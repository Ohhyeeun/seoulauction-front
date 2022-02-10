<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<link href="/css/angular/ngDialog.min.css" rel="stylesheet">
<link href="/resources/css/angular/popup.css" rel="stylesheet">
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>

<script type="text/javascript">
app.requires.push.apply(app.requires, ["bw.paging", "ngDialog"]);
app.controller('InteListCtl', function($scope, common, ngDialog) {
	$scope.sale_kind = "${SALE_KIND}";
	$scope.pageRows = 10;
	$scope.currentPage = 1;
	
	$scope.inteCheckList = {};
	
 	$scope.loadInteList = function($page){
 		$scope.currentPage = $page;
 		
 		$scope.parmsList1 = [{"sale_kind" : $scope.sale_kind}];
 		$scope.parmsList2 = [{"from": (($scope.currentPage - 1) * $scope.pageRows), "rows" : $scope.pageRows, "sale_kind" : $scope.sale_kind }];
 		
 		$d = {"baseParms":{},
 				"actionList":[
				{"actionID":"cust_inte_lot_count", "actionType":"select" , "tableName": "INTE_LIST_CNT" ,"parmsList":$scope.parmsList1},
				{"actionID":"cust_inte_lot_list", "actionType":"select" , "tableName": "INTE_LIST" ,"parmsList":$scope.parmsList2}
 			 ]};

 	   	common.callActionSet($d, function(data, status){
 			$scope.inteListCnt = data["tables"]["INTE_LIST_CNT"]["rows"][0]["ROW_CNT"];
 			$scope.inteList = data["tables"]["INTE_LIST"]["rows"];
 		});
	};
	
	/* 관심작품 Start */
	// 관심작품 로직 추가(2018.08.14 YDH)
	$scope.inteSave = function($input) {		
		var $d = {"baseParms":{"sale_no":$input.sale_no, "lot_no":$input.lot_no}, 
				"actionList":[
				{"actionID":"add_cust_inte_lot", "actionType":"insert", "tableName":"CUST_INTE_LOT", "parmsList":[{}]}
				]};
		common.callActionSet($d, function(data, status) {
			if(data.tables["CUST_INTE_LOT"]["rows"].length > 0) {
				if($scope.locale == 'ko') {
					alert("관심작품 추가가 완료되었습니다.\n추가된 관심작품은 ACCOUNT페이지에서 확인하실 수 있습니다.");
					window.location.reload(true);
				}else {
					alert("A favorite work has been added.\nYou can find your favorite works on your account page.");
					window.location.reload(true);
				}
				return true;
			}
		})		
	};
	
	$scope.inteDel = function($input) {	
		var $d = {"baseParms":{"sale_no":$input.sale_no, "lot_no":$input.lot_no}, 
				"actionList":[
				{"actionID":"del_cust_inte_lot", "actionType":"delete", "tableName":"CUST_INTE_LOT", "parmsList":[{}]}
				]};
		common.callActionSet($d, function(data, status) {
			if(data.tables["CUST_INTE_LOT"]["rows"].length > 0) {
				if($scope.locale == 'ko') {
					alert("관심작품이 삭제되었습니다.");
					window.location.reload(true);
				}else {
					alert("A favorite work has been deleted.");
					window.location.reload(true);
				}
				return true;
			}
		})	
	};
	
	
	$scope.inteCheckDel = function() {		
		
		$scope.inteCheckList = $.makeArray($("input[name=inteCheckbox]:checked"));
		$scope.inteCheckList = $scope.inteCheckList.map(function(item){ return {saleno :$(item).attr("saleno"), lotno : $(item).val()}; } );
		console.log($scope.inteCheckList);
		
		if($scope.inteCheckList.length > 0){
			var $d = {"baseParms":{"inteChkList" : $scope.inteCheckList }, 
					"actionList":[
						{"actionID":"del_cust_inte_lotList", "actionType":"delete", "tableName":"CUST_INTE_LOT", "parmsList":[{}]}
					]};
			common.callActionSet($d, function(data, status) {
				if(data.tables["CUST_INTE_LOT"]["rows"].length > 0) {
					if($scope.locale == 'ko') {
						alert("관심작품이 삭제되었습니다.");
						window.location.reload(true);
					}else {
						alert("A favorite work has been deleted.");
						window.location.reload(true);
					}
					return true;
				}
			});	
		}else{
			alert("삭제할 작품을 선택 해주세요");
		}
		
		
		
	};
	

	$scope.checkAll = function(){
		if($("#inteCheckAll").prop("checked")){
			$("input[name=inteCheckbox]").prop("checked", true);
		}else{
			$("input[name=inteCheckbox]").prop("checked", false);
			$scope.inteCheckList = {};
		}
	}
	
	/* 관심작품 End */

});



