<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
function noauction(){
	alert("현재 진행중인 경매가 없습니다.");
}
function noupcoming(){
	alert("경매 준비중 입니다.");
}

app.controller('footerCtl', function($scope, consts, common ) {

	$scope.leave = function(){
		if($scope.locale == 'ko'){
			if(!confirm("탈퇴하시겠습니까?")) return;
		} else {
			if(!confirm("Do you want leave?")) return;
		}

		$d = {"baseParms":{},
 				"actionList":[
					{"actionID":"modify_cust_stat_cd_for_leave", "actionType":"update" , "tableName": "CUST" ,"parmsList":[{}]}
 				]};
		console.log($d);
 	   	common.callActionSet($d, function(data, status){
 	   		console.log(data);
			if(data.tables["CUST"]["rows"].length > 0){
				if($scope.locale == 'ko'){
					alert("탈퇴 되었습니다. 이용해주셔서 감사합니다.");
				} else {
					alert("You are unsubscribed. Thank you for using.");
				}
				document.getElementById('logoutForm').submit();
			}
		});
	}
});
</script>

<div class="footer_wrap_in web_only " ng-controller="footerCtl" ><a href="javascript:noauction()">
	<div id="footer_in">
    	<div class="footerinner">
       <!--sh--> <div class="nav-left">
                      <ul>
                          <p>Auction</p>
                              <li><a href="/currentAuction?sale_kind=offline_only"><!--<a href="#">--><spring:message code="label.auction.offlinecurrent" /></a></li>
							  <li><a href="/upcomingAuction?sale_kind=offline_only"><!--<a href="javascript:noauction()">--><spring:message code="label.auction.upcoming" /></a></li>
                              <li><a href="/resultAuction"><spring:message code="label.auction.result" /></a></li>
                              <li><a href="/auctionGuide/page?view=biddingGuide"><spring:message code="label.howto.bid" /></a></li>
                              <li><a href="/auctionGuide/page?view=commissionGuide"><spring:message code="label.howto.contract" /></a></li>
							  <!--<li><a href="/auctionGuide/page?view=winningBidGuide"><spring:message code="label.howto.buy" /></a></li>
                              <li><a href="/auctionGuide/page?view=deliveryGuide"><spring:message code="label.howto.delivery" /></a></li> -->
                          <p>Online</p>
                              <li><a href="/currentAuction?sale_kind=online_only"><spring:message code="label.auction.current" /></a></li>
                              <li>
                                  <a href="/currentAuction?sale_outside_yn=Y&lang={{locale}}">
                                    <span ng-if="locale=='ko'">블랙랏 제로베이스</span><span ng-if="locale!='ko'">BLACKLOT ZEROBASE</span>
                                  </a> 
                              </li>
							  <li><a href="/upcomingAuction?sale_kind=online_only"><spring:message code="label.auction.upcoming" /></a></li>
                              <li><a href="/auctionGuide/page?view=onlinebidGuide"><spring:message code="label.howto.bid" /></a></li>
                              <%--<li style="border-bottom: 1px solid #333; height: 10px; max-width: 100px;"><li>
                              <li style="padding-top: 10px;"><a href="/currentAuction?sale_kind=zerobase_only"><span ng-if="locale=='ko'">제로베이스 경매</span><span ng-if="locale!='ko'">Zero base</span></a>
                              </li>
                              <li><a href="/zerobaseArtist"><span ng-if="locale=='ko'">제로베이스 작가</span><span ng-if="locale!='ko'">Zero base Artist</span></a></li>--%>
                      </ul>
                  </div>
                  <div class="nav">
                      <ul>
                      	  <p>How To</p>
                          	<li><a href="/auctionGuide/page?view=commissionGuide"><spring:message code="label.howto.contract" /></a></li>
                            <li><a href="/auctionGuide/page?view=biddingGuide"><spring:message code="label.howto.bid" /></a></li>
                            <li><a href="/auctionGuide/page?view=onlinebidGuide"><spring:message code="label.howto.onbid" /></a></li>

                          <p>Private Sale</p>
							  <li><a href="/currentPrivate"><spring:message code="label.ps.privatesale" /></a></li>
                              <!-- <li><a href="/ps/page?view=gallery_network"><spring:message code="label.ps.gallerynetwork" /></a></li> -->
                              <li><a href="/ps/page?view=priGuide"><spring:message code="label.ps.privateguide" /></a></li>
                              <!-- 기존 -->
                              <!-- <li><a href="/auctionGuide/page?view=commissionGuide"><spring:message code="label.howto.contract" /></a></li>
                              <li><a href="/auctionGuide/page?view=priGuide"><spring:message code="label.howto.PRIVATE" /></a></li>
                              <li><a href="/service/page?view=chinaArtwork"><spring:message code="label.china.artwork.auth" /></a></li> -->
                          <!-- <p>Live</p> -->
                              <!--<li name="AUCTION LIVE" value="AUCTION LIVE" scrolling="no" onClick="window.open('${contextPath}/service/page?view=auctionLivePop2', 'how', 'width=790,height=610,scrollbars=1')";>
                              <span ng-if="locale == 'ko'">생중계보기</span>
                              <span ng-if="locale != 'ko'">LIVE</span>
                              </li>-->
                          <p>Search</p>
                              <li><a href="/search"><spring:message code="label.artwork.search" /></a></li>
                          <p><spring:message code="label.terms.auction01" /></p>
                              <li><a href="/terms/page?view=auctionTerms"><spring:message code="label.terms.auction" /></a></li>
                              <li><a href="/terms/page?view=privateInfo"><spring:message code="label.terms.privacy.policy" /></a></li>
                              <c:if test="${locale == 'en'}"><li><a href="/terms/page?view=cookiePolicy">Cookie Policy</a></li></c:if>
                              <li><a href="/terms/page?view=infoManage"><spring:message code="label.terms.infor.rules" /></a></li>
                      </ul>
                  </div>
                  <div class="nav">
                      <ul>
                      	  <p>Service</p>
                              <c:if test="${is_korean}"><li><a href="/service/page?view=academy"><spring:message code="label.academy" /></a></li></c:if>
                              <li><a href="/service/page?view=corporationArtwork"><spring:message code="label.company.artwork" /></a></li>
                              <li><a href="/service/page?view=rentExhibitionCenter"><spring:message code="label.space.rental" /></a></li>
                              <li><a href="/service/page?view=securedLoan"><spring:message code="label.collateral.loan" /></a></li>
