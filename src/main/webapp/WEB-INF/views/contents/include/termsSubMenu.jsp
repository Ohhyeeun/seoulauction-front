<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
				<ul>
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"auctionTerms\") > -1}'>sele</c:if>"><a href="/terms/page?view=auctionTerms"><spring:message code="label.terms.auction" /></a></li>
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"privateInfo\") > -1}'>sele</c:if>"><a href="/terms/page?view=privateInfo"><spring:message code="label.terms.privacy.policy" /></a></li>
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"infoManage\") > -1}'>sele</c:if>"><a href="/terms/page?view=infoManage"><spring:message code="label.terms.infor.rules" /></a></li>
                    <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"cookiePolicy\") > -1}'>sele</c:if>"><a href="/terms/page?view=cookiePolicy">Cookie Policy</a></li>
				</ul>
