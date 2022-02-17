<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<link href="/css/angular/ng-animation.css" rel="stylesheet">
<link href="/css/angular/ngDialog.min.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">

<style type="text/css">
   @media print {
      .noprint { display: none;	                }
    }
	.page_body {

 margin: 0;

 padding: 0;
 background:#eee;

}

* {

 box-sizing: border-box;

 -moz-box-sizing: border-box;

}

.page {

 width: 21cm;

 min-height: 29.7cm;

 padding:1.2cm;  

 margin: 0 auto;

 background:#fff;

}

.subpage {

 background:#fff;   

 height: 257mm;

}




@page {

 size: A4;

 margin: 0;

}

@media print {

 .page_body {

  width: 210mm;

  height: 297mm;

 }

 .page {

  margin: 0;

  border: initial;

  width: initial;

  min-height: initial;

  box-shadow: initial;

  background: initial;

  page-break-after: always;

 }

}


  </style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<!-- <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-animate.min.js"></script> -->
<script type="text/javascript" src="/js/angular/angular-animate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script src="https://code.angularjs.org/1.4.9/angular.js"></script>
  
<script>
app.requires.push.apply(app.requires, ["ngAnimate", "ngDialog"]);

app.controller('lotDetailCtl', function($scope, consts, common, bid, $interval, is_login, locale, $filter) {
	$scope.db_now = null;
	$scope.is_login = is_login;
	$scope.locale = locale;
	$scope.sale_no = ${SALE_NO};
	$scope.sale_status = "READY";
	$scope.img_idx = 0;
	
    $scope.loadLotDetail = function(){
		$d = {"baseParms":{"sale_no":$scope.sale_no},
 				"actionList":[
 				{"actionID":"saleLot_result", "actionType":"select" , "tableName": "SALE"}
 			 ]};

 	   	common.callActionSet($d, $sLot, null, null);
	}

 	var $sLot = function(data, status) { 
 		$scope.sale = data["tables"]["SALE"]["rows"][0];
 		$scope.saleResult = data["tables"]["SALE"]["rows"];
 		$scope.db_now = $scope.sale.DB_NOW;
 		
 		var S_DB_NOW = $filter('date')($scope.db_now, 'yyyyMMddHHmmss');
 		var FROM_DT = $filter('date')($scope.sale.FROM_DT, 'yyyyMMddHHmmss');
 		var TO_DT = $filter('date')($scope.sale.TO_DT, 'yyyyMMddHHmmss');
 		var SALE_TO_DT = $filter('date')($scope.sale.TO_DT, 'yyyyMMdd');
 		var DB_NOW_DT = $filter('date')($scope.db_now, 'yyyyMMdd');
 		
 		if(FROM_DT > S_DB_NOW && TO_DT > S_DB_NOW){
 			$scope.sale_status = "READY";
 		}
 		else if((FROM_DT <= S_DB_NOW) && 
			(TO_DT >= S_DB_NOW)){
 			$scope.sale_status = "ING";
 			if(['online','online_zb'].indexOf($scope.sale.SALE_KIND_CD) > -1 && !$scope.now_timer_start){
 				$interval(function(){$scope.db_now = moment($scope.db_now).add(1, 'seconds');}, 1000);
 			} 
 		}
 		else if(TO_DT < S_DB_NOW){
 			$scope.sale_status = "END";
 		}
 		
 	    $scope.base_currency = $scope.sale.CURR_CD;
 	    $scope.base_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKT" : "KST");
 		$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
 		$scope.sub_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KST" : "HKT");

 		// COLUMN ARRAY 정의
 		var cols = [];
 		var saleR = [];
	
 		// 숫자 타입에서 쓸 수 있도록 format() 함수 추가
 		Number.prototype.format = function(){
 		    if(this==0) return 0;
 		 
 		    var reg = /(^[+-]?\d+)(\d{3})/;
 		    var n = (this + '');
 		 
 		    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
 		 
 		    return n;
 		};
 		 
 		// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
 		String.prototype.format = function(){
 		    var num = parseFloat(this);
 		    if( isNaN(num) ) return "0";
 		 
 		    return num.format();
 		};
 			
 		var k = 0;
 		for (var i=0; i< 35; i++){
			if (i < $scope.sale.COLCOUNT){
				//cols.push('LOT '+'    '+$scope.sale.CURR_CD);
				cols.push({'LOT':'LOT', 'PRICE':$scope.sale.CURR_CD});
			}
			
			var rowData = [];
			
			for (var j=0; j < $scope.sale.COLCOUNT; j++){
				
				k = (i + j*35) ;
				
				if ( k >= $scope.sale.LOT_COUNT){					
					break;
				}
				//rowData.push($scope.saleResult[k].LOT_NO + '     ' + $scope.saleResult[k].LAST_PRICE.format());
				rowData.push({'LOT':$scope.saleResult[k].LOT_NO, 'PRICE':$scope.saleResult[k].LAST_PRICE.format()});
			}			
			saleR.push(rowData)
 		}
 		
 		$scope.cols = cols;
 		$scope.saleR = saleR;
 		
 		console.log("=======>>>>> end");
 	};
});

</script>
<script type="text/javascript" src="/js/bid.js"></script>



