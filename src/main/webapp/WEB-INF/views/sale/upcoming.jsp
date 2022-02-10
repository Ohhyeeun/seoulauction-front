<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<link type="text/css" href="/css/imgzoom/jquery.magnify.css" rel="stylesheet"> 
<link type="text/css" href="/css/imgzoom/magnify-bezelless-theme.css" rel="stylesheet">  
<script type="text/javascript" src="/js/imgzoom/jquery.magnify.js"></script>
<script>
app.controller('saleCtl', function($scope, consts, common, $interval, $sce, is_login) {
	$scope.is_login = is_login;
	$scope.sale_no = 0;
	$scope.sale_kind_cd = "${SALE_KIND_CD}";
	$scope.sale_outside_yn = "N"; 

	$scope.loadSaleMenuList = function(){
 		$d = {"actionList":[ 
 				{"actionID":"sale_list_paging", "actionType":"select" , "tableName": "SALES", "parmsList":[{"sale_kind_cd":$scope.sale_kind_cd, "sale_outside_yn": $scope.sale_outside_yn,  "status":"READY", "sort_by":"SALENODESC", "from":0, "rows":3}]}
 			 ]};
 		
 		common.callActionSet($d, $sMenuList);
	}
 	
 	$scope.loadSale = function(){
		$d = {"baseParms":{"sale_no":$scope.sale_no},
 				"actionList":[
 				{"actionID":"sale_info", "actionType":"select" , "tableName": "SALE"}, 
 				{"actionID":"sale_image_list", "actionType":"select" , "tableName": "SALE_IMG_LIST"}
 				
 			 ]};

	 	var $s = function(data, status) { 
	 		$scope.sale = data["tables"]["SALE"]["rows"][0];
	 		$scope.saleImgList = data["tables"]["SALE_IMG_LIST"]["rows"];
		};

		common.callActionSet($d, $s);
	}
 	
    $scope.getTrustURL = function (url) {
        return $sce.trustAsResourceUrl(url);
    }

    $scope.showLargeMap = function (url) {
        window.open(url, "_blank");
    }
    
 	var $sMenuList = function(data, status) {
 	    $scope.saleMenuList = data["tables"]["SALES"]["rows"];
		
 	    var saleNoArray = [];
	    for (var i=0; i< $scope.saleMenuList.length; i++){
			saleNoArray.push($scope.saleMenuList[i]["SALE_NO"]);   
	    }
	    console.log(saleNoArray);
	    console.log("${SALE_NO}");
	    console.log(saleNoArray.toString().indexOf("${SALE_NO}"));
	    if (saleNoArray.toString().indexOf("${SALE_NO}") < 0){
 	    	window.location.href = '/';
 	    }
	    
	    if($scope.saleMenuList.length == 0){
 	    	alert("현재 준비중입니다.");
 			window.history.back();
 	    }else{
 	 	    $scope.sale_no = ("${SALE_NO}" == "" ? $scope.saleMenuList[0]["SALE_NO"] : "${SALE_NO}");
 	 	    $scope.loadSale();
 	    }
	};
	$scope.img_idx = 0;
	
	$scope.setImgIdx = function(idx){
		$scope.img_idx = idx;
	}
	
	$scope.RCnt = 0;
	$scope.$on('ngRepeatFinished', function (ngRepeatFinishedEvent) {
		$scope.RCnt++;

        if($scope.RCnt == 2){
            $("#rollingBox123").slideFunc("", "#rolling123", "#thumb123");
        }
	});
});
</script>
<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="exhibition upcoming">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>

