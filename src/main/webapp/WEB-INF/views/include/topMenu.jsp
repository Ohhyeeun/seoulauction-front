<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="locale" scope="session" value="${pageContext.response.locale}" />
<c:set var="is_korean" scope="session" value="${locale eq 'ko'}" />
<c:set var="is_login" scope="session" value="false" />
<sec:authorize access="hasRole('ROLE_FRONT_USER')">
	<c:set var="is_login" scope="session" value="true" />
</sec:authorize>
<c:set var="is_login" scope="session" value="${pageContext.request.userPrincipal.name != null}" />

<!-- 모바일메뉴 --> 
<link rel="stylesheet" href="/css/topmenu02.css" type="text/css">          
<script src="/js/topmenu02.js"></script>   

<script type="text/javascript">
app.value('locale', '${locale}');
app.value('is_login', '${is_login}');
app.value('_csrf', '${_csrf.token}');
app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN
// 진행여부 표시


app.controller("saleIngCtl", function($scope, consts, common) {
	$scope.offlineIng = 0;
	$scope.onlineIng = 0;
	$scope.exhibitIng = 0;
	$scope.etcIng = 0;
	$scope.onlineUpcomingIng = 0;
	$scope.offlineUpcomingIng = 0;
	$scope.academyIng= 0;
	$scope.zerobaseIng= 0;
	$scope.outsideIng=0;
	$scope.recruitMent = 0;  
 
	$scope.init = function(){
		$scope.loadSaleIng();
	}
	
  	$scope.loadSaleIng = function(){
  	   	$d = {"actionList":[
  	   	     	{"actionID":"sale_ing_count", "actionType":"select" , "tableName": "SALE_ING"}
  	   	     ]};
     		
  	   	var $s = function(data, status) { 
  	   	$scope.saleIngList = data["tables"]["SALE_ING"]["rows"][0];
  	  	$scope.offlineIng = $scope.saleIngList.OFFLINE_COUNT;
	  	  	$scope.onlineIng = $scope.saleIngList.ONLINE_COUNT;
	 	 	$scope.onlineUpcomingIng = $scope.saleIngList.ONLINE_UPCOMING_COUNT;
	 		$scope.offlineUpcomingIng = $scope.saleIngList.OFFLINE_UPCOMING_COUNT;
	 		$scope.academyIng = $scope.saleIngList.ACADEMY_COUNT;
	  	  	$scope.exhibitIng = $scope.saleIngList.EXHIBIT_COUNT;
	  	  	$scope.etcIng = $scope.saleIngList.ETC_COUNT;
	  	  	$scope.zerobaseIng = $scope.saleIngList.ZEROBASE_COUNT;
	  	 	$scope.outsideIng=$scope.saleIngList.OUTSIDE_COUNT;
	  	 	$scope.recruitMent = $scope.saleIngList.RECRUITMENT_COUNT; 
  	   	};	
  	  	common.callActionSet($d, $s); 
	}
});
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

//최근언론보도가져오기
app.controller("recentPressCtl", function($scope, consts, common) {
  	$scope.loadRecentPress = function(){
  	   	$d = {"actionList":[
				{"actionID":"pressList", "actionType":"select" , "tableName": "PRESS_LIST" ,"parmsList":[{"from": 0, "rows":consts.NOTICE_RECENT_ROWS, "search_lang":$scope.locale}]}  	   	     	
  	   	     ]};
  	    	        		
  	   	var $s = function(data, status) { $scope.recentPressList = data["tables"]["PRESS_LIST"]["rows"]; };
  		
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
	
	
	$("#offlineCurrBtn").click(function() {
		if("${pageContext.response.locale}"=='ko'){
			alert("진행 경매가 없습니다");
		} else {
			alert("There is no auctions going on currently.");
		}
	});
	$("#offlineUpcomBtn").click(function() {
		if("${pageContext.response.locale}"=='ko'){
			alert("예정 경매가 없습니다");
		} else {
			alert("There is no upcoming auctions currently.");
		}
	});
	$("#onlineCurrBtn , #zerobaseBtn").click(function() {
		if("${pageContext.response.locale}"=='ko'){
			alert("진행 경매가 없습니다");
		} else {
			alert("There is no auctions going on currently.");
		}
	});
	$("#onlineUpcomBtn").click(function() {
		if("${pageContext.response.locale}"=='ko'){
			alert("예정 경매가 없습니다");
		} else {
			alert("There is no upcoming auctions currently.");
		}
	});
	$("#outsideIngBtn").click(function() {
		if("${pageContext.response.locale}"=='ko'){
			alert("예정 경매가 없습니다");
		} else {
			alert("There is no auctions going on currently.");
		}
	});  
	
	$("#recruit_Ingbtn").click(function() {
		if("${pageContext.response.locale}"=='ko'){
			alert("진행중인 채용공고가 없습니다");
		} else {
			alert("There is no open recruitment");  
		}
	});   
	
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


<div class="header_wrap"  ng-controller="saleIngCtl" data-ng-init="init();">
         <!-- <div style="height:20px; width:200px; font-size:11px; display: inline-table; clear:both; float:right;" >
			<ul class="fl_menu">
			
                <li style="margin-right: 20px;"><a target="_blank" href="http://www.auctionblue.com "style="color:#666;">Auction Blue</a></li>
                <li style="margin-right :10px;"><a target="_blank" href="http://www.printbakery.co.kr" style="color:#666;"><spring:message code="label.printbakery" /></a></li>
			</ul>
			
		</div>-->

	<div class="web_main_menu_wrap">  
		<div id="header">
	         
			<h1><a href="/" ><span class="hidden">Seoul Auction EST.1998</span></a></h1>
			<div class="gnb_menu">
				<ul class="fl_menu">  
					<li><a href="#" class="sp_txt menu01"><span class="hidden">Auction</span></a></li>
					<li><a href="#" class="sp_txt menu02"><span class="hidden">Online</span></a></li>
					<li><a href="#" class="sp_txt menu03"><span class="hidden">Private Sale</span></a></li>  
					<li><a href="#" class="sp_txt menu04"><span class="hidden">Service</span></a></li>
					<li><a href="#" class="sp_txt menu05"><span class="hidden">About</span></a></li>
				</ul>
			</div>
			<div class="gnb_menu_layer">
				<button class="sp_btn btn_gnbmenu_close web_menu_close"><span class="hidden">메뉴레이어 닫기</span></button>
				<div class="m_util_menu m_only">
					<ul class="fl_menu">
						<c:if test="${locale == 'ko'}">
						<li><a href="/?lang=en">Eng</a></li>
						</c:if>
						<c:if test="${locale == 'en'}">
						<li><a href="/?lang=ko">Kor</a></li>
						</c:if>
						<c:if test="${is_login}">
							<li id="accountBtn"><a href="/customer/myPage" style="color:#fff;">ACCOUNT</a></li>
							<li><a href="javascript:document.getElementById('logoutForm').submit();" style="color:#fff;">LOGOUT</a></li>
						</c:if>
						<c:if test="${!is_login}"> 
							<li><a href="login">Login</a></li>
						</c:if>					
					</ul> 
				</div>   
				<div class="left web_menu_left">   
					<div class="m_scrollable">
						<div id="gnbMenuConatiner"> 
							<div class="gnb_menu gnb_menu02"> 
								<ul id="gnbMenuList web_gnbMenuList">
									<li>
										<span class="sp_txt menu01"><span class="hidden">Auction</span></span>  
										<ul>   
											<li>     
	                                        <span ng-if="offlineIng > 0"><a href="/currentAuction?sale_kind=offline_only&page=1&lang={{locale}}"><!--<a href="#">-->
	                                            <spring:message code="label.auction.offlinecurrent" />
		                                        <img src="/images/icon/now_icon.png" /></a></span>   
											<span ng-if="offlineIng == 0 || offlineIng == null" id="offlineCurrBtn"><spring:message code="label.auction.offlinecurrent" /></span> 
	                                        <!--<span id="offlineCurrBtn"><spring:message code="label.auction.current" /></span> -->   
											</li>
											<li>
											<span ng-if="offlineUpcomingIng > 0"><a href="/upcomingAuction?sale_kind=offline_only&lang={{locale}}"><spring:message code="label.auction.upcoming" /><img src="/images/icon/now_icon.png" /></a></span>
											<span ng-if="offlineUpcomingIng == 0 || offlineUpcomingIng == null" id="offlineUpcomBtn"><spring:message code="label.auction.upcoming" /></span>
											<%-- <span id="offlineUpcomBtn"><spring:message code="label.auction.upcoming" /></span>  --%>
											</li>  
											<li><a href="/resultAuction?sale_kind=offline_only&page=1&lang={{locale}}"><spring:message code="label.auction.result" /></a></li>
	                                        <li><a href="/auctionGuide/page?view=biddingGuide&lang={{locale}}"><spring:message code="label.howto.bid" /></a></li>  
	                                        <!--<li><a href="/auctionGuide/page?view=commissionGuide&lang={{locale}}"><spring:message code="label.howto.contract" /></a></li> -->
	                                       <!-- <li><a href="/auctionGuide/page?view=winningBidGuide"><spring:message code="label.howto.buy" /></a></li>
	                                        <li><a href="/auctionGuide/page?view=deliveryGuide"><spring:message code="label.howto.delivery" /></a></li> 
											<li><a href="/otherSales"><spring:message code="label.sale.exhibit" /></a></li>-->
										</ul>  
									</li>   
									<li>
										<span class="sp_txt menu02"><span class="hidden">Online</span></span>
										<ul>  
											<li> 
	                                            <span ng-if="onlineIng > 0"><a href="/currentAuction?sale_kind=online_only&page=1&lang={{locale}}"><spring:message code="label.auction.current" /><img src="/images/icon/now_icon.png" /></a></span>
	                                            <span ng-if="onlineIng == 0 || onlineIng == null" id="onlineCurrBtn"><spring:message code="label.auction.current" /></span> 
											</li>      
											<li>
	                                            <span ng-if="onlineUpcomingIng > 0"><a href="/upcomingAuction?sale_kind=online_only&lang={{locale}}"><spring:message code="label.auction.upcoming" /><img src="/images/icon/now_icon.png" /></a></span> 
	                                            <span ng-if="onlineUpcomingIng == 0 || onlineUpcomingIng == null" id="onlineUpcomBtn"><spring:message code="label.auction.upcoming" /></span>
	                                          	<!-- <span id="onlineUpcomBtn"><spring:message code="label.auction.upcoming" /></span> -->
	 										</li>
                                            <li>
												<a href="https://www.blacklot.com/" ng-if="locale=='ko'" target="_blank">블랙랏<img src="/images/icon/now_icon.png"/></a>  
                                                <a href="https://www.blacklot.com/" ng-if="locale!='ko'" target="_blank">BLACKLOT<img src="/images/icon/now_icon.png"/></a>    
                                            </li> 
                                            <li>      
	                                            <span ng-if="outsideIng > 0"><a href="https://www.seoulauction.com/currentAuction?sale_outside_yn=Y&lang={{locale}}">
                                                <span ng-if="locale=='ko'">아트시 경매</span><span ng-if="locale!='ko'">ARTSY Auction</span><img src="/images/icon/now_icon.png" /></a></span> 
                                                <span ng-if="outsideIng == 0 || outsideIng == null" id="outsideIngBtn"><span ng-if="locale=='ko'">아트시 경매</span><span ng-if="locale!='ko'">ARTSY Auction</span></span>   
											</li>                 
	                                        <!-- <li><a href="/resultAuction?sale_kind=online&page=1&lang={{locale}}"><spring:message code="label.auction.result" /></a></li> --> 
	                                        <li><a href="/auctionGuide/page?view=onlinebidGuide&lang={{locale}}"><spring:message code="label.howto.onbid" /></a></li>
	                                        <li class="zero_bar" style="cursor: none;"></li>  
	                                        <li>
	                                            <span ng-if="zerobaseIng > 0"><a href="/currentAuction?sale_kind=zerobase_only&page=1&lang={{locale}}"><span ng-if="locale=='ko'">제로베이스 경매</span><span ng-if="locale!='ko'">Zero base</span><img src="/images/icon/now_icon.png" /></a></span>
	                                            <span ng-if="zerobaseIng == 0 || zerobaseIng == null" id="zerobaseBtn"><span ng-if="locale=='ko'">제로베이스 경매</span><span ng-if="locale!='ko'">Zero base</span></span> 
											</li>
	                                        <li>
	                                            <a href="https://www.seoulauction.com/zerobaseArtist?page=1&lang={{locale}}"><span ng-if="locale=='ko'">제로베이스 작가</span><span ng-if="locale!='ko'">Zero base Artist</span><span ng-if="zerobaseIng > 0"><img src="/images/icon/now_icon.png" /></a></span>
	                                            <!-- <span ng-if="zerobaseIng == 0 || zerobaseIng == null" id="zerobaseBtn"><span ng-if="locale=='ko'">제로베이스 작가</span><span ng-if="locale!='ko'">Zero base Artist</span></span> --> 
	                                        </li>
											<!--<li><a href="/resultAuction"><spring:message code="label.auction.result" /></a></li>-->
										</ul> 
									</li>   
									<li>  
										<span class="sp_txt menu03"><span class="hidden">Private Sale</span></span>   
										<ul>
											<li><a href="/currentPrivate?lang={{locale}}"><spring:message code="label.ps.privatesale" />
                                            <!-- <img src="/images/icon/now_icon.png" /></a>--></li>  
											<!-- <li><a href="/currentExhibit?sale_kind=exhibit_only"><spring:message code="label.ps.privatesale" /> -->
	                                        <!-- <img src="/images/icon/now_icon.png" /> </a></li> -->   
											<!-- <li><a href="/ps/page?view=gallery_network"><spring:message code="label.ps.gallerynetwork" /></a></li> -->
											<li><a href="/ps/page?view=priGuide&lang={{locale}}"><spring:message code="label.ps.privateguide" /></li></a> 
										</ul> 
									</li> 
									<li>
										<span class="sp_txt menu04"><span class="hidden">Service</span></span>   
										<ul>
										    <!-- <li><a href="/search"><spring:message code="label.artwork.search" /></a></li>
										    <li><a href="/service/page?view=displayPlan"><spring:message code="label.exhibition.curation" /></a></li>-->
	                                        <li>
                                            	<a href="/service/page?view=academy&lang={{locale}}"><spring:message code="label.academy" /><span ng-if="academyIng > 0"><img src="/images/icon/now_icon.png" /></span></a></span>  
                                            </li>  
											<li><a href="/service/page?view=corporationArtwork&lang={{locale}}"><spring:message code="label.company.artwork" /></a></li>
	                                        <li><a href="/service/page?view=rentExhibitionCenter&lang={{locale}}"><spring:message code="label.space.rental" /></a></li>
	                                        <li><a href="/service/page?view=securedLoan&lang={{locale}}"><spring:message code="label.collateral.loan" /></a></li>
	                                        <li><a href="/service/page?view=chinaArtwork&lang={{locale}}"><spring:message code="label.china.artwork.auth" /></a></li>
	                                        <li><a href="/service/page?view=storageInsa&lang={{locale}}"><spring:message code="label.artwork.keep" /></a></li>
	                                        <!-- <li><a href="/service/page?view=ArtDonations&lang={{locale}}"><spring:message code="label.company.artwork-artdonation" /></a></li> -->
                                            <li ng-if="locale==='ko'"><a href="/service/page?view=Newsletter"><spring:message code="label.newsletter" /></a></li> 
										</ul>  
									</li>    
									<li> 
										<span class="sp_txt menu05"><span class="hidden">About</span></span>
										<ul>
											<li><a href="/about/page?view=introduction&lang={{locale}}"><spring:message code="label.seoulauction.introduction" /></a></li>
	                                        <li><a href="/about/page?view=introGang&lang={{locale}}"><spring:message code="label.seoulauction.introgang" /></a></li>
											<li><a href="/about/page?view=history&lang={{locale}}"><spring:message code="label.seoulauction.history" /></a></li>
											<!--<li><a href="/about/page?view=saplus">SA+</a></li>-->
                                             <!-- api 문제로 잠시 다운 투자정보 --> 
											<!-- <li><a href="/about/page?view=investRealtime&lang={{locale}}"><spring:message code="label.seoulauction.invest" /></a></li> -->
											<!--<li><a href="/about/page?view=snsChannels"><spring:message code="label.seoulauction.sns" /></a></li>-->
											<li><a href="/about/page?view=pressList&lang={{locale}}"><spring:message code="label.press" /></a></li>
	                                        <li><a href="/noticeList?lang={{locale}}"><spring:message code="label.notice" /></a></li> 
	                                        <li ng-if="locale == 'ko'">   
												<span ng-if="recruitMent > 0"><a href="/about/page?view=recruitList"><spring:message code="label.recruit" /><img src="/images/icon/now_icon.png" /></a></span> 
	                                            <span ng-if="recruitMent == 0" id="recruit_Ingbtn" style="cursor: default;"><spring:message code="label.recruit" /></span>
	                                        </li>   
	                                        <li><a href="/about/page?view=location&lang={{locale}}"><spring:message code="label.seoulauction.location" /></a></li>
	                                        <li><a href="/about/page?view=faq&lang={{locale}}"><spring:message code="label.faq" /></a></li> 
										</ul>  
									</li> 
								</ul>
							</div>  
						</div>      
					</div> 
					<div class="link_menu01">
						<ul class="fl_menu">
							<li><a href="/auctionGuide/page?view=commissionGuide&lang={{locale}}" class="menu02"><spring:message code="label.inquiry.contract" /></a></li>
	                        <li>
							<a href="/search?lang={{locale}}" class="menu03"><spring:message code="label.artwork.search" /></a>
						</li>
						</ul>  
					</div>  
					 
	                <div class="link_menu03">   
						<ul>     
							<!-- 블랙랏 메뉴 
							<li ng-if="locale == 'ko'" style="padding-top:10px;"><a href="/currentExhibit?sale_kind=exhibit_only&sale_no=673&page=1">블랙랏 런칭 전시 (하이라이트)</a></li> 
							<li ng-if="locale != 'ko'" style="padding-top:10px;"><a href="/currentExhibit?sale_kind=exhibit_only&sale_no=673&page=1">BLACKLOT Launching Exhibition (highlights)</a></li> -->    
							     
	                    	<!--<li style="padding-top:10px;"><a href="/about/page?view=gnExhibition&lang={{locale}}" ><spring:message code="label.seoulauction.introgang0" /></a></li>-->
	                    	<!-- 강남전시 1,2  
	                        <li style="padding-top:10px;"><a href="/about/page?view=gnExhibition" ><spring:message code="label.seoulauction.introgang1" /></a></li>
	                        <li style="padding-top:10px;"><a href="/about/page?view=gnExhibition02" ><spring:message code="label.seoulauction.introgang2" /></a></li> -->
                            
	                        <!--<li><a target="_blank" href="http://www.auctionblue.com" ><spring:message code="label.AuctionBlueonline" /></a></li>   
							<li><a target="_blank" href="http://www.printbakery.co.kr" ><spring:message code="label.printbakery" /></a></li> -->       
						</ul>   
	                    <!-- 홍콩 리미티드 hidden 처리 
	                    <ul>
	                        <li><a href="/about/page?view=saplus" ><!--<img src="/images/img/saplus.jpg" alt="saplus" style="width:37px;"/>-><spring:message code="label.seoulauction.introhk" /></a></li> 
						</ul> -->
					</div>    
					
					<!--<div class="gnb_notice" id="recentNoticeContainer" ng-controller="recentNoticeCtl" data-ng-init="loadRecentNotice();">
						<div class="sp_txt title"><span class="hidden">NOTICE</span></div>
						<ul>
							<span ng-if="locale=='ko'"><li ng-repeat="row in recentList"><a href="/noticeView?write_no={{row.WRITE_NO}}">{{row.TITLE}}</a></li></span>
							<span ng-if="locale!='ko'"><li ng-repeat="row in recentList"><p ng-if="row.TITLE_EN != null || row.TITLE_EN != ''"><a href="/noticeView?write_no={{row.WRITE_NO}}">{{row.TITLE_EN}}</a></p></li></span>
							
						</ul>
					</div>-->  
				</div>
	            <!--OPEN-->
	            <!-- 
	            <div class="right">  
			        <ul class="link_menu02">
						<li>
	                        <span ng-if="locale=='ko'">
	                        	<input type="button" name="생중계" value="생중계" align="center" scrolling="no" onclick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')";></button>
	                        </span>
							<span ng-if="locale!='ko'">
								<input type="button" name="Live" value="Live" align="center" scrolling="no" onclick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')";></button>
							</span>  
						</li>
					</ul>  
				</div> -->
	             
	            <!-- Live 응찰 ->
	            <div class="right">  
			        <ul class="link_menu02">
						<li>
	                        <span ng-if="locale=='ko'">
	                        	<input type="button" name="Live 응찰" value="Live 응찰" align="center" scrolling="no" onclick="window.open('/currentAuction?sale_kind=offline_only')";></button>
	                        </span>
							<span ng-if="locale!='ko'"> 
								<input type="button" name="Live Bid" value="Live Bid" align="center" scrolling="no" onclick="window.open('/currentAuction?sale_kind=offline_only')";></button>
							</span>   
						</li>
					</ul>   
				</div>  
				
				<!--OPEN-->
	           
	            <!-- <div class="right">  
			        <ul class="link_menu02">
						<li>
	                         <span ng-if="locale=='ko'"> 
	                        	<input type="button" name="비디오" value="비디오" align="center" scrolling="no" onclick="window.open('${contextPath}/service/page?view=auctionVideoPop', 'how', 'width=790,height=700,scrollbars=1')";></button>
	                        </span> 
							<span ng-if="locale!='ko'">
								<input type="button" name="Video" value="Video" align="center" scrolling="no" onclick="window.open('${contextPath}/service/page?view=auctionVideoPop', 'how', 'width=790,height=700,scrollbars=1')";></button>
							</span> 
						</li>
					</ul>  
				</div>-->
	            
				<!--<div class="web_only edge"></div> 20150302 수정 -->
				<div class="m_only m_util_mask"></div><!-- 20150302 수정 -->
			</div>
			<div class="util_menu">
				<c:if test="${is_login}">
					<form action="/processLogout" method="post" id="logoutForm">
					  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>  
				</c:if>
				<ul class="fl_menu util_fl_menu"><!-- //${pageContext.request.queryString}||${param.lang}// --> 
					 <c:set var="queryString" value="${pageContext.request.queryString}" />
	           		 <c:if test="${not empty param.lang}"> 
	           		 	<c:set var="langParam" value="&lang=${param.lang}" />
	           		 	<c:set var="queryString" value="${fn:replace(queryString,langParam, '')}" />
	           		 	<c:set var="langParam" value="lang=${param.lang}" />
	            		<c:set var="queryString" value="${fn:replace(queryString,langParam, '')}" />
	           		</c:if>
	           		<c:if test="${not empty queryString}">
	           			<c:set var="queryString" value="?${queryString}&" />
	           		</c:if>
	           		<c:if test="${ empty queryString}">
	           			<c:set var="queryString" value="?" />
	           		</c:if>
					<c:choose>
						<c:when test="${is_login}">
							<c:choose>
								<c:when test="${is_korean}">
									<li><a href="${queryString}lang=en" style="color:#F30;">ENG</a></li>   
								</c:when>  
								<c:otherwise>
									<li><a href="${queryString}lang=ko" style="color:#F30;">KOR</a></li>	
								</c:otherwise>
							</c:choose>
							<li><a href="/customer/myPage" style="color:#000;">ACCOUNT</a></li>
							<li><a href="javascript:document.getElementById('logoutForm').submit();" style="color:#000;">LOGOUT</a></li>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${is_korean}">
									<li><a href="${queryString}lang=en" style="color:#F30;">ENG</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="${queryString}lang=ko" style="color:#F30;">KOR</a></li>  	
								</c:otherwise>
							</c:choose>
							<li><a href="/login" style="color:#000;">ACCOUNT</a></li>
							<c:choose>
								<c:when test="${uri == '/login'}">
									<li><a href="/login" style="color:#000; font-weight: bold;">LOGIN</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="/login" style="color:#000; font-weight: bold;">LOGIN</a></li> 
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose> 
				</ul>
				<div class="top_search main_top_search">     
					<form action="">   
						<fieldset> 
							<legend><spring:message code="label.search" /></legend>              
							<input type="text" name="" placeholder="검색어를 입력하세요." id="headerSearchContent" class="input_search" title="<spring:message code="label.search.placeholder" />" onkeypress="searchKeyPress(event, true);" />    
							<button type="button" class="sp_btn btn_search" onclick="goSearch('headerSearchContent', true);">      
								<span class="hidden"><spring:message code="label.search" /></span>    
							</button> 
							<button type="button" class="sp_btn m_btn_search"><span class="hidden"><spring:message code="label.search" /></span></button><!-- 20150623 -->
						</fieldset>
					</form>
				</div>
			</div>
		</div><!-- //header -->
	</div> <!-- //web_header_wrap -->
	
	<!-- mobile-ver -->
	<div class="mobile-ver clearfix">  
		<div class="menu_toggle"> 
			<div class="toggle_menu">   
				<div class="top_search">   
					<form id="frmTopSearch" action="/search" style="position: relative;">  
						<fieldset> 
							<legend><spring:message code="label.search" /></legend>
							<input type="text" name="" id="headerSearchContent" class="input_search" title="<spring:message code="label.search.placeholder" />" onkeypress="searchKeyPress(event, true);" style="color:#000;" />
							<button type="button" class="sp_btn btn_search" onclick="goSearch('headerSearchContent', true);"> 
								<span class="hidden"><spring:message code="label.search" /></span>
							</button>  
							<button type="button" class="sp_btn m_btn_search"><span class="hidden"><spring:message code="label.search" /></span></button><!-- 20150623 -->
						</fieldset> 
					</form>   
				</div>  
				<h1 class="logo mo_logo">  
					<a href="/" ><span class="hidden">Seoul Auction EST.1998</span></a>
				</h1>   
				<!-- <span style="font-size:30px;cursor:pointer; margin-top: 15px; float: right;" onclick="openNav()">&#9776;</span> -->     
				<div class="hamber_toggle" onclick="openNav()">
					<span class="hamber_bar"></span>  	
					<span class="hamber_bar"></span> 	
					<span class="hamber_bar"></span>  	
				</div> 
			</div>   
		</div>  
		
		<div class="overlay_back" onclick="closeNav()"></div>     
		<div id="mySidenav" class="left_menu">
			<div class="mo_util"> 
				<h1 class="logo acodian_logo">     
					<a href="/"><span class="hidden">Seoul Auction EST.1998</span></a> 
				</h1>  
				<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
				
				<div class="toggle_utility clearfix">    
					<ul>   
						<c:if test="${locale == 'ko'}">
							<li> 
								<a href="/?lang=en" style="color:#f30;">ENG</a> 
							</li>
						</c:if> 
						<c:if test="${locale == 'en'}">
							<li>  
								<a href="/?lang=ko" style="color:#f30;">KOR</a>  
							</li>  
						</c:if>  
						<c:if test="${is_login}"> 
							<li><a href="/customer/myPage">ACCOUNT</a></li>
							<li>
								<c:if test="${is_login}">
									<form action="/processLogout" method="post" id="logoutForm">
									  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>    
								</c:if>  
								<a href="javascript:document.getElementById('logoutForm').submit();">LOGOUT</a> 
							</li>
						</c:if>   
						<c:if test="${!is_login}">    
							<li><a href="/join/agree">JOIN</a></li>   
							<li><a href="/login">LOGIN</a></li>   
						</c:if>
					</ul>  
				</div> <!-- //toggle_utility --> 
			</div><!-- //mo_util --> 
			
			<!-- 모바일 right 메뉴-->   
		  	<nav class="my-menu"> 
          			<ul class="my-nav"> 
	              	<li><a href="#">AUCTION</a>            
		                <ul>  
		                	<li>      
                                <span ng-if="offlineIng > 0"><a href="/currentAuction?sale_kind=offline_only&lang={{locale}}"><!--<a href="#">-->
                                <spring:message code="label.auction.offlinecurrent" />  
								<img src="/images/icon/now_icon.png" style="vertical-align: text-bottom; margin-left: 2px;"/></a></span>          
								<span ng-if="offlineIng == 0 || offlineIng == null" id="M_Only_OfflineEnd"><spring:message code="label.auction.offlinecurrent" /></span>   
                                <!--<span id="offlineCurrBtn"><spring:message code="label.auction.current" /></span> -->      
							</li>              
							<li>
								<span ng-if="offlineUpcomingIng > 0"><a href="/upcomingAuction?sale_kind=offline_only&lang={{locale}}"><spring:message code="label.auction.upcoming" /><img src="/images/icon/now_icon.png" style="vertical-align: text-bottom; margin-left: 2px;"/></a></span>
								<span ng-if="offlineUpcomingIng == 0 || offlineUpcomingIng == null" id="M_Only_OnlineUpcomEnd"><spring:message code="label.auction.upcoming" /></span>  
								<!-- <span id="M_Only_OfflineUpcomEnd"><spring:message code="label.auction.upcoming" /></span> -->  
							</li>   
							<li>
								<a href="/resultAuction?sale_kind=offline_only&lang={{locale}}"><spring:message code="label.auction.result" /></a> 
								<ul class="sub_menu_tit" style="border-bottom: 1px solid #333;">          
									<li> 
										<a href="/resultAuction?result=Y&page=1&lang={{locale}}">All</a> 
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=main&page=1&lang={{locale}}">Seoul</a> 
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=hongkong&page=1&lang={{locale}}">Hong Kong</a> 
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=online&page=1&lang={{locale}}">Online Only</a>  
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=zerobase_only&page=1&lang={{locale}}">Zero Base</a>  
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=other&page=1&lang={{locale}}">Others</a>    
									</li>  
								</ul>
							</li>
		                    <li><a href="/auctionGuide/page?view=biddingGuide&lang={{locale}}"><spring:message code="label.howto.bid" /></a></li>
		                    <li><a href="/auctionGuide/page?view=commissionGuide&lang={{locale}}"><spring:message code="label.howto.contract" /></a></li>  
		                   	<!-- <li><a href="/auctionGuide/page?view=winningBidGuide"><spring:message code="label.howto.buy" /></a></li>
		                    <li><a href="/auctionGuide/page?view=deliveryGuide"><spring:message code="label.howto.delivery" /></a></li> 
							<li><a href="/otherSales"><spring:message code="label.sale.exhibit" /></a></li>-->
		                </ul>
	              	</li>
	              	<li><a href="#">ONLINE</a> 
		                <ul>  
		                  	<li>  
								<span ng-if="onlineIng > 0"><a href="/currentAuction?sale_kind=online_only&lang={{locale}}"><spring:message code="label.auction.current" /><img src="/images/icon/now_icon.png" style="vertical-align: text-bottom; margin-left: 2px;"/></a></span> 
								<span ng-if="onlineIng == 0 || onlineIng == null" id="M_Only_OnlineEnd"><spring:message code="label.auction.current" /></span> 
							</li>         
							<li>
	                            <span ng-if="onlineUpcomingIng > 0"><a href="/upcomingAuction?sale_kind=online_only&lang={{locale}}"><spring:message code="label.auction.upcoming" /><img src="/images/icon/now_icon.png" style="vertical-align: text-bottom; margin-left: 2px;"/></a></span> 
	                            <span ng-if="onlineUpcomingIng == 0 || onlineUpcomingIng == null" id="M_Only_OnlineUpcomEnd"><spring:message code="label.auction.upcoming" /></span>  
	                            <!--<span id="M_Only_OnlineUpcomEnd"><spring:message code="label.auction.upcoming" /></span>-->    
							</li>    
							<li>
                                <a href="https://www.blacklot.com/" ng-if="locale=='ko'" target="_blank">블랙랏<img src="/images/icon/now_icon.png"/></a>  
                                <a href="https://www.blacklot.com/" ng-if="locale!='ko'" target="_blank">BLACKLOT<img src="/images/icon/now_icon.png"/></a>    
                            </li> 

                            <li>      
	                           <span ng-if="outsideIng > 0"><a href="https://www.seoulauction.com/currentAuction?sale_outside_yn=Y&lang={{locale}}"><span ng-if="locale=='ko'">아트시 경매</span><span ng-if="locale!='ko'">ARTSY Auction</span><img src="/images/icon/now_icon.png" style="vertical-align: text-bottom; margin-left: 2px;"/></a></span>    
	                           <span ng-if="outsideIng == 0 || outsideIng == null" id="M_Only_OutsideEnd"><span ng-if="locale=='ko'">아트시 경매</span><span ng-if="locale!='ko'">ARTSY Auction</span></span> 
							</li>    
	                        <!-- <li> 
	                        	<a href="/resultAuction?sale_kind=online&lang={{locale}}"><spring:message code="label.auction.result" /></a>
	                        	<ul class="sub_menu_tit" style="border-bottom: 1px solid #333;">          
									<li> 
										<a href="/resultAuction?result=Y&page=1&lang={{locale}}">All</a> 
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=main&page=1&lang={{locale}}">Seoul</a> 
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=hongkong&page=1&lang={{locale}}">Hong Kong</a> 
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=online&page=1&lang={{locale}}">Online Only</a>  
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=zerobase_only&page=1&lang={{locale}}">Zero Base</a>  
									</li>
									<li> 
										<a href="/resultAuction?sale_kind=other&page=1&lang={{locale}}">Others</a>    
									</li>  
								</ul> 
	                        </li> -->  
	                        <li><a href="/auctionGuide/page?view=onlinebidGuide&lang={{locale}}"><spring:message code="label.howto.onbid" /></a></li>
	                        <li class="zero_bar" style="cursor: none;"></li>  
	                        <li> 
		                        <span ng-if="zerobaseIng > 0"><a href="/currentAuction?sale_kind=zerobase_only&lang={{locale}}"><span ng-if="locale=='ko'">제로베이스 경매</span><span ng-if="locale!='ko'">Zero base</span><img src="/images/icon/now_icon.png" style="vertical-align: text-bottom; margin-left: 2px;"/></a></span> 
		                        <span ng-if="zerobaseIng == 0 || zerobaseIng == null" id="M_Only_ZeroEnd"><span ng-if="locale=='ko'">제로베이스 경매</span><span ng-if="locale!='ko'">Zero base</span></span> 
							</li> 
		                    <li> 
		                        <a href="https://www.seoulauction.com/zerobaseArtist?lang={{locale}}"><span ng-if="locale=='ko'">제로베이스 작가</span><span ng-if="locale!='ko'">Zero base Artist</span><span ng-if="zerobaseIng > 0"><img src="/images/icon/now_icon.png" style="vertical-align: text-bottom; margin-left: 2px;"/></span></a>  
		                        <!-- <span ng-if="zerobaseIng == 0 || zerobaseIng == null" id="zerobaseBtn"><span ng-if="locale=='ko'">제로베이스 작가</span><span ng-if="locale!='ko'">Zero base Artist</span></span> --> 
		                    </li> 
		                </ul>
	             	 </li> 
	              	<li><a href="#">PRIVATE SALE</a>
		                <ul>     
		                	<li><a href="/currentPrivate?lang={{locale}}"><spring:message code="label.ps.privatesale" /><img src="/images/icon/now_icon.png" style="vertical-align: text-bottom; margin-left: 2px;"/></a></li>  
							<!-- <li><a href="/currentExhibit?sale_kind=exhibit_only"><spring:message code="label.ps.privatesale" /> -->
		                    <!-- <img src="/images/icon/now_icon.png" style="vertical-align: text-bottom;"/> </a></li> -->    
							<!-- <li><a href="/ps/page?view=gallery_network"><spring:message code="label.ps.gallerynetwork" /></a></li> -->
							<li><a href="/ps/page?view=priGuide&lang={{locale}}"><spring:message code="label.ps.privateguide" /></li></a>
		                </ul>
	              	</li>   
	              	<li><a href="#">SERVICE</a>     
		                <ul> 
		                	<!-- <li><a href="/search"><spring:message code="label.artwork.search" /></a></li>
						    <li><a href="/service/page?view=displayPlan"><spring:message code="label.exhibition.curation" /></a></li>-->
		                    <li><a href="/service/page?view=academy&lang={{locale}}"><spring:message code="label.academy" /><span ng-if="academyIng > 0"><img src="/images/icon/now_icon.png" style="vertical-align: text-bottom; margin-left: 2px;" /></span></a> 
		                    	<ul class="sub_menu_tit" style="border-bottom:1px solid #333;">           
									<li>       
										<a href="/service/page?view=academyArtculture&lang={{locale}}"><spring:message code="label.academy.artculture" /></a> 
									</li>
									<li>      
										<a href="/service/page?view=academyArtisttalk&lang={{locale}}"><spring:message code="label.academy.artisttalk" /></a> 
									</li>
									<li>      
										<a href="/service/page?view=academyArtbrunch&lang={{locale}}"><spring:message code="label.academy.artbrunch" /></a> 
									</li>
									<li>       
										<a href="/service/page?view=academyArtauction&lang={{locale}}"><spring:message code="label.academy.artauction" /></a> 
									</li>
									<li>      
										<a href="/service/page?view=academyCulture&lang={{locale}}"><spring:message code="label.academy.culture" /></a> 
									</li>
									<li>       
										<a href="/service/page?view=academyLecture&lang={{locale}}"><spring:message code="label.academy.lecture" /></a>   
									</li> 
								</ul>
		                    </li>  
							<li><a href="/service/page?view=corporationArtwork&lang={{locale}}"><spring:message code="label.company.artwork" /></a>
								<ul class="sub_menu_tit" style="border-bottom:1px solid #333;">            
									<li>     
										<a href="/service/page?view=corporationArtwork-marketing&lang={{locale}}"><spring:message code="label.company.artwork-marketing" /></a>
									</li>   
									<li> 
										<a href="/service/page?view=corporationArtwork-specialauction&lang={{locale}}"><spring:message code="label.company.artwork-specialauction" /></a>
									</li>
									<li> 
										<a href="/service/page?view=corporationArtwork-artservice&lang={{locale}}"><spring:message code="label.company.artwork-artservice" /></a> 
									</li>
									<li>  
										<a href="/service/page?view=corporationArtwork-artconsulting&lang={{locale}}"><spring:message code="label.company.artwork-artconsulting" /></a>   
									</li> 
								</ul> 
							</li>
		                    <li><a href="/service/page?view=rentExhibitionCenter&lang={{locale}}"><spring:message code="label.space.rental" /></a></li>
		                    <li><a href="/service/page?view=securedLoan&lang={{locale}}"><spring:message code="label.collateral.loan" /></a></li>
		                    <li><a href="/service/page?view=chinaArtwork&lang={{locale}}"><spring:message code="label.china.artwork.auth" /></a></li>
		                    <li>
		                    	<a href="/service/page?view=storageInsa&lang={{locale}}"><spring:message code="label.artwork.keep" /></a>
		                    	<ul class="sub_menu_tit" style="border-bottom: 1px solid #333;">          
									<li> 
										<a href="/service/page?view=storageInsa&lang={{locale}}"><spring:message code="label.artwork.keep.insa" /></a>  
									</li>
									<li>    
										<a href="/service/page?view=storageJangheung&lang={{locale}}"><spring:message code="label.artwork.keep.jangheung" /></a>   
									</li>
									<li>     
										<a href="/service/page?view=storagePyeongchang&lang={{locale}}"><spring:message code="label.artwork.keep.Pyeongchang" /></a>     
									</li>   
								</ul>
		                    </li>
		                    <li><a href="/service/page?view=ArtDonations&lang={{locale}}"><spring:message code="label.company.artwork-artdonation" /></a></li>
		                    <!-- <li><a href="/service/page?view=Newsletter&lang={{locale}}"><spring:message code="label.newsletter" /></a></li> --> 
		                </ul> 
	             	</li>
         			<li><a href="#">ABOUT</a>  
						<ul>
							<li><a href="/about/page?view=introduction&lang={{locale}}"><spring:message code="label.seoulauction.introduction" /></a></li>
	                        <li><a href="/about/page?view=introGang&lang={{locale}}"><spring:message code="label.seoulauction.introgang" /></a></li>
							<li><a href="/about/page?view=history&lang={{locale}}"><spring:message code="label.seoulauction.history" /></a></li> 
							<!--<li><a href="/about/page?view=saplus">SA+</a></li>-->
                            <!-- api 문제로 투자정보 페이지 잠시 다운 -->
							<!-- <li><a href="/about/page?view=investRealtime&lang={{locale}}"><spring:message code="label.seoulauction.invest" /></a></li> -->  
							<!--<li><a href="/about/page?view=snsChannels"><spring:message code="label.seoulauction.sns" /></a></li>-->
							<li><a href="/about/page?view=pressList&lang={{locale}}"><spring:message code="label.press" /></a></li>
	                        <li><a href="/noticeList?lang={{locale}}"><spring:message code="label.notice" /></a></li> 
	                        <li ng-if="locale == 'ko'">   
                                <span ng-if="recruitMent > 0"><a href="/about/page?view=recruitList"><spring:message code="label.recruit" /><img src="/images/icon/now_icon.png" /></a></span> 
								<span ng-if="recruitMent == 0" id="M_Only_RecruitEnd" style="cursor: default;"><spring:message code="label.recruit" /></span>    
	                        </li>  
	                        <li> 
	                        	<a href="/about/page?view=location&lang={{locale}}"><spring:message code="label.seoulauction.location" /></a>
	                        </li>
	                        <li><a href="/about/page?view=faq&lang={{locale}}"><spring:message code="label.faq" /></a></li>
						</ul>   
           			</li> 
                    
           			<!-- 블랙랏 메뉴   
					<li class="dropdown" ng-if="locale=='ko'"><a href="/currentExhibit?sale_kind=exhibit_only&sale_no=673&page=1" >블랙랏 런칭 전시 (하이라이트)</a></li>  
           			<li class="dropdown" ng-if="locale!='ko'"><a href="/currentExhibit?sale_kind=exhibit_only&sale_no=673&page=1" >BLACKLOT Launching Exhibition (highlights)</a></li> -->  
           			
                    <!-- <li class="dropdown noLink">
                    	<a href="/about/page?view=gnExhibition&lang={{locale}}" > 
                        	<spring:message code="label.seoulauction.introgang0" />
                       	</a> 
                    </li> -->       
                    
                    <!-- 강남전시 1,2   
                    <li class="dropdown"><a href="/about/page?view=gnExhibition" ><spring:message code="label.seoulauction.introgang1" /></a></li>  
                    <li class="dropdown"><a href="/about/page?view=gnExhibition02" ><spring:message code="label.seoulauction.introgang2" /></a></li> -->  
                    
                    <li class="dropdown"> 
                    	<div class="mobile_copyright">
                    		<div class="copy_txtbox">  
                    			<p class="copy_txtbox_url">  
				       				www.seoulauction.com
				       			</p>        
				       			<p class="copy_txtbox_inquery">    
				       				<a ng-if="locale == 'ko'" href="tel:02-395-0330" style="color: #333;">고객센터</a>   
				       				<a ng-if="locale == 'ko'" href="/customer/inquiryForm" style="color: #333;">1:1 문의</a>     
                                    <a ng-if="locale != 'ko'" href="/customer/inquiryForm" style="color: #333;">1:1 Inquiry</a>       
				       			</p>  
                    		</div> 
			       			
			       			<div class="copy_snsbox">  
			       				<ul>
			       					<li><a class="snsbox1" href="https://www.facebook.com/seoulauction"></a></li>
			       					<li><a class="snsbox2" href="http://blog.naver.com/PostList.nhn?blogId=s_auction"></a></li>
			       					<li><a class="snsbox3" href="https://www.instagram.com/seoulauction/"></a></li>  
			       					<li><a class="snsbox4" href="https://pf.kakao.com/_yxiUyxl"></a></li>       
			       				</ul>    
			       			</div> 
			       		</div> 
                    </li>    
           		</ul>   
       		</nav>     
		</div><!-- //mySidenav -->   
	</div><!-- mobile -->   
	
</div>
<!-- //header_wrap -->
<!-- header.jsp End --> 

<script>  
$(document).ready(function () {
	/* 모바일용 메뉴 제이쿼리 (em) */ 
	$('.my-nav').mgaccordion();
	$('.my-nav2').mgaccordion({
		theme: 'tree',
	 	leaveOpen: true
	});  
	
	/* 모바일용 메뉴 alert 스크립트 (em)*/      
	$("#M_Only_OfflineEnd").click(function() {  
		if("${pageContext.response.locale}"=='ko'){
			alert("진행 경매가 없습니다");
		} else {
			alert("There is no auctions going on currently.");
		}
	});
	$("#M_Only_OfflineUpcomEnd").click(function() {  
		if("${pageContext.response.locale}"=='ko'){  
			alert("예정 경매가 없습니다"); 
		} else { 
			alert("There is no upcoming auctions currently.");
		}
	});
	$("#M_Only_OnlineEnd , #M_Only_ZeroEnd").click(function() { 
		if("${pageContext.response.locale}"=='ko'){
			alert("진행 경매가 없습니다");
		} else {
			alert("There is no auctions going on currently.");
		}
	});
	$("#M_Only_OnlineUpcomEnd").click(function() { 
		if("${pageContext.response.locale}"=='ko'){
			alert("예정 경매가 없습니다");
		} else {
			alert("There is no upcoming auctions currently.");
		}  
	});
	$("#M_Only_OutsideEnd").click(function() { 
		if("${pageContext.response.locale}"=='ko'){
			alert("예정 경매가 없습니다");
		} else {
			alert("There is no auctions going on currently.");
		} 
	});  
	
	$("#M_Only_RecruitEnd").click(function() { 
		if("${pageContext.response.locale}"=='ko'){
			alert("진행중인 채용공고가 없습니다"); 
		} else {
			alert("There is no open recruitment");  
		}  
	});    
});
</script>  
