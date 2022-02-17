<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- head.jsp Begin -->
<!DOCTYPE html>
<html lang="ko" ng-app="myApp">
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0" http-equiv="X-UA-Compatible" content="IE=Edge">     
<meta charset="UTF-8">
<title>서울옥션 환율 계산기</title>
	<link rel="apple-touch-icon-precomposed" sizes="57x57" href="/images/icon/favic/apple-touch-icon-57x57.png" />
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/icon/favic/apple-touch-icon-72x72.png" />
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/icon/favic/apple-touch-icon-114x114.png" />
	<link rel="apple-touch-icon-precomposed" sizes="120x120" href="/images/icon/favic/apple-touch-icon-120x120.png" />
	<link rel="apple-touch-icon-precomposed" sizes="152x152" href="/images/icon/favic/apple-touch-icon-152x152.png" />
	<link rel="icon" type="image/png" href="/images/icon/favic/favicon-32x32.png" sizes="32x32"/>
	<link rel="icon" type="image/png" href="/images/icon/favic/favicon-16x16.png" sizes="16x16"/>
	<meta name="application-name" content="SeoulAuction" /> 

    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="/images/icon/favic/apple-touch-icon-57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/icon/favic/apple-touch-icon-72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/icon/favic/apple-touch-icon-114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="120x120" href="/images/icon/favic/apple-touch-icon-120x120.png" />
    <link rel="apple-touch-icon-precomposed" sizes="152x152" href="/images/icon/favic/apple-touch-icon-152x152.png" />
    <link rel="icon" type="image/png" href="/images/icon/favic/favicon-32x32.png" sizes="32x32"/>
    <link rel="icon" type="image/png" href="/images/icon/favic/favicon-16x16.png" sizes="16x16"/>
    <meta name="application-name" content="SeoulAuction" />

    <link href="<c:url value="/css/old/common.css?ver=20211104" />" rel="stylesheet">  
    <link href="<c:url value="/css/sa.common.2.0.css?ver=20210901" />" rel="stylesheet">  
    <link href="<c:url value="/css/sa.common.2.1.css?ver=20211013" />" rel="stylesheet"> 
    <link href="<c:url value="/css/old/onepcssgrid.css" />" rel="stylesheet"> 

	<script type="text/javascript" src="/js/angular/angular.min.js"></script>
	<script src="/js/angular/angular-sanitize.js"></script>
	<script type="text/javascript" src="<c:url value="/js/angular/angular-bind-html-compile.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/angular/app.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/common.js" />"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.js" ></script>
	<script type="text/javascript" src="/js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="/js/jquery.panzoom.min.js"></script>
	<script type="text/javascript" src="/js/jquery.slides.min.js"></script>
	<script type="text/javascript" src="/js/jquery.placeholder.min.js"></script>
	<script type="text/javascript" src="/js/jquery.nicefileinput.min.js"></script>
	<script type="text/javascript" src="/js/jquery.mousewheel.min.js"></script>
	<script type="text/javascript" src="/js/jquery.mobile-events.js"></script>
	<script type="text/javascript" src="/js/iscroll.js"></script>
	<script type="text/javascript" src="/js/old/ui.js"></script>
	<script type="text/javascript" src="/js/old/frontCommon.js"></script> 
	 
