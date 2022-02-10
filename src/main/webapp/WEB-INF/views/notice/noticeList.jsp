<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script>

app.requires.push.apply(app.requires, ["bw.paging"]);
app.controller("noticeListCtl", function($scope, consts, common) {
	$scope.pageRows = 10;
	$scope.currentPage = 1;
	$scope.noticeCnt = 0;
	$scope.search_type = "all";
 	$scope.loadNoticeList = function($page){
 		$scope.currentPage = $page;
 		
 		$scope.parmsList1 = [];
 		$scope.parmsList2 = [{"from": (($scope.currentPage - 1) * $scope.pageRows), "rows" : 10 }];
 		
 		$d = {"baseParms":{"search_type":$scope.search_type, "search_keyword" : $scope.search_keyword},
 				"actionList":[
				{"actionID":"bbs_notice_recent_cnt", "actionType":"select" , "tableName": "NOTICE_LIST_CNT" ,"parmsList":$scope.parmsList1},
				{"actionID":"bbs_notice_recent", "actionType":"select" , "tableName": "NOTICE_LIST" ,"parmsList":$scope.parmsList2}
 			 ]};

 	   	common.callActionSet($d, function(data, status){
 			$scope.noticeCnt = data["tables"]["NOTICE_LIST_CNT"]["rows"][0]["CNT"];
 			$scope.noticeCnt_EN = data["tables"]["NOTICE_LIST_CNT"]["rows"][0]["CNT_EN"];
 			$scope.noticeList = data["tables"]["NOTICE_LIST"]["rows"];
 		});
	};
	 
});

</script>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container" ng-controller="noticeListCtl" data-ng-init="loadNoticeList(1);">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
                    <jsp:include page="../contents/include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">	 
				<div class="contents"  style="min-height:700px; overflow:visible;">	 
					<div class="tit_h2"> 
						<h2><spring:message code="label.notice" /></h2>
					</div>
					<div class="tbl_top web_only">
						<div class="left">
							<div class="txt"><spring:message code="label.notice" /><!--<spring:message code="label.membership.inquery01" />-->
								<span class="txt_green">
									<span ng-if="locale == 'ko'"> {{noticeCnt}} 건</span>
									<span ng-if="locale != 'ko'"> {{noticeCnt_EN}}</span>
								</span>
							</div>
						</div>
						<form commandName="pageForm" name="pageForm" method="get">
						<div class="right">
							<div class="fl_wrap">
								<select name="search_type" ng-model="search_type">
									<option value="title"><spring:message code="label.membership.inquerytitle" /></option>
									<option value="contents"><spring:message code="label.membership.inquerycontents" /></option>
									<option value="all"><spring:message code="label.membership.inquerytitle" /> + <spring:message code="label.membership.inquerycontents" /></option>
								</select>
								<input type="text" name="search_keyword" ng-model="search_keyword" placeholder="검색어" />
								<span class="btn_style01 gray02">
									<button type="button" ng-click="loadNoticeList(1);"><spring:message code="label.search" /></button>
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
								<col style="width:40%;"><!-- 수정 -->
								<!--<col style="width:10%;">-->
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><spring:message code="label.membership.inquerytitle" /></th>
									<th scope="col"><spring:message code="label.membership.inquerydate" /></th>
									<!--<th scope="col">조회수</th>-->
								<tr>
							</thead>
							<tbody>
								<tr ng-if="noticeCnt == 0"> 
									<td class="nodata" colspan="5"><spring:message code="label.notice.nosearch" /></td>
								</tr>
								<tr class="notice" ng-repeat="notice in noticeList" ng-if="locale == 'ko' || (locale != 'ko' && (notice.TITLE_EN != null && notice.TITLE_EN != ''))">
									<td class="tal">
										<a href="/noticeView?write_no={{notice.WRITE_NO}}">
											<span ng-if="locale == 'ko' && notice.WRITE_NO != '3304'">{{notice.TITLE}}</span>
											<span ng-if="locale != 'ko' && notice.WRITE_NO != '3304'">{{notice.TITLE_EN}}</span>  
                                            <span ng-if="locale == 'ko' && notice.WRITE_NO == '3304'" style="color:#ff0000;">{{notice.TITLE}}</span>
											<span ng-if="locale != 'ko' && notice.WRITE_NO == '3304'" style="color:#ff0000;">{{notice.TITLE_EN}}</span>
										</a>
										<img src="/images/bg/bul_file02.png" alt="첨부파일" ng-show="notice.FILE_YN == 'Y'" />
									</td>
									<td>{{notice.REG_DT | date : 'yyyy-MM-dd'}}</td>
									<!--  <td>{{notice.VIEW_CNT}}</td> -->
								</tr>
							</tbody>
						</table>
					</div>
					<div class="wrap_paging">
						<paging page="currentPage"
							page-size="pageRows"
							total="locale == 'ko'? noticeCnt : noticeCnt_EN"
							paging-action="loadNoticeList(page)"
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
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />