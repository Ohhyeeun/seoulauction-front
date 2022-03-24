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

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="UTF-8">
<title>서울옥션</title>
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">    
    <meta name="description" content="미술품,경매,작품,미술,근현대,고미술,와인,보석,구매,판매,위탁">
    <meta name="keywords" content="미술품,경매,작품,미술,근현대,고미술,와인,보석,구매,판매,위탁,경매회사,갤러리,케이옥션,K옥션,seoulauction,auction">
    <meta name="author" content="SeoulAuction">
    <meta name="Copyright" content="SeoulAuction" />
    <meta name="Claasification" content="회사소개, 미술품소개, 경매, 구매, 위탁" />       
    <meta property="og:type" content="website"> 
    <meta property="og:url" content="https://www.seoulauction.com">
    <meta property="og:title" content="SeoulAuction">
    <meta property="og:description" content="미술품,경매,작품,미술,근현대,고미술,와인,보석,구매,판매,위탁">
    <meta property="og:image" content="https://www.seoulauction.com/nas_img/front/homepage/201508122329463497773394954126.jpg"/>        
    <meta property="al:web:url" content="https://www.seoulauction.com">

    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="/images/icon/favic/apple-touch-icon-57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/icon/favic/apple-touch-icon-72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/icon/favic/apple-touch-icon-114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="120x120" href="/images/icon/favic/apple-touch-icon-120x120.png" />
    <link rel="apple-touch-icon-precomposed" sizes="152x152" href="/images/icon/favic/apple-touch-icon-152x152.png" />
    <link rel="icon" type="image/png" href="/images/icon/favic/favicon-32x32.png" sizes="32x32"/>
    <link rel="icon" type="image/png" href="/images/icon/favic/favicon-16x16.png" sizes="16x16"/>
    <meta name="application-name" content="SeoulAuction" />
 
    <link href="<c:url value="/css/old/common.css" />" rel="stylesheet">  
     <link href="<c:url value="/css/old/onepcssgrid_live.css" />" rel="stylesheet"> 
    <link href="<c:url value="/css/sa.common.2.0.css" />" rel="stylesheet">
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

<%-- YDH 추가 시작--%>
<script type="text/javascript" src="/js/angular/paging.js"></script>

