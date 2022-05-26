<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<link href="/css/angular/ng-animation.css" rel="stylesheet">
<link href="/css/angular/ngDialog.min.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">
<link type="text/css" href="/css/imgzoom/jquery.magnify.css" rel="stylesheet">
<link type="text/css" href="/css/imgzoom/magnify-bezelless-theme.css" rel="stylesheet"> 
 
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<!--  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-animate.min.js"></script> -->
<script type="text/javascript" src="/js/angular/angular-animate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script type="text/javascript" src="/js/imgzoom/jquery.magnify.js"></script>

<script> 
app.requires.push.apply(app.requires, ["ngAnimate", "ngDialog"]);

app.controller('lotDetailCtl', function($scope, consts, common, bid, $interval, is_login, locale, $filter) {
	$scope.db_now = null;
	$scope.is_login = is_login;
	$scope.locale = locale;
	$scope.sale_no = ${SALE_NO};
	$scope.sale_status = "READY";
	$scope.lot_no = ${LOT_NO};
	$scope.img_idx = 0;
	
    $scope.loadLotDetail = function(){
		$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no},
 				"actionList":[
 				{"actionID":"sale_info", "actionType":"select" , "tableName": "SALE"},
 				{"actionID":"exch_rate_list", "actionType":"select" , "tableName": "EXCH"},
 			    {"actionID":"lot_info", "actionType":"select" , "tableName": "LOT"},
 			    {"actionID":"lot_images", "actionType":"select" , "tableName": "IMAGES"},
 			    {"actionID":"lot_artist_other_lots", "actionType":"select" , "tableName": "OTHER_LOTS"},
  				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]}
 			 ]};

 		if(is_login == "true"){
	 		/* blueerr 20180810 회차 휴대폰 인증 정보 */
			$d.actionList.push({"actionID":"sale_cert_info", "actionType":"select", "tableName":"CERT"});
			/* blueerr 20180810 회차 휴대폰 인증 정보 */
 		}
 	   	common.callActionSet($d, $sLot, null, finalRefresh);
	}
 	
 	$scope.refreshLots = function(){
 		$d = {"actionList":[
 			    {"actionID":"lot_list_refresh", "actionType":"select" , "tableName": "LOTS" ,"parmsList":[{"sale_no":$scope.sale_no, "lot_nos":[$scope.lot_no]}]}
 			 ]};

 	   	common.callActionSet($d, $sLotRefresh, null, finalRefresh);
	}
	
 	var $sLot = function(data, status) { 
 		$scope.sale = data["tables"]["SALE"]["rows"][0];
 		$scope.db_now = $scope.sale.DB_NOW;
 		$scope.exchRateList = data["tables"]["EXCH"]["rows"];
 		$scope.lot = data["tables"]["LOT"]["rows"][0];
	 	$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
 		
 		var S_DB_NOW = $filter('date')($scope.db_now, 'yyyyMMddHHmmss');
 		var FROM_DT = $filter('date')($scope.lot.FROM_DT, 'yyyyMMddHHmmss');
 		var TO_DT = $filter('date')($scope.lot.TO_DT, 'yyyyMMddHHmmss');
 		var SALE_TO_DT = $filter('date')($scope.lot.TO_DT, 'yyyyMMdd');
 		var DB_NOW_DT = $filter('date')($scope.db_now, 'yyyyMMdd');

 		if(FROM_DT > S_DB_NOW && TO_DT > S_DB_NOW){
 			$scope.sale_status = "READY";
 		}
 		else if((FROM_DT <= S_DB_NOW) && 
			(TO_DT >= S_DB_NOW)){
 			$scope.sale_status = "ING";
 			if(['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && !$scope.now_timer_start){	//$scope.sale.SALE_KIND_CD == 'online' 수정. 2019.12.12 YDH
 				$interval(function(){$scope.db_now = moment($scope.db_now).add(1, 'seconds');}, 1000);
 			} 
 		}
 		else if(TO_DT < S_DB_NOW){
 			$scope.sale_status = "END";
 		}
 		
 		//종료된 경매이고 로그인하지 않은 경우 메인페이지 이동(2018.06.12)
 		if($scope.sale_status == "END" && $scope.is_login == "false"){
  	   		location.href="/"
  	   	}
  	   	//종료된 경매이고 로그인했지만 직원이 아닌경우 메인페이지 이동(2018.06.12)
  	  	if($scope.lot.NEXT_LOT_NO == null && $scope.sale_status == "END" && $scope.is_login == "true" && $scope.custInfo.EMP_GB != "Y"){
  	   		location.href="/"
  	   	}
  	  	
 	    $scope.lot = data["tables"]["LOT"]["rows"][0];
 	    //$scope.sizeList = data["tables"]["SIZES"]["rows"];
 	    $scope.imageList = data["tables"]["IMAGES"]["rows"];
 	    $scope.otherLotList = data["tables"]["OTHER_LOTS"]["rows"];
 	   
 	    //$scope.base_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKD" : "KRW");
 	    $scope.base_currency = $scope.sale.CURR_CD;
 	    $scope.base_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKT" : "KST");
 		//$scope.sub_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KRW" : "HKD");
 		$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
 		$scope.sub_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KST" : "HKT");

 		if($scope.sale_status == "ING" && data.tables.CERT){
	 		$scope.sale_cert = data["tables"]["CERT"]["rows"][0];
 			//bid.saleCertCheck({'parent':$scope, 'sale':$scope.sale}); LOT Detail에서는 체크하지 않음
 		}

 		//var key = $scope.sale.SALE_NO + "" + $scope.lot.LOT_NO;
 		console.log("=======>>>>> end");
 	};
	
	var $sLotRefresh = function(data, status) { 
 		var $d = data["tables"]["LOTS"]["rows"][0];
 		
        if($d && $scope.lot) {
        	$scope.lot["STAT_CD"] = $d["STAT_CD"];
        	$scope.lot["TO_DT"] = $d["TO_DT"];
        	$scope.lot["LAST_PRICE"] = $d["LAST_PRICE"];
        	$scope.lot["END_YN"] = $d["END_YN"];
        	$scope.lot["BID_CNT"] = $d["BID_CNT"];
        	$scope.lot["LAST_CUST_ID"] = $d["LAST_CUST_ID"];
        }
	};

	$scope.runLotsRefresh = function(){
		if(['main','hongkong','plan'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){	//$scope.sale.SALE_KIND_CD != 'online' 수정. 2019.12.12 YDH
 	 		$scope.timer_lots_refresh = $interval($scope.refreshLots, 60000, 1);  //오프라인 경매는 1시간 단위로 refresh처리
 		}
 		if(['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){	//$scope.sale.SALE_KIND_CD == 'online' 수정. 2019.12.12 YDH
 	 		//if(!$scope.modal) 
 	 		$scope.timer_lots_refresh = $interval($scope.refreshLots, 5000, 1);
 		}
	}

	var finalRefresh = function(){
		$scope.runLotsRefresh(); 
	}

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
	
	$scope.duraionEnd = function(){
 		if($scope.duration_end_start) return;
		$scope.duration_end_start = true;
		$interval($scope.refreshLots, 1000, 1);
 	}
	
	$scope.cancelLotRefresh = function(){
		//$interval.cancel($scope.timer_lots_refresh);
		//$scope.list_timer_start = false;
		console.log("========= list reflash cancel");
	}

	$scope.setImgIdx = function(idx){
		$scope.img_idx = idx;
	}
	
	$scope.showBidPopup = bid.showBidPopup;
	$scope.showBidRequestPopup = bid.showBidRequestPopup;
	$scope.showBidHistoryPopup = bid.showBidHistoryPopup;
	$scope.showDetailImagePopup = function () {
		//var elThumbId = "thumb" + $scope.sale.SALE_NO + "" + $scope.lot.LOT_NO;
		m_sImagePath = $("#thumb123").find("li.sele").find("img").attr("src");//$("#" + elThumbId).find("li.sele").find("img").attr("src");
		//m_sImagePath = $("#thumb123").find("li.sele").find("img").css('background-image');
		//m_sImagePath = m_sImagePath.replace(/(url\(|\)|")/g, '');
		m_sImagePath = m_sImagePath.replace("thum/", "");		
		m_sImagePath = m_sImagePath.replace("list/", "");
		m_sImagePath = m_sImagePath.replace("detail/", "");
		
		$(".btn_zoom").click();
	}

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
					alert("A favorite work has been added.\nYou can find your favorite works on your account page.");
					window.location.reload(true);
				}
				return true;
			}
		})		
	};
	
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
					alert("A favorite work has been deleted.");
					window.location.reload(true);
				}
				return true;
			}
		})	
	};
	/* 관심작품 End */
	
	$scope.RCnt = 0;
	$scope.$on('ngRepeatFinished', function (ngRepeatFinishedEvent) {
		$scope.RCnt++;
        if($scope.RCnt == 2){
            $("#rollingBox123").slideFunc("", "#rolling123", "#thumb123");
        }
	});
	
	
	$scope.listBack = function(){
		window.history.back();
	}
	
});

/* // 자세히 보기 팝업
var m_sImagePath ="";
 */ 
</script>


