<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<link href="/css/angular/ngDialog.min.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">
<script type="text/javascript" src="/js/angular/paging.js?"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>

<script type="text/javascript">
app.requires.push.apply(app.requires, ["bw.paging", "ngDialog"]);
app.controller('offlineBidReqListCtl', function($scope, common, ngDialog, locale) {
	$scope.pageRows = 10;
	$scope.currentPage = 1;
	$scope.sale_no = "${SALE_NO}";
	$scope.locale = locale;
	
 	$scope.loadOfflineBidReqList = function($page){
 		$scope.currentPage = $page;
 		
 		$scope.parmsList1 = [];
 		$scope.parmsList2 = [{"from": (($scope.currentPage - 1) * $scope.pageRows), "rows" : $scope.pageRows }];
 		
 		$d = {"baseParms":{"bid_kind_cds":["paper_online", "phone", "paper_phone", "place"], "sale_no": $scope.sale_no },
 				"actionList":[
				{"actionID":"sale_info", "actionType":"select" , "tableName": "SALE"},
				{"actionID":"get_date_now", "actionType":"select" , "tableName": "DB_NOW" ,"parmsList":[]},
				{"actionID":"get_off_autobid_count_by_cust_no", "actionType":"select" , "tableName": "BIDREQ_LIST_CNT" ,"parmsList":$scope.parmsList1},
				{"actionID":"get_off_autobid_list_by_cust_no", "actionType":"select" , "tableName": "BIDREQ_LIST" ,"parmsList":$scope.parmsList2}
 			 ]};

 	   	common.callActionSet($d, function(data, status){
 	   		$scope.sale = data["tables"]["SALE"]["rows"][0];
 			$scope.autoBidCnt = data["tables"]["BIDREQ_LIST_CNT"]["rows"][0]["ROW_CNT"];
 			$scope.autoBidList = data["tables"]["BIDREQ_LIST"]["rows"];
 			$scope.dbDate = data["tables"]["DB_NOW"]["rows"][0]["DATE_NOW"];
 			
 			
 			console.log($scope.autoBidList);
 		});
	};
	
	$scope.abortBid = function(sale_no, lot_no, req_no){
		
		var parmsList = [{"sale_no" : sale_no, "lot_no" : lot_no, "req_no" : req_no }];
		$d = {"baseParms":{},
 				"actionList":[
				{"actionID":"modify_auto_bid_req_for_abort", "actionType":"update" , "tableName": "RESULT" ,"parmsList":parmsList}
 		]};
		
		common.callActionSet($d, 
			function(data, status){
	   			if(data.tables["RESULT"]["rows"].length > 0){
  					alert("응찰이 취소 되었습니다.");
  					document.location.href="/login";
  	   			}else{
  					alert("응찰이 취소에 실패하셨습니다.\n다시 시도해주세요.");
  	   			}
	   	   	},
	   	   	function(data, status, headers, config) {
				alert("응찰이 취소에 실패하셨습니다.\n다시 시도해주세요.");
   		   	}
		);
	};
	
	$scope.abortBid = function(sale_no, lot_no, req_no){
		
		var parmsList = [{"sale_no" : sale_no, "lot_no" : lot_no, "req_no" : req_no }];
		$d = {"baseParms":{},
 				"actionList":[
				{"actionID":"modify_auto_bid_req_for_abort", "actionType":"update" , "tableName": "RESULT" ,"parmsList":parmsList}
 		]};
		
		common.callActionSet($d, 
			function(data, status){
	   			if(data.tables["RESULT"]["rows"].length > 0){
  					alert("응찰이 취소 되었습니다.");
  					document.location.href="/login";
  	   			}else{
  					alert("응찰이 취소에 실패하셨습니다.\n다시 시도해주세요.");
  	   			}
	   	   	},
	   	   	function(data, status, headers, config) {
				alert("응찰이 취소에 실패하셨습니다.\n다시 시도해주세요.");
   		   	}
		);
	};
	
	$scope.showBidRequestPopup = function($input) {
		$scope.modal = ngDialog.open({
			template: '/bidRequest?sale_no=' + $input.sale_no + '&lot_no=' + $input.lot_no,
			controller: 'bidRequestCtl',
			showClose: false,
			closeByDocument: false,
			animationEndSupport: false,
			resolve: {input: function(){return $input;}},
		    preCloseCallback: function(ng_scope) {
		    	$scope.modal = null;
		    	$scope.loadOfflineBidReqList($scope.currentPage);
		    	return true;
		    },
		});
	};
	
	$scope.viewAllList = function(){
		location.href="/customer/offlineBidReqList";
	}

});

app.controller('bidRequestCtl', function($scope, common, input) {
	
	$scope.chkConfirm = false;
	$scope.chkAgree = false;
	$scope.chkCustInfo = false;
	$scope.save_data = {};

	$scope.loadBidRequest = function(){
		var paramList = [{"sale_no":input.sale_no, "lot_no": input.lot_no, "req_no": input.req_no}]
 		$d = {"baseParms":{},
 				"actionList":[
 				{"actionID":"get_auto_bid_req_info", "actionType":"select" , "tableName": "REQ_INFO", "parmsList":paramList},
  				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
 		]};

 	   	common.callActionSet($d, function(data, status){
 	   		$scope.reqInfo = data["tables"]["REQ_INFO"]["rows"][0];
	 		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];

	 		$scope.sale = {"SALE_NO" : $scope.reqInfo.SALE_NO
	 					,"TITLE_JSON" : $scope.reqInfo.TITLE_JSON
	 					,"SALE_TH": $scope.reqInfo.SALE_TH};
	 		$scope.lot = {"LOT_NO" : $scope.reqInfo.LOT_NO
	 				, "ARTIST_NAME_JSON" : $scope.reqInfo.ARTIST_NAME_JSON
	 				, "TITLE_JSON" : $scope.reqInfo.W_TITLE_JSON};
	 		
	 		$scope.base_currency = $scope.sale.CURR_CD;
	 		$scope.save_data.sale_no = $scope.sale.SALE_NO;
	 		$scope.save_data.lot_no = $scope.lot.LOT_NO;
	 		$scope.save_data.req_no = $scope.reqInfo.REQ_NO;
	 		$scope.save_data.bid_kind_cd = $scope.reqInfo.BID_KIND_CD;
	 		$scope.save_data.bid_price = $scope.reqInfo.BID_PRICE;
	 		$scope.save_data.hp = $scope.custInfo.HP;
	 		$scope.save_data.email = $scope.custInfo.EMAIL;
 	   	
	 		console.log($scope.custInfo);
 	   	});
	}
	
	
	$scope.saveBidRequest = function(form){
		if(!$scope.chkCustInfo){
			alert("고객정보 확인을 체크 바랍니다.");
			common.setFocus("chkCustInfo");
			return;
		}
		if(!$scope.chkConfirm){
			alert("상태확인 후 동의 바랍니다.");
			common.setFocus("chkConfirm");
			return;
		}
		if(!$scope.chkAgree){
			alert("약관 확인 후 동의 바랍니다.");
			common.setFocus("chkAgree");
			return;
		}
		
		if(!confirm("응찰하시겠습니까?")) return;
		
		$scope.save_data.bid_price = $scope.save_data.bid_price != undefined && $scope.save_data.bid_price != null ? parseInt($scope.save_data.bid_price.replace(/,/gi, "")) : null;
		
		var $d = {"baseParms":{},
 				"actionList":[
 			    {"actionID":"modify_auto_bid_req_for_price", "actionType":"insert" , "tableName": "RESULT","parmsList":[$scope.save_data]}
 			 ]};
  		
  	   	common.callActionSet($d, function(data, status) {
   	   			if(data.tables["RESULT"]["rows"].length > 0){
   					alert("응찰 정보가 변경 되었습니다.");
					
   					form.closeThisDialog();
   	   			}else{
   					alert("실패하셨습니다.\n다시 시도해주세요.");
   	   			}
   	   		},
   			function(data, status, headers, config) {
				alert("실패하셨습니다.\n다시 시도해주세요.");
   		    }
   		);
	}
	
	$scope.changeBidKind = function(){
		//var bid_kind = element(by.binding('save_data.bid_kind_cd'));
		if($scope.save_data.bid_kind_cd != 'paper_online'){
			$scope.save_data.bid_price = null;
		}
	}
});
</script>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="offlineBidReqListCtl" data-ng-init="loadOfflineBidReqList(1);">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
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
						<h2>
							<span ng-if="sale_no" ng-bind="sale.TITLE_JSON[locale]"></span>
						</h2>
					</div>
					<div class="tbl_top">
						<div class="left">
							<div class="txt"><span class="txt_green">{{autoBidCnt}}</span> <spring:message code="message.mypage.bidding" /></div>
						</div>
						<div class="right web_only">
							<span ng-if="sale_no" class="btn_style01">
								<button ng-click="viewAllList();" class="ng-binding">{{locale == 'ko'? '전체 내역 보기' : 'All List'}}</button>
							</span>
						</div>
					</div>
					<div class="tbl_style02 bidhistory_boxwrap">          
						<table>     
							<caption><spring:message code="label.mypage.offauctionlist" /></caption> 
							<colgroup> 
								<col width="*" /> 
								<col width="*" />
								<col width="100px" />    
								<col width="*" />   
