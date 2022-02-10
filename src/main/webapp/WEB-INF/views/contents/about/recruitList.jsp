<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../../include/header.jsp" flush="false"/>

<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script> 


app.value('locale', 'ko');
app.requires.push("bw.paging");
app.controller("recuitListCtl", function($scope, consts, common) {
	$scope.pageRows = 20; 
	$scope.reqRowCnt = 20;
	$scope.currentPage = 1;
	$scope.totalCount = 0;
	$scope.recruitment_title = null;
	$scope.recruitment_all = null;

	$scope.loadrecuitList = function($page) {
		var titleSelect = "title";
		titleSelect = $("#titleSelect").val();
		
		if(titleSelect = 'title'){
			$scope.recruitment_title = $scope.search_keyword;
		} else if( titleSelect = 'all' ) {
			$scope.recruitment_all = $scope.search_keyword;
		}
		
		$scope.currentPage = $page;
	$d = {
			"baseParms" : {	"recruitment_title" : $scope.recruitment_title , "recruitment_all":$scope.recruitment_all},
			"actionList" : [ 
				{"actionID" : "get_recruit_list","actionType" : "select","tableName" : "RECRUIT_LIST","parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt)}]}, 
				{"actionID":"get_recruit_count", "actionType":"select" , "tableName": "RECRUIT_CNT" ,"parmsList":[{"for_count":true}]}
		]};

		$d["actionList"][0]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 
		common.callActionSet($d, $s);
	}

	var $s = function(data, status) {
		$scope.recuitList = data["tables"]["RECRUIT_LIST"]["rows"];
		$scope.totalCount = data["tables"]["RECRUIT_CNT"]["rows"][0]["CNT"];
		console.log($scope.recuitList);
	};
	
	
	 
});

</script> 

<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container" ng-controller="recuitListCtl" data-ng-init="loadrecuitList(1)">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
                    <jsp:include page="../../contents/include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">	 
				<div class="contents"  style="min-height:700px; overflow:visible;">	 
					<div class="tit_h2"> 
						<h2><spring:message code="label.recruit" /></h2>
					</div>
					<div class="tbl_top web_only">
						<div class="left">
							<div class="txt"><spring:message code="label.recruit" />
								<span class="txt_green">
									<span ng-if="locale == 'ko'"> {{totalCount}} 건</span>
									<span ng-if="locale != 'ko'"> {{totalCount}}</span>
								</span> 
							</div>
						</div>
						<form commandName="pageForm" name="pageForm" method="get">
						<div class="right">
							<div class="fl_wrap">
								<select name="search_type" id="titleSelect"> 
									<option value="title"><spring:message code="label.membership.inquerytitle" /></option>
									<option value="all"><spring:message code="label.membership.inquerytitle" /> + <spring:message code="label.membership.inquerycontents" /></option>
								</select>
								<input type="text" name="search_keyword" ng-model="search_keyword" placeholder="검색어" />
								<span class="btn_style01 gray02"> 
									<button type="button" ng-click="loadrecuitList(1);"><spring:message code="label.search" /></button>
								</span>
							</div> 
						</div>
						</form>
					</div>
					<div class="tbl_style02 type02"> 
						<table>
							<caption><spring:message code="label.notice" /><span class="txt_green"></caption>
							<colgroup>
								<col style="width:60%;">    
								<col style="width:40%;"> 
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><spring:message code="label.membership.inquerytitle" /></th>
									<th scope="col"><spring:message code="label.recruitperiod" /></th>  
								<tr>
							</thead>
							<tbody>
								<tr ng-if="totalCount == 0" class="notice recruit_notice"> 
									<td class="recruit_td" colspan="2" style="color:red; text-align:center;">  
										검색된 채용공고가 없습니다.   
									</td> 
								</tr>  
								<tr class="notice recruit_notice" ng-repeat="recuitList in recuitList">
									<td class="recruit_td">    
										<a href="page?view=recruitView&recruitment_no={{recuitList.recruitment_no}}">
											{{recuitList.recruitment_title}}
										</a>  
									</td> 
									<td class="recruit_td" ng-if="recuitList.recruitment_dt_none == 'N' || recuitList.recruitment_dt_none == null"  >{{recuitList.recruitment_from_dt | date:'yyyy-MM-dd'}} ~ {{recuitList.recruitment_to_dt | date:'yyyy-MM-dd'}}</td>
									<td class="recruit_td" ng-if="recuitList.recruitment_dt_none == 'Y'">수시채용</td>  
								</tr>
							</tbody>
						</table>
					</div>
					<div class="wrap_paging">
							<!-- S : paging 영역 -->
							<paging page="currentPage" 
							page-size="pageRows"
								total="totalCount" 
								adjacent="10"
								paging-action="loadrecuitList(page)" 
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
							<!-- E : paging 영역 -->
							<div class="right">
								<span class="btn_style01 icon02 btn_scrolltop mbtn">
									<button type="button">
										<span>위로</span>
									</button> <span class="ico up"></span>
								</span>
							</div>
						</div>
				</div>
			</div>

		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />