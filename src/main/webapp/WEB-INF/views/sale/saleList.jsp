<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<script type="text/javascript" src="/js/angular/paging.js"></script>
<script>
	
var page= 1;
if (location.hash != "" && location.hash  != undefined ) {
	try {
		
		page = parseInt(location.hash.slice(5));
		if (isNaN(page)) {
			page = 1; 
		}
	 
	} catch(ex) {
		page = 1 ;
	}
	
} 

	$(window).on('hashchange', function() {
		var pageValue = parseInt(location.hash.slice(5)); 
		if (isNaN(pageValue)) {
			pageValue = 1; 
		 }
		 
		if (page != pageValue) {
			page = pageValue;
			angular.element(document.getElementById('container')).scope().loadSaleList(pageValue);
	 
		} 
	});

$(document).ready(function(){
	
});

app.requires.push("bw.paging");

app.controller('saleListCtl', function($scope, consts, is_login, locale, common, $filter) {
	$scope.is_login = is_login;
	$scope.pageRows = consts.SALE_LIST_ROWS;
	$scope.currentPage = page;
	$scope.totalCount = 0;
	$scope.sortBy = "DATADE";
	$scope.sale_outside_yn = (getParameter("sale_outside_yn"));
	
 	$scope.loadSaleList = function($page){

		//지난경매 결과 당일 자정까지 보여주기
		const today = new Date();
		$scope.today = $filter('date')(today, 'yyyyMMdd');
		window.location.hash = '#page' + $page;
		if(!$scope.sale_outside_yn){
 			$scope.sale_outside_yn = "N";
 		}
		
 		$scope.currentPage = $page;
<%-- 		setCookie('saleList', $page, 1);--%>

 		$d = {"baseParms":{"sale_kind_cd":"${SALE_KIND_CD}","status":"END", "find_word":$scope.findWord},
 				"actionList":[
 				{"actionID":"sale_list_count", "actionType":"select" , "tableName": "COUNT" ,"parmsList":[{"for_count":true,"sale_outside_yn": $scope.sale_outside_yn,}]},
 			    {"actionID":"sale_list_paging", "actionType":"select" , "tableName": "LIST" ,"parmsList":[{"from":0, "rows":$scope.pageRows, "sort_by":$scope.sortBy ,"sale_outside_yn": $scope.sale_outside_yn, }]},
 			    {"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]}
 			 ]};

 	   	$d["actionList"][1]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows);

 	   common.callActionSet($d, $s);
	}

 	var $s = function(data, status) {
 		if(data.tables.LIST.rows.length != 0){
 	   		$(".wrap_paging").show();	 					
 		} else { $(".wrap_paging").hide(); }
 		$scope.totalCount = data["tables"]["COUNT"]["rows"][0]["CNT"];
 	    $scope.saleList = data["tables"]["LIST"]["rows"];
 	    $scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
	};
	
	
	$scope.initSearchList = function(){
		$scope.findWord = null;
		$scope.loadSaleList(1);
	}
	
	
});
</script>
<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="saleListCtl" data-ng-init="loadSaleList(currentPage);">
		<!--<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>-->
		<div id="container">
			<div class="sub_menu_wrap menu06">
				<div class="sub_menu">
					<jsp:include page="../include/subMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div> 
			<!-- //sub_menu_wrap -->
	
			<div class="contents_wrap">
				<div class="contents m_top">
				    <div class="tit_h2 pd-top"> 
						<h2><spring:message code="label.auction.result" /></h2>    
					</div>
					<form  name="pageForm" method="get" ng-submit="loadSaleList(currentPage);">
						<fieldset>
							<legend>검색<!-- Search --></legend>
							<div class="wrap_search type03 web_only mt0">
								<div class="search_box">
									<div class="form">
										<label for=""><spring:message code="label.sale.title" /></label>
										<input type="text" name="searchName" ng-model="findWord" placeholder='<spring:message code="label.sale.search.placeholder" />'/>
										<span class="btn_style01 dark">
											<button type="button" ng-click="loadSaleList(1);"><spring:message code="label.query" /></button>
										</span>
									</div>
								</div>
							</div>
						</fieldset>
	
					<div class="tbl_top web_only mt0 t_tbl_top"><!-- 수정 -->
						<div class="left">
							<div class="wrap_paging">
								<paging page="currentPage"
										page-size="pageRows"
										total="totalCount"
										paging-action="loadSaleList(page)"
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
									<span class="tbl_label"><spring:message code="label.sale.list.summary" arguments='{{totalCount}}'/></span>
									<label for="" class="tbl_label bar02"><spring:message code="label.sort.by" /></label>
									<select path="orderType" class="selectbox" ng-model="sortBy" ng-init="sortBy='DATDE'">
										<option value="DATDE"><spring:message code="label.sort.by.latest" /></option>
										<option value="DATAS"><spring:message code="label.sort.by.oldest" /></option>
										<!-- <option value="TOTAS"><spring:message code="label.sort.by.price_low" /></option>
										<option value="TOTDE"><spring:message code="label.sort.by.price_high" /></option>
										<option value="WONAS"><spring:message code="label.sort.by.bid_rate_low" /></option>
										<option value="WONDE"><spring:message code="label.sort.by.bid_rate_high" /></option>-->
									</select>
									<span class="btn_style01 gray03">
										<button type="button" ng-click="loadSaleList(1);"><spring:message code="label.query2" /></button>
									</span>
									<span class="btn_style01 white02 icon02 btn_scrollbot">
										<button type="button"><spring:message code="label.move.bottom" /></button>
										<span class="ico down"></span>
									</span>
								</div>
							</div>
						</div>
					</div>
					</form>
					
					<div class="auction_list02" oncontextmenu="return false" ondragstart="return false" >
						<ul>
							<div ng-if="saleList < 1" class="noListbox"  style=""> 
								<p>{{locale == 'ko'? '검색결과가 없습니다.' : 'There is no List.'}}</p><br>
								<span class="btn_style01">
									<button ng-click="initSearchList();">{{locale == 'ko'? '전체 리스트 보기' : 'View All List'}}</button>
								</span>
							</div>
							<li ng-repeat="sale in saleList" ng-class="{first:$first || $index == 1}" ng-class-even="'even'">
								<div class="img" style="overflow: hidden;">
									<a href="#" onClick="return false;" style="cursor: default;">
										<img style="width:100%; height: auto; margin-left:0px;" 
											ng-src="<spring:eval expression="@configure['img.root.path']" />{{sale.SALE_IMG_NAME ? (sale.SALE_IMG_PATH + '/' + sale.SALE_IMG_NAME)  : (sale.LOT_IMG_NAME | imagePath : sale.LOT_IMG_PATH : true)}}" alt='{{slae.TITLE_JSON[locale]}}' />
									</a>
								</div>
								<div class="cont">
									<div class="title">
										<div class="tit"><span ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0">{{sale.SALE_TH | localeOrdinal}} </span>{{sale.TITLE_JSON[locale]}}</div>
										<div class="sub">
											<span>
											<!-- <span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1"> {{sale.FROM_DT | dateFormat}} ~ </span>{{sale.TO_DT | dateFormat}} -->
											<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1"> {{sale.FROM_DT | date:'(EEE) d MMM, yyyy h:mm a' : 'UTC+9'}} ~ </span>{{sale.TO_DT | date:'(EEE) d MMM, yyyy h:mm a' : 'UTC+9'}} KST
											<br />
											{{sale.PLACE_JSON[locale]}}</span>
										</div>
										<div ng-if="sale.IS_OLD_SALE === 'N'">
											<span class="btn_style01 white02" ng-if="custInfo.EMP_GB == 'Y' || ( is_login == 'true' && ((['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1) ||  (today <= (sale.TO_DT | date:'yyyyMMdd'))) )">
												<a ng-href="/saleDetail?view_id=${VIEW_ID}&sale_no={{sale.SALE_NO}}"><spring:message code="label.view.detail" /></a>
											</span>
										</div>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="wrap_paging">
						<paging page="currentPage"
								page-size="pageRows"
								total="totalCount"
								paging-action="loadSaleList(page)"
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
						<div class="right">
							<span class="btn_style01 icon02 mbtn btn_scrolltop">
								<button type="button"><spring:message code="label.move.top" /></button>
								<span class="ico up"></span>
							</span>
						</div>
					</div>
					<!-- <div id="contentContainer" class="ex_list_area nobanner rolling_box">
					</div>-->
					
					<jsp:include page="../include/bottom.jsp" flush="false" />
					
				</div>
			</div>
			
			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/img/img_past.png" alt="작품1" class="img_master" />	
						</li>
					</ul>
				</div>
			</div>-->
				
		</div>
	</div>
	<script type="text/javascript">
			$(document).ready(function(){
				$(".rolling_box").rollingFunc({
					interval:"4000",
					dulation:"3000",
					prevBtn:"btn_prev",
					nextBtn:"btn_next",
					//auto:true,
					isMain:true			// mainpage인 경우 배경 클래스 적용
				});
			});
	</script>
</div>
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
