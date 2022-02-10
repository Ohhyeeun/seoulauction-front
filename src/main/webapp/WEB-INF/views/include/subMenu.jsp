<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<ul>
	<li class="<c:if test="${VIEW_ID == 'CURRENT_AUCTION'}">sele</c:if>">
		<a href="/currentAuction?sale_kind={{['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 ? (sale.SALE_KIND_CD == 'online' ? 'online_only' : 'zerobase_only') : 'offline_only'}}&page=1">CURRENT</a>
		<div class="sub_menu02"><!-- current -->  
			<ul> 
				<li ng-repeat="menu in saleMenuList" ng-class="menu.SALE_NO == sale_no ? 'sele' : ''">
					<a ng-href="/currentAuction?sale_kind={{['online','online_zb'].indexOf(menu.SALE_KIND_CD) > -1 ? (menu.SALE_KIND_CD == 'online_zb'? 'zerobase_only' : 'online_only') : 'offline_only'}}{{menu.SALE_OUTSIDE_YN == 'Y'? '&sale_outside_yn=Y' : ''}}&sale_no={{menu.SALE_NO}}&page=1">
						<span ng-if="[408,412,418].indexOf(menu.SALE_NO) < 0">{{menu.SALE_TH | localeOrdinal}}</span> {{menu.TITLE_JSON[locale]}}
						<span ng-if="menu.SALE_KIND_CD == 'online'" class="sp_icon icon_ebid"><span class="hidden">eBid Now</span></span>
					</a>
				</li>
			</ul>
		</div>
		<c:if test="${VIEW_ID == 'LOT_DETAIL'}">
		<div class="sub_menu02"><!-- lot_detail -->
			<ul>
				<li>
                    <a href="/currentAuction?sale_kind={{sale.SALE_KIND_CD == 'online' ? 'online_only' : 'offline_only'}}&sale_no={{menu.SALE_NO}}&page=1">
						<span ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0">{{sale.SALE_TH | localeOrdinal}}</span> {{menu.TITLE_JSON[locale]}}
						<span ng-if="sale.SALE_KIND_CD == 'online'" class="sp_icon icon_ebid"><span class="hidden">eBid Now</span></span>
					</a>
				</li>
			</ul>
		</div>
		</c:if>
	</li>
	<li class="<c:if test="${VIEW_ID == 'UPCOMING_AUCTION'}">sele</c:if>">
		<a href="/upcomingAuction?sale_kind={{sale.SALE_KIND_CD == 'online' ? 'online_only' : 'offline_only'}}">UPCOMING</a>
		<c:if test="${VIEW_ID == 'UPCOMING_AUCTION'}">
		<div class="sub_menu02"><!-- upcoming -->
			<ul>
				<li ng-repeat="menu in saleMenuList" ng-class="menu.SALE_NO == sale_no ? 'sele' : ''">
					<!--<a href="/upcomingAuction?sale_no={{menu.SALE_NO}}">-->
                    <a href="/upcomingAuction?sale_kind={{sale.SALE_KIND_CD == 'online' ? 'online_only' : 'offline_only'}}&sale_no={{menu.SALE_NO}}">
						<span ng-if="[408,412,418].indexOf(menu.SALE_NO) < 0">{{menu.SALE_TH | localeOrdinal}}</span> {{menu.TITLE_JSON[locale]}}
						<span ng-if="menu.SALE_KIND_CD == 'online'" class="sp_icon icon_ebid"><span class="hidden">eBid Now</span></span>
					</a>
				</li>
			</ul>
		</div>
		</c:if>
	</li>
	<li class="<c:if test="${VIEW_ID == 'RESULT_AUCTION' || VIEW_ID == 'RESULT_LOT_LIST'}">sele</c:if>">
		<a href="/resultAuction?result=Y&page=1">RESULT</a>
		<c:if test="${VIEW_ID == 'RESULT_AUCTION'}">
		<div class="sub_menu02">
			<ul>
				<li class=""><a href="/resultAuction?result=Y&page=1">ALL</a></li>
				<li><a href="/resultAuction?sale_kind=main&page=1">SEOUL</a></li>
				<li><a href="/resultAuction?sale_kind=hongkong&page=1">HONG KONG</a></li>
				<li><a href="/resultAuction?sale_kind=online&page=1">ONLINE ONLY</a></li>
				<li><a href="/resultAuction?sale_kind=zerobase_only&page=1">ZERO BASE</a></li>
				<li><a href="/resultAuction?sale_kind=other&page=1">OTHERS</a></li>
			</ul>
		</div>
		</c:if>
		<c:if test="${VIEW_ID == 'RESULT_LOT_LIST'}">
		<div class="sub_menu02">
			<ul>
				<li class="sele">
					<a href="/currentAuction?sale_no={{sale.SALE_NO}}?page=1">
						<span ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0">{{sale.SALE_TH | localeOrdinal}}</span> {{sale.TITLE_JSON[locale]}}
						<span ng-if="sale.SALE_KIND_CD == 'online'" class="sp_icon icon_ebid"><span class="hidden">eBid Now</span></span>
					</a>
				</li>
			</ul>
		</div>
		</c:if>
	</li>
	<!-- <li class="<c:if test="${VIEW_ID == 'OTHER_SALES'}">sele</c:if>">
		<a href="/otherSales">Other Sales</a>
		<c:if test="${VIEW_ID == 'OTHER_SALES'}">
		<div class="sub_menu02 m_hide">
			<ul>
				<li>
					<a href="/auction/otherList?salesPlanningId=${planning.sales_planning_id }">
						{{sale.SALE_TH | localeOrdinal}} {{sale.TITLE_JSON[locale]}}
					</a>
				</li>
			</ul>
		</div>
		</c:if>
	</li>-->
	<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"search\") > -1}'>sele</c:if>">
		<a href="/search?search=Y">SEARCH</a>
	</li>
</ul>
