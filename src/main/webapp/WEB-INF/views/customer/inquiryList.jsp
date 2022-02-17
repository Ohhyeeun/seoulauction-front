<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<script type="text/javascript" src="/js/angular/paging.js"></script>

<script type="text/javascript">
app.requires.push.apply(app.requires, ["bw.paging"]);
app.controller('inquiryListCtl', function($scope, consts, common) {
	$scope.pageRows = 10;
	$scope.currentPage = 1;
	$scope.emp_read_yn = false;
	$scope.complet_yn = false;

	
	$scope.loadInquiryEmpRead = function(){
 		$scope.emp_read_yn = true;
 		$scope.complet_yn = false;
		$scope.loadInquiryList(1, 'Y', 'N');
	}
	
	$scope.loadInquiryComplet = function(){
 		$scope.emp_read_yn = false;
 		$scope.complet_yn = true;
		$scope.loadInquiryList(1, 'Y', 'Y');
	}

 	$scope.loadInquiryList = function($page, $emp_read_yn, $complet_yn){
 		if($emp_read_yn == '' && $complet_yn == ''){
 	 		$scope.emp_read_yn = false;
 	 		$scope.complet_yn = false;
 		}
 		$scope.currentPage = $page;
 		
 		$scope.parmsList1 = [];
 		$scope.parmsList2 = [{"from": (($scope.currentPage - 1) * $scope.pageRows), "rows" : 10 }];
 		
 		$d = {"baseParms":{"emp_read_yn" : $emp_read_yn, "complet_yn" : $complet_yn},
 				"actionList":[
				{"actionID":"get_bbs_inquiry_list_cnt", "actionType":"select" , "tableName": "INQUIRY_LIST_CNT" ,"parmsList":$scope.parmsList1},
				{"actionID":"get_bbs_inquiry_list", "actionType":"select" , "tableName": "INQUIRY_LIST" ,"parmsList":$scope.parmsList2}
 			 ]};

 	   	common.callActionSet($d, $scope.showInquiry);
	};
	
	$scope.showInquiry = function(data, status){
		$scope.inquiryCnt = data["tables"]["INQUIRY_LIST_CNT"]["rows"][0]["ROW_CNT"];
		$scope.inquiryList = data["tables"]["INQUIRY_LIST"]["rows"];
	}
});
</script>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="inquiryListCtl" data-ng-init="loadInquiryList(1, '', '');">
		
		<div id="container">
			<div class="sub_menu_wrap menu06">
				<div class="sub_menu">
					<jsp:include page="../include/customerSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2><spring:message code="label.membership.inquery" /></h2>
						<p><spring:message code="message.membership.inquery" /></p>
					</div>
					<div class="sort_area">
						<ul>
							<li ng-class="{sele:!emp_read_yn && !complet_yn}"><a href="#" ng-click="loadInquiryList(1, '', '');"><spring:message code="label.membership.inqueryall" /></a></li>
							<li ng-class="{sele:emp_read_yn}"><a href="#" ng-click="loadInquiryEmpRead();"><spring:message code="label.membership.inqueryWaiting" /></a></li>
							<li ng-class="{sele:complet_yn}"><a href="#" ng-click="loadInquiryComplet();"><spring:message code="label.membership.inqueryAnswered" /></a></li>
						</ul>
					</div>
					<div class="tbl_top">
						<div class="left">
							<div class="txt"><spring:message code="label.membership.inquery01" /> <span class="txt_green">{{inquiryCnt}}</span> <spring:message code="label.membership.inquery21" /></div>
						</div>
						<div class="right web_only">
						</div>
					</div>
					<div class="tbl_style02 m_tbl_z059">
						<table style="table-layout:fixed !important;">
							<caption><spring:message code="label.membership.inquery" /></caption>
							<colgroup>
								<col style="width:12%" />
								<col />
								<col style="width:9%" />
								<col style="width:14%" />
								<col style="width:9%" />
								<col style="width:9%" />
								<col style="width:13%" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><spring:message code="label.membership.inquerydate" /></th>
									<th scope="col"><spring:message code="label.membership.inquerytitle" /></th>
									<th colspan="2" scope="col"><spring:message code="label.membership.inquerytype" /></th>
									<th scope="col"><spring:message code="label.membership.inquerynow" /></th>
									<th scope="col"><spring:message code="label.membership.inqueryst" /></th>
									<th scope="col"><spring:message code="label.membership.inqueryendt" /></th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="inquiry in inquiryList">
									<td>{{inquiry.REG_DT | date:'yyyy-MM-dd'}}</td>
									<td class="tal ellipsis"><a href="/customer/inquiryView?write_no={{inquiry.WRITE_NO}}">{{inquiry.TITLE}}</a></td>
									<td>{{inquiry.P_CATE_NM}}</td>
									<td>{{inquiry.CATE_NM}}</td>
									<!--  <td>{{inquiry.EMP_READ_YN == 'Y' ? '<spring:message code="label.membership.inqueryread" />' : '<spring:message code="label.membership.inquerynotread" />'}}</td> -->
									<td>{{inquiry.REPLY_YN == 'Y' ? '<spring:message code="label.membership.inqueryread" />' : '<spring:message code="label.membership.inquerynotread" />'}}</td>
									<td>{{inquiry.EMP_NAME}}</td>
									<td>{{inquiry.LAST_REPLY_DT | date:'yyyy-MM-dd'}}</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="wrap_paging">
						<paging page="currentPage"
							page-size="pageRows"
							total="inquiryCnt"
							paging-action="loadInquiryList(page, '', '')"
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
						
						<div class="right m_right">
							<span class="btn btn_style01 dark"><a href="/customer/inquiryForm"><spring:message code="label.membership.Write Inquiryt" /></a></span>
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />