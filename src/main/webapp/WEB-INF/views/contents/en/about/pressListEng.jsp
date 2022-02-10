<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script>

app.requires.push.apply(app.requires, ["bw.paging"]);
app.controller("pressListCtl", function($scope, consts, common) {
	$scope.pageRows = 20;
	$scope.currentPage = 1;
	$scope.pressCnt = 0;
	$scope.search_type = "all";
 	$scope.loadPressList = function($page){
 		$scope.currentPage = $page;
 		
 		$scope.parmsList1 = [];
 		$scope.parmsList2 = [{"from": (($scope.currentPage - 1) * $scope.pageRows), "rows" : 20 }];
 		
 		$d = {"baseParms":{"search_type":$scope.search_type, "search_keyword" : $scope.search_keyword, "search_lang" : "en"},
 				"actionList":[
				{"actionID":"pressListCnt", "actionType":"select" , "tableName": "PRESS_LIST_CNT" ,"parmsList":$scope.parmsList1},
				{"actionID":"pressList", "actionType":"select" , "tableName": "PRESS_LIST" ,"parmsList":$scope.parmsList2}
 			 ]};

 	   	common.callActionSet($d, function(data, status){
 			$scope.pressCnt = data["tables"]["PRESS_LIST_CNT"]["rows"][0]["CNT"];
 			$scope.pressCnt_EN = data["tables"]["PRESS_LIST_CNT"]["rows"][0]["CNT_EN"];
 			$scope.pressList = data["tables"]["PRESS_LIST"]["rows"];
 		});
	};
	 
});

</script>

<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">

		<div id="container" ng-controller="pressListCtl" data-ng-init="loadPressList(1);">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
                    <jsp:include page="../../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">	 
				<div class="contents"  style="min-height:700px; overflow:visible;">	 
					<div class="tit_h2"> 
						<h2><spring:message code="label.press" /></h2>
					</div>
					<div class="tbl_top web_only">
						<div class="left">
							<div class="txt"><spring:message code="label.press" />
								<span class="txt_green">
									<span ng-if="locale == 'ko'"> {{pressCnt}} 건</span>
									<span ng-if="locale != 'ko'"> {{pressCnt_EN}}</span>
								</span>
							</div>
						</div>
						<form commandName="pageForm" name="pageForm" method="get">
						<div class="right">
							<div class="fl_wrap">
								<select name="search_type" ng-model="search_type">
									<option value="title"><spring:message code="label.membership.inquerytitle" /></option>
									<option value="press"><spring:message code="label.membership.press" /></option>
									<option value="all"><spring:message code="label.membership.inquerytitle" /> + <spring:message code="label.membership.press" /></option>
								</select>
								<input type="text" name="search_keyword" ng-model="search_keyword" placeholder="검색어" />
								<span class="btn_style01 gray02">
									<button type="button" ng-click="loadPressList(1);"><spring:message code="label.search" /></button>
								</span>
							</div> 
						</div>
						</form>
					</div>
					<div class="tbl_style02 type02">
						<table>
							<caption><spring:message code="label.notice" /><span class="txt_green"></caption>
							<colgroup>
								<col style="width:10%;">
								<col style="width:30%;">
								<col style="width:50%;">
								<col style="width:10%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><spring:message code="label.membership.no" /></th>
									<th scope="col"><spring:message code="label.membership.press" /></th>
									<th scope="col"><spring:message code="label.membership.inquerytitle" /></th>
									<th scope="col"><spring:message code="label.membership.inquerydate" /></th>
								<tr>
							</thead>
							<tbody>
								<tr ng-if="pressCnt == 0">
									<td class="nodata" colspan="5"><spring:message code="label.press.nosearch" /></td>
								</tr>
								<tr ng-repeat="press in pressList" ng-if="locale == 'ko' || (locale != 'ko' && (press.PRESS_TITLE_EN != null && press.PRESS_TITLE_EN != ''))">
									<td>{{press.PRESS_SEQ}}</td>
									<td>										
										<span ng-if="locale == 'ko'">{{press.PRESS_COMP}}</span>
										<span ng-if="locale != 'ko'">{{press.PRESS_COMP_EN}}</span>
									</td>
									<td>
										<span ng-if="locale == 'ko'"><a href="{{press.PRESS_URL}}" target="new">{{press.PRESS_TITLE}}</a></span>
										<span ng-if="locale != 'ko'"><a href="{{press.PRESS_URL_EN}}" target="new">{{press.PRESS_TITLE_EN}}</a></span>										
									</td>
									<td>{{press.PRESS_DATE | date : 'yyyy-MM-dd'}}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="wrap_paging">
						<paging page="currentPage"
							page-size="pageRows"
							total="locale == 'ko'? pressCnt : pressCnt_EN"
							paging-action="loadPressList(page)"
							scroll-top="true"
							hide-if-empty="true"
							show-prev-next="true"
							show-first-last="true"
							ul-class="page_ul"
							active-class="page_active"
						    disabled-class="page_disable"
						    text-next-class="page_btn sp_btn btn_next02"
						    text-prev-class="page_btn sp_btn btn_prev02"
						    text-first-class="page_btn sp_btn btn_prev"
						    text-last-class="page_btn sp_btn btn_next">
						</paging>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />