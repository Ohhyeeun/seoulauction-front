<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

		<ul>
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"myPage\") > -1}'>sele</c:if>">
				<a href="/customer/myPage"><spring:message code="label.mypage" /></a>
			</li>
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"modifyForm\") > -1}'>sele</c:if>">
				<a href="/customer/modifyForm"><spring:message code="label.membership.ChangeInfo" /></a>
			</li>
			
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"customer/offline\") > -1}'>sele</c:if>">
				<a href="/customer/offlineBidReqList"><spring:message code="label.mypage.offauction" /></a>
				<div class="sub_menu02">
					<ul>
						<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"offlineBidReqList\") > -1}'>sele</c:if>">
							<a href="/customer/offlineBidReqList"><spring:message code="label.mypage.offauctionlist" /></a>
						</li> 
						<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"offlineBidHistory\") > -1}'>sele</c:if>">    
							<a href="/customer/offlineBidHistory"><spring:message code="label.mypage.offbidhistory" /></a>     
						</li>     
						<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"offlineInteList\") > -1}'>sele</c:if>">
							<a href="/customer/offlineInteList/offline"><spring:message code="label.mypage.offintelist" /></a>
						</li>
						<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"offlineCRInteList\") > -1}'>sele</c:if>">
							<a href="/customer/offlineCRInteList"><spring:message code="label.mypage.offcrintelist" /></a>
						</li>
					</ul>
				</div>
			</li>
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"customer/online\") > -1}'>sele</c:if>">
				<a href="/customer/onlineBidList"><spring:message code="label.mypage.online" /></a>
				<div class="sub_menu02">
					<ul>
						<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"onlineBidList\") > -1}'>sele</c:if>">
							<a href="/customer/onlineBidList"><spring:message code="label.mypage.bidding" /></a>
						</li>
						<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"onlineAutoBidList\") > -1}'>sele</c:if>">
							<a href="/customer/onlineAutoBidList"><spring:message code="label.mypage.autobidding" /></a>
						</li>
						<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"onlinePayList\") > -1}'>sele</c:if>">
							<a href="/customer/onlinePayList"><spring:message code="label.mypage.onlimepaylist" /></a>
						</li>
						<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"onlineInteList\") > -1}'>sele</c:if>">
							<a href="/customer/onlineInteList/online"><spring:message code="label.mypage.onintelist" /></a>
						</li>
					</ul>
				</div>
			</li>
            <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"customer/academyList\") > -1}'>sele</c:if>">
				<a href="/customer/academyList"><spring:message code="label.mypage.academylist" /></a>
				<div class="sub_menu02">
					<ul>
						<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"academyList\") > -1}'>sele</c:if>">
							<a href="/customer/academyList"><spring:message code="label.mypage.academylist" /></a>
						</li>
					</ul>
				</div>
			</li>
			<!--<li>
				<a href="/myPage/interestWork">관심작품</a>
			</li>-->
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"inquiryList\") > -1}'>sele</c:if>">
				<a href="/customer/inquiryList"><spring:message code="label.membership.inquery" /></a>
			</li>
		</ul>