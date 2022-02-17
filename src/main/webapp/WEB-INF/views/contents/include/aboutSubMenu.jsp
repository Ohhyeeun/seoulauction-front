<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

				<ul>
					<li  class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"introduction\") > -1}'>sele</c:if>">
						<a href="/about/page?view=introduction"><spring:message code="label.seoulauction.introduction" /></a>
					</li>
                    <li  class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"introGang\") > -1}'>sele</c:if>">
						<a href="/about/page?view=introGang"><spring:message code="label.seoulauction.introgang" /></a>
					</li>
					<li  class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"history\") > -1}'>sele</c:if>">
						<a href="/about/page?view=history"><spring:message code="label.seoulauction.history" /></a>
					</li>
                    <!-- api 문제로 잠시 다운 --> 
					<!-- <li  class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"invest\") > -1}'>sele</c:if>"> 
						<a href="/about/page?view=investRealtime"><spring:message code="label.seoulauction.invest" /></a>
					</li> -->  
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"pressList\") > -1}'>sele</c:if>"> 
						<a href="/about/page?view=pressList"><spring:message code="label.press" /></a>
					</li>  
                    <c:if test="${is_korean}">
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"noticeList\") > -1}'>sele</c:if>"> 
						<a href="/noticeList"><spring:message code="label.notice" /></a> 
					</li>
                    <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"recruitList\") > -1}'>sele</c:if>"> 
						<a href="/about/page?view=recruitList"><spring:message code="label.recruit" /></a> 
					</li>  
					</c:if>
                    <li  class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"location\") > -1}'>sele</c:if>">
						<a href="/about/page?view=location"><spring:message code="label.seoulauction.location" /></a>
					</li>
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"faq\") > -1}'>sele </c:if>full">
						<a href="/about/page?view=faq"><spring:message code="label.faq" /></a>
					</li>
				</ul>