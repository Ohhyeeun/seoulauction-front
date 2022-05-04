<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<spring:eval expression="@property['blacklot.router.domain']" var="blacklot" scope="page"/>

<link href="/css/angular/ng-animation.css" rel="stylesheet">
<link href="/css/angular/ngDialog.min.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<link type="text/css" href="/css/imgzoom/jquery.magnify.css" rel="stylesheet">
<link type="text/css" href="/css/imgzoom/magnify-bezelless-theme.css" rel="stylesheet">

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
  	   		location.href="https://www.seoulauction.com"
  	   	}
  	   	//종료된 경매이고 로그인했지만 직원이 아닌경우 메인페이지 이동(2018.06.12)
  	  	if($scope.sale_status == "END" && $scope.is_login == "true" && $scope.custInfo.EMP_GB != "Y"){
  	   		location.href="https://www.seoulauction.com"
  	   	}
  	  	
 	    $scope.lot = data["tables"]["LOT"]["rows"][0];
 	    console.log($scope.lot);
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

	$scope.blacklotGo = function(url, sale_no, lot_no) {
		window.open(url+encodeURIComponent("sale_no="+sale_no+"&lot_no="+lot_no));
	}
});

/* // 자세히 보기 팝업
var m_sImagePath =""; */  
</script>


