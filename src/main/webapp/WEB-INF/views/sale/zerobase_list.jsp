<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<link href="/css/angular/rzslider.css" rel="stylesheet">
<link href="/resources/css/angular/ngDialog.css" rel="stylesheet">
<link href="/resources/css/angular/popup.css" rel="stylesheet">
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script type="text/javascript" src="/js/angular/rzslider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script>
$(window).on('beforeunload', function(event){
    scope = angular.element(document.getElementById("container")).scope();
});


app.value('locale', 'ko');
app.requires.push("bw.paging");
app.controller('artDetailListCtl', function($scope, consts, common) {
	$scope.pageRows = 20; 
	$scope.reqRowCnt = 20;
	$scope.currentPage = 1;
	$scope.totalCount = 0;
	$scope.artist_no = (getParameter("artist_no"));
	$scope.artist_nos = [];
	$scope.artist_nos.push(getParameter("artist_no"));
	$scope.sale_kind_cd = [];
	$scope.sale_kind_cd.push("online_zb");

	$scope.loadArtDetailList = function($page) {
		$scope.currentPage = $page;
	$d = {
			"baseParms" : {	"artist_no" : $scope.artist_no , "artist_nos":$scope.artist_nos, "sale_kind_cd": $scope.sale_kind_cd },
			"actionList" : [ 
				{"actionID" : "zero_base_artist","actionType" : "select","tableName" : "ART_LIST","parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt)}]}, 
				{"actionID":"lot_list_count", "actionType":"select" , "tableName": "LOT_CNT" ,"parmsList":[{"for_count":true}]},
				{"actionID":"lot_list_paging", "actionType":"select" , "tableName": "LOTS" ,"parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt)}]},
				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
		]};

		$d["actionList"][2]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 
		common.callActionSet($d, $s);
	}

	var $s = function(data, status) {
		$scope.artList = data["tables"]["ART_LIST"]["rows"];
		$scope.lotList = data["tables"]["LOTS"]["rows"];
		$scope.totalCount = data["tables"]["LOT_CNT"]["rows"][0]["CNT"];
		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
		console.log($scope.lotList);
		//$scope.totalCount = data["tables"]["ART_CNT"]["rows"][0]["CNT"]; 
	};
	
	
	/* 관심작품 */
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
					alert("A favorate work has been added.\nYou can find your favorite works on your account page.");
					window.location.reload(true);
				}
				return true;
			}
		})
		
	}
	
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
					alert("A favorate work has been deleted.");
					window.location.reload(true);
				}
				return true;
			}
		})	
	}
	
});

</script>
<script type="text/javascript" src="/resources/js/bid.js?${resources.timestamp}"></script>