</script>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="InteListCtl" data-ng-init="loadInteList(1);">
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
						<h2><span ng-if="locale=='ko'">관심작품 현황</span><span ng-if="locale!='ko'">FAVORITE WORKS</span></h2>
					</div>
					<div class="tbl_top">
						<div class="left">
							<button type="button" class="delet_btn" ng-click="inteCheckDel();">{{locale=='ko' ? '선택작품 삭제' : 'Delete Select'}}</button>   
						</div>
						<div class="right">
							<div style="font-weight: 900; padding-top:10px;" ng-if="locale=='ko'">   
								총&nbsp;&nbsp;<span class="txt_green">{{inteListCnt}}</span>개 <%-- <spring:message code="message.mypage.interlist" /> --%>
							</div>   
							<div style="font-weight: 900; padding-top: 10px;" ng-if="locale!='ko'"> 
								ALL&nbsp;&nbsp;<span class="txt_green">{{inteListCnt}}</span>  
							</div>
						</div>
					</div>
					<div class="tbl_style02 table_hovback">
						<table style="table-layout:fixed !important;">
							<caption>관심 작품 목록</caption>
							<colgroup>
								<col style="width:25px" /> 
								<col style="width:5%" />  
								<col style="width:*" /> 
								<col style="width:5%" />  
								<col style="width:*" /> 
								<col style="width:13%" /> 
								<col style="width:12%" />     
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" id="inteCheckAll" ng-click="checkAll();" class="check_inputbox"/><label for="inteCheckAll" class="check_img"></label></th>
									<th>NO</th>
									<th scope="col"><span ng-if="locale=='ko'">경매명</span><span ng-if="locale!='ko'">Auction</span></th>
									<th scope="col">LOT</th>
									<th scope="col"><span ng-if="locale=='ko'">작품명</span><span ng-if="locale!='ko'">Title</span></th>
									<th scope="col"><span ng-if="locale=='ko'">작가명</span><span ng-if="locale!='ko'">Artist</span></th> 
									<th scope="col"><span ng-if="locale=='ko'">등록일자</span><span ng-if="locale!='ko'">Date</span></th>  
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="il in inteList">
									<td>
										<input type="checkbox" id="inteCheckbox{{$index}}" name="inteCheckbox" saleNo="{{il.SALE_NO}}"  value="{{il.LOT_NO}}"  class="check_inputbox"/>
										<label for="inteCheckbox{{$index}}" class="check_img"></label> 
									</td>
									<td>{{$index+1}}</td>  
									<td>{{il.SALE_TH_DSP}} <span ng-if="locale=='ko'">{{il.SALE_TITLE_KO}}</span><span ng-if="locale!='ko'">{{il.SALE_TITLE_EN}}</span></td>
									<td>{{il.LOT_NO}}</td>
									<td>
										<a ng-if="il.SALE_OUTSIDE_YN =='N'"  ng-class="il.CLOSE_YN=='N' ? 'wish_hover_active' : 'wish_hover'" ng-href="{{il.CLOSE_YN=='N' ? '/lotDetail?sale_no=' + il.SALE_NO + '&lot_no=' + il.LOT_NO + '&sale_status=ING&view_type=LIST' : ''}}" target="_blank">
											<span ng-if="locale=='ko'">{{il.TITLE_KO}}</span><span ng-if="locale!='ko'">{{il.TITLE_EN}}</span>
										</a>
										<a ng-if="il.SALE_OUTSIDE_YN =='Y'"  ng-class="il.CLOSE_YN=='N' ? 'wish_hover_active' : 'wish_hover'"  ng-href="{{il.CLOSE_YN=='N' ? '/lotOutsideDetail?sale_no=' + il.SALE_NO + '&lot_no=' + il.LOT_NO + '&sale_status=ING&view_type=LIST' : ''}}" target="_blank">
											<span ng-if="locale=='ko'">{{il.TITLE_KO}}</span><span ng-if="locale!='ko'">{{il.TITLE_EN}}</span>
										</a>
									</td>
									<td><span ng-if="locale=='ko'">{{il.ARTIST_NAME_KO}}</span><span ng-if="locale!='ko'">{{il.ARTIST_NAME_EN}}</span></td>
									<td>{{il.REG_DT | date:'yyyy-MM-dd'}}</td>
									<!-- <td>
										<button type="button" class="btn_insert" ng-click="inteDel({'parent':this, 'sale_no':il.SALE_NO, 'lot_no':il.LOT_NO});">FAVORITE Del.</button>
									</td>
									<td ng-if="il.CLOSE_YN=='N' && il.SALE_OUTSIDE_YN =='N'">
										<a ng-href="{{'/lotDetail?sale_no=' + il.SALE_NO + '&lot_no=' + il.LOT_NO + '&sale_status=ING&view_type=LIST'}}" target="_blank">
											<span ng-if="locale=='ko'">바로가기</span><span ng-if="locale!='ko'">Detail</span></a>
									</td>
									<td ng-if="il.CLOSE_YN=='N' && il.SALE_OUTSIDE_YN =='Y'">
										<a ng-href="{{'/lotOutsideDetail?sale_no=' + il.SALE_NO + '&lot_no=' + il.LOT_NO + '&sale_status=ING&view_type=LIST'}}" target="_blank">
											<span ng-if="locale=='ko'">바로가기</span><span ng-if="locale!='ko'">Detail</span></a>
									</td> --> 
								</tr>
							</tbody>
						</table> 
					</div>  
					 
					<p class="cstm_psnotice">  
						* 모바일에선 table 좌우 스크롤이 가능 합니다. 
					</p> 
						
					<div class="wrap_paging">
						<paging page="currentPage"
							page-size="pageRows"
							total="inteListCnt"
							paging-action="loadInteList(page)"
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