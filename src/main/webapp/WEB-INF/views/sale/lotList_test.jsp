<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<link href="/css/angular/rzslider.css" rel="stylesheet">
<link href="/css/angular/ngDialog.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">
<link href="/css/jquery.modally.css" rel="stylesheet">
<script type="text/javascript" src="/js/angular/paging.js"></script>
<script type="text/javascript" src="/js/jquery.modally.js"></script>
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

<!-- manual/auto -->
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
    var varUA = navigator.userAgent.toLowerCase(); //userAgent ??? ??????
    if ( varUA.indexOf('android') > -1) {
        //???????????????
        return "android";
    } else if ( varUA.indexOf("iphone") > -1||varUA.indexOf("ipad") > -1||varUA.indexOf("ipod") > -1 ) {
        //IOS
        return "ios";
    } else {
        //?????????, ??????????????? ???
        return "other";
    }
}

var filter = "win16|win32|win64|mac";
if(navigator.platform){
	if(0 > filter.indexOf(navigator.platform.toLowerCase())&& checkMobile() != 'android'){//Mobile
		history.scrollRestoration = "auto" //??????????????? ?????? ????????? ?????? ??????O
	}else{//PC
		history.scrollRestoration = "manual" //pc?????? ?????? ????????? ?????? ??????X
	}
}