<body>
	<jsp:include page="../include/topSearch.jsp" flush="false" />
	<div id="wrap" class="noexhibition">
		<jsp:include page="../include/topMenu.jsp" flush="false" />

		<div class="container_wrap">
			<div id="container" ng-controller="artDetailListCtl" data-ng-init="loadArtDetailList(1)">
				<div class="contents_wrap">
					
					<!-- 모바일용 -->
					<div class="m_only m_location" ng-repeat="artList in artList">
						<div class="hidden_box">
							<ul>
								<li>
									<div class="m_ex_title zero_mwrap">
										<div class="title">
											<div class="tit">
												<span class="ng-binding" ng-if="locale == 'ko'">{{artList.ARTIST_NAME_BLOB_KO}}</span>
												<span class="ng-binding" ng-if="locale != 'ko'">{{artList.ARTIST_NAME_BLOB_EN}}</span>
											</div>

											<div class="sub sub02">
												<span class="ng-binding" ng-if="locale == 'ko'"> <strong class="info_font">Info</strong>
													<p class="m_infotxt">
                                                        {{artList.NATION_CD}}
                                                        {{artList.BORN_YEAR}}
                                                        {{artList.PROFILE_BLOB_KO}}
                                                    </p>
												</span> <span class="ng-binding" ng-if="locale != 'ko'"> <strong class="info_font">Info</strong>
													<p class="m_infotxt">
                                                        {{artList.NATION_CD}}
                                                        {{artList.BORN_YEAR}}
                                                        {{artList.PROFILE_BLOB_EN}}
                                                    </p>
												</span>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>

					<!-- 웹용 -->
				
					<div class="contents">
						<div class="ex_title type02" ng-if="viewId != 'SEARCH'" ng-repeat="artList in artList">
							<div class="title">
								<div class="tit zero_tit">
									<span class="num"></span>
									<!-- // num -->
                                        <img src="/nas_img/{{artList.FILE_PATH}}/{{artList.FILE_NAME}}" width="170px" height="170px" style="margin: 20px 0; background-size: contain;">   
                                        <span ng-if="locale == 'ko'" style="font-weight: 600; text-align:center;"> {{artList.ARTIST_NAME_BLOB_KO}} </span>  
                                        <span ng-if="locale != 'ko'" style="font-weight: 600; text-align:center;"> {{artList.ARTIST_NAME_BLOB_EN}} </span>
									<!-- <span ng-if="viewId == 'CURRENT_AUCTION' && sale_status == 'ING' && sale.SALE_KIND_CD == 'online' && sale_status = 'END'">진행 LOT : <span ng-bind="curr_lot_no"></span></span> -->
								</div> 
								<div class="sub zero-left">
									<span ng-if="locale == 'ko'">
										<p class="zero_info">Info</p>
										<p class="zero_infotxt">
										{{artList.NATION_CD}}
										{{artList.BORN_YEAR}}
										{{artList.PROFILE_BLOB_KO}}
										</p>
									</span> <span ng-if="locale != 'ko'">
										<p class="zero_info">Info</p>
										<p class="zero_infotxt">
										{{artList.NATION_CD}}
										{{artList.BORN_YEAR}}
										{{artList.PROFILE_BLOB_EN}}
										</p>
									</span>
								</div>					 			
							</div>
						</div><!--ex_title type02-->
						<div style="clear: both"></div>
						
						<div ng-if="viewId == 'SEARCH'" class="tit_h2">
							<h2>검색</h2>
						</div> 
					<form name="pageForm" method="get">  						
						<div class="tbl_top web_only mt0 t_tbl_top">
							<div class="left">
								<div class="wrap_paging">
									<paging page="currentPage" page-size="pageRows"
										total="totalCount" adjacent="10"
										paging-action="loadLotList(page)" scroll-top="true"
										hide-if-empty="true" show-prev-next="true"
										show-first-last="true" ul-class="page_ul"
										active-class="page_active" disabled-class="page_disable"
										text-next-class="page_btn sp_btn btn_next02"
										text-prev-class="page_btn sp_btn btn_prev02"
										text-first-class="page_btn sp_btn btn_prev"
										text-last-class="page_btn sp_btn btn_next"> </paging>
								</div>
							</div>
							
							<div class="right">
								<div class="view">
									<div class="fl_wrap">
										<span class="tbl_label">총 <span class="txt_green02">{{totalCount}}</span></span>
									</div>
								</div>
								
								<span class="btn_style01 white02 icon02 btn_scrollbot">
									<button type="button">아래로</button> <span class="ico down"></span>
								</span>
							</div>
						</div><!-- // tbl_top web_only -->
						</form>


						<div class="auction_list" style="z-index: 8; background-color: #fff">
							<ul id="auctionList">
								<li class="ng-scope" ng-repeat="lot in lotList">
									<!-- 경매중 이미지 사이즈 -->
									<div class="auction_list_img" ng-if="sale_status!='END'">   
										<span ng-if="sale_status == 'ING'">
											<span class="ng-scope">
												<span class="ng-scope"> 
													<a class="ng-scope" href="#">
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}">
													</a>
												</span> 
											</span>  
										</span>
										
										<span ng-if="sale_status != 'ING'">
											<span class="ng-scope">   
												<span class="ng-scope">  
													<a class="ng-scope" href="#">
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}">
													</a>
												</span> 
											</span>  
										</span> 
									</div>
									
									<!-- 경매종료 3*3 사이즈 -->     
									<div class="result_auction_img_wrap result_zeroartist_img_wrap" ng-if="sale_status=='END'">       
										<div class="result_auction_img result_zeroartist_img"> 
											<span ng-if="sale_status == 'ING'"> 
												<span class="ng-scope">
													<span class="ng-scope">
														<a class="ng-scope" href="#">
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}">
														</a>  
													</span>  
												</span> 
											</span>
											
											<span ng-if="sale_status != 'ING'">
												<span class="ng-scope"> 
													<span class="ng-scope">
														<a class="ng-scope" href="#"> 
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}">
														</a>  
													</span>  
												</span>
											</span>
										</div>
									</div>
									
									<div class="hidden_box m_padding auction_list_hidden_box"> 
										<div class="author auction_list_author">
											<div class="cancel ng-hide">
												<p class="notice_style03 tac">
													현 작품은 <span class="txt_green02">출품이 취소</span>되었습니다.
												</p>
											</div>
											
											<div class="lot_wish"> 
											 	<div class="lotnum auction_lotnum"> 
											 		<div class="lot new_auction_lot">   
														<span >lot. <strong>{{lot.LOT_NO}}</strong></span> 
													</div> 
											 	</div> 
										 	</div><!-- //lot_wish -->
										 	
											<div class="name auction_workartist"> 
												<span ng-bind="lot.ARTIST_NAME_JSON[locale]"></span>
												<span style="font-size: 14px; vertical-align: middle;">
													<span ng-bind="lot.ARTIST_NAME_JSON.zh"></span>
													<span ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')"></span>
												</span>
											</div>
											
											<div class="title auction_worktitle" style="border: none;"> 
												<!-- <div class="lang web_only">
													<span ng-bind="lot.ARTIST_NAME_JSON.zh"></span>
													<span ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')"></span>
												</div> -->
												<div class="tit">
													<span ng-bind="lot.TITLE_JSON[locale]"></span>
												</div>
											</div>
											
											<div style="margin: 10px 0;"></div><!-- //빈칸용 -->
														
											<div class="explain add_explain auction_list_explain" style="text-align: left;"> 
												<p ng-if="lot.MATE_NM" ng-bind="'MATE_NM' | localeValue : lot"></p>  
												<!-- <p ng-if="locale == 'ko' && lot.MATE_NM_EN != lot.MATE_NM"><span ng-bind="lot.MATE_NM_EN"></span></p> -->
												<p ng-repeat="size in lot.LOT_SIZE_JSON">
												 <span ng-bind="size | size_text"></span> 
												</p>
												
												<p ng-if='lot.EDITION'><span ng-bind="lot.EDITION"></span></p>
												<p ng-if='lot.MAKE_YEAR_JSON[locale]'>
													<span ng-bind="lot.MAKE_YEAR_JSON['ko']"></span>
												</p>
											</div> 
										</div>
	
											<%-- <div class="estimate" style="text-align:left;">
												<span class="txt_dark web_only ng-scope zerolist_price" ng-if="locale == 'ko'">추정가</span>
												<span class="txt_dark web_only ng-scope zerolist_price" ng-if="locale != 'ko'">Estimate</span>
												
												<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null">
													<!-- KRW -->
												<p>
													<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span>
													<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)" ng-bind="' ~ '"></span>	
													<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
												</p>
												<!-- USD -->
												<p ng-if="lot.EXPE_PRICE_FROM_JSON.USD != null && sale.SALE_KIND_CD != 'hongkong'">
													<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
													<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)" ng-bind="' ~ '"></span>	
													<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
												</p>
												<!-- HKD -->
												<p>
													<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
													<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)" ng-bind="' ~ '"></span>	
													<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
												</p>
												</span>
												
												<div>
													<span class="ng-scope">
													<span class="txt_dark"><spring:message code="label.expense.start_price" /></span>
													<p>KRW <span ng-bind="lot.START_PRICE | number : 0"></span></p>
													</span>
												</div><!-- // 시작가끝-->
											</div> --%><!-- // estimate -->
	
											<div class="estimate auction_list_estimate" style="background: transparent; height: 100%;">
												<div class="zero_btn_wrap_back">  
													<div class="zero_btn02 zerolist_btn">
														<a href="{{'../lotDetail?sale_no=' + lot.SALE_NO + '&lot_no=' + lot.LOT_NO }}" ng-if="locale == 'ko'">자세히 보기</a>
														<a href="{{'../lotDetail?sale_no=' + lot.SALE_NO + '&lot_no=' + lot.LOT_NO }}" ng-if="locale != 'ko'">SEE MORE</a>
													</div>
												
													<span>									
														<a ng-if="!custInfo.CUST_NO" type="button" class="btn_interest zero_btn_interest web_only" onClick="alert('로그인 해주세요.\n Please login for use.')">
															<span ng-if="locale=='ko'">관심작품</span> 
															<span ng-if="locale!='ko'">FAVORITE WORK</span>
														</a>
													</span>	
													
													<span ng-if="custInfo.CUST_NO > 0 && lot.STAT_CD != 'reentry'">
														<span ng-if="lot.INTE_LOT_DEL == 'N'" class="btn_interest zero_btn_interest_active sele web_only">
															<a ng-if="custInfo.CUST_NO" type="button" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});">
																<span ng-if="locale=='ko'">관심작품 삭제</span>
																<span ng-if="locale!='ko'">FAVORITE WORK Del.</span>
															</a>
														</span> 
													</span>
													<span ng-if="custInfo.CUST_NO > 0 && lot.INTE_LOT_DEL != 'N' && lot.STAT_CD != 'reentry'" class="btn_interest zero_btn_interest web_only" > 
														<a ng-if="custInfo.CUST_NO" type="button" ng-click="inteSave({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});">
															<span ng-if="locale=='ko'">관심작품</span>
															<span ng-if="locale!='ko'">FAVORITE WORK</span>
														</a> 
													</span>
												</div> 
											</div> <!-- //auction_list_estimate -->
									</div> <!--// hidden_box -->
								</li><!-- end ngRepeat: lot in lotList -->
							</ul>
						</div>



						<div style="display: none;">
							<span class="btn_style01 xlarge green02 btn_bid btn_modal pop01">
								<button type="button">작품응찰신청</button>
							</span> <span class="btn_style01 xlarge green02 btn_bid btn_modal pop02">
								<button type="button">응찰하기</button>
							</span> <span class="btn_style01 xlarge dark btn_bid btn_modal pop03">
								<button type="button">경매기록보기</button>
							</span> <span class="btn_style01 xlarge dark btn_bid btn_modal pop13">
								<button type="button">사업자본인인증</button>
							</span> <span class="btn_style01 xlarge dark btn_bid btn_modal pop11">
								<button type="button">비디오보기</button>
							</span> <span class="btn_style01 gray02 btn_modal pop15">
								<button type="button">Become a Bidding Member</button>
							</span>
						</div>
						
						<div class="wrap_paging">
							<!-- S : paging 영역 -->
							<paging page="currentPage" 
							page-size="pageRows"
								total="totalCount" 
								adjacent="10"
								paging-action="loadArtDetailList(page)" 
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
					<!-- contents m_top -->
				</div>
			</div>
		</div>
	</div>


<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