<script type="text/javascript" src="/js/bid.js?ver=20220418"></script>
<script type="text/javascript">
<!--
function shareSns(snsType) {
	var url = "${baseUrl}/auction/currentView?page="+$("#page").val()+"&salesPlanningId="+$("#salesPlanningId").val();
	url += "&artistId="+$("#artistId").val()+"&listType="+$("#listType").val()+"&estimatePriceStart="+$("#estimatePriceStart").val();
	url += "&estimatePriceEnd="+$("#estimatePriceEnd").val()+"&from="+$("#from").val()+"&clientId="+$("#clientId").val()+"&searchName="+$("#searchName").val();
	url += "&searchTitle="+$("#searchTitle").val()+"&estimatePriceCode="+$("#estimatePriceCode").val()+"&lotNumber="+$("#lotNumber").val()+"&orderType="+$("#orderType").val()+"&pageSize="+$("#pageSize").val()+"";
	
	var text = "${map.firstWork.artist.name_kr } ${map.firstWork.workInfo.title_kr }에 대한 서울옥션 경매정보 입니다.";
	
	switch(snsType) {
		case "T" : {
			// 트위터 공유 
			window.open("http://twitter.com/share?text="+encodeURIComponent(text)+"&url="+encodeURIComponent(url));
			break;
		}
		case "F" : {
			// 페이스북 공유
			
			window.open("http://www.facebook.com/sharer.php?u=" + encodeURIComponent(url) , 'recom_icon_pop', 'width=400, height=364, scrollbars=no, resizable=no');
			break;
		}
		case "G" : {
			// 구글플러스 공유
			window.open("https://plus.google.com/share?url=" + encodeURIComponent(url) , 'recom_icon_pop', 'width=400, height=364, scrollbars=no, resizable=no');
			break;
		}
	}
}
//-->

</script>
<body>
<!-- <script>
//YDH 자세히 보기
function OnloadImg(){
	m_sImagePath = $("#thumb123").find("li.sele").find("img").attr("src");
	m_sImagePath = m_sImagePath.replace("thum/", "");		
	m_sImagePath = m_sImagePath.replace("list/", "");
	m_sImagePath = m_sImagePath.replace("detail/", "");
	
	var img=new Image();
	img.src=m_sImagePath;
	var img_width=1200;
	var win_width=1200;
	var height=800;
	var OpenWindow=window.open('/lotDetailImgView?url='+img.src,'_blank', 'width='+img_width+', height='+height+', menubars=no, scrollbars=yes');
	  
	 }	 
</script> -->  
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	
<div class="container_wrap">
	<div class="shadow left"><span class="corner"></span></div>
	<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
	<div id="container" ng-controller="lotDetailCtl" data-ng-init="loadLotDetail();">
		<div class="sub_menu_wrap menu01">
			<div class="sub_menu">
				<jsp:include page="../include/subMenu.jsp" flush="false"/>
			</div>
		</div> 
		<!-- //sub_menu_wrap -->

		<div class="contents_wrap">
			<div class="contents m_top">	
				<div class="btn_wrap top link mt0">
					<div class="left">
						<div class="sns_area">
							<ul class="fl_menu">
								<li><a href="javascript:shareSns('T');" class="sp_btn sns01"><span class="hidden"><spring:message code="label.sns.twitter" /></span></a></li>
								<li><a href="javascript:shareSns('F');" class="sp_btn sns02"><span class="hidden"><spring:message code="label.sns.facebook" /></span></a></li>
								<li><a href="javascript:shareSns('G');" class="sp_btn sns03"><span class="hidden"><spring:message code="label.sns.google" /></span></a></li>
							</ul>
						</div>    
					</div>
                    
					<div class="right" ng-if="${param.SearchYn == Y}">
							<%-- <span class="btn_style01 white02 icon btn_list mbtn">
								<span class="ico list"></span>
								<a href="javascript:goOtherList(543);"><span>목록</span></a>
							</span>
							<span class="btn_style01 white02 icon02 btn_next mbtn">
								<span class="ico next"></span>
								<a href="javascript:goOtherLot(2);"><span>다음</span></a>
							</span> --%>
							<span class="btn_style01 white02 icon btn_list mbtn" ng-click="listBack()">
								<c:choose>
									<c:when test="${param.sale_status == 'ING'}">
										<a href="/saleDetail?view_id=CURRENT_AUCTION&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}">
                                        	<span class="ico list"></span>
											<span ng-if="locale != 'en'">목록</span>
											<span ng-if="locale == 'en'">List</span>
										</a>
									</c:when>
									<c:when test="${param.sale_status == 'END'}">
										<a href="/saleDetail?view_id=RESULT_AUCTION&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}">
                                        	<span class="ico list"></span>
											<span ng-if="locale != 'en'">목록</span>
											<span ng-if="locale == 'en'">List</span>
										</a>
									</c:when>
									<c:otherwise>
										<a href="<%--뒤로가야함--%>">
                                        	<span class="ico list"></span>
											<span ng-if="locale != 'en'">목록</span>
											<span ng-if="locale == 'en'">List</span>
										</a>
									</c:otherwise>
								</c:choose>
							</span>
							<c:if test="${param.view_type == 'LIST' or param.view_type == 'GRID'}">
								<span class="btn_style01 white02 icon btn_prev mbtn" ng-if="lot.PREV_LOT_NO > 0">
									<a href="/lotDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.PREV_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
                                    	<span class="ico prev"></span>
										<span ng-if="locale != 'en'">이전</span>
										<span ng-if="locale == 'en'">Prev</span>
									</a>
								</span>
								<span class="btn_style01 white02 icon02 btn_next mbtn" ng-if="lot.NEXT_LOT_NO > 0">
									<a href="/lotDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.NEXT_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
                                    	<span class="ico next"></span> 
										<span ng-if="locale != 'en'">다음</span>
										<span ng-if="locale == 'en'">Next</span>
									</a>
								</span>
							</c:if>
							<span class="btn_style01 icon02 btn_scrollbot mbtn">
								<button type="button">
									<span ng-if="locale != 'en'">아래로</span>
									<span ng-if="locale == 'en'">Down</span>
								</button>
								<span class="ico down"></span>
							</span>
					</div>
				</div>
				 
				<div class="state_wrap">
					<div class="state_area_detail web_only">
					<%-- 첫번 째 항목에만 진행 상황 보여줌 --%>
						<%-- 온라인 경매 - 시작 전, 진행 중, 종료 상태에 따른 버튼 변경 필요
							시작 전 - 버튼 없음
							진행 중 - 응찰하기
							종료    - 경매 기록보기
						--%>
						<!-- 온라인 경매  -->
						<div ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) >= 0">
                            <div style="font-size:16px; font-weight:700; padding-left:5px; padding-bottom:10px;">
                                <!--임시<span ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0" ng-bind="sale.SALE_TH+sale.SALE_TH_DSP"></span>-->
                                <span ng-bind="sale.TITLE_JSON[locale]"></span>
                            </div>
							<%-- 온라인 경매 시작 전 --%>
							<div ng-if="sale_status == 'READY'">
								<div class="state"><spring:message code="label.auction.start" /></div>
								<div class="info">
									<ul>
										<li class="time"><span ng-bind="(lot.FROM_DT | dateFormat)+' KST 시작'"></span></li>
									</ul>
								</div>
							</div>
							<%-- 온라인 경매 진행 중 --%>
							<%-- 경매 시작가가 없는 경우 추정가 최저가가 시작가가 되야함 --%>
							<div ng-if="sale_status == 'ING'">
								<div class="state"><spring:message code="label.auction.ongoing" /></div>
								<div class="info">
									<ul>
										<li id="leftTime" class="time" ng-if="lot.END_YN != 'Y'"><span ng-bind="db_now | timeDuration : lot.TO_DT"></span></li>
										<li><spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" /></li>
										<li ng-if="lot.BID_CNT > 0"><strong class="txt_red"><spring:message code="label.bid.price" />&nbsp;<span ng-if="lot.LAST_PRICE != null" ng-bind="sale.CURR_CD+' '+(lot.LAST_PRICE | number:0)"></span> <!--KRW <span id="current_price" ng-bind="lot.LAST_PRICE | number:0"></span>--></strong></li>
									</ul>
                                    <!--<span class="btn_style01 xlarge white btn_bid">
										<button type="button" ng-click="showBidPopup({'parent':this, 'sale':sale, 'lot':lot});" >
											<spring:message code="label.go.bid.now" />
										</button>
									</span>-->
								</div>
							</div>						
							<%-- 온라인 경매 종료 --%>
							<div ng-if="sale_status == 'END'">
								<div class="state end" ><spring:message code="label.auction.finish" /></div>
								<div class="info">
									<ul>
										<li class="time"><span ng-bind="(lot.TO_DT | dateFormat)+' KST'"></span> <spring:message code="label.auction.finish" /></li>
										<li><spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" /></li>
										<li><strong class="txt_impo" ng-if="!lot.LAST_PRICE || lot.LAST_PRICE <= 0"><spring:message code="label.auction.unsold" /></strong></li>
										<li><strong class="txt_impo" ng-if="lot.LAST_PRICE > 0"><spring:message code="label.bid.price.sold" /> KRW <span ng-bind="lot.LAST_PRICE | number:0"></span></strong></li>
									</ul>
									<!--<span class="btn_style01 xlarge dark btn_bid">
										<button ng-click="showBidHistoryPopup({'parent':this, 'sale':sale, 'lot':lot});" ><spring:message code="label.go.bid.history" /></button>
									</span>-->
								</div>
							</div>
						</div>
						<!-- //온라인 경매  -->
						
						<!-- 오프라인 경매  -->
					    <div ng-if="['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) >= 0">
							<div class="info">
								<ul>
                                    <li>
                                    <span ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0" ng-bind="sale.SALE_TH+sale.SALE_TH_DSP"></span>
                                    <span ng-bind="sale.TITLE_JSON[locale]"></span>
                                    </li>
									<li class="time">
										<span ng-if="locale != 'ko'">AUCTION</span><span ng-if="locale == 'ko'">경매일시</span> :&nbsp; 
										<!--
										<span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d(EEE) h:mm a' : 'UTC+9' | lowercase)+' '+(base_timezone)+
											'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a' : 'UTC+9' | lowercase)+' '+(sub_timezone)+')'">
									 	</span>
										-->
										<!-- 홍콩경매의 경우에만 서브타임존 표시 -->
										<span ng-bind="(sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.M.d(EEE) h:mm a' : 'UTC+9' | lowercase)+' '+(base_timezone)"></span>
                                        <span ng-if="sale.SALE_KIND_CD == 'hongkong'" 
                                        	ng-bind="'('+(sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a' : 'UTC+9'| lowercase)+' '+(sub_timezone)+')'"></span>
										<!-- 홍콩경매의 경우에만 서브타임존 표시 -->
                                     <br/>
                                     	<span ng-bind="sale.PLACE_JSON[locale]"></span>
									</li>
								</ul>
							</div> 
						</div>
						<!-- //오프라인 경매  -->
						<%-- 전시/PS 건이 노출되는 경우 --%>
						<!-- <span ng-if="['private','exhibit'].indexof(sale.SALE_KIND_CD) >= 0" class="btn_style01 xlarge green02 btn_bid">
							<button type="button" onclick="goInquiryWrite();"><spring:message code="label.go.inquery" /></button>
						</span> -->
					</div>
				</div>
				

				<div class="master_detail">
					<div class="detail">
						<!-- 20150521 -->
						<!-- <div id="rollingBox{{sale.SALE_NO}}{{lot.LOT_NO}}" class="left rolling_box3">-->
						<!-- 직원만 우클릭 가능하게 변경 -->
						<div id="rollingBox123" class="left rolling_box3" ng-if="custInfo.EMP_GB == 'Y'">
							<div class="img_represent">
								<div class="btns rolling_btn">
									<button type="button" class="sp_btn btn_prev"><span class="hidden"><spring:message code="label.move.prev" /></span></button>
									<button type="button" class="sp_btn btn_next"><span class="hidden"><spring:message code="label.move.next" /></span></button>
								</div>
								<!-- <div id="rolling{{sale.SALE_NO}}{{lot.LOT_NO}}" class="hidden_box rolling">-->								

								<div ng-if="sale.SALE_NO <= '408'" id="rolling123" class="hidden_box rolling" >
									<ul style="width: 500px;"> 
										<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<!-- <img oncontextmenu="return false" class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}})'}" style="margin-top: 84px;" alt="{{lot.TITLE}}"/> -->
											<span ng-if="lot.ARTIST_NAME_JSON['ko'] == '김환기' || lot.ARTIST_NAME_JSON['ko'] == '박수근'">
												<a>   
													<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
													alt="{{lot.TITLE}}" style="max-width: 100px; max-height: 100px;"/>       
												</a> 
											</span> 
											<span ng-if="lot.ARTIST_NAME_JSON['ko'] != '김환기' && lot.ARTIST_NAME_JSON['ko'] != '박수근'"> 
												<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">   
													<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
													alt="{{lot.TITLE}}" /> 
												</a>
											</span>   
										</li>
										<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}})'}" style="margin-top: 84px;" alt="{{lot.TITLE}}"/> -->
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" 
												alt="{{lot.TITLE}}" /> 
											</a>
										</li>
									</ul>
								</div>
								<div ng-if="sale.SALE_NO >= '409'" id="rolling123" class="hidden_box rolling" >
									<ul style="width: 500px;">   
										<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<!-- <img oncontextmenu="return false" class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}})'}" style="margin-top: 84px;" alt="{{lot.TITLE}}"/> -->
											<span ng-if="lot.ARTIST_NAME_JSON['ko'] == '김환기' || lot.ARTIST_NAME_JSON['ko'] == '박수근'">  
												<a>   
													<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
													alt="{{lot.TITLE}}" />      
												</a>
											</span> 
											<span ng-if="lot.ARTIST_NAME_JSON['ko'] != '김환기' && lot.ARTIST_NAME_JSON['ko'] != '박수근'"> 
												<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">   
													<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
													alt="{{lot.TITLE}}" />  
												</a>
											</span> 
										</li>
										<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}})'}" style="margin-top: 84px;" alt="{{lot.TITLE}}"/> -->
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
												alt="{{lot.TITLE}}" /> 
											</a> 
										</li>
									</ul>
								</div>
							</div>
							<!-- <div id="thumb{{sale.SALE_NO}}{{lot.LOT_NO}}" class="thumb_list">-->
							<div ng-if="sale.SALE_NO <= '408'" id="thumb123" class="thumb_list" oncontextmenu="return false" ondragstart="return false" >
								<ul>
									<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
										<span>
											<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH : true}}"
											 alt="{{lot.TITLE_JSON[locale]}}" ng-click="setImgIdx($index);" />
											<span class="masking"></span>
										</span>
									</li>
									<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
										<span>
											<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH : true}}"
											 alt="{{lot.TITLE_JSON[locale]}}" ng-click="setImgIdx($index);" />
											<span class="masking"></span>
										</span>
									</li>
								</ul>
							</div>
							<div ng-if="sale.SALE_NO >= '409'" id="thumb123" class="thumb_list" oncontextmenu="return false" ondragstart="return false" >
								<ul>
									<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
										<span>
											<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'list'}}" 
											 alt="{{lot.TITLE_JSON[locale]}}" ng-click="setImgIdx($index);" />
											<span class="masking"></span>
										</span>
									</li>
									<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
										<span>
											<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'list'}}" 
											 alt="{{lot.TITLE_JSON[locale]}}" ng-click="setImgIdx($index);" />
											<span class="masking"></span>
										</span> 
									</li>
								</ul>
							</div> 
							<!-- <a onClick="OnloadImg();" class="btn_view" style="cursor:pointer;">
								<span ng-if="locale != 'en'">자세히보기</span>
								<span ng-if="locale == 'en'">&nbsp;&nbsp;&nbsp;Details&nbsp;&nbsp;</span>
							</a> --> 
						</div>
						<div id="rollingBox123" class="left rolling_box3" ng-if="custInfo.EMP_GB != 'Y'" oncontextmenu="return false">
							<div class="img_represent">
								<div class="btns rolling_btn">
									<button type="button" class="sp_btn btn_prev"><span class="hidden"><spring:message code="label.move.prev" /></span></button>
									<button type="button" class="sp_btn btn_next"><span class="hidden"><spring:message code="label.move.next" /></span></button>
								</div>
								<!-- <div id="rolling{{sale.SALE_NO}}{{lot.LOT_NO}}" class="hidden_box rolling">-->								
								
								<div ng-if="sale.SALE_NO <= '408'" id="rolling123" class="hidden_box rolling"> 
									<ul style="width: 500px;">
										<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<!-- <img oncontextmenu="return false" class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}})'}" style="margin-top: 84px;" alt="{{lot.TITLE}}"/> -->
											<img ng-if="lot.IMG_DISP_YN == 'N'" img ng-src="/images/bg/no_image.jpg" />
											<span ng-if="lot.ARTIST_NAME_JSON['ko'] == '김환기' || lot.ARTIST_NAME_JSON['ko'] == '박수근'"> 
												<a>  
													<img ng-if="lot.IMG_DISP_YN == 'Y'" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" 
													alt="{{lot.TITLE}}" style="max-width: 100px; max-height: 100px;"/>      
												</a> 
											</span>
											<span ng-if="lot.ARTIST_NAME_JSON['ko'] != '김환기' && lot.ARTIST_NAME_JSON['ko'] != '박수근'">   
												<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기"> 
													<img ng-if="lot.IMG_DISP_YN == 'Y'" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
													alt="{{lot.TITLE}}" /> 
												</a>  
											</span>
										</li>
										<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}})'}" style="margin-top: 84px;" alt="{{lot.TITLE}}"/> -->
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" 
												alt="{{lot.TITLE}}" /> 
											</a>
										</li> 
									</ul>
								</div>
								<div ng-if="sale.SALE_NO >= '409'" id="rolling123" class="hidden_box rolling" >
									<ul style="width: 500px;">
										<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<!-- <img oncontextmenu="return false" class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}})'}" style="margin-top: 84px;" alt="{{lot.TITLE}}"/> -->
											<img ng-if="lot.IMG_DISP_YN == 'N'" img ng-src="/images/bg/no_image.jpg" />
											<span ng-if="lot.ARTIST_NAME_JSON['ko'] == '김환기' || lot.ARTIST_NAME_JSON['ko'] == '박수근'">
												<a>  
													<img ng-if="lot.IMG_DISP_YN == 'Y'" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
													alt="{{lot.TITLE}}" />   
												</a>   
											</span> 
											<span ng-if="lot.ARTIST_NAME_JSON['ko'] != '김환기' && lot.ARTIST_NAME_JSON['ko'] != '박수근'">  
												<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기"> 
													<img ng-if="lot.IMG_DISP_YN == 'Y'" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
													alt="{{lot.TITLE}}" /> 
												</a>   
											</span>
										</li>
										<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}})'}" style="margin-top: 84px;" alt="{{lot.TITLE}}"/> -->
											<img ng-if="lot.IMG_DISP_YN == 'N'" img ng-src="/images/bg/no_image.jpg" />
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
												<img ng-if="lot.IMG_DISP_YN == 'Y'" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
												alt="{{lot.TITLE}}" /> 
											</a>  
										</li>
									</ul>
								</div>
							</div>
							<!-- <div id="thumb{{sale.SALE_NO}}{{lot.LOT_NO}}" class="thumb_list">-->
							<div ng-if="sale.SALE_NO <= '408'" id="thumb123" class="thumb_list" oncontextmenu="return false" ondragstart="return false" >
								<ul>
									<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
										<span>
											<img ng-if="lot.IMG_DISP_YN == 'N'" img ng-src="/images/bg/no_image.jpg" />
											<img ng-if="lot.IMG_DISP_YN == 'Y'" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH : true}}"
											 alt="{{lot.TITLE_JSON[locale]}}" ng-click="setImgIdx($index);" />
											<span class="masking"></span>
										</span>
									</li>
									<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
										<span>
											<img ng-if="lot.IMG_DISP_YN == 'N'" img ng-src="/images/bg/no_image.jpg" />
											<img ng-if="lot.IMG_DISP_YN == 'Y'" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH : true}}"
											 alt="{{lot.TITLE_JSON[locale]}}" ng-click="setImgIdx($index);" />
											<span class="masking"></span> 
										</span>
									</li>
								</ul>
							</div>
							<div ng-if="sale.SALE_NO >= '409'" id="thumb123" class="thumb_list" oncontextmenu="return false" ondragstart="return false" >
								<ul>
									<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
										<span>
										<img ng-if="lot.IMG_DISP_YN == 'N'" img ng-src="/images/bg/no_image.jpg" />
											<img ng-if="lot.IMG_DISP_YN == 'Y'" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'list'}}" 
											 alt="{{lot.TITLE_JSON[locale]}}" ng-click="setImgIdx($index);" />
											<span class="masking"></span> 
										</span>
									</li>
									<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
										<span>
										<img ng-if="lot.IMG_DISP_YN == 'N'" img ng-src="/images/bg/no_image.jpg" />
											<img ng-if="lot.IMG_DISP_YN == 'Y'" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'list'}}" 
											 alt="{{lot.TITLE_JSON[locale]}}" ng-click="setImgIdx($index);" />
											<span class="masking"></span>
										</span> 
									</li>
								</ul> 
							</div>
							<!-- <a onClick="OnloadImg();" class="btn_view" style="cursor:pointer;">
								<span ng-if="locale != 'en'">자세히보기</span>
								<span ng-if="locale == 'en'">&nbsp;&nbsp;&nbsp;Details&nbsp;&nbsp;</span>
							</a> -->   
						</div>
												
						
						<!-- //20150521 -->
						<div class="right" style="cursor:default;">  
							<div class="author">     
								<div class="lot detail_lot">  
									<div style="display: inline-block;">  
										<span>Lot.</span>       
										<strong>
											<span ng-if="sale.SALE_NO == '410'">
												<span ng-if="lot.LOT_NO != '91' && lot.LOT_NO != '92'" ng-bind="lot.LOT_NO" title="{{lot.LOT_NO}}"></span> 
												<span ng-if="lot.LOT_NO == '91'" ng-init="SLOT01='S01';SLOT02='S02'" ng-bind="SLOT01"></span> 
												<span ng-if="lot.LOT_NO == '92'" ng-init="SLOT01='S01';SLOT02='S02'" ng-bind="SLOT02"></span>  
											</span>
											<span ng-if="sale.SALE_NO != '410'" ng-bind="lot.LOT_NO" title="{{lot.LOT_NO}}"></span> 
										</strong>
									</div>   
									
									<div class="wish_btn"> 
										<button type="button">  
											<span ng-if="lot.STAT_CD != 'reentry'">    
									             <span ng-if="!custInfo.CUST_NO" class="grid_wish_btn" onClick="alert('로그인 해주세요.\n Please login for use.')" title="관심작품 보기 / WishiList"> </span>  
									             <span ng-if="custInfo.CUST_NO && lot.INTE_LOT_DEL == 'N'" class="grid_wish_btn grid_wish_btn_sele" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishiList"></span>
									             <span ng-if="custInfo.CUST_NO  && lot.INTE_LOT_DEL != 'N' && lot.STAT_CD != 'reentry'" class="grid_wish_btn" ng-click="inteSave({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishiList"></span>  
								            </span> 
								        </button>  
									</div>    
								</div><!-- //lot -->     
								<div class="name" id="artist_name">  
									<span ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}"></span>
								</div>  
								<div class="lang"> 
									<span ng-if="locale != 'en'" ng-bind="lot.ARTIST_NAME_JSON.en" title="{{lot.ARTIST_NAME_JSON.en}}"></span>  
									<span class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh" title="{{lot.ARTIST_NAME_JSON.zh}}"></span> 
								</div>
								<div class="year"><span ng-if="lot.BORN_YEAR!=null" ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')" title="{{(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')}}"></span></div> 
							</div> 
							<!-- 홍콩경매 여부에 따른 화면표시 확인 --> 
							<div class="title">  
								<%-- 작품제목 중복인경우 하나만 보여주기(2015.11.17. YDH) --%>
								<div class="tit" id="workTitle">
									<p style="padding-bottom: 5px;">  
										<span ng-bind="lot.TITLE_JSON[locale]" title="{{lot.TITLE_JSON[locale]}}"></span>
									</p>  
									<p> 
										<span ng-bind="lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale]"></span>
									</p>   
									<p ng-if="lot.TITLE_JSON['zh'] != lot.TITLE_JSON['en']">    
										<span ng-if="lot.TITLE_JSON.zh != null" ng-bind="lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale]"></span>
									</p> 
									<p>
										<span ng-bind="lot.STITLE_JSON[locale]"></span> 
									</p>  
									<p ng-if="locale == 'en'"><span ng-if="lot.STITLE_JSON.ko != null && lot.STITLE_JSON.ko != lot.STITLE_JSON.en" ng-bind="lot.STITLE_JSON.ko"></span></p>
									<p ng-if="locale != 'en'"><span ng-if="lot.STITLE_JSON.en != null && lot.STITLE_JSON.ko != lot.STITLE_JSON.en" ng-bind="lot.STITLE_JSON.en"></span></p>
									<p ng-if="lot.STITLE_JSON['zh'] != lot.STITLE_JSON['en']">
										<span ng-if="lot.STITLE_JSON.zh != null" ng-bind="lot.STITLE_JSON.zh | trimSameCheck : lot.STITLE_JSON[locale]"></span>
									</p>
								</div> 
								<div class="mat"> 
									<p>
										<span ng-if="lot.MATE_NM_EN" ng-bind="'MATE_NM_EN' | localeValue : lot" title="{{lot.MATE_NM_EN}}"></span>
									</p>
									<!-- <p ng-if="locale == 'ko' && lot.MATE_NM_EN != lot.MATE_NM"><span ng-bind="lot.MATE_NM_EN"></span></p> //2018.08.30 캡션간소화처리(YDH) -->
									<p ng-repeat="size in lot.LOT_SIZE_JSON">
										<span ng-if="locale!='ko'" ng-bind="size | size_text" title="{{size | size_text}}"></span>  
										<span ng-if="locale=='ko'" ng-bind="size | size_text_cm" title="{{size | size_text_cm}}"></span>    
									</p> 
									<p ng-if='lot.EDITION'><span ng-bind="lot.EDITION"></span></p>
									<p ng-if='lot.MAKE_YEAR_JSON[locale]'>  
										<span ng-bind="lot.MAKE_YEAR_JSON['ko']" title="{{lot.MAKE_YEAR_JSON['ko']}}"></span>    
										<!--	{{lot.MAKE_YEAR_JSON[locale]}}  
									  	{{lot.MAKE_YEAR_JSON["en"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}
										<span ng-if="lot.MAKE_YEAR_JSON['zh'] != lot.MAKE_YEAR_JSON['en'] && lot.MAKE_YEAR_JSON['zh'] != null">
										{{lot.MAKE_YEAR_JSON["zh"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}</span> -->
									</p>
									<p ng-if='lot.SIGN_INFO_JSON[locale]'>
										<span bind-html-compile="lot.SIGN_INFO_JSON[locale]" title="{{lot.SIGN_INFO_JSON[locale]}}"></span>    
									<!--	<span bind-html-compile="lot.SIGN_INFO_JSON[locale]"></span>
									  	<span ng-if="lot.SIGN_INFO_JSON['en'] != lot.SIGN_INFO_JSON[locale]"><span bind-html-compile="lot.SIGN_INFO_JSON["en"]"></span></span>
										<span ng-if="lot.SIGN_INFO_JSON['zh'] != lot.SIGN_INFO_JSON[locale] && lot.SIGN_INFO_JSON['zh'] != null"><span bind-html-compile="lot.SIGN_INFO_JSON["zh"]""></span></span> -->
									</p>
								</div> 
							</div>
							
							<div class="price">   
								<div ng-if="((lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null) || ((lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0  && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null)"><strong><spring:message code="label.expense.price" /></strong></div>
								<div class="mat">    
									<!-- 추정가 별도문의 -->  
									<p style="font-weight: 900; font-size: 14px;">   
										<span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
									</p>     
									<div style="padding-top: 7px; padding-bottom: 15px;" ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && ((lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null) || ((lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null)">
										<!-- 기준통화 -->   
										<p>
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)">
											 ~ 
											</span>	
											<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
										</p>
										<!-- USD -->
										<p ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null) || (lot.EXPE_PRICE_FROM_JSON.USD != 0) || (lot.EXPE_PRICE_TO_JSON.USD != 0)">
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)">
											 ~ 
											</span>	 
											<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
										</p>
										<!-- 서브통화 -->
										<p ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null) || (lot.EXPE_PRICE_FROM_JSON[sub_currency] != 0 ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != 0)">
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)">
											 ~ 
											</span>	 
											<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
										</p>  
									</div> 
									<!-- 시작가 -->          
									<div style="padding-bottom:15px;" ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.START_PRICE > 0">
										<span class="txt_dark"><spring:message code="label.expense.start_price" /></span>  
										<p>KRW <span ng-bind="lot.START_PRICE | number : 0"></span></p> 
									</div>  	 
									<!--시작가끝-->   
									<p>      
										<strong class="txt_red"> 
											<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && lot.BID_CNT > 0"><spring:message code="label.bid.price" /></span>
											<span ng-if="sale_status == 'END' && lot.LAST_PRICE >= 0 && lot.BID_CNT > 0"><spring:message code="label.bid.price.sold" /></span>
                                            <span ng-if="lot.LAST_PRICE != null && sale_status != 'ING' && lot.LAST_PRICE >= 0 && lot.BID_CNT > 0" ng-bind="sale.CURR_CD+' '+(lot.LAST_PRICE | number:0)"></span>
                                            <span ng-if="lot.LAST_PRICE >= 0 && sale_status == 'ING' && lot.LAST_PRICE != null" ng-bind="(sale.CURR_CD)+' '+(lot.LAST_PRICE | number:0)"></span>   
										</strong> 
									</p>  
								</div>
							</div>
							
							<div class="title" ng-if='lot.COND_RPT_JSON[locale] || lot.FRAME_CD!="none"'> 
								<div class="mat"> 		 							  
									<p>      
										<span ng-if='lot.COND_RPT_JSON[locale] || lot.FRAME_CD!="none"'>【Condition】&nbsp;&nbsp;</span>
										<span ng-if="lot.FRAME_CD!='none'" ng-bind="lot.FRAME_CD"></span>       
										<br><span ng-if='lot.COND_RPT_JSON[locale]' bind-html-compile="lot.COND_RPT_JSON[locale]"></span>     
										<!--<span ng-bind="lot.COND_RPT_JSON['en'] | trimSameCheck : lot.COND_RPT_JSON[locale]"></span>-->  
										<!--<p ng-if="lot.COND_RPT_JSON['zh'] != lot.COND_RPT_JSON['en']">
											<span ng-bind="lot.COND_RPT_JSON['zh'] | trimSameCheck : lot.COND_RPT_JSON[locale]"></span>
										</p>--> 
									</p>  
								</div>  
							</div> 
							
							
                            <div class="title" >   
								<div class="mat">  
									<p ng-if="locale == 'ko'" class="inquiry_no_email">
										<span ng-if="sale.SALE_NO != 422" class="inquiry_no_email_lang">     
                                    		<span>    
												<a href="tel:02-395-0330">작품문의: 02-395-0330</a>   
											</span>  
	                                    	<!-- <span style="margin-top: 20px;">      
		                                    	<a href="" target="_blank">    
		                                        	<strong><span style="color:#62c3bc;">버튼링크 </span></strong> 
		                                        </a>
		                                    </span> -->  
                                    	</span>
                                    	 
                                    	<span ng-if="sale.SALE_NO == '422'" class="inquiry_no_email_lang">  
                                    		<!-- <span>
	                                    		<a href="mailto:specialist@artsy.net">specialist@artsy.net</a>
                                    		</span>  -->
                                    		<span> 
												<a href="tel:02-395-0330">작품문의: 02-395-0330</a>   
											</span> 
											<!-- 버튼링크 -->
                                    		<!-- <span style="margin-top: 20px;">  
                                    			<a href="" target="_blank"> 
		                                        	<strong><span style="color:#62c3bc;">버튼링크</span></strong>    
		                                        </a>
                                    		</span> -->    
                                    	</span>    
                                    </p> 
									<!-- <p ng-if="locale == 'ko'">작품문의: 02-395-0330</p> -->
                                    
									<p ng-if="locale == 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p>
                                    <p ng-if="locale != 'ko' && sale.SALE_KIND_CD != 'hongkong'"> 
                                    	<a href="mailto: info@seoulauction.com">E-mail: info@seoulauction.com</a>  
                                    </p>
                                    <p ng-if="locale != 'ko' && sale.SALE_KIND_CD == 'hongkong'"> 
                                    	<a href="mailto:saplus@seoulauction.com">E-mail: saplus@seoulauction.com</a>   
                                    </p>
                                    <p ng-if="locale != 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p>

                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN == 'Y'" >
                                        <li><spring:message code="label.auction.soldpricelog" /></li>
                                    </ul>
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <%-- <li><spring:message code="label.auction.loginlog" /></li> --%>
                                        <!--<li><spring:message code="label.auction.loginlog_1" /></li>-->
                                    </ul>
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') >= (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li><spring:message code="label.auction.loginlog1" /></li>
                                    </ul>
                                    <ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD != 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.MEMBERSHIP_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>	
                                    <ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD == 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.FORE_BID_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>
								</div> 
							</div> 
                            
                            <%--  <div class="title" ng-if ="lot.SALE_NO==483" >
								<div class="mat">
									<p ng-if="locale == 'ko'">작품문의: 02-395-0330</p>
									<p ng-if="locale == 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p>
                                    <p ng-if="locale != 'ko' && sale.SALE_KIND_CD != 'hongkong'">E-mail: info@seoulauction.com</p>
                                    <p ng-if="locale != 'ko' && sale.SALE_KIND_CD == 'hongkong'">E-mail: saplus@seoulauction.com</p>
                                    <p ng-if="locale != 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p>
                                    <!--<p ng-if="sale.SALE_KIND_CD != 'hongkong'">
                                         <br/><span ng-if="locale == 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60">테스트 경매입니다. 응찰을 하셔도 실제 낙찰과는 무관합니다.<br/>실제 환경과 동일 조건에서 테스트 중입니다. </p>
                                         
                                         <br/><p ng-if="locale != 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60"">TEST AUCTION. Even if you make a bid, it doesn't really matter.</span>
                                    </p>-->
                                    <p ng-if="locale == 'ko' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
                                        작품 컨디션은 주관적인 견해에 따라 다를 수 있습니다. 재질의 특성상 울음 등의 변형이 있을 수 있으니  반드시 '실물 확인' 후 응찰 해주시기 바랍니다.</br>
                                        컨디션에 액자 상태는 포함되지 않으며, 작품을 직접 확인하지 못하여 발생하는 모든 책임은 응찰자에게 있습니다.</br>
                                        응찰 및 낙찰 취소는 불가합니다. 부득이한 사유로 낙찰 취소시, 낙찰가의 30%에 해당하는 위약금이 발생합니다.</br>
                                        <font style="font-weight:700">
                                        작품은 보증서가 발급되지 않으며, 전 작품은 컨디션, 제작시기, 작품 정보에 대한 보증을 하지 않습니다.</br>
                                        응찰은 작품 컨디션을 확인 후 진행 되는 것을 전제로 하며, 컨디션에 액자 상태는 포함되지 않습니다.</br>
                                        배송 : 운송 및 포장 등 출고에 대한 모든 사항은 낙찰자 본인 책임 하의 유료 배송을 원칙으로 합니다.
                                        </font>
                                    </p>
                                    <p ng-if="locale != 'ko' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 ">
                                        The condition of the artwork may vary based on subjective opinion, and changes in the material may occur due to the innate characteristics of such material. (As wrinkles may form in the material of an artwork, altering the appearance of the work, please make sure to check the condition of the actual artwork before making your bid.)</br>
                                        Details on the condition of the artwork’s frame are not included in the description of the condition of the artwork itself. The bidder alone is responsible for checking the condition of the actual/physical artwork.</br>
                                        A (successful) bid can be cancelled with a penalty. In the event a bid must be cancelled, the bidder must pay a penalty corresponding to 30 percent of the successful bid price.</br>
                                       
                                        If the artwork requires installation, etc., a separate fee shall be incurred by the bidder.</br>
Bidding will take place after a final check of the artwork’s condition. The condition of the frame is not added in the condition report. </br>
All auction item will not be guaranteed.</br>
* Shipping fee is not included. At the responsibilities and expenses of a buyer, the Company may make arrangements of shipping of items and a buyer wishes for such delivery of properties. </br>
                                    </p>
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN == 'Y'" >
                                        <li><spring:message code="label.auction.soldpricelog" /></li>
                                    </ul>
                                    <!-- <span ng-if="!is_login && sale_status == 'ING' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">  -->
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li><spring:message code="label.auction.loginlog" /></li>
                                        <li><spring:message code="label.auction.loginlog_1" /></li>
                                    </ul>
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') >= (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li><spring:message code="label.auction.loginlog1" /></li>
                                    </ul>
                                    <ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD != 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.MEMBERSHIP_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>	
                                    <ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD == 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.FORE_BID_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>
								</div> 
							</div> --%>
                            
                            
                            
                          <%--   <div class="title" ng-if ="lot.SALE_NO==472" >
								<div class="mat">
									<p ng-if="locale == 'ko'">작품문의: 02-395-0330</p>
									<p ng-if="locale == 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p>
                                    <p ng-if="locale != 'ko' && sale.SALE_KIND_CD != 'hongkong'">E-mail: info@seoulauction.com</p>
                                    <p ng-if="locale != 'ko' && sale.SALE_KIND_CD == 'hongkong'">E-mail: saplus@seoulauction.com</p>
                                    <p ng-if="locale != 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p>

                                    <p ng-if="locale == 'ko' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
                                        작품 컨디션은 주관적인 견해에 따라 다를 수 있습니다. 재질의 특성상 울음 등의 변형이 있을 수 있으니  반드시 '실물 확인' 후 응찰 해주시기 바랍니다.</br>
                                        컨디션에 액자 상태는 포함되지 않으며, 작품을 직접 확인하지 못하여 발생하는 모든 책임은 응찰자에게 있습니다.</br>
                                        응찰 및 낙찰 취소는 불가합니다. 부득이한 사유로 낙찰 취소시, 낙찰가의 30%에 해당하는 위약금이 발생합니다.</br>
                                        출품작 중 일부는 문화재 보호법상의 문화재에 해당되므로 해외반출이 불가하오니 이 점 유의하시기 바랍니다.</br>
                                        <font style="font-weight:700">
                                        배송 : <br/>
                                        - 구매수수료: 18% (부가세 별도), 낙찰작품 배송은 유료입니다.<br/>
                                        - 작품은 낙찰 후 7일 이내 출고해야 합니다.<br/>
                                        </font>
                                    </p>
                                    <p ng-if="locale != 'ko' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 ">
                                        The condition of the artwork may vary based on subjective opinion, and changes in the material may occur due to the innate characteristics of such material. (As wrinkles may form in the material of an artwork, altering the appearance of the work, please make sure to check the condition of the actual artwork before making your bid.)</br>
                                        Details on the condition of the artwork’s frame are not included in the description of the condition of the artwork itself. The bidder alone is responsible for checking the condition of the actual/physical artwork.</br>
                                        A (successful) bid can be cancelled with a penalty. In the event a bid must be cancelled, the bidder must pay a penalty corresponding to 30 percent of the successful bid price.</br>
                                       
                                        If the artwork requires installation, etc., a separate fee shall be incurred by the bidder.</br>
                                        The part of Korean traditional works cannot be carried out abroad, because of the Cultural Properties Protection Law.</br>
 The bidding is conducted on the premise that the bidder has identified the condition of artworks. Some of the artworks may have copies, so please make a careful bid.</br>
Shipping : </br>
* Buyer’s Premium: 18% (VAT excluded), Shipping fee is not included.<br/>
* The works must be shipped within 7 days.<br/>


                                    </p>
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN == 'Y'" >
                                        <li><spring:message code="label.auction.soldpricelog" /></li>
                                    </ul>
                                    <!-- <span ng-if="!is_login && sale_status == 'ING' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">  -->
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && 'ING' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li><spring:message code="label.auction.loginlog" /></li>
                                        <li><spring:message code="label.auction.loginlog_1" /></li>
                                    </ul>
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') >= (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li><spring:message code="label.auction.loginlog1" /></li>
                                    </ul>
                                    <ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD != 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.MEMBERSHIP_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>	
                                    <ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD == 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.FORE_BID_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>
								</div> 
							</div> --%>
							
							
							
							<%-- <div class="title" ng-if ="[474, 472, 476, 478, 482, 483, 484, 487, 488, 489, 490, 493, 494].indexOf(sale.SALE_NO) < 0" >
								<div class="mat">
									<p ng-if="locale == 'ko'">작품문의: 02-395-0330</p>
									<p ng-if="locale == 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p>
                                    <p ng-if="locale != 'ko' && sale.SALE_KIND_CD != 'hongkong'">E-mail: info@seoulauction.com</p>
                                    <p ng-if="locale != 'ko' && sale.SALE_KIND_CD == 'hongkong'">E-mail: saplus@seoulauction.com</p>
                                    <p ng-if="locale != 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p>
                                    <!--<p ng-if="sale.SALE_KIND_CD != 'hongkong'">
                                         <br/><span ng-if="locale == 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60">테스트 경매입니다. 응찰을 하셔도 실제 낙찰과는 무관합니다.<br/>실제 환경과 동일 조건에서 테스트 중입니다. </p>
                                         
                                         <br/><p ng-if="locale != 'ko' && sale.SALE_NO == '422' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 " style="font-weight:600; color:#F60"">TEST AUCTION. Even if you make a bid, it doesn't really matter.</span>
                                    </p>-->
                                    <p ng-if="locale == 'ko' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
                                        작품 컨디션은 주관적인 견해에 따라 다를 수 있습니다. 재질의 특성상 울음 등의 변형이 있을 수 있으니  반드시 실물 확인 후 응찰 해주시기 바랍니다.</br>
                                        컨디션에 액자 상태는 포함되지 않으며, 작품을 직접 확인하지 못하여 발생하는 모든 책임은 응찰자에게 있습니다.</br>
                                        응찰 및 낙찰 취소는 불가합니다. 부득이한 사유로 낙찰 취소시, 낙찰가의 30%에 해당하는 위약금이 발생합니다.</br>
                                        <span ng-if="lot.SALE_NO != 451">결제금액 : 낙찰 후 최종 결제금액은 낙찰금액+구매수수료(18%+VAT)입니다.</br></span>
                                        <span ng-if="lot.SALE_NO == 451">결제금액 : 낙찰 후 최종 결제금액은 낙찰금액+구매수수료(10%+VAT)입니다.  Lot 48-64 번은 구매수수료가 없습니다.</br></span>
                                        <span ng-if="lot.SALE_NO != 451">배송 : <br/>
                                        - 서울 및 수도권 지역 무료 배송 진행<br/>
                                        - 수도권 외 지역은 월 2회 운송사 지정 일정(주말 포함)에 맞춰 일괄 무료 배송 진행<br/>
                                        - 상기 일정 외 개별 운송 진행 및 도서 산간(제주 포함)지역 운송의 경우 운송비 고객 부담 <br/>
                                        - 특수 설치 및 추가 운송 인력 소요 작품의 경우 고객 비용 부담<br/> 
                                        - 배송관련 문의: 02-2075-4404<br/>
                                    </p>
                                    <p ng-if="locale != 'ko' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 ">
                                        The condition of the artwork may vary based on subjective opinion, and changes in the material may occur due to the innate characteristics of such material. (As wrinkles may form in the material of an artwork, altering the appearance of the work, please make sure to check the condition of the actual artwork before making your bid.)</br>
                                        Details on the condition of the artwork’s frame are not included in the description of the condition of the artwork itself. The bidder alone is responsible for checking the condition of the actual/physical artwork.</br>
                                        A (successful) bid can be cancelled with a penalty. In the event a bid must be cancelled, the bidder must pay a penalty corresponding to 30 percent of the successful bid price.</br>
                                        <span ng-if="lot.SALE_NO != 451">Buyer’s Premium: 18% (VAT excluded), Shipping fee is not included.</br></span>
                                        <span ng-if="lot.SALE_NO == 451">Lot 1-47 : Buyer’s Premium is 10% ((VAT excluded). Fees will be transferred to the Overseas Korean Cultural heritage as a donation. Lot 48-64: There is no Buyer’s Premium.</br></span>
                                        If the artwork requires installation, etc., a separate fee shall be incurred by the bidder.</br>
                                         
                                        -Shipping fee is free of charge for Seoul and Gyeonggi-do. For other provinces, it will be shipped twice a month on the designated day for free of charge. (Including weekend) </br>
                                        - Additional fee is charged for individual shipping, mountainous, remotes areas, Jeju Island and overseas.</br>
                                        - Additional fee is paid to the on-site employee who does the installation and artworks that require additional personnel for installation. (Quotation will be provided in advance)</br>
                                        -Inquiry: +82 2-2075-4404</br>
                                    </p>
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN == 'Y'" >
                                        <li><spring:message code="label.auction.soldpricelog" /></li>
                                    </ul>
                                    <!-- <span ng-if="!is_login && sale_status == 'ING' && 'ING' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">  -->
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li><spring:message code="label.auction.loginlog" /></li>
                                        <li><spring:message code="label.auction.loginlog_1" /></li>
                                    </ul>
                                    <ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') >= (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li><spring:message code="label.auction.loginlog1" /></li>
                                    </ul>
                                    <ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD != 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.MEMBERSHIP_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>	
                                    <ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD == 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.FORE_BID_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>
								</div> 
							</div> --%>
							
							
							

							<!-- YBK. 출력버튼 추가 -->
							
							<div class="info">
								<!-- YDH. 경매관련 버튼 추가 -->
								 <span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge2 dark btn_bid" 
									ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'Y'">
									<button ng-if="custInfo.CUST_NO" ng-click="showBidHistoryPopup({'parent':this, 'sale':sale, 'lot':lot});" >
										<spring:message code="label.go.bid.history" />
									</button><!--온라인응찰기록 -->
                                    <button ng-if="!custInfo.CUST_NO" type="button" onClick="location.href='/login'" >
										<spring:message code="label.go.bid.loginlog" />
									</button>
								</span> <!-- 온라인 / 종료 -->
								<!--온라인 / 진행중. 와인이 아닌경우 또는 직원인경우는  바로 허용--> 
								<span ng-show='lot.STAT_CD != "reentry" && (lot.WINE_YN == "N" || custInfo.EMP_GB == "Y")'    
									ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N'&& sale.AUTO_BID_REQ_CLOSE_DT <= sale.DB_NOW">
									<button ng-if="custInfo.BID_FORBID == 'N' && custInfo.CUST_NO && ((custInfo.LOCAL_KIND_CD == 'foreigner' && custInfo.FORE_BID_YN == 'Y') || (custInfo.LOCAL_KIND_CD != 'foreigner'))" type="button" ng-click="showBidPopup({'parent':this, 'sale':sale, 'lot':lot});" class="btn_style01 xlarge2 green02 Online_bidbtn">
										<spring:message code="label.go.bid.now" />
									</button>  
                                    <%-- <button ng-if="!custInfo.CUST_NO" type="button" onClick="location.href='https://www.seoulauction.com/login'" >
										<spring:message code="label.go.bid.loginlog" />
									</button> --%> 
								</span> <!--온라인 / 진행중-->
								<!--온라인 / 진행중. 와인인경우 && 직원이 아닌경우 alert처리--> 
								<span ng-show='lot.STAT_CD != "reentry" && lot.WINE_YN == "Y" && custInfo.EMP_GB == "N"' 
									ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N'&& sale.AUTO_BID_REQ_CLOSE_DT <= sale.DB_NOW">
									<button ng-if="custInfo.BID_FORBID == 'N' && custInfo.CUST_NO && ((custInfo.LOCAL_KIND_CD == 'foreigner' && custInfo.FORE_BID_YN == 'Y') || (custInfo.LOCAL_KIND_CD != 'foreigner'))" type="button" onClick="alert('와인 응찰은 서울옥션 담당자 또는 \n02-2075-4326으로 문의주시기 바랍니다. \n\nPlease contact ejlee@seoulauction.com for wine.')" class="btn_style01 xlarge2 green02 Online_bidbtn"> 
										<spring:message code="label.go.bid.now" /> 
									</button>
                                    <%-- <button ng-if="!custInfo.CUST_NO" type="button" onClick="location.href='https://www.seoulauction.com/login'" >
										<spring:message code="label.go.bid.loginlog" />  
									</button> --%> 
								</span> <!--온라인 / 진행중--> 
								   
								<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge2 green02"      
									ng-if="!custInfo.CUST_NO">
									<button ng-if="!custInfo.CUST_NO" type="button" onClick="location.href='/login'" >
										<spring:message code="label.go.bid.loginlog" /> 
									</button>
								</span> <!-- 정회원 국내 -->
								<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge2 green02 btn_bid" 
									ng-if="sale.SALE_NO != '563' && sale.SALE_NO != '594' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && custInfo.MEMBERSHIP_YN == 'Y' && (sale.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">  
									<button ng-if="sale.SALE_NO != '594' && custInfo.CUST_NO" type="button" ng-click="showBidRequestPopup({'parent':this, 'sale':sale, 'lot':lot});" >
										<spring:message code="label.go.bid.request" />
									</button> 
								</span> <!-- 정회원 국내 -->
								<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge2 green02 btn_bid"
									ng-if="['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && custInfo.FORE_BID_YN == 'Y' && (sale.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
									<button ng-if="sale.SALE_NO != '594' && custInfo.CUST_NO" type="button" ng-click="showBidRequestPopup({'parent':this, 'sale':sale, 'lot':lot});" >
										<spring:message code="label.go.bid.request" />
									</button>
								</span> <!--정회원. 국외 회원 응찰 여부 체크된 고객 -->
								
								<span ng-show='lot.STAT_CD != "reentry"' ng-if="['private','exhibit'].indexOf(sale.SALE_KIND_CD) >= 0 && sale_status == 'ING' && (sale.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')" class="btn_style01 xlarge green02 btn_bid">
									<button ng-if="custInfo.CUST_NO" type="button" onClick="goInquiryWrite();">
                                        <spring:message code="label.go.inquery" />
                                    </button>
								</span><!-- 전시 -->
								<!-- YDH. 경매관련 버튼 추가 -->

                                <a ng-href="{{'/lotDetailPrt?sale_no=' + sale_no + '&lot_no=' + lot_no + '&sale_status=END&view_type=LIST'}}" target="_blank">
									<span class="btn_style01 xlarge2 white">
										<button type="button">
											<spring:message code="label.go.print.now" />
										</button>
									</span>
								</a>
								<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge2 green02 btn_bid" ng-if="lot_no==87 && lot.SALE_NO == 467">
									<button type="button" onClick="location.href='/nas_img/front/online0467/Lot87_detail.pdf'" >
										<span>세부작품보기</span>
									</button>
								</span> <!-- 정회원 국내 -->
								<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge2 green02 btn_bid" ng-if="lot_no==88 && lot.SALE_NO == 467">
									<button type="button" onClick="location.href='/nas_img/front/online0467/Lot88_detail.pdf'" >
										<span>세부작품보기</span>
									</button>
								</span> <!-- 정회원 국내 -->
								<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge2 green02 btn_bid" ng-if="lot_no==89 && lot.SALE_NO == 467">
									<button type="button" onClick="location.href='/nas_img/front/online0467/Lot89_detail.pdf'" >
										<span>세부작품보기</span>
									</button>
								</span> <!-- 정회원 국내 -->

                                
                                <!-- VR -->
                                <a href="/service/page?view=auction360VRPop_online1" target="_blank">
									<span class="btn_style01 xlarge2 white" ng-if="locale == 'ko' && lot.SALE_NO == 459">
										<button type="button">
											전시장보기
										</button>
									</span>
                                    <span class="btn_style01 xlarge2 white" ng-if="locale != 'ko' && lot.SALE_NO == 459">
										<button type="button">
											EXHIBITION
										</button>
									</span>
								</a>							
								<!-- VR -->
                                <a href="/service/page?view=auction360VRPop" target="_blank">
									<span class="btn_style01 xlarge2 white" ng-if="locale == 'ko' && lot.SALE_NO == 442">
										<button type="button">
											전시장보기
										</button>
									</span>
                                    <span class="btn_style01 xlarge2 white" ng-if="locale != 'ko' && lot.SALE_NO == 442">
										<button type="button">
											EXHIBITION
										</button>
									</span>
								</a>
								<!-- 관심작품 추가. 2017.08.14 YDK -->
								<span ng-if="custInfo.CUST_NO > 0 && is_login && lot.INTE_LOT_DEL == 'N' && sale_status == 'ING'" class="btn_style01 xlarge2 white">
									<button type="button" ng-click="inteDel({'parent':this, 'sale_no':sale_no, 'lot_no':lot_no});">
										<span ng-if="locale=='ko'">관심작품 삭제</span>
										<span ng-if="locale!='ko'">FAVORITE WORK Del.</span>
									</button>
								</span>
									
								<span ng-if="custInfo.CUST_NO > 0 && is_login && lot.INTE_LOT_DEL != 'N' && sale_status == 'ING'" class="btn_style01 xlarge2 white">
									<button type="button" ng-click="inteSave({'parent':this, 'sale_no':sale_no, 'lot_no':lot_no});">
										<span ng-if="locale=='ko'">관심작품</span>
										<span ng-if="locale!='ko'">FAVORITE WORK</span>
									</button>
								</span>
								<!-- 관심작품 추가. 2017.08.14 YDK -->
								
								<!-- YBK.컨디션리포트 추가 -->
								<!--  <span ng-if="custInfo.CUST_NO > 0 && is_login && sale.SALE_KIND_CD == 'hongkong' && sale_status != 'ING'" class="btn_style01 xlarge white"> -->
								<!--	<span ng-if="custInfo.CUST_NO > 0 && is_login && sale.SALE_KIND_CD == 'hongkong' && sale_status == 'ING' && lot.CR_INTE_LOT == 'N'" class="btn_style01 xlarge white">
										<button type="button" ng-click="showConditionReportPopup({'parent':this, 'sale_no':sale_no, 'lot_no':lot_no});">
											<span ng-if="locale=='ko'">Condition 요청</span>
											<span ng-if="locale!='ko'">Condition Req.</span>
										</button>
									</span>
									<span ng-if="custInfo.CUST_NO > 0 && is_login && sale.SALE_KIND_CD == 'hongkong' && sale_status == 'ING' && lot.CR_INTE_LOT != 'N'">
										<a ng-href="{{'/conditionPrt?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=END&view_type=LIST'}}" target="_blank" class="btn_style01 xlarge white">
											<button type="button">
												<span ng-if="locale=='ko'">Condition 출력</span>
												<span ng-if="locale!='ko'">Condition PRT</span>
											</button>
										</a>
									</span>-->
								<!-- </span>  -->
								<!-- YBK.컨디션리포트 추가 -->
                             </div>
                             
                             <!-- YBK. 출력버튼 추가 -->
							
							<!-- 컨디션 리포트 요청 1:1문의 링크. 영문 번역 필요함 
							<div class="right" align="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">컨디션리프토</a><span class="ico next02"></span></span>
							</div> -->
							<!-- <div class="report">
								<div class="tit"><strong><spring:message code="label.artwork.condition_report" /></strong></div>
								<div class="btns">
									<span class="btn_style01 gray03 xsmall icon02">
										<button type="button" onclick="">한국어</button>
										<span class="ico download"></span>
									</span>
									<span class="btn_style01 gray03 xsmall icon02">
										<button type="button" onclick="">English</button>
										<span class="ico download"></span>
									</span>
								</div>
								<div class="txt"></div>
							</div>-->
                           	<!-- <div>
								<button type="button" class="btn_modal pop18 btn_view"><span style=" background-color: #9CF; padding:10px;">▷ Preview-VOD</span></button>
                            </div>-->
						</div>
					</div>
				</div>

				<div class="m_block">
					<div class="master_info explain" ng-if="lot.PROV_INFO_JSON[locale]">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.provenance" /></div>
							<div class="txt" bind-html-compile="lot.PROV_INFO_JSON[locale]"></div>
						</div>
					</div>
					<div class="master_info explain" ng-if="lot.LITE_INFO_JSON[locale]">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.literature" /></div>
							<div class="txt" bind-html-compile="lot.LITE_INFO_JSON[locale]"></div>
						</div>
					</div>
					<div class="master_info explain" ng-if="lot.EXHI_INFO_JSON[locale]">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.exhibited" /></div>
							<div class="txt" bind-html-compile="lot.EXHI_INFO_JSON[locale]"></div>
						</div>
					</div>
					<div class="master_info explain" ng-if="lot.ETC_INFO_JSON[locale]">
						<div class="left" style="padding-right: 0px;">
							<!--  <div class="tit"><spring:message code="label.auction.detail.literature" /></div>  기타사항 용어 정의 필요 -->
							<div class="txt" bind-html-compile="lot.ETC_INFO_JSON[locale]"></div>
						</div>
					</div>
					<div class="master_info explain" ng-if="lot.CMMT_JSON[locale]">
						<!-- YBK. 20170307. 아래 소스와 동일한 내용
						<div ng-if="locale != 'en'" class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.explain" /></div>
							<div class="txt" bind-html-compile="lot.CMMT_JSON[locale]"></div>
						</div>
						<div ng-if="locale == 'en'" class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.explain" /></div>
							<div class="txt" bind-html-compile="lot.CMMT_JSON[locale]"></div>							
						</div>
						-->
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.explain" /></div>
							<div class="txt" bind-html-compile="lot.CMMT_JSON[locale]"></div>
							<div class="txt" ng-if="(locale == 'en' && lot.CMMT_JSON['zh'] != null) && (lot.CMMT_JSON[locale] != lot.CMMT_JSON['zh'])" bind-html-compile="lot.CMMT_JSON['zh']"></div>							
						</div>
					</div>
					<div class="master_info explain" ng-if="sale.NOTICE_DTL_JSON[locale]">
						<div class="tit"><spring:message code="label.auction.detail.notice" /></div>
						<div class="txt" bind-html-compile="sale.NOTICE_DTL_JSON[locale]"></div>
					</div>
					<%-- <div class="master_info explain" ng-if="sale.PREVIEW_JSON">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.exhibited" /></div>
							<div class="txt">
								<span ng-repeat="prv in sale.PREVIEW_JSON">
									{{prv.PLACE_JSON[locale]}}
								</span>
							</div>
						</div>
					</div> --%>
					<!-- <div class="master_info explain" ng-if="lot['OWN_INFO'] || lot['OWN_INFO' + locale]">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.provenance" /> PROVENANCE 작품소장이력</div>
							<div class="txt">{{'OWN_INFO' | localeValue : lot}}</div>
						</div>
					</div>-->
					<!-- <div class="master_info explain" ng-if="lot['ETC_INFO'] || lot['ETC_INFO' + locale]">
						<div class="left" style="padding-right: 0px;">
							<div class="tit">기타사항</div>
							<div class="txt">{{'ETC_INFO' | localeValue : lot}}</div>
						</div>
					</div>-->
					<!-- <div class="master_info author">
						<div class="left">
							<img src="" alt="" />
						</div>
						<div class="right">
							<div class="tit">작가의 프로필</div>
							<div class="txt txt_italic">
								{{'PROFILE' | localeValue : lot}}
								<br />
								<strong>- {{'ARTIST_NAME' | localeValue : lot}}</strong>
							</div>
						</div>
					</div> -->
				</div>
				<div class="ex_list_area nobanner rolling_box" ng-show="otherLotList.length > 0"> 
                    <div style="font-size: 16px; font-weight: 600; padding-top: 50px; padding-bottom: 30px; color: #222;"><spring:message code="label.auction.detail.artistOtherLot" /></div> 
                    <div class="thumb_list">                     
                        <ul style="display:table; text-align:left;" > 
                            <li ng-repeat="lot2 in otherLotList" style="text-align: center; margin:5px; width:130px; height:130px;"> 
                                <a ng-href="{{is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot2.LOT_NO : null}}"> 
                                    <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot2.LOT_IMG_NAME | imagePath1 : lot2.LOT_IMG_PATH : 'list'}}" title="LOT.{{lot2.LOT_NO}}-{{lot2.TITLE_JSON[locale]}}" style="max-width:120px; max-height:120px; overflow:hidden;"/> 
                                </a> 
                            <!--<div> 
                            <span>Lot {{lot2.LOT_NO}}. {{lot2.TITLE_JSON[locale]}}</span> 
                            </div> sale_status == 'ING'--> 
                            </li> 
                        </ul> 
                    </div> 
                </div>
				
				<div class="btn_wrap link">
					<div class="right">
						<%-- <span class="btn_style01 white02 icon btn_list mbtn">
							<span class="ico list"></span>
							<a href="javascript:goCurrentList();"><span>목록</span></a>
						</span>
						<span class="btn_style01 white02 icon btn_prev mbtn">
							<span class="ico prev"></span>
							<a href="javascript:goOtherLot();"><span>이전</span></a>
						</span>
						<span class="btn_style01 white02 icon02 btn_next mbtn">
							<span class="ico next"></span>
							<a href="javascript:goOtherLot();"><span>다음</span></a>
						</span> --%>
						<span class="btn_style01 white02 icon btn_list mbtn" ng-click="listBack()">
							<c:choose>
								<c:when test="${param.sale_status == 'ING'}">
									<a href="/saleDetail?view_id=CURRENT_AUCTION&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}">
                                    	<span class="ico list"></span>
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:when>
								<c:when test="${param.sale_status == 'END'}">
									<a href="/saleDetail?view_id=RESULT_AUCTION&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}">
                                    	<span class="ico list"></span>
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:when>
								<c:otherwise>
									<a href="<%--뒤로가야함--%>">
                                    	<span class="ico list"></span>
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:otherwise>
							</c:choose>					
						</span>
						<c:if test="${param.view_type == 'LIST' or param.view_type == 'GRID'}">			
							<span class="btn_style01 white02 icon btn_prev mbtn" ng-if="lot.PREV_LOT_NO > 0">
								<a href="/lotDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.PREV_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
                                	<span class="ico prev"></span>
									<span ng-if="locale != 'en'">이전</span>
									<span ng-if="locale == 'en'">Prev</span>
								</a>
							</span>
							<span class="btn_style01 white02 icon02 btn_next mbtn" ng-if="lot.NEXT_LOT_NO > 0">
								<a href="/lotDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.NEXT_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
                                	<span class="ico next"></span> 
									<span ng-if="locale != 'en'">다음</span>
									<span ng-if="locale == 'en'">Next</span>
								</a>
							</span>
						</c:if>
						<span class="btn_style01 icon02 btn_scrolltop mbtn">
							<button type="button">
								<span ng-if="locale != 'en'">위로</span>
								<span ng-if="locale == 'en'">Up</span>
							</button>
							<span class="ico up"></span>
						</span>
					</div>
				</div>	
				</div>
			</div>
		</div>

		<!--<div class="sub_banner">
			<div class="hidden_box">
				<ul>
					<li>
						<img src="/images/img/img_current.png" alt="작품1" class="img_master">	
					</li>
				</ul>
			</div>
		</div>	-->		
	</div>
</div>
<div style="display:none;">
	<span class="btn_style01 xlarge green02 btn_bid btn_modal pop02">
		<button type="button">Bid Now</button>
	</span>
	<span class="btn_style01 xlarge dark btn_bid btn_modal pop03">
		<button type="button">Bid History</button>
	</span>
	<span class="btn_style01 xlarge dark btn_bid btn_zoom">
		<button type="button">Show Image</button>
	</span>
	<span class="btn_style01 xlarge dark btn_bid btn_modal pop11">
		<button type="button">비디오보기</button>
	</span>
	<span class="btn_style01 gray02 btn_modal pop15">
		<button type="button">Become a Bidding Member</button>
	</span>
</div>
<!-- //#wrap -->
<jsp:include page="../include/bottom.jsp" flush="false" />
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />