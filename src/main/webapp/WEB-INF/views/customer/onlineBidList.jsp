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
app.controller('onlineBidListCtl', function($scope, consts, common) {
	$scope.pageRows = 10;
	$scope.currentPage = 1;
	$scope.suc_yn = null;
	$scope.pay_sat_cd = null;
	
	var nowDate = new Date();
	$scope.nowDate = nowDate;
	
	$scope.setListFilter = function(suc_yn, pay_sat_cd){
 		$scope.suc_yn = suc_yn;
 		$scope.pay_sat_cd = pay_sat_cd;
 		$scope.loadOnlineBidList($scope.currentPage);
	};
	
 	$scope.loadOnlineBidList = function($page){
 		$scope.currentPage = $page;
 		$scope.parmsList1 = [];
 		$scope.parmsList2 = [{"from": (($scope.currentPage - 1) * $scope.pageRows), "rows" : 10 }];
 		
 		$d = {"baseParms":{},
 				"actionList":[
				{"actionID":"get_bid_count_by_cust_no", "actionType":"select" , "tableName": "BID_LIST_CNT" ,"parmsList":$scope.parmsList1},
				{"actionID":"get_bid_list_by_cust_no", "actionType":"select" , "tableName": "BID_LIST" ,"parmsList":$scope.parmsList2}
 			 ]};

 	   	common.callActionSet($d, function(data, status){
 			$scope.bidCnt = data["tables"]["BID_LIST_CNT"]["rows"][0]["ROW_CNT"];
 			$scope.bidList = data["tables"]["BID_LIST"]["rows"];
 			
 			console.log($scope.bidCnt);
 			console.log($scope.bidList);
 		});
	};
});
</script>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="onlineBidListCtl" data-ng-init="loadOnlineBidList(1, null, null);">
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
						<h2>My Online Auction <spring:message code="label.mypage.bidding" /></h2>
					</div>
					<!-- <div class="sort_area">
						 <ul>
							<li class="sele"><a href="#" ng-click="setListFilter(null,null);">전체</a></li>
							<li><a ng-click="setListFilter('Y', null);">낙찰</a></li>
							<li><a ng-click="setListFilter('Y','paid');">구매목록</a></li>
						</ul>
					</div>-->
					<div class="tbl_top">
						<div class="left"> 
							<div class="txt" style="margin-bottom: 10px;"> <span class="txt_green">{{bidCnt}}</span>  <spring:message code="message.mypage.bidding" /></div>
						</div>
						<div class="right web_only">
						</div>
					</div>
					
					<div class="bid_group mt0"> 
						<div id="bid_container1" class="bid"> 
							<div class="customer_bidlist clearfix" ng-repeat="lot in bidList" >    
								<div class="customer_bidlist_title">    
									{{lot.SALE_TH}} {{lot.TITLE_JSON[locale]}} ({{lot.FROM_DT |dateFormat }} ~ {{lot.TO_DT |dateFormat}})
								</div> 
								
								<div class="customer_bidlist_imgbox clearfix">         
									<div class="customer_bidlist_img" oncontextmenu="return false" ondragstart="return false" style="text-align: center;" ng-if="lot.STAT_CD != 'reentry'">
										<!--  <img oncontextmenu="return false" src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG}}" alt="{{lot.TITLE_JSON[locale]}}" style="width: auto; height: 100%; margin-top: 0px;"> -->
										<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG}}" alt="{{lot.TITLE_JSON[locale]}}" style="max-width:100px; max-height: 100px;" />  
									</div>     
									<div class="customer_bidlist_img" oncontextmenu="return false" ondragstart="return false" style="text-align: center;" ng-if="lot.STAT_CD == 'reentry'">
										<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;" /> 
									</div>  
								</div>    
								<div class="customer_bidlist_captionbox clearfix">       
									<div class="cancel auction_grid_cancel" ng-show='lot.STAT_CD == "reentry"'>
										<p class="notice_style03 tac"><spring:message code="message.lot.status.reentry" /></p>
									</div>  
									<div class="customer_bidlist_caption clearfix txt-over" ng-if="lot.STAT_CD != 'reentry'">    
										<p class="customer_bidlist_txt txt-over"> 
											<!-- <div class="txt_dark"><strong>Lot. {{lot.LOT_NO}}</strong></div> -->
											<span title="{{lot.LOT_NO}}">{{lot.LOT_NO}}</span>    
										</p>  
										<p class="customer_bidlist_txt txt-over">  
											<span title="{{lot.ARTIST_NAME_JSON[locale]}}">{{lot.ARTIST_NAME_JSON[locale]}}</span> 
											<sub class="lang web_only txt-over" style="font-size:12px; font-weight: normal;">         
												<span class="txt_cn" ng-if="lot.ARTIST_NAME_JSON.zh != null" style="padding-right: 5px;" title="{{lot.ARTIST_NAME_JSON.zh}}">{{lot.ARTIST_NAME_JSON.zh}}</span> 
												<span ng-if="locale != 'en' && lot.ARTIST_NAME_JSON.en != null" title="{{lot.ARTIST_NAME_JSON.en}}">  
													{{lot.ARTIST_NAME_JSON.en}} 
												</span> 
												<span class="txt_pale txt-over" style="font-size:12px; font-weight: normal;" title="{{lot.BORN_YEAR}}{{lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : ''}}">{{lot.BORN_YEAR}}{{lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : ''}}</span>
											</sub>   
										</p>
										<div class="customer_bidlist_txt txt-over" style="border:none; font-weight: normal; font-size:14px;">     
											<p class="tit txt-over" title="{{lot.LOT_TITLE_JSON[locale]}}">
												<span>{{lot.LOT_TITLE_JSON[locale]}}</span>
											</p>      
											<span class="lang web_only txt-over" title="{{lot.LOT_TITLE_JSON.en | trimSameCheck : lot.LOT_TITLE_JSON[locale] }}{{lot.LOT_TITLE_JSON.zh | trimSameCheck : lot.LOT_TITLE_JSON[locale] }}">   
												{{lot.LOT_TITLE_JSON.en | trimSameCheck : lot.LOT_TITLE_JSON[locale] }}
												{{lot.LOT_TITLE_JSON.zh | trimSameCheck : lot.LOT_TITLE_JSON[locale] }}
											</span>
										</div>
										<div class="buy_list_price txt-over">       
											<span class="txt_red"><p ng-if="lot.TO_DT < nowDate" class="customer_bidlist_txt" style="padding-bottom: 0;"><span ng-if="locale == 'ko'">낙찰가</span><span ng-if="locale != 'ko'">Hammer</span></p><p ng-if="lot.TO_DT >= nowDate" class="customer_bidlist_txt" style="padding-bottom: 0;">응찰가</p> : <span class="customer_bidlist_txt" title="{{lot.SUCCESS_PRICE | number : 0}}">{{lot.SUCCESS_PRICE | number : 0}}</span></span>    
										</div>    
									</div> 
								</div><!-- //customer_bidlist_caption--> 
								  
								<div class="customer_bidinglistbox clearfix" ng-if="lot.STAT_CD != 'reentry'">  
									<div class="scrollable web buy_list_scrollable">  
										<div class="scroller"> 
											<ul>
												<li ng-repeat="bid in lot.BID_JSON"> 
													<p>
														<span class="unit" title="{{lot.CURR_CD}}">{{lot.CURR_CD}}</span> 
														<span class="sum" title="{{bid.BID_PRICE | number : 0}}"> 
															{{bid.BID_PRICE | number : 0}} 
														</span> 
													</p>
													<p>
														<span class="time" title="{{bid.BID_DT}}">  
															{{bid.BID_DT}}  
														</span>
														<span title="{{bid.BID_KIND_NM}}">({{bid.BID_KIND_NM}})</span>  
														<span class="state_box" ng-if="lot.SUCCESS_YN == 'Y' && bid.BID_PRICE == lot.SUCCESS_PRICE && $first">
															<span class="state02 buy_list_state02"><spring:message code="label.mypage.successfulbid" /></span>
															<!-- <span class="state03">경매종료</span>-->    
														</span>
													</p> 
												</li>
											</ul>
										</div>
									</div>
								</div>   
							</div> 
						</div>
					</div>
					
					<div class="wrap_paging">
						<paging page="currentPage"
							page-size="pageRows"
							total="bidCnt"
							paging-action="loadOnlineBidList(page)"
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