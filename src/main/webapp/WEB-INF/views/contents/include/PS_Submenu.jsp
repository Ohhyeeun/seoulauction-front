<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

		<ul>
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"lotListPrivate\") > -1}'>sele</c:if>">
				<a href="/currentPrivate"><spring:message code="label.ps.privatesale" /></a>       
			</li>   
			<!-- <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"lotListExhibit\") > -1}'>sele</c:if>">
				<a href="/currentExhibit?sale_kind=exhibit_only"><spring:message code="label.ps.privatesale" /></a>      
			</li> -->     
			<!-- <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"gallery_network\") > -1}'>sele</c:if>">
				<a href="/ps/page?view=gallery_network"><spring:message code="label.ps.gallerynetwork" /></a> 
			</li> --> 
			<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"priGuide\") > -1}'>sele</c:if>">
				<a href="/ps/page?view=priGuide"><spring:message code="label.ps.privateguide" /></a> 
			</li>
			
		</ul>   