</head>
<script>
	app.value('locale', 'ko');
	app.value('is_login', 'false');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN
	
	app.controller('currencyPopCtl', function($scope, common) {
		
		$scope.jsonCurrency = {};
		$scope.existFileDate = "";
		
		$scope.init = function(){
			$scope.today = $scope.getToday();
			$scope.yesterday = $scope.getPast();

			if($scope.isFileExist($scope.today)){
				$scope.existFileDate = $scope.today;
			}else if($scope.isFileExist($scope.yesterday)){
				$scope.existFileDate = $scope.yesterday;
			}else{
				console.log("error");
			}


			$.ajaxSetup({async: false });
			$.getJSON( "/js/currency/"+$scope.existFileDate+".json", function( data ) {
				
				$scope.jsonCurrency = data;
				$scope.krwBase = $scope.jsonCurrency["KRW"]
				$scope.usdBase = $scope.jsonCurrency["USD"];
				$scope.hkdBase = $scope.jsonCurrency["HKD"];
				$scope.cnhBase = $scope.jsonCurrency["CNH"];
				$scope.jpyBase = $scope.jsonCurrency["JPY"];
				$scope.eurBase = $scope.jsonCurrency["EUR"];
				
				$scope.dataResult = "LAST UPDATE : " + $scope.existFileDate + " KST (평일 오전 9시 업데이트)";
				
			}).fail(function() {
				$scope.dataResult = "데이터 호출 실패";
		 	});
			
		}
		
		$scope.vCommaKRW = function() { 
			var inNum = $scope.delComma($scope.krwInput);

			$scope.k_calUSD = (inNum/$scope.usdBase).toFixed(0);
			$scope.k_calHKD = (inNum/$scope.hkdBase).toFixed(0);
			$scope.k_calCNH = (inNum/$scope.cnhBase).toFixed(0);
			$scope.k_calJPY = (inNum/$scope.jpyBase).toFixed(0);
			$scope.k_calEUR = (inNum/$scope.eurBase).toFixed(0);
		}  

		$scope.vCommaHKD = function() { 
			var inNum = $scope.delComma($scope.hkdInput) * $scope.hkdBase;

			$scope.h_calKRW = (inNum).toFixed(0);
			$scope.h_calUSD = (inNum/$scope.usdBase).toFixed(0);
			$scope.h_calCNH = (inNum/$scope.cnhBase).toFixed(0);
			$scope.h_calJPY = (inNum/$scope.jpyBase).toFixed(0);
			$scope.h_calEUR = (inNum/$scope.eurBase).toFixed(0);
		}  
		
		$scope.isFileExist = function(day){
		    var isExist = false;
		    $.ajaxSetup({async: false });
			$.ajax({
			    url:'/js/currency/'+day+".json",
			    type:'HEAD',
			    success: function()
			    {
			    	console.log("file exists");
			    	isExist = true;
			    },
			    error: function()
			    {
			    	console.log("file not exists");
			    	isExist = false;
			    }
			});
			
			return isExist;
		}
		
		$scope.getToday = function(){
			var today = new Date();

			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);

			var dateString = year + '-' + month  + '-' + day;
			
			return dateString;
		}
		
		$scope.getPast = function(how){
			var now = new Date();	// 현재 날짜 및 시간
			var yesterday = new Date(now.setDate(now.getDate() - 1));	// 어제
			
			var year = yesterday.getFullYear();
			var month = ('0' + (yesterday.getMonth() + 1)).slice(-2);
			var day = ('0' + yesterday.getDate()).slice(-2);
			
			var dateString = year + '-' + month  + '-' + day;
			
			return dateString;
		}
		
		$scope.delComma = function(str) { 
			str = "" + str.replace(/,/gi,''); // 콤마 제거 
			str = str.replace(/(^\s*)|(\s*$)/g, ""); // trim 
			return (new Number(str)); 
		} 
		
	});
	
