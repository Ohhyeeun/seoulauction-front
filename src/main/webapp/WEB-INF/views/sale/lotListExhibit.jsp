<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<link href="/css/angular/rzslider.css" rel="stylesheet">
<link href="/resources/css/angular/ngDialog.css" rel="stylesheet">
<link href="/resources/css/angular/popup.css" rel="stylesheet">
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script type="text/javascript" src="/js/angular/rzslider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>

<style type="text/css"> 
p.flip
{
cursor:pointer;
line-height: 30px;
margin:auto;
font-size:16px;
padding:5px;
text-align:center;
background:#a2a2a2;
border:solid 1px #a2a2a2;
color:#ffffff;
user-select:none;
margin-top:-30px;
}

div.panel
{
line-height: 30px;
margin:auto;
font-size:12px;
padding:5px;
text-align:left;
background:#f4f4f4;
border:solid 1px #a2a2a2;
color:#000;
user-select:none;
height:auto;
display:none;
}
</style>

<link href="/css/jquery.nouislider.css" rel="stylesheet">
<script src="/js/jquery.nouislider.all.js"></script>

<script>
var page= 1;
if (location.hash != "" && location.hash  != undefined ) {
	try {
		
		page = parseInt(location.hash.slice(5));
		if (isNaN(page)) {
			page = 1; 
		}
	 
	} catch(ex) {
		page = 1 ;
	}
	
} 
$(window).on('hashchange', function() {
	var pageValue = parseInt(location.hash.slice(5)); 
	if (isNaN(pageValue)) {
		pageValue = 1; 
	 }
	 
	if (page != pageValue) {
		page = pageValue;
		angular.element(document.getElementById('container')).scope().loadLotList(pageValue);
 
	}

});

function checkMobile(){
    var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
    if ( varUA.indexOf('android') > -1) {
        //안드로이드
        return "android";
    } else if ( varUA.indexOf("iphone") > -1||varUA.indexOf("ipad") > -1||varUA.indexOf("ipod") > -1 ) {
        //IOS
        return "ios";
    } else {
        //아이폰, 안드로이드 외
        return "other";
    }
}

var filter = "win16|win32|win64|mac";
if(navigator.platform){
	if(0 > filter.indexOf(navigator.platform.toLowerCase())&& checkMobile() != 'android'){//Mobile
		history.scrollRestoration = "auto" //모바일일때 이전 스크롤 위치 기억O
	}else{//PC
		history.scrollRestoration = "manual" //pc일때 이전 스크롤 위치 기억X
	}
}

$(window).on('beforeunload', function(event){
    scope = angular.element(document.getElementById("container")).scope();
    /* 현재 스크롤 위치 기억 */
	var offset = $(window).scrollTop(); 
    offset = offset > 1 ? offset : document.querySelector('body').scrollTop; 
    sessionStorage.setItem("scroll_loc", offset); // 세션에 현재 스크롤 위치 저장 
});

$(window).on('popstate', function(event) {
    /*if(event.state == null) return;
    console.log("====================-=-=-=-=-");
	console.log(window.history.length);
    scope = angular.element(document.getElementById("container")).scope();
    scope.reqRowCnt = event.state.row_cnt
    scope.sortBy = event.state.order;
    scope.popstate = true;
    scope.loadLotList(event.state.page);*/
});
	
app.requires.push.apply(app.requires, ["bw.paging", "ngDialog"]);
app.controller('lotListCtl', function($scope, consts, common, bid, $interval, is_login, locale, $filter) {
	$scope.popstate = false;
	$scope.viewType = "${VIEW_TYPE}";
	$scope.is_login = is_login;
	$scope.locale = locale;
	$scope.pageRows = 20;//consts.LOT_LIST_ROWS;
	$scope.reqRowCnt = "20";
	$scope.currentPage = page;
	$scope.totalCount = 0;
	$scope.viewId = "${VIEW_ID}";
	$scope.db_now = null;
	$scope.sale_no = null;
	$scope.sale_status = "READY";
	$scope.sale_kind_cd = "${SALE_KIND_CD}";
	$scope.lot_map = {};
	$scope.is_error = false;
	$scope.now_timer_start = false;
	$scope.list_timer_start = false;
	$scope.modal = null;
	$scope.expe_from_price = null;
	$scope.expe_to_price = null;
	/* YBK.20170314.카테고리 변수 추가 */
	$scope.cate_list = null;
	$scope.scate_list = null;
	$scope.mate_list = null;
	$scope.artist_list = null;
	$scope.fav_cds_list = null;
	/* YBK.20170314.카테고리 변수 추가 */
	$scope.hashtag_list = null; 
	
	$scope.selected_cate = 'all'; //카테고리 font color 작업  
	
	$scope.reqRowCnts1 = {20:"<spring:message code='label.listup.lots' arguments='20' />",
						50:"<spring:message code='label.listup.lots' arguments='50' />",
						100:"<spring:message code='label.listup.lots' arguments='100' />"};
	$scope.reqRowCnts2 = {20:"<spring:message code='label.listup.lots' arguments='20' />",
			40:"<spring:message code='label.listup.lots' arguments='40' />",
			80:"<spring:message code='label.listup.lots' arguments='80' />"};

	$scope.reqRowCnts = $scope.viewType == "LIST" ? $scope.reqRowCnts1 :  $scope.reqRowCnts2;
	
	
	$scope.sortBy = "LOTAS";
	$scope.orders1={"LOTAS": "<spring:message code='label.sort.by.LOTAS' />",
	                "LOTDE": "<spring:message code='label.sort.by.LOTDE' />",
	                "ESTAS": "<spring:message code='label.sort.by.ESTAS' />",
	                "ESTDE": "<spring:message code='label.sort.by.ESTDE' />"};
	$scope.orders2={"ENDAS": "<spring:message code='label.sort.by.ENDAS' />",
	                "BIPAS": "<spring:message code='label.sort.by.BIPAS' />",
	                "BIPDE": "<spring:message code='label.sort.by.BIPDE' />",
	                "BICAS": "<spring:message code='label.sort.by.BICAS' />",
	                "BICDE": "<spring:message code='label.sort.by.BICDE' />"};
 	$scope.init = function(){
 		$("body, html").stop().animate({scrollTop : 0}, 0);  
 		<c:choose>
	 		<c:when test="${VIEW_ID == 'CURRENT_EXHIBIT'}">   
 				$scope.sale_status = "ING";      
	 			$scope.loadSaleMenuList();  
	 		</c:when> 
 			<c:when test="${VIEW_ID == 'RESULT_LOT_LIST'}">
 		 	    $scope.sale_no = "${SALE_NO}";
	 	    	$scope.sale_status = "END";
	 	    	
	 	    	var useCookiePage = (getCookie("prev_url").indexOf("lotDetail") > -1 || getCookie("prev_url").indexOf("lotList") > -1);
	 	    	useCookiePage = useCookiePage && (page != undefined && getCookie('sale_no') != undefined && $scope.sale_no == getCookie('sale_no'));

	 	    	$scope.loadLotList((useCookiePage ? page : 1));
	 		</c:when>
		</c:choose>
		
		var kindCategory = (getParameter("kind"));
 		
 		if( kindCategory == "con" ){
 			$scope.cate_list=['contemporary'];
 			$scope.selected_cate = 'contemporary';
 		} else if( kindCategory == "trad" ) {
 			$scope.cate_list=['traditional'];
 			$scope.selected_cate = 'traditional';
 		} else {
 			$scope.cate_list = null;
 		} 

 	}

 	$scope.loadSaleMenuList = function(){
 		$d = {"baseParms":{},
 				"actionList":[
 				{"actionID":"sale_list_paging", "actionType":"select" , "tableName": "SALES", "parmsList":[{"sale_kind_cd":$scope.sale_kind_cd, "status":$scope.sale_status, "sort_by":"DATAS", "from":0, "rows":3}]}
 			 ]};
 		
 	   	common.callActionSet($d, function(data, status) {
 	 	    $scope.saleMenuList = data["tables"]["SALES"]["rows"];

 	 	    if($scope.saleMenuList.length == 0){
 	 	    	if($scope.locale == 'ko')
 	 	    	{
 	 	    		alert("현재 준비중입니다.");	
 	 	    	}else{
 	 	    		alert("It is currently being prepared.");
 	 	    	}
 	 			window.history.back();
 	 	    }else{
 	 	 	    $scope.sale_no = ("${SALE_NO}" == "" ? $scope.saleMenuList[0]["SALE_NO"] : "${SALE_NO}");

	 	    	var useCookiePage = (getCookie("prev_url").indexOf("lotDetail") > -1 || getCookie("prev_url").indexOf("lotList") > -1);
	 	    	useCookiePage = useCookiePage && (page != undefined && getCookie('sale_no') != undefined && $scope.sale_no == getCookie('sale_no'));

	 	    	$scope.loadLotList((useCookiePage ? page : 1));
 	 	    }
 		});
	}
 	
 	$scope.cnt = 0;
 	$scope.duration_end_start = false;
 	$scope.getDurationTime = function(toDT, f){
 		if(!f) f = (locale == 'ko' ? 'd일 h시간 m분 s초' : 'd[Days] h[Hours] m[Minutes] s[Seconds]');
    	var s = moment(toDT).diff(moment($scope.db_now), 'seconds');
    	if(s > 0){
        	var d = moment.duration(s, "seconds").format(f);
        	return d;
    	}
    	else if (s == 0){
    		$scope.duraionEnd();
    	}
    	if(locale == 'ko'){return "종료중...";
    	} else {
    		return "Now Closing...";
    	}
    }
 	
 	//시간 보정으로 인한 중복 실행 방지
 	$scope.duraionEnd = function(){
 		if($scope.duration_end_start) return;
		$scope.duration_end_start = true;
		$interval($scope.refreshLots, 1000, 1);
 	}
 	
 	$scope.initTimer = function(){
		$scope.cancelLotRefresh();
		$interval.cancel($scope.timer_duration);
		$scope.now_timer_start = false;
		$scope.lot_nos = null;
		$scope.is_reflash_proc = false;
		$scope.duration_end_start =false;
 	}
 	
 	$scope.initSerachFilter = function(){
 		$scope.expe_from_price = null;
 		$scope.expe_to_price = null;
// 		$scope.setExpeSlide($scope.sale.CURR_CD);
 		$scope.s_expe_currency = $scope.sale.CURR_CD;
 		$scope.artistName = null;
 		$scope.worksTitle = null;
 		$scope.lot_no = null;
 		
 		// YBK.20170315.카테고리 초기화
		$scope.cate_selected = [];
		$scope.cate_list = null;
		$scope.scate_selected = [];
		$scope.scate_list = null;
		$scope.mate_selected = [];
		$scope.mate_list = null;
		$scope.art_selected = [];
		$scope.art_list = null;
		$scope.hashtag_selected = [];
		$scope.hashtag_list = null;  
		$scope.loadLotList(1);
		$scope.fav_selected = []; 
		$scope.fav_cds_list = null;   
 	}
 	
 	$scope.loadLotList = function($page){
 		
 		window.location.hash = '#page' + $page;
 		setCookie('sale_no', $scope.sale_no, 1);
 		//setCookie('page', $page, 1);
 		
		if($scope.sale_status == "ING") $scope.initTimer();

 		$scope.currentPage = $page;
 		
 		if($scope.expe_from_price != null){
 	 		$scope.expe_from_price = parseInt(slide_expe_start);
 		}
 		if($scope.expe_to_price != null){
 	 		$scope.expe_to_price = parseInt(slide_expe_end);
 		}

	
 		$d = {"baseParms":{
 				"sale_no":$scope.sale_no, "artist_name":$scope.artistName, "works_title":$scope.worksTitle, "lot_no":$scope.lot_no
 					, "s_expe_currency" : $scope.s_expe_currency, "expe_from_price" : $scope.expe_from_price, "expe_to_price": $scope.expe_to_price
 					, "cate_cds" : $scope.cate_list, "scate_cds" : $scope.scate_list, "mate_cds" : $scope.mate_list, "artist_nos" : $scope.art_list, "hashtag_list" : $scope.hashtag_list, "fav_cds_list" : $scope.fav_cds_list, 
 				}, 
 				"actionList":[
 				{"actionID":"sale_info", "actionType":"select" , "tableName": "SALE"},
 				{"actionID":"exch_rate_list", "actionType":"select" , "tableName": "EXCH"},
 				{"actionID":"lot_list_count", "actionType":"select" , "tableName": "LOT_CNT" ,"parmsList":[{"for_count":true}]},
 			    {"actionID":"lot_list_paging", "actionType":"select" , "tableName": "LOTS" ,"parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt), "sort_by":$scope.sortBy}]},
  				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
  				/* YBK.20170314.카테고리 추가 */
  				{"actionID":"saleLot_category", "actionType":"select", "tableName":"CATEGORY"},
  				{"actionID":"saleLot_subcategory", "actionType":"select", "tableName":"SUBCATEGORY"},
  				{"actionID":"saleLot_material", "actionType":"select", "tableName":"MATERIAL"},
  				{"actionID":"saleLot_artist", "actionType":"select", "tableName":"ARTIST"}, 
  				{"actionID":"saleLot_hashtag", "actionType":"select", "tableName":"HASHTAG"}, 
  				/* YBK.20170314.카테고리 추가 */
 			 ]};

 		
 		if(is_login == "true"){
	 		/* blueerr 20180810 회차 휴대폰 인증 정보 */
			$d.actionList.push({"actionID":"sale_cert_info", "actionType":"select", "tableName":"CERT"});
			/* blueerr 20180810 회차 휴대폰 인증 정보 */
 		}
 		
 	   	$d["actionList"][3]["parmsList"][0]["from"] = (($scope.currentPage - 1) * parseInt($scope.reqRowCnt)); 
 	   	common.callActionSet($d, function(data, status) { 
 	 		$scope.sale = data["tables"]["SALE"]["rows"][0];
 	 		$scope.db_now = $scope.sale.DB_NOW;
 	 		$scope.exchRateList = data["tables"]["EXCH"]["rows"];
 	 		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
 	 		/* YBK.20170314.카테고리 추가 */
 	 		$scope.category = data["tables"]["CATEGORY"]["rows"];
 	 		$scope.subcategory = data["tables"]["SUBCATEGORY"]["rows"];
 	 		$scope.material = data["tables"]["MATERIAL"]["rows"];
 	 		$scope.artist = data["tables"]["ARTIST"]["rows"];
 	 		/* YBK.20170314.카테고리 추가 */
 	 		$scope.hashtag = data["tables"]["HASHTAG"]["rows"];  
 	 		
// 	 		if($scope.expe_from_price == null && $scope.expe_to_price == null){
// 	 	 		$scope.setExpeSlide($scope.sale.CURR_CD);
// 	 	 		$scope.expe_from_price = parseInt(slide_expe_start);
// 	 	 		$scope.expe_to_price = parseInt(slide_expe_end);
// 	 	 		$scope.s_expe_currency = $scope.sale.CURR_CD;
// 	 		} 
 	 		
 	 		var S_DB_NOW = $filter('date')($scope.db_now, 'yyyyMMddHHmm');
 	 		var S_DB_NOW_D = $filter('date')($scope.db_now, 'yyyyMMdd');
 	 		var FROM_DT = $filter('date')($scope.sale.FROM_DT, 'yyyyMMdd');
 	 		var TO_DT = $filter('date')($scope.sale.TO_DT, 'yyyyMMdd');
 	 		var END_DT = $filter('date')($scope.sale.END_DT, 'yyyyMMddHHmm');
 	 		// 오프라인 경매인 경우에는 SALE.TO_DT는 YYYY.MM.DD로 체크. 비교 서버시간은 S_DB_NOW_D (YDH. 2016.10.05)
 	 		// 온라인 경매인 경우에는 MAX(LOT.TO_DT) 기준으로 시분까지 체크. 비교 서버시간은 S_DB_NOW (YDH. 2016.10.05)
 	 		if(FROM_DT > S_DB_NOW && 
 	 				(($scope.sale.SALE_KIND_CD != 'online' && TO_DT > S_DB_NOW_D)
 	 				|| ($scope.sale.SALE_KIND_CD == 'online' && END_DT > S_DB_NOW))
 	 			){
 	 			$scope.sale_status = "READY";
 	 		}
 	 		else if(FROM_DT <= S_DB_NOW && 
					(($scope.sale.SALE_KIND_CD != 'online' && $scope.sale.CLOSE_YN != 'Y')
 	 				|| ($scope.sale.SALE_KIND_CD == 'online' && END_DT >= S_DB_NOW))
				){
 	 			$scope.sale_status = "ING";
 	 			if(!$scope.now_timer_start){
 	 				console.log("duration timer start!!");
 	 	 	 		$scope.timer_duration = $interval(function(){$scope.db_now = moment($scope.db_now).add(1, 'seconds');}, 1000);
 	 	 	 		$scope.now_timer_start = true;
 	 			} 
 	 		}
 	 		else if(($scope.sale.SALE_KIND_CD != 'online' && $scope.sale.CLOSE_YN == 'Y')
 				|| ($scope.sale.SALE_KIND_CD == 'online' && END_DT < S_DB_NOW)){
 	 			$scope.sale_status = "END";
 	 		}
 	 		
 	 		$scope.totalCount = data["tables"]["LOT_CNT"]["rows"][0]["CNT"];

 	 		//$scope.setJsonObj(data["tables"]["LOTS"]["rows"], ["LOT_SIZE", "ARTIST_NAME", "TITLE", "STITLE", "MAKE_YEAR"]);
 	 		
 	 	    $scope.lotList = data["tables"]["LOTS"]["rows"];
 	 	    $scope.curr_lot_no = $scope.lotList[0].CURR_LOT_NO;
 	 	   
 	 	    //$scope.base_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKD" : "KRW");
 	 	    $scope.base_currency = $scope.sale.CURR_CD;
 	 	    $scope.base_timezone = ($scope.sale.CURR_CD == 'HKD' ? "HKT" : "KST");//$scope.base_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKT" : "KST");
 	 	    
 	 		//$scope.sub_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KRW" : "HKD");
 	 		$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
 	 		$scope.sub_timezone = ($scope.sale.CURR_CD == 'KRW' ? "KST" : "HKT");//$scope.sub_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KST" : "HKT");
 	 		
 	 		$scope.orders = ($scope.sale.SALE_KIND_CD == 'online' && is_login) ? $.extend($scope.orders1, $scope.orders2) : $scope.orders1;
 	 		
 	 		$scope.pageRows = parseInt($scope.reqRowCnt);
 	 		
 	 		if($scope.sale_status == "ING" && $scope.sale.SALE_KIND_CD == 'online' && data.tables.CERT){
 	 	 		var isSaleCertCancel = (getCookie('sale_cert_cancel') || false);
 	 	 		$scope.sale_cert = data["tables"]["CERT"]["rows"][0];
 	 			if(!isSaleCertCancel) bid.saleCertCheck({'parent':$scope, 'sale':$scope.sale});
 	 		}
 	 		/*if(!$scope.popstate){
 	 			$scope.historyData = {"page" : $scope.currentPage, "row_cnt" : $scope.reqRowCnt, "order" : $scope.sortBy};
 	 	 		history.pushState($scope.historyData,  document.title, document.location.href);
 	 		}
 	 		else{
 	 	 		$scope.popstate = false;
 	 		}*/
 	 		
 		}, function(){
 			$scope.is_error = true;
 		}, finalRefresh);
	}
 	
 	$scope.is_reflash_proc = false;
 	$scope.lot_nos = null;
 	$scope.refreshLots = function(){
 		if($scope.is_reflash_proc) return;
 		
 		$scope.is_reflash_proc = true;
 		 		
 		if($scope.lot_nos == null){
 			$scope.lot_nos = Object.keys($scope.lot_map); 
 		}

 		if($scope.sale.SALE_KIND_CD == 'online' && $scope.lot_nos.length == 0){  //수정전(2017.03.30) if($scope.lot_nos.length == 0){ 
			console.log("refreshLots end");
			// 종료시 프로세스 초기화
			$scope.initTimer();
			return;
 		}

 		$d = {"actionList":[
 			    {"actionID":"lot_list_refresh", "actionType":"select" , "tableName": "LOTS" ,"parmsList":[{"sale_no":$scope.sale_no, "lot_nos": $scope.lot_nos}]}
 		 ]};
 		
 		common.callActionSet($d, function(data, status) { 
 	 		var $d = data["tables"]["LOTS"]["rows"];
 			var lot = null;
 			
 			// 데이터가 0 이면 모든 타이머 종료

 	       	$scope.lot_nos = [];
 	        for(var i = 0; i < $d.length; i++){
 	            lot = $scope.lot_map[$d[i]["LOT_NO"]];
 	            
 	            if(lot != null) {
 	            	lot["STAT_CD"] = $d[i]["STAT_CD"];
 	            	lot["TO_DT"] = $d[i]["TO_DT"];
 	            	lot["LAST_PRICE"] = $d[i]["LAST_PRICE"];
 	            	lot["END_YN"] = $d[i]["END_YN"];
 	            	lot["BID_CNT"] = $d[i]["BID_CNT"];
 	            	lot["IS_WIN"] = $d[i]["IS_WIN"];
 	            	lot["MY_BID_CNT"] = $d[i]["MY_BID_CNT"];
 	            	lot["LAST_CUST_ID"] = $d[i]["LAST_CUST_ID"];
 	            	lot["MY_BID_SALE_CNT"] = $d[i]["MY_BID_SALE_CNT"];
 	            	lot["MY_BID_AUTO_CNT"] = $d[i]["MY_BID_AUTO_CNT"];
 	            	lot["CURR_LOT_NO"] = $d[i]["CURR_LOT_NO"];
 	            	$scope.curr_lot_no = $d[i]["CURR_LOT_NO"];
 	            	
 	            	$scope.db_now = moment($d[i]["DB_NOW"]);
 	            	
 	            	if($d[i]["END_YN"] == 'N'){
 	            		$scope.lot_nos.push($d[i]["LOT_NO"]);
 	            	}
 	            }
 	        }
 	        
 		}, function(){
 			$scope.cancelLotRefresh();
 		}, function(){
 		 	$scope.is_reflash_proc = false;
 		 	if($scope.duration_end_start) $scope.duration_end_start =false;
 		});
	}

	$scope.runLotsRefresh = function(){
	 	if($scope.list_timer_start) return;
	 	//오프라인 경매 1시간단위로 refresh
	 	if($scope.sale.SALE_KIND_CD != 'online' && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){
			console.log("========= offline runLotsRefresh start");
 	 		//if(!$scope.modal) 
 	  		$scope.timer_lots_refresh = $interval($scope.refreshLots, 60000);//, 1);
 	  		$scope.list_timer_start = true;
 		}
	 	//온라인 경매는 5초단위로 refresh
 		if($scope.sale.SALE_KIND_CD == 'online' && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){
			console.log("========= runLotsRefresh start");
 	 		//if(!$scope.modal) 
 	  		$scope.timer_lots_refresh = $interval($scope.refreshLots, 5000);//, 1);
 	  		$scope.list_timer_start = true;
 		}
	}
	
	$scope.cancelLotRefresh = function(){
		$interval.cancel($scope.timer_lots_refresh);
		$scope.list_timer_start = false;
		console.log("========= list reflash cancel");
	}

	var finalRefresh = function(){ 
		if($scope.is_error){
			alert("에러가 발생하며 자동 변경을 종료 합니다.");
			//$interval.cancel($scope.refreshLots);
 	  		//$scope.list_timer_start = false;
			$scope.cancelLotRefresh();
		}
		else{
			$scope.runLotsRefresh(); 
		}
	}
	
	$scope.hashtag_selected = [];
	$scope.hashtag_toggle = function(item, list) { 
		var idx = list.indexOf(item);
		if(idx > -1) {
			list.splice(idx, 1);
		}else {
			$scope.hashtag_selected = [];
			$scope.cate_selected = [];
			list.push(item);
		}
		$scope.cate_list = null;
		$scope.hashtag_list = null;
		$scope.hashtag_list = list;
		if($scope.hashtag_list == null || $scope.hashtag_list == "undefined" || $scope.hashtag_list.length < 1) {
			$scope.hashtag_list = null;
		}
		
		$scope.selected_cate = item;
		
		$scope.loadLotList(1);
	}; 
	
	$scope.fav_selected = [];
	$scope.fav_toggle = function(item, list) {

		$scope.cate_list = null;
		$scope.hashtag_list = null;		
		$scope.fav_cds_list = null;
		$scope.fav_cds_list = 1;
		
		if($scope.fav_cds_list == null || $scope.fav_cds_list == "undefined" || $scope.fav_cds_list.length < 1) {
			$scope.fav_cds_list = null;
		}
		$scope.loadLotList(1);
	};

	$scope.showBidPopup = bid.showBidPopup;
	$scope.showBidRequestPopup = bid.showBidRequestPopup;
	$scope.showBidHistoryPopup = bid.showBidHistoryPopup;
	
//	$scope.setExpeSlide = function(currency) {
// 		setUiSlider($scope.sale["MIN_" + currency + "_EXPE_PRICE"], $scope.sale["MAX_" + currency+ "_EXPE_PRICE"]
// 			, $scope.sale["MIN_" + currency + "_EXPE_PRICE"], $scope.sale["MAX_" + currency+ "_EXPE_PRICE"]);
//	}

	
	$scope.searchList = function(){
		$scope.fav_toggle(false);
		$scope.loadLotList(1);
	}
	
	/* YBK.20170314.카테고리 추가 */
	// 메인카테고리 사이드바 구성
	$scope.cate_selected = [];
	$scope.cate_toggle = function(item, list) {
		var idx = list.indexOf(item);
		if(idx > -1) {
			list.splice(idx, 1);
		}else {
			$scope.cate_selected = [];
			$scope.hashtag_selected = []; 
			list.push(item);
		}
		$scope.cate_list = null;
		$scope.hashtag_list = null;  
		$scope.fav_cds_list = null; 
		$scope.cate_list = list;
		if($scope.cate_list == null || $scope.cate_list == "undefined" || $scope.cate_list.length < 1) {
			$scope.cate_list = null;
		}
		
		$(".list-category-b").each(function(i, data) {
			$(this).removeClass("list-active");//.addClass("list-category-a");
		}); 
		$scope.selected_cate = item;
		 
		
		$scope.loadLotList(1);
	};
	
	$scope.cate_exists = function(item, list) {
		return list.indexOf(item) > -1;
	};
	
	$scope.checkCateAll = function() {
		$scope.cate_selected = [];
		$scope.cate_list = null; 
		$scope.hashtag_selected = [];
		$scope.hashtag_list = null;		
		$scope.loadLotList(1);
		$scope.fav_selected = [];
		$scope.fav_cds_list = null;    
		$scope.selected_cate = 'all';  
	}
	
	// 서브카테고리 체크 사이드바 구성
	$scope.scate_selected = [];
	
	$scope.scate_toggle = function(item, list) {
		var idx = list.indexOf(item);
		if(idx > -1) {
			list.splice(idx, 1);
		}else {
			list.push(item);
		}
		
		$scope.scate_list = list;
		if($scope.scate_list == null || $scope.scate_list == "undefined" || $scope.scate_list.length < 1) {
			$scope.scate_list = null;
		}
		$scope.loadLotList(1);
	};
	
	$scope.scate_exists = function(item, list) {
		return list.indexOf(item) > -1; 
	};
	
	$scope.checkScateAll = function() {
		$scope.cate_selected = [];
		$scope.cate_list = null;
		$scope.hashtag_selected = [];
		$scope.hashtag_list = null; 
		$scope.scate_selected = [];
		$scope.scate_list = null;  
		$scope.loadLotList(1);
	}
	
	// 재질 체크 사이드바 구성
	$scope.mate_selected = [];
	
	$scope.mate_toggle = function(item, list) {
		var idx = list.indexOf(item);
		if(idx > -1) {
			list.splice(idx, 1);
		}else {
			list.push(item);
		}
		
		$scope.mate_list = list;
		if($scope.mate_list == null || $scope.mate_list == "undefined" || $scope.mate_list.length < 1) {
			$scope.mate_list = null;
		}
		$scope.loadLotList(1);
	};
	
	$scope.mate_exists = function(item, list) {
		return list.indexOf(item) > -1;
	};
	
	$scope.checkMateAll = function() {
		$scope.mate_selected = [];
		$scope.mate_list = null;
		$scope.loadLotList(1);
	}
	
	// 작가 체크 사이드바 구성
	$scope.art_selected = [];
	
	$scope.art_toggle = function(item, list) {
		var idx = list.indexOf(item);
		if(idx > -1) {
			list.splice(idx, 1);
		}else {
			list.push(item);
		}
		
		$scope.art_list = list;
		if($scope.art_list == null || $scope.art_list == "undefined" || $scope.art_list.length < 1) {
			$scope.art_list = null;
		}
		$scope.loadLotList(1);
	};
	
	$scope.art_exists = function(item, list) {
		return list.indexOf(item) > -1;
	};
	
	$scope.checkArtistAll = function() {
		$scope.art_selected = [];
		$scope.art_list = null;
		$scope.loadLotList(1);
	}
	
	// 전체 선택 해제
	$scope.checkAcateAll = function() {
		$scope.cate_selected = [];
		$scope.cate_list = null;
		$scope.scate_selected = [];
		$scope.scate_list = null;
		$scope.mate_selected = [];
		$scope.mate_list = null;
		$scope.art_selected = [];
		$scope.art_list = null;
		
		$scope.loadLotList(1);
		
		// filterLotListL.jsp 검색초기화
 		$scope.expe_from_price = null;
 		$scope.expe_to_price = null;
// 		$scope.setExpeSlide($scope.sale.CURR_CD);
 		$scope.s_expe_currency = $scope.sale.CURR_CD;
 		$scope.artistName = null;
 		$scope.worksTitle = null;
 		$scope.lot_no = null;
	}
	/* YBK.20170314.카테고리 추가 */
	
	/* 컨디션리포트/관심작품 신청, 삭제 SRC START (2017.08.11 YDH) */
	/* YBK.컨디션리포트추가 */
	$scope.showConditionReportPopup = bid.showConditionReportPopup;
	/* YBK.컨디션리포트추가 */
	
	/* 관심작품 Start */
	// 관심작품 로직 추가(2018.08.14 YDH)
	$scope.inteSave = function($input) {		
		var $d = {"baseParms":{"sale_no":$input.sale_no, "lot_no":$input.lot_no}, 
				"actionList":[
				{"actionID":"add_cust_inte_lot", "actionType":"insert", "tableName":"CUST_INTE_LOT", "parmsList":[{}]}
				]};
		common.callActionSet($d, function(data, status) {
			if(data.tables["CUST_INTE_LOT"]["rows"].length > 0) {
				if($scope.locale == 'ko') {
					alert("관심작품 추가가 완료되었습니다.\n추가된 관심작품은 ACCOUNT페이지에서 확인하실 수 있습니다.");
					window.location.reload(true);
				}else {
					alert("A favorate work has been added.\nYou can find your favorite works on your account page.");
					window.location.reload(true);
				}
				return true;
			}
		})
		
	}
	
	$scope.inteDel = function($input) {	
		var $d = {"baseParms":{"sale_no":$input.sale_no, "lot_no":$input.lot_no}, 
				"actionList":[
				{"actionID":"del_cust_inte_lot", "actionType":"delete", "tableName":"CUST_INTE_LOT", "parmsList":[{}]}
				]};
		common.callActionSet($d, function(data, status) {
			if(data.tables["CUST_INTE_LOT"]["rows"].length > 0) {
				if($scope.locale == 'ko') {
					alert("관심작품이 삭제되었습니다.");
					window.location.reload(true);
				}else {
					alert("A favorate work has been deleted.");
					window.location.reload(true);
				}
				return true;
			}
		})	
	}
	/* 관심작품 End */
	/* 컨디션리포트/관심작품 신청, 삭제 SRC END (2017.08.11 YDH) */
	
	//lot출력완료 후 이전 위치로 스크롤 이동
	$scope.$on('ngRepeatFinished', function (ngRepeatEndEvent) { 
 		var scroll_loc = sessionStorage.getItem("scroll_loc");
  		//$(window).scrollTop(scroll_loc); //IE지원 X
 		$("body, html").stop().animate({scrollTop : scroll_loc}, 0);
 		sessionStorage.removeItem("scroll_loc");
	});
});
</script>
<script type="text/javascript" src="/resources/js/bid.js?${resources.timestamp}"></script>
<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap"> 
		<div id="container" ng-controller="lotListCtl" data-ng-init="init();">
			<div class="sub_menu_wrap menu01">
				<div class="sub_menu">
					<jsp:include page="../include/exhibitionsubMenu.jsp" flush="false"/>
				</div>
			</div> 
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">  
            <!-- 모바일용 -->
				<div class="m_only m_location">
					<div class="hidden_box">
						<ul> 
							<li>
								<div class="m_ex_title">    
									<div class="title"> 
										<div class="tit lotlist_memobox">  
											<!--<span ng-bind="sale.SALE_TH | localeOrdinal"></span>
											<br />-->  
											<span style="padding:0 15px;" ng-bind="sale.TITLE_JSON[locale]"></span>
										</div>
										<div class="sub lotlist_memobox">  
                                            <%-- 홍콩인 경우 시간 순서 변경 --%>
                                            <!-- <p ng-if="locale != 'ko'" style="font-weight:600;">
                                                <span style="font-weight:600;">DATE : </span>
                                                <span ng-bind="(sale.FROM_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'(EEE) d MMM, yyyy' : 'UTC+9' | lowercase)"></span>
                                                - <span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'(EEE) d MMM, yyyy' : 'UTC+9' | lowercase)"></span>
                                            </p> 
                                            <p ng-if="locale == 'ko'" style="font-weight:600;">
                                                <span style="font-weight:600;">DATE : </span>
                                                <span ng-bind="(sale.FROM_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d' : 'UTC+9' | lowercase)+'('+getWeek(sale.FROM_DT)+')'"></span>
                                                - <span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d(EEE)' : 'UTC+9' | lowercase)+'('+getWeek(sale.TO_DT)+')'"></span>
                                            </p> -->           
                                            
                                            <!-- <p>
                                            	<span ng-bind="sale.PLACE_JSON[locale]"></span>
                                            </p>  --><!-- 2021.02.10 YDH 주석처리. 디테일페이지에서 해당 컬럼 사용! -->
                                            <p>     
                                            	<!-- <span ng-if="sale.SALE_KIND_CD == 'exhibit' && viewId == 'CURRENT_EXHIBIT'"></span> (임시주석)-->
												<span ng-bind-html="sale.NOTICE_JSON[locale]"></span> 
                                            	<!-- </span> (임시주석)-->
                                            </p>   
                                            
                                            <div style="margin-top: 10px;">
                                            	<!-- 전시 공지사항 (임시) -->
	                                            <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_EXHIBIT' && sale.SALE_NO == '673'">
	                                                <button type="button" ng-if="viewId == 'CURRENT_EXHIBIT' && sale.SALE_NO == '673'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=5175')"; >NOTICE</button>    
	                                            </span>  
	                                            <!-- 블랙랏 -->   
		                                        <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '673'">     
		                                            <button type="button" name="Blacklot" value="Blacklot" align="center" scrolling="no" onClick="window.open('https://www.blacklot.com')">BLACKLOT</button>   
		                                        </span>
                                            	<%-- <span class="btn_style01 dark" ng-if="sale.SALE_NO == '485'"> 
                                                	<button type="button" name="SA+" value="SA+" align="center" scrolling="no" onClick="window.open('/about/page?view=saplus')"; >SA+ EXHIBITION</button>
	                                            </span>
	                                           	<span class="btn_style01 dark" ng-if="sale.SALE_NO == '480'">
													<button type="button" name="Gangnam" value="Gangnam" align="center" scrolling="no" onClick="window.open('/about/page?view=gnExhibition')"; >Gangnam Center</button> 
	                                            </span> 
	                                           	<span class="btn_style01 orange01" ng-if="sale.SALE_NO == '485'">
	                                                <button type="button" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_online2')"; >EXHIBITION-VR</button>
	                                            </span>
	                                            <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '480'">
	                                                <button type="button" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_ex')"; >EXHIBITION-VR</button>
	                                            </span>
	                                            <!-- 로얄샬루트 -->  
		                                        <span class="btn_style01 green" ng-if="sale.SALE_NO == '617'">    
		                                            <button type="button" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.royalsaluteart.kr')"; >EVENT</button> 
		                                        </span>  
                                                <!-- 로얄샬루트 Notice -->   
		                                        <span class="btn_style01 dark" ng-if="sale.SALE_NO == '617'">    
		                                            <button type="button" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=3926')"; >NOTICE</button>  
		                                        </span>
                                                <!-- 도록보기 이북 --> 
                                                <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_EXHIBIT' && sale.SALE_NO == '637'"> 
                                                    <button type="button" ng-if="viewId == 'CURRENT_EXHIBIT' && sale.SALE_NO == '637'" name=" CATALOGUE" value=" CATALOGUE" align="center" scrolling="no" onClick="window.open('/nas_img/front/homepage/e-book/mariKim/index.html')"; >CATALOGUE</button>    
                                                </span> --%> 
                                            </div>
                                        </div>
									</div>
								</div>
							</li> 
						</ul>
					</div>
				</div>
                
                 
				<!-- 웹용 -->
				<div class="contents">
					<!--<button ng-if="viewId == 'CURRENT_EXHIBIT'" class="sp_btn btn_up">
						<span class="hidden"><spring:message code="label.move.top" /></span>
					</button>-->
					<div class="ex_title type02" ng-if="viewId != 'SEARCH'">
						<div class="title">
							<div class="tit"> 
								<!--<span class="num" ng-bind="sale.SALE_TH | localeOrdinal"></span>-->
								<span ng-bind="sale.TITLE_JSON[locale]"></span>								
							</div>
							<div class="sub lotlist_memobox">
                                <%-- 홍콩인 경우 시간 순서 변경 --%>
                                <!-- <p ng-if="locale != 'ko'" style="font-weight:600;"> 
                                	<span style="font-weight:600;">DATE : </span>
                                	<span ng-bind="(sale.FROM_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'(EEE) d MMM, yyyy' : 'UTC+9' | lowercase)"></span>
                                    - <span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'(EEE) d MMM, yyyy' : 'UTC+9' | lowercase)"></span>
                                </p> 
                                <p ng-if="locale == 'ko'" style="font-weight:600;">
                                	<span style="font-weight:600;">DATE : </span>
                                	<span ng-bind="(sale.FROM_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d' : 'UTC+9' | lowercase)+'('+getWeek(sale.FROM_DT)+')'"></span>
                                    - <span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d' : 'UTC+9' | lowercase)+'('+getWeek(sale.TO_DT)+')'"></span>
                                </p> -->      
                                
                                <!-- <p ng-if="viewId == 'CURRENT_EXHIBIT' && sale.SALE_KIND_CD == 'exhibit'" style="font-weight:600;">VENUE : </p> 
                                <p ng-bind="sale.PLACE_JSON[locale]" style="font-weight:600;"></p>  --><!-- 2021.02.10 YDH 주석처리. 디테일페이지에서 해당 컬럼 사용! -->
                               
                                <p>     
                                    <!--<span ng-if="sale.SALE_KIND_CD == 'exhibit'"> <span ng-bind-html="sale.NOTICE_JSON[locale]"></span> (임시주석)-->
                                        <span ng-bind-html="sale.NOTICE_JSON[locale]" style="font-weight:600;"></span>  
                                    <!--</span> (임시주석) --> 
                                </p>   
                                <dl style="padding-top:15px; padding-bottom:20px;">
                                    <div class="btns">	
                                    	<!-- 전시 공지사항 (임시) -->      
                                        <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_EXHIBIT' && sale.SALE_NO == '673'">  
                                            <button type="button" ng-if="viewId == 'CURRENT_EXHIBIT' && sale.SALE_NO == '673'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=5175')"; >NOTICE</button>    
                                        </span>   
                                        
                                        <!-- 블랙랏 --> 
                                        <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '673'">          
                                            <button type="button" name="Blacklot" value="Blacklot" align="center" scrolling="no" onClick="window.open('https://www.blacklot.com')">BLACKLOT</button>  
                                        </span>    
                                        									 
                                        <%-- <span class="btn_style01 dark" ng-if="sale.SALE_NO == '485'">
											<button type="button" name="SA+" value="SA+" align="center" scrolling="no" onClick="window.open('/about/page?view=saplus')"; >SA+ EXHIBITION</button>
                                        </span>
                                        <span class="btn_style01 dark"  ng-if="sale.SALE_NO == '480'">
											<button type="button" name="Gangnam" value="Gangnam" align="center" scrolling="no" onClick="window.open('/about/page?view=gnExhibition')"; >Gangnam Center</button>
                                        </span> 
                                        <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '485'">
                                            <button type="button" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_online2')"; >EXHIBITION-VR</button>
                                        </span> 
                                         <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '480'">
                                            <button type="button" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_ex')"; >EXHIBITION-VR</button>
                                        </span>
                                        <!-- 로얄샬루트 --> 
                                        <span class="btn_style01 green" ng-if="sale.SALE_NO == '617'">    
                                            <button type="button" name="Royalsaluteart" value="Royalsaluteart" align="center" scrolling="no" onClick="window.open('https://www.royalsaluteart.kr ')"; >EVENT</button>  
                                        </span>    
                                        <!-- 로얄샬루트 Notice -->   
                                        <span class="btn_style01 dark" ng-if="sale.SALE_NO == '617'">    
                                            <button type="button" name="Royalsaluteart" value="Royalsaluteart" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=3926')"; >NOTICE</button>  
                                        </span>  
                                         
                                        
                                        <!-- 도록보기 이북 -->  
                                        <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_EXHIBIT' && sale.SALE_NO == '637'"> 
                                            <button type="button" ng-if="viewId == 'CURRENT_EXHIBIT' && sale.SALE_NO == '637'" name=" CATALOGUE" value=" CATALOGUE" align="center" scrolling="no" onClick="window.open('/nas_img/front/homepage/e-book/mariKim/index.html')"; >CATALOGUE</button>    
                                        </span> --%> 
                                    </div> 
								</dl> 
							</div>  
							
                            <!--<div class="butt">
                                <span class="btn_style01 gray02" ng-if="is_login && sale_status != 'ING' && locale != 'ko'">
									<button type="button" onClick="location.href='/saleLot_Result?sale_no=${SALE_NO}'";>Result List</button>
                               	</span>
                           	</div>-->
						</div>
						 
						<!--오른쪽 more -->
				 		<div class="more web_only" align="center">

						</div>
                    	<!--오른쪽 more --> 
					</div> <!--ex_title type02-->

					<div ng-if="viewId == 'SEARCH'" class="tit_h2">
						<h2><spring:message code="label.search" /></h2>
					</div> 
					<form name="pageForm" method="get">
						<fieldset>
							<legend><spring:message code="label.search" /></legend>
							<%@ include file="./include/filterLotListL.jsp" %>
						</fieldset>
						<!-- <div class="tbl_top web_only mt0 t_tbl_top"> -->
						
						<div class="list-category auction-list-category">        
                            <span ng-click="checkCateAll();" ng-class="{true: 'list-category-a', false: 'list-category-b'}['all' == selected_cate]" ng-if="locale=='ko'"><a href="#" >전체</a> </span>
                            <span ng-click="checkCateAll();" ng-class="{true: 'list-category-a', false: 'list-category-b'}['all' == selected_cate]" ng-if="locale!='ko'"><a href="#" >All</a> </span>
    
    <!--CATEGORY-->			<span ng-repeat="cate in category" class="standard" flex="50"> 
                                    <span ng-if="locale=='ko'" ng-click="cate_toggle(cate.CD_ID, cate_selected)" checklist-model="cate_cds" ng-class="{true: 'list-category-a', false: 'list-category-b'}[cate.CD_ID == selected_cate]"><a href="#" >{{cate.CD_NM}}</a></span>
                                    <span ng-if="locale!='ko'" ng-click="cate_toggle(cate.CD_ID, cate_selected)" checklist-model="cate_cds" ng-class="{true: 'list-category-a', false: 'list-category-b'}[cate.CD_ID == selected_cate]"><a href="#" class="list-category-b">{{cate.CD_NM_EN}}</a></span>  
                            </span>    
                            <span ng-repeat="hashtag in hashtag" class="standard" flex="50">  
                            	<span ng-if="locale=='ko'" ng-click="hashtag_toggle(hashtag.LOT_TAG, hashtag_selected)" checklist-model="hashtag_list"  ng-class="{true: 'list-category-a', false: 'list-category-b'}[hashtag.LOT_TAG == selected_cate]" ><a href="#" >{{hashtag.LOT_TAG}}</a></span> 
                            </span>     
                            
							<div class="wish_btn wish_btn_right">          
								<span ng-if="is_login == 'false'">       
		                           	<span ng-if="locale == 'ko'" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" checklist-model="fav_cds_list" title="관심작품 보기">        
		                            	<span class="grid_wish_btn wish_btn_list">         
			                            </span> 
			                            <span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">     
		                            		관심작품 보기  
		                            	</span>   
		                            </span>      
		                           	<span ng-if="locale != 'ko'" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" checklist-model="fav_cds_list" title="WishList">    
			                            <span class="grid_wish_btn wish_btn_list">   
			                            </span>    
			                            <span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">    
		                            		WishList   
		                            	</span> 
		                            </span> 
		                        </span>
		                             
								<span ng-if="is_login == 'true'">     
		                           	<span ng-if="locale == 'ko'" ng-click="fav_toggle( 1 , fav_selected)" checklist-model="fav_cds_list" title="관심작품 보기">           
		                            	<span class="grid_wish_btn wish_btn_list">   
		                            	</span>        
		                            	<span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">      
		                            		관심작품 보기   
		                            	</span>      
		                           	</span> 
		                           	 
		                           	<span ng-if="locale != 'ko'" ng-click="fav_toggle( 1 , fav_selected)" checklist-model="fav_cds_list" title="WishList">         
		                            	<span class="grid_wish_btn wish_btn_list"> 
		                            	</span> 
		                            	<span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">    
		                            		WishList  
		                            	</span>
		                           	</span>  
		                        </span>      
							</div> 
						</div>  
						
						<div class="tbl_top web_only02 mt0 t_tbl_top"> <!-- m_ver paging 상단으로 변경 -->
							<div class="left">
								<div class="wrap_paging"> 
									<paging page="currentPage"
											page-size="pageRows"
											total="totalCount"
											adjacent="10"
											paging-action="loadLotList(page)"
											scroll-top="true"
											hide-if-empty="true"
											show-prev-next="true"
											show-first-last="true"
											ul-class="page_ul"
											active-class="page_active"
										    disabled-class="page_disable"
										    text-next-class="page_btn sp_btn btn_next02"
										    text-prev-class="page_btn sp_btn btn_prev02"
										    text-first-class="page_btn sp_btn btn_prev"
										    text-last-class="page_btn sp_btn btn_next"
									>
									</paging>
								</div>
							</div>
							<div class="right">
								<div class="view">
									<div class="fl_wrap">
										<!-- <span class="btn_style01 gray03">
											<button ng-if="list_timer_start" ng-click="cancelLotRefresh();"><span>응찰정보자동갱신 중</span></button>
											<button ng-if="!list_timer_start" ng-click="runLotsRefresh();"><span>응찰정보자동갱신</span></button>
										</span> -->
										<span class="tbl_label"><spring:message code="label.total.lots" arguments='{{totalCount}}' /></span>
										<label for="" class="tbl_label bar02"><spring:message code="label.sort.by" /></label>
										<select path="orderType" class="selectbox" ng-model="sortBy">
											<option ng-repeat="(key, value) in orders" value="{{key}}">{{value}}</option>
										</select>
										<select ng-model="reqRowCnt" class="selectbox">
											<option ng-repeat="(key, value) in reqRowCnts" value="{{key}}">{{value}}</option>
										</select>
										<span class="btn_style01 gray03">
											<button type="button" ng-click="loadLotList(1);"><spring:message code="label.query" /></button>
										</span>
									</div>
								</div>
								<div class="type">
									<button type="button" class="sp_btn ver" ng-class="viewType=='LIST' ? 'sele' : ''" 
										onclick="location.href='/exhibitDetail?view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type=LIST&sale_kind=${SALE_KIND_CD}'">
										<span class="hidden"><spring:message code="label.list.vertical" /></span>
									</button>
									<button type="button" class="sp_btn hor" ng-class="viewType=='GRID' ? 'sele' : ''" 
										onclick="location.href='/exhibitDetail?view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type=GRID&sale_kind=${SALE_KIND_CD}'">
										<span class="hidden"><spring:message code="label.list.horizontal" /></span>
									</button> 
								</div>
								<span class="btn_style01 white02 icon02 btn_scrollbot">
									<button type="button"><spring:message code="label.move.bottom" /></button>
									<span class="ico down"></span>   
								</span>
							</div>
						</div>   
					</form> 
 
					<div ng-class="viewType == 'LIST' ? 'auction_list' :  'auction_h_list'" style="z-index:8; background-color:#fff">
						<ul id="auctionList">
							<li ng-repeat="lot in lotList" ng-init="lot_map[lot.LOT_NO] = lot;" on-finish-render-filters>
								<c:if test="${VIEW_TYPE == 'LIST'}">
									<jsp:include page="inc_lotList_List_Exhibit.jsp" flush="false"/>
								</c:if>
								<c:if test="${VIEW_TYPE == 'GRID'}">
									<jsp:include page="inc_lotList_Grid_Exhibit.jsp" flush="false"/>
								</c:if>
							</li>
						</ul>
					</div>
					<div style="display:none;">
						<span class="btn_style01 xlarge green02 btn_bid btn_modal pop01">
							<button type="button">작품응찰신청</button>
						</span>
						<span class="btn_style01 xlarge green02 btn_bid btn_modal pop02">
							<button type="button">응찰하기</button>
						</span>
						<span class="btn_style01 xlarge dark btn_bid btn_modal pop03">
							<button type="button">경매기록보기</button>
						</span>
						<span class="btn_style01 xlarge dark btn_bid btn_modal pop13">
							<button type="button">사업자본인인증</button>
						</span>
						<span class="btn_style01 xlarge dark btn_bid btn_modal pop11">
							<button type="button">비디오보기</button>
						</span>
						<span class="btn_style01 gray02 btn_modal pop15">
							<button type="button">Become a Bidding Member</button>
						</span>
					</div>
					<div class="wrap_paging">
						<!-- S : paging 영역 -->
						<paging page="currentPage"
								page-size="pageRows"
								total="totalCount"
								adjacent="10"
								paging-action="loadLotList(page)"
								scroll-top="true"
								hide-if-empty="true"
								show-prev-next="true"
								show-first-last="true"
								ul-class="page_ul"
								active-class="page_active"
							    disabled-class="page_disable"
							    text-next-class="page_btn sp_btn btn_next02"
							    text-prev-class="page_btn sp_btn btn_prev02"
							    text-first-class="page_btn sp_btn btn_prev"
							    text-last-class="page_btn sp_btn btn_next"
						>
						</paging>
						<!-- E : paging 영역 -->
						<div class="right">
							<span class="btn_style01 icon02 btn_scrolltop mbtn">
								<button type="button"><span><spring:message code="label.move.top" /></span></button>
								<span class="ico up"></span>
							</span>
						</div>
					</div>
					
					<jsp:include page="../include/bottom.jsp" flush="false" />
					
				</div><!-- contents m_top -->
			</div>		

		</div>

		<!--<div class="sub_banner web_only">
				<div class="hidden_box">
				<ul>
						<li>
						<img src="/images/img/img_past.png" alt="작품1" class="img_master">
					</li>
				</ul>
		</div>
		</div>-->
	
	</div>
</div>
<script type="text/javascript">
//
//var slide_expe_start = 0;
//var slide_expe_end = 0;
////$(document).ready(function(){
////	setUiSlider(min_expe_price, max_expe_price, min_expe_price, max_expe_price);
////});

////화폐 구분 변경 이벤트

//function setUiSlider(nEstimateStart, nEstimateEnd, nEstimateMin, nEstimateMax) {
//	$("#estimatePriceStart").val(nEstimateStart);
//	$("#estimatePriceEnd").val(nEstimateEnd);
//	$("#estimateRange").noUiSlider({
//		start: [nEstimateStart, nEstimateEnd],
//		orientation: "horizontal",
//		connect: true,
//		step: 1000,
//		range: {
//			"min": nEstimateMin,
//			"max": nEstimateMax
//		}
//	}, true);
//	
//	$("#estimateRange").on({
//		slide: function(){
//			var startPrice = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
//			var endPrice = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];    	// 추정가 같은 경우 0~맥스추정가 설정. YDH
//			$("#rangeText").html(comma(parseInt(startPrice, 10)) + " ~ " + comma(parseInt(endPrice, 10)));
//		},
//		set: function(){
//			slide_expe_start = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
//			slide_expe_end = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];		// 추정가 같은 경우 0~맥스추정가 설정. YDH
//		},
//		change: function(){
//		}
//	});
//	
//	$("#estimateRange").Link('lower').to($("#estimatePriceStart"));
//	$("#estimateRange").Link('upper').to($("#estimatePriceEnd"));
	
//	var startPrice = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
//	var endPrice = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];							// 추정가 같은 경우 0~맥스추정가 설정. YDH
//	$("#rangeText").html(comma(parseInt(startPrice, 10)) + " ~ " + comma(parseInt(endPrice, 10)));
//	slide_expe_start = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
//	slide_expe_end = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];						// 추정가 같은 경우 0~맥스추정가 설정. YDH
//}

 
$(document).ready(function(){
$(".flip").click(function(){
$(".panel").slideToggle();
});
});


</script>

<script>
$(function() {

	var slideCount = $('#slides > div').size();

	$('#slides').slidesjs({
		width : 940,
		height : 528,
		navigation : {
			active : false
		},
		start : 1,
		play : {
			auto : slideCount > 1 ? true : false
		}
	});

	if(slideCount < 2){
		$(".slidesjs-navigation").hide();
		$(".slidesjs-slide").css("left", "0px");
	}
});

fullImg();
funcContHeight();
</script>

<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
