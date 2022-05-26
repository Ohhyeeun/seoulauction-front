<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 

				<ul> 
                	<li ng-if="locale == 'ko'" class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"gnExhibition.jsp\") > -1}'>sele</c:if>">
						<%--<a href="/about/page?view=gnExhibition"><spring:message code="label.seoulauction.introgang0" /></a>--%>
						<a href="/about/page?view=gnExhibition">강남센터 Exhibition</a>
					</li>
                    <li ng-if="locale != 'ko'" class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"gnExhibitionEng.jsp\") > -1}'>sele</c:if>">   
						<a href="/about/page?view=gnExhibition"><spring:message code="label.seoulauction.introgang0" /></a>       
					</li> 
                     
                	<!-- 강남전시 1,2 ko 
					<li ng-if="locale == 'ko'" class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"gnExhibition.jsp\") > -1}'>sele</c:if>">
						<a href="/about/page?view=gnExhibition"><spring:message code="label.seoulauction.introgang1" /></a> 
					</li>  
                    <li ng-if="locale == 'ko'" class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"gnExhibition02.jsp\") > -1}'>sele</c:if>">  
						<a href="/about/page?view=gnExhibition02"><spring:message code="label.seoulauction.introgang2" /></a>    
					</li> --> 
                    
                    <!-- 강남전시 1,2 en 
                    <li ng-if="locale != 'ko'" class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"gnExhibitionEng.jsp\") > -1}'>sele</c:if>">
						<a href="/about/page?view=gnExhibition"><spring:message code="label.seoulauction.introgang1" /></a>
					</li>
                    <li ng-if="locale != 'ko'" class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"gnExhibition02Eng.jsp\") > -1}'>sele</c:if>">   
						<a href="/about/page?view=gnExhibition02"><spring:message code="label.seoulauction.introgang2" /></a>       
					</li>  --> 
				</ul>      