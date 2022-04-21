<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<spring:eval expression="@property['blacklot.router.domain']" var="blacklot" scope="request"/>

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
    
	var targetUrl = document.activeElement.href? document.activeElement.href : location.href; //이동하는 url가져오기
    if(targetUrl.indexOf("lotDetail") < 0){ //새로고침이 아니면서 lotDetail페이지가 아니면 쿠키 삭제
    	deleteCookie("reqRowCnt");
    	deleteCookie("sortBy");
    }

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
	
	var getSortBy = getCookie("sortBy");
	if(!getSortBy){
		getSortBy = "LOTAS";
	} else {
		getSortBy = getCookie("sortBy");
	}
	
	$scope.reqRowCnt = getRowCnt; // "20"
	$scope.sortBy = getSortBy; //LOTAS
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
	$scope.sale_outside_yn = (getParameter("sale_outside_yn") ? getParameter("sale_outside_yn") : "N");
	$scope.padd_info = null;
	
	$scope.selected_cate = 'all'; //카테고리 font color 작업

	$scope.reqRowCnts1 = {20:"<spring:message code='label.listup.lots' arguments='20' />",
						50:"<spring:message code='label.listup.lots' arguments='50' />",
						100:"<spring:message code='label.listup.lots' arguments='100' />"};
	$scope.reqRowCnts2 = {20:"<spring:message code='label.listup.lots' arguments='20' />",
			40:"<spring:message code='label.listup.lots' arguments='40' />",
			80:"<spring:message code='label.listup.lots' arguments='80' />"};

	

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
 			$scope.selected_cate = 'contemporary';
 		} else if( kindCategory == "trad" ) {
 			$scope.cate_list=['traditional'];
 			$scope.selected_cate = 'traditional';
 		} else {
 			$scope.cate_list = null;
 		}

 	}

 	$scope.loadSaleMenuList = function(){
//  		if(!$scope.sale_outside_yn){
//  			$scope.sale_outside_yn = "N";
//  		} 
 		$d = {"baseParms":{}, 
 				"actionList":[					/* "sort_by": 설정변경(2020.06.06 YDH)"DATAS" => SALENOASC. 참고로  sort_by 추가한 내용은 SALENOASC, SALENODESC임. */
 				{"actionID":"sale_list_paging", "actionType":"select" , "tableName": "SALES", "parmsList":[{"sale_kind_cd":$scope.sale_kind_cd, "status":$scope.sale_status, "sale_outside_yn": $scope.sale_outside_yn, "sort_by":"SALENOASC", "from":0, "rows":3}]}
 			]};   
 		
 	   	common.callActionSet($d, function(data, status) {
 	 	    $scope.saleMenuList = data["tables"]["SALES"]["rows"];
 	 	    
 	 	    if($scope.saleMenuList.length == 0){
 	 	    	if($scope.locale == 'ko')
 	 	    	{
 	 	    		alert("진행중인 경매가 없습니다");	
//  	 	    		alert("현재 준비중입니다.");	
 	 	    	}else{
					alert("There is no auctions going on currently")
//  	 	    		alert("It is currently being prepared.");
 	 	    	}
 	 			location.href="/";
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
 		if(!f) f = (locale == 'ko' ? 'd일 h시간 m분 s초' : 'd[Days] hh:mm:ss');  
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
 		$scope.setExpeSlide($scope.sale.CURR_CD);
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
		$scope.fav_selected = [];
		$scope.fav_cds_list = null;
		$scope.loadLotList(1);
 	}
 	
 	 $scope.changeViewType = function(type){
//  		 deleteCookie('sortBy');
//  		 deleteCookie('reqRowCnt');
 		 if($scope.sale_outside_yn == "Y"){//$scope.sale_outside_yn == true
 			location.href='/saleDetail?sale_outside_yn=Y&view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type='+type+'&sale_kind=${SALE_KIND_CD}'
 		 }else{
 			location.href='/saleDetail?view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type='+type+'&sale_kind=${SALE_KIND_CD}';
 		 }
 		 
 	 }
 	
 	$scope.loadLotList = function($page){
		 

		window.location.hash = '#page' + $page;
//  		if(!$scope.sale_outside_yn){
//  			$scope.sale_outside_yn = "N";
//  		}
 		
 		setCookie('sale_no', $scope.sale_no, 1);
//  		setCookie('page', $page, 1);
 		setCookie('reqRowCnt', $scope.reqRowCnt, 1);
		setCookie('sortBy', $scope.sortBy, 1);
 		 
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
 				{"actionID":"sale_info", "actionType":"select" , "tableName": "SALE"},
 				{"actionID":"exch_rate_list", "actionType":"select" , "tableName": "EXCH"},
 				{"actionID":"lot_list_count", "actionType":"select" , "tableName": "LOT_CNT" ,"parmsList":[{"for_count":true}]},
 			    {"actionID":"lot_list_paging", "actionType":"select" , "tableName": "LOTS" ,"parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt), "sale_outside_yn": $scope.sale_outside_yn, "sort_by":$scope.sortBy}]},
  				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
  				/* YBK.20170314.카테고리 추가 */
  				{"actionID":"saleLot_category", "actionType":"select", "tableName":"CATEGORY"},
  				{"actionID":"saleLot_subcategory", "actionType":"select", "tableName":"SUBCATEGORY"},
  				{"actionID":"saleLot_material", "actionType":"select", "tableName":"MATERIAL"},
  				{"actionID":"saleLot_artist", "actionType":"select", "tableName":"ARTIST"},
  				/* YBK.20170314.카테고리 추가 */
  				{"actionID":"saleLot_hashtag", "actionType":"select", "tableName":"HASHTAG"},
  				{"actionID":"saleHighlight_List", "actionType":"select", "tableName":"LOT_HIGHLIGHT"}, 
 			 ]};

 		
 		if(is_login == "true"){
	 		/* blueerr 20180810 회차 휴대폰 인증 정보 */
			$d.actionList.push({"actionID":"sale_cert_info", "actionType":"select", "tableName":"CERT"});
			/* blueerr 20180810 회차 휴대폰 인증 정보 */
			/* 패들번호 발급여부 체크 */
			$d.actionList.push({"actionID":"my_paddle_check", "actionType":"select", "tableName":"PADDLE_CHECK", "parmsList":[{}]});
 		}
 		
 	   	$d["actionList"][3]["parmsList"][0]["from"] = (($scope.currentPage - 1) * parseInt($scope.reqRowCnt)); 
 	   	common.callActionSet($d, function(data, status) {
	 	   	if(is_login == "true"){
			   	var padd_info = data["tables"]["PADDLE_CHECK"]["rows"][0];
			   	$scope.padd_no = padd_info == null? 0 : padd_info.PADD_NO;
	 	   	}
	 	   	
	 	   	if(data.tables.LOTS.rows.length != 0){
	 	   		$(".wrap_paging").show();	 					
	 		} else { $(".wrap_paging").hide(); }
		   	
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
 	 		$scope.highlight = data["tables"]["LOT_HIGHLIGHT"]["rows"];

			// 직원이 아니고, 오래된 경매일 경우, 막음
			if (typeof $scope.custInfo !== 'undefined') {
				if (typeof $scope.custInfo.EMP_GB !== 'undefined') {
					if ($scope.custInfo.EMP_GB === 'N' && $scope.sale.IS_OLD_SALE === 'Y') {
						window.alert('해당 경매는 조회가 불가능 합니다');
						window.history.back();
						return;
					}
				}
			}

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
 	 		// 오프라인 경매인 경우에는 SALE.TO_DT는 YYYY.MM.DD로 체크. 비교 서버시간은 S_DB_NOW_D (YDH. 2016.10.05)
 	 		// 온라인 경매인 경우에는 MAX(LOT.TO_DT) 기준으로 시분까지 체크. 비교 서버시간은 S_DB_NOW (YDH. 2016.10.05)
 	 		
 	 		//라이브 응찰 시간 체크
 	 		$scope.liveEnd = TO_DT;  
 	 		$scope.nowTime = S_DB_NOW_D;  
 	 		$scope.liveStartDt = LIVE_START_DT;
 	 		$scope.liveCheckDt = S_DB_NOW;   
 	 		
 	 		if(FROM_DT > S_DB_NOW && 
 	 				((['main','hongkong','plan'].indexOf($scope.sale.SALE_KIND_CD) > -1 && TO_DT > S_DB_NOW_D)	//$scope.sale.SALE_KIND_CD != 'online' 수정. 2019.12.12 YDH
 	 				|| (['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && END_DT > S_DB_NOW))	//$scope.sale.SALE_KIND_CD == 'online' 수정. 2019.12.12 YDH
 	 			){
 	 			$scope.sale_status = "READY";
 	 		}
 	 		else if(FROM_DT <= S_DB_NOW && 
					((['main','hongkong','plan'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.CLOSE_YN != 'Y')	//$scope.sale.SALE_KIND_CD != 'online' 수정. 2019.12.12 YDH
 	 				|| (['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && END_DT >= S_DB_NOW))		//$scope.sale.SALE_KIND_CD == 'online' 수정. 2019.12.12 YDH
				){
 	 			$scope.sale_status = "ING";
 	 			if(!$scope.now_timer_start){
 	 				console.log("duration timer start!!");
 	 	 	 		$scope.timer_duration = $interval(function(){$scope.db_now = moment($scope.db_now).add(1, 'seconds');}, 1000);
 	 	 	 		$scope.now_timer_start = true;
 	 			} 
 	 		}
 	 		else if((['main','hongkong','plan'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.CLOSE_YN == 'Y')	//$scope.sale.SALE_KIND_CD != 'online' 수정. 2019.12.12 YDH
 				|| (['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && END_DT < S_DB_NOW)){		//$scope.sale.SALE_KIND_CD == 'online' 수정. 2019.12.12 YDH
 	 			$scope.sale_status = "END";
 				
 	 			if(is_login == "false"){//마감되고 비로그인시
 	 				alert($scope.locale == 'ko' ? "권한이 없거나 허용되지 않은 접근입니다." : "Access is not authorized or not allowed.");
 	 				history_back();
 	 			}else{
 	 				if($scope.custInfo.EMP_GB == 'Y')	{
 	 	 				/* 직원은 모든 페이지 접속 허용 */
 	 	 			}else{
						if(['online','online_zb','exhibit','exhibit_sa'].indexOf($scope.sale.SALE_KIND_CD) > -1 && TO_DT < S_DB_NOW_D ){
 	 	 	 				/* 마감된 온라인경매 페이지 접속시*/
 	 	 	 				alert($scope.locale == 'ko' ? "권한이 없거나 허용되지 않은 접근입니다.2" : "Access is not authorized or not allowed.");
 	 						history_back();
 	 	 				} 	
 	 	 			}
 	 			}
 	 		}
 	 		
 	 		if($scope.sale.SALE_NO == 422){ //테스트 경매 ( or 외부경매 접속시  || $scope.sale.SALE_OUTSIDE_YN == 'Y' * 추후 외부경매시 테스트 후 적용)
 	 			if(is_login == "false"){ //비로그인시
 	 				alert($scope.locale == 'ko' ? "권한이 없거나 허용되지 않은 접근입니다." : "Access is not authorized or not allowed."); 	
 	 				history_back();
 	 				return;
 	 			}else if($scope.custInfo.EMP_GB != 'Y'){//로그인 && 직원 아닐시 
 	 				alert($scope.locale == 'ko' ? "권한이 없거나 허용되지 않은 접근입니다." : "Access is not authorized or not allowed."); 	
 	 				history_back();
 	 				return;
 	 			}
 	 		}
 	 		
 	 		$scope.totalCount = data["tables"]["LOT_CNT"]["rows"][0]["CNT"];

 	 		//$scope.setJsonObj(data["tables"]["LOTS"]["rows"], ["LOT_SIZE", "ARTIST_NAME", "TITLE", "STITLE", "MAKE_YEAR"]);
 	 		
 	 	    $scope.lotList = data["tables"]["LOTS"]["rows"];
 	 	    if($scope.lotList.length > 0)
 	 	   	 	$scope.curr_lot_no = $scope.lotList[0].CURR_LOT_NO;
 	 	   
 	 	    //$scope.base_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKD" : "KRW");
 	 	    $scope.base_currency = $scope.sale.CURR_CD;
 	 	    $("#nationCash").html($scope.sale.CURR_CD);
 	 	    $scope.base_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKT" : "KST");
 	 		//$scope.sub_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KRW" : "HKD");
 	 		$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
 	 		$scope.sub_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KST" : "HKT");
 	 		
 	 		$scope.orders = (['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && is_login) ? $.extend($scope.orders1, $scope.orders2) : $scope.orders1;//$scope.sale.SALE_KIND_CD == 'online' 수정. 2019.12.12 YDH
 	 		$scope.reqRowCnts = $scope.viewType == "LIST" ? $scope.reqRowCnts1 :  $scope.reqRowCnts2;
 	 		
 	 		$scope.pageRows = parseInt($scope.reqRowCnt);
 	 		
 	 		if($scope.sale_status == "ING" && ['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && data.tables.CERT){ //$scope.sale.SALE_KIND_CD == 'online' 수정. 2019.12.12 YDH
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
 		//$scope.sale.SALE_KIND_CD == 'online' 수정. 2019.12.12 YDH
 		if(['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.lot_nos.length == 0){  //수정전(2017.03.30) if($scope.lot_nos.length == 0){ 
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
 	            	//lot["GROW_PRICE"] = $d[i]["GROW_PRICE"]; //호가변경관련 소스추가부분. 현재 주석처리(2019.10.03 YDH)
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
	 	//오프라인 경매 1시간단위로 refresh
	 	if(['main','hongkong','plan'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){//$scope.sale.SALE_KIND_CD != 'online' 수정. 2019.12.12 YDH
			console.log("========= offline runLotsRefresh start");
 	 		//if(!$scope.modal) 
 	  		$scope.timer_lots_refresh = $interval($scope.refreshLots, 60000);//, 1);
 	  		$scope.list_timer_start = true;
 		}
	 	//온라인 경매는 5초단위로 refresh
 		if(['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){	//$scope.sale.SALE_KIND_CD == 'online' 수정. 2019.12.12 YDH
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

	$scope.showBidPopup = bid.showBidPopup;
	$scope.showBidRequestPopup = bid.showBidRequestPopup;
	$scope.showBidHistoryPopup = bid.showBidHistoryPopup;
	
	$scope.setExpeSlide = function(currency) {
 		setUiSlider($scope.sale["MIN_" + currency + "_EXPE_PRICE"], $scope.sale["MAX_" + currency+ "_EXPE_PRICE"]
 			, $scope.sale["MIN_" + currency + "_EXPE_PRICE"], $scope.sale["MAX_" + currency+ "_EXPE_PRICE"]);
	}
	
	$scope.searchList = function(){
		$scope.fav_toggle(false);
		$scope.loadLotList(1);
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
	$scope.isFavPage = false; //true-관심, false-전체
	$scope.fav_toggle = function(isFav) {
		
		$scope.cate_list = null;
		$scope.hashtag_list = null;		
		$scope.fav_cds_list = null;
		
		if(isFav){
			$scope.fav_cds_list = 1;
			$scope.isFavPage = true;
		}else{
			$scope.fav_cds_list = null;
			$scope.isFavPage = false;
		}
		
		if($scope.fav_cds_list == null || $scope.fav_cds_list == "undefined" || $scope.fav_cds_list.length < 1) {
			$scope.fav_cds_list = null;
		}
		$scope.loadLotList(1);
	};
	
	
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
		$scope.fav_selected = [];
		$scope.fav_cds_list = null;
		$scope.loadLotList(1);
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
		$scope.fav_selected = [];
		$scope.fav_cds_list = null;	
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
 		$scope.setExpeSlide($scope.sale.CURR_CD);
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
					$scope.fav_toggle($scope.isFavPage);
// 					window.location.reload(true);
				}else {
					alert("A favorate work has been deleted.");
					$scope.fav_toggle($scope.isFavPage);
// 					window.location.reload(true);
				}
				return true;
			}
		})	
	}
	/* 관심작품 End */
	/* 컨디션리포트/관심작품 신청, 삭제 SRC END (2017.08.11 YDH) */
	
	
	/* 라이브 비딩 패들번호 부여 */
	$scope.paddleAdd = function(saleNo){
		
		$scope.paddleYn = 'N';
		
		if(is_login == "false" && $scope.locale  == 'ko' ){
			alert("로그인 후 이용해주세요");
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
						alert("이미 패들번호를 부여받으셨습니다.");
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
							
							$("#liveBidContents").html("고객님의 패들넘버는"+$scope.check.PADD_NO+"번 입니다.");
							$("#liveBidInfoCheck").trigger('click');
							
							$scope.padd_no = $scope.check.PADD_NO;
							
						});
			} 
		})	
	}
	
	$scope.showTremPopup = function(){
		$("input:checkbox[name=agree_checkbox]").prop("checked", false);
		$("input:checkbox[name=agree_checkbox_all]").prop("checked", false);
		$("#TremAgreeCheck").trigger('click');
	}
	
	$scope.closeTremPopup = function(){
		$(".modally-close-button").click();
	}
	
	$scope.tremAgreeCheck = function(){ //동의여부 체크
		var checkboxLen = $("input:checkbox[name=agree_checkbox]").length; //체크박스 전체 개수
		var checkedLen = $("input:checkbox[name=agree_checkbox]:checked").length; //체크된 개수
		
		if(checkboxLen == checkedLen){
			$(".modally-close-button").click();			
			$scope.paddleAdd($scope.sale.SALE_NO);
		}else{
			alert($scope.locale == 'ko'? "약관에 모두 동의해주세요." : "Please agree to all the terms and conditions." );
			return;
		}
	}	
	
	$scope.checkboxAll = function(){ 
		if($("#agree_checkbox_all").prop("checked")){
			$("input:checkbox[name=agree_checkbox]").prop("checked", true);
		}else{
			$("input:checkbox[name=agree_checkbox]").prop("checked", false);
		}
	}
	
	$scope.close = function(){
		self.opener = self;
		window.close();
		$scope.modal.close();
	}
	
	//lot출력완료 후 이전 위치로 스크롤 이동
	$scope.$on('ngRepeatFinished', function (ngRepeatEndEvent) { 
 		var scroll_loc = sessionStorage.getItem("scroll_loc");
  		//$(window).scrollTop(scroll_loc); //IE지원 X
 		$("body, html").stop().animate({scrollTop : scroll_loc}, 0);
 		sessionStorage.removeItem("scroll_loc");
	});
	
	//해당 경매 공지사항 연결
	$scope.openPageBlank = function(url, param){
		window.open('about:blank').location.href= url;
	}

	$scope.blacklotGo = function(url, sale_no, lot_no) {
		window.location.href = url+encodeURIComponent("sale_no="+sale_no+"&lot_no="+lot_no);
	}
});
</script>
<script type="text/javascript" src="/js/bid.js?ver=20220418"></script>
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
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div> 
			<!-- //sub_menu_wrap -->
			
			<div class="contents_wrap">
            <!-- 모바일용 -->    
				<div class="m_only m_location">
                    <%-- 모바일용 버튼 완성안됨 
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
					</div>--><%-- 모바일용 버튼 완성안됨 --%> 
					<div class="hidden_box">
						<ul> 
							<li>
								<div class="m_ex_title">
									<div class="title">  
										<div class="tit lotlist_memobox">          
											<span class="num" ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0" ng-bind="sale.SALE_TH | localeOrdinal"></span> 
											<span style="padding: 10px 15px;" ng-bind-html="sale.TITLE_JSON[locale]"></span> 
											<!-- <span ng-if="viewId == 'CURRENT_AUCTION' && sale_status == 'ING' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status = 'END'">진행 LOT : <span ng-bind="curr_lot_no"></span></span> -->
										</div>   
										<div class="sub lotlist_memobox"> 
                                            <%-- 홍콩인 경우 시간 순서 변경 --%>  
                                            <p ng-if="locale != 'ko'">  
                                                <span style="font-weight:600; color: #00acac; display: inline-block;">AUCTION : </span> 
                                                <span style="display: inline-block; font-weight:bold;" ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'(EEE) d MMM, yyyy h:mm a' : 'UTC+9' | lowercase)+' ' + base_timezone"></span> 
                                                <span ng-if="sale.SALE_KIND_CD == 'hongkong'" ng-bind="'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a'  : 'UTC+9'| lowercase)+' '+sub_timezone+')'"></span>
                                            </p>   
                                            <p ng-if="locale == 'ko'">   
                                                <span style="font-weight:600; color: #00acac; display:inline-block;">일 시 : </span>  
                                                <span style="display: inline-block; font-weight:bold; " ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d' : 'UTC+9' | lowercase)+'('+getWeek(sale.TO_DT)+')'+(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'h:mm a' : 'UTC+9')+' '+base_timezone"></span>     
                                                <span ng-if="sale.SALE_KIND_CD == 'hongkong'" ng-bind="'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a'  : 'UTC+9'| lowercase)+' '+sub_timezone+')'"></span> 
                                            </p> 
                                            <!-- <p> 
	                                			<span ng-if="viewId == 'CURRENT_AUCTION' && sale_status == 'ING' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.FROM_DT > db_now" ng-bind="db_now | timeDuration : sale.TO_DT" style="font-weight:600;"></span> 
	                                	    </p> -->
	                                	    <!-- <p>
	                                	    	<span ng-bind="sale.PLACE_JSON[locale]"></span> 
	                                	    </p>  --><!-- 2021.02.10 YDH 주석처리. 디테일페이지에서 해당 컬럼 사용! -->
                                	        <%-- <p> 
	                                	        <span ng-if="viewId == 'CURRENT_AUCTION' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.TO_DT < db_now" style="font-weight:600;">진행 LOT : <span ng-bind="curr_lot_no" style="font-weight:600; color:#00acac;"></span></span>
	                                	    </p> --%> 
	                                	    <p>     
	                                            <span ng-bind-html="sale.NOTICE_JSON[locale]"></span>
                                	        </p> 
                                            <!--홍콩--> 
                                            <!-- <span ng-if="sale.SALE_KIND_CD == 'hongkong' && viewId == 'CURRENT_AUCTION'">
	                                          <span ng-if="locale == 'ko'" style="font-weight:600;">* 이종 통화 표시 추정가 및 대금결제 : 경매진행 및 대금결제는 홍콩 달러로 이루어집니다. 이러한 이종 통화 표시 추정가는 응찰자에게 편의를 제공하기 위함일 뿐이며 모든 응찰 및 대금 결제는 홍콩 달러로 이루어집니다. 당사는 각 통화 환산 과정에서 발생하는 어떠한 과실 또는 누락에 대한 책임이 없음을 유의해 주시기 바랍니다.</span>
	                                            <span ng-if="locale != 'ko'"><font style="font-weight:600;">* Currency indication of the estimated price and the payment : </font>All bids and payment will be in <font style="font-weight:600;">Hong Kong Dollars (HKD)</font>. Multi-currency pricing is for reference only and all bid payment shall be in HKD.. Also, we will not take responsibility for any problems that occur during the calculation of currency exchange rates</span>
                                                <span ng-if="locale != 'ko'"><br />E-mail saplus@seoulauction.com</span>
                                            </span>
                                            국내
                                            <span ng-if="sale.SALE_KIND_CD != 'hongkong' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">
	                                            <span ng-if="locale == 'ko'" style="font-weight:600;">* 구매수수료: 15%​ (부가세 별도) </span><span ng-if="locale == 'ko' && sale.SALE_NO == '401' && sale.SALE_KIND_CD == 'online' " style="font-weight:600;"> / 작품보증서 미발급</span>
	                                            <span ng-if="locale == 'ko'"><br />* 응찰은 <font style="font-weight:600;">작품 컨디션 확인 후 진행 되는 것을 전제</font>로 하며, 작품 컨디션에 액자 상태는 포함되지 않습니다.</span>
                                                <span ng-if="locale != 'ko'">E-mail info@seoulauction.com</span>
                                            </span> 
                                            온라인 
                                            <span ng-if="sale.SALE_KIND_CD != 'hongkong' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.SALE_NO == '463'" >
                                                 <span ng-if="locale == 'ko'">* 구매수수료: 18% (부가세 별도)</span>
                                                 <span ng-if="locale != 'ko'">* Buyer’s Premium: 18% (VAT excluded)</span>                            
                                                 <span ng-if="locale != 'ko'"><br/>* E-mail info@seoulauction.com</span>
                                            </span> --> 

                                            <!--<span ng-if="sale.SALE_KIND_CD != 'hongkong'">
                                                 <br/><span ng-if="locale == 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60">테스트 경매입니다. 응찰을 하셔도 실제 낙찰과는 무관합니다.<br/>실제 환경과 동일 조건에서 테스트 중입니다. </span>
                                                 
                                                 <br/><span ng-if="locale != 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60"">TEST AUCTION. Even if you make a bid, it doesn't really matter.</span>
                                            </span>-->           
                                             <!--생중계LIVE 모바일--> 
                                        </div> 
                            
                                        <div class="m_only" style="padding:4px; margin-top: 10px;">   
                                                  <!-- 생중계 버튼(오픈시처리) -->
                                                  <!--<span class="btn_style01 white"  ng-if="locale=='ko'"><button type="button" name="생중계보기" value="생중계보기" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')";>생중계보기</button></span>
                                                  <span ng-if="locale!='ko'"><button type="button" name="Auction Live" value="Auction Live" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')";>Auction Live</button></span>  
                                                 </div> --> 
                                                 
                                                 <!-- PREVIEW 버튼 표시(상시 노출금지. 2020.12.12 임2지시사항)  -->
                                                 <!-- <span class="btn_style01 dark" ng-if="sale.SALE_NO != '594' && viewId == 'CURRENT_AUCTION' && sale_outside_yn != 'Y'">
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="PREVIEW" value="PREVIEW" align="center" scrolling="no" onClick="window.open('${contextPath}/upcomingAuction?sale_kind=${SALE_KIND_CD}&sale_no=${SALE_NO}')";>PREVIEW</button>  
                                                </span>    -->
                                                    
                                                <!-- Notice 버튼 표시 
                                                <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_KIND_CD == '000'">
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_KIND_CD == '000'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/noticeView?write_no=2895')"; >NOTICE</button>
                                                </span>
                                                
                                                <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '643'"> 
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '643'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=4514')"; >NOTICE</button>             
                                                </span> 
                                                 -->
                                                 
                                                <!-- Notice 버튼 자동 표시 -->
	                                            <span class="btn_style01 dark" ng-if="sale.WRITE_NO > 0"> 
	                                                <button type="button" name="NOTICE" value="NOTICE" align="center" scrolling="no" ng-click="openPageBlank('/noticeView?write_no='+sale.WRITE_NO)" >NOTICE</button>          
	                                            </span> 
                                                
                                                <!-- 제로베이스 작가 보기 -->       
                                                <span class="btn_style01 dark" ng-if="sale.SALE_NO == '679'">   
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="ARTIST VIEW" value="ARTIST VIEW" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/zerobaseArtist')"; >ARTIST VIEW</button>    
                                                </span>  
                                                 
                                                <!-- e-book 도록 보기 (버튼 4개일시 빼기) -->     
                                                <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '700'">
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '700'" name=" CATALOGUE" value=" CATALOGUE" align="center" scrolling="no" onClick="window.open('/nas_img/front/homepage/e-book/166th/index.html')"; >CATALOGUE</button>
                                                </span>   
                                                
												<span class="btn_style01 green" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '679'"> 
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '679'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=5313')"; >EVENT</button>              
                                                </span> 

                                               
                                                <!-- EXHIBITION 버튼 표시(VR) -->  
                                                 <!-- 홍콩 EXHIBITION 
                                                <span class="btn_style01 dark" ng-if="sale.SALE_NO == '566'"> 
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/VR/')"; >EXHIBITION</button>   
                                                </span> -->  
                                                
                                                <!--  전시장 EXHIBITION  --> 
                                                <span class="btn_style01 dark" ng-if="sale.SALE_NO == '681'">   
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/VR/164th/index.html')"; >EXHIBITION</button>     
                                                </span>   
                                                
                                                <!-- 경매 건물 EXHIBITION     
                                                <span class="btn_style01 dark" ng-if="sale.SALE_NO == '562'">
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/VR/')"; >VR Video</button>
                                                </span> -->   
                                                
                                                <!-- 아트시 응찰버튼 -->   
                                                <span class="btn_style01 orange01" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'">
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'" name="Artsy" value="Artsy" align="center" scrolling="no" onClick="window.open('https://www.artsy.net/auction/seoul-auction-crossroad')"; > 
                                                    	<span ng-if="locale != 'ko'">BLACKLOT Bid</span>
                                                        <span ng-if="locale == 'ko'">블랙랏 응찰</span>
                                                    </button>   
                                                </span>
                                                
                                                <!-- 아트시 응찰버튼 (동시 게시 시)-->  
                                                <!-- <span class="btn_style01 orange01" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y' && sale.SALE_NO != '667'">    
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'" name="Artsy" value="Artsy" align="center" scrolling="no" onClick="window.open('https://www.artsy.net/auction/artsy-x-seoul-auction-mixed-media')"; >
                                                    	<span ng-if="locale != 'ko'">Artsy Bid</span>
                                                        <span ng-if="locale == 'ko'">아트시 응찰</span>   
                                                    </button>    
                                                </span> --> 
                                                
                                               <!-- <span class="btn_style01 orange01"  ng-if="sale.SALE_NO == '452' && locale=='ko'">
                                                <button type="button" name="동영상보기" value="동영상보기" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionVideoPop', 'how', 'width=590,height=410,scrollbars=1')";>고미술 인터뷰영상</button>
                                            </span>
                                            <br/><br/>
                                            <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '454' && locale=='ko'">
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/currentAuction?sale_kind=online_only&sale_no=455')"; >김기홍 박사 컬렉션 바로가기</button>
                                                </span>
                                                <span class="btn_style01 orange01" ng-if="sale.SALE_NO == '455' && locale=='ko'">
                                                    <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/currentAuction?sale_kind=online_only&sale_no=454')"; >7회 블랙랏 바로가기</button>
                                                </span>
                                            </div> -->  
                                        </div>  
                                               
										<!-- 라이브 응찰 신청 및 응찰하기 버튼 -->      
										<div ng-if="sale.LIVE_BID_YN == 'Y' && viewId == 'CURRENT_AUCTION' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">            
											<div class="livebid_page" ng-if="sale_status == 'ING' && nowTime < liveEnd">       
			                                	<div class="livebid_pageback">   
			                                		<!-- 경매 당일 전 신청하기 자동생성 -->  
			                                		<span>    
				                                		<a ng-if="is_login == 'false'" class="livebid_page_btn" href="" alt="온라인 실시간 신청" onClick="alert('로그인 후 이용해주세요.\n Please login for use.'); location.href='/login';">      
				                                			<c:if test="${locale == 'ko'}">  
				                                				<span class="livebid_pageback_txt">온라인 실시간 신청</span>  
				                                			</c:if>    
				                                			<c:if test="${locale != 'ko'}">    
				                                				<span class="livebid_pageback_txt" style="font-size: 16px;">Online live Apply</span>    
				                                			</c:if>   
														</a>  
		                                				
				                                		<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN == 'Y' && padd_no == 0" class="livebid_page_btn" href="" alt="온라인 실시간 신청" ng-click="showTremPopup()" >     <!-- ng-click="paddleAdd(sale.SALE_NO)" -->
				                                			<c:if test="${locale == 'ko'}">  
				                                				<span class="livebid_pageback_txt">온라인 실시간 신청</span>  
				                                			</c:if>    
				                                			<c:if test="${locale != 'ko'}">    
				                                				<span class="livebid_pageback_txt" style="font-size: 16px;">Online live Apply</span>    
				                                			</c:if>   
														</a> 
														<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN != 'Y'" class="livebid_page_btn" href="" alt="온라인 실시간 응찰" onClick="alert('정회원만 응찰 가능합니다.\n Only Subscription Member can bid.')">     
				                                			<c:if test="${locale == 'ko'}">
				                                				<span class="livebid_pageback_txt">온라인 실시간 신청</span>    
				                                			</c:if>  
				                                			<c:if test="${locale != 'ko'}">  
				                                				<span class="livebid_pageback_txt" style="font-size: 16px;">BidLive Apply</span>   
				                                			</c:if>  
														</a>   
														<!-- 패들번호 발급 받았을 시 패들번호 표시 -->
														<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN == 'Y' && padd_no > 0" class="livebid_page_btn"  alt="PADD NO. {{padd_no}}" style="cursor:default;">     
				                                			<span class="livebid_pageback_txt">PADD NO. {{padd_no}}</span>
														</a>
													</span>
			                                	</div><!-- //livebid_pageback --> 
			                                </div><!-- //livebid_page --> 
			                                <div class="livebid_page" ng-if="sale_status == 'ING' && nowTime == liveEnd && liveCheckDt < liveStartDt && padd_no > 0">            
			                                	<div class="livebid_pageback">        
			                                		<!-- 경매 당일 패들번호 출력 -->          
		<!-- 									<p style="color:#00acac;">nowTime : {{nowTime}} / liveEnd : {{liveEnd}}</p> -->
		<!-- 									<p style="color:#00acac;">liveCheckDt : {{liveCheckDt}} / liveStartDt : {{liveStartDt}}</p> -->
			                                		<span>  
			                                			<a class="livebid_page_btn"  alt="PADD NO. {{padd_no}}" style="cursor:default;">     
				                                			<span class="livebid_pageback_txt">PADD NO. {{padd_no}}</span>
														</a>  
			                                		</span>   
			                                	</div><!-- //livebid_pageback -->       
			                                </div> <!-- //livebid_page --> 
			                                <div class="livebid_page" ng-if="sale_status == 'ING' && liveCheckDt >= liveStartDt">       
			                                	<div class="livebid_pageback">  
			                                		<!-- 경매 당일 응찰하기 자동생성 -->          
			                                		<span>   
			                                			<a ng-if="custInfo.MEMBERSHIP_YN == 'Y'" class="livebid_page_btn" target="_blank" href="/service/page?view=bidLive_memberNew&sale_no={{sale.SALE_NO}}" alt="온라인 실시간 응찰">
			                                				<c:if test="${locale == 'ko'}"><span class="livebid_pageback_txt">온라인 실시간 응찰<br><p ng-if="padd_no > 0">PADD NO. {{padd_no}}</p></span></c:if> 
		                              						<c:if test="${locale != 'ko'}"><span class="livebid_pageback_txt" style="font-size: 16px;">Online live bid<br><p ng-if="padd_no > 0">PADD NO. {{padd_no}}</p></span></c:if>  
			                                			</a> 
			                                			<a ng-if="custInfo.MEMBERSHIP_YN != 'Y'" class="livebid_page_btn" target="_blank" href="/service/page?view=bidLive_all&sale_no={{sale.SALE_NO}}" alt="온라인 실시간 응찰">
		                              						<c:if test="${locale == 'ko'}"><span class="livebid_pageback_txt">온라인 실시간 응찰</span></c:if> 
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
                
				<!-- 웹용 -->
				<div class="contents">
                   
					<!--<button ng-if="viewId == 'CURRENT_AUCTION'" class="sp_btn btn_up">
						<span class="hidden"><spring:message code="label.move.top" /></span>
					</button>-->
					<div class="ex_title type02" ng-if="viewId != 'SEARCH'">  
						<div class="title">   
							<div class="tit">
								<span class="num" ng-if="[620].indexOf(sale.SALE_NO) > -1" ><strong>2021 FIRST AUCTION</strong></span>    
								<span class="num" ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0" ng-bind="sale.SALE_TH | localeOrdinal"></span>
								<span ng-bind-html="sale.TITLE_JSON[locale]"></span>
								<!-- <span ng-if="viewId == 'CURRENT_AUCTION' && sale_status == 'ING' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status = 'END'">진행 LOT : <span ng-bind="curr_lot_no"></span></span> -->
							</div>
							<div class="sub lotlist_memobox"> 
                                <%-- 홍콩인 경우 시간 순서 변경 --%> 
                                <p ng-if="locale != 'ko'" style="font-weight:600;"> 
                                	<span style="font-weight:600; color: #00acac;">AUCTION : </span>   
                                	<span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'(EEE) d MMM, yyyy h:mm a' : 'UTC+9' | lowercase)+' '+base_timezone"></span>  
                                    <span ng-if="sale.SALE_KIND_CD == 'hongkong'" ng-bind="'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a' : 'UTC+9' | lowercase)+' '+sub_timezone+')'"></span>
                                </p> 
                                <p ng-if="locale == 'ko'" style="font-weight:600;">  
                                	<span style="font-weight:600; color: #00acac;">일 시 : </span>  
                                	<span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d' : 'UTC+9' | lowercase)+'('+getWeek(sale.TO_DT)+')'+(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'h:mm a' : 'UTC+9')+' '+base_timezone"></span>     
                                    <span ng-if="sale.SALE_KIND_CD == 'hongkong'" ng-bind="'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a' : 'UTC+9' | lowercase)+' '+sub_timezone+')'"></span>
                                </p>  
                               <!--  <p>
                                	<span ng-if="viewId == 'CURRENT_AUCTION' && sale_status == 'ING' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.FROM_DT > db_now" ng-bind="db_now | timeDuration : sale.TO_DT" style="font-weight:600;"></span>
                                </p> -->
                                 
                                <!-- VENUE 오피스 수기 입력으로 주석 처리 -->  
                                <!-- <p>  
                               		<span ng-if="viewId == 'CURRENT_AUCTION' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1" style="font-weight:600;">VENUE : </span><span ng-bind="sale.PLACE_JSON[locale]" style="font-weight:600;"></span> 
                                </p> --> 
                                
                                <%-- <p>
                                	<span ng-if="viewId == 'CURRENT_AUCTION' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.TO_DT < db_now" style="font-weight:600;">진행 LOT : <span ng-bind="curr_lot_no" style="font-weight:600; color:#00acac;"></span></span>
                                </p> --%> 
                                <!-- <span ng-bind="sale.PLACE_JSON[locale]"></span> -->
                                <p>
                                	<span ng-bind-html="sale.NOTICE_JSON[locale]"></span>
                                </p> 
                                <!--홍콩--> 
                                <!-- <span ng-if="sale.SALE_KIND_CD == 'hongkong'">
	                                 <span ng-if="locale == 'ko'" style="font-weight:600;">* 이종 통화 표시 추정가 및 대금결제 : 경매진행 및 대금결제는 홍콩 달러로 이루어집니다. 이러한 이종 통화 표시 추정가는 응찰자에게 편의를 제공하기 위함일 뿐이며 모든 응찰 및 대금 결제는 홍콩 달러로 이루어집니다. 당사는 각 통화 환산 과정에서 발생하는 어떠한 과실 또는 누락에 대한 책임이 없음을 유의해 주시기 바랍니다.</span>
                                      <span ng-if="locale != 'ko'"><font style="font-weight:600;">* Currency indication of the estimated price and the payment : </font>All bids and payment will be in <font style="font-weight:600;">Hong Kong Dollars (HKD)</font>. Multi-currency pricing is for reference only and all bid payment shall be in HKD.. Also, we will not take responsibility for any problems that occur during the calculation of currency exchange rates</span>
                                      <span ng-if="locale != 'ko'"><br />E-mail saplus@seoulauction.com</span>
                                </span>
                                국내
                                <span ng-if="sale.SALE_KIND_CD != 'hongkong' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1" >
	                                 <span ng-if="locale == 'ko'">* 구매수수료: 15%​ (부가세 별도) </span>
                                     <span ng-if="locale == 'ko' && sale.SALE_NO == '401' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600;"> / 작품보증서 미발급</span>
	                                 <span ng-if="locale == 'ko'"><br />* 응찰은 작품 컨디션 확인 후 진행 되는 것을 전제로 하며, 작품 컨디션에 액자 상태는 포함되지 않습니다.</span>
                                     <span ng-if="locale != 'ko'">E-mail info@seoulauction.com</span>
                                </span>  
                                온라인 
                                <span ng-if="sale.SALE_KIND_CD != 'hongkong' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.SALE_NO == '463'" >
                                     <span ng-if="locale == 'ko'">* 구매수수료: 18% (부가세 별도)</span>
                                     <span ng-if="locale == 'ko'"><br />* 'Lot.번호 1~8 작품은 물품으로 작품 보증서가 발급되지 않습니다.</span>
                                     <span ng-if="locale != 'ko'">* Buyer’s Premium: 18% (VAT excluded)</span>
                                     <span ng-if="locale != 'ko'"><br/>* Lot.1-8, 78-87, 122-133 will not be guaranteed.</span>                          
                                     <span ng-if="locale != 'ko'"><br/>* E-mail info@seoulauction.com</span>
                                </span> -->  

                                <!--<span ng-if="sale.SALE_KIND_CD != 'hongkong'">
	                                 <br/><span ng-if="locale == 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60">테스트 경매입니다. 응찰을 하셔도 실제 낙찰과는 무관합니다.<br/>실제 환경과 동일 조건에서 테스트 중입니다. </span>
	                                 
                                     <br/><span ng-if="locale != 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60"">TEST AUCTION. Even if you make a bid, it doesn't really matter.</span> 
                                </span>-->     
                                <dl style="padding-top:15px; padding-bottom:20px;">      
                                       <div class="btns">     
                                       		<!-- Preview 버튼 표시(상시 노출금지. 2020.12.12 임2지시사항) -->      
                                            <!--  <span class="btn_style01 dark" ng-if="sale.SALE_NO != '594' && viewId == 'CURRENT_AUCTION' && sale_outside_yn != 'Y'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="PREVIEW" value="PREVIEW" align="center" scrolling="no" onClick="window.open('${contextPath}/upcomingAuction?sale_kind=${SALE_KIND_CD}&sale_no=${SALE_NO}')";>PREVIEW</button>
                                            </span>  -->   
                                              
                                           <!-- Notice 버튼 표시 -->       
                                           <!--  <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_KIND_CD == '000'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_KIND_CD == '000'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/noticeView?write_no=2895')"; >NOTICE</button>
                                            </span> 
                                            
                                            <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '643'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '643'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=4514')"; >NOTICE</button>            
                                            </span>
                                            -->
                                            
                                            <!-- Notice 버튼 자동 표시 -->
                                            <span class="btn_style01 dark" ng-if="sale.WRITE_NO > 0"> 
                                                <button type="button" name="NOTICE" value="NOTICE" align="center" scrolling="no" ng-click="openPageBlank('/noticeView?write_no='+sale.WRITE_NO)" >NOTICE</button>          
                                            </span> 
                                            
                                            <!-- 제로베이스 작가 보기 -->      
                                             <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '679'">    
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '679'" name="ARTIST VIEW" value="ARTIST VIEW" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/zerobaseArtist')"; >ARTIST VIEW</button>    
                                            </span>  
                                            
                                            <!-- e-book 도록 보기 -->       
                                            <span class="btn_style01 dark" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '700'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '700'" name=" CATALOGUE" value=" CATALOGUE" align="center" scrolling="no" onClick="window.open('/nas_img/front/homepage/e-book/166th/index.html')";>CATALOGUE</button>
                                            </span>     
                                            
                                            <!-- EXHIBITION 버튼 표시(VR) -->  
                                            <!-- 홍콩 EXHIBITION ->    
                                            <span class="btn_style01 dark" ng-if="sale.SALE_NO == '566'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/VR/')"; >EXHIBITION</button> 
                                            </span> -->   
                                             
                                            <!-- 전시장 EXHIBITION -->   
                                            <span class="btn_style01 dark" ng-if="sale.SALE_NO == '681'">  
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/VR/164th/index.html')"; >EXHIBITION</button>       
                                            </span>    
                                            
                                            <span class="btn_style01 green" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '679'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale.SALE_NO == '679'" name="NOTICE" value="NOTICE" align="center" scrolling="no" onClick="window.open('/noticeView?write_no=5313')"; >EVENT</button>              
                                            </span> 
                                             
                                            <!-- 경매 건물 EXHIBITION ->
                                           	<span class="btn_style01 dark" ng-if="sale.SALE_NO == '562'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="EXHIBITION" value="EXHIBITION" align="center" scrolling="no" onClick="window.open('https://www.seoulauction.com/nas_img/front/homepage/VR/')"; >VR Video</button>     
                                            </span> -->  
                                            
                                            <!-- 아트시 응찰버튼 -->
										   <!-- TODO: 블랙랏 응찰 URI 변경 -->
                                            <%--<span class="btn_style01 orange01" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'" name="Artsy" value="Artsy" align="center" scrolling="no" onClick="window.open('https://www.artsy.net/auction/seoul-auction-crossroad')";>   
                                                    <span ng-if="locale != 'ko'">BLACKLOT Bid</span>
                                                    <span ng-if="locale == 'ko'">블랙랏 응찰</span>
                                                 </button>     
                                            </span> --%>
                                            
                                            <!-- 아트시 응찰버튼(2개 동시 게시 시) -->                     
                                            <!-- <span class="btn_style01 orange01" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y' && sale.SALE_NO != '667'">      
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION' && sale_outside_yn == 'Y'" name="Artsy" value="Artsy" align="center" scrolling="no" onClick="window.open('https://www.artsy.net/auction/artsy-x-seoul-auction-mixed-media')"; >  
                                                    <span ng-if="locale != 'ko'">Artsy Bid</span>  
                                                    <span ng-if="locale == 'ko'">아트시 응찰</span>   
                                                 </button>     
                                            </span> -->  
                                             
                                          <!-- 생중계 버튼(오픈시처리) -->
                                          <!-- <span class="btn_style01 orange01">
                                                <button type="button" ng-if="viewId == 'CURRENT_AUCTION'" name="AUCTION LIVE" value="AUCTION LIVE" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')"; >AUCTION LIVE</button>
										</span> --> 
										
                                        <!--<span class="btn_style01 orange01"  ng-if="sale.SALE_NO == '452' && locale=='ko'">
                                            <button type="button" name="동영상보기" value="동영상보기" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionVideoPop', 'how', 'width=790,height=700,scrollbars=1')";>고미술 인터뷰영상</button>
                                        </span>-->
								    </div> 
								</dl>  
							</div>  
							  
                            <div class="butt livebid_pagebox clearfix">   
								<!-- 라이브 응찰 신청 및 응찰하기 버튼 -->       
								<div ng-if="sale.LIVE_BID_YN == 'Y' && viewId == 'CURRENT_AUCTION' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">              
									<div class="livebid_page" ng-if="sale_status == 'ING' && nowTime < liveEnd">            
	                                	<div class="livebid_pageback">  
	                                		<!-- 경매 당일 전 신청하기 자동생성 -->   
	                                		<span>    
		                                		<a ng-if="is_login == 'false'" class="livebid_page_btn" href="" alt="온라인 실시간 신청" onClick="alert('로그인 후 이용해주세요.\n Please login for use'); location.href='/login';">        
		                                			<c:if test="${locale == 'ko'}">         
		                                				<span class="livebid_pageback_txt">온라인 실시간 신청</span>   
		                                			</c:if>    
		                                			<c:if test="${locale != 'ko'}">    
		                                				<span class="livebid_pageback_txt" style="font-size: 16px;">Online live Apply</span>     
		                                			</c:if>   
												</a> 
		                                		<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN == 'Y' && padd_no == 0" class="livebid_page_btn" ng-click="showTremPopup()" alt="온라인 실시간 신청"><!--  ng-click="paddleAdd(sale.SALE_NO)" -->     
		                                			<c:if test="${locale == 'ko'}">  
		                                				<span class="livebid_pageback_txt">온라인 실시간 신청</span>  
		                                			</c:if>    
		                                			<c:if test="${locale != 'ko'}">    
		                                				<span class="livebid_pageback_txt" style="font-size: 16px;">Online live Apply</span>    
		                                			</c:if>   
												</a> 
												<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN != 'Y'" class="livebid_page_btn" href="" alt="온라인 실시간 응찰" onClick="alert('정회원만 응찰 가능합니다.\n Only Subscription Member can bid.')">     
		                                			<c:if test="${locale == 'ko'}"> 
		                                				<span class="livebid_pageback_txt">온라인 실시간 신청</span>    
		                                			</c:if>  
		                                			<c:if test="${locale != 'ko'}">  
		                                				<span class="livebid_pageback_txt" style="font-size: 16px;">BidLive Apply</span>   
		                                			</c:if> 
												</a>   
												<!-- 패들번호 발급 받았을 시 패들번호 표시 -->
												<a ng-if="is_login == 'true' && custInfo.MEMBERSHIP_YN == 'Y' && padd_no > 0" class="livebid_page_btn"  alt="PADD NO. {{padd_no}}" style="cursor:default;">     
		                                			<span class="livebid_pageback_txt">PADD NO. {{padd_no}}</span> 
												</a>  
	                                		</span>
	                                	</div>
	                                </div><!-- //livebid_page --> 
	                                <div class="livebid_page" ng-if="sale_status == 'ING' && nowTime == liveEnd && liveCheckDt < liveStartDt && padd_no > 0">            
	                                	<div class="livebid_pageback">        
	                                		<!-- 경매 당일 패들번호 출력 -->          
<!-- 									<p style="color:#00acac;">nowTime : {{nowTime}} / liveEnd : {{liveEnd}}</p> -->
<!-- 									<p style="color:#00acac;">liveCheckDt : {{liveCheckDt}} / liveStartDt : {{liveStartDt}}</p> -->
	                                		<span>  
	                                			<a class="livebid_page_btn"  alt="PADD NO. {{padd_no}}" style="cursor:default;">     
		                                			<span class="livebid_pageback_txt">PADD NO. {{padd_no}}</span>
												</a>
	                                		</span>   
	                                	</div><!-- //livebid_pageback -->       
	                                </div> <!-- //livebid_page --> 
	                               	<!-- 경매 당일 응찰하기 자동생성 -->               
	                                <div class="livebid_page" ng-if="sale_status == 'ING' && liveCheckDt >= liveStartDt">             
	                                	<div class="livebid_pageback"> 		 
	                                		<span>    
	                                			<a ng-if="custInfo.MEMBERSHIP_YN == 'Y'" class="livebid_page_btn" target="_blank" href="/service/page?view=bidLive_memberNew&sale_no={{sale.SALE_NO}}" alt="온라인 실시간 응찰"> 
	                                				<c:if test="${locale == 'ko'}"><span class="livebid_pageback_txt">온라인 실시간 응찰<br><p ng-if="padd_no > 0">PADD NO. {{padd_no}}</p></span></c:if> 
                              						<c:if test="${locale != 'ko'}"><span class="livebid_pageback_txt" style="font-size: 16px;">Online live bid<br><p ng-if="padd_no > 0">PADD NO. {{padd_no}}</p></span></c:if>  
	                                			</a>   
	                                			<a ng-if="custInfo.MEMBERSHIP_YN != 'Y'" class="livebid_page_btn" target="_blank" href="/service/page?view=bidLive_all&sale_no={{sale.SALE_NO}}" alt="온라인 실시간 응찰">
                              						<c:if test="${locale == 'ko'}"><span class="livebid_pageback_txt">온라인 실시간 응찰</span></c:if>   
                              						<c:if test="${locale != 'ko'}"><span class="livebid_pageback_txt" style="font-size: 16px;">Online live bid</span></c:if>     
												</a>
	                                		</span>   
	                                	</div><!-- //livebid_pageback -->        
	                                </div> <!-- //livebid_page -->   
								</div> 
								
								<!-- 응찰 신청 팝업 -->
                                <span class="btn_style01 gray02" ng-if="custInfo.CUST_NO && sale_status != 'ING' && locale != 'ko'">
									<button type="button" onClick="location.href='/saleLot_Result?sale_no=${SALE_NO}'";>Result List</button>
                               	</span>
                               	<div class="bidlive_notice"> 
                                    <a href="#lorem" target="_modal" class="button white" style="margin-right: 6px;" id="liveBidInfoCheck"></a>
                                </div> 
                                
                               	<div class="bidlive_notice"> 
                                    <a href="#Padd_AgreeCheck" target="_modal" class="button white" style="margin-right: 6px;" id="TremAgreeCheck"></a>
                                </div> 
                                
                                <!-- 패들부여 경매약관 주요 내용 동의 --> 
                                <div id="Padd_AgreeCheck" style="display:none" class="modally-init" modally-max-width="700">   
                                	<div class="agree_checkboxwrap padd_checkboxwrap">     
										<p class="agree_checkbox_tit">         
											<span ng-if="locale=='ko'"><span class="agree_checkbox_img"></span>약관 동의 안내 (필수체크)</span>    
											<span ng-if="locale!='ko'"><span class="agree_checkbox_img"></span>AGREEMENT ON AUCTION TERMS and IMPORTANT NOTICE(REQUIRED)</span>     
										</p>
										     
										<ul style="font-size:12px;">   
											<li class="agree_checkbox_li">    
												<input type="checkbox" name="agree_checkbox" id="EX01" class="auctionagree_checkinput" />            
												<label for="EX01" class="auctionagree_check" style="cursor:pointer;">     
													<span ng-if="locale=='ko'" class="auctionagree_check_contents">본인은 서울옥션 경매약관 <a href="/terms/page?view=auctionTerms" target="_blank">[약관 <span style="color:#00f;" class="txt_under">바로보기</span>]</a>를 모두 읽고 이해하였으며, 그 적용에 동의합니다.</span> 
													<span ng-if="locale!='ko'" class="auctionagree_check_contents">I have read and understood “Auction Terms”<a href="/terms/page?view=auctionTerms" target="_blank">[<span style="color:#00f;" class="txt_under">View Terms and Conditions</span>]</a> and “Important Notices” and agreed to be bound by them.</span> 
												</label>  
											</li> 
											<li>    
												<input type="checkbox" name="agree_checkbox" id="EX02" class="auctionagree_checkinput" />            
												<label for="EX02" class="auctionagree_check" style="cursor:pointer;">    
													<span ng-if="locale=='ko'" class="auctionagree_check_contents">응찰은 작품 실물 및 컨디션을 확인하셨음을 전제로 합니다.</span>
													<span ng-if="locale!='ko'" class="auctionagree_check_contents">The Bidder shall be responsible for conducting his/her own research and satisfying himself/herself of the condition of the lots, including, but not limited to, damage and/or restoration of the lots and in respect of any entries provided in the Auction Catalogue or elsewhere.</span>  
												</label>   
											</li>  
											<li>  
												<input type="checkbox" name="agree_checkbox" id="EX03" class="auctionagree_checkinput" />            
												<label for="EX03" class="auctionagree_check" style="cursor:pointer;">  
													<span ng-if="locale=='ko'" class="auctionagree_check_contents">낙찰자는 후 7일 이내(낙찰가 3억원 이상인 경우 21일 이내)에 구매수수료를 포함한 금액을 입금하여야 합니다. 구매수수료는 낙찰금액의 18%(부가세 별도)입니다.</span> 
													<span ng-if="locale!='ko'" class="auctionagree_check_contents">A Successful Bidder shall make full payments, including the amount of the Hammer Price, Buyer’s Premium and any applicable taxes within 7 days after the sale.(within 21 days if the Hammer Price is higher than or equal to KRW300,000,000)</span>
												</label> 
											</li> 
											<li> 
												<input type="checkbox" name="agree_checkbox" id="EX04" class="auctionagree_checkinput" />            
												<label for="EX04" class="auctionagree_check" style="cursor:pointer;">    
													<span ng-if="locale=='ko'" class="auctionagree_check_contents">낙찰자가 ①지정된 기일에 낙찰대금을 납부하지 않거나,②부득이 낙찰을 철회하는 경우,낙찰가의 30%에해당하는 금액을 낙찰철회비(위약금)로 납부하여야 합니다.</span>    
													<span ng-if="locale!='ko'" class="auctionagree_check_contents">A successful bidder must immediately pay a buyer withdrawal fee, corresponding to 30% of the hammer price, ①when the successful bidder fail to make a full payment, including the buyer’s premium, by the payment deadline or ②when withdrawing the successful bid for unavoidable reasons.</span> 
												</label>   
											</li>
											<li>   
												<input type="checkbox" name="agree_checkbox_all" id="agree_checkbox_all" ng-click="checkboxAll()" class="auctionagree_checkinput" />            
												<label for="agree_checkbox_all" class="auctionagree_check" style="cursor:pointer;">    
													<span ng-if="locale=='ko'" class="auctionagree_check_contents" ><strong>모두 동의합니다.</strong></span>       
													<span ng-if="locale!='ko'" class="auctionagree_check_contents" ><strong>All agree.</strong></span>    
												</label> 
											</li>
										</ul>   
									</div>
									
									<div class="btn_wrap">
										<span class="btn_style01 mid green02">   
											<button type="button" ng-click="tremAgreeCheck()" ><span ng-if="locale=='ko'">동의</span><span ng-if="locale!='ko'">Agree</span></button>  
										</span>   
										
										<span class="btn_style01 mid gray03">   
											<button type="button" ng-click="closeTremPopup()" ><span ng-if="locale=='ko'">취소</span><span ng-if="locale!='ko'">Cancel</span></button>
										</span> 
									</div> 
                                </div><!-- //Padd_AgreeCheck -->
                                
                                <div id="lorem" style="display:none" class="modally-init" modally-max-width="1000"> 
                                    <h1 class="modal-title" id="liveBidContents"></h1>  
                                    <p> 
                                    	 온라인 실시간 응찰은 철회가 불가합니다.<br>   
	                                     응찰 우선순위는 서면  > 현장  > 온라인 순입니다.<br> 
	                                     동영상의 금액은 시차가 있을 수 있으니, 응찰 화면의 응찰가를 확인하시고 응찰해주시기 바랍니다.<br>    
	                                     경매당일 <span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'h' : 'UTC+9' | lowercase)"></span>시부터 실시간 라이브 응찰이 가능합니다.
                                    </p>
                                </div><!-- 응찰 신청 팝업 --> 
                           	</div><!-- //livebid_pagebox -->
						</div>
						 
						<!--오른쪽 more --> 
				 		<div class="more web_only" align="center">
                           <!--생중계LIVE Web-->
                           
						  <!-- <button ng-if="viewId == 'CURRENT_AUCTION'" name="AUCTION LIVE" value="AUCTION LIVE" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')"; style="width:65px;margin-bottom:5px;">
                              <span ng-if="locale == 'ko'" style="width:65px;" ><img src="/images/bg/bg_img33_s.png" alt="CATALOG"><br/><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">생중계보기</p></span>   
                              <span ng-if="locale != 'ko'" style="width:65px;" ><img src="/images/bg/bg_img33_s.png" alt="CATALOG"><br/><p style="color:#ccc;font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">LIVE</p></span> 
                           </button><br/>-->
                           
                           <!--생중계LIVE-->  
                           
                            <!--비디오VIDEO-->
                           
						   <!--<button ng-if="viewId == 'CURRENT_AUCTION'" name="AUCTION VIDEO" value="AUCTION VIDEO" align="center" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionVideoPop', 'how', 'width=610,height=505,scrollbars=1')"; style="width:65px;margin-bottom:5px;">
                              <span ng-if="locale == 'ko'" style="width:65px;" ><img src="/images/bg/bg_img33_s.png" alt="CATALOG"><br/><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">VIDEO 보기</p></span>   
                              <span ng-if="locale != 'ko'" style="width:65px;" ><img src="/images/bg/bg_img33_s.png" alt="CATALOG"><br/><p style="color:#ccc;font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">VIDEO</p></span>
                           </button><br/>
                          -->
                           <!--비디오VIDEO-->


                           <!--<span ng-if="sale.SALE_NO == '413' && viewId == 'CURRENT_AUCTION'">-->
                           <span ng-if="sale.SALE_NO == '423' && viewId == 'CURRENT_AUCTION'">
                               	<!--PREVIEW (상시 노출금지. 2020.12.12 임2지시사항)-->
                               	
                            	<!--  <a href="https://www.seoulauction.com/upcomingAuction" target="_parent" style="width:65px;margin-top:5px;">
                                  <span style="width:65px;" ><img src="/images/bg/bg_img32_s.png" alt="Preview"><br/><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">PREVIEW</p></span>   
                            	</a><br /> -->
                            	<!---->
                            	<!--PREVIEW-->
                                <!--3D VR
                               	
                            	<a href="https://www.seoulauction.com/service/page?view=auction360VRPop" target="new" style="width:65px;margin-top:5px;">
                                  <span style="width:65px;" ><img src="/images/bg/bg_img32_s.png" alt="Preview"><br/><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">EXHIBITION</p></span>   
                            	</a><br />-->

                            	<!--3D VR--->     
	                            
                              <!--   <a href="/nas_img/front/homepage/148-Modern.pdf" target="new" style="width:65px;margin-top:5px;">
	                            	<span ng-if="locale == 'ko'" style="width:65px;" ><img src="/images/bg/bg_img31_s.png" alt="CATALOG"><br /><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">근현대도록</p></span>  
                                    <span ng-if="locale != 'ko'" style="width:65px;" ><img src="/images/bg/bg_img31_s.png" alt="CATALOG"><br /><p style="color:#ccc;font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">CATALOGUE-A</p></span> 
	                            </a>
	                            <br /> 
                                <a href="/nas_img/front/homepage/148-korean.pdf" target="new" style="width:65px;margin-top:5px;">
	                            	<span ng-if="locale == 'ko'" style="width:65px;" ><img src="/images/bg/bg_img31_s.png" alt="CATALOG"><br /><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">고미술도록</p></span>  
                                    <span ng-if="locale != 'ko'" style="width:65px;" ><img src="/images/bg/bg_img31_s.png" alt="CATALOG"><br /><p style="color:#ccc;font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">CATALOGUE-B</strong></p></span> 
	                            </a>
	                            <br />  -->
	                           
	                           <!--  <span ng-if="locale == 'ko'" style="width:65px;" ><a href="https://www.seoulauction.com/noticeList" target="_parent" style="width:80px;margin-top:5px;"> 
	                            	<img src="/images/bg/bg_img09_s.png" alt="CATALOG"><br/><p style="color:#ccc; font-size:11px;font-weight:600; padding-top:3px; padding-bottom:3px;">공지사항</p>
	                            </a></span> 
	                            <span ng-if="locale != 'ko'" style="width:65px;" ><a href="https://www.seoulauction.com/noticeList" target="_parent" style="width:80px;margin-top:5px;">
	                            	<img src="/images/bg/bg_img09_s.png" alt="CATALOG"><br/><p style="color:#ccc; font-size:11px;font-weight:600; padding-top:3px; padding-bottom:3px;">NOTICE</p>
	                            </a></span> -->
                        	</span>
						</div>
                    	<!--오른쪽 more --> 
					</div> <!--ex_title type02--> 
 


				<!--네비게이션. 네비게이션은 웹버전에서만 표시 예정임.--> 
                <div class="col12 web_only" ng-if="locale!='ko' && highlight.length > 0 " align="center" style="border-top:#666 1px solid; overflow: hidden; padding: 10px 0;">   
                    <h2 style="padding: 10px 0; font-weight:900; font-size:25px; padding-bottom: 20px;">SALE HIGHLIGHTS</h2>      
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
                                    <p class="txt-over" ng-bind="naviList.ARTIST_NAME_JSON.en" title="{{naviList.ARTIST_NAME_JSON.en}}" style="font-weight: bold; font-size: 16px; padding-bottom: 10px; height: 21px;"></p>         
                                    <p class="txt-over" ng-bind="naviList.TITLE_JSON.en" title="{{naviList.TITLE_JSON.en}}" style="height: 21px;"></p>             
                                    <span class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD == null && naviList.EXPE_PRICE_FROM_JSON.KRW == null && naviList.EXPE_PRICE_FROM_JSON.USD == null" title="Estimate on Request">Estimate on Request</span>       
                                    <span class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD != null && naviList.EXPE_PRICE_FROM_JSON.KRW != null && naviList.EXPE_PRICE_FROM_JSON.USD != null" ng-bind="base_currency" ng-bind="base_currency"></span>
                                    <span class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD != null && naviList.EXPE_PRICE_FROM_JSON.KRW != null && naviList.EXPE_PRICE_FROM_JSON.USD != null && base_currency == 'HKD'"><span ng-bind="naviList.EXPE_PRICE_FROM_JSON.HKD | number : 0" style="margin-right:5px;"></span> ~ <span ng-bind="naviList.EXPE_PRICE_TO_JSON.HKD | number : 0" style="margin-right:5px;"></span></span>  
                                    <span class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD != null && naviList.EXPE_PRICE_FROM_JSON.KRW != null && naviList.EXPE_PRICE_FROM_JSON.USD != null && base_currency == 'KRW'"><span ng-bind="naviList.EXPE_PRICE_FROM_JSON.KRW | number : 0" style="margin-right:5px;"></span> ~ <span ng-bind="naviList.EXPE_PRICE_TO_JSON.KRW | number : 0" style="margin-right:5px;"></span></span> 
                                    <span class="txt-over highlight_price" ng-if="naviList.EXPE_PRICE_FROM_JSON.HKD != null && naviList.EXPE_PRICE_FROM_JSON.KRW != null && naviList.EXPE_PRICE_FROM_JSON.USD != null && base_currency == 'USD'"><span ng-bind="naviList.EXPE_PRICE_FROM_JSON.USD | number : 0" style="margin-right:5px;"></span> ~ <span ng-bind="naviList.EXPE_PRICE_TO_JSON.USD | number : 0" style="margin-right:5px;"></span></span> 
                                    <span class="txt-over highlight_price" ng-if="naviList.STAT_CD != 'reentry' && naviList.BID_PRICE > 0" ng-bind="sale.CURR_CD"></span>     
                                </div>       
                            </li> 
                        </ul>  
	                </div> 
	                <!-- <div style="display:inline; float:right; margin-top:100px; overflow:visible;"> 
	                        <button type="button" ng-click="naviMove(+1);"><img src="/images/btn/btn_next_right.png" alt="btn_next_right"></button> 
	                </div> --> 
                </div>   
                <!--네비게이션--> 
                
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
                            <span ng-click="checkCateAll();" ng-class="{true: 'list-category-a', false: 'list-category-b'}['all' == selected_cate]" ng-if="locale=='ko'"><a href="#" >전체</a> </span>
                            <span ng-click="checkCateAll();" ng-class="{true: 'list-category-a', false: 'list-category-b'}['all' == selected_cate]" ng-if="locale!='ko'"><a href="#" >All</a> </span>
    <!--CATEGORY-->			<span ng-repeat="cate in category" class="standard" flex="50">
                                    <span ng-if="locale=='ko'" ng-click="cate_toggle(cate.CD_ID, cate_selected)" checklist-model="cate_cds" ng-class="{true: 'list-category-a', false: 'list-category-b'}[cate.CD_ID == selected_cate]"><a href="#" >{{cate.CD_NM}}</a></span>
                                    <span ng-if="locale!='ko'" ng-click="cate_toggle(cate.CD_ID, cate_selected)" checklist-model="cate_cds" ng-class="{true: 'list-category-a', false: 'list-category-b'}[cate.CD_ID == selected_cate]"><a href="#" class="list-category-b">{{cate.CD_NM_EN}}</a></span>  
                            </span>  
                            <span ng-repeat="hashtag in hashtag" class="standard" flex="50">  
                            	<span ng-if="locale=='ko'" ng-click="hashtag_toggle(hashtag.LOT_TAG, hashtag_selected)" checklist-model="hashtag_list"  ng-class="{true: 'list-category-a', false: 'list-category-b'}[hashtag.LOT_TAG == selected_cate]" ><a href="#" >{{hashtag.LOT_TAG}}</a></span> 
                            </span>   
                                
                            <!-- 관심작품보기-->  
							<div class="wish_btn wish_btn_right"> 
								 <!-- 비로그인시 -->        
								<span ng-if="is_login == 'false'">   
	                            	<span class="wish_btnko" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.'); location.href='/login';" checklist-model="fav_cds_list" title="{{locale == 'ko' ? '관심작품 보기' :  'Wish List' }} ">       
		                            	<span class="grid_wish_btn wish_btn_list">        
			                            </span> 
			                            <span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">     
		                            		{{locale == 'ko' ? '관심작품 보기' :  'Wish List' }} 
		                            	</span>    
		                            </span>      
		                        </span> 
	                             <!-- 로그인시 -->
	                            <span ng-if="is_login == 'true'">       
	                            	<span class="wish_btnko" ng-if="!isFavPage" ng-click="fav_toggle(true)" checklist-model="fav_cds_list" title="{{locale == 'ko' ? '관심작품 보기' :  'Wish List' }} ">           
		                            	<span class="grid_wish_btn wish_btn_list"></span>        
		                            	<span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">      
		                            		{{locale == 'ko' ? '관심작품 보기' :  'Wish List' }} 
		                            	</span>      
	                            	</span>   
	                            	
	                            	<span class="wish_btnko"  ng-if="isFavPage" ng-click="fav_toggle(false)" checklist-model="fav_cds_list" title="{{locale == 'ko' ? '전체작품 보기' :  'All List' }} ">         
		                            	<span class="grid_wish_btn wish_btn_list"></span> 
		                            	<span style="font-size: 12px; font-weight: bold; color: #999; vertical-align:middle;">     
		                            		{{locale == 'ko' ? '전체작품 보기' :  'All List' }} 
		                            	</span>
	                            	</span>     
	                            </span>            
	                             
	                            <span ng-if="is_login == 'true' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_outside_yn == 'N'" class="wish_btn">         
	                           		<span class="my_bidlist" ng-click="openPageBlank('/customer/offlineBidReqList?sale_no='+sale.SALE_NO);" style="font-size: 12px; font-weight: bold; color: #999; vertical-align:text-top;">{{locale == 'ko' ? '응찰한 작품 보기' :  'Bidding List' }}</span>
	                            </span> 
							</div>  
							<!-- //관심작품보기--> 
	                    </div>                     
						<!-- <p class="flip"><span ng-if="locale == 'ko'" onClick="openNav()">&#9776; 카테고리검색</span>
											<span ng-if="locale != 'ko'" onClick="openNav()">&#9776; Category Search</span></p>
							<div class="panel">
								
								<div class="side-toggle-menu"> 
	                                  
	                                        <div class="btn_style01 gray02" style="float:right;">
	                                            <button type="button" ng-click="checkAcateAll()">
	                                                <span ng-if="locale == 'ko'">전체초기화</span>
	                                                <span ng-if="locale != 'ko'">Clear</span>
	                                            </button>
	                                        </div> 
	                                        
	                                    
	                                        <a href="#">
	                                            <span style="font-weight:bold" ng-if="locale == 'ko'">카테고리</span>
	                                            <span style="font-weight:bold" ng-if="locale != 'ko'">Category</span>
	                                            <button type="button" ng-click="checkCateAll();">
	                                                <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">✓ 선택해제</font></span>
	                                                <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">✓ Unchecked</font></span>
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
	                                            <span style="font-weight:bold" ng-if="locale == 'ko'">서브카테고리</span>
	                                            <span style="font-weight:bold" ng-if="locale != 'ko'">Sub Category</span>
	                                            <button type="button" ng-click="checkScateAll();">
	                                                <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">✓ 선택해제</font></span>
	                                                <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">✓ Unchecked</font></span>
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
	                                            <span style="font-weight:bold" ng-if="locale == 'ko'">재질</span>
	                                            <span style="font-weight:bold" ng-if="locale != 'ko'">Material</span>
	                                            <button type="button" ng-click="checkMateAll();">
	                                                <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">✓ 선택해제</font></span>
	                                                <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">✓ Unchecked</font></span>
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
	                                            <span style="font-weight:bold" ng-if="locale == 'ko'">작가명</span>
	                                            <span style="font-weight:bold" ng-if="locale != 'ko'">Artist</span>
	                                            <button type="button" ng-click="checkArtistAll();">
	                                                <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">✓ 선택해제</font></span>
	                                                <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">✓ Unchecked</font></span>
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
						<div class="tbl_top web_only02 mt0 t_tbl_top" > <!-- m_ver paging 상단으로 변경 -->
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
											<button ng-if="list_timer_start" ng-click="cancelLotRefresh();"><span>응찰정보자동갱신 중</span></button>
											<button ng-if="!list_timer_start" ng-click="runLotsRefresh();"><span>응찰정보자동갱신</span></button>
										</span> -->
										<label for="" class="tbl_label bar02"><spring:message code="label.sort.by" /></label>
										<select ng-model="sortBy" class="selectbox" path="orderType" >
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
										ng-click="changeViewType('LIST');">
										<span class="hidden"><spring:message code="label.list.vertical" /></span>
									</button>
									<button type="button" class="sp_btn hor" ng-class="viewType=='GRID' ? 'sele' : ''" 
										ng-click="changeViewType('GRID');">
										<span class="hidden"><spring:message code="label.list.horizontal" /></span>
									</button> 
								</div>
								<%-- <div class="type" ng-if="sale_outside_yn == 'Y'">
									<button type="button" class="sp_btn ver" ng-class="viewType=='LIST' ? 'sele' : ''" 
										onclick="location.href='/saleDetail?sale_outside_yn=Y&view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type=LIST&sale_kind=${SALE_KIND_CD}'">
										<span class="hidden"><spring:message code="label.list.vertical" /></span>
									</button>
									<button type="button" class="sp_btn hor" ng-class="viewType=='GRID' ? 'sele' : ''" 
										onclick="location.href='/saleDetail?sale_outside_yn=Y&view_id=${VIEW_ID}&sale_no=${SALE_NO}&view_type=GRID&sale_kind=${SALE_KIND_CD}'">
										<span class="hidden"><spring:message code="label.list.horizontal" /></span>
									</button> 
								</div> --%>
								<span class="btn_style01 white02 icon02 btn_scrollbot flbtn_scrollBtm">
									<button type="button"><spring:message code="label.move.bottom" /></button>
									<span class="ico down"></span>
								</span>
							</div>
						</div>
					</form>

					<div ng-class="viewType == 'LIST' ? 'auction_list' :  'auction_h_list'" style="z-index:8; background-color:#fff">
						<ul id="auctionList">
							<span ng-show="lotList.length > 0" class="icon02 flbtn_scrollTop web_only btn_scroll_fixed"  style="bottom:30px; "> <!-- 61px -->
								<button type="button"><span class="ico up"></span></button>
							</span>
							<!-- <span ng-show="lotList.length > 0" class="icon02 flbtn_scrollBtm web_only btn_scroll_fixed"  style="bottom:30px; "> 
								<button type="button"><span class="ico down"></span></button>
							</span> -->
							<!-- 관심작품 보기이면서 리스트가 없으면 -->
							<div ng-if="isFavPage && lotList.length < 1" class="noListbox"  style=""> 
								<p>{{locale == 'ko'? '관심작품이 없습니다.' : 'There is no WishList.'}}</p><br>
								<span class="btn_style01">
									<button ng-click="fav_toggle(false)">{{locale == 'ko'? '전체작품 보기' : 'View All List'}}</button>
								</span>
							</div>
							<!-- 리스트가 없으면 -->
							<div ng-if="!isFavPage &&lotList.length < 1" class="noListbox"  style=""> 
								<p>{{locale == 'ko'? '검색결과가 없습니다.' : 'There is no List.'}}</p><br>
								<span class="btn_style01">
									<button ng-click="initSerachFilter();">{{locale == 'ko'? '전체작품 보기' : 'View All List'}}</button>
								</span>
							</div>
<!-- 						<div ng-if="lotList.length > 0"> 리스트 1개 이상 있으면-->
								<c:if test="${VIEW_TYPE == 'LIST'}">
									<li ng-if="sale_outside_yn == 'N' && lotList.length > 0" ng-repeat="lot in lotList" ng-init="lot_map[lot.LOT_NO] = lot;" ng-class="$index == lotList.length-2 ? 'lastlot' : ''" on-finish-render-filters>
										<jsp:include page="inc_lotList_List.jsp" flush="false"/>
									</li>
									<li ng-if="sale_outside_yn == 'Y' && lotList.length > 0" ng-repeat="lot in lotList" ng-init="lot_map[lot.LOT_NO] = lot;" ng-class="$index == lotList.length-2 ? ? 'lastlot' : ''" on-finish-render-filters>
										<jsp:include page="inc_outSide_List.jsp" flush="false"/>
									</li>
								</c:if>
								<c:if test="${VIEW_TYPE == 'GRID'}">
									<li ng-if="sale_outside_yn == 'N' && lotList.length > 0" ng-repeat="lot in lotList" ng-init="lot_map[lot.LOT_NO] = lot;" ng-class="$last ? 'lastlot' : ''" on-finish-render-filters>
										<jsp:include page="inc_lotList_Grid.jsp" flush="false"/>
									</li>
									<li ng-if="sale_outside_yn == 'Y' && lotList.length > 0" ng-repeat="lot in lotList" ng-init="lot_map[lot.LOT_NO] = lot;" ng-class="$last ? 'lastlot' : ''" on-finish-render-filters>
										<jsp:include page="inc_outSide_Grid.jsp" flush="false"/>
									</li>
								</c:if>
<!-- 						</div> -->
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
					<div class="wrap_paging"  >
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

var slide_expe_start = 0;
var slide_expe_end = 0;
//$(document).ready(function(){
//	setUiSlider(min_expe_price, max_expe_price, min_expe_price, max_expe_price);
//});

//화폐 구분 변경 이벤트

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
			var endPrice = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];    	// 추정가 같은 경우 0~맥스추정가 설정. YDH
			$("#rangeText").html(comma(parseInt(startPrice, 10)) + " ~ " + comma(parseInt(endPrice, 10)));
		},
		set: function(){
			slide_expe_start = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
			slide_expe_end = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];		// 추정가 같은 경우 0~맥스추정가 설정. YDH
		},
		change: function(){}
	});
	
	$("#estimateRange").Link('lower').to($("#estimatePriceStart"));
	$("#estimateRange").Link('upper').to($("#estimatePriceEnd"));
	
	var startPrice = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
	var endPrice = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];							// 추정가 같은 경우 0~맥스추정가 설정. YDH
	$("#rangeText").html(comma(parseInt(startPrice, 10)) + " ~ " + comma(parseInt(endPrice, 10)));
	slide_expe_start = isNaN($("#estimateRange").val()[0]) ? 0 : $("#estimateRange").val()[0];
	slide_expe_end = isNaN($("#estimateRange").val()[1]) ? nEstimateMax : $("#estimateRange").val()[1];						// 추정가 같은 경우 0~맥스추정가 설정. YDH
}  

/* 온라인패들번호 부여 팝업 */  
$(document).ready(function(){  	
	$('#ipsum').modally('ipsum', {'max-width': 800});
// 	$('#lorem').modally(); 
	$('#Padd_AgreeCheck').modally();       
	
}); 


</script>

<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
