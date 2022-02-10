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
<link href="/css/old/detailprt.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<!--  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-animate.min.js"></script>-->
<script type="text/javascript" src="/resources/js/angular/angular-animate.min.js"></script>
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
 			if(['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && !$scope.now_timer_start){
 				$interval(function(){$scope.db_now = moment($scope.db_now).add(1, 'seconds');}, 1000);
 			} 
 		}
 		else if(TO_DT < S_DB_NOW){
 			$scope.sale_status = "END";
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
 		if(['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && $scope.sale.STAT_CD == 'open' && $scope.sale_status == "ING"){
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
		m_sImagePath = m_sImagePath.replace("thum/", "");
		$(".btn_zoom").click();
	}
	
	$scope.RCnt = 0;
	$scope.$on('ngRepeatFinished', function (ngRepeatFinishedEvent) {
		$scope.RCnt++;
        if($scope.RCnt == 2){
            $("#rollingBox123").slideFunc("", "#rolling123", "#thumb123");
        }
	});
});

// 자세히 보기 팝업
var m_sImagePath ="";


</script>
<script type="text/javascript" src="/resources/js/bid.js?${resources.timestamp}"></script>



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
	
	//최근공지가져오기
	app.controller("recentNoticeCtl", function($scope, consts, common) {
	  	$scope.loadRecentNotice = function(){
	  	   	$d = {"actionList":[
	  	   	     	{"actionID":"bbs_notice_recent", "actionType":"select" , "tableName": "WRITES", "parmsList":[{"from": 0, "rows":consts.NOTICE_RECENT_ROWS}]}
	  	   	     ]};
	  	    	        		
	  	   	var $s = function(data, status) { $scope.recentList = data["tables"]["WRITES"]["rows"]; };
	  		
	  	  	common.callActionSet($d, $s);
		}
	});
	
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
	
	/*function mobileGnb(){
		var isMobile = {
			Android: function() {
				return navigator.userAgent.match(/Android/i);
			},
			BlackBerry: function() {
				return navigator.userAgent.match(/BlackBerry/i);
			},
			iOS: function() {
				return navigator.userAgent.match(/iPhone|iPad|iPod/i);
			},
			Opera: function() {
				return navigator.userAgent.match(/Opera Mini/i);
			},
			Windows: function() {
				return navigator.userAgent.match(/IEMobile/i);
			},
			any: function() {
				return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
			}
		};
		
		if(isMobile.any()) {
			investHide();
		}
	
	}*/
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
                <div style=" float:right">					 
                    <span  class="noprint"><a href="javascript:window.print();"><img src="/images/icon/print.png" border="0" style="width:88px; height:auto" alt="print"></a></span>                  	
				</div>
                <div class="fontlarge"><img src="/images/icon/print_logo.png" border="0" style="width:218px;" alt="SeoulAuction"></div> 
				
				<div style="padding-top:15px;">
                    <!-- 온라인 경매  -->
                    <div ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
                         <span ng-bind="sale.TITLE_JSON[locale]"></span>
                        <%-- 온라인 경매 시작 전 --%>
                        <div ng-if="sale_status == 'ING'">
                            <div>
                                <ul>
                                    <li>{{lot.TO_DT | dateFormat}} KST</li>
                                </ul>
                            </div>
                        </div>
                        <%-- 온라인 경매 진행 중 --%>
                        <%-- 경매 시작가가 없는 경우 추정가 최저가가 시작가가 되야함 (마감후 리프레쉬 필요함)--%>
                        <!--<div ng-if="sale_status == 'ING'">
                            <div><spring:message code="label.auction.ongoing" /></div>
                            <div>
                                <ul>
                                    <li id="leftTime" class="time">{{db_now | timeDuration : lot.TO_DT}}</li>
                                    <li><spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" /></li>
                                    <li><spring:message code="label.bid.price" /> <strong class="txt_green02">KRW <span id="current_price">{{lot.LAST_PRICE | number:0}}</span></strong></li>
                                </ul>
                                
                            </div>
                        </div>	-->					
                        <%-- 온라인 경매 종료 --%>
                        <div ng-if="sale_status == 'END'">
                            <!--<div><spring:message code="label.auction.finish" /></div>-->
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
                        <div style="text-align:left;"> 
                           <p ng-if="lot.SALE_NO != '412'" class="fontlarge">{{sale.SALE_TH}}{{sale.SALE_TH_DSP}} {{sale.TITLE_JSON[locale]}}</p>
                           <p ng-if="lot.SALE_NO == '412'" class="fontlarge">{{sale.TITLE_JSON[locale]}}</p>
                            <p class="fontm">
                                <img src="/images/icon/less1.png" border="0" style="width:12px;vertical-align: text-bottom;" alt="line">Auction :&nbsp; 
                                {{sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.MM.dd(EEEE) ha' : 'UTC+9'}} {{base_timezone}}
                                ({{sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'ha' : 'UTC+9'}} {{sub_timezone}})
                                <br/> 
                                <img src="/images/icon/less1.png" border="0" style="width:12px;vertical-align: text-bottom;" alt="line">{{sale.PLACE_JSON[locale]}}
                                </p>

                        </div> 
                    </div>
                    <!-- //오프라인 경매  -->
				</div>
				  
				<div>
					<div style=" margin-top:20px;">
						<div align="center">
					    	<div style="width:600px; height:400px;">
								<div ng-repeat="img in imageList" on-finish-render-filters>
								<span ng-if="$index == 0">
									<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_NAME | imagePath : img.FILE_PATH}}" 
									alt="{{lot.TITLE}}" style="height: auto; max-height:380px; width:auto; max-width:580px;"/>
								</span>
								</div>  
					    	</div> 
                        </div>
						<div style="margin-top:20px; line-height:24px;">
							<div class="fontlot">Lot.{{lot.LOT_NO}}</div>
                            <div>
								<span class="fontname">
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
							<div style="margin-top:10px;">
								<%-- 작품제목 중복인경우 하나만 보여주기(2015.11.17. YDH) --%>
								<div style="color:#999; font-size:13px;">
                                    <span>{{lot.TITLE_JSON[locale]}}</span>
									<span>
										{{lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale] }}
									<span ng-if="lot.TITLE_JSON['zh'] != lot.TITLE_JSON['en']"><span ng-if="lot.TITLE_JSON.zh != null">{{lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale] }}</span></span> 
									</span> 
								</div>
								<div style="color:#999; font-size:13px;">
									<span ng-if="lot.MATE_NM">
                                        {{lot.MATE_NM_EN}}
										<!--{{"MATE_NM" | localeValue : lot}}
										<span ng-if="locale == 'ko' && lot.MATE_NM_EN != lot.MATE_NM">{{lot.MATE_NM_EN}}</span>-->
									</span>
                                    <br/>
									<span ng-repeat="size in lot.LOT_SIZE_JSON">
										{{size | size_text}}
									</span>
									<span ng-if='lot.EDITION'>{{lot.EDITION}}</span>
									<span ng-if='lot.MAKE_YEAR_JSON[locale]'>
										, {{lot.MAKE_YEAR_JSON['ko']}}									
									</span>
                                    <br/>
									<span ng-if='lot.SIGN_INFO_JSON[locale]'>
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
									<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.START_PRICE > 0">									
										<span class="txt_dark"><spring:message code="label.expense.start_price" /></span>
										<p>KRW {{lot.START_PRICE | number : 0}}</p>
									</span>	
									<!--시작가끝-->	
									<!-- YBK_낙찰가 추가 
										<strong class="txt_green02">
											<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING'"><spring:message code="label.bid.price" /></span>
											<span ng-if="sale_status == 'END'"><spring:message code="label.bid.price.sold" /></span>
											<span ng-if="lot.LAST_PRICE > 0">{{sale.CURR_CD}} {{lot.LAST_PRICE | number:0}}</span>
										</strong>
									 YBK_낙찰가 추가 -->

							</div>
                            <div style="color:#999; font-size:11px; margin-top:14px;">
                            	【Condition】&nbsp;&nbsp;<span ng-if="lot.FRAME_CD!='none'" ng-bind="lot.FRAME_CD"></span><br/>
                                <p ng-if='lot.COND_RPT_JSON[locale]'>
                                    {{lot.COND_RPT_JSON[locale]}}
                                    <!--{{lot.COND_RPT_JSON["en"] | trimSameCheck : lot.COND_RPT_JSON[locale] }}
                                    <p ng-if="lot.COND_RPT_JSON['zh'] != lot.COND_RPT_JSON['en']">
                                    {{lot.COND_RPT_JSON["zh"] | trimSameCheck : lot.COND_RPT_JSON[locale] }}</p>-->
                                </p>
                            </div>

							<div style="border-top:#e4e4e4 solid 1px; margin-top:25px;">
								<div style="margin-top:10px;" ng-if="locale == 'ko'">
									<img src="/images/icon/print_foot.png" border="0" style="height: auto; width: 100%;">
								</div>  
                                <div style="margin-top:10px;" ng-if="locale != 'ko'">
									<img src="/images/icon/print_foot_en.png" border="0" style="height: auto; width: 100%;">
								</div>
							</div>
							
                            
						</div>
					</div> 
				</div>
			</div>
		</div>

					
	</div>



</body>
</html>
