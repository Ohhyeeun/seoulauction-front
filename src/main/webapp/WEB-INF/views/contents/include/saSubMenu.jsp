<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

				<ul>
					<li  class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"saplus\") > -1}'>sele</c:if>">
						<a href="/about/page?view=saplus"><spring:message code="label.seoulauction.introhk" /></a> 
					</li>
					
				</ul>