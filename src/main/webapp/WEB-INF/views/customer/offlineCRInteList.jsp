<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<link href="/css/angular/ngDialog.min.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">
<script type="text/javascript" src="/js/angular/paging.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>

<script type="text/javascript">
app.requires.push.apply(app.requires, ["bw.paging", "ngDialog"]);
app.controller('ConditionReportListCtl', function($scope, common, ngDialog) {
	$scope.pageRows = 10;
	$scope.currentPage = 1;
	
 	$scope.loadConditionReportList = function($page){
 		$scope.currentPage = $page;
 		
 		$scope.parmsList1 = [];
 		$scope.parmsList2 = [{"from": (($scope.currentPage - 1) * $scope.pageRows), "rows" : $scope.pageRows }];
 		
 		$d = {"baseParms":{},
 				"actionList":[
				{"actionID":"cust_cr_lot_count", "actionType":"select" , "tableName": "CR_LIST_CNT" ,"parmsList":$scope.parmsList1},
				{"actionID":"cust_cr_lot_list", "actionType":"select" , "tableName": "CR_LIST" ,"parmsList":$scope.parmsList2}
 			 ]};

 	   	common.callActionSet($d, function(data, status){
 			$scope.crListCnt = data["tables"]["CR_LIST_CNT"]["rows"][0]["ROW_CNT"];
 			$scope.crList = data["tables"]["CR_LIST"]["rows"];
 		});
	};
	
	/* YBK.20170407.컨디션리포트 추가 */
	$scope.crDel = function($input) {
		<%-- alert 확인/취소 여부 --%>
		if($scope.locale == 'ko') {
			var retVal = confirm("삭제하시겠습니까?");
		}
		else
		{
			var retVal = confirm("Do you want to delete continue?");	
		}
		
		<%-- alert 확인 --%>
		if(retVal == true) {
			var $d = {"baseParms":{"cr_seq":$input.crSeq, "sale_no":$input.sale, "lot_no":$input.lot}, 
					"actionList":[
					{"actionID":"del_cust_cr_lot", "actionType":"insert", "tableName":"CUST_CR_LOT", "parmsList":[{}]}
					]};
			common.callActionSet($d, function(data, status) {
				if(data.tables["CUST_CR_LOT"]["rows"].length > 0) {
					if($scope.locale == 'ko') {
						alert("컨디션리포트 관심추가가 삭제되었습니다.");
						window.location.reload(true);
					}else {
						alert("The condition report interest add has been deleted.");
						window.location.reload(true);
					}
					return true;
				}else {
					if($scope.locale == 'ko') {
						alert("실패하셨습니다.\n다시 시도해주세요.");
					}else {
						alert("Failed.\nPlease try again.");
					}
				}
			})
		}else {
			return false;
		}
	}
	/* YBK.20170407.컨디션리포트 추가 */

});
</script>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="ConditionReportListCtl" data-ng-init="loadConditionReportList(1);">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container">{{a}}
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
						<h2><span ng-if="locale=='ko'">컨디션리포트 관심 현황</span><span ng-if="locale!='ko'">ConditionReport Works</span></h2>
					</div>
					<div class="tbl_top">
						<div class="left">
							<div class="txt"><span class="txt_green">{{crListCnt}}</span> <spring:message code="message.mypage.interlist" /></div>
						</div>
						<div class="right web_only">
						</div>
					</div>
					<div class="tbl_style02">
						<table style="table-layout:fixed !important;">
							<caption>컨디션리포트 관심 목록</caption>
							<colgroup>
								<col style="width:20%" />
								<col style="width:5%" />
								<col style="width:25%" />
								<col style="width:15%" />
								<col style="width:15%" />
								<col style="width:7%" />
								<col style="width:7%" />
								<col style="width:6%" ng-if="cr.CLOSE_YN=='N'"/>
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><span ng-if="locale=='ko'">경매명</span><span ng-if="locale!='ko'">Auction</span></th>
									<th scope="col">LOT</th>
									<th scope="col"><span ng-if="locale=='ko'">작품명</span><span ng-if="locale!='ko'">Title</span></th>
									<th scope="col"><span ng-if="locale=='ko'">작가명</span><span ng-if="locale!='ko'">Artist</span></th>
									<th scope="col"><span ng-if="locale=='ko'">등록일자</span><span ng-if="locale!='ko'">Date</span></th>
									<th scope="col"><span ng-if="locale=='ko'">관심해제</span><span ng-if="locale!='ko'">CR Del.</span></th>
									<th scope="col"><span ng-if="locale=='ko'">출력</span><span ng-if="locale!='ko'">Print</span></th>
									<th scope="col" ng-if="cr.CLOSE_YN=='N'"><span ng-if="locale=='ko'">바로가기</span><span ng-if="locale!='ko'">Detail</span></th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="cr in crList">
									<td style="text-align: left; padding-left: 5px;">{{cr.SALE_TH_DSP}} <span ng-if="locale=='ko'">{{cr.SALE_TITLE_KO}}</span><span ng-if="locale!='ko'">{{cr.SALE_TITLE_EN}}</span></td>
									<td style="text-align: left; padding-left: 5px;">{{cr.LOT_NO}}</td>
									<td style="text-align: left; padding-left: 5px;"><span ng-if="locale=='ko'">{{cr.TITLE_KO}}</span><span ng-if="locale!='ko'">{{cr.TITLE_EN}}</span></td>
									<td style="text-align: left; padding-left: 5px;"><span ng-if="locale=='ko'">{{cr.ARTIST_NAME_KO}}</span><span ng-if="locale!='ko'">{{cr.ARTIST_NAME_EN}}</span></td>
									<td>{{cr.REG_DT | date:'yyyy-MM-dd HH:mm:ss'}}</td>
									<td>
										<button type="button" class="btn_insert" ng-click="crDel({'parent':this, 'crSeq':cr.CR_SEQ, 'sale':cr.SALE_NO, 'lot':cr.LOT_NO});">CR Del.</button>
									</td>
									<td>
										<button type="button">
											<a ng-href="{{'/conditionPrt?sale_no=' + cr.SALE_NO + '&lot_no=' + cr.LOT_NO + '&sale_status=END&view_type=LIST'}}" target="_blank">CR Prt.</a>
										</button>
									</td>
									<td ng-if="cr.CLOSE_YN=='N'">
										<a ng-href="{{'/lotDetail?sale_no=' + cr.SALE_NO + '&lot_no=' + cr.LOT_NO + '&sale_status=ING&view_type=LIST'}}" >
											<span ng-if="locale=='ko'">바로가기</span><span ng-if="locale!='ko'">Detail</span></a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="wrap_paging">
						<paging page="currentPage"
							page-size="pageRows"
							total="crListCnt"
							paging-action="loadConditionReportList(page)"
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