<script>
	app.value('locale', 'ko');
	app.value('is_login', 'false');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN
	
	$(document).ready(function(){
		$scope.cnt = 0; // 네비게이션 실행여부 확인(2018.04.25)
	});
	
	app.controller('liveAuctionCtl', function($scope, consts, common, $interval) {

	 	$scope.loadLiveAuction = function(){

	 		$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
	 				"actionList":[
 					{"actionID":"liveSaleInfo", "actionType":"select" , "tableName": "SALE"},
 					{"actionID":"liveLotInfo", "actionType":"select" , "tableName": "LOT"},
 					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
 					{"actionID":"offBidList", "actionType":"select", "tableName":"BID_OFF_LIST"}, // Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
 					{"actionID":"liveLotNaviList", "actionType":"select", "tableName":"LOT_NAVI", "parmsList":[{}]}, // navi 최신화. Edit모드에서만 실행할 것
	 			 ]};
	 	   	
	 	   common.callActionSet($d, $s);
		}
	 		
	 	var $s = function(data, status) { 
	 		$scope.sale = data["tables"]["SALE"]["rows"][0];
	 		$scope.lot = data["tables"]["LOT"]["rows"][0];
	 		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
	 		$scope.offBidList = data["tables"]["BID_OFF_LIST"]["rows"];// Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
	 		$scope.lot_navi = data["tables"]["LOT_NAVI"]["rows"];// Live 진행 LOT번호 5건 호출 추가(2018.04.19 YDH). Edit모드에서만 실행할 것
	 		
	 		$scope.base_currency = $scope.sale.CURR_CD;
	 	    $scope.base_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKT" : "KST");;
	 		$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
	 		$scope.sub_timezone = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "KST" : "HKT");

	 		$scope.live_lot_no = $scope.lot.LOT_NO;  //현재 진행중인 LOT 번호
	 		$scope.max_lot_no = $scope.sale.MAX_LOT_NO;  // LOT 번호 MAX 번호
	 		
			$scope.sale_no = $scope.sale.SALE_NO;
			$scope.lot_no = $scope.lot.LOT_NO;
			
			// 2018.05.08 호가 설정. Lot 동기화할경우만 반영
			var price_len = $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency].toString().length; // 
			
			if ($scope.bid_price_input_grow1 == "" || $scope.bid_price_input_grow1 == null){
				$scope.bid_price_input_grow1 = $scope.commaSetting(1 * Math.pow(10, parseInt(price_len)-2));	
			}
			if ($scope.bid_price_input_grow2 == "" || $scope.bid_price_input_grow2 == null){
				$scope.bid_price_input_grow2 = $scope.commaSetting(2 * Math.pow(10, parseInt(price_len)-2));	
			}
			if ($scope.bid_price_input_grow3 == "" || $scope.bid_price_input_grow3 == null){
				$scope.bid_price_input_grow3 = $scope.commaSetting(3 * Math.pow(10, parseInt(price_len)-2));	
			}
			if ($scope.bid_price_input_grow4 == "" || $scope.bid_price_input_grow4 == null){
				$scope.bid_price_input_grow4 = $scope.commaSetting(5 * Math.pow(10, parseInt(price_len)-2));				
			}
			if ($scope.bid_price_input_grow5 == "" || $scope.bid_price_input_grow5 == null){
				$scope.bid_price_input_grow5 = $scope.commaSetting($scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency]);	
			}
			
			// 최초 오픈된 경우 실행. 최초 오픈시에는 mid_lot_no는 NULL!
	 		if($scope.mid_lot_no == null || $scope.mid_lot_no == 'undefined')
	 		{
	 			$scope.naviMoveInit($scope.live_lot_no);
	 		}
	 		// 네비게이션 버튼 실행한 적이 없는 경우에만 네비게이션 리스트도 동기화. (2018.04.25)
	 		if ($scope.cnt == 0 && (($scope.mid_lot_no+2) < $scope.live_lot_no ||($scope.mid_lot_no-2) > $scope.live_lot_no)){
	 			$scope.naviMoveInit($scope.live_lot_no);
	 		}
		}
		
		// Live 진행 LOT번호 설정 로직 추가(2018.04.14 YDH)
		$scope.liveLotSave = function($input) {		
			var $d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no}, 
					"actionList":[
					{"actionID":"modLiveLot", "actionType":"update", "tableName":"LIVE_LOT", "parmsList":[{}]}
					]};
			common.callActionSet($d, function(data, status) {
				// $scope.bid_price_input = "";
				// $scope.bid_price = "";
				$scope.bid_price_input_start = "";
				$scope.price_len = "";
				
				$scope.bid_price_input_grow1 = "";
				$scope.bid_price_input_grow2 = "";
				$scope.bid_price_input_grow3 = "";
				$scope.bid_price_input_grow4 = "";
				$scope.bid_price_input_grow5 = "";

				$scope.loadLiveAuction();				
			})
		};
		// Live 진행 LOT번호 응찰금액 로직 추가(2018.04.17 YDH), bid_price는 콤마(,)제거
		$scope.liveLotBidPriceSave = function($input) {		
			var $d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "bid_price":$scope.bid_price_input_start.replace(/[^\d]+/g,''), "bid_kind_cd":$input}, 
					"actionList":[
					{"actionID":"addOffBidPrice", "actionType":"insert", "tableName":"BID_OFFLINE", "parmsList":[{}]}
					]};
			common.callActionSet($d, function(data, status) {
				$scope.loadLiveAuction();
			})
		};
		
		// Live 하단 네비게이션 리스트
		$scope.liveLotNaviList = function($input){
			var $d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$input}, 
				"actionList":[
				{"actionID":"liveLotNaviList", "actionType":"select", "tableName":"LOT_NAVI", "parmsList":[{}]}
				]};
			common.callActionSet($d, function(data, status) {
				$scope.lot_navi = data["tables"]["LOT_NAVI"]["rows"];// Live 진행 LOT번호 5건 호출 추가(2018.04.19 YDH)
				$scope.mid_lot_navi = data["tables"]["LOT_NAVI"]["rows"][0]; // Live 진행 MID_LOT_NO 호출 추가(2018.04.19 YDH)
				
				$scope.mid_lot_no = $scope.mid_lot_navi.MID_LOT_NO;
				
				$scope.loadLiveAuction();
			})
		};
		
		$scope.naviMove = function($input){
			$scope.cnt = $scope.cnt + 1; //네비게이션 실행한 Count 누적
			
			if($scope.mid_lot_no == null || $scope.mid_lot_no == 'undefined'){
				if($scope.live_lot_no < 3){
	 				$scope.live_lot_no = 3;
				}
				$scope.mid_lot_no = $scope.live_lot_no;
			} ;

			$scope.mid_lot_no = $scope.mid_lot_no + $input;
			
			// lot_no가 3이하일경우 3로 설정, 최대 lot_no Over일 경우 최대lot_no-2로 설정. 기본 5건 보여주기위해서 처리
			if($scope.mid_lot_no < 3)
			{
				$scope.mid_lot_no = 3;
			} else if ($scope.mid_lot_no > $scope.max_lot_no-2)
			{
				$scope.mid_lot_no = $scope.max_lot_no-2;
			}
			
			$scope.liveLotNaviList($scope.mid_lot_no);
		};
		
		$scope.naviMoveInit = function($input){
			$scope.cnt = 0; //네비게이션 실행 Count 초기화
			
			// lot_no가 3이하일경우 3로 설정, 최대 lot_no Over일 경우 최대lot_no-2로 설정. 기본 5건 보여주기위해서 처리
			$scope.mid_lot_no = $input;
			
			if($scope.mid_lot_no < 3)
			{
				$scope.mid_lot_no = 3;
			} else if ($scope.mid_lot_no > $scope.max_lot_no-2)
			{
				$scope.mid_lot_no = $scope.max_lot_no-2;
			}
			
			$scope.liveLotNaviList($scope.mid_lot_no);
		};
		
		$scope.liveLotBidPriceInputPlus = function($input){
			if ($scope.bid_price_input_start == null || $scope.bid_price_input_start == ""){
				$scope.current_bid_price = 0;
			} else {
				$scope.current_bid_price = $scope.bid_price_input_start.replace(/[^\d]+/g,'');
			}
			
			var price_grow = parseInt($scope.current_bid_price) + (parseInt($input.replace(/[^\d]+/g,''))*1);

			$scope.bid_price_input_start = $scope.commaSetting(price_grow);

		};
		
		$scope.liveLotBidPriceInputMinus = function($input){
			if ($scope.bid_price_input_start == null){
				$scope.current_bid_price = 0;
			} else {
				$scope.current_bid_price = $scope.bid_price_input_start.replace(/[^\d]+/g,'');
			}
			
			var price_grow = parseInt($scope.current_bid_price) + (parseInt($input.replace(/[^\d]+/g,''))*-1);

			$scope.bid_price_input_start = $scope.commaSetting(price_grow);
		};
		
		// Lot Refresh : 3초단위, Navi Refresh : 1분단위
		//$interval(function(){$scope.loadLiveAuction();},3000);
		//$interval(function(){$scope.naviMove();},30000); //네비게이션 동기화는 버튼 클릭시만 진행
		
		$scope.commaSetting = function(inNum){
			// 콤마(,)표시
			//var inNum = $input;
			var rgx2 = /(\d+)(\d{3})/; 
			var outNum;

			outNum = inNum.toString();
			
			while (rgx2.test(outNum)) {
			   outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
			}
			
			return outNum;
		}
	});