<script type="text/javascript" src="/js/bid.js"></script>
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
<script>
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
</script>
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
                            <span class="btn_style01 white02 icon btn_list mbtn"> 
								<c:choose> 
									<c:when test="${param.sale_status == 'ING'}">
										<a href="/currentAuction?sale_outside_yn=Y&lang=ko&view_type=${param.view_type}#page1">   
                                        <!-- <a href="/saleDetail?view_id=CURRENT_AUCTION&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}"> -->
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
	                                    <a href="/currentAuction?sale_outside_yn=Y&lang=ko&view_type=${param.view_type}#page1">     
										<!-- <a href="뒤로가야함"> --> 
                                        	<span class="ico list"></span>
											<span ng-if="locale != 'en'">목록</span>
											<span ng-if="locale == 'en'">List</span>
										</a>
									</c:otherwise>
								</c:choose>
							</span>
							<c:if test="${param.view_type == 'LIST' or param.view_type == 'GRID'}"> 
								<span class="btn_style01 white02 icon btn_prev mbtn" ng-if="lot.PREV_LOT_NO > 0">
                                	<a href="/lotOutsideDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.PREV_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}"> 
										<span class="ico prev"></span> 
										<span ng-if="locale != 'en'">이전</span>
										<span ng-if="locale == 'en'">Prev</span>
									</a>
								</span>
								<span class="btn_style01 white02 icon02 btn_next mbtn" ng-if="lot.NEXT_LOT_NO > 0">
									<a href="/lotOutsideDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.NEXT_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">																			
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
										Auction :&nbsp; 
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
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
												<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" 
												alt="{{lot.TITLE}}" />   
											</a>
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
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
												<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
												alt="{{lot.TITLE}}" />
											</a>
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
								
								<div ng-if="sale.SALE_NO <= '408'" id="rolling123" class="hidden_box rolling" >
									<ul style="width: 500px;">
										<li ng-if="custInfo.EMP_GB != 'Y'" ng-repeat="img in imageList" style="text-align: center;" on-finish-render-filters>
											<!-- <img oncontextmenu="return false" class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}})'}" style="margin-top: 84px;" alt="{{lot.TITLE}}"/> -->
											<img ng-if="lot.IMG_DISP_YN == 'N'" img ng-src="/images/bg/no_image.jpg" />
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
												<img ng-if="lot.IMG_DISP_YN == 'Y'" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" 
												alt="{{lot.TITLE}}" /> 
											</a>
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
											<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
												<img ng-if="lot.IMG_DISP_YN == 'Y'" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath1 : img.FILE_PATH : 'detail'}}" 
												alt="{{lot.TITLE}}" />
											</a> 
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
								</div><!--//lot  -->     
                                
                                <div class="name" id="artist_name"><span ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}"></span></div>   
                                <div class="lang">
                                    <span ng-if="locale != 'en'" ng-bind="lot.ARTIST_NAME_JSON.en" title="{{lot.ARTIST_NAME_JSON.en}}"></span>   
                                    <span class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh"></span>
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
									</p>
									<p ng-if='lot.SIGN_INFO_JSON[locale]'>
										<span bind-html-compile="lot.SIGN_INFO_JSON[locale]" title="{{lot.SIGN_INFO_JSON[locale]}}"></span>  
									</p>
								</div>
							</div>
							
							<div class="price"> 
								<div class="tit" ng-if="(lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null"><strong><spring:message code="label.expense.price" /></strong></div>
								<div class="mat"> 
									<!-- 추정가 별도문의 --> 
									<p>
										<span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
									</p>
									<div ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null"> 
										<!-- 기준통화 -->
										<p>
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)">
											 ~ 
											</span>	
											<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
										</p>
										<!-- USD -->
										<!-- <p ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) && (lot.EXPE_PRICE_TO_JSON.USD != null) && (lot.EXPE_PRICE_FROM_JSON.USD != 0) && (lot.EXPE_PRICE_TO_JSON.USD != 0)">
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)">
											 ~ 
											</span>	 
											<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
										</p> -->
										<!-- 서브통화 -->
										<p ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) && (lot.EXPE_PRICE_TO_JSON[sub_currency] != null) && (lot.EXPE_PRICE_FROM_JSON[sub_currency] != 0 ) && (lot.EXPE_PRICE_TO_JSON[sub_currency] != 0)">
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)">
											 ~ 
											</span>	 
											<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
										</p>   
									</div>    
									<p> 
										<strong class="txt_red">  
											<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.bid.price" /></span><br/>
											<span ng-if="sale_status == 'END' && sale.SALE_KIND_CD != 'online_zb'"><spring:message code="label.bid.price.sold" /></span>
                                            <span ng-if="lot.LAST_PRICE != null && sale.SALE_KIND_CD != 'online_zb' && sale_status != 'ING'" ng-bind="sale.CURR_CD+' '+(lot.LAST_PRICE | number:0)"></span>
                                            <span ng-if="lot.LAST_PRICE > 0 && sale_status == 'ING'" ng-bind="(sale.CURR_CD)+' '+(lot.LAST_PRICE | number:0)"></span>
										</strong> 
									</p>
								</div>  
							</div>   

							<div class="title" ng-if='lot.COND_RPT_JSON[locale] != null'> 
								<div class="mat">  
									<p ng-if='lot.COND_RPT_JSON[locale]'>   
										<span>【Condition】&nbsp;&nbsp;</span>   
										<span bind-html-compile="lot.COND_RPT_JSON[locale]"></span>   
									</p>
								</div> 
							</div>
							
                            <!--<div class="title">
                            	<div class="mat"> 
                                	 <p ng-if="locale == 'ko'">   
                                    	* 서울옥션은 아트시에서 제공한 작품의 정보를 "있는 그대로" 제공함으로, 입찰/작품정보/보증 등과 관련된 오류나 누락에 대해 책임지지 않습니다.<br>   
                                        * 구매수수료는 낙찰가의 20%입니다.<br>
                                        * 본 경매는 서울옥션 보증서를 발행하지 않습니다.<br>
                                        * 작품의 위치를 확인 후 응찰해야하며, 운송비 및 관세가 발생됩니다. 
                                    </p>   
                                    
                                    <p ng-if="locale != 'ko'">
                                    	* 서울옥션은 아트시에서 제공한 작품의 정보를 "있는 그대로" 제공함으로, 입찰/작품정보/보증 등과 관련된 오류나 누락에 대해 책임지지 않습니다.<br>   
                                        * 구매수수료는 낙찰가의 20%입니다.<br>
                                        * 본 경매는 서울옥션 보증서를 발행하지 않습니다.<br>
                                        * 작품의 위치를 확인 후 응찰해야하며, 운송비 및 관세가 발생됩니다.
                                    </p>  
                                </div> 
                            </div> -->
							
                            <div class="title"> 
								<div class="mat">  
                                    <p class="inquiry_no_email">
                                    	<span class="inquiry_no_email_lang">
                                    		<span>
												<a href="tel:010-4464-0396">010-4464-0396</a> / <a href="mailto:ynjang@seoulauction.com">ynjang@seoulauction.com</a>
											</span> 
                                    		<span ng-if="lot.END_YN == 'N' && sale.AUTO_BID_REQ_CLOSE_DT <= sale.DB_NOW" style="margin-top: 20px;">
                                    			<a ng-click="blacklotGo('${blacklot}', sale.SALE_NO, lot.LOT_NO)" style="cursor:pointer;">
		                                        	<strong ng-if="locale == 'ko'"><span style="color:#62c3bc;">▶ 블랙랏 응찰하기</span></strong>
													<strong ng-if="locale != 'ko'"><span style="color:#62c3bc;">▶ Bid on BLACKLOT</span></strong>
		                                        </a>
                                    		</span>   
                                    	</span>  
                                    </p>

									<%-- <p ng-if="locale == 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p> --%>
									<!-- <p ng-if="locale != 'ko' && sale.SALE_NO == '667'">specialist@artsy.net</p>
									<p ng-if="locale != 'ko' && sale.SALE_NO != '667'">ujin0618@seoulauction.com / 02-2075-4391</p>       
									
                                    <p ng-if="locale != 'ko'" style="margin-top: 20px;">  
                                    	<a href="https://www.artsy.net/auction/artsy-x-seoul-auction-mixed-media-1" target="_blank">   
                                        <strong><span style="color:#62c3bc;">▶ Bid on Artsy</span></strong>    
                                        </a>
                                    </p>  --> 
                                          
                                    <!-- <p ng-if="locale != 'ko' && sale.SALE_KIND_CD != 'hongkong'">E-mail: info@seoulauction.com</p>
                                    <p ng-if="locale != 'ko' && sale.SALE_KIND_CD == 'hongkong'">E-mail: saplus@seoulauction.com</p> 
                                    <p ng-if="locale != 'ko' && !custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.auction.membershipchk" /></p> -->   
									
									<p ng-if="sale.NOTICE_DTL_JSON != null"> 
									<span ng-bind-html="sale.NOTICE_DTL_JSON[locale]"></span>
									</p>
                                    
                                    <p ng-if="locale == 'ko' && sale.NOTICE_DTL_JSON == null && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
                                        작품 컨디션은 주관적인 견해에 따라 다를 수 있습니다. 재질의 특성상 울음 등의 변형이 있을 수 있으니  반드시 '실물 확인' 후 응찰 해주시기 바랍니다.</br>
                                        컨디션에 액자 상태는 포함되지 않으며, 작품을 직접 확인하지 못하여 발생하는 모든 책임은 응찰자에게 있습니다.</br>
                                        응찰 및 낙찰 취소는 불가합니다. 부득이한 사유로 낙찰 취소시, 낙찰가의 30%에 해당하는 위약금이 발생합니다.</br>
                                        출품작 중 일부는 문화재 보호법상의 문화재에 해당되므로 해외반출이 불가하오니 이 점 유의하시기 바랍니다.</br>
                                        <font style="font-weight:700">
                                        응찰은 실물 확인 후 진행되는 것을 전제로 하며, 작품 중 일부에는 복사본이 포함되어 있을 수 있으니 신중히 응찰해주시기 바랍니다.</br>
                                        배송 : <br/>
                                        작품은 사전예약을 통해 7일 이내 출고하여야 합니다.<br/>
                                        또한 작품 운송은 '구매자 비용'으로 진행하셔야 합니다.
                                        </font>
                                    </p>
                                    <p ng-if="locale != 'ko' && sale.NOTICE_DTL_JSON == null && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
                                        The condition of the artwork may vary based on subjective opinion, and changes in the material may occur due to the innate characteristics of such material. (As wrinkles may form in the material of an artwork, altering the appearance of the work, please make sure to check the condition of the actual artwork before making your bid.)</br>
                                        Details on the condition of the artwork’s frame are not included in the description of the condition of the artwork itself. The bidder alone is responsible for checking the condition of the actual/physical artwork.</br>
                                        A (successful) bid can be cancelled with a penalty. In the event a bid must be cancelled, the bidder must pay a penalty corresponding to 30 percent of the successful bid price.</br>
                                       
                                        If the artwork requires installation, etc., a separate fee shall be incurred by the bidder.</br>
                                        The part of Korean traditional works cannot be carried out abroad, because of the Cultural Properties Protection Law.</br>
 The bidding is conducted on the premise that the bidder has identified the condition of artworks. Some of the artworks may have copies, so please make a careful bid.</br>
* The work must be picked-up within 7 days of the sale through advanced arrangement. Also, shipping costs and packing shall be carried under the responsibility of the winning bidder.</br>
                                    </p> 
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

                                    <%--<ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD != 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.MEMBERSHIP_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>
                                    <ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD == 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                        <li ng-if="custInfo.FORE_BID_YN != 'Y'">
                                            <spring:message code="label.auction.membershipchk" />
                                        </li>
                                    </ul>--%>
								</div> 
							</div>
                            

							<!-- YBK. 출력버튼 추가 -->
							
							<div class="info">
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
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.explain" /></div>
							<div class="txt" bind-html-compile="lot.CMMT_JSON[locale]"></div>
							<div class="txt" ng-if="(locale == 'en' && lot.CMMT_JSON['zh'] != null) && (lot.CMMT_JSON[locale] != lot.CMMT_JSON['zh'])" bind-html-compile="lot.CMMT_JSON['zh']"></div>							
						</div>
					</div>
				</div>
				<div class="ex_list_area nobanner rolling_box" ng-show="otherLotList.length > 0"> 
                    <div style="font-size: 16px; font-weight: 600; padding-top: 50px; padding-bottom: 30px; color: #222;"><spring:message code="label.auction.detail.artistOtherLot" /></div> 
                    <div class="thumb_list">                     
                        <ul style="display:table; text-align:left;" > 
                            <li ng-repeat="lot2 in otherLotList" style="text-align: center; margin:5px; width:130px; height:130px;"> 
                                <a ng-href="{{is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot2.LOT_NO : null}}"> 
                                    <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot2.LOT_IMG_NAME | imagePath1 : lot2.LOT_IMG_PATH : 'list'}}" title="LOT.{{lot2.LOT_NO}}-{{lot2.TITLE_JSON[locale]}}" style="max-width:120px; max-height:120px; overflow:hidden;"/> 
                                </a> 
                            </li> 
                        </ul> 
                    </div> 
                </div>
				
				<div class="btn_wrap link">
					<div class="right">
                        <span class="btn_style01 white02 icon btn_list mbtn"> 
							<c:choose>
								<c:when test="${param.sale_status == 'ING'}"> 
									<a href="/currentAuction?sale_outside_yn=Y&lang=ko&view_type=${param.view_type}#page1">  
									<!-- <a href="/saleDetail?view_id=CURRENT_AUCTION&sale_no={{sale.SALE_NO}}&view_type=${param.view_type}"> -->
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
									<a href="/currentAuction?sale_outside_yn=Y&lang=ko&view_type=${param.view_type}#page1">    
                                    <!-- <a herf="뒤로 가야함"> --> 
                                    	<span class="ico list"></span>
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:otherwise>
							</c:choose>					
						</span>
						<c:if test="${param.view_type == 'LIST' or param.view_type == 'GRID'}">			
							<span class="btn_style01 white02 icon btn_prev mbtn" ng-if="lot.PREV_LOT_NO > 0">
								<span class="ico prev"></span>
								<a href="/lotOutsideDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.PREV_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
									<span ng-if="locale != 'en'">이전</span>
									<span ng-if="locale == 'en'">Prev</span>
								</a>
							</span>
							<span class="btn_style01 white02 icon02 btn_next mbtn" ng-if="lot.NEXT_LOT_NO > 0">
								<span class="ico next"></span>
								<a href="/lotOutsideDetail?sale_no={{sale.SALE_NO}}&lot_no={{lot.NEXT_LOT_NO}}&sale_status={{sale_status}}&view_type=${param.view_type}">
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