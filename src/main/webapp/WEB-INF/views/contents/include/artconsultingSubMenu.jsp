<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

				<ul style="border: none;"> 
                    <!-- <c:if test="${is_korean}">
					
					</c:if> -->  
                    <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"corporationArtwork-marketing\") > -1}'>sele</c:if>">
						<a href="/service/page?view=corporationArtwork-marketing"><spring:message code="label.company.artwork-marketing" /></a>
					</li>
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"corporationArtwork-specialauction\") > -1}'>sele</c:if>">
						<a href="/service/page?view=corporationArtwork-specialauction"><spring:message code="label.company.artwork-specialauction" /></a>
					</li>
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"corporationArtwork-artservice\") > -1}'>sele</c:if>">
						<a href="/service/page?view=corporationArtwork-artservice"><spring:message code="label.company.artwork-artservice" /></a>
					</li>
                    <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"corporationArtwork-artconsulting\") > -1}'>sele</c:if>">
						<a href="/service/page?view=corporationArtwork-artconsulting"><spring:message code="label.company.artwork-artconsulting" /></a>
					</li>  
				</ul>  
				 