<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<link href="/css/angular/rzslider.css" rel="stylesheet">
<link href="/css/angular/ngDialog.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">
<script type="text/javascript" src="/js/angular/checklist-model.js"></script>
<script type="text/javascript" src="/js/angular/paging.js"></script>
<script type="text/javascript" src="/js/angular/rzslider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>

<link href="/css/jquery.nouislider.css" rel="stylesheet">
<script src="/js/jquery.nouislider.all.js"></script>

<script>

var getLoginInfo = $("#accountBtn").next().text();
	if( getLoginInfo != "LOGOUT" ){ $(document).on('click', 'a[href="#"]', function(e){
	    e.preventDefault();
	});	} 

app.requires.push.apply(app.requires, ["bw.paging", "ngDialog", "checklist-model"]);
app.controller('lotListCtl', function($scope, consts, common, is_login, locale, $filter) {
	$scope.popstate = false;
	$scope.is_login = is_login;
	$scope.locale = locale;
	$scope.pageRows = 20;//consts.LOT_LIST_ROWS;
	$scope.reqRowCnt = "20";
	$scope.currentPage = 1;
	$scope.totalCount = 0;
	$scope.db_now = null;
	$scope.sale_no = null;
	$scope.sale_status = null;
	$scope.lot_map = {};
	$scope.is_error = false;
	$scope.now_timer_start = false;
	$scope.list_timer_start = false;
	$scope.modal = null;
	$scope.expe_from_price = null;
	$scope.expe_to_price = null;
	$scope.search = {"sale_kind" : []};
	
	$scope.reqRowCnts = {20:"<spring:message code='label.listup.lots' arguments='20' />",
						50:"<spring:message code='label.listup.lots' arguments='50' />",
						100:"<spring:message code='label.listup.lots' arguments='100' />"};

	
	$scope.sortBy = "ENDDE";
	$scope.orders={
					"ENDDE": "<spring:message code="label.sort.by.latest" />",
					"LOTAS": "<spring:message code="label.sort.by.LOTAS" />",
	                "LOTDE": "<spring:message code="label.sort.by.LOTDE" />",
	                "ESTAS": "<spring:message code="label.sort.by.ESTAS" />",
	                "ESTDE": "<spring:message code="label.sort.by.ESTDE" />"};

	$scope.sale_kind_list = [
	        {"text":"<spring:message code="label.online" />", "cd":"online"},
	        {"text":"<spring:message code="label.online_zb" />", "cd":"online_zb"},
	        {"text":"<spring:message code="label.offline" />", "cd":"main"},
	        {"text":"<spring:message code="label.offline.hk" />", "cd":"hongkong"},
	        {"text":"<spring:message code="label.plan" />", "cd":"plan"}];
	        /* {"text":"<spring:message code="label.exhibit" />", "cd":"exhibit"}]; */ 

	$scope.sale_kind_all = true;
	$scope.checkSaleKindAll = function(){
		if($scope.sale_kind_all){
			$scope.search.sale_kind = $scope.sale_kind_list.map(function(item) { return item.cd; });
		}
		else{
			$scope.search.sale_kind = [];
		}
	}
	
	$scope.uncheckAll = function(){
		$scope.sale_kind_all = false;
	}
	
 	$scope.init = function(){
 		$scope.checkSaleKindAll();
 		$scope.search.keyword = "${param.searchContent}";
 		//$scope.search.keyword1 = "${param.searchContent1}";//작품명 검색
 		$scope.search.chk = "all";//검색 조건 (all 통합검색, art 작가명, title 작품명)
 		
		if(getCookie("prev_url").indexOf("lotDetail") > -1 || getCookie("prev_url").indexOf("lotSearchList") > -1){
	 		if($scope.search.keyword == "undefined" || $scope.search.keyword.length == 0 ){	
				if(getCookie("keyword") == "undefined"){
					$scope.search.keyword = undefined;
				}else{
					$scope.search.keyword = getCookie("keyword");	
				}
				//작품명 검색(작가명/작품명 분리 검색)
				//if(getCookie("keyword1") == "undefined"){
				//	$scope.search.keyword1 = undefined;
				//}else{
				//	$scope.search.keyword1 = getCookie("keyword1");	
				//}
				if(getCookie("chk") == "undefined"){
					$scope.search.chk = "all";
				}else{
					$scope.search.chk = getCookie("chk");	
				}
				
				if(getCookie("mate_nm") == "undefined"){
					$scope.search.mate_nm = undefined;
				}else{
					$scope.search.mate_nm = getCookie("mate_nm");
				}
		 			
				if(getCookie("from_dt") == "undefined"){
					$scope.search.from_dt = undefined;
				}else{
					$scope.search.from_dt = getCookie("from_dt");
				}
		 		
				if(getCookie("to_dt") == "undefined"){
					$scope.search.to_dt = undefined;
				}else{
					$scope.search.to_dt = getCookie("to_dt");	
				}
	 		}
 		}

 		if($scope.search.keyword.length > 0){
 			if(getCookie("prev_url").indexOf("lotDetail") > -1 || getCookie("prev_url").indexOf("lotSearchList") > -1){
 	    		if(getCookie('page') != undefined){
		 	    	$scope.loadLotList(getCookie('page'));
 	    		}
 	    		else{
		 	  		$scope.loadLotList(1);
 	    		}
 	    	}
 	    	else{
	 	  		$scope.loadLotList(1);
 	    	}
 		}
 	}

 	$scope.search = function(){
 		$scope.loadLotList(1); 		
 	}
 	
 	$scope.clearSearchCondition = function(){
 		$scope.search = {"sale_kind" : ['main', 'online', 'online_zb', 'hongkong', 'plan', 'exhibit']};
 		
 		setCookie('keyword', "", 1);
 		//setCookie('keyword1', "", 1);
 		setCookie('chk', "", 1);
 		setCookie('mate_nm', "", 1);
 		setCookie('from_dt', "", 1);
 		setCookie('to_dt', "", 1);	
 	}
 	
 	$scope.cnt = 0;
 	$scope.loadLotList = function($page){

 		if($page > 1){
 			setCookie('prev_url', getCookie('curr_url'), 1);
 		} 	
 		
 		setCookie('page', $page, 1);

 		setCookie('keyword', $scope.search.keyword, 1);
 		//setCookie('keyword1', $scope.search.keyword1, 1);
 		setCookie('chk', $scope.search.chk, 1);
 		setCookie('mate_nm', $scope.search.mate_nm, 1);
 		setCookie('from_dt', $scope.search.from_dt, 1);
 		setCookie('to_dt', $scope.search.to_dt, 1);	
		
 		$scope.currentPage = $page;
  
 		$d = {"baseParms":{
	 				"list_type": "SEARCH", "sale_kind" : $scope.search.sale_kind
	 				, "keyword": $scope.search.keyword, "mate_nm": $scope.search.mate_nm
	 				, "from_dt": $scope.search.from_dt, "to_dt": $scope.search.to_dt
	 				//, "keyword1": $scope.search.keyword1
	 				, "chk": $scope.search.chk
 				},
 				"actionList":[            
 				{"actionID":"search_list_count", "actionType":"select" , "tableName": "LOT_CNT" ,"parmsList":[{"for_count":true}]},
 			    {"actionID":"search_list_paging", "actionType":"select" , "tableName": "LOTS" 
 								,"parmsList":[{
 										"from": (($scope.currentPage - 1) * parseInt($scope.reqRowCnt))
 										, "rows":parseInt($scope.reqRowCnt)
 										, "sort_by":$scope.sortBy}
 								]
 				},
  				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
  				{"actionID":"search_log", "actionType":"insert" , "tableName": "SEARCH_LOG" ,"parmsList":[{}]},
 			 ]};

 	   	common.callActionSet($d, function(data, status) {
 	   		if(data.tables.LOTS.rows.length != 0){
 	   		$(".wrap_paging").show();	 					
 	 		} else { $(".wrap_paging").hide(); }
 	   		$scope.totalCount = data["tables"]["LOT_CNT"]["rows"][0].CNT;
 	 	    $scope.lotList = data["tables"]["LOTS"]["rows"];
 	 		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
 	 		$scope.searchLog = data["tables"]["SEARCH_LOG"]["rows"];
 	 		$scope.pageRows = parseInt($scope.reqRowCnt);
 		}, function(){
 			$scope.is_error = true;
 		});
	}
 	
 	
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
	/* 관심작품 End */ 
});
</script> 
<script type="text/javascript" src="/js/bid.js"></script>
<body> 
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		<!--<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>-->
		<div id="container" ng-controller="lotListCtl" data-ng-init="init();">
			<div class="sub_menu_wrap menu01">
				<div class="sub_menu">
					<jsp:include page="../include/subMenu.jsp" flush="false"/>
				</div>
			</div> 
			<!-- //sub_menu_wrap -->
			
			<div class="contents_wrap">
				
				<div class="contents m_top">
					<!--<button class="sp_btn btn_up">
						<span class="hidden"><spring:message code="label.move.top" /></span>
					</button>-->
					<div class="tit_h2">
						<h2><spring:message code="label.search" /></h2>
					</div>
					<form name="searchForm" method="get">
						<fieldset>
							<legend><spring:message code="label.search" /></legend>
							<div class="wrap_search search mt0">
								<div class="search_box">
									<div class="row">
										<dl>
											<dt><label for=""><spring:message code="label.period" /></label></dt>
											<dd>
												<div class="fl_wrap">
													<div class="input_period">
														<input name="from_dt" ng-model="search.from_dt" class="tac" 
															onkeyup="this.value=numberOnly(this.value);" ng-keypress="$event.keyCode === 13 && loadLotList(1);" placeholder="20170321" type="text" maxlength="8">
														<span class="tbl_label">~</span>
														<input name="to_dt" ng-model="search.to_dt" class="tac" 
															onkeyup="this.value=numberOnly(this.value);" ng-keypress="$event.keyCode === 13 && loadLotList(1);"  placeholder="20171231" type="text" value="" maxlength="8">
														<span class="tbl_label"><spring:message code="label.period.num" /></span>
													</div>
												</div>
											</dd>
										</dl>
										<dl>
											<dt><spring:message code="label.auction.sales" /></dt>
											<dd style="float: none;">  
												<div class="wrap_check">  
													<div >
														<input ng-model="sale_kind_all" ng-click="checkSaleKindAll()" type="checkbox" >
														<label for="all"><spring:message code="label.membership.inqueryall" /></label>
													</div>
													<div ng-repeat="sale_kind in sale_kind_list">
														<input checklist-model="search.sale_kind" ng-click="uncheckAll();" type="checkbox" checklist-value="sale_kind.cd">
														<label>{{sale_kind.text}}</label>
													</div>
												</div>
											</dd>
										</dl>
									</div>
									<div class="row">
										<dl>
											<dt><label for=""><spring:message code="label.artist.title" /></label></dt>
											<dd>
												<div>
												<input type="text" name="searchContent" ng-model="search.keyword" ng-keypress="$event.keyCode === 13 && loadLotList(1);"  style="width:100"
												  placeholder="<spring:message code="label.artist.title" />">
												<!-- <span class="tbl_label">/</span>
												<input type="text" name="searchContent1" ng-model="search.keyword1" style="width:100"
												  placeholder="<spring:message code="label.artist.title.ex01" />"> -->
												  &nbsp;&nbsp;
												<input type="radio" name="chk" ng-model="search.chk" value="all" checked /><label><spring:message code="label.artist.title" /></label>
												<input type="radio" name="chk" ng-model="search.chk" value="art"/><label><spring:message code="label.artist.title.ex" /></label>
												<input type="radio" name="chk" ng-model="search.chk" value="title" /><label><spring:message code="label.artist.title.ex01" /></label>
											</dd>
										</dl>
										<dl>
											<dt><label for=""><spring:message code="label.material" /></label></dt>
											<dd>
												<input type="text" style="width:150px;" name="mate" ng-model="search.mate_nm" ng-keypress="$event.keyCode === 13 && loadLotList(1);" class="input_search" placeholder="<spring:message code="label.material.works" />">
											</dd>
										</dl>
									</div>		
								</div>
								<div class="btn_wrap">
									<span class="btn_style01 gray">
										<button type="button" ng-click="clearSearchCondition();"><spring:message code="label.search.reset" /></button>
									</span>
									<span class="btn_style01 gray02">
										<button type="button" ng-click="search();"><spring:message code="label.search" /></button>
									</span>
								</div>
							</div>
						</fieldset>
						<!-- <div class="tbl_top web_only mt0 t_tbl_top"> -->
						<div class="tbl_top web_only02 mt0 t_tbl_top"> <!-- m_ver paging 상단으로 변경 -->
							<div class="left">
								<div class="wrap_paging">
									<paging page="currentPage"
											page-size="pageRows"
											total="totalCount"
											paging-action="loadLotList(page)"
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
										    text-last-class="page_btn sp_btn btn_next"
									>
									</paging>
								</div>
							</div>
							<div class="right">
								<div class="view">
									<div class="fl_wrap">
										<span class="tbl_label"><spring:message code="label.total.lots" arguments='{{totalCount}}' /></span>
										<label for="" class="tbl_label bar02"><spring:message code="label.sort.by" /></label>
										<select path="orderType" ng-model="sortBy">
											<option ng-repeat="(key, value) in orders" value="{{key}}">{{value}}</option>
										</select>
										<select ng-model="reqRowCnt">
											<option ng-repeat="(key, value) in reqRowCnts" value="{{key}}">{{value}}</option>
										</select>
										<span class="btn_style01 gray03">
											<button type="button" ng-click="loadLotList(1);"><spring:message code="label.query" /></button>
										</span>
									</div>
								</div>
								<span class="btn_style01 white02 icon02 btn_scrollbot">
									<button type="button"><spring:message code="label.move.bottom" /></button>
									<span class="ico down"></span>
								</span>
							</div>
						</div>
					</form>
	
					<script type="text/javascript" src="/js/fancybox/jquery.fancybox.js"></script>
					<script type="text/javascript">
						$(".fancybox").fancybox({
							openEffect	: 'none',
							closeEffect	: 'none'
						});
					</script>
					
					<div class="auction_list">
						<ul id="auctionList"> 
							<div ng-if="lotList < 1" class="noListbox"  style=""> 
								<p>{{locale == 'ko'? '검색결과가 없습니다.' : 'There is no List.'}}</p><br>
							</div>
							<li ng-repeat="lot in lotList" ng-init="lot_map[lot.LOT_NO] = lot;"> 
								<!-- 경매 진행 중 이미지 사이즈 --> 
								<div class="auction_list_img" oncontextmenu="return false" onselectstart="return false" ondragstart="return false"onkeydown="return false" ng-if="lot.END_YN=='N'">
									<!-- YBK.20170303.noImage처리(직원X, 이미지게시여부X) --> 
									<a target="_blank" ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + lot.SALE_NO + '&lot_no=' + lot.LOT_NO + '&SearchYn=Y' : '#'}}">
										<!-- <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE_JSON[locale]}}" style="height: 100%; width: auto; margin-top: 0px;"/> -->
										<span ng-if="lot.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
											<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE_JSON[locale]}}" />
										</span>
										<span ng-if="lot.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
											<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE_JSON[locale]}}" />
										</span>
									</a>   
									 
									<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'">
										<img ng-src="/images/bg/no_image.jpg" /> 
									</a>
								</div> 
								
								<!-- 경매 종료 후 3*3 이미지 사이즈 -->  
								<div class="result_auction_img_wrap" ng-if="lot.END_YN=='Y'">   
									<div class="result_auction_img" oncontextmenu="return false" onselectstart="return false" ondragstart="return false"onkeydown="return false">
										<!-- YBK.20170303.noImage처리(직원X, 이미지게시여부X) -->
										<a target="_blank" ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + lot.SALE_NO + '&lot_no=' + lot.LOT_NO + '&SearchYn=Y' : '#'}}">
											<!-- <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE_JSON[locale]}}" style="height: 100%; width: auto; margin-top: 0px;"/> -->
											<span ng-if="lot.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE_JSON[locale]}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
											</span>
											<span ng-if="lot.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE_JSON[locale]}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
											</span>
										</a>
										 
										<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'">
											<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
										</a>
									</div> 
								</div><!-- //result_auction_img_wrap-->   
								
								<div class="hidden_box auction_list_hidden_box">      
									<!-- <div class="img" oncontextmenu="return false" onselectstart="return false" ondragstart="return false"onkeydown="return false">
										<!-- YBK.20170303.noImage처리(직원X, 이미지게시여부X) ->
										<a target="_blank" ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + lot.SALE_NO + '&lot_no=' + lot.LOT_NO + '&SearchYn=Y' : '#'}}">
											<!-- <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE_JSON[locale]}}" style="height: 100%; width: auto; margin-top: 0px;"/> ->
											<span ng-if="lot.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE_JSON[locale]}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</span>
											<span ng-if="lot.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE_JSON[locale]}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</span>
										</a>
										
										<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'">
											<img ng-src="/images/bg/no_image.jpg" />
										</a>
									</div>-->
									
									<%-- 출품 취소 여부 확인 --%> 
									<div class="cancel auction_list_cancel" ng-show='lot.STAT_CD == "reentry"'>
										<p class="notice_style03 tac"><spring:message code="message.lot.status.reentry" /></p>
									</div>
																		
									<!-- 홍콩경매 여부에 따른 화면표시 확인 --> 
									<div class="author auction_list_author" ng-show='lot.STAT_CD != "reentry"'> 
										<div class="lot_wish">	 
											<div class="lotnum auction_lotnum">  
												<strong> 
													<span ng-if="lot.SALE_NO == '410'">
														<span ng-if="lot.LOT_NO != '91' && lot.LOT_NO != '92'" title="{{lot.LOT_NO}}">{{lot.LOT_NO}}</span>  
														<span ng-if="lot.LOT_NO == '91'">S01</span> 
														<span ng-if="lot.LOT_NO == '92'">S02</span>
													</span>
													<span ng-if="lot.SALE_NO != '410'" title="{{lot.LOT_NO}}">{{lot.LOT_NO}}</span> 
												</strong>  
											</div>   
											<div class="wish_btn">    
												<button type="button">     
													<span ng-if="lot.STAT_CD != 'reentry'">   
											            <span ng-if="!custInfo.CUST_NO" class="grid_wish_btn" onClick="alert('로그인 해주세요.\n Please login for use.')" title="관심작품 보기 / WishList"> </span>   
												        <span ng-if="custInfo.CUST_NO && lot.INTE_LOT_DEL == 'N'" class="grid_wish_btn grid_wish_btn_sele" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishList"></span>
												        <span ng-if="custInfo.CUST_NO  && lot.INTE_LOT_DEL != 'N' && lot.STAT_CD != 'reentry'" class="grid_wish_btn" ng-click="inteSave({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishList"></span> 
										            </span>
										        </button>      
											</div>   
										</div><!-- //lot_wish -->     
										
										<div class="name auction_workartist">        
											<span ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}"></span>     
											<!-- <span class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh" style="font-weight:normal; font-family:none;"></span> -->   
											<span class="txt_pale" ng-if="lot.BORN_YEAR!=null" ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')" title="{{(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')}}"></span> 
											<!-- // 아티스트  
												 <div class="lang web_only"> 
												<!-- <span ng-if="locale != 'en'" ng-bind="lot.ARTIST_NAME_JSON.en"></span> //2018.08.30 캡션간소화처리(YDH) ->
												<span class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh"></span>
												<span class="txt_pale" ng-if="lot.BORN_YEAR!=null" ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')"></span> 
											</div> -->   
										</div>    
										
										<div class="title txt-over">   
											<div class="tit txt-over"><span title="{{lot.TITLE_JSON[locale]}}">{{lot.TITLE_JSON[locale]}}</span></div>
											<div class="lang web_only txt-over">     
												<span>
													<p ng-if="lot.TITLE_JSON.en != null">   
													{{lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale] }} </p>
													<p ng-if="lot.TITLE_JSON.zh != null && lot.TITLE_JSON.zh != lot.TITLE_JSON.en"> 
													{{lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale] }} </p>
												</span>
												<span style="color:#666">
													<p ng-if="lot.STITLE_JSON[locale] != null"> 
													{{lot.STITLE_JSON[locale]}} </p>
													<p ng-if="lot.STITLE_JSON.en != null">
													{{lot.STITLE_JSON.en | trimSameCheck : lot.STITLE_JSON[locale] }} </p>
													<p ng-if="lot.STITLE_JSON.zh != null && lot.STITLE_JSON.zh != lot.STITLE_JSON.en">
													{{lot.STITLE_JSON.zh | trimSameCheck : lot.STITLE_JSON[locale] }} </p>
												</span>
											</div>
										</div> 
										
										<div class="explain auction_list_explain" ng-show='lot.STAT_CD != "reentry"'>
											<p ng-if='lot.MAKE_YEAR_JSON[locale]'> 
												<span title="{{lot.MAKE_YEAR_JSON[locale]}}">{{lot.MAKE_YEAR_JSON[locale]}}</span> 
												{{lot.MAKE_YEAR_JSON["en"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}
												<span ng-if="lot.MAKE_YEAR_JSON.zh != null">{{lot.MAKE_YEAR_JSON["zh"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}
											</p>    
											<p>
												<span ng-bind="lot.MATE_NM_EN" title="{{lot.MATE_NM_EN}}"></span>  
											</p>
											<p ng-repeat="size in lot.LOT_SIZE_JSON"> 
												<span ng-if="locale!='ko'" ng-bind="size | size_text" title="{{size | size_text}}"></span> 
												<span ng-if="locale=='ko'" ng-bind="size | size_text_cm" title="{{size | size_text_cm}}"></span> 
												<!-- <span ng-if="locale!='ko'" ng-bind="size | size_text_in"></span> --> 
											</p> 
											<p ng-if='lot.EDITION'><span title="{{lot.EDITION}}">{{lot.EDITION}}</span></p>  
											<!-- <span class="web_only" ng-if="lot.MATE_NM">  
												{{"MATE_NM" | localeValue : lot}}
												<p ng-if="locale == 'ko' && lot.MATE_NM_EN != lot.MATE_NM">{{lot.MATE_NM_EN}}</p>
											</span> -->
											<!-- <p ng-repeat="size in lot.LOT_SIZE_JSON">
												{{size | size_text}}
											</p> --> 
											<!-- <p ng-if='lot.SIGN_INFO_JSON[locale]'> 
												<span bind-html-compile="lot.SIGN_INFO_JSON[locale]"></span>
												{{lot.SIGN_INFO_JSON["en"] | trimSameCheck : lot.SIGN_INFO_JSON[locale] }}
												<span ng-if="lot.SIGN_INFO_JSON.zh != null">{{lot.SIGN_INFO_JSON["zh"] | trimSameCheck : lot.SIGN_INFO_JSON[locale] }}
											</p> --> 
										</div> 
									</div><!-- //author auction_list_author -->    
	
									
									<div class="estimate auction_list_estimate" ng-show='lot.STAT_CD != "reentry"' style="padding: 10px;">   
										<div class="ect auction_ect search_auction_ect">     
											<!-- 현재 및 지난옥션 날짜 및 경매명 -->              
											<div style="padding: 15px 0; font-weight: bold; color: #898c8c; font-size: 14px;">                     
												<span ng-if="lot.SALE_NO != '408' && lot.SALE_TH != '0th'">{{lot.SALE_TH}}</span>
												<span>{{lot.SALE_TITLE_JSON[locale]}}</span>     
												<span style="font-size: 12px;">[{{lot.SALE_TO_DT | date : 'yyyy.M.d'}}({{getWeek(lot.SALE_TO_DT)}})    
												{{lot.SALE_TO_DT | date : 'ah'}} {{lot.SALE_KIND_CD == 'hongkong' ? "HKT" : "KST"}}]</span>     
											</div>     
										</div> 
										
										<div class="es_price" >
											<!-- 추정가 -->
											<ul>
												<li class="es_price_left" ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_TO_JSON.HKD != 0 && lot.EXPE_PRICE_TO_JSON.KRW != 0 && lot.EXPE_PRICE_FROM_TO.USD != 0">
													<spring:message code="label.expense.price" />
													<%-- <span class="txt_dark web_only" ng-if="lot.EXPE_PRICE_FROM_JSON.HKD != 0 && lot.EXPE_PRICE_FROM_JSON.KRW != 0"><spring:message code="label.expense.price" /></span> --%>
												</li>
                                      			<li class="es_price_right" style="font-size: 12px; line-height: 20px;">
                                      				<!-- 홍콩경매 SALE_KIND_CD == 'hongkong'는 HKD를 맨위로 표시한다. --> 
													<span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'">추정가 별도문의</span>
													<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'"> 
													<span ng-if="lot.CURR_CD == 'HKD'">
														<p ng-if="lot.EXPE_PRICE_FROM_JSON.HKD != 0 && lot.EXPE_PRICE_TO_JSON.HKD != 0 && lot.EXPE_PRICE_FROM_JSON.HKD != null && lot.EXPE_PRICE_TO_JSON.HKD != null">
															{{lot.EXPE_PRICE_FROM_JSON.HKD | currency : "HKD " : 0}} 
															<br>~ {{lot.EXPE_PRICE_TO_JSON.HKD | number : 0}}
														</p>
														<p ng-if="lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_TO_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null && lot.EXPE_PRICE_TO_JSON.USD != null">
															{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}
															<br>~ {{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}
														</p> 
														<p ng-if="lot.EXPE_PRICE_FROM_JSON.KRW != 0 && lot.EXPE_PRICE_TO_JSON.KRW != 0 && lot.EXPE_PRICE_FROM_JSON.KRW != null && lot.EXPE_PRICE_TO_JSON.KRW != null">
															{{lot.EXPE_PRICE_FROM_JSON.KRW | currency : "KRW " : 0}} 
															<br>~ {{lot.EXPE_PRICE_TO_JSON.KRW | number : 0}}
														</p> 
													</span> 
													
													<span ng-if="lot.CURR_CD != 'HKD'">
														<p ng-if="lot.EXPE_PRICE_FROM_JSON.KRW != 0 && lot.EXPE_PRICE_TO_JSON.KRW != 0 && lot.EXPE_PRICE_FROM_JSON.KRW != null && lot.EXPE_PRICE_TO_JSON.KRW != null">
															{{lot.EXPE_PRICE_FROM_JSON.KRW | currency : "KRW " : 0}} 
															<br>~ {{lot.EXPE_PRICE_TO_JSON.KRW | number : 0}}
														</p> 
														<p ng-if="lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_TO_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null && lot.EXPE_PRICE_TO_JSON.USD != null">
															{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}} 
															<br>~ {{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}
														</p> 
														<p ng-if="lot.EXPE_PRICE_FROM_JSON.HKD != 0 && lot.EXPE_PRICE_TO_JSON.HKD != 0 && lot.EXPE_PRICE_FROM_JSON.HKD != null && lot.EXPE_PRICE_TO_JSON.HKD != null">
															{{lot.EXPE_PRICE_FROM_JSON.HKD | currency : "HKD " : 0}}    
															<br>~ {{lot.EXPE_PRICE_TO_JSON.HKD | number : 0}} 
														</p>
													</span> 
												</span>
											</ul> 
										</div><!-- //es_price -->
										 
										<div class="es_price" ng-show='lot.STAT_CD != "reentry"' ng-class="{double:viewId == 'CURRENT_AUCTION'}" style="border-bottom: 0;">
											<!-- 낙찰가 -->         
											<ul> 
												<li class="es_price_left" ng-show='lot.STAT_CD != "reentry"'>
													<div ng-class="{double:viewId == 'CURRENT_AUCTION'}"> 
														<!-- <span><spring:message code="label.auction.finish" /></span> -->
														<span class="finished_icon" ng-if="(['online','online_zb'].indexOf(lot.SALE_KIND_CD) > -1 && lot.END_YN == 'Y') || (['main','hongkong','plan'].indexOf(lot.SALE_KIND_CD) >= 0 && lot.CLOSE_YN == 'Y')"><spring:message code="label.auction.finish" /></span>
														<span class="finished_icon finished_icon_ing" ng-if="(['online','online_zb'].indexOf(lot.SALE_KIND_CD) > -1 && lot.END_YN == 'N') || (['main','hongkong','plan'].indexOf(lot.SALE_KIND_CD) >= 0 && lot.CLOSE_YN == 'N')" class="auction_list_state"><spring:message code="label.auction.ongoing" /></span>
													</div>
                                      			</li>    
                                      			<li class="es_price_right"> 
                                      				<div class="info">      
														<ul ng-if="custInfo.CUST_NO && is_login && ['online','online_zb'].indexOf(lot.SALE_KIND_CD) > -1 && lot.END_YN == 'Y'">
															<li ng-if="lot.LAST_PRICE > 0"><!-- <spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" />--></li>
															<!--  <li ng-if="!lot.LAST_PRICE || lot.LAST_PRICE <= 0"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></li> -->
															<%-- <li ng-if="lot.END_YN == 'Y' && (!lot.LAST_PRICE || lot.LAST_PRICE <= 0)"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></li> --%>
															<li ng-if="lot.LAST_PRICE > 0">  
																<span style="color:#00acac;"><strong><spring:message code="label.bid.price.sold" /></strong></span> 
																<strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION', txt_green02:viewId != 'CURRENT_AUCTION'}"> KRW {{lot.LAST_PRICE | number:0}}</strong>
															</li>
														</ul><!-- 온라인 종료 -->
														
														<ul ng-if="custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(lot.SALE_KIND_CD) >= 0">
															<%-- <li><strong class="txt_impo"><spring:message code="label.bid.price.sold" /> {{base_currency}} {{lot.LAST_PRICE | number:0}}</strong></li> --%>
															<%-- <li ng-if="lot.END_YN == 'Y' && (lot.LAST_PRICE <= 0)"><strong class="txt_impo"><spring:message code="label.auction.unsold" /></strong></li> --%>
															<li ng-if="lot.CLOSE_YN == 'Y' && (lot.LAST_PRICE > 0)"><strong class="txt_impo"><spring:message code="label.bid.price.sold" /> {{lot.CURR_CD}} {{lot.LAST_PRICE | number:0}}</strong></li>
														</ul><!-- 오프라인 경매 && 금액 0 -->
													</div>     
                                      			</li>
                                      			<li class="es_price_right" ng-if="!custInfo.CUST_NO">      
                                      				<span ng-if="locale=='ko'" style="font-size: 12px; font-weight: bold;">        
														낙찰가는 로그인 후 확인할 수 있습니다.      
													</span>  
                                                    <span ng-if="locale!='ko'" style="font-size: 12px; font-weight: bold;">         
														You can check the winning bid after logging in. 
													</span>  
                                      			</li>
											</ul>
										</div>   
										
										<div class="ect auction_ect search_auction_ect" style="height: auto;">         
											<!-- 경매 결과 보기 -->          
											<div class="search_resultbtn">                  
												<!-- 진행경매보기 / 경매결과보기 btn -->  
												<!--  YDH 추가 Start.(2016.10.05) -->
												<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge white btn_bid" ng-if="['online','online_zb'].indexOf(lot.SALE_KIND_CD) > -1 && custInfo.CUST_NO && is_login && lot.END_YN == 'N'">
										        	<a ng-if="locale=='ko'" target="_blank" href="/saleDetail?view_id=CURRENT_AUCTION&sale_no={{lot.SALE_NO}}">진행경매 보기</a> 
                                                    <a ng-if="locale!='ko'" target="_blank" href="/saleDetail?view_id=CURRENT_AUCTION&sale_no={{lot.SALE_NO}}">View Auction</a> 
										        </span>
												<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge white btn_bid" ng-if="['online','online_zb'].indexOf(lot.SALE_KIND_CD) < 0 && custInfo.CUST_NO && is_login && lot.END_YN == 'Y'">
										        	<a ng-if="locale=='ko'" target="_blank" href="/lotDetail?view_id=RESULT_AUCTION&sale_no={{lot.SALE_NO}}&lot_no={{lot.LOT_NO}}&view_type=GRID">경매결과 보기</a>
                                                    <a ng-if="locale!='ko'" target="_blank" href="/lotDetail?view_id=RESULT_AUCTION&sale_no={{lot.SALE_NO}}&lot_no={{lot.LOT_NO}}&view_type=GRID">See the result</a>
										        </span> 
										        <!--  YDH 추가 End.(2016.10.05) -->      
											</div>    
										</div>  
									</div>
										
	
									<!-- <div class="state_wrap" ng-show='lot.STAT_CD != "reentry"'>
										<div class="state_area" ng-class="{double:viewId == 'CURRENT_AUCTION'}">
											<div class="state end"> 
												<!-- <span><spring:message code="label.auction.finish" /></span> ->
												<span ng-if="lot.END_YN == 'Y'"><spring:message code="label.auction.finish" /></span>
												<span ng-if="lot.END_YN == 'N'"><spring:message code="label.auction.ongoing" /></span>
											</div>
											<div class="info">  
												<ul ng-if="custInfo.CUST_NO && is_login && ['online','online_zb'].indexOf(lot.SALE_KIND_CD) > -1 && lot.END_YN == 'Y'">
													<li ng-if="lot.LAST_PRICE > 0"><!-- <spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" />-></li>
													<!--  <li ng-if="!lot.LAST_PRICE || lot.LAST_PRICE <= 0"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></li> ->
													<li ng-if="lot.END_YN == 'Y' && (!lot.LAST_PRICE || lot.LAST_PRICE <= 0)"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></li>
													<li ng-if="lot.LAST_PRICE > 0"><spring:message code="label.bid.price.sold" />
														<strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION', txt_green02:viewId != 'CURRENT_AUCTION'}"> KRW {{lot.LAST_PRICE | number:0}}</strong>
													</li>
												</ul><!-- 온라인 종료 ->
												
												<ul ng-if="custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(lot.SALE_KIND_CD) >= 0">
													<%-- <li><strong class="txt_impo"><spring:message code="label.bid.price.sold" /> {{base_currency}} {{lot.LAST_PRICE | number:0}}</strong></li> --%>
													<li ng-if="lot.END_YN == 'Y' && (lot.LAST_PRICE <= 0)"><strong class="txt_impo"><spring:message code="label.auction.unsold" /></strong></li>
													<li ng-if="lot.END_YN == 'Y' && (lot.LAST_PRICE > 0)"><strong class="txt_impo"><spring:message code="label.bid.price.sold" /> {{lot.CURR_CD}} {{lot.LAST_PRICE | number:0}}</strong></li>
												</ul><!-- 오프라인 경매 && 금액 0 ->
												<span ng-if="!custInfo.CUST_NO">
													낙찰가는 로그인 후 확인할 수 있습니다.
												</span>
											</div>
										</div>
									</div>
									<!-- 버튼 -->
									<!-- test -->
									
									<!-- <span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge dark btn_bid" 
										ng-if="['online','online_zb'].indexOf(lot.SALE_KIND_CD) > -1 && is_login">
										<button ng-click="showBidHistoryPopup({'parent':this, 'sale':sale, 'lot':lot});" >
											<spring:message code="label.go.bid.history" /> 온라인응찰기록 
										</button>
									</span>--><!-- 온라인 / 종료 -->
									<!--  YDH 추가 Start.(2016.10.05) ->
									<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge white btn_bid" ng-if="['online','online_zb'].indexOf(lot.SALE_KIND_CD) > -1 && custInfo.CUST_NO && is_login && lot.END_YN == 'N'">
							        	<a target="_blank" href="/saleDetail?view_id=CURRENT_AUCTION&sale_no={{lot.SALE_NO}}">진행경매 보기</a> 
							        </span>
							        <span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge white btn_bid" ng-if="custInfo.CUST_NO && is_login && lot.END_YN == 'Y'">
							        	<a target="_blank" href="/saleDetail?view_id=RESULT_AUCTION&sale_no={{lot.SALE_NO}}">경매결과 보기</a> 
							        </span> 
							        <!--  YDH 추가 End.(2016.10.05) -->
								</div><!-- hidden_box --> 
								
								<!-- 진행증 / 종료 바 -->
								<%-- <div class="state_wrap" ng-show='lot.STAT_CD != "reentry" && lot.SALE_KIND_CD != "online_zb"'>
									<div class="state_area" ng-class="{double:viewId == 'CURRENT_AUCTION'}" style="margin-top: 10px;"> 
										<div class="state end">     
											<!--   <span><spring:message code="label.auction.finish" /></span> -->
											<span ng-if="lot.END_YN == 'Y'"><spring:message code="label.auction.finish" /></span>
											<span ng-if="lot.END_YN == 'N'" class="auction_list_state"><spring:message code="label.auction.ongoing" /></span>
										</div>  
										<div class="info">  
											<ul ng-if="custInfo.CUST_NO && is_login && ['online','online_zb'].indexOf(lot.SALE_KIND_CD) > -1 && lot.END_YN == 'Y'">
												<li ng-if="lot.LAST_PRICE > 0"><!-- <spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" />--></li>
												<!--  <li ng-if="!lot.LAST_PRICE || lot.LAST_PRICE <= 0"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></li> -->
												<li ng-if="lot.END_YN == 'Y' && (!lot.LAST_PRICE || lot.LAST_PRICE <= 0)"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></li>
												<li ng-if="lot.LAST_PRICE > 0"><spring:message code="label.bid.price.sold" />
													<strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION', txt_green02:viewId != 'CURRENT_AUCTION'}"> KRW {{lot.LAST_PRICE | number:0}}</strong>
												</li>
											</ul><!-- 온라인 종료 -->
											
											<ul ng-if="custInfo.CUST_NO && is_login && ['main','hongkong','plan'].indexOf(lot.SALE_KIND_CD) >= 0">
												<li><strong class="txt_impo"><spring:message code="label.bid.price.sold" /> {{base_currency}} {{lot.LAST_PRICE | number:0}}</strong></li>
												<li ng-if="lot.END_YN == 'Y' && (lot.LAST_PRICE <= 0)"><strong class="txt_impo"><spring:message code="label.auction.unsold" /></strong></li>
												<li ng-if="lot.END_YN == 'Y' && (lot.LAST_PRICE > 0)"><strong class="txt_impo"><spring:message code="label.bid.price.sold" /> {{lot.CURR_CD}} {{lot.LAST_PRICE | number:0}}</strong></li>
											</ul><!-- 오프라인 경매 && 금액 0 -->
											<span ng-if="!custInfo.CUST_NO">
												낙찰가는 로그인 후 확인할 수 있습니다.
											</span>
										</div>
									</div>
									
									<!-- 진행경매보기 / 경매결과보기 btn -->
									<!--  YDH 추가 Start.(2016.10.05) -->
									<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge white btn_bid" ng-if="['online','online_zb'].indexOf(lot.SALE_KIND_CD) > -1 && custInfo.CUST_NO && is_login && lot.END_YN == 'N'">
							        	<a target="_blank" href="/saleDetail?view_id=CURRENT_AUCTION&sale_no={{lot.SALE_NO}}">진행경매 보기</a> 
							        </span>
							        <span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge white btn_bid" ng-if="custInfo.CUST_NO && is_login && lot.END_YN == 'Y'">
							        	<a target="_blank" href="/saleDetail?view_id=RESULT_AUCTION&sale_no={{lot.SALE_NO}}">경매결과 보기</a> 
							        </span>  
							        <!--  YDH 추가 End.(2016.10.05) --> 
								</div> --%> 
							</li><!-- repeat -->
						</ul>
					</div>
					<div class="wrap_paging">
						<!-- S : paging 영역 -->
						<paging page="currentPage"
								page-size="pageRows"
								total="totalCount"
								paging-action="loadLotList(page)"
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
							    text-last-class="page_btn sp_btn btn_next"
						>
						</paging>
						<!-- E : paging 영역 -->
						<div class="right">
							<span class="btn_style01 icon02 btn_scrolltop mbtn">
								<button type="button"><span><spring:message code="label.move.top" /></span></button>
								<span class="ico up"></span>
							</span>
						</div>
					</div>
					
					<jsp:include page="../include/bottom.jsp" flush="false" />
					
				</div><!-- contents m_top -->
			</div>
			
		</div>

		<!--<div class="sub_banner">
			<div class="hidden_box">
				<ul>
					<li>
						<img src="/images/img/img_past.png" alt="작품1" class="img_master">
							
					</li>
				</ul>
			</div>
		</div>-->
		
	</div>
</div>

<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