</script>
<body>
    <div class="pop_wrap" ng-controller="currencyPopCtl" data-ng-init="init()">
        <div class="title">
            <h2>환율 계산기</h2> 
        </div>  
        <!--main -->
        <div class="cont">
            <h3>{{dataResult}}</h3>
            <br/>
            <p>
            	USD : <span ng-bind="usdBase"></span> │ 
            	HKD : <span ng-bind="hkdBase"></span> │ 
            	CNH : <span ng-bind="cnhBase"></span> │ 
            	JPY : <span ng-bind="jpyBase"></span> │ 
            	EUR : <span ng-bind="eurBase"></span>
            </p>
            <div class="onepcssgrid-1200">
                 <div class="onerow"></div><!--clear-->   
                 <div class="col6" style="padding-bottom:40px;">
	                  <h2 style="padding-bottom:20px; font-size:28px; line-height:33px;">[국내경매]</h2>  
	                  <div style="padding-bottom:20px; font-size:22px; line-height:30px;">
		                <p style="padding-bottom:20px;">
						<label style="color:#f44336">KRW: </label>
							<input type="text" placeholder="KRW" id="krwInput" ng-model="krwInput" onkeyup="moneyFormat(event, this);" ng-change="vCommaKRW();" style="padding:5px;"> 원
						</p>
						<p>USD: <span id="K_USD">{{ k_calUSD | number : 0 }}</span></p>
						<p>HKD: <span id="K_HKD">{{ k_calHKD | number : 0 }}</span></p>
						<p>CNH: <span id="K_CNH">{{ k_calCNH | number : 0 }}</span></p>
						<p>JPY: <span id="K_JPY">{{ k_calJPY | number : 0 }}</span></p>
						<p>EUR: <span id="K_EUR">{{ k_calEUR | number : 0 }}</span></p>
					 </div>
         		 </div><!--col6-->
         
         
             	<div class="col6 last">
					<h2 style="padding-bottom:20px; font-size:28px; line-height:33px;">[홍콩경매]</h2>  
					<div style="padding-bottom:20px; font-size:22px; line-height:30px;">
						<p style="padding-bottom:20px;">
						<label style="color:#f44336">HKD: </label>
							<input type="text" placeholder="HKD" id="hkdInput" ng-model="hkdInput" onkeyup="moneyFormat(event, this)" ng-change="vCommaHKD(this)" style="padding:5px;"> 달러
						</p>
						<p>KRW: <span id="H_KRW">{{ h_calKRW | number : 0 }}</span></p>
						<p>USD: <span id="H_USD">{{ h_calUSD | number : 0 }}</span></p>
						<p>CNH: <span id="H_CNH">{{ h_calCNH | number : 0 }}</span></p>
						<p>JPY: <span id="H_JPY">{{ h_calJPY | number : 0 }}</span></p>
						<p>EUR: <span id="H_EUR">{{ h_calEUR | number : 0 }}</span></p>		
					</div>
            	</div> <!--col6-->


             	   <div class="onerow"></div><!--clear-->
  
                    
            </div> <!--onepcssgrid-1200-->
         </div> <!--cont-->
     </div> <!--liveAuctionCtl-->
      
     <!--footer-->
     <div style="background-color:#e4e4e4; padding:10px; text-align:left;">	 
          <div class="web_only" align="center">
              <p style="color: #000; font-size:11px; padding-top:20px; padding-bottom:20px; line-height:18px;">* 환율정보는 경매 참고용입니다. *<br/>경매 당일 환율은 입금시 환율과 달라 질 수 있습니다.<br/><br/>
             * 서울외국환중개의 공시를 참고합니다. *<br/>http://www.smbs.biz/ExRate/TodayExRate.jsp<br/><br/>
              * 서울외국환중개홈페이지상 조회하여 출력한 환율 정보가 시스템 장애등으로 잘못 출력된 경우 서울외국환중개가 책임지지 않습니다. 이에 담당자분들게서는 계산시 참고 바랍니다.<br/><br/>IT팀에서는 경매당일 환율정보를 공시에 따라 프로그램에 제공합니다. 전광판과 연결된 것은 아닙니다.</p>
          </div><!--web_only-->
          <div class="m_only" align="center">
              <p style="color:#000; font-size:13px; padding-top:20px; padding-bottom:20px; line-height:18px;">* 환율정보는 경매 참고용입니다. *<br/>경매 당일 환율은 입금시 환율과 달라 질 수 있습니다.<br/><br/>* 서울외국환중개의 공시를 참고합니다. *<br/>http://www.smbs.biz/ExRate/TodayExRate.jsp<br/><br/>* 서울외국환중개홈페이지상 조회하여 출력한 환율 정보가 시스템 장애등으로 잘못 출력된 경우 서울외국환중개가 책임지지 않습니다. 이에 담당자분들게서는 계산시 참고 바랍니다.<br/><br/>IT팀에서는 경매당일 환율정보를 공시에 따라 프로그램에 제공합니다. 전광판과 연결된 것은 아닙니다.</p>
          </div><!--m_only-->
     </div><!--footer-->
            
  </div> <!--pop_wrap-->
</body>
</html>