$(window).on('beforeunload', function(event){
    scope = angular.element(document.getElementById("container")).scope();
    /* ?????? ????????? ?????? ?????? */
	var offset = $(window).scrollTop(); 
    offset = offset > 1 ? offset : document.querySelector('body').scrollTop; 
    sessionStorage.setItem("scroll_loc", offset); // ????????? ?????? ????????? ?????? ?????? 
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
	
	var getRowCnt = getCookie("reqRowCnt");
	if(!getRowCnt){
		getRowCnt = "20";
	} else {
		getRowCnt = getCookie("reqRowCnt");
	}
	$scope.reqRowCnt = getRowCnt; // "20"
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
	/* YBK.20170314.???????????? ?????? ?????? */
	$scope.cate_list = null;
	$scope.scate_list = null;
	$scope.mate_list = null;
	$scope.artist_list = null;
	$scope.fav_cds_list = null;
	/* YBK.20170314.???????????? ?????? ?????? */
	$scope.hashtag_list = null;
	$scope.sale_outside_yn = (getParameter("sale_outside_yn"));
	$scope.padd_info = null;
	
	$scope.selected_cate = 'all'; //???????????? font color ??????

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
	 		<c:when test="${VIEW_ID == 'CURRENT_AUCTION'}">
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
 		} else if( kindCategory == "trad" ) {
 			$scope.cate_list=['traditional'];
 		} else {
 			$scope.cate_list = null;
 		}
 	}

 	$scope.loadSaleMenuList = function(){
 		if(!$scope.sale_outside_yn){
 			$scope.sale_outside_yn = "N";  
 		}
 		
 		$d = {"baseParms":{},
 				"actionList":[					/* "sort_by": ????????????(2020.06.06 YDH)"DATAS" => SALENOASC. ?????????  sort_by ????????? ????????? SALENOASC, SALENODESC???. */  
 				{"actionID":"sale_list_paging_test", "actionType":"select" , "tableName": "SALES", "parmsList":[{"sale_kind_cd":$scope.sale_kind_cd, "status":"READY", "sale_outside_yn": $scope.sale_outside_yn, "sort_by":"SALENOASC", "from":0, "rows":3}]}
 			 ]};
 		
 	   	common.callActionSet($d, function(data, status) {
 	 	    $scope.saleMenuList = data["tables"]["SALES"]["rows"];
 	 	    
 	 	    if($scope.saleMenuList.length == 0){
 	 	    	if($scope.locale == 'ko')
 	 	    	{
 	 	    		alert("?????? ??????????????????.");	
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
 		if(!f) f = (locale == 'ko' ? 'd??? h?????? m??? s???' : 'd[Days] hh:mm:ss'); 
    	var s = moment(toDT).diff(moment($scope.db_now), 'seconds');
    	if(s > 0){ 
        	var d = moment.duration(s, "seconds").format(f);
        	return d;
    	}
    	else if (s == 0){
    		$scope.duraionEnd();
    	}
    	if(locale == 'ko'){return "?????????...";
    	} else {
    		return "Now Closing...";
    	}
    }
 	
 	//?????? ???????????? ?????? ?????? ?????? ??????
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
 		$scope.setExpeSlide($scope.sale.CURR_CD);
 		$scope.s_expe_currency = $scope.sale.CURR_CD;
 		$scope.artistName = null;
 		$scope.worksTitle = null;
 		$scope.lot_no = null;
 		
 		// YBK.20170315.???????????? ?????????
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
		$scope.fav_selected = [];
		$scope.fav_cds_list = null;
		$scope.loadLotList(1);
 	}
 	
 	$scope.loadLotList = function($page){
 		 
		 

		window.location.hash = '#page' + $page;
 		if(!$scope.sale_outside_yn){
 			$scope.sale_outside_yn = "N";
 		}
 		
 		setCookie('sale_no', $scope.sale_no, 1);
//  		setCookie('page', $page, 1);
 		setCookie('reqRowCnt', $scope.reqRowCnt, 1);
 		 
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
					, "cate_cds" : $scope.cate_list, "scate_cds" : $scope.scate_list, "mate_cds" : $scope.mate_list, "artist_nos" : $scope.art_list, "hashtag_list" : $scope.hashtag_list,  "fav_cds_list" : $scope.fav_cds_list,
				},
 				"actionList":[
 				{"actionID":"sale_info_test", "actionType":"select" , "tableName": "SALE"},
 				{"actionID":"exch_rate_list", "actionType":"select" , "tableName": "EXCH"},
 				{"actionID":"lot_list_count_test", "actionType":"select" , "tableName": "LOT_CNT" ,"parmsList":[{"for_count":true}]},
 			    {"actionID":"lot_list_paging_test", "actionType":"select" , "tableName": "LOTS" ,"parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt), "sale_outside_yn": $scope.sale_outside_yn, "sort_by":$scope.sortBy}]},
  				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
  				/* YBK.20170314.???????????? ?????? */
  				{"actionID":"saleLot_category", "actionType":"select", "tableName":"CATEGORY"},
  				{"actionID":"saleLot_subcategory", "actionType":"select", "tableName":"SUBCATEGORY"},
  				{"actionID":"saleLot_material", "actionType":"select", "tableName":"MATERIAL"},
  				{"actionID":"saleLot_artist", "actionType":"select", "tableName":"ARTIST"},
  				/* YBK.20170314.???????????? ?????? */
  				{"actionID":"saleLot_hashtag", "actionType":"select", "tableName":"HASHTAG"},
  				{"actionID":"saleHighlight_List", "actionType":"select", "tableName":"LOT_HIGHLIGHT"}, 
 			 ]};

 		
 		if(is_login == "true"){
	 		/* blueerr 20180810 ?????? ????????? ?????? ?????? */
			$d.actionList.push({"actionID":"sale_cert_info", "actionType":"select", "tableName":"CERT"});
			/* blueerr 20180810 ?????? ????????? ?????? ?????? */
			/* ???????????? ???????????? ?????? */
			$d.actionList.push({"actionID":"my_paddle_check", "actionType":"select", "tableName":"PADDLE_CHECK", "parmsList":[{}]});
 		}
 		
 	   	$d["actionList"][3]["parmsList"][0]["from"] = (($scope.currentPage - 1) * parseInt($scope.reqRowCnt)); 
 	   	common.callActionSet($d, function(data, status) { 
	 	   	if(is_login == "true"){
			   	var padd_info = data["tables"]["PADDLE_CHECK"]["rows"][0];
			   	$scope.padd_no = padd_info == null? 0 : padd_info.PADD_NO;
	 	   	}
		   	
 	 		$scope.sale = data["tables"]["SALE"]["rows"][0];
 	 		$scope.db_now = $scope.sale.DB_NOW;
 	 		$scope.exchRateList = data["tables"]["EXCH"]["rows"];
 	 		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
 	 		/* YBK.20170314.???????????? ?????? */
 	 		$scope.category = data["tables"]["CATEGORY"]["rows"];
 	 		$scope.subcategory = data["tables"]["SUBCATEGORY"]["rows"];
 	 		$scope.material = data["tables"]["MATERIAL"]["rows"];
 	 		$scope.artist = data["tables"]["ARTIST"]["rows"];
 	 		/* YBK.20170314.???????????? ?????? */
 	 		$scope.hashtag = data["tables"]["HASHTAG"]["rows"];
 	 		$scope.highlight = data["tables"]["LOT_HIGHLIGHT"]["rows"];
 	 		
 	 		if($scope.expe_from_price == null && $scope.expe_to_price == null){
 	 	 		$scope.setExpeSlide($scope.sale.CURR_CD);
 	 	 		$scope.expe_from_price = parseInt(slide_expe_start);
 	 	 		$scope.expe_to_price = parseInt(slide_expe_end);
 	 	 		$scope.s_expe_currency = $scope.sale.CURR_CD;
 	 		} 
 	 		
 	 		var S_DB_NOW = $filter('date')($scope.db_now, 'yyyyMMddHHmm');
 	 		var S_DB_NOW_D = $filter('date')($scope.db_now, 'yyyyMMdd');
 	 		var FROM_DT = $filter('date')($scope.sale.FROM_DT, 'yyyyMMdd');
 	 		var TO_DT = $filter('date')($scope.sale.TO_DT, 'yyyyMMdd');
 	 		var END_DT = $filter('date')($scope.sale.END_DT, 'yyyyMMddHHmm');
 	 		var LIVE_START_DT = $filter('date')($scope.sale.LIVE_BID_DT, 'yyyyMMddHHmm');    
 	 		
 	 		// ???????????? ????????? ???????????? SALE.TO_DT??? YYYY.MM.DD??? ??????. ?????? ??????????????? S_DB_NOW_D (YDH. 2016.10.05)
 	 		// ????????? ????????? ???????????? MAX(LOT.TO_DT) ???????????? ???????????? ??????. ?????? ??????????????? S_DB_NOW (YDH. 2016.10.05)
 	 		
 	 		//????????? ?????? ?????? ??????
 	 		$scope.liveEnd = TO_DT;
 	 		$scope.nowTime = S_DB_NOW_D;
 	 		$scope.liveStartDt = LIVE_START_DT;
 	 		$scope.liveCheckDt = S_DB_NOW;   
 	 		
 	 		if(FROM_DT > S_DB_NOW && 
 	 				((['main','hongkong','plan'].indexOf($scope.sale.SALE_KIND_CD) > -1 && TO_DT > S_DB_NOW_D)	//$scope.sale.SALE_KIND_CD != 'online' ??????. 2019.12.12 YDH
 	 				|| (['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && END_DT > S_DB_NOW))	//$scope.sale.SALE_KIND_CD == 'online' ??????. 2019.12.12 YDH
 	 			){
 	 			$scope.sale_status = "READY";
 	 		}
 	 		else if(FROM_DT <= S_DB_NOW && 
					((['main','hongkong','plan'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.CLOSE_YN != 'Y')	//$scope.sale.SALE_KIND_CD != 'online' ??????. 2019.12.12 YDH
 	 				|| (['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && END_DT >= S_DB_NOW))		//$scope.sale.SALE_KIND_CD == 'online' ??????. 2019.12.12 YDH
				){
 	 			$scope.sale_status = "ING";
 	 			if(!$scope.now_timer_start){
 	 				console.log("duration timer start!!");
 	 	 	 		$scope.timer_duration = $interval(function(){$scope.db_now = moment($scope.db_now).add(1, 'seconds');}, 1000);
 	 	 	 		$scope.now_timer_start = true;
 	 			} 
 	 		}
 	 		else if((['main','hongkong','plan'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.CLOSE_YN == 'Y')	//$scope.sale.SALE_KIND_CD != 'online' ??????. 2019.12.12 YDH
 				|| (['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && END_DT < S_DB_NOW)){		//$scope.sale.SALE_KIND_CD == 'online' ??????. 2019.12.12 YDH
 	 			$scope.sale_status = "END";
 				
 	 			if(is_login == "false"){
 	 				alert("?????? ????????? ?????????????????????. ????????? ???????????? ????????????.");
 	 				window.close();
 	 			}
 	 		}
 	 		
 	 		$scope.totalCount = data["tables"]["LOT_CNT"]["rows"][0]["CNT"];

 	 		//$scope.setJsonObj(data["tables"]["LOTS"]["rows"], ["LOT_SIZE", "ARTIST_NAME", "TITLE", "STITLE", "MAKE_YEAR"]);
 	 		
 	 	    $scope.lotList = data["tables"]["LOTS"]["rows"];
 	 	    $scope.curr_lot_no = $scope.lotList[0].CURR_LOT_NO;
 	 	   
 	 	    //$scope.base_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKD" : "KRW");
 	 	    $scope.base_currency = $scope.sale.CURR_CD;
 	 	    $("#nationCash").html($scope.sale.CURR_CD);
 	 	    $scope.base_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKT" : "KST");
 	 		//$scope.sub_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KRW" : "HKD");
 	 		$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
 	 		$scope.sub_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KST" : "HKT");
 	 		
 	 		$scope.orders = (['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && is_login) ? $.extend($scope.orders1, $scope.orders2) : $scope.orders1;//$scope.sale.SALE_KIND_CD == 'online' ??????. 2019.12.12 YDH
 	 		
 	 		$scope.pageRows = parseInt($scope.reqRowCnt);
 	 		
 	 		if($scope.sale_status == "ING" && ['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && data.tables.CERT){ //$scope.sale.SALE_KIND_CD == 'online' ??????. 2019.12.12 YDH
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
 		//$scope.sale.SALE_KIND_CD == 'online' ??????. 2019.12.12 YDH
 		if(['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.lot_nos.length == 0){  //?????????(2017.03.30) if($scope.lot_nos.length == 0){ 
			console.log("refreshLots end");
			// ????????? ???????????? ?????????
			$scope.initTimer();
			return;
 		}

 		$d = {"actionList":[
 			    {"actionID":"lot_list_refresh", "actionType":"select" , "tableName": "LOTS" ,"parmsList":[{"sale_no":$scope.sale_no, "lot_nos": $scope.lot_nos}]}
 		 ]};
 		
 		common.callActionSet($d, function(data, status) { 
 	 		var $d = data["tables"]["LOTS"]["rows"];
 			var lot = null;
 			
 			// ???????????? 0 ?????? ?????? ????????? ??????

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
 	            	//lot["GROW_PRICE"] = $d[i]["GROW_PRICE"]; //?????????????????? ??????????????????. ?????? ????????????(2019.10.03 YDH)
 	            	////$scope.lot.GROW_PRICE = $d[i]["GROW_PRICE"];
 	            	
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
	 	//???????????? ?????? 1??????????????? refresh
	 	if(['main','hongkong','plan'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){//$scope.sale.SALE_KIND_CD != 'online' ??????. 2019.12.12 YDH
			console.log("========= offline runLotsRefresh start");
 	 		//if(!$scope.modal) 
 	  		$scope.timer_lots_refresh = $interval($scope.refreshLots, 60000);//, 1);
 	  		$scope.list_timer_start = true;
 		}
	 	//????????? ????????? 5???????????? refresh
 		if(['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){	//$scope.sale.SALE_KIND_CD == 'online' ??????. 2019.12.12 YDH
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
			alert("????????? ???????????? ?????? ????????? ?????? ?????????.");
			//$interval.cancel($scope.refreshLots);
 	  		//$scope.list_timer_start = false;
			$scope.cancelLotRefresh();
		}
		else{
			$scope.runLotsRefresh(); 
		}
	}

	$scope.showBidPopup = bid.showBidPopup;
	$scope.showBidRequestPopup = bid.showBidRequestPopup;
	$scope.showBidHistoryPopup = bid.showBidHistoryPopup;
	
	$scope.setExpeSlide = function(currency) {
 		setUiSlider($scope.sale["MIN_" + currency + "_EXPE_PRICE"], $scope.sale["MAX_" + currency+ "_EXPE_PRICE"]
 			, $scope.sale["MIN_" + currency + "_EXPE_PRICE"], $scope.sale["MAX_" + currency+ "_EXPE_PRICE"]);
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
	
	
	/* YBK.20170314.???????????? ?????? */
	// ?????????????????? ???????????? ??????
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
		$scope.fav_selected = [];
		$scope.fav_cds_list = null;
		$scope.loadLotList(1);
		$scope.selected_cate = 'all';
	}
	
	// ?????????????????? ?????? ???????????? ??????
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
		$scope.fav_selected = [];
		$scope.fav_cds_list = null;	
		$scope.loadLotList(1);
	}
	
	// ?????? ?????? ???????????? ??????
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
	
	// ?????? ?????? ???????????? ??????
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
	
	// ?????? ?????? ??????
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
		
		// filterLotListL.jsp ???????????????
 		$scope.expe_from_price = null;
 		$scope.expe_to_price = null;
 		$scope.setExpeSlide($scope.sale.CURR_CD);
 		$scope.s_expe_currency = $scope.sale.CURR_CD;
 		$scope.artistName = null;
 		$scope.worksTitle = null;
 		$scope.lot_no = null;
	}
	/* YBK.20170314.???????????? ?????? */
	
	/* ??????????????????/???????????? ??????, ?????? SRC START (2017.08.11 YDH) */
	/* YBK.???????????????????????? */
	$scope.showConditionReportPopup = bid.showConditionReportPopup;
	/* YBK.???????????????????????? */
	
	/* ???????????? Start */
	// ???????????? ?????? ??????(2018.08.14 YDH)
	$scope.inteSave = function($input) {		
		var $d = {"baseParms":{"sale_no":$input.sale_no, "lot_no":$input.lot_no}, 
				"actionList":[
				{"actionID":"add_cust_inte_lot", "actionType":"insert", "tableName":"CUST_INTE_LOT", "parmsList":[{}]}
				]};
		common.callActionSet($d, function(data, status) {
			if(data.tables["CUST_INTE_LOT"]["rows"].length > 0) {
				if($scope.locale == 'ko') {
					alert("???????????? ????????? ?????????????????????.\n????????? ??????????????? ACCOUNT??????????????? ???????????? ??? ????????????.");
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
					alert("??????????????? ?????????????????????.");
					window.location.reload(true);
				}else {
					alert("A favorate work has been deleted.");
					window.location.reload(true);
				}
				return true;
			}
		})	
	}
	/* ???????????? End */
	/* ??????????????????/???????????? ??????, ?????? SRC END (2017.08.11 YDH) */
	
	/* ????????? ?????? ???????????? ?????? */
	$scope.paddleAdd = function(saleNo){
		
		$scope.paddleYn = 'N';
		
		if(is_login == "false" && $scope.locale  == 'ko' ){
			alert("????????? ??? ??????????????????");
			return false;
		} else {
				if(is_login == "false" && $scope.locale  != 'ko'){  
				alert("Please login for use.");
				return false;
			}
		}
		
		
		var $d = {"baseParms":{"sale_no":saleNo}, 
				"actionList":[
				{"actionID":"paddle_info", "actionType":"select", "tableName":"PADDLE_INFO", "parmsList":[{}]},
				{"actionID":"paddle_add", "actionType":"insert", "tableName":"PADDLE_ADD", "parmsList":[{}]}
				]};
		common.callActionSet($d, function(data, status) {
			$scope.paddle = data["tables"]["PADDLE_INFO"]["rows"][0];
			if($scope.paddle.PAD_INFO == 1){
				$scope.paddleYn = 'Y';
			} else {
				$scope.paddleYn = 'N';
			}
			if($scope.locale == 'ko') {
					if($scope.paddleYn == 'Y'){
						alert("?????? ??????????????? ????????????????????????.");
						return false;
					} 
				}
			 else {
					if($scope.paddleYn == 'Y'){
						alert("You have already been given a paddle number.");
						return false;
					} 			
				}
			if(data.tables["PADDLE_ADD"]["rows"].length > 0) {
						var $d = {"baseParms":{"sale_no":saleNo}, 
								"actionList":[
								{"actionID":"my_paddle_check", "actionType":"select", "tableName":"PADDLE_CHECK", "parmsList":[{}]}
								]};
						
						common.callActionSet($d, function(data, status) {
							$scope.check = data["tables"]["PADDLE_CHECK"]["rows"][0];
							//console.log($scope.check.PADD_NO);  
							
							$("#liveBidContents").html("???????????? ???????????????"+$scope.check.PADD_NO+"??? ?????????.");
							$("#liveBidInfoCheck").trigger('click');
							
							$scope.padd_no = $scope.check.PADD_NO;
							
						});
			} 
		})	
	}
	
	$scope.close = function(){
		self.opener = self;
		window.close();
		$scope.modal.close();
	}
	
	//lot???????????? ??? ?????? ????????? ????????? ??????
	$scope.$on('ngRepeatFinished', function (ngRepeatEndEvent) { 
 		var scroll_loc = sessionStorage.getItem("scroll_loc");
  		//$(window).scrollTop(scroll_loc); //IE?????? X 
 		$("body, html").stop().animate({scrollTop : scroll_loc}, 0);
 		sessionStorage.removeItem("scroll_loc");
	});  
	
	//?????? ?????? ???????????? ??????
	$scope.openNotice = function(write_no){
		window.open('about:blank').location.href="/noticeView?write_no="+write_no;
	}
});
</script>
<script type="text/javascript" src="/js/bid.js"></script>
<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
	
		<div id="container" ng-controller="lotListCtl" data-ng-init="init();">
			<div class="sub_menu_wrap menu01">
				<div class="sub_menu">
					<jsp:include page="../include/subMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">????????????</span></button>
			</div> 
			<!-- //sub_menu_wrap -->
			
			<div class="contents_wrap">
            <!-- ???????????? -->    
				<div class="m_only m_location">
                    <%-- ???????????? ?????? ???????????? 
					<div class="btns">
						<c:if test="${map.selectedPlanning.prev_id > 542}">  
							<c:if test="${map.selectedPlanning.prev_id eq '529'}">
								<button type="button" class="btn_prev" onClick="movePrevSales('540');">
								<span class="hidden"></span>
								</button>
							</c:if>  
							<c:if test="${map.selectedPlanning.prev_id ne '529'}">
						<button type="button" class="btn_prev" onClick="movePrevSales('${map.selectedPlanning.prev_id}');">
							<span class="hidden"></span>
						</button>
							</c:if>
						</c:if>
						<c:if test="${map.selectedPlanning.next_id > 0}">
						<button type="button" class="btn_next" onClick="moveNextSales('${map.selectedPlanning.next_id}');">
							<span class="hidden"></span>
						</button>
						</c:if>
					</div>--%>
                     
                    <!--  <div class="btns">
						<span ng-if="sale.SALE_NO == 401">
							<button type="button" class="btn_prev" onClick="location.href='/currentAuction?sale_no=399'">
								<span class="hidden"></span>
							</button>
						</span>						
						<span ng-if="sale.SALE_NO == 399">
							<button type="button" class="btn_next" onClick="location.href='/currentAuction?sale_no=401'">
								<span class="hidden"></span>
							</button>
						</span>
					</div>--><%-- ???????????? ?????? ???????????? --%> 
					<div class="hidden_box">
						<ul> 
							<li>
								<div class="m_ex_title"> 
									<div class="title"> 
										<div class="tit lotlist_memobox">    
											<span class="num" ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0" ng-bind="sale.SALE_TH | localeOrdinal"></span>
											<span style="padding: 0 15px;" ng-bind="sale.TITLE_JSON[locale]"></span>
											<!-- <span ng-if="viewId == 'CURRENT_AUCTION' && sale_status == 'ING' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status = 'END'">?????? LOT : <span ng-bind="curr_lot_no"></span></span> -->
										</div>
										<div class="sub lotlist_memobox">
                                            <%-- ????????? ?????? ?????? ?????? ?????? --%>
                                            <p ng-if="locale != 'ko'">
                                            	<span style="font-weight:600; color: #00acac; display: inline-block;">AUCTION : </span>
                                            	<span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'(EEE) d MMM, yyyy h:mm a' : 'UTC+9' | lowercase)+' ' + base_timezone"></span>
                                                <span ng-if="sale.SALE_KIND_CD == 'hongkong'" ng-bind="'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a'  : 'UTC+9'| lowercase)+' '+sub_timezone+')'"></span>
                                            </p> 
                                            <p ng-if="locale == 'ko'"> 
                                            	<span style="font-weight:600; color: #00acac; display:inline-block;">??? ??? : </span>  
                                            	<span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d' : 'UTC+9' | lowercase)+'('+getWeek(sale.TO_DT)+')'+(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'h:mm a' : 'UTC+9')+' '+base_timezone"></span>
                                                <span ng-if="sale.SALE_KIND_CD == 'hongkong'" ng-bind="'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a'  : 'UTC+9'| lowercase)+' '+sub_timezone+')'"></span>
                                            </p>   
                                            <!-- <p>
                                           		<span ng-if="viewId == 'CURRENT_AUCTION' && sale_status == 'ING' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.FROM_DT > db_now" ng-bind="db_now | timeDuration : sale.TO_DT" style="font-weight:600;"></span> 
                                            </p> -->  
                                			<!-- <p> 
                                				<span ng-bind="sale.PLACE_JSON[locale]"></span>
                                			</p> -->
                                			<%-- <span ng-if="viewId == 'CURRENT_AUCTION' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.TO_DT < db_now" style="font-weight:600;">?????? LOT : <span ng-bind="curr_lot_no" style="font-weight:600; color:#00acac;"></span></span> --%>
                                			<p>
                                        	    <span ng-bind-html="sale.NOTICE_JSON[locale]"></span>
                                			</p>  
                                            <!--??????-->
                                            <!-- <span ng-if="sale.SALE_KIND_CD == 'hongkong' && viewId == 'CURRENT_AUCTION'">
	                                          <span ng-if="locale == 'ko'" style="font-weight:600;">* ?????? ?????? ?????? ????????? ??? ???????????? : ???????????? ??? ??????????????? ?????? ????????? ??????????????????. ????????? ?????? ?????? ?????? ???????????? ??????????????? ????????? ???????????? ????????? ????????? ?????? ?????? ??? ?????? ????????? ?????? ????????? ??????????????????. ????????? ??? ?????? ?????? ???????????? ???????????? ????????? ?????? ?????? ????????? ?????? ????????? ????????? ????????? ????????? ????????????.</span>
	                                            <span ng-if="locale != 'ko'"><font style="font-weight:600;">* Currency indication of the estimated price and the payment : </font>All bids and payment will be in <font style="font-weight:600;">Hong Kong Dollars (HKD)</font>. Multi-currency pricing is for reference only and all bid payment shall be in HKD.. Also, we will not take responsibility for any problems that occur during the calculation of currency exchange rates</span>
                                                <span ng-if="locale != 'ko'"><br />E-mail saplus@seoulauction.com</span>
                                            </span>
                                            ??????
                                            <span ng-if="sale.SALE_KIND_CD != 'hongkong' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">
	                                            <span ng-if="locale == 'ko'" style="font-weight:600;">* ???????????????: 15%??? (????????? ??????) </span><span ng-if="locale == 'ko' && sale.SALE_NO == '401' && sale.SALE_KIND_CD == 'online' " style="font-weight:600;"> / ??????????????? ?????????</span>
	                                            <span ng-if="locale == 'ko'"><br />* ????????? <font style="font-weight:600;">?????? ????????? ?????? ??? ?????? ?????? ?????? ??????</font>??? ??????, ?????? ???????????? ?????? ????????? ???????????? ????????????.</span>
                                                <span ng-if="locale != 'ko'">E-mail info@seoulauction.com</span>
                                            </span> 
                                            ?????????
                                            <span ng-if="sale.SALE_KIND_CD != 'hongkong' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.SALE_NO == '463'" >
                                                 <span ng-if="locale == 'ko'">* ???????????????: 18% (????????? ??????)</span>
                                                 <span ng-if="locale != 'ko'">* Buyer???s Premium: 18% (VAT excluded)</span>                            
                                                 <span ng-if="locale != 'ko'"><br/>* E-mail info@seoulauction.com</span>
                                            </span> --> 

                                            <!--<span ng-if="sale.SALE_KIND_CD != 'hongkong'">
                                                 <br/><span ng-if="locale == 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60">????????? ???????????????. ????????? ????????? ?????? ???????????? ???????????????.<br/>?????? ????????? ?????? ???????????? ????????? ????????????. </span>
                                                 
                                                 <br/><span ng-if="locale != 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60"">TEST AUCTION. Even if you make a bid, it doesn't really matter.</span>
                                            </span>-->           
                                            <!--?????????LIVE ?????????--> 
                            			</div>  
	                                    <div class="m_only" style="padding:4px; margin-top:10px;"> 
                                            <!-- ????????? ??????(???????????????) -->
                                            <!--<span class="btn_style01 white"  ng-if="locale=='ko'"><button type="button" name="???????????????" value="???????????????" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')";>???????????????</button></span>
                                            <span ng-if="locale!='ko'"><button type="button" name="Auction Live" value="Auction Live" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')";>Auction Live</button></span>  
                                            </div> --> 
                                              
                                            <!-- ????????? ?????? ??????????????? ??????(???????????????)   
                                            <span class="btn_style01 orange01"  ng-if="custInfo.MEMBERSHIP_YN == 'Y' || custInfo.FORE_BID_YN == 'Y' || custInfo.EMP_GB == 'Y'"><button type="button" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=bidLivePop')";><span ng-if="locale=='ko'">Live ??????</span><span ng-if="locale!='ko'">Live biding</span></button></span>
                                            </div> -->  
                                            <!-- ????????? ?????? ??????????????? ??????(???????????????) 
                                            <span class="btn_style01 orange01"  ng-if="custInfo.MEMBERSHIP_YN != 'Y' && custInfo.FORE_BID_YN != 'Y' && custInfo.EMP_GB != 'Y'"><button type="button" align="center" scrolling="no" onClick="alert('???????????? ?????? ???????????????.')"><span ng-if="locale=='ko'">Live ??????</span><span ng-if="locale!='ko'">Live biding</span></button></span> 
                                            </div> -->       
                                             
                                            <!-- PREVIEW ?????? ?????? (?????? ????????????. 2020.12.12 ???2????????????)  
                                            <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn != 'Y'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="PREVIEW" value="PREVIEW" align="center" scrolling="no" onClick="window.open('${contextPath}/upcomingAuction?sale_kind=${SALE_KIND_CD}&sale_no=${SALE_NO}')";>PREVIEW</button>
                                            </span> -->       
                                                
                                            <!-- Notice ?????? ??????  
                                            <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_KIND_CD == '000'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_KIND_CD == '000'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/noticeView?write_no=2895')"; >NOTICE</button>
                                            </span> 
                                            
                                            <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '422'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '422'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=4287')"; >NOTICE</button>               
                                            </span> 
                                             -->   
                                             
                                            <!-- Notice ?????? ?????? ?????? -->
                                            <span class="btn_style01 dark" ng-if="sale.WRITE_NO > 0"> 
                                                <button type="button" name="NOTICE" value="NOTICE" align="center" scrolling="no" ng-click="openNotice(sale.WRITE_NO)" >NOTICE</button>          
                                            </span> 
                                            
                                            <!-- EXHIBITION ?????? ??????(VR) -->  
                                             <!-- ?????? EXHIBITION 
                                            <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '566'"> 
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_hk')"; >EXHIBITION</button>
                                            </span> -->  
                                            
                                            <!--  ????????? EXHIBITION 
                                             <span class="btn_style01 dark" ng-if="sale.SALE_NO == '562'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/VR/')"; >EXHIBITION</button> 
                                            </span> -->
                                            
                                            <!--  ????????? EXHIBITION 
                                             <span class="btn_style01 dark" ng-if="sale.SALE_NO == '563'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_online2')"; >EXHIBITION</button> 
                                            </span> -->
                                            
                                            <!-- ?????? ?????? EXHIBITION  
                                            <span class="btn_style01 dark" ng-if="sale.SALE_NO == '562'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_online2')"; >VR Video</button>
                                            </span> -->    
                                             
                                            <!-- ??????????????? ?????? ??????  
                                            <span class="btn_style01 dark" ng-if="sale.SALE_NO == '569'"> 
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="ARTIST VIEW" value="ARTIST VIEW" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/zerobaseArtist')"; >ARTIST VIEW</button> 
                                            </span> --> 
                                            
                                            <!-- ????????? ???????????? -->   
                                            <span class="btn_style01 orange01" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y' && sale.SALE_NO == '667'">   
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'" name="Artsy" value="Artsy" align="center" scrolling="no" onClick="window.open('https://www.artsy.net/auction/artsy-x-seoul-auction-mixed-media-1')"; > 
                                                    <span ng-if="locale != 'ko'">Artsy Bid</span>
                                                    <span ng-if="locale == 'ko'">????????? ??????</span> 
                                                </button>   
                                            </span> 
                                            
                                            <!-- ????????? ???????????? (?????? ?????? ???)-->  
                                            <!-- <span class="btn_style01 orange01" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y' && sale.SALE_NO != '667'">    
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'" name="Artsy" value="Artsy" align="center" scrolling="no" onClick="window.open('https://www.artsy.net/auction/artsy-x-seoul-auction-mixed-media')"; >
                                                    <span ng-if="locale != 'ko'">Artsy Bid</span>
                                                    <span ng-if="locale == 'ko'">????????? ??????</span>   
                                                </button>     
                                            </span> -->  
                                            
                                            <!-- e-book ?????? ?????? (?????? 4????????? ??????)  -->   
                                            <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '681'"> 
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '681'" name=" CATALOGUE" value=" CATALOGUE" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/e-book/164th/index.html')"; >CATALOGUE</button>     
                                            </span> 
                                             
                                            <!-- <span class="btn_style01 orange01"  ng-if="sale.SALE_NO == '452' && locale=='ko'">
	                                            <button type="button" name="???????????????" value="???????????????" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionVideoPop', 'how', 'width=590,height=410,scrollbars=1')";>????????? ???????????????</button>
	                                        </span>
	                                        <br/><br/>
	                                        <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '454' && locale=='ko'">
	                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/currentAuction?sale_kind=online_only&sale_no=455')"; >????????? ?????? ????????? ????????????</button>
	                                            </span>
	                                            <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '455' && locale=='ko'">
	                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/currentAuction?sale_kind=online_only&sale_no=454')"; >7??? ????????? ????????????</button>
	                                            </span>
	                                        </div>-->  
										</div>
		                                 
		                                <!-- ????????? ?????? ?????? ??? ???????????? ?????? -->        
										<div ng-if="sale.LIVE_BID_YN == 'Y' && viewId == 'CURRENT_AUCTION' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">       
											<div class="livebid_page" ng-if="sale_status == 'ING' && nowTime < liveEnd">          
			                                	<div class="livebid_pageback">   
			                                		<!-- ?????? ?????? ??? ???????????? ???????????? -->  
			                                		<span>    
				                                		<a ng-if="is_login == 'false'" class="livebid_page_btn" href="" alt="????????? ????????? ??????" onClick="alert('????????? ??? ??????????????????.\n Please login for use.')">      
				                                			<c:if test="${locale == 'ko'}">  
				                                				<span class="livebid_pageback_txt">????????? ????????? ??????</span>  
				                                			</c:if>    
				                                			<c:if test="${locale != 'ko'}">    
				                                				<span class="livebid_pageback_txt" style="font-size: 16px;">Online live Apply</span>    
				                                			</c:if>   
														</a> 
				                                		<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN == 'Y' && padd_no == 0" class="livebid_page_btn" href="" alt="????????? ????????? ??????" ng-click="paddleAdd(sale.SALE_NO)">     
				                                			<c:if test="${locale == 'ko'}">  
				                                				<span class="livebid_pageback_txt">????????? ????????? ??????</span>  
				                                			</c:if>    
				                                			<c:if test="${locale != 'ko'}">    
				                                				<span class="livebid_pageback_txt" style="font-size: 16px;">Online live Apply</span>    
				                                			</c:if>   
														</a> 
														<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN != 'Y'" class="livebid_page_btn" href="" alt="????????? ????????? ??????" onClick="alert('???????????? ?????? ???????????????.\n Only Subscription Member can bid.')">   
				                                			<c:if test="${locale == 'ko'}">
				                                				<span class="livebid_pageback_txt">????????? ????????? ??????</span>    
				                                			</c:if>  
				                                			<c:if test="${locale != 'ko'}">  
				                                				<span class="livebid_pageback_txt" style="font-size: 16px;">BidLive Apply</span>   
				                                			</c:if>  
														</a>   
														<!-- ???????????? ?????? ????????? ??? ???????????? ?????? -->
														<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN == 'Y' && padd_no > 0" class="livebid_page_btn"  alt="PADD NO. {{padd_no}}" style="cursor:default;">     
				                                			<span class="livebid_pageback_txt">PADD NO. {{padd_no}}</span>
														</a>  
			                                		</span> 
			                                	</div> 
			                                </div>
			                                <div class="livebid_page" ng-if="sale_status == 'ING' && nowTime == liveEnd && liveCheckDt < liveStartDt && padd_no > 0">            
			                                	<div class="livebid_pageback">        
			                                		<!-- ?????? ?????? ???????????? ?????? -->           
		<!-- 									<p style="color:#00acac;">nowTime : {{nowTime}} / liveEnd : {{liveEnd}}</p> -->
		<!-- 									<p style="color:#00acac;">liveCheckDt : {{liveCheckDt}} / liveStartDt : {{liveStartDt}}</p> -->
			                                		<span>  
			                                			<a class="livebid_page_btn"  alt="PADD NO. {{padd_no}}" style="cursor:default;">     
				                                			<span class="livebid_pageback_txt">PADD NO. {{padd_no}}</span>
														</a>  
			                                		</span>   
			                                	</div>
			                                </div>
			                                <div class="livebid_page" ng-if="sale_status == 'ING' && liveCheckDt >= liveStartDt">             
			                                	<div class="livebid_pageback"> 
			                                		<!-- ?????? ?????? ???????????? ???????????? -->           
			                                		<span> 
			                                			<a ng-if="custInfo.MEMBERSHIP_YN == 'Y'" class="livebid_page_btn" target="_blank"  href="/service/page?view=bidLive_memberNew&sale_no={{sale.SALE_NO}}" alt="????????? ????????? ??????">
			                                				<c:if test="${locale == 'ko'}"><span class="livebid_pageback_txt">????????? ????????? ??????<br><p ng-if="padd_no > 0">PADD NO. {{padd_no}}</p></span></c:if> 
		                              						<c:if test="${locale != 'ko'}"><span class="livebid_pageback_txt" style="font-size: 16px;">Online live bid<br><p ng-if="padd_no > 0">PADD NO. {{padd_no}}</p></span></c:if>  
			                                			</a> 
			                                			<a ng-if="custInfo.MEMBERSHIP_YN != 'Y'" class="livebid_page_btn" target="_blank"  href="/service/page?view=bidLive_all&sale_no={{sale.SALE_NO}}" alt="????????? ????????? ??????">
		                              						<c:if test="${locale == 'ko'}"><span class="livebid_pageback_txt">????????? ????????? ??????</span></c:if> 
		                              						<c:if test="${locale != 'ko'}"><span class="livebid_pageback_txt" style="font-size: 16px;">Online live bid</span></c:if>     
														</a>  
			                                		</span>   
			                                	</div><!-- //livebid_pageback -->       
			                                </div> <!-- //livebid_page -->
			                            </div>  
									</div> 
								</div>
							</li> 
						</ul>
					</div>   
				</div>
                
				<!-- ?????? -->
				<div class="contents">
					<!--<button ng-if="viewId == 'CURRENT_AUCTION'" class="sp_btn btn_up">
						<span class="hidden"><spring:message code="label.move.top" /></span>
					</button>-->
					<div class="ex_title type02" ng-if="viewId != 'SEARCH'"> 
						<div class="title"> 
							<div class="tit">
								<span class="num" ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0" ng-bind="sale.SALE_TH | localeOrdinal"></span>
								<span ng-bind="sale.TITLE_JSON[locale]"></span>
								<!-- <span ng-if="viewId == 'CURRENT_AUCTION' && sale_status == 'ING' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status = 'END'">?????? LOT : <span ng-bind="curr_lot_no"></span></span> -->
							</div>
							<div class="sub lotlist_memobox">
                                <%-- ????????? ?????? ?????? ?????? ?????? --%>
                                <p ng-if="locale != 'ko'" style="font-weight:600;"> 
                                	<span style="font-weight:600; color: #00acac;">AUCTION : </span>
                                	<span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'(EEE) d MMM, yyyy h:mm a' : 'UTC+9' | lowercase)+' '+base_timezone"></span>
                                    <span ng-if="sale.SALE_KIND_CD == 'hongkong'" ng-bind="'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a' : 'UTC+9' | lowercase)+' '+sub_timezone+')'"></span>
                                </p> 
                                <p ng-if="locale == 'ko'" style="font-weight:600;">
                                	<span style="font-weight:600; color: #00acac;">??? ??? : </span>   
                                	<span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d' : 'UTC+9' | lowercase)+'('+getWeek(sale.TO_DT)+')'+(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'h:mm a' : 'UTC+9')+' '+base_timezone"></span>
                                    <span ng-if="sale.SALE_KIND_CD == 'hongkong'" ng-bind="'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a' : 'UTC+9' | lowercase)+' '+sub_timezone+')'"></span>
                                </p>
                                <!-- <p>
                                	<span ng-if="viewId == 'CURRENT_AUCTION' && sale_status == 'ING' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.FROM_DT > db_now" ng-bind="db_now | timeDuration : sale.TO_DT" style="font-weight:600;"></span>
                                </p> -->             
                                <!-- <p> -->
                                	<!-- VENUE ????????? ?????? ???????????? ???????????? -->  
                               		<!-- <span ng-if="viewId == 'CURRENT_AUCTION' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1" style="font-weight:600;">
                               			<span style="font-weight:600; color: #00acac;">  
                               				VENUE : 
                               			</span> 
                               		</span> -->      
                               		<!-- <span ng-bind="sale.PLACE_JSON[locale]" style="font-weight:600;"></span>  -->
                                <!-- </p> -->
                                <!-- <p>
                               		<span ng-if="viewId == 'CURRENT_AUCTION' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.TO_DT < db_now" style="font-weight:600;">?????? LOT : <span ng-bind="curr_lot_no" style="font-weight:600; color:#00acac;"></span></span> 
                                </p> --> 
                                <!-- <span ng-bind="sale.PLACE_JSON[locale]"></span> -->
                                <!-- <div style="padding-top:8px;"></div> -->  
                                <p>
                                	<span ng-bind-html="sale.NOTICE_JSON[locale]"></span>
                                </p>  
                                <!--??????--> 
                                <!-- <span ng-if="sale.SALE_KIND_CD == 'hongkong'">
	                                 <span ng-if="locale == 'ko'" style="font-weight:600;">* ?????? ?????? ?????? ????????? ??? ???????????? : ???????????? ??? ??????????????? ?????? ????????? ??????????????????. ????????? ?????? ?????? ?????? ???????????? ??????????????? ????????? ???????????? ????????? ????????? ?????? ?????? ??? ?????? ????????? ?????? ????????? ??????????????????. ????????? ??? ?????? ?????? ???????????? ???????????? ????????? ?????? ?????? ????????? ?????? ????????? ????????? ????????? ????????? ????????????.</span>
                                      <span ng-if="locale != 'ko'"><font style="font-weight:600;">* Currency indication of the estimated price and the payment : </font>All bids and payment will be in <font style="font-weight:600;">Hong Kong Dollars (HKD)</font>. Multi-currency pricing is for reference only and all bid payment shall be in HKD.. Also, we will not take responsibility for any problems that occur during the calculation of currency exchange rates</span>
                                      <span ng-if="locale != 'ko'"><br />E-mail saplus@seoulauction.com</span>
                                </span>
                                ??????
                                <span ng-if="sale.SALE_KIND_CD != 'hongkong' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1" >
	                                 <span ng-if="locale == 'ko'">* ???????????????: 15%??? (????????? ??????) </span>
                                     <span ng-if="locale == 'ko' && sale.SALE_NO == '401' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600;"> / ??????????????? ?????????</span>
	                                 <span ng-if="locale == 'ko'"><br />* ????????? ?????? ????????? ?????? ??? ?????? ?????? ?????? ????????? ??????, ?????? ???????????? ?????? ????????? ???????????? ????????????.</span>
                                     <span ng-if="locale != 'ko'">E-mail info@seoulauction.com</span>
                                </span>  
                                ?????????
                                <span ng-if="sale.SALE_KIND_CD != 'hongkong' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.SALE_NO == '463'" >
                                     <span ng-if="locale == 'ko'">* ???????????????: 18% (????????? ??????)</span>
                                     <span ng-if="locale == 'ko'"><br />* 'Lot.?????? 1~8 ????????? ???????????? ?????? ???????????? ???????????? ????????????.</span>
                                     <span ng-if="locale != 'ko'">* Buyer???s Premium: 18% (VAT excluded)</span>
                                     <span ng-if="locale != 'ko'"><br/>* Lot.1-8, 78-87, 122-133 will not be guaranteed.</span>                          
                                     <span ng-if="locale != 'ko'"><br/>* E-mail info@seoulauction.com</span>
                                </span> --> 

                                <!--<span ng-if="sale.SALE_KIND_CD != 'hongkong'">
	                                 <br/><span ng-if="locale == 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60">????????? ???????????????. ????????? ????????? ?????? ???????????? ???????????????.<br/>?????? ????????? ?????? ???????????? ????????? ????????????. </span>
	                                 
                                     <br/><span ng-if="locale != 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60"">TEST AUCTION. Even if you make a bid, it doesn't really matter.</span>
                                </span>-->  
                                <dl style="padding-top:15px; padding-bottom:20px;">  
                                    <div class="btns">   
                                     	<!-- Preview ?????? ?????? (?????? ????????????. 2020.12.12 ???2????????????)  
                                        <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn != 'Y'">
                                        	<button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="PREVIEW" value="PREVIEW" align="center" scrolling="no" onClick="window.open('${contextPath}/upcomingAuction?sale_kind=${SALE_KIND_CD}&sale_no=${SALE_NO}')";>PREVIEW</button>
                                        </span> -->  
                                           
                                        <!-- Notice ?????? ?????? -->  
                                        <!--  <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_KIND_CD == '000'">
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_KIND_CD == '000'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/noticeView?write_no=2895')"; >NOTICE</button>
                                        </span>
                                        <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '000'">
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '000'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/noticeView?write_no=3396')"; >NOTICE</button>     
                                        </span>     
                                          
                                        <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '422'">
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '422'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=4287')"; >NOTICE</button>     
                                        </span> 
                                        -->  
                                        
                                        <!-- Notice ?????? ?????? ?????? -->
                                        <span class="btn_style01 dark" ng-if="sale.WRITE_NO > 0"> 
                                            <button type="button" name="NOTICE" value="NOTICE" align="center" scrolling="no" ng-click="openNotice(sale.WRITE_NO)" >NOTICE</button>          
                                        </span> 
                                         
                                       	<!-- EXHIBITION ?????? ??????(VR) --> 
                                        <!-- ?????? EXHIBITION  
                                        <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '566'">
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_hk')"; >EXHIBITION</button> 
                                        </span> -->
                                        
                                        <!-- ????????? EXHIBITION 
                                        <span class="btn_style01 dark" ng-if="sale.SALE_NO == '562'">
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/VR/')"; >EXHIBITION</button>  
                                        </span> -->
                                        
                                         <!-- ????????? EXHIBITION 
                                        <span class="btn_style01 dark" ng-if="sale.SALE_NO == '563'"> 
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_online2')"; >EXHIBITION</button> 
                                        </span> -->
                                        
                                        <!-- ?????? ?????? EXHIBITION 
                                       	<span class="btn_style01 dark" ng-if="sale.SALE_NO == '562'">
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auction360VRPop_online2')"; >VR Video</button>   
                                        </span> -->  
                                        
                                        <!-- e-book ?????? ??????  -->       
                                            <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '681'">  
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '681'" name=" CATALOGUE" value=" CATALOGUE" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/e-book/164th/index.html')">CATALOGUE</button>                  
                                            </span>   
                                          
                                         <!-- ??????????????? ?????? ?????? 
                                         <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '569'">  
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '569'" name="ARTIST VIEW" value="ARTIST VIEW" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/zerobaseArtist')"; >ARTIST VIEW</button>  
                                        </span> -->   
                                        
                                        <!-- ????????? ???????????? -->        
                                        <span class="btn_style01 orange01" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y' && sale.SALE_NO == '667'">     
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'" name="Artsy" value="Artsy" align="center" scrolling="no" onClick="window.open('https://www.artsy.net/auction/artsy-x-seoul-auction-mixed-media-1')";>   
                                                <span ng-if="locale != 'ko'">Artsy Bid</span>  
                                                <span ng-if="locale == 'ko'">????????? ??????</span> 
                                             </button>     
                                        </span> 
                                        
                                        <!-- ????????? ????????????(2??? ?????? ?????? ???) -->                     
                                        <!-- <span class="btn_style01 orange01" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y' && sale.SALE_NO != '667'">      
                                            <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'" name="Artsy" value="Artsy" align="center" scrolling="no" onClick="window.open('https://www.artsy.net/auction/artsy-x-seoul-auction-mixed-media')"; >  
                                                <span ng-if="locale != 'ko'">Artsy Bid</span>  
                                                <span ng-if="locale == 'ko'">????????? ??????</span>   
                                             </button>     
                                        </span> --> 
                                          
                                        <!-- ????????? ??????(???????????????) -->
                                        <!-- <span class="btn_style01 orange01">
                                              <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="AUCTION LIVE" value="AUCTION LIVE" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')"; >AUCTION LIVE</button>
										</span> -->
								
										<!-- ??????????????? ??????????????? ??????(???????????????)     
		                                      <span class="btn_style01 orange01">  
		                                              <button type="button" ng-if="custInfo.MEMBERSHIP_YN == 'Y' || custInfo.FORE_BID_YN == 'Y' || custInfo.EMP_GB == 'Y'" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=bidLivePop')"; ><span ng-if="locale=='ko'">Live ??????</span><span ng-if="locale!='ko'">Live biding</span></button>
												<button type="button" ng-if="custInfo.MEMBERSHIP_YN != 'Y' && custInfo.EMP_GB != 'Y' && custInfo.FORE_BID_YN != 'Y'" align="center" scrolling="no" onClick="alert('???????????? ?????? ???????????????.')" ><span ng-if="locale=='ko'">Live ??????</span><span ng-if="locale!='ko'">Live biding</span></button>
										</span> -->   
										
	                                    <!--<span class="btn_style01 orange01"  ng-if="sale.SALE_NO == '452' && locale=='ko'">
	                                        <button type="button" name="???????????????" value="???????????????" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionVideoPop', 'how', 'width=790,height=700,scrollbars=1')";>????????? ???????????????</button>
	                                    </span>-->
								    </div>
								</dl>  
							</div>  
							  
                            <div class="butt livebid_pagebox clearfix">   
                                <!-- ????????? ?????? ?????? ??? ???????????? ?????? -->      
								<div ng-if="sale.LIVE_BID_YN == 'Y' && viewId == 'CURRENT_AUCTION' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">           
									<div class="livebid_page" ng-if="sale_status == 'ING' && nowTime < liveEnd">          
	                                	<div class="livebid_pageback">    
	                                		<!-- ?????? ?????? ??? ???????????? ???????????? -->      
	                                		<span>      
		                                		<a ng-if="is_login == 'false'" class="livebid_page_btn" href="" alt="????????? ????????? ??????" onClick="alert('????????? ??? ??????????????????.\n Please login for use.')">      
		                                			<c:if test="${locale == 'ko'}">  
		                                				<span class="livebid_pageback_txt">????????? ????????? ??????</span>  
		                                			</c:if>     
		                                			<c:if test="${locale != 'ko'}">    
		                                				<span class="livebid_pageback_txt" style="font-size: 16px;">Online live Apply</span>    
		                                			</c:if>   
												</a> 
		                                		<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN == 'Y' && padd_no == 0" class="livebid_page_btn" href="" alt="????????? ????????? ??????" ng-click="paddleAdd(sale.SALE_NO)">     
		                                			<c:if test="${locale == 'ko'}">  
		                                				<span class="livebid_pageback_txt">????????? ????????? ??????</span>  
		                                			</c:if>    
		                                			<c:if test="${locale != 'ko'}">    
		                                				<span class="livebid_pageback_txt" style="font-size: 16px;">Online live Apply</span>    
		                                			</c:if>    
												</a> 
												<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN != 'Y'" class="livebid_page_btn" href="" alt="????????? ????????? ??????" onClick="alert('???????????? ?????? ???????????????.\n Only Subscription Member can bid.')">   
		                                			<c:if test="${locale == 'ko'}">
		                                				<span class="livebid_pageback_txt">????????? ????????? ??????</span>     
		                                			</c:if>  
		                                			<c:if test="${locale != 'ko'}">  
		                                				<span class="livebid_pageback_txt" style="font-size: 16px;">BidLive Apply</span>   
		                                			</c:if>    
												</a>      
												<!-- ???????????? ?????? ????????? ??? ???????????? ?????? -->
												<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN == 'Y' && padd_no > 0" class="livebid_page_btn"  alt="PADD NO. {{padd_no}}" style="cursor:default;">     
		                                			<span class="livebid_pageback_txt">PADD NO. {{padd_no}}</span>
												</a>      
	                                		</span>
	                                	</div><!-- //livebid_pageback --> 
	                                </div>	<!-- //livebid_pageback --> 
	                                <div class="livebid_page" ng-if="sale_status == 'ING' && nowTime == liveEnd && liveCheckDt < liveStartDt && padd_no > 0">            
	                                	<div class="livebid_pageback">        
	                                		<!-- ?????? ?????? ???????????? ?????? -->          
<!-- 									<p style="color:#00acac;">nowTime : {{nowTime}} / liveEnd : {{liveEnd}}</p> -->
<!-- 									<p style="color:#00acac;">liveCheckDt : {{liveCheckDt}} / liveStartDt : {{liveStartDt}}</p> -->
	                                		<span>   
	                                			<a class="livebid_page_btn" ng-if="padd_no > 0" alt="PADD NO. {{padd_no}}" style="cursor:default;">     
		                                			<span class="livebid_pageback_txt">PADD NO. {{padd_no}}</span> 
												</a>     
<%-- 												<a class="livebid_page_btn" ng-if="padd_no <= 0" alt="" style="cursor:default;">      --%>
<!-- 		                                			<span>?????? ?????? ??????</span> -->
<!-- 												</a> -->
	                                		</span>   
	                                	</div><!-- //livebid_pageback -->       
	                                </div> <!-- //livebid_page -->   
	                                <div class="livebid_page" ng-if="sale_status == 'ING' && liveCheckDt >= liveStartDt">            
	                                	<div class="livebid_pageback">         
	                                		<!-- ?????? ?????? ???????????? ???????????? -->          
	                                		<span>  
	                                			<a ng-if="custInfo.MEMBERSHIP_YN == 'Y'" class="livebid_page_btn" target="blank" href="/service/page?view=bidLive_memberNew&sale_no={{sale.SALE_NO}}" alt="????????? ????????? ??????">
	                                				<c:if test="${locale == 'ko'}"><span class="livebid_pageback_txt">????????? ????????? ??????<p ng-if="padd_no > 0">PADD NO. {{padd_no}}</p></span></c:if> 
                              						<c:if test="${locale != 'ko'}"><span class="livebid_pageback_txt" style="font-size: 16px;">Online live bid<br><p ng-if="padd_no > 0">PADD NO. {{padd_no}}</p></span></c:if>    
	                                			</a> 
	                                			<a ng-if="custInfo.MEMBERSHIP_YN != 'Y'" class="livebid_page_btn" target="blank" href="/service/page?view=bidLive_all&sale_no={{sale.SALE_NO}}" alt="????????? ????????? ??????">
                              						<c:if test="${locale == 'ko'}"><span class="livebid_pageback_txt">????????? ????????? ??????</span></c:if> 
                              						<c:if test="${locale != 'ko'}"><span class="livebid_pageback_txt" style="font-size: 16px;">Online live bid</span></c:if>      
												</a> 
	                                		</span>   
	                                	</div><!-- //livebid_pageback -->       
	                                </div> <!-- //livebid_page -->   
								</div> 
								
								<!-- ?????? ?????? ?????? -->
                                <span class="btn_style01 gray02" ng-if="custInfo.CUST_NO && sale_status != 'ING' && locale != 'ko'">
									<button type="button" onClick="location.href='/saleLot_Result?sale_no=${SALE_NO}'">Result List</button>
                               	</span>
                               	<div class="bidlive_notice"> 
                                    <a href="#lorem" target="_modal" class="button white" style="margin-right: 6px;" id="liveBidInfoCheck"></a>
                                </div> 
                                
                                <div id="lorem" style="display:none" class="modally-init" modally-max-width="1000"> 
                                    <h1 class="modal-title" id="liveBidContents"></h1>  
                                    <p> 
                                    	 ????????? ????????? ????????? ????????? ???????????????.<br>   
						                                     ?????? ??????????????? ??????  > ??????  > ????????? ????????????.<br>        
						                                     ???????????? ????????? ????????? ?????? ??? ?????????, ?????? ????????? ???????????? ??????????????? ?????????????????? ????????????.<br>   
						                                     ???????????? <span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'h' : 'UTC+9' | lowercase)"></span>????????? ????????? ????????? ????????? ???????????????. 
                                    </p>  
                                </div><!-- ?????? ?????? ?????? --> 
                           	</div><!-- //butt livebid_pagebox -->
						</div>
						 
						<!--????????? more -->
				 		<div class="more web_only" align="center">
                        <!--?????????LIVE Web-->
					    <!-- <button ng-if="viewId == 'CURRENT_AUCTION'" name="AUCTION LIVE" value="AUCTION LIVE" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')"; style="width:65px;margin-bottom:5px;">
                             <span ng-if="locale == 'ko'" style="width:65px;" ><img src="/images/bg/bg_img33_s.png" alt="CATALOG"><br/><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">???????????????</p></span>   
                             <span ng-if="locale != 'ko'" style="width:65px;" ><img src="/images/bg/bg_img33_s.png" alt="CATALOG"><br/><p style="color:#ccc;font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">LIVE</p></span> 
                        </button><br/>-->
                        <!--?????????LIVE-->
                        <!--?????????VIDEO-->
					    <!--<button ng-if="viewId == 'CURRENT_AUCTION'" name="AUCTION VIDEO" value="AUCTION VIDEO" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionVideoPop', 'how', 'width=610,height=505,scrollbars=1')"; style="width:65px;margin-bottom:5px;">
                             <span ng-if="locale == 'ko'" style="width:65px;" ><img src="/images/bg/bg_img33_s.png" alt="CATALOG"><br/><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">VIDEO ??????</p></span>   
                             <span ng-if="locale != 'ko'" style="width:65px;" ><img src="/images/bg/bg_img33_s.png" alt="CATALOG"><br/><p style="color:#ccc;font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">VIDEO</p></span>
                          </button><br/>
                        -->
                        <!--?????????VIDEO--> 

	                        <!--<span ng-if="sale.SALE_NO == '413' && viewId == 'CURRENT_AUCTION'">-->
	                        <span ng-if="sale.SALE_NO == '423' && viewId == 'CURRENT_AUCTION'">
	                            <!--PREVIEW-->
	                         	<a href="https://www.seoulauction.com/upcomingAuction" target="_parent" style="width:65px;margin-top:5px;">
	                               <span style="width:65px;" ><img src="/images/bg/bg_img32_s.png" alt="Preview"><br/><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">PREVIEW</p></span>   
	                         	</a><br /> 
	                         	<!---->
	                         	<!--PREVIEW-->
	                            <!--3D VR
	                         	<a href="https://www.seoulauction.com/service/page?view=auction360VRPop" target="new" style="width:65px;margin-top:5px;">
	                               <span style="width:65px;" ><img src="/images/bg/bg_img32_s.png" alt="Preview"><br/><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">EXHIBITION</p></span>   
	                         	</a><br />-->
	                         	<!--3D VR--->
	                            <!----> 
	                            <a href="/nas_img/front/homepage/148-Modern.pdf" target="new" style="width:65px;margin-top:5px;">
		                          	<span ng-if="locale == 'ko'" style="width:65px;" ><img src="/images/bg/bg_img31_s.png" alt="CATALOG"><br /><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">???????????????</p></span>  
		                            <span ng-if="locale != 'ko'" style="width:65px;" ><img src="/images/bg/bg_img31_s.png" alt="CATALOG"><br /><p style="color:#ccc;font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">CATALOGUE-A</p></span> 
	                          	</a>  
	                            <br />   
	                            <a href="/nas_img/front/homepage/148-korean.pdf" target="new" style="width:65px;margin-top:5px;">
		                          	<span ng-if="locale == 'ko'" style="width:65px;" ><img src="/images/bg/bg_img31_s.png" alt="CATALOG"><br /><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">???????????????</p></span>  
		                            <span ng-if="locale != 'ko'" style="width:65px;" ><img src="/images/bg/bg_img31_s.png" alt="CATALOG"><br /><p style="color:#ccc;font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">CATALOGUE-B</strong></p></span> 
	                          	</a> 
	                          	<br /> 
		                        <!--  <span ng-if="locale == 'ko'" style="width:65px;" ><a href="https://www.seoulauction.com/noticeList" target="_parent" style="width:80px;margin-top:5px;"> 
		                          	<img src="/images/bg/bg_img09_s.png" alt="CATALOG"><br/><p style="color:#ccc; font-size:11px;font-weight:600; padding-top:3px; padding-bottom:3px;">????????????</p>
		                        </a></span> 
		                        <span ng-if="locale != 'ko'" style="width:65px;" ><a href="https://www.seoulauction.com/noticeList" target="_parent" style="width:80px;margin-top:5px;">
		                          	<img src="/images/bg/bg_img09_s.png" alt="CATALOG"><br/><p style="color:#ccc; font-size:11px;font-weight:600; padding-top:3px; padding-bottom:3px;">NOTICE</p>
		                        </a></span> --> 
	                     	</span>
						</div> 
                    	<!--????????? more --> 
					</div> <!--ex_title type02--> 
					
					<!--???????????????. ?????????????????? ?????????????????? ?????? ?????????.-->    
	                <div class="col12 web_only" ng-if="locale!='ko' && highlight.length > 0 " align="center" style="border-top:#666 1px solid; overflow: hidden; padding: 10px 0;">
	                    <h2 style="padding: 10px 0; font-weight:900; font-size:25px; padding-bottom: 30px;">SALE HIGHLIGHTS</h2>
		                <!-- <div style="display:inline;float:left; margin-top:100px;"> 
		                        <button type="button" ng-click="naviMove(-1);"><img src="/images/btn/btn_next_left.png" alt="btn_next_left"></button> 
		                </div>  -->   
	                <div class="hightlightwrap">                      
                        <ul>  
                            <li ng-repeat="naviList in highlight" class="hightlightbox">                                   
                                <div class="hightlight_imgbox">     
	                                <a ng-href="{{'/lotDetail?sale_no=' + naviList.SALE_NO + '&lot_no=' + naviList.LOT_NO}}" target="new">
	                                    <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{naviList.FILE_NAME | imagePath1 : naviList.FILE_PATH : 'detail'}}" /> 
	                                </a>  
                                </div>
 
                                <div class="hightlight_infobox txt-over"> 
                                	<p class="txt-over" style="font-weight: 900;"> 
                                		<span ng-bind="naviList.LOT_NO" title="{{naviList.LOT_NO}}"></span>
                                	</p>      
                                    <p class="txt-over" ng-bind="naviList.ARTIST_NAME_JSON.en" title="{{naviList.ARTIST_NAME_JSON.en}}" style="font-weight: bold; font-size: 16px; padding-bottom: 10px; height: 21px;"></span>  
                                    <p class="txt-over" ng-bind="naviList.TITLE_JSON.en" title="{{naviList.TITLE_JSON.en}}" style="height: 21px;"></span>     
                                    <p class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD == null && naviList.EXPE_PRICE_FROM_JSON.KRW == null && naviList.EXPE_PRICE_FROM_JSON.USD == null" title="Estimate on Request">Estimate on Request</span> 
                                    <p class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD != null && naviList.EXPE_PRICE_FROM_JSON.KRW != null && naviList.EXPE_PRICE_FROM_JSON.USD != null" ng-bind="base_currency" ng-bind="base_currency"></span>
                                    <p class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD != null && naviList.EXPE_PRICE_FROM_JSON.KRW != null && naviList.EXPE_PRICE_FROM_JSON.USD != null && base_currency == 'HKD'"><span ng-bind="naviList.EXPE_PRICE_FROM_JSON.HKD | number : 0" style="margin-right:5px;"></span> ~ <span ng-bind="naviList.EXPE_PRICE_TO_JSON.HKD | number : 0" style="margin-right:5px;"></span></span>  
                                    <p class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD != null && naviList.EXPE_PRICE_FROM_JSON.KRW != null && naviList.EXPE_PRICE_FROM_JSON.USD != null && base_currency == 'KRW'"><span ng-bind="naviList.EXPE_PRICE_FROM_JSON.KRW | number : 0" style="margin-right:5px;"></span> ~ <span ng-bind="naviList.EXPE_PRICE_TO_JSON.KRW | number : 0" style="margin-right:5px;"></span></span> 
                                    <p class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD != null && naviList.EXPE_PRICE_FROM_JSON.KRW != null && naviList.EXPE_PRICE_FROM_JSON.USD != null && base_currency == 'USD'"><span ng-bind="naviList.EXPE_PRICE_FROM_JSON.USD | number : 0" style="margin-right:5px;"></span> ~ <span ng-bind="naviList.EXPE_PRICE_TO_JSON.USD | number : 0" style="margin-right:5px;"></span></span> 
                                    <p class="txt-over highlight_price" ng-if="naviList.STAT_CD != 'reentry' && naviList.BID_PRICE > 0" ng-bind="sale.CURR_CD"></span>      
                                </div> 
                            </li>   
                        </ul> 
	                </div> 
	                <!-- <div style="display:inline; float:right; margin-top:100px; overflow:visible;"> 
	                        <button type="button" ng-click="naviMove(+1);"><img src="/images/btn/btn_next_right.png" alt="btn_next_right"></button> 
	                </div> --> 
	                </div>   
                	<!--???????????????--> 
                	
                	<div style="clear:both"></div><!--clear-->
                	
					<div ng-if="viewId == 'SEARCH'" class="tit_h2">
						<h2><spring:message code="label.search" /></h2>
					</div> 
					<form name="pageForm" method="get">
						<fieldset>
							<legend><spring:message code="label.search" /></legend>
							<%@ include file="./include/filterLotListL.jsp" %> 
						</fieldset>  
                        
                        <div class="list-category auction-list-category">       
                            <span ng-click="checkCateAll();" ng-class="{true: 'list-category-a', false: 'list-category-b'}['all' == selected_cate]" ng-if="locale=='ko'"><a href="#" >??????</a> </span>
                            <span ng-click="checkCateAll();" ng-class="{true: 'list-category-a', false: 'list-category-b'}['all' == selected_cate]" ng-if="locale!='ko'"><a href="#" >All</a> </span>
    <!--CATEGORY-->			<span ng-repeat="cate in category" class="standard" flex="50">
                                    <span ng-if="locale=='ko'" ng-click="cate_toggle(cate.CD_ID, cate_selected)" checklist-model="cate_cds" ng-class="{true: 'list-category-a', false: 'list-category-b'}[cate.CD_ID == selected_cate]"><a href="#" >{{cate.CD_NM}}</a></span>
                                    <span ng-if="locale!='ko'" ng-click="cate_toggle(cate.CD_ID, cate_selected)" checklist-model="cate_cds" ng-class="{true: 'list-category-a', false: 'list-category-b'}[cate.CD_ID == selected_cate]"><a href="#" class="list-category-b">{{cate.CD_NM_EN}}</a></span>  
                            </span>  
                            <span ng-repeat="hashtag in hashtag" class="standard" flex="50">  
                            	<span ng-if="locale=='ko'" ng-click="hashtag_toggle(hashtag.LOT_TAG, hashtag_selected)" checklist-model="hashtag_list"  ng-class="{true: 'list-category-a', false: 'list-category-b'}[hashtag.LOT_TAG == selected_cate]" ><a href="#" >{{hashtag.LOT_TAG}}</a></span> 
                            </span>   
                            <!-- ?????????????????? 
                            <span ng-if="is_login == 'false'"> 
                            	<span ng-if="locale=='ko'" onClick="alert('????????? ??? ????????? ??? ????????????.\n Please login for use.')" checklist-model="fav_cds_list"><a href="#" >??????????????????</a></span>
                            </span> 
                            <span ng-if="is_login == 'true'">
                            	<span ng-if="locale=='ko'" ng-click="fav_toggle( 1 , fav_selected)" checklist-model="fav_cds_list"><a href="#" >??????????????????</a></span>
                            </span>    -->   
                            <!-- ?????????????????? ????????? page -->   
							<div class="wish_btn wish_btn_right">     
								<span ng-if="is_login == 'false'">        
	                            	<span class="wish_btnko" ng-if="locale == 'ko'" onClick="alert('????????? ??? ????????? ??? ????????????.\n Please login for use.')" checklist-model="fav_cds_list" title="???????????? ??????">        
		                            	<span class="grid_wish_btn wish_btn_list">          
			                            </span> 
			                            <span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">     
		                            		???????????? ??????  
		                            	</span>   
		                            </span>      
	                            	<span class="wish_btnko" ng-if="locale != 'ko'" onClick="alert('????????? ??? ????????? ??? ????????????.\n Please login for use.')" checklist-model="fav_cds_list" title="WishList">    
			                            <span class="grid_wish_btn wish_btn_list">   
			                            </span>    
			                            <span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">    
		                            		WishList   
		                            	</span> 
		                            </span> 
		                        </span>
		                             
	                            <span ng-if="is_login == 'true'">      
	                            	<span class="wish_btnko" ng-if="locale == 'ko'" ng-click="fav_toggle( 1 , fav_selected)" checklist-model="fav_cds_list" title="???????????? ??????">           
		                            	<span class="grid_wish_btn wish_btn_list">   
		                            	</span>        
		                            	<span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">      
		                            		???????????? ??????   
		                            	</span>     
	                            	</span>  
	                            	
	                            	<span class="wish_btnko" ng-if="locale != 'ko'" ng-click="fav_toggle( 1 , fav_selected)" checklist-model="fav_cds_list" title="WishList">         
		                            	<span class="grid_wish_btn wish_btn_list"> 
		                            	</span> 
		                            	<span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">    
		                            		WishList  
		                            	</span>
	                            	</span>    
	                            </span>    
	                            
	                            <div ng-if="is_login == 'true' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_outside_yn == 'N'" class="wish_btn">           
	                           		<span class="my_bidlist" ng-click="openPageBlank('/customer/offlineBidReqList?sale_no='+sale.SALE_NO);" style="font-size: 12px; font-weight: bold; color: #999; vertical-align:text-top;">{{locale == 'ko' ? '????????? ?????? ??????' :  'Bidding List' }}</span>
	                            </div>     
							</div>     
							<!-- //?????????????????? ????????? page --> 
	                    </div>                     
						<!--<p class="flip">
								<span ng-if="locale == 'ko'" onClick="openNav()">&#9776; ??????????????????</span>
								<span ng-if="locale != 'ko'" onClick="openNav()">&#9776; Category Search</span></p>
							<div class="panel">
								<div class="side-toggle-menu">
                                    <div class="btn_style01 gray02" style="float:right;">
                                        <button type="button" ng-click="checkAcateAll()">
                                            <span ng-if="locale == 'ko'">???????????????</span>
                                            <span ng-if="locale != 'ko'">Clear</span>
                                        </button>
                                    </div> 
                                    
                                
                                    <a href="#">
                                        <span style="font-weight:bold" ng-if="locale == 'ko'">????????????</span>
                                        <span style="font-weight:bold" ng-if="locale != 'ko'">Category</span>
                                        <button type="button" ng-click="checkCateAll();">
                                            <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">??? ????????????</font></span>
                                            <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">??? Unchecked</font></span>
                                        </button>
                                    </a>
                                        
                                    <ul class="hide">
                                        <div ng-repeat="cate in category" class="standard" flex="50">
                                            <li style="margin:0 0 0 10px">
                                            <input type="checkbox" checklist-model="cate_cds" ng-checked="cate_exists(cate.CD_ID, cate_selected)" ng-click="cate_toggle(cate.CD_ID, cate_selected)" /> 
                                                <span ng-if="locale=='ko'">{{cate.CD_NM}}</span>
                                                <span ng-if="locale!='ko'">{{cate.CD_NM_EN}}</span>
                                            </li>
                                        </div>
                                    </ul>
                                    
                                  
                                    <a href="#">
                                        <span style="font-weight:bold" ng-if="locale == 'ko'">??????????????????</span>
                                        <span style="font-weight:bold" ng-if="locale != 'ko'">Sub Category</span>
                                        <button type="button" ng-click="checkScateAll();">
                                            <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">??? ????????????</font></span>
                                            <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">??? Unchecked</font></span>
                                        </button>
                                    </a>
                    
                                    <ul class="hide">
                                        <div ng-repeat="scate in subcategory" class="standard" flex="50">
                                            <li style="margin:0 0 0 10px">
                                            <input type="checkbox" checklist-model="scate_cds" ng-checked="scate_exists(scate.CD_ID, scate_selected)" ng-click="scate_toggle(scate.CD_ID, scate_selected)" />
                                                <span ng-if="locale=='ko'">{{scate.CD_NM}}</span>
                                                <span ng-if="locale!='ko'">{{scate.CD_NM_EN}}</span>
                                            </li>
                                        </div>
                                    </ul>
                                    
                              
                                    <a href="#">
                                        <span style="font-weight:bold" ng-if="locale == 'ko'">??????</span>
                                        <span style="font-weight:bold" ng-if="locale != 'ko'">Material</span>
                                        <button type="button" ng-click="checkMateAll();">
                                            <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">??? ????????????</font></span>
                                            <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">??? Unchecked</font></span>
                                        </button>
                                    </a>
                                        
                                    <ul class="hide">
                                        <div ng-repeat="mate in material" class="standard" flex="50">
                                            <li style="margin:0 0 0 10px">
                                            <input type="checkbox" checklist-model="mate_cds" ng-checked="mate_exists(mate.CD_ID, mate_selected)" ng-click="mate_toggle(mate.CD_ID, mate_selected)" />
                                                <span ng-if="locale=='ko'">{{mate.CD_NM_EN}}</span>
                                                <span ng-if="locale!='ko'">{{mate.CD_NM_EN}}</span>
                                            </li>
                                        </div>
                                    </ul>						
                                    
                                   
                                    <a href="#">
                                        <span style="font-weight:bold" ng-if="locale == 'ko'">?????????</span>
                                        <span style="font-weight:bold" ng-if="locale != 'ko'">Artist</span>
                                        <button type="button" ng-click="checkArtistAll();">
                                            <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">??? ????????????</font></span>
                                            <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">??? Unchecked</font></span>
                                        </button>
                                    </a>

                                    <ul class="hide">
                                        <div ng-repeat="art in artist" class="standard" flex="50">
                                            <li style="margin:0 0 0 10px">
                                            <input type="checkbox" checklist-model="artist_nos" ng-checked="art_exists(art.CD_ID, art_selected)" ng-click="art_toggle(art.CD_ID, art_selected)" />
                                                <span ng-if="locale=='ko'">{{art.CD_NM}}</span>
                                                <span ng-if="locale!='ko'">{{art.CD_NM_EN}}</span>
                                            </li>
                                        </div>
                                    </ul>
                                </div>
							</div>       -->             
						<!--CATEGORY-->

						<!-- <div class="tbl_top web_only mt0 t_tbl_top"> -->
						<div class="tbl_top web_only02 mt0 t_tbl_top"> <!-- m_ver paging ???????????? ?????? -->
							<div class="left">
								<div class="wrap_paging">
									<paging page="currentPage"
											page-size="pageRows"
											total="totalCount"
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
								<div class="lotCount">  
									<span class="tbl_label"><spring:message code="label.total.lots" arguments='{{totalCount}}' /></span>
								</div>
								<div class="view"> 
									<div class="fl_wrap">
										<!-- <span class="btn_style01 gray03">
											<button ng-if="list_timer_start" ng-click="cancelLotRefresh();"><span>???????????????????????? ???</span></button>
											<button ng-if="!list_timer_start" ng-click="runLotsRefresh();"><span>????????????????????????</span></button>
										</span> -->
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
								<div class="type" ng-if="sale_outside_yn == 'N'">
									<button type="button" class="sp_btn ver" ng-class="viewType=='LIST' ? 'sele' : ''" 
										onclick="location.href='/saleDetailTest?view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type=LIST&sale_kind=${SALE_KIND_CD}'">
										<span class="hidden"><spring:message code="label.list.vertical" /></span>
									</button>  
									<button type="button" class="sp_btn hor" ng-class="viewType=='GRID' ? 'sele' : ''" 
										onclick="location.href='/saleDetailTest?view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type=GRID&sale_kind=${SALE_KIND_CD}'">
										<span class="hidden"><spring:message code="label.list.horizontal" /></span>
									</button>  
								</div>
								<div class="type" ng-if="sale_outside_yn == 'Y'">
									<button type="button" class="sp_btn ver" ng-class="viewType=='LIST' ? 'sele' : ''" 
										onclick="location.href='/saleDetail?sale_outside_yn=Y&view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type=LIST&sale_kind=${SALE_KIND_CD}'">
										<span class="hidden"><spring:message code="label.list.vertical" /></span>
									</button>
									<button type="button" class="sp_btn hor" ng-class="viewType=='GRID' ? 'sele' : ''" 
										onclick="location.href='/saleDetail?sale_outside_yn=Y&view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type=GRID&sale_kind=${SALE_KIND_CD}'">
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
							<li ng-if="sale_outside_yn == 'N'" ng-repeat="lot in lotList" ng-init="lot_map[lot.LOT_NO] = lot;" on-finish-render-filters>
								<c:if test="${VIEW_TYPE == 'LIST'}">
									<jsp:include page="inc_lotList_List.jsp" flush="false"/>
								</c:if>
								<c:if test="${VIEW_TYPE == 'GRID'}">
									<jsp:include page="inc_lotList_Grid.jsp" flush="false"/>
								</c:if>
							</li>
							<li ng-if="sale_outside_yn == 'Y'" ng-repeat="lot in lotList" ng-init="lot_map[lot.LOT_NO] = lot;" on-finish-render-filters>
								<c:if test="${VIEW_TYPE == 'LIST'}">
									<jsp:include page="inc_outSide_List.jsp" flush="false"/>
								</c:if>
								<c:if test="${VIEW_TYPE == 'GRID'}">
									<jsp:include page="inc_outSide_Grid.jsp" flush="false"/>
								</c:if>
							</li>
						</ul>
					</div>
					<div style="display:none;">
						<span class="btn_style01 xlarge green02 btn_bid btn_modal pop01">
							<button type="button">??????????????????</button>
						</span>
						<span class="btn_style01 xlarge green02 btn_bid btn_modal pop02">
							<button type="button">????????????</button>
						</span>
						<span class="btn_style01 xlarge dark btn_bid btn_modal pop03">
							<button type="button">??????????????????</button>
						</span>
						<span class="btn_style01 xlarge dark btn_bid btn_modal pop13">
							<button type="button">?????????????????????</button>
						</span>
						<span class="btn_style01 xlarge dark btn_bid btn_modal pop11">
							<button type="button">???????????????</button>
						</span>
						<span class="btn_style01 gray02 btn_modal pop15">
							<button type="button">Become a Bidding Member</button>
						</span>
					</div>
					<div class="wrap_paging">
						<!-- S : paging ?????? -->
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
						<!-- E : paging ?????? -->
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
						<img src="/images/img/img_past.png" alt="??????1" class="img_master">
					</li>
				</ul>
		</div>
		</div>--> 
	</div>
</div>
<script type="text/javascript"> 

var slide_expe_start = 0;
var slide_expe_end = 0;
//$(document).ready(function(){
//	setUiSlider(min_expe_price, max_expe_price, min_expe_price, max_expe_price);
//});

//?????? ?????? ?????? ?????????

function setUiSlider(nEstimateStart, nEstimateEnd, nEstimateMin, nEstimateMax) {
	$("#estimatePriceStart").val(nEstimateStart);
	$("#estimatePriceEnd").val(nEstimateEnd);
	$("#estimateRange").noUiSlider({
		start: [nEstimateStart, nEstimateEnd],
		orientation: "horizontal",
		connect: true,
		step: 1000,
		range: {
			"min": nEstimateMin,
			"max": nEstimateMax
		}
	}, true);
	
	$("#estimateRange").on({
		slide: function(){
			var startPrice = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
			var endPrice = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];    	// ????????? ?????? ?????? 0~??????????????? ??????. YDH
			$("#rangeText").html(comma(parseInt(startPrice, 10)) + " ~ " + comma(parseInt(endPrice, 10)));
		},
		set: function(){
			slide_expe_start = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
			slide_expe_end = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];		// ????????? ?????? ?????? 0~??????????????? ??????. YDH
		},
		change: function(){
		}
	});
	
	$("#estimateRange").Link('lower').to($("#estimatePriceStart"));
	$("#estimateRange").Link('upper').to($("#estimatePriceEnd"));
	
	var startPrice = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
	var endPrice = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];							// ????????? ?????? ?????? 0~??????????????? ??????. YDH
	$("#rangeText").html(comma(parseInt(startPrice, 10)) + " ~ " + comma(parseInt(endPrice, 10)));
	slide_expe_start = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
	slide_expe_end = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];						// ????????? ?????? ?????? 0~??????????????? ??????. YDH
}

 
/* ????????????????????? ?????? ?????? */  
$(document).ready(function(){  
	$('#ipsum').modally('ipsum', {'max-width': 800});    
	$('#lorem').modally();   
});    


</script>

<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