<div class="container_wrap">
	
	<div id="container" ng-controller="saleCtl" data-ng-init="loadSaleMenuList();">
		<div class="sub_menu_wrap menu01">
			<div class="sub_menu">
				<%@ include file="../include/subMenu.jsp" %>  
			</div>
			<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
		</div> 
		<!-- //sub_menu_wrap --> 			
		 
		<div class="UpComing_subming_wrap">  
			<!-- 경매오픈 전 이미지 수동   
			<div align="center" class="UpComing_img">  
				<img src="./images/img/222.jpg" alt="작품1" />     
			</div> -->  
			
			<div align="center" class="UpComing_img_auto">    
				<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{saleImgList[0].FILE_PATH+'/'+saleImgList[0].FILE_NAME}}" alt="작품1" class="img_master" style="max-height: 780px;"/>  
			</div>   
		</div> 
		
		<div class="UpComing_info" oncontextmenu="return false"> 
			<div class="contents m_top">
				<div class="ex_title">
					<div class="title">
						<div class="upcomming_title">   
							<span class="num" ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0">{{sale.SALE_TH | localeOrdinal}}</span>
							<span>{{sale.TITLE_JSON[locale]}}</span>
						</div>
						<div class="sub">
							<%-- 홍콩인 경우 시간 순서 변경 --%>
							<span><!--${map.fromDate }(${map.fromDayOfWeek }) ${map.fromTimeHKT } HKT--><!--(${map.fromTimeKST } KST)--></span>
							<span><!--${map.fromDate }(${map.fromDayOfWeek }) ${map.fromTimeKST } KST--></span>
							<br />
							<span><!--${map.selectedPlanning.place_kr }--></span>
						</div>
					</div>
					<div class="btn_wrap bg">
						<div>
							<span class="btn_style01 green05" style="  padding: 15px 45px 17px; background-color: #009999;">
								<span ng-if="sale.STAT_CD == 'open'">
									<a ng-href="/currentAuction?sale_kind=${SALE_KIND_CD}&sale_no={{sale.SALE_NO}}" class="fix">
										<font style=" font-size: 18px; font-weight:700;"><span ng-if="locale=='ko'">작품 보기</span>
										<span ng-if="locale!='ko'">SEE MORE</span></font></a>
					
								</span>	
								<span ng-if="sale.STAT_CD != 'open'">
									<a ng-href="" class="fix"><span ng-if="locale=='ko'">작품 준비중</span>
										<span ng-if="locale!='ko'">Preparing</span></a>
								</span>
							</span>
							<%-- <span class="btn_style01" style="  padding: 15px 45px 17px;">
								<span ng-if="is_login" style=" font-size: 18px; font-weight:700;">
								<a href="/customer/inquiryForm" class="fix"><spring:message code="label.membership.inquery" /></a>
								</span>
								<span ng-if="!is_login" style=" font-size: 18px; font-weight:700;">
								<a href="/login" class="fix"><spring:message code="label.membership.inquery" /></a>
								</span>
							</span> --%>
						</div>
					</div>
                    <br/><br/>
					<!-- <div ng-bind-html="<b>tset</b>"></div>-->
					<div class="txt"><span ng-bind-html="sale.CMMT_JSON[locale]"></span></div>
                    <br/><br/><br/>
				</div>
				<div class="ex_detail">  
					<div class="title"><spring:message code="label.upcoming.Preview" /></div>
                       	<br/><br/>
                       	<div class="master_detail">  
                       		<div class="detail">
								<!-- ydh test -->
								<div id="rollingBox123" class="left rolling_box3 web_only">
								<div class="img_represent">
									<div class="btns rolling_btn">
										<button type="button" class="sp_btn btn_prev"><span class="hidden"><spring:message code="label.move.prev" />1</span></button>
										<button type="button" class="sp_btn btn_next"><span class="hidden"><spring:message code="label.move.next" />1</span></button>
									</div>
									<div id="rolling123" class="hidden_box rolling">    
										<ul> 
											<li ng-repeat="img in saleImgList" style="text-align: center;" on-finish-render-filters>
												<a class="imgzoom_a" data-magnify="gallery" href="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" title="이미지 확대보기">
													<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" 
													alt="{{lot.TITLE}}" />
												</a>      
											</li>
										</ul> 
									</div> 
								</div> 
								<!-- <div id="thumb{{sale.SALE_NO}}{{lot.LOT_NO}}" class="thumb_list">-->
								<div id="thumb123" class="thumb_list" oncontextmenu="return false" ondragstart="return false" >
									<ul>  
										<li ng-repeat="img in saleImgList"  style="text-align: center;" on-finish-render-filters>
											<span>
											<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH : true}}"
											 alt="{{lot.TITLE_JSON[locale]}}" ng-click="setImgIdx($index);" /> 
											<span class="masking"></span>  
											</span>
										</li>
									</ul>
								</div>
							</div>
								<!-- ydh test -->
							<!--  
								<div class="left rolling_box2">
									<div class="img_represent">
										<div class="btns rolling_btn">
											<button type="button" class="sp_btn btn_prev"><span class="hidden">이전</span></button>
											<button type="button" class="sp_btn btn_next"><span class="hidden">다음</span></button>
										</div>
										<div class="hidden_box rolling">
											<ul style="width: 550px;">
												<li ng-repeat="saleImag in saleImgList">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{saleImag.FILE_PATH+'/'+saleImag.FILE_NAME}}" alt="" style="width: 100%; height: auto; margin-top: 105px;">
												</li>
											</ul>
										</div>
									</div>
									<div class="thumb_list">
										<ul>
											<li ng-repeat="saleImag in saleImgList"> --> <!-- class="sele"  -->
						<!-- 						<span>
												<span>
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{saleImag.FILE_PATH+'/'+saleImag.FILE_NAME}}" alt="" style="width: 100%; height: auto; margin-top: 9px;">
													<span class="masking"></span>
												</span>
											</li>
										</ul>
									</div>
								</div> --> <!-- PREVIEW_JSON -->
								
								<div class="right">
									<div class="info" ng-repeat="prev in sale.PREVIEW_JSON" ng-class="{first:$first}">
										<div >
											<dl>
												<dt><spring:message code="label.upcoming.Preview1" /></dt>
												<dd>{{prev.FROM_DT | date : 'yyyy.MM.dd'}} ({{getWeek(prev.FROM_DT)}}) 
													- {{prev.TO_DT | date : 'yyyy.MM.dd'}} ({{getWeek(prev.TO_DT)}}) </dd>
												<dd>{{prev.FROM_TIME | date : 'h a'}} – {{prev.TO_TIME | date : 'h a'}}</dd>
												<!-- <dd>{{prev.FROM_TIME | date : 'h a'}} – {{prev.TO_TIME | date : 'h a'}} KST</dd> -->
											</dl>
											<dl>
												<dt><spring:message code="label.upcoming.Preview2" /></dt>
												<dd>
													{{prev.PLACE_JSON[locale]}}
													<br>
													{{prev.ADDR_JSON[locale]}}
												</dd>
											</dl>
										</div>
										
										<div class="map_area comming_map_area">
											<div class="map">
												<iframe src="{{getTrustURL(prev.MAP_URL + '&amp;language=' + locale)}}" width="100%" height="200" frameborder="0" style="border:0"></iframe>
											</div> 
											<div class="btn_wrap"><!-- 20150612 --> 
												<div class="comming_mapbtn">  
													<span class="btn_style01 gray">
														<button type="button" ng-click="showLargeMap(getTrustURL(prev.MAP_URL + '&amp;language=' + locale));"><spring:message code="label.upcoming.Preview3" /></button>
													</span>
												</div>
											</div>
										</div>
									</div><!-- class="info first" --> 
								</div>
							</div>
                       	</div>
					</div>
			</div>				
		</div>
	</div>
</div>
</div>
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

/* 예정경매 Subbanner Img 규격 height 780px */
$(function(){ 
	$('.UpComing_img_auto > img').css('object-fit','cover');      
});    
</script> 
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />