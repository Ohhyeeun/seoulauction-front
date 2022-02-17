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
app.requires.push.apply(app.requires, ["bw.paging"]);
app.controller('offlineBidHistoryCtl', function($scope, common, locale) {   
	$scope.pageRows = 5; 
	$scope.locale = locale;
	 
 	$scope.loadOfflineBidhistory = function($page){   
 		$scope.bidHistoryList = new Array();
 		$scope.currentPage = $page;
 		
 		$scope.parmsList1 = []; 
 		$scope.parmsList2 = [{"from": (($scope.currentPage - 1) * $scope.pageRows), "rows" : $scope.pageRows }];
 		
 		$d = {"baseParms":{},
 				"actionList":[
				{"actionID":"get_date_now", "actionType":"select" , "tableName": "DB_NOW" ,"parmsList":[]},
				{"actionID":"get_off_bidHistory_count", "actionType":"select" , "tableName": "BID_HIS_COUNT" ,"parmsList":$scope.parmsList1},
				{"actionID":"get_off_bidHistory_paging", "actionType":"select" , "tableName": "BID_GROUP_LIST" ,"parmsList":$scope.parmsList2},
				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
 			 ]};

 	   	common.callActionSet($d, function(data, status){
 			$scope.dbDate = data["tables"]["DB_NOW"]["rows"][0]["DATE_NOW"];
 			$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
 			
 			$scope.bidGroupCnt = data["tables"]["BID_HIS_COUNT"]["rows"][0]["ROW_CNT"];
 			$scope.bidGroupList = data["tables"]["BID_GROUP_LIST"]["rows"];
 			
 			$.each($scope.bidGroupList, function(idx, item){
 				$d = {"baseParms":{"sale_no": item.SALE_NO, "lot_no" : item.LOT_NO },
 	 				"actionList":[
	 				{"actionID":"get_off_bidHistory_saleInfo", "actionType":"select" , "tableName": "BID_HIS_SALE", "parmsList": []},
	 				{"actionID":"get_off_bidHistory_lotInfo", "actionType":"select" , "tableName": "BID_HIS_LOT", "parmsList": []},
	 				{"actionID":"get_off_bidHistory_bidding", "actionType":"select" , "tableName": "BID_HIS_LIST", "parmsList": []}
 	 			 ]};
 				common.callActionSet($d, function(data, status){
		 			$scope.bidSaleInfo = data["tables"]["BID_HIS_SALE"]["rows"][0];
		 			$scope.bidLotInfo = data["tables"]["BID_HIS_LOT"]["rows"][0];
		 			$scope.bidList = data["tables"]["BID_HIS_LIST"]["rows"];
		 			
		 			item.sale = $scope.bidSaleInfo;
		 			item.lot = $scope.bidLotInfo;
		 			item.biding = $scope.bidList;
		 			
 				});
 			});
 			
 			$scope.bidHistoryList = $scope.bidGroupList;
 			
 		});
	};
	
	
});


</script> 

<body>  
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>   
	<div class="container_wrap" ng-controller="offlineBidHistoryCtl" data-ng-init="loadOfflineBidhistory(1);">      
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div> 
		<div id="container"> 
			<div class="sub_menu_wrap menu06">
				<div class="sub_menu">   
					<jsp:include page="../include/customerSubMenu.jsp" flush="false" />  
				</div> 
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>  
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents"> 
					<div class="tit_h2">
						<h2><spring:message code="label.mypage.offbidhistory" /></h2> 
					</div> 
					<div class="tbl_top" ng-if="bidHistoryList.length > 0"> 
						<div class="left"> 
							<div class="txt"> 
								<span>{{locale=='ko' ? '총' : 'All' }}</span>
								<span class="txt_green">{{bidGroupCnt}}</span>
								<span ng-if="locale == 'ko'">개 </span>
								<spring:message code="message.mypage.bidding" />  
							</div>      
						</div>  
						<div class="right web_only">  
						</div>  
					</div> 
					
					<div class="bid_group mt0">  
						<div id="bid_container1" class="bid"> 
							<div ng-if="bidHistoryList.length < 1" class="noListbox"  style="border-top:1px dashed #ddd; border-bottom:1px dashed #ddd;"> 
								<p>{{locale == 'ko'? '응찰 내역이 없습니다.' : 'There is no history.'}}</p><br>
