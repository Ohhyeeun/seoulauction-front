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

	app.value('locale', 'ko');
	app.requires.push("bw.paging");
	app.controller('asPsListCtl', function($scope, consts, common) {

		$scope.pageRows = 20; 
		$scope.reqRowCnt = 20;
		$scope.currentPage = 1;
		$scope.totalCount = 0;
		

		$scope.loadAsList = function($page) {
			$scope.currentPage = $page;
		$d = {
				"baseParms" : {	"AS_SALE_NO" : $scope.artist },
				"actionList" : [ 
					{"actionID" : "as_list_paging","actionType" : "select","tableName" : "AS_LIST","parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt)}]}, 
					{"actionID":"as_list_count", "actionType":"select" , "tableName": "AS_CNT" ,"parmsList":[{"for_count":true}]},
					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
			]};

			$d["actionList"][0]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 
			common.callActionSet($d, $s);
		}

		var $s = function(data, status) {
			$scope.asList = data["tables"]["AS_LIST"]["rows"];
			$scope.totalCount = data["tables"]["AS_CNT"]["rows"][0]["CNT"];
			$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
			console.log($scope.asList);
		};
		
		
	});
</script>
 
<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition"> 
<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap"> 
		<div id="container" ng-controller="asPsListCtl" data-ng-init="loadAsList(1)">
			<div class="sub_menu_wrap menu01">
				<div class="sub_menu">
					<jsp:include page="../contents/include/PS_Submenu.jsp" flush="false"/>  
				</div>
			</div> 
            
			<div class="contents_wrap">  
				<div class="contents private_pd">   
					<div class="type02" style="min-height: auto;"> 
						<div class="title">    
							<div class="private_subimg">  
								<c:if test="${locale == 'ko'}">  
									<img src="/images/img/ps/pb_sumko.jpg" alt="서울옥션 프라이빗 세일 이미지" style="max-width: 100%;"> 
								</c:if>
								<c:if test="${locale != 'ko'}">   	
									<img src="/images/img/ps/pb_sumen.jpg" alt="seoulauction private sale image" style="max-width: 100%;">
								</c:if>  
							</div>
						</div> 
					</div> <!--ex_title type02-->  
					<div class="auction_h_list private_auction_list" style="z-index:8; background-color:#fff">
						<ul id="auctionList" >         
							<li ng-repeat="asList in asList">    
								<jsp:include page="inc_lotList_Grid_Private.jsp" flush="false"/>
							</li>  
						</ul>
					</div>    
				</div><!-- //웹용 --> 
			</div>
		</div><!-- //container -->	
	</div><!-- //container_wrap -->
</div> 

<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
