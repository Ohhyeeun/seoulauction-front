<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>

<script type="text/javascript">
app.requires.push.apply(app.requires, ["bw.paging"]);
app.controller('onlinePayListCtl', function($scope, consts, common) {
	$scope.pageRows = 10;
	$scope.currentPage = 1;
	$scope.suc_yn = null;
	$scope.pay_sat_cd = null;
	
	
 	$scope.loadOnlinePayList = function($page){
 		$scope.currentPage = $page;
 		$scope.parmsList1 = [];
 		$scope.parmsList2 = [{"from": (($scope.currentPage - 1) * $scope.pageRows), "rows" : 10 }];
 		
 		$d = {"baseParms":{},
 				"actionList":[
				{"actionID":"get_pay_count_by_cust_no", "actionType":"select" , "tableName": "PAY_LIST_CNT" ,"parmsList":$scope.parmsList1},
				{"actionID":"get_pay_list_by_cust_no", "actionType":"select" , "tableName": "PAY_LIST" ,"parmsList":$scope.parmsList2},
				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
 			 ]};

 	   	common.callActionSet($d, function(data, status){
 			$scope.allCnt = data["tables"]["PAY_LIST_CNT"]["rows"][0]["ROW_CNT"];
 			$scope.paidCnt = data["tables"]["PAY_LIST_CNT"]["rows"][0]["PAID_CNT"];
 			$scope.payCnt = $scope.allCnt - $scope.paidCnt;
 			$scope.payList = data["tables"]["PAY_LIST"]["rows"];
 			$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
 		});
	};
	
$scope.showPurchasePopup = function(lot_no, sale_no, bid_price, pay_price){
		//모바일에서 결제막음 - blueerr
		if(getCookie("mobileFlag") == 'mobile'){
			alert('앱모바일 결제는 준비중입니다. PC 또는 모바일 브라우저에서 결제를 하시기 바랍니다.');
			return;
		}	
	
		if(bid_price <= pay_price){
			alert("일부납부 금액이 결제금액보다 큽니다");
			return;
		}else {
			self.location.href= '/customer/payPurchaseRequest?lot_no=' + lot_no + "&sale_no=" + sale_no, 'popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0';
// 			window.open('/customer/payPurchaseRequest?lot_no=' + lot_no + "&sale_no=" + sale_no, 'popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0');
		}
	}
	
$scope.showPurchasePopupTest = function(lot_no, sale_no, bid_price, pay_price){
	//모바일에서 결제막음 - blueerr
	if(getCookie("mobileFlag") == 'mobile'){
		alert('앱모바일 결제는 준비중입니다. PC 또는 모바일 브라우저에서 결제를 하시기 바랍니다.');
		return;
	}	

	if(bid_price <= pay_price){
		alert("일부납부 금액이 결제금액보다 큽니다");
		return;
	}else {
		window.open('/customer/payPurchaseRequestTest?lot_no=' + lot_no + "&sale_no=" + sale_no, 'popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0');
	}
}

});

