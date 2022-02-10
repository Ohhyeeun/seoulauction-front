<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

		<ul>
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"commissionGuide\") > -1}'>sele</c:if>">
				<a href="/auctionGuide/page?view=commissionGuide"><spring:message code="label.howto.contract" /></a>
			</li>
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"priGuide\") > -1}'>sele</c:if>">
				<a href="/auctionGuide/page?view=priGuide"><spring:message code="label.howto.PRIVATE" /></a>
			</li>
            <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"chinaArtwork\") > -1}'>sele</c:if>">
						<a href="/service/page?view=chinaArtwork"><spring:message code="label.china.artwork.auth" /></a>
					</li>
		</ul>
