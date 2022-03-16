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
	
	<link href="<c:url value="/css/old/common.css" />" rel="stylesheet">  
	<link href="<c:url value="/css/old/onepcssgrid_live.css" />" rel="stylesheet"> 
	<link href="<c:url value="/css/sa.common.2.0.css" />" rel="stylesheet"> 
	<link href="<c:url value="/css/bidLivepop.css" />" rel="stylesheet"> 
	
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
	});
	
	app.controller('liveAuctionCtl', function($scope, consts, common, $interval) {
		$scope.cnt_price = 0;
		$scope.lot_move_init = "NO";
		$scope.sale_no = getParameter('sale_no');
		
		$scope.init = function(){
			$scope.loadliveCustInfo();
			$scope.loadLiveAuction();
	 	}
		
		$scope.loadLiveAuction = function(){
			$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
					"actionList":[
					{"actionID":"liveSaleInfo", "actionType":"select" , "tableName": "SALE"},
					{"actionID":"liveLotInfo", "actionType":"select" , "tableName": "LOT"},
					{"actionID":"offBidList", "actionType":"select", "tableName":"BID_OFF_LIST"}, 						// Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
				]};	 	   	
			common.callActionSet($d, $s);
		}
	 		
		var $s = function(data, status) { 
			$scope.sale = data["tables"]["SALE"]["rows"][0];
			$scope.lot = data["tables"]["LOT"]["rows"][0];
			$scope.offBidList = data["tables"]["BID_OFF_LIST"]["rows"];	// Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
			
			//$scope.live_lot_no = $scope.lot.LOT_NO;  		// 현재 진행중인 LOT 번호
			//$scope.max_lot_no = $scope.sale.MAX_LOT_NO;  	// LOT 번호 MAX 번호
			//$scope.sale_no = $scope.sale.SALE_NO;			// 현재 진행중인 SALE 번호
			$scope.lot_no = $scope.lot.LOT_NO;				// Notice 입력은 LOT_NO 동기화만 진행함.
			
			$("#saleNumber").val($scope.sale_no);
			$("#lotNumber").val($scope.lot_no);
			//if($scope.lot_no == null || $scope.lot_no == 'undefined' || $scope.lot_move_init == "YES"){//alert($scope.lot_no);
			//	$scope.lot_no = $scope.lot.LOT_NO;	//현재  LOT 번호
			//}
			
			$scope.start_price = $scope.commaSetting($scope.lot.START_PRICE);	
			
			$scope.bid_price_input_online = $scope.commaSetting($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE); 	//고객용 응찰금액(최고가+호가) 설정
	 		$scope.bid_price_input_online_KO = $scope.numberToKorean($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE);//고객용 응찰금액(최고가+호가) 설정
			
	 		// 2018.05.08 호가 설정. Lot 동기화할경우만 반영
			var price_len = $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency].toString().length; //호가 생성 기준 
	
			if ($scope.bid_price_input_grow1 == "" || $scope.bid_price_input_grow1 == null || $scope.lot_move_init == "YES"){
				$scope.bid_price_input_grow1 = $scope.commaSetting(1 * Math.pow(10, parseInt(price_len)-2));	
			}
			if ($scope.bid_price_input_grow2 == "" || $scope.bid_price_input_grow2 == null || $scope.lot_move_init == "YES"){
				$scope.bid_price_input_grow2 = $scope.commaSetting(2 * Math.pow(10, parseInt(price_len)-2));	
			}
			if ($scope.bid_price_input_grow3 == "" || $scope.bid_price_input_grow3 == null || $scope.lot_move_init == "YES"){
				$scope.bid_price_input_grow3 = $scope.commaSetting(3 * Math.pow(10, parseInt(price_len)-2));	
			}
			if ($scope.bid_price_input_grow4 == "" || $scope.bid_price_input_grow4 == null || $scope.lot_move_init == "YES"){
				$scope.bid_price_input_grow4 = $scope.commaSetting(5 * Math.pow(10, parseInt(price_len)-2));				
			}
			if ($scope.bid_price_input_grow5 == "" || $scope.bid_price_input_grow5 == null || $scope.lot_move_init == "YES"){
				$scope.bid_price_input_grow5 = $scope.commaSetting($scope.lot.START_PRICE != null? $scope.lot.START_PRICE : $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency]);	
			}
	
			// 최초 오픈된 경우 실행. 최초 오픈시에는 mid_lot_no는 NULL!
			/* if($scope.mid_lot_no == null || $scope.mid_lot_no == 'undefined'){
				$scope.naviMoveInit($scope.live_lot_no);
			}
			// 네비게이션 버튼 실행한 적이 없는 경우에만 네비게이션 리스트도 동기화. (2018.04.25)
			if ($scope.cnt == 0 && (($scope.mid_lot_no+2) < $scope.live_lot_no ||($scope.mid_lot_no-2) > $scope.live_lot_no)){
				$scope.naviMoveInit($scope.live_lot_no);
			} */
			
			if ($scope.bidPriceInputStart == "undefined" || $scope.bidPriceInputStart == null || $scope.bidPriceInputStart == ""){
				$scope.bidPriceInputStart = $scope.bid_price_input_grow5;
			}

			//직원용 현재가 설정. 응찰금액이 없는 경우 시작가 설정. 시작가가 null이면 낮은추정가 설정. 응찰금액이 있는 경우 응찰금액으로 설정	
			
			if($scope.lot.LAST_PRICE != null && $scope.lot.LAST_PRICE != '' && $scope.bidPriceInputStart.replace(/[^\d]+/g,'') < $scope.lot.LAST_PRICE && $scope.cnt_price == 0){
				$scope.bidPriceInputStart = $scope.commaSetting($scope.lot.LAST_PRICE);
			}else{
				if(($scope.lot_move_init == "YES" || $scope.lot_move_init == "undefined") && ($scope.cnt_price == 0 || $scope.cnt_price == "undefined")){
					$scope.bidPriceInputStart = $scope.commaSetting($scope.lot.START_PRICE != null? $scope.lot.START_PRICE : $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency]);
				}
			}	
		}
		
		$scope.loadliveCustInfo = function(){
	 		$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
	 				"actionList":[
	 					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
	 					
	 		]};
	 		
	 	   	common.callActionSet($d, function(data, status) {
	 	   		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
	 		});
		}
		
		
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
		
				$scope.bid_price_input_grow1 = "";
				$scope.bid_price_input_grow2 = "";
				$scope.bid_price_input_grow3 = "";
				$scope.bid_price_input_grow4 = "";
				$scope.bid_price_input_grow5 = "";
	
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
			})
			
			$scope.cnt_price = $scope.cnt_price + 1; //응찰 건수 기록
		};
		
		// Live 진행 LOT번호 응찰금액 로직 추가(2018.04.17 YDH), bid_price는 콤마(,)제거
		$scope.liveLotBidNoticeSave = function($input, $input_en) {
			var $d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "bid_kind_cd":'floor', "bid_notice":$input, "bid_notice_en":$input_en}, 
						"actionList":[
						{"actionID":"addOffBidPrice", "actionType":"insert", "tableName":"BID_OFFLINE", "parmsList":[{}]}
					]};
			common.callActionSet($d, function(data, status) {
				//$scope.loadLiveAuction();
				$scope.init();
			})
		};
		
		// Live 하단 네비게이션 리스트
		/* $scope.liveLotNaviList = function($input){
			$scope.sale_no = $("#saleNumber").val();
			$scope.lot_no = $("#lotNumber").val();
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
		}; */
		
		$scope.lotMove = function($input){
			if($scope.lot_no == null || $scope.lot_no == 'undefined'){
				$scope.lot_no = 0;
			} ;

			if (parseInt($scope.lot_no)+$input > 0 && parseInt($scope.lot_no)+$input < $scope.max_lot_no+1){
				$scope.lot_no = parseInt($scope.lot_no) + $input;				
			}
			
			$("#lotNumber").val($scope.lot_no)
			
			$scope.lot_move_init = "NO";	// lot_no 변경되고 있는중.
		};
		
		/* $scope.naviMove = function($input){
			$scope.cnt = $scope.cnt + 1; //네비게이션 실행한 Count 누적
			
			if($scope.mid_lot_no == null || $scope.mid_lot_no == 'undefined'){
				if($scope.live_lot_no < 3){
					$scope.live_lot_no = 3;
				}
				$scope.mid_lot_no = $scope.live_lot_no;
			} ;

			$scope.mid_lot_no = $scope.mid_lot_no + $input;
			
			// lot_no가 3이하일경우 3로 설정, 최대 lot_no Over일 경우 최대lot_no-2로 설정. 기본 5건 보여주기위해서 처리
			if($scope.mid_lot_no < 3){
				$scope.mid_lot_no = 3;
			} else if ($scope.mid_lot_no > $scope.max_lot_no-2){
				$scope.mid_lot_no = $scope.max_lot_no-2;
			}
			
			$scope.liveLotNaviList($scope.mid_lot_no);
		}; */
		
		/* $scope.naviMoveInit = function($input){
			$scope.cnt = 0; //네비게이션 실행 Count 초기화
			
			// lot_no가 3이하일경우 3로 설정, 최대 lot_no Over일 경우 최대lot_no-2로 설정. 기본 5건 보여주기위해서 처리
			$scope.mid_lot_no = $input;
			
			if($scope.mid_lot_no < 3){
				$scope.mid_lot_no = 3;
			} else if ($scope.mid_lot_no > $scope.max_lot_no-2){
				$scope.mid_lot_no = $scope.max_lot_no-2;
			}
			
			$scope.liveLotNaviList($scope.mid_lot_no);
		};
		 */
		$scope.liveLotBidPriceInputPlus = function($input){
			if ($scope.bidPriceInputStart == null || $scope.bidPriceInputStart == ""){
				$scope.current_bid_price = 0;
			} else {
				$scope.current_bid_price = $scope.bidPriceInputStart.replace(/[^\d]+/g,'');
			}
			
			var price_grow = parseInt($scope.current_bid_price) + (parseInt($input.replace(/[^\d]+/g,''))*1);
			
			$scope.bidPriceInputStart = $scope.commaSetting(price_grow);			
			$("#bidPriceInputStart").val($scope.commaSetting(price_grow));
			
			$scope.cnt_price = $scope.cnt_price + 1; //응찰 건수 기록
		};
		
		$scope.liveLotBidPriceInputMinus = function($input){
			if ($scope.bidPriceInputStart == null){
				$scope.current_bid_price = 0;
			} else {
				$scope.current_bid_price = $scope.bidPriceInputStart.replace(/[^\d]+/g,'');
			}
	
			var price_grow = parseInt($scope.current_bid_price) + (parseInt($input.replace(/[^\d]+/g,''))*-1);

			$scope.bidPriceInputStart = $scope.commaSetting(price_grow);			
			$("#bidPriceInputStart").val($scope.commaSetting(price_grow));
			
			$scope.cnt_price = $scope.cnt_price + 1; //응찰 건수 기록
		};
		
		// Lot Refresh : 1초단위, Navi Refresh : 30초단위
		$interval(function(){$scope.loadLiveAuction();},1000);
		/* $interval(function(){$scope.naviMove();},30000); */ //네비게이션 동기화는 버튼 클릭시만 진행
		
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
		
		/* Notice 백업 */
		$scope.noticeBackup = function() {
			localStorage.setItem("bkNotice1", $("#bidNotice1").val());
			localStorage.setItem("bkNotice1_en", $("#bidNotice1_en").val());
			localStorage.setItem("bkNotice2", $("#bidNotice2").val());
			localStorage.setItem("bkNotice2_en", $("#bidNotice2_en").val());
			localStorage.setItem("bkNotice3", $("#bidNotice3").val());
			localStorage.setItem("bkNotice3_en", $("#bidNotice3_en").val());
			localStorage.setItem("bkNotice4", $("#bidNotice4").val());
			localStorage.setItem("bkNotice4_en", $("#bidNotice4_en").val());
			localStorage.setItem("bkNotice5", $("#bidNotice5").val());
			localStorage.setItem("bkNotice5_en", $("#bidNotice5_en").val());
			localStorage.setItem("bkNotice6", $("#bidNotice6").val());
			localStorage.setItem("bkNotice6_en", $("#bidNotice6_en").val());
			localStorage.setItem("bkNotice7", $("#bidNotice7").val());
			localStorage.setItem("bkNotice7_en", $("#bidNotice7_en").val());
			localStorage.setItem("bkNotice8", $("#bidNotice8").val());
			localStorage.setItem("bkNotice8_en", $("#bidNotice8_en").val());
			localStorage.setItem("bkNotice9", $("#bidNotice9").val());
			localStorage.setItem("bkNotice9_en", $("#bidNotice9_en").val());
			localStorage.setItem("bkNotice10", $("#bidNotice10").val());
			localStorage.setItem("bkNotice10_en", $("#bidNotice10_en").val());			
		}
		
		/* Notice 복원 */
		$scope.noticeRestore = function() {
			$("#bidNotice1").val(localStorage.getItem("bkNotice1"));
			$scope.bidNotice1 = $("#bidNotice1").val(); 
			$("#bidNotice1_en").val(localStorage.getItem("bkNotice1_en"));
			$scope.bidNotice1_en = $("#bidNotice1_en").val();
			$("#bidNotice2").val(localStorage.getItem("bkNotice2"));
			$scope.bidNotice2 = $("#bidNotice2").val();
			$("#bidNotice2_en").val(localStorage.getItem("bkNotice2_en"));
			$scope.bidNotice2_en = $("#bidNotice2_en").val();
			$("#bidNotice3").val(localStorage.getItem("bkNotice3"));
			$scope.bidNotice3 = $("#bidNotice3").val();
			$("#bidNotice3_en").val(localStorage.getItem("bkNotice3_en"));
			$scope.bidNotice3_en = $("#bidNotice3_en").val();
			$("#bidNotice4").val(localStorage.getItem("bkNotice4"));
			$scope.bidNotice4 = $("#bidNotice4").val();
			$("#bidNotice4_en").val(localStorage.getItem("bkNotice4_en"));
			$scope.bidNotice4_en = $("#bidNotice4_en").val();
			$("#bidNotice5").val(localStorage.getItem("bkNotice5"));
			$scope.bidNotice5 = $("#bidNotice5").val();
			$("#bidNotice5_en").val(localStorage.getItem("bkNotice5_en"));
			$scope.bidNotice5_en = $("#bidNotice5_en").val();
			$("#bidNotice6").val(localStorage.getItem("bkNotice6"));
			$scope.bidNotice6 = $("#bidNotice6").val();
			$("#bidNotice6_en").val(localStorage.getItem("bkNotice6_en"));
			$scope.bidNotice6_en = $("#bidNotice6_en").val();
			$("#bidNotice7").val(localStorage.getItem("bkNotice7"));
			$scope.bidNotice7 = $("#bidNotice7").val();
			$("#bidNotice7_en").val(localStorage.getItem("bkNotice7_en"));
			$scope.bidNotice7_en = $("#bidNotice7_en").val();
			$("#bidNotice8").val(localStorage.getItem("bkNotice8"));
			$scope.bidNotice8 = $("#bidNotice8").val();
			$("#bidNotice8_en").val(localStorage.getItem("bkNotice8_en"));
			$scope.bidNotice8_en = $("#bidNotice8_en").val();
			$("#bidNotice9").val(localStorage.getItem("bkNotice9"));
			$scope.bidNotice9 = $("#bidNotice9").val();
			$("#bidNotice9_en").val(localStorage.getItem("bkNotice9_en"));
			$scope.bidNotice9_en = $("#bidNotice9_en").val();
			$("#bidNotice10").val(localStorage.getItem("bkNotice10"));
			$scope.bidNotice10 = $("#bidNotice10").val();
			$("#bidNotice10_en").val(localStorage.getItem("bkNotice10_en"));
			$scope.bidNotice10_en = $("#bidNotice10_en").val();
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
						<%-- <div style="padding-top:10px; border-top: solid #e4e4e4 1px; line-height:22px;">
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
						</div><!--price--> --%>   
					</div><!--col5--><!-- 작품 정보 표시 영역 -->	

					<!-- 응찰 정보 표시 영역 --> 
					<div class="col7 last">
						<!-- scroll START (2018.04.18 YDH) -->
						<div class="fixed-table-container" style="height: 200px;"> <!-- <div class="scrollable web" style="margin-top:22px;"> -->
							<div class="fixed-table-header"></div>  <!-- <div class="scroller"> -->
								<div class="fixed-table-wrap"> <!-- <div class="tbl_style02"> -->
									<table id="tbl_employee" class="fixed-table">
										<colgroup>
											<col style="width:20%"/>
											<col style="width:20%"/>
											<col style="width:20%"/>
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
													<div class="th-text"><span ng-if="locale == 'ko'">Paddle No</span><span ng-if="locale != 'ko'">Paddle No</span> 
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
												<td ng-if="bid.BID_NOTICE == null" style="border-bottom: 1px solid #ddd;"> 
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.BID_PRICE | number:0}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.BID_PRICE | number:0}}</span>
												</td>
												<td ng-if="bid.BID_NOTICE == null" style="border-bottom: 1px solid #ddd;">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{sale.CURR_CD}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{sale.CURR_CD}}</span>
												</td>
												<td ng-if="bid.BID_NOTICE == null" style="border-bottom: 1px solid #ddd;">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.BID_KIND_CD}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.BID_KIND_CD}}</span>
												</td>
												<td ng-if="bid.BID_NOTICE == null" style="border-bottom: 1px solid #ddd;">   
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.ONLINE_BID_ID}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.ONLINE_BID_ID}}</span>
												</td>   
												<td style="border-bottom: 1px solid #ddd;" ng-if="bid.BID_NOTICE != null" colspan="4" style="color:red; text-align:center;"><span ng-if="locale == 'ko'">{{bid.BID_NOTICE}}</span><span ng-if="locale != 'ko'">{{bid.BID_NOTICE_EN}}</span></td>
												<td style="border-bottom: 1px solid #ddd;" ng-show="bid.BID_KIND_CD != 'online'"><button type="button" class="btn_insert" ng-click="bidOffDel(bid.BID_NO);">삭제</button></td>
											</tr>     
										</tbody>
									</table>
								</div>
							</div><!--//fixed-table-container --> 
							
							<!-- 경매 시작/마감 & 경매 문구 입력(직원용)-->		 			
						  	<div ng-if="!custInfo.CUST_NO" class="clearfix bid_live_edit_login_box">   
					  			<button type="button" onClick="location.href='/login'">
									<spring:message code="label.go.bid.loginlog" />
								</button> 
						  	</div> 
						  	<!-- 김소정 선임 : foggywish, 서희륜 선임 : hanasuh -->
						  	<div ng-if="custInfo.CUST_NO != null && custInfo.EMP_GB == 'Y' && (['ynjang', 'yeeun0210', 'hajenuri', 'cotndus3', 'eunmi1235', 'jeonghyhy', 'rpa2080','tlfk5745', 'foggywish', 'hanasuh'].indexOf(custInfo.LOGIN_ID) > -1)">
								<div class="col7 last" style="width: auto; text-align:center; margin-top: 20px;">   
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
										</div>
										&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="noticeBackup();">백업</button></span>
										&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="noticeRestore();">복원</button></span>
										
										<!-- 빈칸용 --> 
										<div style="width: 305px; height: 10px; display: inline-block; background-color: #fff;">  
										</div> 
									</div>
									
									<!-- notice --> 
									<div style="padding-bottom:5px; display:inline-block;"> 
										<!-- notice 1 -->      
										<div class="hogatable hogatable2">  
											<label for="bidNotice1"> 
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice1</font>
											</label> 
											<input type="text" ng-model="bidNotice1" id="bidNotice1" name="bidNotice1" />
											<input type="text" ng-model="bidNotice1_en" id="bidNotice1_en" name="bidNotice1_en" />
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice1, bidNotice1_en);">전송</button></span>
										</div>
										
										<!-- notice 2 -->     
										<div class="hogatable hogatable2">   
											<label for="bidNotice2">
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice2</font>
											</label>
											<input type="text" ng-model="bidNotice2" id="bidNotice2" name="bidNotice2" />
											<input type="text" ng-model="bidNotice2_en" id="bidNotice2_en" name="bidNotice2_en" />
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice2, bidNotice2_en);">전송</button></span>
										</div>
										
										<!-- notice 3 -->     
										<div class="hogatable hogatable2">   
											<label for="bidNotice3">
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice3</font>
											</label>
											<input type="text" ng-model="bidNotice3" id="bidNotice3" name="bidNotice3" />
											<input type="text" ng-model="bidNotice3_en" id="bidNotice3_en" name="bidNotice3_en" />
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice3, bidNotice3_en);">전송</button></span>
										</div>
										
										<!-- notice 4 -->     
										<div class="hogatable hogatable2">   
											<label for="bidNotice4">
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice4</font>
											</label>
											<input type="text" ng-model="bidNotice4" id="bidNotice4" name="bidNotice4" />
											<input type="text" ng-model="bidNotice4_en" id="bidNotice4_en" name="bidNotice4_en" />
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice4, bidNotice4_en);">전송</button></span>
										</div>   
										
										<!-- notice 5 -->     
										<div class="hogatable hogatable2">   
											<label for="bidNotice5">
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice5</font>
											</label>  
											<input type="text" ng-model="bidNotice5" id="bidNotice5" name="bidNotice5" />
											<input type="text" ng-model="bidNotice5_en" id="bidNotice5_en" name="bidNotice5_en" />
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice5, bidNotice5_en);">전송</button></span>
										</div>  
										 
										<!-- notice 6 -->     
										<div class="hogatable hogatable2">   
											<label for="bidNotice6">  
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice6</font>
											</label>  
											<input type="text" ng-model="bidNotice6" id="bidNotice6" name="bidNotice6"/>
											<input type="text" ng-model="bidNotice6_en" id="bidNotice6_en" name="bidNotice6_en"/>
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice6, bidNotice6_en);">전송</button></span>
										</div>  
										 
										<!-- notice 7 -->     
										<div class="hogatable hogatable2">   
											<label for="bidNotice7">  
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice7</font>
											</label>  
											<input type="text" ng-model="bidNotice7" id="bidNotice7" name="bidNotice7"/>
											<input type="text" ng-model="bidNotice7_en" id="bidNotice7_en" name="bidNotice7_en"/>
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice7, bidNotice7_en);">전송</button></span>
										</div>
										
										<!-- notice 8 -->     
										<div class="hogatable hogatable2">   
											<label for="bidNotice8">  
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice8</font>
											</label>  
											<input type="text" ng-model="bidNotice8" id="bidNotice8" name="bidNotice8"/>
											<input type="text" ng-model="bidNotice8_en" id="bidNotice8_en" name="bidNotice8_en"/>
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice8, bidNotice8_en);">전송</button></span>
										</div>
										
										<!-- notice 9 -->     
										<div class="hogatable hogatable2">   
											<label for="bidNotice9">  
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice9</font>
											</label>  
											<input type="text" ng-model="bidNotice9" id="bidNotice9" name="bidNotice9"/>
											<input type="text" ng-model="bidNotice9_en" id="bidNotice9_en" name="bidNotice9_en"/>
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice9, bidNotice9_en);">전송</button></span>
										</div>
										
										<!-- notice 10 -->     
										<div class="hogatable hogatable2">   
											<label for="bidNotice10">  
											<font style="padding-left:5px; padding-right:5px; display:table-cell; vertical-align:middle;">Notice10</font>
											</label>  
											<input type="text" ng-model="bidNotice10" id="bidNotice10" name="bidNotice10"/>
											<input type="text" ng-model="bidNotice10_en" id="bidNotice10_en" name="bidNotice10_en"/>
											&nbsp;<span class="btn_style01 gray02 bidlive_btn"><button type="button" ng-click="liveLotBidNoticeSave(bidNotice10, bidNotice10_en);">전송</button></span>
										</div>  
									</div>   
								</div>
							</div><!-- 경매 시작/마감 & 경매 문구 입력(직원용)--> 
						</div><!-- scroll END (2018.04.18 YDH) -->
					</div> <!--col7--> 					
					
					<div class="onerow"></div><!--clear-->

					<!--네비게이션-->
					<!-- <div class="col12 web_only" align="center" style="padding-top:10px; border-top:#666 1px solid; position: relative;">
						<span class="btn_style01 green02" style="float:right;"><button type="button" ng-click="naviMoveInit(lot.LOT_NO);">
							<span ng-if="locale == 'ko'">경매중인 작품으로 이동</span><span ng-if="locale != 'ko'">Go to the Auction Item</span></button>
						</span>
						<div style="clear:both"></div>
						<div style="float:left; position:absolute; top:40%; left: 0;">
       						<button type="button" ng-click="naviMove(-1);"><img src="/images/btn/btn_next_left.png" alt="btn_next_left"></button>
						</div>
						<div class="livepopedit_img" style="width:80%; height:220px; margin:10px auto; overflow:hidden; text-align: center;">                    
							<ul style="display:table; table-layout:fixed;">
								<li ng-repeat="naviList in lot_navi" style="width:200px; padding:15px; display:table-cell; vertical-align:middle;">
									<a ng-href="{{'/lotDetail?sale_no=' + naviList.SALE_NO + '&lot_no=' + naviList.LOT_NO}}" target="new">
										<div style="width: 100px; height: 100px; line-height: 100px; margin: 0 auto; display:block;">
											<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{naviList.FILE_NAME | imagePath1 : naviList.FILE_PATH : 'detail'}}"
												style="width: 100px; height: 100px; vertical-align:middle;" />    
         								</div>
									</a>
									<div align="center" style="padding-top:10px; margin-top:15px; border-top:#CCC 1px solid; line-height:25px;">
										<font>Lot.</font><span ng-bind="naviList.LOT_NO" style="margin-right:5px;"></span>
											<span ng-if="naviList.STAT_CD != 'reentry' && naviList.BID_PRICE > 0" ng-bind="sale.CURR_CD"></span>
											<span ng-bind="naviList.STAT_CD != 'reentry' && naviList.BID_PRICE | number:0"></span>
											<br/>
											<span ng-show="naviList.STAT_CD == 'reentry'"><font color="#999999"><span ng-if="locale == 'ko'">출품취소</span><span ng-if="locale != 'ko'">Canceled</span></font></span>
											<span ng-if="naviList.STAT_CD != 'reentry' && naviList.LIVE_STAT == 'LIVE'">
												<font color="#ffffff" size="-1" style="background:#C00; padding:4px;"><span ng-if="locale == 'ko'">경매중</span><span ng-if="locale != 'ko'">Bidding</span></font>
											</span>	
											<span ng-if="naviList.STAT_CD != 'reentry' && naviList.LIVE_STAT != 'LIVE' && naviList.BID_PRICE > 0">
												<font color="#ffffff" size="-1" style="background:#999; padding:4px;"><span ng-if="locale == 'ko'">종료</span><span ng-if="locale != 'ko'">Close</span></font>
											</span>
											<span ng-if="naviList.STAT_CD != 'reentry' && naviList.LIVE_STAT != 'LIVE' && naviList.BID_PRICE < 1">
												<font color="#ffffff" size="-1" style="padding:4px;"></font>
                   							</span>    
               						</div>
           						</li>
       						</ul>
						</div>
						<div style="float:left; overflow:visible; position:absolute; top: 40%; right:0;">
							<button type="button" ng-click="naviMove(+1);"><img src="/images/btn/btn_next_right.png" alt="btn_next_right"></button>
						</div>
					</div>--><!--네비게이션-->
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