<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<link href="/resources/css/angular/ng-animation.css" rel="stylesheet">
<link href="/css/angular/ngDialog.min.css" rel="stylesheet">
<link href="/resources/css/angular/popup.css" rel="stylesheet"> 
<link type="text/css" href="/css/imgzoom/jquery.magnify.css" rel="stylesheet">
<link type="text/css" href="/css/imgzoom/magnify-bezelless-theme.css" rel="stylesheet">  

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<!--  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-animate.min.js"></script> -->
<script type="text/javascript" src="/resources/js/angular/angular-animate.min.js"></script>
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
 		console.log($scope.sale);
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
 			if($scope.sale.SALE_KIND_CD == 'online' && !$scope.now_timer_start){
 				$interval(function(){$scope.db_now = moment($scope.db_now).add(1, 'seconds');}, 1000);
 			} 
 		}
 		else if(TO_DT < S_DB_NOW){
 			$scope.sale_status = "END";
 		}
 		
 		//종료된 경매인 경우 메인페이지 이동(2021.05.04, 직원&로그인 조건 삭제)
 		if($scope.sale_status != "ING"){
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
		if($scope.sale.SALE_KIND_CD != 'online' && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){
 	 		$scope.timer_lots_refresh = $interval($scope.refreshLots, 60000, 1);  //오프라인 경매는 1시간 단위로 refresh처리
 		}
 		if($scope.sale.SALE_KIND_CD == 'online' && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){
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
}); 

/* //자세히 보기 팝업
var m_sImagePath =""; */
</script>


