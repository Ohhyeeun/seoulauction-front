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
	
	<link rel="apple-touch-icon-precomposed" sizes="57x57" href="/images/icon/favic/apple-touch-icon-57x57.png" />
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/icon/favic/apple-touch-icon-72x72.png" />
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/icon/favic/apple-touch-icon-114x114.png" />
	<link rel="apple-touch-icon-precomposed" sizes="120x120" href="/images/icon/favic/apple-touch-icon-120x120.png" />
	<link rel="apple-touch-icon-precomposed" sizes="152x152" href="/images/icon/favic/apple-touch-icon-152x152.png" />
	<link rel="icon" type="image/png" href="/images/icon/favic/favicon-32x32.png" sizes="32x32"/>
	<link rel="icon" type="image/png" href="/images/icon/favic/favicon-16x16.png" sizes="16x16"/>
	<meta name="application-name" content="SeoulAuction" />
	
	<link href="<c:url value="/resources/css/old/common.css?${resources.timestamp}" />" rel="stylesheet">  
	<link href="<c:url value="/css/old/onepcssgrid_live.css" />" rel="stylesheet"> 
	<link href="<c:url value="/resources/css/sa.common.2.0.css?${resources.timestamp}" />" rel="stylesheet">
	<script type="text/javascript" src="/resources/js/angular/angular.min.js"></script>
	<script src="/resources/js/angular/angular-sanitize.js"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/angular/angular-bind-html-compile.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/angular/app.js?${resources.timestamp}" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/common.js?${resources.timestamp}" />"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.js" ></script>
	<script type="text/javascript" src="/resources/js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.panzoom.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.slides.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.placeholder.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.nicefileinput.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.mousewheel.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.mobile-events.js"></script>
	<script type="text/javascript" src="/resources/js/iscroll.js"></script>
	<script type="text/javascript" src="/resources/js/old/ui.js?${resources.timestamp}"></script>
	<script type="text/javascript" src="/resources/js/old/frontCommon.js"></script>
</head>

<%-- YDH 추가 시작--%>
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>