<body class="page_body"> 
<div class="page">
	<c:set var="locale" scope="session" value="${pageContext.response.locale}" />
	<c:set var="is_korean" scope="session" value="${locale eq 'ko'}" />
	<c:set var="is_login" scope="session" value="false" />
	<sec:authorize access="hasRole('ROLE_FRONT_USER')">
		<c:set var="is_login" scope="session" value="true" />
	</sec:authorize>
	<c:set var="is_login" scope="session" value="${pageContext.request.userPrincipal.name != null}" />
	
	<script type="text/javascript">
	app.value('locale', '${locale}');
	app.value('is_login', '${is_login}');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN
	
	/********************/
	$(document).ready(function(){
		
		url = document.location.pathname;
	
		var winWidth = $(window).width();
		if(winWidth > 1024) {
			type = "web";
		}
		else if(winWidth <= 1024 && winWidth >= 768) {
			type = "tablet";
		}
		else if(winWidth < 768) {
			type = "phone";
		}
		
		showTopLayer();
		//mobileGnb();
		
	});
	
	function showTopLayer() {
		$("#kanggTopLayer").show();
		
		src960 = $("#topLayerImage").attr("src");
		src768 = $("#topLayerImage").attr("src");
		src320 = $("#topLayerImage").attr("src");
		
		var winWidth = $(window).width();
		if(winWidth > 1024){
			$('.curtain_wrap img').attr('src', src960);
			$('.curtain_wrap').removeClass('response01');
			$('.curtain_wrap').removeClass('response02');
		} else if(winWidth < 768){
			$('.curtain_wrap img').attr('src', src320);
			$('.curtain_wrap').removeClass('response02');
			$('.curtain_wrap').addClass('response01');
		} else {
			$('.curtain_wrap img').attr('src', src768);
			$('.curtain_wrap').removeClass('response01');
			$('.curtain_wrap').addClass('response02');
		}
	}
	
	</script>

	<div ng-controller="lotDetailCtl" data-ng-init="loadLotDetail();">
		
		<div>
			<div class="subpage">
				<div style=" float:right">					 
                     <span  class="noprint"><a href="javascript:window.print();"><img src="https://www.seoulauction.com/images/icon/print.png" border="0" style="width:88px; height:auto" alt="print"></a></span>                 	
				</div> 
                <div><img src="https://www.seoulauction.com/images/icon/print_logo.png" border="0" style="width:200px;" alt="SeoulAuction"></div>
				<div style="padding-top:10px;"> 
                    <div>
                       <div style="font-size:18px;line-height:28px; font-weight:600;">
                       		<span ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0">{{sale.SALE_TH}}{{sale.SALE_TH_DESC}} </span>{{sale.TITLE_JSON[locale]}}
                       	</div>
                        <div style="font-size:12px; color:#999; line-height:24px;">
                            Auction :&nbsp; 
                            {{sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'yyyy.MM.dd' : 'UTC+9' | lowercase}}({{getWeek(sale.TO_DT)}}) {{sale.TO_DT | addHours : (base_currency == 'HKD' ? -1 : 0) | date:'h:mm a' : 'UTC+9'}} {{base_timezone}}
                            ({{sale.TO_DT | addHours : (base_currency == 'HKD' ? 0 : -1) | date:'h:mm a' : 'UTC+9' | lowercase}} {{sub_timezone}})
                            &nbsp; / &nbsp; <span class="txt" bind-html-compile="sale.PLACE_JSON[locale]"></span>
                            </div>
                    </div> 
                    
				</div> 
				
				<div style="padding-top:10px;">
                   <div>
                      <div style="font-size:14px; color:#666; line-height:24px;">
                         Sale Total Hammer Price :&nbsp; 
                         {{sale.TOTAL_PRICE | number:0}} {{sale.CURR_CD}}
                      </div>
                    </div> 
				</div> 
				
				<div style="padding-top:10px;">
                   <div>
                      <div style="font-size:12px; color:#999; line-height:24px;">
                         AUCTION RESULTS 
                      </div>
                      <div style="font-size:11px; color:#999; line-height:20px;">
                         The following lots were sold at the prices stated. Lot number which are omitted represent items which were withdrawn, passed or unslod as of the publication
                          of this list. Prices not include the Buyer's Premium. They do not reflect any Value Added Tax(VAT) or (Australian) Goods and Services Tax(GST).
                      </div>
                    </div> 
				</div> 
			
				<div style="padding-top:15px; font-size:11px; line-height:22px;">
					<table class="table table-bordered">
						<tr align="left">
							<!--  <th ng-repeat="col in cols track by $index| limitTo: sale.COLCOUNT">{{col}}</th>   -->
							<th ng-repeat="(key, value) in cols track by $index| limitTo: sale.COLCOUNT" >
								{{value.LOT}}     {{value.PRICE}}</th>
						</tr>
						<tr>
							<td  colspan="{{sale.COLCOUNT}}" height=2 bgcolor=#000000 ></td>
						</tr>
						<tr ng-repeat="row in saleR">
							<!--  <td ng-repeat="item in row track by $index| limitTo: sale.COLCOUNT">{{item}}</td> -->
							<td ng-repeat="(key, value) in row track by $index| limitTo: sale.COLCOUNT" >
								<b>{{value.LOT}}</b>     {{value.PRICE}}							
							</td> 
						</tr>
					</table>
				</div> 
			</div>
		</div>

					
	</div>



</body>
</html>
