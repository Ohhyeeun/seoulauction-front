<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

		<ul>
        	<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"commissionGuide\") > -1}'>sele</c:if>">
				<a href="/auctionGuide/page?view=commissionGuide"><spring:message code="label.howto.contract" /></a>   
			</li>
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"biddingGuide\") > -1}'>sele</c:if>">
				<a href="/auctionGuide/page?view=biddingGuide"><spring:message code="label.howto.bid" /></a>
			</li> 
            <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"onlinebidGuide\") > -1}'>sele</c:if>">
				<a href="/auctionGuide/page?view=onlinebidGuide"><spring:message code="label.howto.onbid" /></a>
			</li>
		</ul>