</script>

<script>
	//[] <--문자 범위 [^] <--부정 [0-9] <-- 숫자  
	//[0-9] => \d , [^0-9] => \D
	var rgx1 = /\D/g;  // /[^0-9]/g 와 같은 표현
	var rgx2 = /(\d+)(\d{3})/; 
	
	function getNumber(obj){
	   var num01;
	   var num02;
	   num01 = obj.value;
	   num02 = num01.replace(rgx1,"");
	   num01 = setComma(num02);
	   obj.value =  num01;
	
	}
	
	function setComma(inNum){	   
	   var outNum;
	   outNum = inNum; 
	   while (rgx2.test(outNum)) {
	        outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
	    }
	   return outNum;
	
	}
</script>

<body>
    
    <div class="pop_wrap">
        <div class="title">
                <h2>Seoul Auction LIVE</h2> 
        </div>
        
        <div  ng-controller="liveAuctionCtl" data-ng-init="loadLiveAuction()">
        
            <!--로그인 & 직원구분 & 특정 login_id 확인     ng-if="is_login && custInfo.LOGIN_ID == 'hajenuri'" -->
            <div style="background-color:#e4e4e4; padding:10px; text-align:left;">	 
                <p style="padding-top:5px; padding-bottom:5px; display:table;">
                   <font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">경매번호</font>
                   <input type="text" ng-model="sale_no" id="saleNumber" name="saleNumber" style="width:35px;"> 
                   
                   <font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">Lot</font><input type="text" ng-model="lot_no" id="lotNumber" name="lotNumber" style="width:35px;"/> 
                   <span class="btn_style01 green02"><button type="button" ng-click="liveLotSave();">LOT동기화</button></span>
                   <font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">시작가</font>
                   	<input type="text" ng-model="bid_price_input_grow5" id="bidPriceInputGrow5" name="bidPriceInputGrow5" onkeyup="getNumber(this)" style="width:100px;"/>
                   	<span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInputMinus(bid_price_input_grow5);">-</button></span>
                   	<span class="btn_style01 yellow"><button type="button" ng-click="liveLotBidPriceInputPlus(bid_price_input_grow5);">+</button></span>
                </p>
             <!--    <p style="padding-top:5px; padding-bottom:5px; display:table;">
                   <font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">응찰금액</font>
                   <input type="text" ng-model="bid_price_input" id="bidPriceInput" name="bidPriceInput"/>
                   <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInput(10000);">만</button></span>
                   <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInput(100000);">십만</button></span>
                   <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInput(1000000);">백만</button></span>
                   <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInput(10000000);">천만</button></span>
                   <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInput(100000000);">억</button></span>
                   
                   <input type="text" ng-model="bid_price" id="bidPrice" name="bidPrice" onchange="getNumber(this);" onkeyup="getNumber(this);"/>
                   <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceSave('floor');">현장-응찰입력</button></span>
                   <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceSave('phone');">전화-응찰입력</button></span>
                   <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceSave('paper_offline');">서면-응찰입력</button></span>
                   <br/>             
                </p>  -->

                <p style="padding-top:5px; padding-bottom:5px; display:table;">
                	<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">호가 1&nbsp;&nbsp;&nbsp;</font>
                   	<input type="text" ng-model="bid_price_input_grow1" id="bidPriceInputGrow1" name="bidPriceInputGrow1" onkeyup="getNumber(this)" style="width:100px;"/>
                   	<span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInputMinus(bid_price_input_grow1);">-</button></span>
                   	<span class="btn_style01 green02"><button type="button" ng-click="liveLotBidPriceInputPlus(bid_price_input_grow1);">+</button></span>
                   	<br/>
                   
                   	<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">호가 2&nbsp;</font>
                   	<input type="text" ng-model="bid_price_input_grow2" id="bidPriceInputGrow2" name="bidPriceInputGrow2" onkeyup="getNumber(this)" style="width:100px;"/>
                   	<span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInputMinus(bid_price_input_grow2);">-</button></span>
                   	<span class="btn_style01 green02"><button type="button" ng-click="liveLotBidPriceInputPlus(bid_price_input_grow2);">+</button></span>
                   	<br/>
                   
                   	<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">호가 3&nbsp;</font>
                   	<input type="text" ng-model="bid_price_input_grow3" id="bidPriceInputGrow3" name="bidPriceInputGrow3" onkeyup="getNumber(this)" style="width:100px;"/>
                   	<span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInputMinus(bid_price_input_grow3);">-</button></span>
                   	<span class="btn_style01 green02"><button type="button" ng-click="liveLotBidPriceInputPlus(bid_price_input_grow3);">+</button></span>
                   	<br/>
                   
                   	<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">호가 4&nbsp;</font>
                   	<input type="text" ng-model="bid_price_input_grow4" id="bidPriceInputGrow4" name="bidPriceInputGrow4" onkeyup="getNumber(this)" style="width:100px;"/>
                   	<span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceInputMinus(bid_price_input_grow4);">-</button></span>
                   	<span class="btn_style01 green02"><button type="button" ng-click="liveLotBidPriceInputPlus(bid_price_input_grow4);">+</button></span>
                   	<br/>
                </p>
                 <p style="padding-top:5px; padding-bottom:5px; display:table;">
                	<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">현 재 가&nbsp;</font>
                   	<input type="text" ng-model="bid_price_input_start" id="bidPriceInputStart" name="bidPriceInputStart"/>

                    <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceSave('paper_offline');">서면-응찰입력</button></span>
                    <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceSave('phone');">전화-응찰입력</button></span>
                    <span class="btn_style01 gray02"><button type="button" ng-click="liveLotBidPriceSave('floor');">현장-응찰입력</button></span>
                </p>
            </div>
            
            <!--main -->
            <div class="cont">
            
                <div class="cont_title02">
                    <h3 ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0" ng-bind="(sale.SALE_TH)+(sale.SALE_TH_DSP)+' '"></h3>
                    <h3 ng-bind="(sale.TITLE_JSON[locale])"></h3>
                </div><!--cont_title02-->
                
                <div class="onepcssgrid-1200">
                
                    <div class="onerow"></div><!--clear-->
        
                    <div class="col5" style="padding-bottom:10px;">
        
                       <!--img-->
                       <div class="web_only">
                           <div style="height:310px; padding-bottom:25px; display:table; margin:auto; position:relative; overflow:hidden;" align="center">
                               <div style="display:table-cell; margin:auto; position:relative; vertical-align:middle"  align="center">
                               <img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" 
                                            alt="{{lot.TITLE}}" style="height: auto; width: auto; max-width:300px; margin-top: 0px; max-height:300px;"/>
                               </div>
                           </div>
                       </div><!--web_only-->
                       <div class="m_only">
                           <div ng-show="lot.LOT_NO != null" style="padding-bottom:25px; display:table; margin:auto; position:relative; overflow:hidden;" align="center">
                               <div style="display:table-cell; margin:auto; position:relative; vertical-align:middle"  align="center">
                               <img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" 
                                            alt="{{lot.TITLE}}" style="height: auto; width: auto; max-width:200px; margin-top: 0px; max-height:200px;"/>
                               </div>
                           </div>
                       </div><!--m_only-->
                       <!--img-->
                       
                       <!--detail-->
                       <div style="padding-top:15px; padding-bottom:10px; line-height:30px; border-top: solid  #666 1px;">
                           <span style="font-size:30px; color:#999;">Lot.<strong><span ng-bind="lot.LOT_NO"></span></strong></span>
                           <!-- 바로가기 버튼 구성 -->
                           <span ng-show="lot.LOT_NO != null" class="btn_style01 green02" style="margin-left:10px;"><a ng-if="lot.STAT_CD != 'reentry'" ng-href="{{'/lotDetail?sale_no=' + lot.SALE_NO + '&lot_no=' + lot.LOT_NO + '&sale_status=ING&view_type=LIST'}}" target="new">
                          자세히 보기</a></span>
                           <span ng-show="lot.LOT_NO == null">진행 대기중</span>
                           <br/>
                           <span style="font-size:18px;" ng-bind="lot.ARTIST_NAME_JSON[locale]"></span>
                           <span style="font-size:18px;" ng-if="locale != 'en'" ng-bind="lot.ARTIST_NAME_JSON.en"></span>
                           <span style="font-size:18px;" class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh"></span>
                           <br/>
                           <span ng-bind="lot.TITLE_JSON[locale]"></span>
                           <span ng-bind="lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale]"></span>
                           <p ng-if="lot.TITLE_JSON['zh'] != lot.TITLE_JSON['en']">
                              <span ng-if="lot.TITLE_JSON.zh != null" ng-bind="lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale]"></span>
                           </p>
                          
                           <span ng-bind="lot.STITLE_JSON[locale]"></span>
                           <p ng-if="locale == 'en'"><span ng-if="lot.STITLE_JSON.ko != null && lot.STITLE_JSON.ko != lot.STITLE_JSON.en" ng-bind="lot.STITLE_JSON.ko"></span></p>
                           <p ng-if="locale != 'en'"><span ng-if="lot.STITLE_JSON.en != null && lot.STITLE_JSON.ko != lot.STITLE_JSON.en" ng-bind="lot.STITLE_JSON.en"></span></p>
                           <p ng-if="lot.STITLE_JSON['zh'] != lot.STITLE_JSON['en']">
                              <span ng-if="lot.STITLE_JSON.zh != null" ng-bind="lot.STITLE_JSON.zh | trimSameCheck : lot.STITLE_JSON[locale]"></span>
                           </p>
                      </div> <!--detail-->	
                          
                      <!--price-->
                      <div style="padding-top:10px; border-top: solid #e4e4e4 1px; line-height:22px;">
                          <!-- 추정가 별도문의 -->
                          <span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
                          <span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'">
                              <!-- 기준통화 -->
                              <p>
                                  <span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
                                  <span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)">
                                   ~ 
                                  </span>	
                                  <span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
                              </p>
                              <!-- USD -->
                              <p>
                                  <span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
                                  <span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)">
                                   ~ 
                                  </span>	 
                                  <span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
                              </p>
                              <!-- 서브통화 -->
                              <p>
                                  <span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
                                  <span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)">
                                   ~ 
                                  </span>	 
                                  <span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
                              </p>
                              
                          </span>      
                     </div><!--price-->
                 </div><!--col5-->
         
         
                
                 <div class="col7 last">
                        <!-- <div class="web_only" align="center" ng-show="sale.CURR_CD == 'KRW'">
                            <iframe width="710" height="400" src="https://www.youtube.com/embed/8e5Pj1YTAtE?modestbranding=1&rel=0&autohide=0&showinfo=0&controls=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe> 
                        </div> --><!--web_only-->
 
                        <!-- <div class="m_only" align="center" ng-show="sale.CURR_CD == 'KRW'">
                            <iframe width="310" height="180" src="https://www.youtube.com/embed/8e5Pj1YTAtE?modestbranding=1&rel=0&autohide=0&showinfo=0&controls=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                        </div> --><!--m_only-->
                        
                        
                        <!-- scroll START (2018.04.18 YDH) -->
                        <div class="scrollable web" style="margin-top:22px;">
                            <div class="scroller">
                                <div class="tbl_style02">
                                    <table>
                                        <colgroup>
                                            <col />
                                            <col style="width:20%"/>
                                            <col style="width:20%"/>
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">응찰금액</th>
                                                <th scope="col">기준통화</th>
                                                <th scope="col">응찰구분</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblOffBidListBody">
                                            <tr ng-show="offBidList.length == 0"><td colspan="3">응찰 대기중</td></tr>
                                            <tr ng-repeat="bid in offBidList">
                                                <td>{{bid.BID_PRICE | number:0}}</td>
                                                <td>{{sale.CURR_CD}}</td>
                                                <td>{{bid.BID_KIND_CD}}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                             </div>
                        </div>
                        <!-- scroll END (2018.04.18 YDH) -->
                        
                </div> <!--col7-->


                <div class="onerow"></div><!--clear-->
                
                
                <!--네비게이션. 네비게이션은 웹버전에서만 표시 예정임.-->  
                
                <div class="col12 web_only" align="center"  style="padding-top:10px; border-top:#666 1px solid;">
                
                    <span class="btn_style01 green02" style="float:right;"><button type="button" ng-click="naviMoveInit(lot.LOT_NO);">경매중인 작품으로 이동</button></span>
                    
                    <div style="clear:both"></div><!--clear-->

                	<div style="display:inline;float:left; margin-top:100px;">
                        <button type="button" ng-click="naviMove(-1);"><img src="/images/btn/btn_next_left.png" alt="btn_next_left"></button>
                	</div>
                	<div style="width:90%; display:inline; float:left; height:310px; margin:10px; overflow:hidden; padding-left:10px;">                    
                        <ul style="display:table;">
                            <li ng-repeat="naviList in lot_navi" style="width:200px; padding:15px; display:table-cell; vertical-align:middle; ">
                                
                                <a ng-href="{{'/lotDetail?sale_no=' + naviList.SALE_NO + '&lot_no=' + naviList.LOT_NO}}" target="new">
                                <div style="height:200px;">
                                    <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{naviList.FILE_NAME | imagePath1 : naviList.FILE_PATH : 'detail'}}"
                                         style="height: auto; width:auto; max-width:200px; max-height:200px;"/>    
                                         </div>
                                </a>

                                <div align="center" style="padding-top:10px; margin-top:15px; border-top:#CCC 1px solid; line-height:25px;">
                                    <font>Lot.</font><span ng-bind="naviList.LOT_NO" style="margin-right:5px;"></span>
                                    <span ng-if="naviList.STAT_CD != 'reentry' && naviList.BID_PRICE > 0" ng-bind="sale.CURR_CD"></span>
                                    <span ng-bind="naviList.STAT_CD != 'reentry' && naviList.BID_PRICE | number:0"></span>
                                    <br/>
                                    <span ng-show="naviList.STAT_CD == 'reentry'"><font color="#999999">출품취소</font></span>
                                    <span ng-if="naviList.STAT_CD != 'reentry' && naviList.LIVE_STAT == 'LIVE'">
                                    	<font color="#ffffff" size="-1" style="background:#C00; padding:4px;">경매중</font>
                                    </span>	
                                    <span ng-if="naviList.STAT_CD != 'reentry' && naviList.LIVE_STAT != 'LIVE' && naviList.BID_PRICE > 0">
                                    	<font color="#ffffff" size="-1" style="background:#999; padding:4px;">종료</font>
                                    </span>
                                    <span ng-if="naviList.STAT_CD != 'reentry' && naviList.LIVE_STAT != 'LIVE' && naviList.BID_PRICE < 1">
                                    	<font color="#ffffff" size="-1" style="padding:4px;"></font>
                                    </span>    
                                </div>
                            </li>
                        </ul>
                	</div>
                	<div style="display:inline; float:right; margin-top:100px; overflow:visible;">
                        <button type="button" ng-click="naviMove(+1);"><img src="/images/btn/btn_next_right.png" alt="btn_next_right"></button>
                	</div>
                </div>  
                <!--네비게이션-->     
                
                <div class="onerow"></div><!--clear-->    
                    
            </div> <!--onepcssgrid-1200-->
         </div> <!--cont-->
     </div> <!--liveAuctionCtl-->
     
     <!--footer-->
     <div style="background-color:#e4e4e4; padding:10px; text-align:left;">	 
          <div class="web_only" align="center" ng-show="sale.CURR_CD == 'KRW'">
              <p style="color: #000; font-size:11px; padding-top:20px; padding-bottom:20px; line-height:18px;">* LOT정보와 Live중계는 시차가 발생할 수 있습니다. *<br/>재생오류 해결방법:Chrome, Edge, firefox 등 HTML5 지원 브라우저 사용 또는 브라우저 업그레이드를 권장합니다.<br/>자바스크립트를 모든 사이트에서 항상 실행을 하도록 하거나 캐시와 쿠키 삭제, 스피커 입력장치 연결을 확인해 주세요.</p>
          </div><!--web_only-->
          <div class="web_only" align="center" ng-show="sale.CURR_CD != 'KRW'">
              <p style="color: #000; font-size:11px; padding-top:20px; padding-bottom:20px; line-height:18px;">* LOT정보와 Current Bidding은 시차가 발생할 수 있습니다. *<br/>재생오류 해결방법:Chrome, Edge, firefox 등 HTML5 지원 브라우저 사용 또는 브라우저 업그레이드를 권장합니다.<br/>자바스크립트를 모든 사이트에서 항상 실행을 하도록 하거나 캐시와 쿠키 삭제, 스피커 입력장치 연결을 확인해 주세요.</p>
          </div><!--web_only-->
          <div class="m_only" align="center">
              <p style="color:#C00; font-size:12px; padding-top:20px; padding-bottom:20px; line-height:18px;">* 3G/LTE 등으로 재생 시 데이터 사용료가 발생할 수 있습니다.<br/>LOT정보와 Live중계는 시차가 발생할 수 있습니다.</p>
          </div><!--m_only-->
     </div><!--footer-->
            
  </div> <!--pop_wrap-->
</body>
</html>