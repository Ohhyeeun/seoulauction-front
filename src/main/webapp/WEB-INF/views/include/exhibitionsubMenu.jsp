<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<ul>
	<li class="<c:if test="${VIEW_ID == 'CURRENT_EXHIBIT'}">sele</c:if>">
		<span ng-if="sale.SALE_KIND_CD == 'exhibit'"><a href="/currentExhibit?sale_kind=exhibit_only">EXHIBITION</a></span>
		<span ng-if="sale.SALE_KIND_CD != 'exhibit'"><a href="/currentExhibit?sale_kind=exhibit_only">EXHIBITION</a></span>
		<c:if test="${VIEW_ID == 'CURRENT_EXHIBIT'}">
		<div class="sub_menu02 m_hide"><!-- current -->
			<ul>
				<li ng-repeat="menu in saleMenuList" ng-class="menu.SALE_NO == sale_no ? 'sele' : ''">
					<a href="/currentExhibit?sale_kind=exhibit_only&sale_no={{menu.SALE_NO}}">
						<span>{{menu.TITLE_JSON[locale]}}</span>
					</a>
				</li>
			</ul>
		</div>
		</c:if>
		<c:if test="${VIEW_ID == 'LOT_DETAIL'}">
		<div class="sub_menu02 m_hide"><!-- lot_detail -->
			<ul>
				<li>
					<a href="/currentExhibit?sale_kind=exhibit_only&sale_no={{sale.SALE_NO}}">
						<span>{{menu.TITLE_JSON[locale]}}</span>
					</a>
				</li>
			</ul>
		</div>
		</c:if>  
	</li>
	
	<!--//전시마다 리스트 유,무 여부로 임시 주석처리 -->        
	<!--<li class="<c:if test="${VIEW_ID == 'RESULT_EXHIBIT' || VIEW_ID == 'RESULT_LOT_LIST'}">sele</c:if>"> 
		<span><a href="/resultExhibit?sale_kind=exhibit_only">PAST</a></span> 
		<c:if test="${VIEW_ID == 'RESULT_EXHIBIT'}"> 
		<div class="sub_menu02"> 
			<ul>
				<li class=""><a href="/resultExhibit?sale_kind=exhibit_only">ALL</a></li>
				<li><a href="/resultExhibit?sale_kind=exhibit">SA+</a></li> 
				<li><a href="/resultExhibit?sale_kind=exhibit_sa">강남 센터</a></li>
			</ul>
		</div>
		</c:if>
	</li> -->   
</ul>