<script>
	app.value('locale', 'ko');
	app.value('is_login', 'false');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN

	$(document).ready(function(){	
	});
	
	app.controller('liveAuctionCtl', function($scope, consts, common, $interval) {
		$scope.cnt_price = 0;
		$scope.lot_move_init = "NO";
		
		$scope.init = function(){
			$scope.loadliveLotInfo();
			$scope.loadLiveAuction();
	 	}
		
		
		$scope.loadLiveAuction = function(){
			$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
					"actionList":[
					{"actionID":"offBidList", "actionType":"select", "tableName":"BID_OFF_LIST"}, 						// Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
				]};	 	   	
			common.callActionSet($d, $s);
		}
	 		
		var $s = function(data, status) { 
			$scope.offBidList = data["tables"]["BID_OFF_LIST"]["rows"];	// Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
			console.log("####loadLiveAuction####")
	 	   	console.log($scope.lot_no);	 	   	
	 	   	//if($scope.lot_no == null || $scope.lot_no == "" ||$scope.lot_no == 'undefined' || $scope.lot_move_init == "YES"){
			//	console.log("####loadLiveAuction---lot_no####")
		 	//   	console.log($scope.sale.ING_LOT_NO);	 	   	
	 	   	//	$scope.lot_no = $scope.sale.ING_LOT_NO;	//현재  LOT 번호
	 	    //}
		}
		
		$scope.loadliveLotInfo = function(){
	 		$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
	 				"actionList":[
	 					{"actionID":"liveLotInfo", "actionType":"select" , "tableName": "LOT"},
	 					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
						{"actionID":"liveSaleInfo", "actionType":"select" , "tableName": "SALE"},
						
	 		]};
	 		
	 	   	common.callActionSet($d, function(data, status) {
	 	   		$scope.lot = data["tables"]["LOT"]["rows"][0];
	 	   		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];

				$scope.sale = data["tables"]["SALE"]["rows"][0];
		 	  	$scope.base_currency = $scope.sale.CURR_CD;
				$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
				$scope.max_lot_no = $scope.sale.MAX_LOT_NO;  	// LOT 번호 MAX 번호
				$scope.sale_no = $scope.sale.SALE_NO;			// 현재 진행중인 SALE 번호
		 	   	$scope.live_lot_no = $scope.sale.ING_LOT_NO;  		// 현재 진행중인 LOT 번호
		 	   	
		 	   if($scope.lot_no == null|| $scope.lot_no == ""  || $scope.lot_no == 'undefined' || $scope.lot_move_init == "YES"){
					$scope.lot_no = $scope.lot.LOT_NO;	//현재  LOT 번호
					$("#lotNumber").val($scope.lot_no);
			    }
	 	   
				// 2018.05.08 호가 설정. Lot 동기화할경우만 반영. 추정가 별도인경우 제외			 
				 if ($scope.lot.EXPE_PRICE_INQ_YN == 'N'){
					$scope.start_price = $scope.commaSetting($scope.lot.START_PRICE);	
					$scope.bid_price_input_online = $scope.commaSetting($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE); 	//고객용 응찰금액(최고가+호가) 설정
			 		$scope.bid_price_input_online_KO = $scope.numberToKorean($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE);//고객용 응찰금액(최고가+호가) 설정
			 	
			 		//var price_len = $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency].toString().length; //호가 생성 기준
					if ($scope.bid_price_input_grow1 == "" || $scope.bid_price_input_grow1 == null || $scope.lot_move_init == "YES"){
						//$scope.bid_price_input_grow1 = $scope.commaSetting(1 * Math.pow(10, parseInt(price_len)-2));
						$scope.bid_price_input_grow1 = $scope.commaSetting(1*$scope.growPriceOffline($scope.lot.START_PRICE != null? $scope.lot.START_PRICE : $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency]));
						$("#bidPriceInputGrow1").val($scope.bid_price_input_grow1);
					}
					if ($scope.bid_price_input_grow2 == "" || $scope.bid_price_input_grow2 == null || $scope.lot_move_init == "YES"){
						//$scope.bid_price_input_grow2 = $scope.commaSetting(2 * Math.pow(10, parseInt(price_len)-2));
						$scope.bid_price_input_grow2 = $scope.commaSetting(2*$scope.growPriceOffline($scope.lot.START_PRICE != null? $scope.lot.START_PRICE : $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency]));
						$("#bidPriceInputGrow2").val($scope.bid_price_input_grow2);
					}
					if ($scope.bid_price_input_grow3 == "" || $scope.bid_price_input_grow3 == null || $scope.lot_move_init == "YES"){
						//$scope.bid_price_input_grow3 = $scope.commaSetting(3 * Math.pow(10, parseInt(price_len)-2));
						$scope.bid_price_input_grow3 = $scope.commaSetting(3*$scope.growPriceOffline($scope.lot.START_PRICE != null? $scope.lot.START_PRICE : $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency]));
						$("#bidPriceInputGrow3").val($scope.bid_price_input_grow3);
					}	
					if ($scope.bid_price_input_grow4 == "" || $scope.bid_price_input_grow4 == null || $scope.lot_move_init == "YES"){
						//$scope.bid_price_input_grow4 = $scope.commaSetting(5 * Math.pow(10, parseInt(price_len)-2));
						$scope.bid_price_input_grow4 = $scope.commaSetting(5*$scope.growPriceOffline($scope.lot.START_PRICE != null? $scope.lot.START_PRICE : $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency]));
						$("#bidPriceInputGrow4").val($scope.bid_price_input_grow4);
					}
					if ($scope.bid_price_input_grow5 == "" || $scope.bid_price_input_grow5 == null || $scope.lot_move_init == "YES"){
						$scope.bid_price_input_grow5 = $scope.commaSetting($scope.lot.START_PRICE != null? $scope.lot.START_PRICE : $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency]);	
						$("#bidPriceInputGrow5").val($scope.bid_price_input_grow5);
					}
					if ($scope.bid_price_input_grow6 == "" || $scope.bid_price_input_grow6 == null || $scope.lot_move_init == "YES"){
						$scope.bid_price_input_grow6 = "";	
						$("#bidPriceInputGrow6").val($scope.bid_price_input_grow6);
					}
					
					if ($scope.bidPriceInputStart == "undefined" || $scope.bidPriceInputStart == null || $scope.bidPriceInputStart == "" || $scope.lot_move_init == "YES"){
						$scope.bidPriceInputStart = $scope.bid_price_input_grow5;
					}
					//직원용 현재가 설정. 응찰금액이 없는 경우 시작가 설정. 시작가가 null이면 낮은추정가 설정. 응찰금액이 있는 경우 응찰금액으로 설정	$scope.bidPriceInputStart.replace(/[^\d]+/g,'') < $scope.lot.LAST_PRICE && 
					if($scope.lot.LAST_PRICE != null && $scope.lot.LAST_PRICE != '' && $scope.cnt_price == 0){
						$scope.bidPriceInputStart = $scope.commaSetting($scope.lot.LAST_PRICE);
						$("#bidPriceInputStart").val($scope.bidPriceInputStart);
					}else{
						if(($scope.lot_move_init == "YES" || $scope.lot_move_init == "undefined") && ($scope.cnt_price == 0 || $scope.cnt_price == "undefined")){
							$scope.bidPriceInputStart = $scope.commaSetting($scope.lot.START_PRICE != null? $scope.lot.START_PRICE : $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency]);
							$("#bidPriceInputStart").val($scope.bidPriceInputStart);
						}
					}
				} 
	 		});
		}

		//최초 시작가 기준으로 호가 반영 Function
		$scope.growPriceOffline = function($input){
			$scope.outGrowPrice;
			if (parseInt($input) < 20000000){
				$scope.outGrowPrice = 100000;
			} else if (parseInt($input) >= 20000000 && parseInt($input) < 200000000){
				$scope.outGrowPrice = 1000000;
			} else if (parseInt($input) >= 200000000){
				$scope.outGrowPrice = 10000000;
			} else{
				$scope.outGrowPrice = 0;
			}		
			return $scope.outGrowPrice;
		};
		
		// Live 진행 LOT번호 설정 로직 추가(2018.04.14 YDH)
		$scope.liveLotSave = function($input) {	
			$scope.sale_no = $("#saleNumber").val();
			$scope.lot_no = $("#lotNumber").val();
			var $d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no}, 
						"actionList":[
						{"actionID":"modLiveLot", "actionType":"update", "tableName":"LIVE_LOT", "parmsList":[{}]}
					]};
			
			common.callActionSet($d, function(data, status) {
				$scope.bidPriceInputStart = "";
				$scope.price_len = "";
				
				$("#bidPriceInputGrow1").val("");
				$("#bidPriceInputGrow2").val("");
				$("#bidPriceInputGrow3").val("");
				$("#bidPriceInputGrow4").val("");
				$("#bidPriceInputGrow5").val("");
				$("#bidPriceInputGrow6").val("");
		
				$scope.bid_price_input_grow1 = "";
				$scope.bid_price_input_grow2 = "";
				$scope.bid_price_input_grow3 = "";
				$scope.bid_price_input_grow4 = "";
				$scope.bid_price_input_grow5 = "";
				$scope.bid_price_input_grow6 = "";
				
				$scope.bidPriceInputStart = "";
				
				$scope.init();
			})
			$scope.cnt = 0; // 네비게이션 실행여부 확인(2018.04.25)
			$scope.cnt_price = 0; //금액수정 건수
			$scope.lot_move_init = "YES";	// lot_no 초기화.
		};
		//LOT 마감/마감해제 관련 function. lot.LIVE_CLSOE_YN = 'Y'면 고객 응찰 불가처리
		$scope.liveLotClose = function($input) {	
			$scope.sale_no = $("#saleNumber").val();
			$scope.lot_no = $("#lotNumber").val();
			var $d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no}, 
						"actionList":[
						{"actionID":"closeLiveLot", "actionType":"update", "tableName":"CLOSE_LOT", "parmsList":[{}]}
					]};
			
			common.callActionSet($d, function(data, status) {
				$scope.init();
				//$scope.loadLiveAuction();
			})
		};		
		
		// Live 진행 LOT번호 응찰금액 로직 추가(2018.04.17 YDH), bid_price는 콤마(,)제거
		$scope.liveLotBidPriceSave = function($input) {	
			if ($input == 'online'){
				$scope.bid_price_input_online = $("#bid_price_input_online").val();
				$scope.bid_price = $scope.bid_price_input_online.replace(/[^\d]+/g,'');
			} else {
				$scope.bidPriceInputStart = $("#bidPriceInputStart").val();
				$scope.bid_price = $scope.bidPriceInputStart.replace(/[^\d]+/g,'');
			};
			
			var $d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "bid_price":$scope.bid_price, "bid_kind_cd":$input}, 
						"actionList":[
						{"actionID":"addOffBidPrice", "actionType":"insert", "tableName":"BID_OFFLINE", "parmsList":[{}]}
					]};
			common.callActionSet($d, function(data, status) {
				$scope.loadLiveAuction();
				//$scope.init();
			})
			
			$scope.cnt_price = $scope.cnt_price + 1; //응찰 건수 기록
		};
		
		$scope.lotMove = function($input){
			$scope.sale_no = $("#saleNumber").val();
			$scope.lot_no = $("#lotNumber").val();
			if($scope.lot_no == null || $scope.lot_no == 'undefined'){
				$scope.lot_no = 0;
			} ;
			
			if (parseInt($scope.lot_no)+$input > 0 && parseInt($scope.lot_no)+$input < $scope.max_lot_no+1){
				$scope.lot_no = parseInt($scope.lot_no) + $input;				
			}
			
			$("#lotNumber").val($scope.lot_no)
			
			$scope.lot_move_init = "NO";	// lot_no 변경되고 있는중.
		};
		
		$scope.liveLotBidPriceInputPlus = function($input){
			console.log("##InputPlus###");
			console.log($input);			
			$scope.inputPrice = 0;
			//데이터 바인딩 초기화 문제로 재할당함.(YDH)
			if ($input == 1){
				$scope.inputPrice = $("#bidPriceInputGrow1").val();
			} else if ($input == 2){
				$scope.inputPrice = $("#bidPriceInputGrow2").val();
			} else if ($input == 3){
				$scope.inputPrice = $("#bidPriceInputGrow3").val();
			} else if ($input == 4){
				$scope.inputPrice = $("#bidPriceInputGrow4").val();
			} else if ($input == 5){
				$scope.inputPrice = $("#bidPriceInputGrow5").val();
			} else if ($input == 6){
				$scope.inputPrice = $("#bidPriceInputGrow6").val();
			}
			console.log($scope.inputPrice);
			
			if ($scope.bidPriceInputStart == null || $scope.bidPriceInputStart == ""){
				$scope.current_bid_price = 0;
			} else {
				//$scope.current_bid_price = $scope.bidPriceInputStart.replace(/[^\d]+/g,'');
				$scope.current_bid_price = $("#bidPriceInputStart").val().replace(/[^\d]+/g,'');
			}
			
			//var price_grow = parseInt($scope.current_bid_price) + (parseInt($input.replace(/[^\d]+/g,''))*1);
			var price_grow = parseInt($scope.current_bid_price) + (parseInt($scope.inputPrice.replace(/[^\d]+/g,''))*1);
			
			$scope.bidPriceInputStart = $scope.commaSetting(price_grow);			
			$("#bidPriceInputStart").val($scope.commaSetting(price_grow));
			
			$scope.cnt_price = $scope.cnt_price + 1; //응찰 건수 기록
			$scope.lot_move_init = "NO";			 //LOT 동기화 초기여부. 최초 'YES'
		};
		
		$scope.liveLotBidPriceInputMinus = function($input){
			console.log("##InputMinus###");
			console.log($input);			
			$scope.inputPrice = 0;
			//데이터 바인딩 초기화 문제로 재할당함.(YDH)
			if ($input == 1){
				$scope.inputPrice = $("#bidPriceInputGrow1").val();
			} else if ($input == 2){
				$scope.inputPrice = $("#bidPriceInputGrow2").val();
			} else if ($input == 3){
				$scope.inputPrice = $("#bidPriceInputGrow3").val();
			} else if ($input == 4){
				$scope.inputPrice = $("#bidPriceInputGrow4").val();
			} else if ($input == 5){
				$scope.inputPrice = $("#bidPriceInputGrow5").val();
			} else if ($input == 6){
				$scope.inputPrice = $("#bidPriceInputGrow6").val();
			}
			console.log($scope.inputPrice);
			
			if ($scope.bidPriceInputStart == null){
				$scope.current_bid_price = 0;
			} else {
				//$scope.current_bid_price = $scope.bidPriceInputStart.replace(/[^\d]+/g,'');
				$scope.current_bid_price = $("#bidPriceInputStart").val().replace(/[^\d]+/g,'');
			}
	
			var price_grow = parseInt($scope.current_bid_price) + (parseInt($scope.inputPrice.replace(/[^\d]+/g,''))*-1);
			
			$scope.bidPriceInputStart = $scope.commaSetting(price_grow);			
			$("#bidPriceInputStart").val($scope.commaSetting(price_grow));
			
			$scope.cnt_price = $scope.cnt_price + 1; //응찰 건수 기록
			$scope.lot_move_init = "NO";			 //LOT 동기화 초기여부. 최초 'YES'
		};
		
		//// Lot Refresh : 1초단위, Navi Refresh : 30초단위
		$interval(function(){$scope.loadLiveAuction();},1000);
		
		$scope.commaSetting = function(inNum){
			// 콤마(,)표시			//var inNum = $input;
			var rgx2 = /(\d+)(\d{3})/; 
			var outNum;

			outNum = inNum.toString();
		
			while (rgx2.test(outNum)) {
				outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
			}
			return outNum;
		}
		
		$scope.numberToKorean = function(number){
		    var inputNumber  = number < 0 ? false : number;
		    var unitWords    = ['', '만', '억', '조', '경'];
		    var splitUnit    = 10000;
		    var splitCount   = unitWords.length;
		    var resultArray  = [];
		    var resultString = '';

		    for (var i = 0; i < splitCount; i++){
		         var unitResult = (inputNumber % Math.pow(splitUnit, i + 1)) / Math.pow(splitUnit, i);
		        unitResult = Math.floor(unitResult);
		        if (unitResult > 0){
		            resultArray[i] = $scope.commaSetting(unitResult);
		        }
		    }

		    for (var i = 0; i < resultArray.length; i++){
		        if(!resultArray[i]) continue;
		        resultString = String(resultArray[i]) + unitWords[i] + resultString;
		    }
			$scope.bidPriceInputKO = resultString;
		    return resultString;
		}
		
		/* 현재가/Notice 입력 삭제 */
		$scope.bidOffDel = function($input) {
			if($scope.locale == 'ko') {
				var retVal = confirm("삭제하시겠습니까?");
			} else
			{
				var retVal = confirm("Do you want to delete continue?");	
			}
			
			<%-- alert 확인 --%>
			if(retVal == true) {
				var $d = {"baseParms":{"bid_no":$input}, 
						"actionList":[
						{"actionID":"offBidDel", "actionType":"delete", "tableName":"BID_OFFLINE_DEL", "parmsList":[{}]}
						]};
				common.callActionSet($d, function(data, status) {
					$scope.del_cnt = data["tables"]["BID_OFFLINE_DEL"]["rows"];
					
					if($scope.del_cnt.length > 0) {
						alert("삭제되었습니다.");
						$scope.loadLiveAuction();
						return true;
					}else {
						alert("실패하셨습니다.\n다시 시도해주세요.");
					}
				})				
			}else {
				return false;
			}
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
		<div class="title"><h2>Seoul Auction LIVE</h2></div>
        
		<div  ng-controller="liveAuctionCtl" data-ng-init="init()"> 
            <!--main -->
			<div class="cont">            
				<div class="cont_title02"><h3 ng-bind="(sale.TITLE_JSON[locale])"></h3></div><!--cont_title02-->

				<div class="onepcssgrid-1200">                
    				<div class="onerow"></div><!--clear-->  
					<!-- 작품 정보 표시 영역 -->      
					<div class="col5" style="padding-bottom:10px;">        
						<!--img-->
						<div class="web_only">
							<div ng-show="lot.LOT_NO != null" style="height:310px; padding-bottom:25px; display:table; margin:auto; position:relative; overflow:hidden;" align="center">
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
							<span ng-show="lot.LOT_NO == null">진행 대기중</span>
							<span ng-show="lot.LOT_NO != null">
								<span style="font-size:30px; color:#999;">Lot.<strong><span ng-bind="lot.LOT_NO"></span></strong></span>
								<!-- 자세히보기 버튼 구성 -->
								<span class="btn_style01 green02" style="margin-left:10px;">
									<a ng-if="lot.STAT_CD != 'reentry'" ng-href="{{'/lotDetail?sale_no=' + lot.SALE_NO + '&lot_no=' + lot.LOT_NO + '&sale_status=ING&view_type=LIST'}}" target="new">
									<span ng-if="locale == 'ko'">자세히 보기</span><span ng-if="locale != 'ko'">Detail</span></a>
								</span>
								
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
							</span>
						</div> <!--detail-->

						<!--price-->
						<div style="padding-top:10px; border-top: solid #e4e4e4 1px; line-height:22px;">
							<!-- 추정가 별도문의 -->
							<span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
							<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'">
    							<!-- 기준통화 -->
								<p>
	    							<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
	    							<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
	    							<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
								</p>
								<!-- USD -->
								<p>
									<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
									<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)"> ~ </span>	 
									<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
								</p>
								<!-- 서브통화 -->
								<p>
									<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
									<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)"> ~ </span>	 
									<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
								</p>                              
							</span>      
						</div><!--price-->
					</div><!--col5--><!-- 작품 정보 표시 영역 -->	

					<!-- 응찰 정보 표시 영역 --> 
					<div class="col7 last">
						<!-- scroll START (2018.04.18 YDH) -->
						<div class="fixed-table-container" style="height: 200px;"> <!-- <div class="scrollable web" style="margin-top:22px;"> -->
							<div class="fixed-table-header"></div>  <!-- <div class="scroller"> -->
								<div class="fixed-table-wrap"> <!-- <div class="tbl_style02"> -->
									<table id="tbl_employee" class="fixed-table">
										<colgroup>
											<col />
											<col style="width:20%"/>
											<col style="width:20%"/>
										</colgroup>
										<thead>
											<tr>
												<th scope="col">
													<div class="th-text">
														<span ng-if="locale == 'ko'">응찰금액</span><span ng-if="locale != 'ko'">Bid Price</span>
													</div>
												</th>
												<th scope="col">
													<div class="th-text">
														<span ng-if="locale == 'ko'">기준통화</span><span ng-if="locale != 'ko'">Currency</span>
													</div>
												</th>
												<th scope="col">
													<div class="th-text">
														<span ng-if="locale == 'ko'">응찰구분</span><span ng-if="locale != 'ko'">Bidding</span>
													</div>
												</th>
												<th scope="col">
													<div class="th-text"><span ng-if="locale == 'ko'">ID</span><span ng-if="locale != 'ko'">ID</span>
													</div>
												</th>
												<th ng-show="bid.KIND_CD !='online'" scope="col">
													<div class="th-text">
														<span ng-if="locale == 'ko'">삭제</span><span ng-if="locale != 'ko'">Delete</span>
													</div>
												</th>
											</tr>
										</thead>
										<tbody id="tblOffBidListBody">
											<tr ng-show="offBidList.length == 0"><td colspan="5"><span ng-if="locale == 'ko'">응찰 대기중</span><span ng-if="locale != 'ko'">Waiting for a bid</span></td></tr>
											<tr ng-repeat="bid in offBidList">
												<td ng-if="bid.BID_NOTICE == null">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.BID_PRICE | number:0}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.BID_PRICE | number:0}}</span>
												</td>
												<td ng-if="bid.BID_NOTICE == null">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{sale.CURR_CD}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{sale.CURR_CD}}</span>
												</td>
												<td ng-if="bid.BID_NOTICE == null">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.BID_KIND_CD}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.BID_KIND_CD}}</span>
												</td>
												<td ng-if="bid.BID_NOTICE == null">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.ONLINE_BID_ID}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.ONLINE_BID_ID}}</span>
												</td>
												<td ng-if="bid.BID_NOTICE != null" colspan="4" style="color:red; text-align:center;"><span ng-if="locale == 'ko'">{{bid.BID_NOTICE}}</span><span ng-if="locale != 'ko'">{{bid.BID_NOTICE_EN}}</span></td>
												<td ng-show="bid.BID_KIND_CD != 'online'"><button type="button" class="btn_insert" ng-click="bidOffDel(bid.BID_NO);">삭제</button></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div><!-- scroll END (2018.04.18 YDH) -->
					</div> <!--col7-->

					<!-- 경매 시작/마감 & 경매 문구 입력(직원용). 김예은, 장부경, 양동호 담당만 접근 가능-->
					<div ng-if="custInfo.CUST_NO != null && custInfo.EMP_GB == 'Y' && (['yeeun0210', 'hajenuri', 'jbg211'].indexOf(custInfo.LOGIN_ID) > -1)">
						<div class="col7 last" style="width: auto; text-align:left; margin-top: 20px;">   
							<!-- Lot동기화는 LOT의 시작과 마감을 모두 처리. -->
							<div style="padding-bottom:10px;"> 
								<div class="hogatable" style="display: inline-block;"> 
									<label for="saleNumber"> 
									<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">경매번호</font>
									</label>
									<input type="text" ng-model="sale_no" id="saleNumber" name="saleNumber" style="width:35px;"> 
								</div>
								
								<div class="hogatable" style="display: inline-block;">
									<label for="bidPriceInputGrow5">
									<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">Lot</font>
									</label>
									<input type="text" ng-model="lot_no" id="lotNumber" name="lotNumber" style="width:35px;"/>&nbsp;
									<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="lotMove(-1);">-</button></span>
									<span class="btn_style01 green02 bidlive_btn"><button type="button" ng-click="lotMove(+1);">+</button></span>
									&nbsp;  
									<span class="btn_style01 green02 bidlive_btn"><button type="button" ng-click="liveLotSave();">LOT동기화</button></span>
									<span class="btn_style01 green02"><button type="button" ng-click="liveLotClose();">
										<span ng-if="lot.LIVE_CLOSE_YN == 'Y'" style="color:red; font-weight:bold;">LOT마감해제</span><span ng-if="lot.LIVE_CLOSE_YN != 'Y'" style="color:blue; font-weight:bold;">LOT마감</span></button>
									</span>
								</div>
								
								<!-- 빈칸용 --> 
								<div style="width: 305px; height: 10px; display: inline-block; background-color: #fff;">  
								</div> 
							</div>
														
							<!-- 테스트용 (직원용) -->  
							<div style="padding-top:5px; padding-bottom:5px; display:inline-block;">     
								<!-- 시작가 & 호가 -->  
								<div class="hogatable"> 
									<label for="bidPriceInputGrow5">
									<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">시작가</font>
									</label>
									<input type="text" ng-model="bid_price_input_grow5" id="bidPriceInputGrow5" name="bidPriceInputGrow5" onkeyup="getNumber(this)" />
									&nbsp;
									<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputMinus(5);">-</button></span>
									<span class="btn_style01 yellow bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputPlus(5);">+</button></span>
								</div>
								
								<!-- 호가 1 -->
								<div class="hogatable"> 
									<label for="bidPriceInputGrow1">
									<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">호가 1</font>
									</label>
									<input type="text" ng-model="bid_price_input_grow1" id="bidPriceInputGrow1" name="bidPriceInputGrow1" onkeyup="getNumber(this)" />
									&nbsp;
									<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputMinus(1);">-</button></span>
									<span class="btn_style01 green02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputPlus(1);">+</button></span>
								</div> 
								
								<!-- 호가 2 --> 
								<div class="hogatable">
									<label for="bidPriceInputGrow2">  
									<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">호가 2</font>
									</label>
									<input type="text" ng-model="bid_price_input_grow2" id="bidPriceInputGrow2" name="bidPriceInputGrow2" onkeyup="getNumber(this)" />
									&nbsp;
									<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputMinus(2);">-</button></span>
									<span class="btn_style01 green02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputPlus(2);">+</button></span>
								</div>
								
								<!-- 호가 3 -->
								<div class="hogatable">
									<label for="bidPriceInputGrow3">  
									<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">호가 3</font>
									</label>
									<input type="text" ng-model="bid_price_input_grow3" id="bidPriceInputGrow3" name="bidPriceInputGrow3" onkeyup="getNumber(this)"/>
									&nbsp;
									<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputMinus(3);">-</button></span>
									<span class="btn_style01 green02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputPlus(3);">+</button></span>
								</div>
								
								<!-- 호가 4 -->
								<div class="hogatable">
									<label for="bidPriceInputGrow4"> 
									<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">호가 4</font>
									</label>
									<input type="text" ng-model="bid_price_input_grow4" id="bidPriceInputGrow4" name="bidPriceInputGrow4" onkeyup="getNumber(this)" />
									&nbsp;
									<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputMinus(4);">-</button></span>
									<span class="btn_style01 green02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputPlus(4);">+</button></span>
								</div>
								
								<!-- 호가 5 -->
								<div class="hogatable">
									<label for="bidPriceInputGrow6"> 
									<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">호가 5</font>
									</label>
									<input type="text" ng-model="bid_price_input_grow6" id="bidPriceInputGrow6" name="bidPriceInputGrow6" onkeyup="getNumber(this)" />
									&nbsp;
									<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputMinus(6);">-</button></span>
									<span class="btn_style01 green02 bidlive_btn"><button type="button" ng-click="liveLotBidPriceInputPlus(6);">+</button></span>
								</div>
								
								<!-- 현재가 -->
								<div class="hogatable">      
									<label for="bidPriceInputStart">   
									<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;">현재가</font>
									</label>
									<input type="text" ng-model="bidPriceInputStart" id="bidPriceInputStart" name="bidPriceInputStart" onkeyup="getNumber(this)" style="width:170px;"/>									
								</div>
						   </div><!-- //시작가 & 호가 -->  
						   
							<!-- 응찰 버튼 (직원용) --> 	
							<div style="display:inline-block; vertical-align: text-bottom;">     
								<span class="btn_style01 green02 offauction_btn"> 
									<button type="button" ng-click="liveLotBidPriceSave('floor');">현장 응찰</button>
								</span>    
								<span class="btn_style01 green02 offauction_btn">
									<button type="button" ng-click="liveLotBidPriceSave('price_change');">현재가조정</button>
								</span>
							</div>
						</div>
					</div><!-- 경매 시작/마감 & 경매 문구 입력(직원용)-->

					<div class="onerow"></div><!--clear-->

					<div class="onerow"></div><!--clear-->    
				</div> <!--onepcssgrid-1200-->
			</div> <!--cont-->
		</div> <!--liveAuctionCtl-->
			
		<!--footer-->
		<div style="background-color:#e4e4e4; padding:10px; text-align:left;">	 
			<div align="center" ng-if="locale == 'ko'">
    			<p style="color: #000; font-size:11px; padding-top:20px; padding-bottom:20px; line-height:18px;">
    				* LOT정보와 Current Bidding은 네트워크 속도에 따라 지연될 수 있습니다.
				</p>
			</div>
			<div align="center" ng-if="locale != 'ko'">
    			<p style="color: #000; font-size:11px; padding-top:20px; padding-bottom:20px; line-height:18px;">
    				* LOT information and Current Bidding may be delayed depending on network speed.
				</p>
			</div>
		</div><!--footer-->
          
	</div> <!--pop_wrap-->
</body>
</html>