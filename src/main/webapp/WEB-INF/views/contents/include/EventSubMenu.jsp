<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 

				<ul> 
                	<li ng-if="locale == 'ko'" class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"EventExhibition.jsp\") > -1}'>sele</c:if>">
						<a href="/about/page?view=EventExhibition">THE KING OF WHISKY</a>  
					</li>  
                    <li ng-if="locale != 'ko'" class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"EventExhibitionEng.jsp\") > -1}'>sele</c:if>">    
						<a href="/about/page?view=EventExhibitionEng">THE KING OF WHISKY</a>         
					</li>     
				</ul>      