<%-- 								<col style="width:15%" /> --%> 
                                <!--<col style="width:10%" />-->
							</colgroup> 
							<thead>
								<tr> 
									<th scope="col"><spring:message code="label.mypage.autobidding01" /></th>
									<th scope="col"><spring:message code="label.mypage.autobidding02" /></th> 
									<th scope="col"><spring:message code="label.mypage.autobidding03" /></th>
									<th scope="col"><spring:message code="label.mypage.autobidding04" /></th>
<%-- 									<th scope="col"><spring:message code="label.mypage.autobidding05" /></th> --%>
									<!--<th scope="col"><spring:message code="label.mypage.autobidding06" /></th>-->
								</tr> 
							</thead>  
							<tbody class="off_table_titlepadd"> 
								<tr ng-if="autoBidList.length < 1" class="noListbox" >
									<td colspan="4">
										<p>{{locale == 'ko'? '응찰한 내역이 없습니다.' : 'There is no Bidding List.'}}</p>
									</td>
								</tr>
								<tr ng-repeat="bid in autoBidList">  
									<td style="text-align: left; padding-left: 5px;">
										<a ng-href="/lotDetail?sale_no={{bid.SALE_NO}}&lot_no={{bid.LOT_NO}}&view_type=GRID" >{{bid.SALE_TH | localeOrdinal}} {{bid.TITLE_JSON[locale]}}<br/>
										lot.{{bid.LOT_NO}} | {{bid.W_TITLE_JSON[locale]}}</a>
									</td>
									<td>{{bid.REQ_DT | date:'yyyy-MM-dd HH:mm:ss'}} </td>
									<td>{{bid.BID_KIND_NM}} </td>
									<td style="text-align: right; padding-right: 5px;"> 
										{{bid.CURR_CD}} {{bid.BID_PRICE | number:0}}
									</td>
									<%-- <td>
										<span ng-if="bid.ABORT_YN == 'Y'">
											{{bid.ABORT_DT | date:'yyyy-MM-dd HH:mm:ss'}} <spring:message code="label.mypage.autobidding07" />
										</span>
										<span class="btn_style01 gray03" ng-if="bid.ABORT_YN == 'N' && bid.TO_DT > dbDate && bid.BID_KIND_NM != '서면'">
											<button type="button" ng-click="abortBid(bid.SALE_NO, bid.LOT_NO, bid.REQ_NO);"><spring:message code="label.mypage.autobidding08" /></button>
										</span>
									</td> --%>
									<!--<td>
										<span class="btn_style01 gray03" ng-if="bid.ABORT_YN == 'N' && bid.TO_DT > dbDate">
											<button type="button" ng-click="showBidRequestPopup({'parent':this, 'sale_no':bid.SALE_NO, 'lot_no':bid.LOT_NO, 'req_no':bid.REQ_NO});"><spring:message code="label.mypage.autobidding09" /></button>
										</span>
									</td>-->
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
							total="autoBidCnt"
							paging-action="loadOnlineAutoBidList(page)"
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