<script type="text/javascript" src="/resources/js/bid.js?${resources.timestamp}"></script>
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
	<div id="container" ng-controller="lotDetailCtl" data-ng-init="loadLotDetail();">
		<div class="sub_menu_wrap menu01">
			<div class="sub_menu">
				<jsp:include page="../include/exhibitionsubMenu.jsp" flush="false"/>
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
                    
					<div class="right">
							<span class="btn_style01 white02 icon btn_list mbtn">
								<span class="ico list"></span>
								<c:choose> 
									<c:when test="${param.sale_status == 'ING'}">
										<a href="/exhibitDetail?view_id=CURRENT_EXHIBIT&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}">
											<span ng-if="locale != 'en'">목록</span>
											<span ng-if="locale == 'en'">List</span>
										</a>
									</c:when>
									<c:when test="${param.sale_status == 'END'}">
										<a href="/exhibitDetail?view_id=RESULT_AUCTION&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}">
											<span ng-if="locale != 'en'">목록</span>
											<span ng-if="locale == 'en'">List</span>
										</a>
									</c:when>
									<c:otherwise>
										<a href="<%--뒤로가야함--%>">
											<span ng-if="locale != 'en'" onclick = "history.go(-1); return false;">목록</span>
											<span ng-if="locale == 'en'" onclick = "history.go(-1); return false;">List</span>
										</a>
									</c:otherwise>
								</c:choose>
							</span>
							<c:if test="${param.view_type == 'LIST' or param.view_type == 'GRID'}">
								<span class="btn_style01 white02 icon btn_prev mbtn" ng-if="lot.PREV_LOT_NO > 0">
									<span class="ico prev"></span>
									<a href="/lotDetailExhibit?sale_no={{sale.SALE_NO}}&lot_no={{lot.PREV_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
										<span ng-if="locale != 'en'">이전</span>
										<span ng-if="locale == 'en'">Prev</span>
									</a>
								</span>
								<span class="btn_style01 white02 icon02 btn_next mbtn" ng-if="lot.NEXT_LOT_NO > 0">
									<span class="ico next"></span>
									<a href="/lotDetailExhibit?sale_no={{sale.SALE_NO}}&lot_no={{lot.NEXT_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
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
						<p>
							<!-- //전시 타이틀 -->
							<span ng-bind="sale.TITLE_JSON[locale]"></span>
						</p>
						 
						<!-- 전시 프리뷰 기간 --> 
						<div ng-repeat="prev in sale.PREVIEW_JSON" ng-class="{first:$first}" style="padding: 3px 0;"> 
							<dl>
								<dd>{{prev.FROM_DT | date : 'yyyy.MM.dd'}} ({{getWeek(prev.FROM_DT)}}) 
									- {{prev.TO_DT | date : 'yyyy.MM.dd'}} ({{getWeek(prev.TO_DT)}}) </dd>
							</dl>
						</div> 
						<!-- // 전시 장소 -->   
						<p> 
							<span ng-bind="sale.PLACE_JSON[locale]"></span>
						</p>
					<%-- 첫번 째 항목에만 진행 상황 보여줌 --%>
						<%-- 온라인 경매 - 시작 전, 진행 중, 종료 상태에 따른 버튼 변경 필요
							시작 전 - 버튼 없음
							진행 중 - 응찰하기
							종료    - 경매 기록보기
						--%>
					</div>
				</div>
				

				<div class="master_detail">
					<div class="detail">
						<!-- 20150521 -->
						<!-- <div id="rollingBox{{sale.SALE_NO}}{{lot.LOT_NO}}" class="left rolling_box3">-->
						<div id="rollingBox123" class="left rolling_box3">
							<div class="img_represent">
								<div class="btns rolling_btn">
									<button type="button" class="sp_btn btn_prev"><span class="hidden"><spring:message code="label.move.prev" /></span></button>
									<button type="button" class="sp_btn btn_next"><span class="hidden"><spring:message code="label.move.next" /></span></button>
								</div>
								<!-- <div id="rolling{{sale.SALE_NO}}{{lot.LOT_NO}}" class="hidden_box rolling">-->								

								<div ng-if="sale.SALE_NO <= '408'" id="rolling123" class="hidden_box rolling" >
									<ul style="width: 500px;">  
										<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
												<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" 
												alt="{{lot.TITLE}}" />  
											</a> 
										</li> 
										<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
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
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">  
										  		<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
												alt="{{lot.TITLE}}" />
											</a>  
										</li> 
										<li ng-if="custInfo.EMP_GB == 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>   
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
						<!-- //20150521 -->
						<div class="right" style="cursor: default;">  
							<div class="author"> 
								<div class="lot detail_lot"> 
									<div style="display: inline-block;">   
										<span>NO.</span>      
										<strong>   
											<span ng-bind="lot.LOT_NO" title="{{lot.LOT_NO}}"></span> 
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
								</div><!-- //lot-->  
								<div class="name" id="artist_name"><span ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}"></span></div>
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
										<span ng-bind="lot.STITLE_JSON[locale]" title="{{lot.STITLE_JSON[locale]}}"></span>
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
										<!-- <span ng-bind="size | size_text"></span> -->
										<span ng-if="locale=='ko'"  ng-bind="size | size_text_cm" title="{{size | size_text_cm}}"></span>
										<span ng-if="locale!='ko'"  ng-bind="size | size_text_in" title="{{size | size_text_in}}"></span>  
									</p> 
									<p ng-if='lot.EDITION'><span ng-bind="lot.EDITION" title="{{lot.EDITION}}"></span></p>  
									<p ng-if='lot.MAKE_YEAR_JSON[locale]'>     
										<span ng-bind="lot.MAKE_YEAR_JSON['ko']" title="{{lot.MAKE_YEAR_JSON['ko']}}"></span>       
									<!--	{{lot.MAKE_YEAR_JSON[locale]}}
									  	{{lot.MAKE_YEAR_JSON["en"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}
										<span ng-if="lot.MAKE_YEAR_JSON['zh'] != lot.MAKE_YEAR_JSON['en'] && lot.MAKE_YEAR_JSON['zh'] != null">
										{{lot.MAKE_YEAR_JSON["zh"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}</span> -->
									</p>
									<p ng-if='lot.SIGN_INFO_JSON[locale]'>   
										<span bind-html-compile="lot.SIGN_INFO_JSON['ko']" title="{{lot.SIGN_INFO_JSON['ko']}}"></span>   
									<!--	<span bind-html-compile="lot.SIGN_INFO_JSON[locale]"></span>
									  	<span ng-if="lot.SIGN_INFO_JSON['en'] != lot.SIGN_INFO_JSON[locale]"><span bind-html-compile="lot.SIGN_INFO_JSON["en"]"></span></span>
										<span ng-if="lot.SIGN_INFO_JSON['zh'] != lot.SIGN_INFO_JSON[locale] && lot.SIGN_INFO_JSON['zh'] != null"><span bind-html-compile="lot.SIGN_INFO_JSON["zh"]""></span></span> -->
									</p>
								</div>
							</div>
							
							<!-- <div class="price" ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'">
								<div class="tit"><strong><spring:message code="label.expense.price" /></strong></div>
								<div class="mat">
									<!-- 추정가 별도문의 ->
									<!-- <span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span> ->
									<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'">
											<!-- 기준통화 ->
											<p>
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
												<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)">
												 ~ 
												</span>	
												<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
											</p>
											<!-- USD ->
											<p>
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
												<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)">
												 ~ 
												</span>	 
												<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
											</p>
											<!-- 서브통화 ->
											<p>
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
												<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)">
												 ~ 
												</span>	 
												<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
											</p>
									</span>
								</div> 
							</div> -->	 						

							<div class="title">  
								<div class="mat"> 
									<p ng-if='lot.COND_RPT_JSON[locale]'>
										【Condition】&nbsp;&nbsp;<span ng-if="lot.FRAME_CD!='none'" ng-bind="lot.FRAME_CD" title="{{lot.FRAME_CD}}"></span>  
										<br/>
										<span ng-bind="lot.COND_RPT_JSON[locale]" title="{{lot.COND_RPT_JSON[locale]}}"></span>  
										<span ng-bind="lot.COND_RPT_JSON["en"] | trimSameCheck : lot.COND_RPT_JSON[locale]"></span>
										<p ng-if="lot.COND_RPT_JSON['zh'] != lot.COND_RPT_JSON['en']">
											<span ng-bind="lot.COND_RPT_JSON["zh"] | trimSameCheck : lot.COND_RPT_JSON[locale]"></span>
										</p>
									</p>
								</div>
							</div>
                
                
                			<!-- 홍콩용 디테일 내용 --> 
                              <div class="title" ng-if="sale.SALE_KIND_CD == 'exhibit'">
								<div class="mat">
									<p ng-if="locale == 'ko'" class="inquiry_no_email">
                                    	<span class="inquiry_no_email_lang"> 
                                            <span>
												작품문의: <a href="tel:02-395-0330">(서울)02-395-0330</a>/ <a href="tel:+852-2537-1880">(홍콩) +852-2537-1880</a> 
                                            </span> 
                                            <span> 
                                                <a href="mailto:saplus@seoulauction.com">E-mail: (홍콩)saplus@seoulauction.com</a>
                                            </span>
                                          		 또는, 로그인 뒤 1:1 문의를 하실 수 있습니다.  
                                    	</span> 
                                    </p> 
                                    <p ng-if="locale != 'ko'" class="inquiry_no_email">
                                    	<span class="inquiry_no_email_lang">   
                                        	<span>                                  
	                                    		<a href="mailto:saplus@seoulauction.com">E-mail: (hongkong) saplus@seoulauction.com</a>
                                            </span> 
                                        </span>  
                                    </p>
								</div> 
							</div>   
							
							<!-- 국내용 디테일 내용 -->
							 <div class="title" ng-if="sale.SALE_KIND_CD == 'exhibit_sa'">
								<div class="mat">
									<p ng-if="locale == 'ko'" class="inquiry_no_email">  
                                    	<span ng-if="sale.SALE_NO == 640" class="inquiry_no_email_lang"> 
                                      	  	서울옥션 김승엽 선임 
                                      	  	<span>
	                                          	<a href="tel: 02-2075-4426">작품문의 : 02-2075-4426</a> / <a href="mailto:syk@seoulauction.com">syk@seoulauction.com</a> 
                                            </span>   
                                            <span>  
                                            	또는, 로그인 뒤 1:1 문의를 하실 수 있습니다.
                                            </span>
                                        </span>  
                                        
                                        <span ng-if="sale.SALE_NO != 640" class="inquiry_no_email_lang">   
                                        	<!-- 서울옥션 정선정 선임 -->
                                            <span>
                                           		<a href="tel:02-395-0330">작품문의 : 02-395-0330</a>      
	                                            <!-- / <a href="mailto: jsj@seoulauction.com">jsj@seoulauction.com</a> -->
	                                        </span>
	                                        <span style="margin-top: 20px;">
                                    			<a href="https://www.blacklot.com/" target="_blank">  
		                                        	<strong><span style="color:#00acac;">▶ 블랙랏 응찰 / 구매</span></strong>           
		                                        </a>
                                    		</span>   
                                        </span>    
									</p>   
									
                                    <p ng-if="locale != 'ko'" class="inquiry_no_email">    
                                    	<span ng-if="sale.SALE_NO == 640" class="inquiry_no_email_lang"> 
                                        	Specialist, S.Y Kim 
                                            <span>  
                                            	<a href="tel: +82 (0)2-2075-4426">Tel. +82 (0)2-2075-4426</a> / <a href="mailto:syk@seoulauction.com">syk@seoulauction.com</a> 
                                            </span>  
                                            <span>    
                                            	E-mail: (Hong Kong) saplus@seoulauction.com 
                                            </span> 
                                        </span>       
                                        
                                        <span ng-if="sale.SALE_NO != 640" class="inquiry_no_email_lang"> 
                                        	<!-- Specialist, Sunny Jung -->   
                                            <span>    
                                            	<a href="tel: +82 (0)2-395-0330">Tel. +82 (0)2-395-0330</a>      
                                            	<!-- / <a href="mailto: jsj@seoulauction.com">jsj@seoulauction.com</a> -->    
                                            </span>  
                                            <span style="margin-top: 20px;">
                                    			<a href="https://www.blacklot.com/" target="_blank">  
		                                        	<strong><span style="color: #00acac;">▶ Blacklot Bid / Purchase </span></strong>          
		                                        </a> 
                                    		</span>  
                                        </span>  
                                    </p>
								</div>   
							</div> 

							<!-- YBK. 출력버튼 추가 -->
							
							<div class="info">
								<!-- 1:1문의 또는 서면/전화 방식 결정 후 진행 필요함.-->
								<!--<span ng-show='lot.STAT_CD != "reentry"' ng-if="custInfo.CUST_NO && ['private','exhibit','exhibit_sa'].indexOf(sale.SALE_KIND_CD) >= 0 && sale_status == 'ING' && (sale.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')" class="btn_style01 xlarge green02 btn_bid">
									<button type="button" onClick="location.href='/customer/inquiryForm'">
                                        <spring:message code="label.go.inquery" />
                                    </button> 
								</span> --> <!-- 전시 --> 

                                <a ng-href="{{'/lotDetailPrt?sale_no=' + sale_no + '&lot_no=' + lot_no + '&sale_status=END&view_type=LIST'}}" target="_blank">
									<span class="btn_style01 xlarge2 white">
										<button type="button">
											<spring:message code="label.go.print.now" />
										</button>
									</span>
								</a>								
								
								<!-- 관심작품 추가. 2017.08.14 YDK 
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
								</span>-->
								<!-- 관심작품 추가. 2017.08.14 YDK -->
                             </div>                             
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

				<!-- <div class="master_info more ex_list_area rolling_box" ng-show="otherLotList">
					<div class="tit">작가의 작품 더보기</div>
					<div class="m_hidden_box rolling">
						<ul>
							<li ng-repeat="lot2 in otherLotList">
								<a ng-href="{{sale_status == 'ING' ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot2.LOT_NO : null}}">
									<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot2.LOT_IMG_NAME | imagePath : lot2.LOT_IMG_PATH : true}}" alt="{{lot2.TITLE}}//{{sale_no}}//{{lot2.LOT_NO}}" />
								</a>
								<div>
									<span>Lot {{lot2.LOT_NO}}. {{lot2.TITLE_JSON[locale]}}</span>
								</div>
							</li>
						</ul>
					</div>
				</div>-->
				
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
						<span class="btn_style01 white02 icon btn_list mbtn">
							<span class="ico list"></span>
							<c:choose>
								<c:when test="${param.sale_status == 'ING'}">
									<a href="/saleDetail?view_id=CURRENT_EXHIBIT&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}">
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:when>
								<c:when test="${param.sale_status == 'END'}">
									<a href="/saleDetail?view_id=RESULT_AUCTION&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}">
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:when>
								<c:otherwise>
									<a href="<%--뒤로가야함--%>">
										<span ng-if="locale != 'en'" onclick = "history.go(-1); return false;">목록</span>
										<span ng-if="locale == 'en'" onclick = "history.go(-1); return false;">List</span>
									</a>
								</c:otherwise>
							</c:choose>					
						</span>
						<c:if test="${param.view_type == 'LIST' or param.view_type == 'GRID'}">			
							<span class="btn_style01 white02 icon btn_prev mbtn" ng-if="lot.PREV_LOT_NO > 0">
								<span class="ico prev"></span>
								<a href="/lotDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.PREV_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
									<span ng-if="locale != 'en'">이전</span>
									<span ng-if="locale == 'en'">Prev</span>
								</a>
							</span>
							<span class="btn_style01 white02 icon02 btn_next mbtn" ng-if="lot.NEXT_LOT_NO > 0">
								<span class="ico next"></span>
								<a href="/lotDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.NEXT_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
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