<!-- 														<span class="btn_style01"> -->
<!-- 															<button ng-click="fav_toggle(false)">{{locale == 'ko'? '전체작품 보기' : 'View All List'}}</button> -->
<!-- 														</span> -->
							</div>
							<div ng-if="bidHistoryList.length > 0" ng-repeat="bid in bidHistoryList" class="customer_bidlist clearfix"  style="border: 0; border-bottom: 1px dashed #ddd;">      
								<div class="bidhistroy_flex">  
									<div class="bidhistroy_boxleft">       
										<div class="bidhistroy_img clearfix" style="margin-bottom: 15px;">                      
											<!-- <div class="customer_bidlist_img" oncontextmenu="return false" ondragstart="return false" style="text-align: center;"> -->
											<div class="customer_bidlist_img" style="text-align: center;">  
												<a ng-if="bid.lot.TO_DT > dbDate || custInfo.EMP_GB == 'Y'" ng-href="/lotDetail?sale_no={{bid.sale.SALE_NO}}&lot_no={{bid.lot.LOT_NO}}&view_type=GRID" target="_blank">
													<img src="{{'https://www.seoulauction.com/nas_img'+bid.lot.FILE_PATH+'/'+bid.lot.FILE_NAME}}" alt="{{bid.lot.LOT_TITLE_JSON[locale]}}" style="max-width:100px; max-height: 100px;" ondragstart="return false" />
												</a>
												<a ng-if="bid.lot.TO_DT < dbDate && custInfo.EMP_GB == 'N'"  target="_blank">
													<img src="{{'https://www.seoulauction.com/nas_img'+bid.lot.FILE_PATH+'/'+bid.lot.FILE_NAME}}" alt="{{bid.lot.LOT_TITLE_JSON[locale]}}" style="max-width:100px; max-height: 100px;" ondragstart="return false" />
												</a>
											</div>         
										</div>    
										<div class="bidhistroy_caption clearfix">        
											<div class="customer_bidlist_caption clearfix txt-over" style="max-width: 170px; margin: 0 auto;">       
												<p class="customer_bidlist_txt txt-over"> 
													<span title="{{bid.lot.LOT_NO}}">{{bid.lot.LOT_NO}}</span>        
												</p>  
												<p class="customer_bidlist_txt txt-over">  
													<span title="{{bid.lot.ARTIST_NAME_JSON[locale]}}">{{bid.lot.ARTIST_NAME_JSON[locale]}}</span>   
													<sub class="lang txt-over" style="font-size:12px; font-weight: normal;">            
													<!-- 	<span ng-if="locale == 'zh'" class="txt_cn" ng-if="bid.lot.ARTIST_NAME_JSON.zh != null" style="padding-right: 5px;" title="{{bid.lot.ARTIST_NAME_JSON.zh}}">{{bid.lot.ARTIST_NAME_JSON.zh}}</span>  
														<span ng-if="locale == 'en' && bid.lot.ARTIST_NAME_JSON.en != null" title="{{bid.lot.ARTIST_NAME_JSON.en}}">  
															{{bid.lot.ARTIST_NAME_JSON.en}}
														</span>   -->
														<span class="txt_pale txt-over" style="font-size:12px; font-weight: normal;" title="{{bid.lot.BORN_YEAR}}{{bid.lot.DIE_YEAR != null && bid.lot.DIE_YEAR != '' ? '~' + bid.lot.DIE_YEAR : ''}}">
															{{bid.lot.BORN_YEAR}}{{bid.lot.DIE_YEAR != null && bid.lot.DIE_YEAR != '' ? '~' + bid.lot.DIE_YEAR : ''}}
														</span> 
													</sub>    
												</p>
												<div class="customer_bidlist_txt txt-over" style="border:none; font-weight: normal; font-size:14px;">      
													<p class="tit txt-over" title="{{bid.lot.LOT_TITLE_JSON[locale]}}"> 
														<span>{{bid.lot.LOT_TITLE_JSON[locale]}}</span> 
													</p>         
												</div>
											</div> 
										</div><!-- //customer_bidlist_caption--> 
									</div><!-- //bidhistroy_boxleft -->
									
									<div class="bidhistroy_boxright">     
										<p class="bidhistory_captiontit">
											{{bid.sale.SALE_TITLE_JSON[locale]}}
											<span class="fr txt_small">{{locale == 'ko' ? '통화' : 'Currency'}}&nbsp;:&nbsp;[KRW]</span>
										</p> 
										<div class="tbl_style02 bidhistory_boxwrap scrollable" style="border: 0;">                          
											<table>  
												<colgroup>
													<col width="7%" /> 
													<col width="85px" />      
													<col width="*" />    
													<col width="*" /> 
													<col width="80px" />  
												</colgroup> 
												<thead style="position: sticky; top: 0;">  
													<tr>   
														<th scope="col">
															Lot 
														</th>   
														<th scope="col">
															<span ng-if="locale =='ko'">패들번호</span> 
															<span ng-if="locale !='ko'">Paddle.No</span>   
														</th>  
														<th scope="col">
															<span ng-if="locale =='ko'">응찰금액</span> 
															<span ng-if="locale !='ko'">Bid Price</span> 
														</th>  
														<th scope="col">
															<span ng-if="locale =='ko'">응찰시각</span> 
															<span ng-if="locale !='ko'">Bid Time</span>  
														</th> 
														<th scope="col">  
															<span ng-if="locale =='ko'">현황</span> 
															<span ng-if="locale !='ko'">Status</span>     
														</th>  
													</tr>  
												</thead>    
												<tbody> 
													<tr ng-repeat="biding in bid.biding">  
														<td>     
															{{bid.lot.LOT_NO}}   
														</td>   
														<td>{{bid.sale.PADD_NO}}</td>  
														<td>{{biding.BID_PRICE | number:0}}</td>
														<td> 
															{{biding.BID_DT | date:'yyyy-MM-dd HH:mm:ss'}}
														</td>  
														<td>  
															<span ng-if="biding.HAMMER_STAT != 'hammer'"></span>  
															<span ng-if="biding.HAMMER_STAT == 'hammer'" style="color: #62c3bc; font-weight:bold;">{{ locale == 'ko'? '낙찰' : 'Hammer'}}</span>
														</td>  
													</tr>
												</tbody>
											</table>
										</div>
									</div> 
								</div>
							</div>
						</div> 
					</div>  
					
					<p class="cstm_psnotice">  
						* 모바일에선 table 좌우 스크롤이 가능 합니다.  
					</p> 
						
					<div class="wrap_paging">
						<paging page="currentPage"
							page-size="pageRows"
							total="bidGroupCnt"
							paging-action="loadOfflineBidhistory(page)"
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