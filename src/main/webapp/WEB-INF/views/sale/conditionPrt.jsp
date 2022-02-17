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
<link href="/css/old/detailprt.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<!-- <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-animate.min.js"></script> -->
<script type="text/javascript" src="/js/angular/angular-animate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>

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
 			    {"actionID":"lot_artist_other_lots", "actionType":"select" , "tableName": "OTHER_LOTS"}
 			 ]};

 	   	common.callActionSet($d, $sLot, null, finalRefresh);
	}

 	var $sLot = function(data, status) { 
 		$scope.sale = data["tables"]["SALE"]["rows"][0];
 		$scope.db_now = $scope.sale.DB_NOW;
 		$scope.exchRateList = data["tables"]["EXCH"]["rows"];
 		$scope.lot = data["tables"]["LOT"]["rows"][0];

 	    $scope.imageList = data["tables"]["IMAGES"]["rows"];
 	    $scope.otherLotList = data["tables"]["OTHER_LOTS"]["rows"];
 	   
 	    $scope.base_currency = $scope.sale.CURR_CD;
 	    $scope.base_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKT" : "KST");
 		$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
 		$scope.sub_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KST" : "HKT");

 		// 컨디션리포트 출력 승인한 경우만 처리. 출력 요청시에는 해당 lot번호에 cr_inte_lot = 'N' 임
 		if ($scope.lot.CR_INTE_LOT != 'Y'){
			$d1 = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no}, 
					"actionList":[
					{"actionID":"add_cust_cr_lot", "actionType":"insert", "tableName":"CUST_CR_LOT", "parmsList":[{}]}
					]};
	 	   
 	 	  	var $s1 = function(data, status) { $scope.crSave = data["tables"]["CUST_CR_LOT"]["rows"]; };
 			 			 			
 			common.callActionSet($d1, $s1);
 			window.opener.location.reload(true);
		}			
 		
 		//var key = $scope.sale.SALE_NO + "" + $scope.lot.LOT_NO;
 		console.log("=======>>>>> end");
 	};
 	
	var finalRefresh = function(){
		//$scope.runLotsRefresh(); 
	}
});
</script>
<script type="text/javascript" src="/js/bid.js"></script>



<body> 
<div class="page">
	<c:set var="locale" scope="session" value="${pageContext.response.locale}" />
	<c:set var="is_korean" scope="session" value="${locale eq 'ko'}" />
	<c:set var="is_login" scope="session" value="false" />
	<sec:authorize access="hasRole('ROLE_FRONT_USER')">
		<c:set var="is_login" scope="session" value="true" />
	</sec:authorize>
	<c:set var="is_login" scope="session" value="${pageContext.request.userPrincipal.name != null}" />
	
	<script type="text/javascript">
	app.value('locale', '${locale}');
	app.value('is_login', '${is_login}');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN
	

	
	/********************/
	$(document).ready(function(){
		
		url = document.location.pathname;
	
		var winWidth = $(window).width();
		if(winWidth > 1024) {
			type = "web";
		}
		else if(winWidth <= 1024 && winWidth >= 768) {
			type = "tablet";
		}
		else if(winWidth < 768) {
			type = "phone";
		}
		
		showTopLayer();
		//mobileGnb();
		
	});

	function showTopLayer() {
		//var html = $(msg).filter("#kanggTopLayer").children().clone();
		//$('#kanggTopLayer').html(html);
		$("#kanggTopLayer").show();
		
		src960 = $("#topLayerImage").attr("src");
		src768 = $("#topLayerImage").attr("src");
		src320 = $("#topLayerImage").attr("src");
		
		var winWidth = $(window).width();
		if(winWidth > 1024){
			$('.curtain_wrap img').attr('src', src960);
			$('.curtain_wrap').removeClass('response01');
			$('.curtain_wrap').removeClass('response02');
		} else if(winWidth < 768){
			$('.curtain_wrap img').attr('src', src320);
			$('.curtain_wrap').removeClass('response02');
			$('.curtain_wrap').addClass('response01');
		} else {
			$('.curtain_wrap img').attr('src', src768);
			$('.curtain_wrap').removeClass('response01');
			$('.curtain_wrap').addClass('response02');
		}
	}
	
	</script>

	<div ng-controller="lotDetailCtl" data-ng-init="loadLotDetail();">
		
		<div>
			<div class="subpage">
                <div style="float:right">					 
                    <span class="noprint"><a href="javascript:window.print();"><img src="https://www.seoulauction.com/images/icon/print.png" border="0" style="width:88px; height:auto" alt="print"></a></span>                  	
				</div>
                <div class="fontxlarge"><img src="https://www.seoulauction.com/images/icon/print_logo.png" border="0" style="width:150px;" alt="SeoulAuction"></div> 
				
				<div style="padding-top:15px;">
                    <!-- 온라인 경매  -->
                    <div ng-if="sale.SALE_KIND_CD == 'online'">
                        <%-- 온라인 경매 시작 전 --%>
                        <div ng-if="sale_status == 'READY'">
                            <div>
                                <ul>
                                    <li>{{lot.FROM_DT | dateFormat}} KST 시작</li>
                                </ul>
                            </div>
                        </div>
                        <%-- 온라인 경매 진행 중 --%>
                        <%-- 경매 시작가가 없는 경우 추정가 최저가가 시작가가 되야함 --%>
                        <div ng-if="sale_status == 'ING'">
                            <div><spring:message code="label.auction.ongoing" /></div>
                            <div>
                                <ul>
                                    <li id="leftTime" class="time">{{db_now | timeDuration : lot.TO_DT}}</li>
                                    <li><spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" /></li>
                                    <li><spring:message code="label.bid.price" /> <strong class="txt_green02">KRW <span id="current_price">{{lot.LAST_PRICE | number:0}}</span></strong></li>
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
                            <div>end <spring:message code="label.auction.finish" /></div>
                            <div>
                                <ul>
                                    <li class="time">{{lot.TO_DT | dateFormat}} KST <spring:message code="label.auction.finish" /></li>
                                    <li><spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" /></li>
                                    <li><strong class="txt_impo" ng-if="!lot.LAST_PRICE || lot.LAST_PRICE <= 0"><spring:message code="label.auction.unsold" /></strong></li>
                                    <li><strong class="txt_impo" ng-if="lot.LAST_PRICE > 0"><spring:message code="label.bid.price.sold" /> KRW {{lot.LAST_PRICE | number:0}}</strong></li>
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
                        <div style="text-align:center">
                           <p class="fontsmall" ng-if="lot.SALE_NO != '408'">{{sale.SALE_TH}} {{sale.TITLE_JSON[locale]}}</p>
                           <p class="fontsmall" ng-if="lot.SALE_NO == '408'">{{sale.TITLE_JSON[locale]}}</p>
                           
                           <p class="fontxlarge" style="text-align:center;">CONDITION REPORT</p>
                           
                           <p class="fontm" style="text-align:left; margin-top:15px;">
                                <span border="0" style="width:12px; vertical-align: text-bottom;" alt="line">
                                	■ AUCTION DATE : 
	                                {{sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.MM.dd(EEE) ha' : 'UTC+9'}} {{base_timezone}}
	                                ({{sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'ha' : 'UTC+9'}} {{sub_timezone}})
	                                <!--장소
	                                <br/> 
	                                <img src="https://www.seoulauction.com/images/icon/less1.png" border="0" style="width:12px;vertical-align: text-bottom;" alt="line">{{sale.PLACE_JSON[locale]}}
									장소-->
								</span>
                           </p>
                        </div> 
                    </div>
                    <!-- //오프라인 경매  -->
				</div>
				  
				<div>
					<div style="margin-top:5px;">
						<div align="left">
					    	<div style="width:600px; height:310px;">
								<div ng-repeat="img in imageList" on-finish-render-filters>
								<span ng-if="$index == 0">
									<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" 
									alt="{{lot.TITLE}}" style="height: auto; max-height:300px; width:auto; max-width:500px;"/>
								</span>
								</div>  
					    	</div> 
                        </div>
						<div style="line-height:24px;">
							<div class="fontlot">Lot.{{lot.LOT_NO}}</div>                            
                            <div>
								<span class="fontlot">
                               {{lot.ARTIST_NAME_JSON[locale]}}
									<span ng-if="locale != 'en'">
									&nbsp;{{lot.ARTIST_NAME_JSON.en}}
									</span>
									<span class="txt_cn">&nbsp;{{lot.ARTIST_NAME_JSON.zh}}</span>
								</span>
								<span style="color:#999; font-size:11px;">
                                &nbsp;{{lot.BORN_YEAR}}{{lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : ''}}</span>
							</div>
							<!-- 홍콩경매 여부에 따른 화면표시 확인 -->
							<div>
								<%-- 작품제목 중복인경우 하나만 보여주기(2015.11.17. YDH) --%>
								<div style="color:#999; font-size:13px;">
                                    <span>{{lot.TITLE_JSON[locale]}}</span>
										<span>
											{{lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale]}}
										<span ng-if="lot.TITLE_JSON['zh'] != lot.TITLE_JSON['en']">
											<span ng-if="lot.TITLE_JSON.zh != null">{{lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale] }}</span>
										</span>
									</span> 
								</div>
								<div style="color:#999; font-size:13px; margin-top:-3px;">
									<span ng-if="lot.MATE_NM">
                                        {{lot.MATE_NM_EN}}
										<!--{{"MATE_NM" | localeValue : lot}}
										<span ng-if="locale == 'ko' && lot.MATE_NM_EN != lot.MATE_NM">{{lot.MATE_NM_EN}}</span>-->
									</span>
                                    <br/>
									<span ng-repeat="size in lot.LOT_SIZE_JSON" style="margin-top:-3px;">
										{{size | size_text}}
									</span>
									<span ng-if='lot.EDITION'>{{lot.EDITION}}</span>
									<span ng-if='lot.MAKE_YEAR_JSON[locale]'>
										, {{lot.MAKE_YEAR_JSON['ko']}}									
									</span>
                                    <br/>
									<span ng-if='lot.SIGN_INFO_JSON[locale]' style="margin-top:-3px;">
										<span bind-html-compile="lot.SIGN_INFO_JSON['ko']"></span>
									
									</span>
								</div>
							</div>
							<div style="font-size:13px; font-weight:600; margin-top:10px;">
								<!--<spring:message code="label.expense.price" />-->

									<span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
									<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'">
										<p>
											{{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + " " : 0}} 
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)">~</span>
											{{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}} 
										</p>
										<p>
											{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}} 
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)">~</span>
											{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}
										</p>
										<p>
											{{lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + " " : 0}} 
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)">~</span>
											{{lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0}}
										</p>
									</span>
									<!--시작가-->
									<span ng-if="sale.SALE_KIND_CD == 'online' && lot.START_PRICE > 0">									
										<span class="txt_dark"><spring:message code="label.expense.start_price" /></span>
										<p>KRW {{lot.START_PRICE | number : 0}}</p>
									</span>
									<!--시작가끝-->	
									<!-- YBK_낙찰가 추가 
										<strong class="txt_green02">
											<span ng-if="sale.SALE_KIND_CD == 'online' && sale_status == 'ING'"><spring:message code="label.bid.price" /></span>
											<span ng-if="sale_status == 'END'"><spring:message code="label.bid.price.sold" /></span>
											<span ng-if="lot.LAST_PRICE > 0">{{sale.CURR_CD}} {{lot.LAST_PRICE | number:0}}</span>
										</strong>
									YBK_낙찰가 추가 -->
							</div>
							<br />
							<div class="bg_grey" ng-if='lot.COND_RPT_JSON[locale]'>
								<span ng-bind="lot.COND_RPT_JSON[locale]"></span>
								<span ng-bind="lot.COND_RPT_JSON["en"] | trimSameCheck : lot.COND_RPT_JSON[locale]"></span>
								<p ng-if="lot.COND_RPT_JSON['zh'] != lot.COND_RPT_JSON['en']">
									<span ng-bind="lot.COND_RPT_JSON["zh"] | trimSameCheck : lot.COND_RPT_JSON[locale]"></span>
								</p>
							</div>
							
							<div style="font-size:11px; line-height:15px; margin-bottom:15px;">
								<br />
								In response to your inquiry, we are pleased to provide to provide you with a general report of the condition of the property described above. 
								Since we are not professional conservators or restorers, we urge you to consult with a restorer or conservator of your choice 
								who will be better able to provide a detailed, professional report. Prospective buyers should inspect each lot to satisfy themselves 
								as to condition and must understand that any statement made by Seoul Auction is merely a subjective qualified opinion Notwithstanding 
								this report or any discussions concerning condition of a lot, all lots art offered and sold "AS IS" in accordance with the condition of sale printed in the catalogue.
							</div>
							
							<div>
								<img src="https://www.seoulauction.com/images/icon/print_footer.jpg" border="0" style="height: auto; width: 100%;">
							</div>                       
						</div>
					</div> 
				</div>
			</div>
		</div>

					
	</div>



</body>
</html>