<%--                              <li><a href="/service/page?view=chinaArtwork"><spring:message code="label.china.artwork.auth" /></a></li>--%>
                              <li><a href="/service/page?view=storageInsa"><spring:message code="label.artwork.keep" /></a></li>
                              <c:if test="${is_korean}">
                            	  <li><a href="/service/page?view=Newsletter"><spring:message code="label.newsletter" /></a></li>
                              </c:if>
                              <!--<li><a href="/service/page?view=displayPlan"><spring:message code="label.exhibition.curation" /></a></li>-->
                          <p>Language</p>
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
	                          <c:if test="${locale == 'en'}">
															<li><a href="${queryString}lang=ko">KOR</a></li>
													  </c:if>
					                  <c:if test="${locale == 'ko'}">
															<li><a href="${queryString}lang=en">ENG</a></li>
													  </c:if>
                      </ul>
                  </div>
                  <div class="nav">
                      <ul>
                          <p>About</p>
                              <li><a href="/about/page?view=introduction"><spring:message code="label.seoulauction.introduction" /></a></li>
                              <li><a href="/about/page?view=introGang"><spring:message code="label.seoulauction.introgang" /></a></li>
                              <li><a href="/about/page?view=history"><spring:message code="label.seoulauction.history" /></a></li>
                              <!-- <li><a href="/about/page?view=investRealtime"><spring:message code="label.seoulauction.invest" /></a></li> -->
                              <!--<li><a href="/about/page?view=snsChannels"><spring:message code="label.seoulauction.sns" /></a></li>-->
                              <li><a href="/noticeList"><spring:message code="label.notice" /></a></li>
							  <c:if test="${is_korean}">
	                              	<li><a href="/about/page?view=recruitList"><spring:message code="label.recruit" /></a></li>
                              </c:if>
                              <li><a href="/about/page?view=pressList"><spring:message code="label.press" /></a></li>
                              <li><a href="/about/page?view=location"><spring:message code="label.seoulauction.location" /></a></li>
                              <li class="full"><a href="/about/page?view=faq"><spring:message code="label.faq" /></a></li>
						 <p>Link</p>
                         	  <li><a href="/about/page?view=gnExhibition" ng-if="locale=='ko'">강남센터 Exhibition</a></li>
                         	  <li><a href="/about/page?view=gnExhibition" ng-if="locale!='ko'">Gangnam Center Exhibition</a></li>
                              <!-- 강남전시 1,2 ->
                              <li><a href="/about/page?view=gnExhibition" ><spring:message code="label.seoulauction.introgang1" /></a></li>
                              <li><a href="/about/page?view=gnExhibition02" ><spring:message code="label.seoulauction.introgang2" /></a></li> -->
                              <!-- <li><a href="/about/page?view=saplus"><spring:message code="label.seoulauction.introhk" /></a></li>  -->
                        <p>Family Site</p>
	                         <li><a target="_blank" href="http://www.printbakery.co.kr" class="menu03"><spring:message code="label.printbakery" /></a></li>
                             <li><a target="_blank" href="https://www.auctionblue.com" class="menu01"><spring:message code="label.AuctionBlueonline" /></a></li>
                      </ul>
                  </div>
                  <div class="nav">
                      <ul>
                      		<c:if test="${!is_login}">
                                <p><spring:message code="label.login" />/<spring:message code="label.agree" /></p>
                                <li><a href="/login"><spring:message code="label.login" /></a></li>
                                <li><a href="/login"><spring:message code="label.agree" /></a></li>
                            </c:if>
                             <c:if test="${is_login}">
                          		<p>Log out</p>
								  <li><a href="javascript:document.getElementById('logoutForm').submit();" >Log out</a></li>
	                                           <p>My Account</p>
                                  <li><a href="/customer/myPage"><spring:message code="label.membership" /></a></li>
                                  <li><a href="/customer/modifyForm"><spring:message code="label.membership.ChangeInfo" /></a></li>
                                  <li><a href="/customer/myPage"><spring:message code="label.membership.payment" /></a></li>
                              <!--<li><a href="/customer/myPage">나의 포인트 사용내역 </a></li> -->
                                  <li><a href="#" ng-click="leave();"><spring:message code="label.membership.DeleteAccount" /></a></li>
                                  <li><a href="/customer/offlineBidReqList"><spring:message code="label.mypage.offauction" /><spring:message code="label.mypage.bidding" /></a></li>
                                  <li><a href="/customer/onlineBidList"><spring:message code="label.mypage.online" /></a></li>
                                  <li><a href="/customer/onlineAutoBidList"><spring:message code="label.mypage.autobidding" /></a></li>
                                  <li><a href="/customer/onlinePayList"><spring:message code="label.mypage.onlimepay" /></a></li>
                                  <li><a href="/customer/academyList"><spring:message code="label.mypage.academylist" /></a></li>
                                  <li><a href="/customer/inquiryForm" onfocus="this.blur()"><spring:message code="label.membership.inquery" /></a></li>
                          </c:if>
                      </ul>
                  </div>
                  <div style="clear:both"> </div>
                  <!--sh-->
           </div>
	</div>
</div>
<!-- //footer_wrap
<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script> <script type="text/javascript"> if(!wcs_add) var wcs_add = {}; wcs_add["wa"] = "19656f7bcf4c5c"; wcs_do(); </script>
</body>
</html>
-->