</script>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="onlinePayListCtl" data-ng-init="loadOnlinePayList(1);">
		
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
						<h2>결제 및 구매 목록</h2>
					</div>
                    <p style="font-size:12px; line-height:18px;">구매가(Purchase Price) : 낙찰가 + 낙찰 수수료 + 부가가치세가 합산된 금액입니다. 구매수수료 18%(부가가치세 별도) 일괄 적용합니다.</p>
                      <p style="font-size:12px; line-height:18px; color:#F00">낙찰 계좌안내 : 우리은행 1005-200-281649  서울옥션 (입금뒤 전화주세요)​</p>
                      <p style="font-size:12px; line-height:18px;">문의 : 02-395-0330​​(본사) <br/><br/> </p>
					<div class="tbl_top">
						<div class="left"> 
							<div class="txt" style="margin-bottom: 10px;">총 <span class="txt_green">{{allCnt}}</span>건의 내역(결재할 내역 {{payCnt}}건, 구매 내역 {{paidCnt}}건)이 있습니다.</div>
						</div>
						<div class="right web_only">
						</div>
					</div>
					<div class="bid_group mt0"> 
						<div class="bid">  
							<div class="customer_bidlist clearfix" ng-repeat="lot in payList">  
								<div class="customer_bidlist_title">   
									{{lot.SALE_TH}} {{lot.TITLE_JSON[locale]}} ({{lot.FROM_DT |dateFormat }} ~ {{lot.TO_DT |dateFormat}})
								</div> 
								
								<div class="customer_paylistbox_imgbox clearfix">    					
									<div class="customer_bidlist_img" oncontextmenu="return false" ondragstart="return false" style="text-align: center;">
										<!--  <img oncontextmenu="return false" src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG}}" alt="{{lot.TITLE_JSON[locale]}}" style="width: auto; height: 100%; margin-top: 0px;"> -->
										<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG}}" alt="{{lot.TITLE_JSON[locale]}}" style="max-width:150px; max-height: 150px;" />
									</div>   
								</div> <!-- //customer_bidlist_imgbox --> 		
									
								<div class="customer_paylistbox_captionbox clearfix"> 
									<div class="customer_bidlist_caption">
										<p class="customer_bidlist_txt txt-over">    
											<!-- <div class="txt_dark"><strong>Lot. {{lot.LOT_NO}}</strong></div> -->
											<span title="{{lot.LOT_NO}}">{{lot.LOT_NO}}</span>       
										</p>   
										
										<p class="customer_paylistbox_txt txt-over"> 
											<span title="{{lot.ARTIST_NAME_JSON[locale]}}">{{lot.ARTIST_NAME_JSON[locale]}}</span> 
											<sub class="lang web_only txt-over" style="font-size:12px; font-weight: normal;">    
												<span class="txt_cn" ng-if="lot.ARTIST_NAME_JSON.zh != null" style="padding-right: 5px;" title="{{lot.ARTIST_NAME_JSON.zh}}">{{lot.ARTIST_NAME_JSON.zh}}</span> 
												<span ng-if="locale != 'en' && lot.ARTIST_NAME_JSON.en != null" title="{{lot.ARTIST_NAME_JSON.en}}"> 
													{{lot.ARTIST_NAME_JSON.en}}
												</span> 
												<span class="txt_pale txt-over" style="font-size:12px; font-weight: normal;" title="{{lot.BORN_YEAR}}{{lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : ''}}">{{lot.BORN_YEAR}}{{lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : ''}}</span>
											</sub>     
										</p>   
										
										<div class="customer_paylistbox_txt txt-over" style="border:none; font-weight: normal; font-size:14px;">    
											<div class="tit txt-over">       
												<span title="{{lot.LOT_TITLE_JSON[locale]}}">{{lot.LOT_TITLE_JSON[locale]}}</span>
											</div> 
											<span class="lang web_only txt-over" title="{{lot.LOT_TITLE_JSON.en | trimSameCheck : lot.LOT_TITLE_JSON[locale] }}{{lot.LOT_TITLE_JSON.zh | trimSameCheck : lot.LOT_TITLE_JSON[locale] }}">    
												{{lot.LOT_TITLE_JSON.en | trimSameCheck : lot.LOT_TITLE_JSON[locale] }}
												{{lot.LOT_TITLE_JSON.zh | trimSameCheck : lot.LOT_TITLE_JSON[locale] }}
											</span>  
										</div> 
									</div> 
								</div><!-- //customer_bidlist_captionbox -->
								
								<div class="customer_paylistbox">                
									<div class="pay_pricebox">    
										<div>{{lot.CURR_CD}} {{lot.BID_PRICE | number : 0}}</div>
										<div>   
											{{lot.BID_DT | dateFormat}}
											<span class="state_box" style="margin-left: 5px;">      
												<span class="state02 buy_list_state02" style="font-size:12px;">
													<span ng-if="locale == 'ko'">낙찰</span> 
													<span ng-if="locale != 'ko'">Hammer</span>   
												</span>  
											</span>      
										</div> 
									</div> 
									  
									<div class="pay_pricebox02">       
										<dl>
											<!-- <dt>낙찰가</dt>
												<dd>: {{lot.CURR_CD}} {{lot.BID_PRICE | number : 0}}</dd> -->
											<dt ng-if="lot.CUST_FEE_YN == 'N' || (lot.CUST_FEE_YN == 'Y' && lot.PAYMENT_P_SET_CD == 'customer')">낙찰수수료</dt>
												<dd ng-if="lot.CUST_FEE_YN == 'N' || (lot.CUST_FEE_YN == 'Y' && lot.PAYMENT_P_SET_CD == 'customer')">: {{lot.CURR_CD}} {{getPayTotal(lot.BID_PRICE, lot.LOT_FEE_JSON).fee | number : 0}}</dd>
											<dt ng-if="lot.CUST_FEE_YN == 'N' || (lot.CUST_FEE_YN == 'Y' && lot.PAYMENT_P_SET_CD == 'customer')">총결제액</dt>
												<dd ng-if="lot.CUST_FEE_YN == 'N' || (lot.CUST_FEE_YN == 'Y' && lot.PAYMENT_P_SET_CD == 'customer')">: <span style="font-weight: 900; color: #f30;">{{lot.CURR_CD}} {{getPayTotal(lot.BID_PRICE, lot.LOT_FEE_JSON).price | number : 0}}</span></dd>  
											<dt>결제현황</dt>
												<dd>:  
													<strong ng-if="lot.PAY_PRICE > 0">  
														{{lot.CURR_CD}} {{lot.PAY_PRICE | number : 0}}
													</strong>
													<span class="state_box buy_list_state02" style="margin-left: 5px;">    
														<!--  과거의 이관자료는 입금내역이 명확하지 않아서 미납/완납 표시 불명확함. 미납표시는 제외처리.-->
														<!--  <span class="state03" ng-if="lot.PAY_PRICE == null || lot.PAY_PRICE == 0">결제미진행</span>  -->
														<span class="state03 buy_list_state03" ng-if="lot.PAY_PRICE > 0 && lot.PAY_PRICE < getPayTotal(lot.BID_PRICE, lot.LOT_FEE_JSON).price" style="font-size:12px;"><span ng-if="locale == 'ko'">일부결제</span><span ng-if="locale != 'ko'">Partial payment</span></span> 
														<span class="state03 buy_list_state03" ng-if="lot.PAY_PRICE == getPayTotal(lot.BID_PRICE, lot.LOT_FEE_JSON).price" style="font-size:12px;"><span ng-if="locale == 'ko'">결제완료</span><span ng-if="locale != 'ko'">full payment</span></span> 
													</span> 
												</dd>
											<dt ng-if="lot.PAY_PRICE < getPayTotal(lot.BID_PRICE, lot.LOT_FEE_JSON).price"></dt>
												<dd ng-if="lot.PAY_PRICE < getPayTotal(lot.BID_PRICE, lot.LOT_FEE_JSON).price"> 
													<!-- 고객우대수수료 적용 12/11 bk 수정  -->
													<span class="btn_style01" style="padding:3px 20px 3px 20px; background-color:#62c3bc;"> 
														<button type="button" ng-click="showPurchasePopup(lot.LOT_NO, lot.SALE_NO);" style="color:#FFF; font-size:14px; font-weight:700;">결제하기</button>
													</span>  
													<span class="btn_style01" style="padding:3px 20px 3px 20px; background-color:#62c3bc;" ng-if="custInfo.CUST_NO == 98250">
														<button type="button" ng-click="showPurchasePopupTest(lot.LOT_NO, lot.SALE_NO);" style="color:#FFF; font-size:14px; font-weight:700;">결제하기</button>
													</span>
													<!-- 
													<span class="btn_style01 gray02" ng-if="lot.CUST_FEE_YN == 'N' || (lot.CUST_FEE_YN == 'Y' && lot.PAYMENT_P_SET_CD == 'customer')">
														<button type="button" ng-click="showPurchasePopup(lot.LOT_NO, lot.SALE_NO);">결제하기</button>
													</span> -->
													<!-- <span style="color:red" ng-if="lot.CUST_FEE_YN == 'Y' && lot.PAYMENT_P_SET_CD != 'customer'">
														고객할인 대상입니다. 담당자에게 연락 바랍니다.(02-542-2412)
													</span> -->
												</dd>
											<dt ng-if="lot.PAY_CNT > 0">결제방법</dt>
											<dd ng-if="lot.PAY_CNT > 0">: {{lot.PAY_METHOD_NM}} <span ng-if="lot.PAY_CNT > 1">외 {{lot.PAY_CNT - 1}}건</span></dd>
										</dl>
									</div> 
								</div><!-- //customer_bidinglistbox -->    
							</div> 
						</div>
					</div>
					<div class="wrap_paging">
						<paging page="currentPage"
							page-size="pageRows"
							total="allCnt"
							paging-action="loadOnlinePayList(page)"
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