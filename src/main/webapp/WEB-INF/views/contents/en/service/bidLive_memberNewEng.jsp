<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- head.jsp Begin --> 
<!DOCTYPE html>
<html lang="en" ng-app="myApp">   
<head>  
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale = 1, maximum-scale = 1, user-scalable=no" http-equiv="X-UA-Compatible" content="IE=Edge">           
	<meta charset="UTF-8">   
	<title>μμΈμ₯μ</title>  
	
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
	<link href="/css/jquery.modally.css" rel="stylesheet">  
	
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	
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
	<script type="text/javascript" src="/js/jquery.modally.js"></script>
</head> 

<%-- YDH μΆκ° μμ--%>
<script type="text/javascript" src="/js/angular/paging.js"></script>
<!-- Expose 'llnwrtssdk' on the window global to reference in your 'subscribe' script -->
<script type="text/javascript" src="https://llrtsprod.s.llnwi.net/v1/sdk/html/current/llnwrtssdk.min.js"></script>
<!-- Recommended shim for cross-browser WebRTC support. -->
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>

<style>
.nowLot{
	border: 2px solid #62c3bc; 
}
.nowLot p,
.nowLot span {  
	font-weight: bold;     
	color: #333;        
}    
</style>

<script>
	app.value('locale', 'en');
	app.value('is_login', 'false');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN

	$(document).ready(function(){
		$("#cancelBtn").click(function(){
			self.opener = self;    
			window.close();   
		});   
	}); 
	
	app.controller('liveAuctionCtl', function($scope, consts, common, $interval) {
		$scope.isReentry = false; //μΆνμ·¨μμ¬λΆ
// 		$scope.isZeroBase = false;
		$scope.cnt = 0; // λ€λΉκ²μ΄μ μ€νμ¬λΆ νμΈ(2018.04.25)
		$scope.lot_move_init = "NO";
		$scope.sale_no = getParameter('sale_no');
		
		$scope.base_currency = 'KRW';
		$scope.curren = 'KRW';
		$scope.fromPrice = 0; //μΆμ²­κ° νμ¨ from
		$scope.toPrice = 0; //μΆμ κ° νμ¨ to
		
		$scope.cate_list = ['contemporary'];// μΉ΄νκ³ λ¦¬ κ΅¬λΆ μΆκ°(2021.03.15 YDH)
		$scope.hashtag_list = null;// ν΄μ¬νκ·Έ κ΅¬λΆ μΆκ°(2021.03.15 YDH)
		
		$scope.init = function(){
// 			$scope.loadLiveAuction();
			$scope.loadInitInfo();
	 	} 
		 
		$scope.loadLiveAuction = function(){
			$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
					"actionList":[
					{"actionID":"liveSaleInfo", "actionType":"select" , "tableName": "SALE"},
					{"actionID":"liveLotInfo", "actionType":"select" , "tableName": "LOT"},
					{"actionID":"offBidList", "actionType":"select", "tableName":"BID_OFF_LIST"}, // Live μ§ν LOTλ²νΈ μμ°°κΈμ‘ νΈμΆ μΆκ°(2018.04.18 YDH)
					{"actionID":"get_lotInfo_naviation", "actionType":"select" , "tableName": "LOT_NAVI"},// λμ°°κ° νμμν΄ 1ν νΈμΆμμ κ³μ νΈμΆλ‘ μΆκ°(2021.11.22 YDH)
				]};	 	   	
			common.callActionSet($d, $s);
		}
		
		var $s = function(data, status) {
			
			$scope.sale = data["tables"]["SALE"]["rows"][0];
			$scope.lot = data["tables"]["LOT"]["rows"][0];
			$scope.offBidList = data["tables"]["BID_OFF_LIST"]["rows"];// Live μ§ν LOTλ²νΈ μμ°°κΈμ‘ νΈμΆ μΆκ°(2018.04.18 YDH)
			$scope.lotNavi = data["tables"]["LOT_NAVI"]["rows"];// λμ°°κ° νμμν΄ 1ν νΈμΆμμ κ³μ νΈμΆλ‘ μΆκ°(2021.11.22 YDH)
			
			$scope.LotNo = $scope.lot.LOT_NO;
			
			$scope.base_currency = $scope.sale.CURR_CD;
			$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
// 			$scope.curren = $scope.base_currency; //νμ¬ μ€μ  νμ¨
			
			$scope.live_lot_no = $scope.lot.LOT_NO;  //νμ¬ μ§νμ€μΈ LOT λ²νΈ
			$scope.max_lot_no = $scope.sale.MAX_LOT_NO;  // LOT λ²νΈ MAX λ²νΈ
		
			$scope.sale_no = $scope.sale.SALE_NO;
			$scope.lot_no = $scope.lot.LOT_NO;		//μ‘°νλ LOTμ λ¬΄μ‘°κ±΄ λκΈ°ν
			
			/* νμ¨ μ²λ¦¬ */
			if($scope.curren != 'KRW'){
				//νμ¬κ° νμ¨
				var nowCurrPrice = $scope.calCurrPrice($scope.lot.LAST_PRICE);
				$("#NowCurrPrice").html(comma(nowCurrPrice));
			
				//νμ¬μ§νλ μμ­
				var baseFromPrice = $scope.lot.EXPE_PRICE_FROM_JSON['KRW'];
				var baseToPrice = $scope.lot.EXPE_PRICE_TO_JSON['KRW'];				
		
				var fromPrice = $scope.calCurrPrice(baseFromPrice);
				var toPrice = $scope.calCurrPrice(baseToPrice);
				$scope.fromCurrPrice = comma(fromPrice);
				$scope.toCurrPrice = comma(toPrice);
				
				//lotμ λ³΄ μμ­
			 	var fromPrice2 = $scope.calCurrPrice($("#startPrice").attr("data-curr"));
				var toPrice2 = $scope.calCurrPrice($("#toPrice").attr("data-curr"));
				$("#fromCurrPrice2").html(comma(fromPrice2));
				$("#toCurrPrice2").html(comma(toPrice2));
			}
			/*  */
			
			
// 			var naviCategory =  $(".navimgBox").attr("data-category");
// 			var naviHashtag =  $(".navimgBox").attr("data-hashtag");
			$scope.naviLot = $("#nowLotNo").val();
			
			if($scope.lot_no != $scope.naviLot){ //μ§νλ λ³κ²½λμμλ 
				$scope.elClickLotNo = $scope.lot_no;
				//μΆμ κ° λ° νμ¨
				var priceInqYn = $scope.lot.EXPE_PRICE_INQ_YN;
				
				if($scope.lot.EXPE_PRICE_INQ_YN != 'Y' && $scope.lot.EXPE_PRICE_FROM_JSON['KRW'] != 0 && $scope.lot.EXPE_PRICE_FROM_JSON['KRW'] != 0 && $scope.lot.EXPE_PRICE_FROM_JSON['KRW'] != null && $scope.lot.EXPE_PRICE_FROM_JSON['KRW'] != null){
		 			$scope.isPriceInqYn = false;
		 		}else{
		 			$scope.isPriceInqYn = true;
		 		}

				for(var i=0; i < $scope.lotNavi.length-1; i++){
					if($scope.lotNavi[i].LOT_NO == $scope.lot_no){
						$scope.lot_idx = $scope.lotNavi[i].LOT_IDX;
						break;
					}
				}
				
				//μ€ν¬λ‘€
                $(".bidlive_navigationbox").animate({ scrollTop: 90*($scope.lot_idx-2), duration: 400 }); 
			}
			
			
			//μΆμ κ° λ³λμΈ κ²½μ° μ μΈ
			if ($scope.lot.EXPE_PRICE_INQ_YN == 'N'){	
				if($scope.lot.LAST_PRICE != null && $scope.lot.LAST_PRICE != ''){
					$scope.bid_price_input_online = $scope.commaSetting($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE); //κ³ κ°μ© μμ°°κΈμ‘(μ΅κ³ κ°+νΈκ°) μ€μ 				
			 		$scope.bid_price_input_online_KO = $scope.numberToKorean($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE);	
			 		if($scope.curren != 'KRW'){ //μμ°°κ° νμ¨ κ³μ°
				 		var bidCurrPrice = $scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE;
						$scope.bid_price_input_online_CURR = comma($scope.calCurrPrice(bidCurrPrice));
			 		}
				}else{
					if($scope.lot.START_PRICE == null || $scope.lot.START_PRICE == ''){
						$scope.lot.START_PRICE = 0;
					} 
					$scope.bid_price_input_online = $scope.commaSetting($scope.lot.START_PRICE); //κ³ κ°μ© μμ°°κΈμ‘(μμκ°) μ€μ 
			 		$scope.bid_price_input_online_KO = $scope.numberToKorean($scope.lot.START_PRICE);	
			 		if($scope.curren != 'KRW'){//μμ°°κ° νμ¨ κ³μ°
						$scope.bid_price_input_online_CURR = comma($scope.calCurrPrice($scope.lot.START_PRICE));
			 		}
				}
			} else {//μΆμ κ° λ³λ λ¬Έμμ μ²λ¦¬
				$scope.bid_price_input_online = ""; //κ³ κ°μ© μμ°°κΈμ‘(μμκ°+νΈκ°) μ€μ 
		 		$scope.bid_price_input_online_KO = "";	
		 		$scope.bid_price_input_online_CURR = "";
			}
		}
		
		//νμ¨ κ³μ° ν¨μ
		$scope.calCurrPrice = function(baseprice){
			var currPrice = $scope.currRate = $scope.currenList.filter(function (curren){ return curren.EXCH_CURR_CD == $scope.curren; })[0].RATE; //νμ¨λ¦¬μ€νΈμ€ νμ¬ μ νλ νμ¨μ rowλ₯Ό λ½μ rateκ°μ μΆμΆ
			var resultPrice = Math.round(baseprice/currPrice);
			return resultPrice;
		}
		
		$scope.loadInitInfo = function(){
	 		$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no },
// 	 							"cate_cds" : $scope.cate_list, "hashtag_list" : $scope.hashtag_list},
	 				"actionList":[
// 	 				    {"actionID":"saleLot_category", "actionType":"select", "tableName":"CATEGORY"}, // μΉ΄νκ³ λ¦¬ κ΅¬λΆ μΆκ°(2021.03.15 YDH)
// 	 	  				{"actionID":"saleLot_hashtag", "actionType":"select", "tableName":"HASHTAG"}, // ν΄μ¬ μΉ΄νκ³ λ¦¬ κ΅¬λΆ μΆκ°(2021.03.15 YDH)
	 					{"actionID":"get_bidMy_history", "actionType":"select" , "tableName": "MY_BID_HISTORY"},
	 					{"actionID":"get_lotInfo_naviation", "actionType":"select" , "tableName": "LOT_NAVI"},
	 					{"actionID":"get_bidLive_info", "actionType":"select" , "tableName": "GET_CUST_INFO" ,"parmsList":[]},
	 					{"actionID":"get_bidLive_currenInfo", "actionType":"select" , "tableName": "GET_BID_CURREN" ,"parmsList":[]},
	 					{"actionID":"get_lotInfo_favorate", "actionType":"select" , "tableName": "LOT_FAV" },  //κ΄μ¬μνλ§ νμ
	 		]};
	 	   	common.callActionSet($d, function(data, status) {
		 	   	$scope.custInfo = data["tables"]["GET_CUST_INFO"]["rows"][0];
		 	  	$scope.liveCheck = data["tables"]["LOT_NAVI"]["rows"][0];
	 	   		
		 	  	if($scope.liveCheck.IS_CLOSED == 'Y'){
	 	 			alert($scope.locale == 'ko'? "μ§νμ€μΈ κ²½λ§€κ° μμ΅λλ€" : "There is no auctions going on currently");
	 	 		  	//window.close();
	 	 		  	location.href='/';
	 	 		}else{
		 	   	 	$scope.myBidHistory = data["tables"]["MY_BID_HISTORY"]["rows"];
		 	   		$scope.lotNavi = data["tables"]["LOT_NAVI"]["rows"]; 
		 	   		$scope.currenList = data["tables"]["GET_BID_CURREN"]["rows"];//νμ¨ selectbox
	// 		 	   	$scope.category = data["tables"]["CATEGORY"]["rows"]; // μΉ΄νκ³ λ¦¬ κ΅¬λΆ μΆκ°(2021.03.15 YDH)
	// 	 	 		$scope.hashtag = data["tables"]["HASHTAG"]["rows"]; // ν΄μ¬ μΉ΄νκ³ λ¦¬ κ΅¬λΆ μΆκ°(2021.03.15 YDH)
		 	 		$scope.lotFAV = data["tables"]["LOT_FAV"]["rows"]; // κ΄μ¬μν κ΅¬λΆ μΆκ°(2021.03.15 YDH)
		 	 		
		 	 		for(var i=0; i<$scope.lotNavi.length-1; i++){
						if($scope.lotNavi[i].LOT_NO == $scope.lot_no){
							$scope.lot_idx = $scope.lotNavi[i].LOT_IDX;
							$(".bidlive_navigationbox").animate({ scrollTop: 90*($scope.lot_idx-2), duration: 400 });
							break;
						}
					}
		 	 		
		 	 		// Lot Refresh : 1μ΄λ¨μ, Navi Refresh : 30μ΄λ¨μ
		 			$interval(function(){$scope.loadLiveAuction();},1000);     
		 			/* $interval(function(){$scope.naviMove();},30000); */ //λ€λΉκ²μ΄μ λκΈ°νλ λ²νΌ ν΄λ¦­μλ§ μ§ν
	 	 		}
	 		});
		}
		 $scope.elClick = function( lotNo, stat, artist, title, cdMn, baseFromPrice, baseToPrice, priceInqYn, fileName, filePath){
// 			$("#elClickLotNo").val(lotNo);
			$scope.elClickLotNo = lotNo;

			document.getElementById("defaultOpen").click(); //μν ν΄λ¦­μ lot Infoν­ λ³΄μ¬μ£ΌκΈ° 
			
	 		if(stat == 'entry'){
	 			$scope.isReentry = false; //μΆνμ·¨μμ¬λΆ
	 			$("#lotNo").html(lotNo);
	 			$("#artistName").html(artist);
		 		$("#titleName").html(title);
		 		$("#cdMnEn").html(cdMn);
		 		
		 		if(baseToPrice != 0 && baseFromPrice != 0 && baseToPrice != null && baseFromPrice != null && priceInqYn !='Y'){
		 			$scope.isPriceInqYn = false;
		 		}else{
		 			$scope.isPriceInqYn = true;
		 		}
		 		
		 		$("#startPrice").html("KRW " +comma(baseFromPrice ));
		 		$("#startPrice").attr("data-curr", baseFromPrice);
		 		$("#toPrice").html(comma(baseToPrice));
		 		$("#toPrice").attr("data-curr", baseToPrice);
		 		
		 		if($scope.curren != 'KRW'){
					
					var fromPrice = $scope.calCurrPrice(baseFromPrice);
					var toPrice = $scope.calCurrPrice(baseToPrice);
					
					$("#fromCurrPrice2").html(comma(fromPrice));
			 		$("#toCurrPrice2").html(comma(toPrice));
		 		}
		 		
				var imgUrl = "https://www.seoulauction.com/nas_img"+filePath+"/"+fileName;
		 		$('#imgSrc').empty();
		 		$('#imgSrc').attr('src',  imgUrl);
	 		}else{ 
	 			$scope.isReentry = true;//μΆνμ·¨μμ¬λΆ
	 		}
		}
		
		
		$scope.nowLotMove= function( lot_no, artistName, title, cdMn, baseFromPrice, baseToPrice, priceInqYn, fileName, filePath ){
			if($scope.lot_no != $scope.elClickLotNo){ 
                $(".bidlive_navigationbox").animate({ scrollTop: 90*($scope.lot_idx-2), duration: 400 });  
			}
			
			$scope.isReentry = false; //μΆνμ·¨μμ¬λΆ
			$scope.elClickLotNo = lot_no;
			$("#lotNo").html(lot_no);
	 		$("#artistName").html(artistName);
	 		$("#titleName").html(title);
	 		$("#cdMnEn").html(cdMn);

	 		if(baseToPrice != 0 && baseFromPrice != 0 && baseToPrice != null && baseFromPrice != null && priceInqYn !='Y'){
	 			$scope.isPriceInqYn = false;
	 		}else{
	 			$scope.isPriceInqYn = true;
	 		}
	 		
	 		$("#startPrice").html("KRW "+comma(baseFromPrice));
	 		$("#startPrice").attr("data-curr", baseFromPrice);
	 		$("#toPrice").html(comma(baseToPrice));
	 		$("#toPrice").attr("data-curr", baseToPrice);
	 		if($scope.curren != 'KRW'){
				
				var fromPrice = $scope.calCurrPrice(baseFromPrice);
				var toPrice = $scope.calCurrPrice(baseToPrice);
				
				$("#fromCurrPrice2").html(comma(fromPrice));
		 		$("#toCurrPrice2").html(comma(toPrice));
	 		}
	 		var imgUrl = "https://www.seoulauction.com/nas_img"+filePath+"/"+fileName;
	 		$('#imgSrc').empty();
	 		$('#imgSrc').attr('src',  imgUrl);
		}
		
		
		// Live μ§ν LOTλ²νΈ μμ°°κΈμ‘ λ‘μ§ μΆκ°(2018.04.17 YDH), bid_priceλ μ½€λ§(,)μ κ±°
		$scope.liveLotBidPriceSave = function($input) {	
			if ($input == 'online'){
				$scope.bid_price_input_online = $("#bidPriceInputOnline").val();
				$scope.bid_price = $scope.bid_price_input_online.replace(/[^\d]+/g,'');
			} else {
				$scope.bidPriceInputStart = $("#bidPriceInputStart").val();
				$scope.bid_price = $scope.bidPriceInputStart.replace(/[^\d]+/g,'');
			};
			
			var $d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "bid_price":$scope.bid_price, "bid_kind_cd":$input, "padd_no" : $scope.custInfo.PADD_NO}, 
						"actionList":[
						{"actionID":"addOffBidPrice", "actionType":"insert", "tableName":"BID_OFFLINE", "parmsList":[{}]}
					]};
			common.callActionSet($d, function(data, status) {
				$scope.loadLiveAuction();				
			})
		};
		
		
		/* νμ¨λ³κ²½μ λ‘μ§ */
		$scope.currChange = function(currCd){ //νμ¨ λ³κ²½μ
			//νμλμ°κΈ°
			$("#modalTitle").html("Please read");
			$("#liveCurrChangeCheck").trigger('click');
			$("#currChangeCheckbox").prop('checked', false);
			$scope.selecCurr = currCd;
		}
		
		$scope.currChangeOk = function(isBtnOk){
			if(!isBtnOk) {
				$(".modally-close-button").click();//νμμ°½ λ«κΈ°;
			}else{
				if($("#currChangeCheckbox").is(":checked")){
					$(".modally-close-button").click();//νμμ°½ λ«κΈ°
					$(".utility_curren > a").click();//selectBox λ«κΈ° (krwμλ¨)
					
					var baseFromPrice = $scope.lot.EXPE_PRICE_FROM_JSON['KRW'];
					var baseToPrice = $scope.lot.EXPE_PRICE_TO_JSON['KRW'];
					$scope.curren = $scope.selecCurr;
					if($scope.curren != 'KRW'){
// 						$scope.currRate = $scope.currenList.filter(function (curren){ return curren.EXCH_CURR_CD == $scope.curren; })[0].RATE; //νμ¨λ¦¬μ€νΈμ€ νμ¬ μ νλ νμ¨μ rowλ₯Ό λ½μ rateκ°μ μΆμΆ
					
						var fromPrice = $scope.calCurrPrice(baseFromPrice);
						var toPrice = $scope.calCurrPrice(baseToPrice);
						$scope.fromCurrPrice = comma(fromPrice);
						$scope.toCurrPrice = comma(toPrice);

// 						if($scope.lot_no != $("#elClickLotNo").val()){ //λ€λΉκ²μ΄μμμ μ νν lotκ³Ό νμ¬μ§νlotμ΄ λ€λ₯Όκ²½μ° μ νλ lotμ μΆμ κ°μ λ³΄λ‘ κ³μ°
// 							var fromPrice2 = $scope.calCurrPrice($("#startPrice").attr("data-curr"));
// 							var toPrice2 = $scope.calCurrPrice($("#toPrice").attr("data-curr"));
// 							$("#fromCurrPrice2").html(comma(fromPrice2));
// 							$("#toCurrPrice2").html(comma(toPrice2));
// 						}
						
					}
				}else{
					alert($scope.locale == 'ko' ? "μ²΄ν¬λ°μ€μ μ²΄ν¬ν΄ μ£ΌμΈμ." : "Please check the checkbox.");
				}
			}
		}
		
		$scope.commaSetting = function(inNum){
			// μ½€λ§(,)νμ
			//var inNum = $input;
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
		    var unitWords    = ['', 'λ§', 'μ΅', 'μ‘°', 'κ²½'];
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
		
		
		// λ©μΈμΉ΄νκ³ λ¦¬ μ¬μ΄λλ° κ΅¬μ± (2021.03.15  YDH)
// 		$scope.cate_selected = [];
// 		$scope.cate_toggle = function(item, list) {
// 			var idx = list.indexOf(item);
// 			if(idx > -1) {
// 				list.splice(idx, 1);
// 			}else {
// 				$scope.cate_selected = [];
// 				$scope.hashtag_selected = [];
// 				list.push(item);
// 			}
// 			$scope.cate_list = null;
// 			$scope.hashtag_list = null;		
// 			$scope.fav_cds_list = null;	
// 			$scope.cate_list = list;
// 			if($scope.cate_list == null || $scope.cate_list == "undefined" || $scope.cate_list.length < 1) {
// 				$scope.cate_list = ['contemporary'];
// 			}
// 			$scope.loadInitInfo();
// 		};

		// ν΄μ¬νκ·Έ μΉ΄νκ³ λ¦¬ μ¬μ΄λλ° κ΅¬μ± (2021.03.15  YDH)
		$scope.hashtag_selected = [];
		$scope.hashtag_toggle = function(item, list) {
			var idx = list.indexOf(item);
			if(idx > -1) {
				list.splice(idx, 1);
			}else {
				$scope.hashtag_selected = [];
				$scope.cate_selected = [];
				list.push(item);
			}
			$scope.cate_list = null;
			$scope.hashtag_list = null;
			$scope.hashtag_list = list;
			if($scope.hashtag_list == null || $scope.hashtag_list == "undefined" || $scope.hashtag_list.length < 1) {
				$scope.hashtag_list = null;
			}
			$scope.loadInitInfo();
		};			        
										            
		// κ΄μ¬μν λ‘μ§ μΆκ°(2021.03.15 YDH)
		$scope.inteSave = function($input) { 
// 			openCity(event, 'Seoul');//μν ν΄λ¦­μ lot Infoν­ λ³΄μ¬μ£ΌκΈ° 
			if (!$scope.custInfo.CUST_NO){
				alert('λ‘κ·ΈμΈ ν΄μ£ΌμΈμ.\n Please login for use.');
			}
			
			if ($input.inte_stat == "N"){ //κ΄μ¬μν μ­μ  μ²λ¦¬
				var $d = {"baseParms":{"sale_no":$input.sale_no, "lot_no":$input.lot_no}, 
						"actionList":[
						{"actionID":"del_cust_inte_lot", "actionType":"delete", "tableName":"CUST_INTE_LOT", "parmsList":[{}]}
						]};
				common.callActionSet($d, function(data, status) {
					if(data.tables["CUST_INTE_LOT"]["rows"].length > 0) {
						if($scope.locale == 'ko') {
							alert("κ΄μ¬μνμ΄ μ­μ λμμ΅λλ€.");
							window.location.reload(true);
						}else {
							alert("A favorate work has been deleted.");
							window.location.reload(true);
						}
						return true;
					}
				})	
			} else {	
				var $d = {"baseParms":{"sale_no":$input.sale_no, "lot_no":$input.lot_no}, 
						"actionList":[
						{"actionID":"add_cust_inte_lot", "actionType":"insert", "tableName":"CUST_INTE_LOT", "parmsList":[{}]}
						]};
				common.callActionSet($d, function(data, status) {
					if(data.tables["CUST_INTE_LOT"]["rows"].length > 0) {
						if($scope.locale == 'ko') {
							alert("κ΄μ¬μν μΆκ°κ° μλ£λμμ΅λλ€.\nμΆκ°λ κ΄μ¬μνμ κ΄μ¬μν ν­ λλ ACCOUNTνμ΄μ§μμ νμΈνμ€ μ μμ΅λλ€.");
							window.location.reload(true);
						}else {
							alert("A favorate work has been added.\nYou can find your favorite works on your account page.");
							window.location.reload(true);
						}
						return true;
					}
				})
			}
		};
		/* κ΄μ¬μν End */
		
	});
</script> 


<script>
	//[] <--λ¬Έμ λ²μ [^] <--λΆμ  [0-9] <-- μ«μ  
	//[0-9] => \d , [^0-9] => \D
	var rgx1 = /\D/g;  // /[^0-9]/g μ κ°μ νν
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
	
	function CloseWindow(){
		var win=window.open("","_self");
		window.close();
	}
</script>

<body>     
	<div class="pop_wrap" ng-controller="liveAuctionCtl" data-ng-init="init()">   
		<div class="title bidlive_header web_only">    
			<div class="client_onepcssgrid-1200 clearfix" style="padding: 0; height: 45px;">    
				<div class="bidlive_titbox">  
					<h2><a href="/" style="color: #fff;" title="Home" target="_blank">Seoul Auction LIVE</a></h2>            
				</div>  
				<!-- //μΈμ΄ λ©λ΄ language -->  
				<div class="bidlive_utilitybox">         
					<ul>
						<!-- λ‘κ·Έμμ λ²νΌ -->   
						<c:if test="${is_login}">
							<li>
								<c:if test="${is_login}"> 
									<form action="/processLogout" method="post" id="logoutForm">
									  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>     
								</c:if>   
								<a href="javascript:document.getElementById('logoutForm').submit();">LOGOUT</a> 
							</li>
						</c:if>
						<!-- λ‘κ·ΈμΈ λ²νΌ -->  
						<c:if test="${!is_login}">   
							<li><a href="/login">LOGIN</a></li>   
						</c:if> 
						<c:set var="queryString" value="${pageContext.request.queryString}" />
						<c:if test="${not empty param.lang}"> 
		           		 	<c:set var="langParam" value="&lang=${param.lang}" />
		           		 	<c:set var="queryString" value="${fn:replace(queryString,langParam, '')}" />
		           		 	<c:set var="langParam" value="lang=${param.lang}" />
		            		<c:set var="queryString" value="${fn:replace(queryString,langParam, '')}" />
		           		</c:if> 
		           		<c:if test="${not empty queryString}"> 
		           			<c:set var="queryString" value="?${queryString}&" />
		           		</c:if> 
		           		<c:if test="${ empty queryString}"> 
		           			<c:set var="queryString" value="?" />
		           		</c:if>
		           		<c:choose>   
							<c:when test="${is_login}"> <!-- λ‘κ·ΈμΈμ -->
								<li ng-if="locale == 'ko'" class="util_box_lang"><a href="${queryString}lang=en" style="color:#fff;">ENG</a></li>
								<li ng-if="locale != 'ko'" class="util_box_lang"><a href="${queryString}lang=ko" style="color:#fff;">KOR</a></li>	
							</c:when>
							<c:otherwise>  
								<li ng-if="locale == 'ko'" class="util_box_lang"><a href="${queryString}lang=en" style="color:#fff;">ENG</a></li> 
								<li ng-if="locale != 'ko'"class="util_box_lang"><a href="${queryString}lang=ko" style="color:#fff;">KOR</a></li> 	
							</c:otherwise> 
						</c:choose>      
						
						<li class="utility_curren"> 
							<a class="" href="">   
								{{curren}} <!-- curren -->  
								<span class="white_down"></span>       
							</a>  
							<ul class="sub_uti_curren">    
								<li ng-click="currChange('KRW')"><a href="">KRW</a></li> 
								<li ng-repeat="curr in currenList" ng-click="currChange(curr.EXCH_CURR_CD)"><a href="">{{curr.EXCH_CURR_CD}}</a></li> 
							</ul>     
						</li> 
					</ul>    
				</div>    
			</div>   
			<div class="bidlive_notice">  
               <a href="#lorem" target="_modal" class="button white" style="margin-right: 6px;" id="liveCurrChangeCheck"></a>
            </div>
			<div id="lorem" class="modally-init" modally-max-width="600">
				<h1 class="modal-title" id="modalTitle"></h1>
				<p style="text-align: justify; margin: 10px auto 20px; display: table;">
	               	 The currencies other than KRW are shown only for guidance to prospective buyers. All bidding and payment will be in KRW. Seoul Auction is not responsible for any error or omission in the operation of currency converter during the Auction.
                </p>
                <lable for="currChangeCheck">I have read and agree to the above. <input type="checkbox" id="currChangeCheckbox" ></lable><br>
                <div style="margin: 10px 5px 0px 5px;" class="btn_style01 green02"><button ng-click="currChangeOk(false)" style="padding: 2px 13px;">Cancle</button></div>
                <div style="margin: 10px 5px 0px 5px;" class="btn_style01 green02"><button ng-click="currChangeOk(true)" style="padding: 2px 13px;">Ok</button></div>
			</div>  
		</div> <!-- //title -->        
        
	    <!--main -->    
		<div class="client_onepcssgrid-1200 clearfix">     
			<div class="bidlive_resizeFull clearfix">  
				<div class="bidlive_boxLeft web_only clearfix">       
					<div class="bidnav_tapname">  
						<ul> 
							<li class="bidnav_tapOn" data-tab="navitab01">List</li>                      
						</ul>               
					</div>  
					<div class="bidlive_navigationbox">
						<div class="bidlive_navigationblock" id="naviDiv">
							<!-- κ·Όνλ ν­ λ€λΉκ²μ΄μ -->     
							<div class="naviImgbox on" id="navitab01">                     
								<div class="bidnav_naviimg" ng-class="{'nowLot' : lotNavi.LOT_NO == lot.LOT_NO }" ng-repeat="lotNavi in lotNavi" ng-click="elClick(lotNavi.LOT_NO, lotNavi.STAT_CD, lotNavi.ARTIST_NAME_JSON[locale], lotNavi.TITLE_JSON[locale], lotNavi.MATE_NM_EN , lotNavi.EXPE_PRICE_FROM_JSON[base_currency], lotNavi.EXPE_PRICE_TO_JSON[base_currency], lotNavi.EXPE_PRICE_INQ_YN, lotNavi.FILE_NAME, lotNavi.FILE_PATH )">
									<div class="img_navigation">       
										<img ng-if="lotNavi.STAT_CD == 'entry'" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lotNavi.FILE_NAME | imagePath1 : lotNavi.FILE_PATH : 'detail'}}" 
											alt="{{lotNavi.TITLE}}" />      
										<img ng-if="lotNavi.STAT_CD == 'reentry'" oncontextmenu="return false" ng-src="/images/bg/no_image.jpg" />            
									</div>      
									 
									<div ng-if="lotNavi.STAT_CD == 'entry'" class="bidnav_lotinfo">   
										<span ng-if="lotNavi.INTE_LOT_DEL != 'N'" class="wish_btn bidlive_wishbtn" ng-click="inteSave({'sale_no':lotNavi.SALE_NO, 'lot_no':lotNavi.LOT_NO, 'inte_stat':lotNavi.INTE_LOT_DEL});"></span> <!-- κ΄μ¬μνμλλ -->
								        <span ng-if="lotNavi.INTE_LOT_DEL == 'N'" class="wish_btn bidlive_wishbtn bidlive_wishbtn_sele" ng-click="inteSave({'sale_no':lotNavi.SALE_NO, 'lot_no':lotNavi.LOT_NO, 'inte_stat':lotNavi.INTE_LOT_DEL});"></span> <!-- κ΄μ¬μνμΌλ -->
								        <!-- liveμ΄λ―Έμ§  --> 
								        <p style="margin-bottom: 5px;">     
								        	<span class="lotNo" ng-bind="lotNavi.LOT_NO" title="{{lotNavi.LOT_NO}}"></span>  
								        	<span ng-if="lotNavi.LOT_NO == lot.LOT_NO"  class="navi_liveicon"></span>  
								        </p> 
										<p class="textshort artistName" ng-bind="lotNavi.ARTIST_NAME_JSON[locale]" title="{{lotNavi.ARTIST_NAME_JSON[locale]}}"></p>   
										<p class="textshort titleName" ng-bind="lotNavi.TITLE_JSON[locale]" title="{{lotNavi.TITLE_JSON[locale]}}"></p>  
										
										<p class="textshort priceInfo" ng-if="(lotNavi.LOT_NO != lot.LOT_NO) && lotNavi.MAX_BID_PRICE > 0">
											<span ng-if="locale!='en'" style="color: #f00;">λμ°°κ° {{base_currency}} </span><span ng-if="locale!='ko'" style="color: #f00;">Hammer {{base_currency}}</span>  
											<span ng-bind="lotNavi.MAX_BID_PRICE | number : ''" style="color: #f00;" />   
										</p> 
										<p class="textshort priceInfo" ng-if="(lotNavi.LOT_NO == lot.LOT_NO) || !(lotNavi.MAX_BID_PRICE > 0) && lotNavi.EXPE_PRICE_INQ_YN != 'Y' && (lotNavi.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lotNavi.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lotNavi.EXPE_PRICE_TO_JSON[base_currency]) != null && (lotNavi.EXPE_PRICE_FROM_JSON[base_currency]) != null" title="{{lotNavi.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : ''}} ~ {{lotNavi.EXPE_PRICE_TO_JSON[base_currency] | number : ''}}"> 
			    							<span ng-bind="lotNavi.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : ''"></span> 
			    							<span ng-if="(lotNavi.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
			    							<span ng-bind="lotNavi.EXPE_PRICE_TO_JSON[base_currency] | number : ''"></span> 
										</p>    
									</div> 
									 
									<div ng-if="lotNavi.STAT_CD == 'reentry'" class="bidnav_lotinfo">   
										<p ng-if="locale=='ko'" class="tac" style="margin-top:25px; padding-left:0px;">ν μνμ <span class="">μΆνμ΄ μ·¨μ</span>λμμ΅λλ€.</p>
										<p ng-if="locale!='ko'" class="tac" style="margin-top:18px; padding-left:0px;">Cancellation of this artwork has been submitted and approved.</p> 
									</div>  
									
									<input ng-if="lotNavi.LOT_NO == lot.LOT_NO" type="hidden" id="nowLotNo" value="{{lotNavi.LOT_NO}}"/>     
								</div>   
							</div>
						</div> 
					</div>
				</div>
				
				<div class="bidlive_boxCenter clearfix">  
					<div class="bidlive_topbox web_only">   
						<ul>
							<li style="padding: 0 10px; background:#62c3bc; color:#fff; letter-spacing: 2px;">    
								<span class="bidlive_LIVEicon"></span>
								<span class="bidlive_LIVEicon_del"></span> 
								<span style="text-indent:15px;">LIVE</span>  
							</li>  
							<li style="padding: 0 10px;">  
								<span class="num" ng-if="[408,412,418].indexOf(sale.SALE_NO) < 0" ng-bind="sale.SALE_TH | localeOrdinal"></span>
								<span ng-bind="sale.TITLE_JSON[locale]"></span> 
							</li>        
						</ul>
					</div>  
				
					<div class="bidlive_video bidlive_videobox">    
						<div>     
							<video id="llnw-rts-subscriber" width="640" height="480" autoplay controls playsinline muted></video>  
						</div> 
					</div><!-- //video -->  
					
					<!-- notice -->  
                    <div class="bidlivenotice_slide bidlivenotice_slide_en clearfix">     
                        <div class="notice_head notice_head_en">NOTICE</div>   
                        <div class="bidlivenotice_txtbox bidlivenotice_txtbox_en">     
                            <ul>   
                                <li class="bidlivenotice_lifirst">
                                    <span class="">Online bids cannot be withdrawn.</span>      	
                                </li>   
                                <li> 
                                    <span>The order of priority is written > site > online.</span>  
                                </li> 
                                <li>
                                    <span>Online bidding is only available for regular members who have applied for bidding.</span>  
                                </li> 
                                <li>   
                                    The amount of the video may vary, so please bid after checking the bid price on the bid screen.    
                                </li>  
                                <li>  
                                    <span> It is recommended to use a chrome browser.</span>   
                                </li>
                            </ul> 
                        </div>    
                    </div>       
				
					<div class="re-flash">         
						<a onClick="window.location.reload()" style="cursor:pointer; color: #444;">        
							<i class="material-icons" style="vertical-align:middle; font-size: 16px; font-weight: bold; color: #444;">     
								refresh  
							</i>    
							Video Refresh    
						</a>   
					</div> <!-- //μλ‘κ³ μΉ¨ -->  
					     
					<!-- tabs -->     
					<div class="bidlive_tab web_only clearfix" style="padding-bottom: 10px;">    
						<div class="tab boxCenter_tab">    
							<button class="tablinks" onclick="Centertab(event, 'Lot_tab')" id="defaultOpen">Lot</button>
							<button class="tablinks" onclick="Centertab(event, 'BidHistory_tab')"><span ng-if="locale=='ko'">μμ°°κΈ°λ‘</span><span ng-if="locale=='en'">Bid history</span></button>
							<button class="tablinks" onclick="Centertab(event, 'WishList_tab')"><span ng-if="locale=='ko'">κ΄μ¬μν</span><span ng-if="locale=='en'">Wish List</span></button>      
						</div>      
						
						<div id="Lot_tab" class="tabcontent bidlive_tapcation clearfix">                     
							<!-- lot μ λ³΄  -->    
							<div class="tab_lotcaption" style="position:relative;"> 
								<input type="hidden" id="elClickLotNo" value="lot.LOT_NO" />     
								<div class="bidlive_tapimg">      
									<img ng-hide="isReentry" id="imgSrc" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" alt="{{lot.TITLE}}" />
									<img ng-show="isReentry" id="imgSrc" oncontextmenu="return false" ng-src="/images/bg/no_image.jpg"  alt="no image"/> 
								</div>           
								<div ng-hide="isReentry" class="tab_box_img_caption" style="float:left; width: 60%;">     
									<span>Lot. </span><span id="lotNo" ng-bind="lot.LOT_NO"></span> 
									<p class="textshort" style="font-size: 16px; padding-top: 10px; height: 19px;" id="artistName" ng-bind="lot.ARTIST_NAME_JSON[locale]"></p> 
									<p class="textshort" style="font-size: 16px; height: 19px;" id="titleName" ng-bind="lot.TITLE_JSON[locale]"></p>  
									<p class="textshort lot_price" style="margin-top: 10px; font-size: 12px; font-weight: bold;" ng-show="!isPriceInqYn">       
										<span id="startPrice" data-curr="{{lot.EXPE_PRICE_FROM_JSON[base_currency]}}" ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
		    							<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
		    							<span id="toPrice" data-curr="{{lot.EXPE_PRICE_TO_JSON[base_currency]}}" ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
									</p> 
									<!-- νμ¨ -->    
									<p  class="textshort bidlive_usdcurrency" ng-show="curren != 'KRW' && !isPriceInqYn">     
										( {{curren}} <span id="fromCurrPrice2" >{{fromCurrPrice}}</span> 
		    							<span> ~ </span>	
		    							<span id="toCurrPrice2">{{toCurrPrice}}</span> )  
									</p>   
                                    <div style="padding: 10px 0;">  
								 	   <a ng-href="{{'/lotDetail?sale_no=' + sale.SALE_NO + '&lot_no=' + (elClickLotNo ? elClickLotNo : lot_no)}}" target="_blank" style="color: #999; font-size:12px; font-weight: bold; border-bottom: 1px solid #999; padding-bottom: 2px;">
								 	   Art Detail</a>    
                                    </div>
                                    <!-- νμ¬ lotμ΄λ λ²νΌ -->
                                    <span style="position:absolute; top:7px; right:0; cursor:pointer;  font-size: 12px; color: #555; font-weight:900;" 
										ng-click="nowLotMove(lot.LOT_NO,lot.ARTIST_NAME_JSON[locale],lot.TITLE_JSON[locale], lot.MATE_NM_EN, lot.EXPE_PRICE_FROM_JSON[base_currency], lot.EXPE_PRICE_TO_JSON[base_currency], lot.EXPE_PRICE_INQ_YN, lot.FILE_NAME, lot.FILE_PATH)">
										<span class="now_lotmove">NOW LOT</span>  
									</span>      
								</div> 
								<div ng-show="isReentry" class="tab_box_img_caption" style="float:left; width: 60%;">  
                                      	<p class="" style="margin-top:10px; padding-left:20px;" ><span class="">Cancellation of this artwork has been submitted and approved.</p>
								</div>   
							</div>     
						</div> 
						
						<div id="BidHistory_tab" class="tabcontent clearfix" style="border: 0;">       	 				 
							<!-- //μμ°°κΈ°λ‘ -->         
							<div class="tab_history">         
								<table class="bid_history_table"> 
									<caption style="text-indent: -9999px;"><span ng-if="locale=='ko'">μμ°°κΈ°λ‘</span><span ng-if="locale=='en'">Bid history</span></caption> 
									<colgroup>  
										<col width="15%" />     
										<col width="35%" />      
										<col width="35%" />   
										<col width="15%" />     
									</colgroup>    
									<thead> 
										<tr>
											<th scope="col">
												<div class="bidtable_tit">
													Lot
												</div>
											</th> 
											<th scope="col">
												<div class="bidtable_tit">
													Max bid price
												</div>
											</th>    
											<th scope="col">
												<div class="bidtable_tit">
													Sell price
												</div>
											</th>     
											<th scope="col">
												<div class="bidtable_tit">
													satus  
												</div>
											</th>   
										</tr>  
									</thead>
									<tbody style="text-align:center;"> 
										<tr ng-repeat="myBidHistory in myBidHistory">
											<td ng-bind="myBidHistory.LOT_NO"></td> 
											<td ng-bind="myBidHistory.LAST_BID_PRICE | number : 0"></td>  
											<td ng-bind="myBidHistory.HAMMER_BID_PRICE | number : 0"></td>
											<td ng-if="myBidHistory.LOT_NO != lot.LOT_NO && myBidHistory.LAST_BID_PRICE != myBidHistory.HAMMER_BID_PRICE"></td> 
											<td ng-if="myBidHistory.LOT_NO == lot.LOT_NO"></td> <!-- μ§νμ€ -->
											<td ng-if="myBidHistory.HAMMER_STAT == 'hammer'">Hammer</td>
										</tr>
									</tbody> 
								</table> 
							</div>   
						</div> <!-- //BidHistory_tab -->         
						
						<!-- κ΄μ¬μν λ³΄κΈ° --> 
						<div id="WishList_tab" class="tabcontent clearfix" style="border: 0;"> 
							<div class="bidlive_wishListwarp"> 
								<div ng-if="lotFAV.length <= 0" style="display:flex; justify-content: center; align-items: center; height: 100%;">
									<p style="color: #999;">Your list is empty</p>
								</div> 
								<div class="wishList_box" ng-if="lotFAV.length > 0" ng-repeat="lot in lotFAV">   
									<div class="img_navigation">             
										<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" 
											alt="{{lot.TITLE}}" /> 
									</div> 
									<div class="bidnav_lotinfo wishilist_info">  
										<span class="lotNo" ng-bind="lot.LOT_NO" title="{{lot.LOT_NO}}"></span>   
										<span ng-if="lot.INTE_LOT_DEL != 'N'" class="wish_btn bidlive_wishbtn" ng-click="inteSave({'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO, 'inte_stat':lot.INTE_LOT_DEL});"></span> <!-- κ΄μ¬μνμλλ -->
							        	<span ng-if="lot.INTE_LOT_DEL == 'N'" class="wish_btn bidlive_wishbtn bidlive_wishbtn_sele" ng-click="inteSave({'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO, 'inte_stat':lot.INTE_LOT_DEL});"></span> <!-- κ΄μ¬μνμΌλ --> 
							        	<span ng-if="lot.STAT_CD != 'reentry'"> <%-- μΆνμ·¨μ μ¬λΆ νμ --%>
											<p class="textshort artistName" ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}" style="margin-top: 5px;"></p>    
											<p class="textshort titleName" ng-bind="lot.TITLE_JSON[locale]" title="{{lot.TITLE_JSON[locale]}}"></p>    
											<p class="textshort priceInfo" ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" title="{{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0}} ~ {{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}}">
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
				    							<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	 
				    							<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
											</p> 
										</span>
										<div style="text-align:right;">     
											<a style="color: #999; font-size:12px; font-weight: bold; text-decoration: underline;" ng-href="{{'/lotDetail?sale_no=' + sale.SALE_NO + '&lot_no=' + lot.LOT_NO}}" target="_blank">
												 Art detail       
											</a>          
										</div> 
									</div>
								</div><!-- //wishList_box -->   
							</div> <!-- //bidlive_wishListwarp -->      
						</div> <!-- //WishList_tab -->    
						
					</div> <!-- //bidlive_tab -->      	 
				</div><!-- //bidlive_boxCenter -->       
			
				<div class="bidlive_boxRight clearfix">     
					<div class="bidlive_Rtop">
						<div class="bidlive_topbox">  
							<ul> 
								<li style="padding: 0 15px;">LOT {{lot.LOT_NO}}</li> 
								<li class="m_utility_curren m_only">  
									<a class="" href="">   
										{{curren}} <!-- curren --> 
										<span class="white_down"></span>      
									</a>  
									<ul class="m_sub_uti_curren">    
										<li ng-click="currChange('KRW')"><a href="">KRW</a></li>    
										<li ng-repeat="curr in currenList" ng-click="currChange(curr.EXCH_CURR_CD)"><a href="">{{curr.EXCH_CURR_CD}}</a></li>     
									</ul>       
								</li>   
								<li style="padding: 0 10px; float:right;">{{lot.LOT_NO}}/<span style="color: #999;">{{sale.MAX_LOT_NO}}</span></li>
							</ul>  
						</div>   
						<!-- νμ¬ μ§ν μμ°° μ λ³΄-->
						<div class="bidlive_Rcaption">     
							<div class="Rcaption_imgbox">           
								<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" alt="{{lot.TITLE}}" />    
							</div>        
							<div class="Rcaption_caption">
								<p class="textshort bidimg_tit"><span ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}"></span></p> 
								<p class="textshort bidimg_tit" ng-bind="lot.TITLE_JSON[locale]" title="{{lot.TITLE_JSON[locale]}}"></p> 
								<p class="textshort" ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" style="font-size:12px; font-weight: 900;" title="{{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0}} ~ {{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}}">                      
									<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
	    							<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
	    							<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
								</p>    
								<!-- νμ¨ --> 
								<p class="textshort bidlive_usdcurrency" ng-if="curren != 'KRW' && lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" title="{{curren}}{{fromCurrPrice}} ~ {{toCurrPrice}}">      
									( {{curren}} <span id="fromCurrPrice1">{{fromCurrPrice}}</span> 
	    							<span> ~ </span>	
	    							<span id="toCurrPrice1">{{toCurrPrice}}</span> ) 
								</p>
							</div> 
						</div><!--//bidlive_Rcaption  --> 
						 
						<!-- νμ¬κ°/νΈκ°/μμ°°κ° -->  
						<div class="Rcaption_price clearfix">     
							<div class="Rcaption_pricetxt">     
								<!-- νμ¬κ° -->
								<div class="Rcaption_priceCurrent">
									<p> 
										<span ng-if="locale=='ko'">νμ¬κ°</span><span ng-if="locale!='ko'">Current price</span></font>
									</p>
									<p>   
										<strong style="vertical-align:middle;"><span ng-if="sale.CURR_CD=='KRW'">KRW</span><span ng-if="sale.CURR_CD=='HKD'">HKD</span>&nbsp;{{lot.LAST_PRICE | number:0}}<!-- &nbsp;[{{sale.CURR_CD}}] --></strong>
									</p>    
									<!-- νμ¨ -->    
									<p class="textshort bidlive_usdcurrency" ng-if="curren != 'KRW' && lot.EXPE_PRICE_FROM_JSON[base_currency]">     
										( {{curren}} <span id="NowCurrPrice"></span> )  
									</p>     
								</div>     
								   
								<!-- μμ°°κ°(μ£Όμ λ° μ§μ°λ©΄ μλ¨! μ§μ°λ©΄ μμ°°λ²νΌ μλ μν¨) -->  
								<div class="Rcaption_priceBid" style="display:none;">   
									<label for="bidPriceInputOnline" style="vertical-align:middle; overflow: hidden;">           
										<font style="color:#ff0000;">   
											<span ng-if="locale=='ko'">μμ°°κ°</span><span ng-if="locale!='ko'">Biding price</span>
											<strong><span ng-if="sale.CURR_CD=='KRW'">οΏ¦</span><span ng-if="sale.CURR_CD=='HKD'">HKD</span></strong>	
										</font>  
									</label>  
									<input type="text" style="color:#ff0000; font-weight:bold; border: 0; padding-left: 0;" ng-model="bid_price_input_online" id="bidPriceInputOnline" name="bidPriceInputOnline" onkeyup="getNumber(this)" readonly/>
								</div> <!-- //Rcaption_priceBid --> 
						    </div> <!-- //Rcaption_pricetxt -->     
								    
							<!-- μμ°° λ²νΌ (κ³ κ°μ©) --> 	
							<div class="Rcaption_Bidbtnbox clearfix">  
								<span ng-if="custInfo.CUST_NO > 0 && lot.LIVE_CLOSE_YN=='N' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && custInfo.PADD_NO != 0">
									<button type="button" ng-click="liveLotBidPriceSave('online');" ng-disabled="lot.IS_WIN == 'Y'">  
										<span ng-if="locale=='ko'"><span ng-if="lot.IS_WIN == 'N'">μμ°°νκΈ°</span><span ng-if="lot.IS_WIN == 'Y'">μ΅κ³ κ° μμ°°μ€</span></span>   	
							  			<span ng-if="locale!='ko'"><span ng-if="lot.IS_WIN == 'N'">Bid</span><span ng-if="lot.IS_WIN == 'Y'">Highest bidding</span></span>
							  			<p style="text-align:center; width: 100%; margin: 0 auto;"> 
											<font style="font-weight:bold;">
												<strong><span ng-if="sale.CURR_CD=='KRW'">KRW</span><span ng-if="sale.CURR_CD=='HKD'">HKD</span></strong>
												<span ng-bind="bid_price_input_online" id="bidPriceInputOnline" >&nbsp;[{{sale.CURR_CD}}]</span> 
											</font>  
										</p>   
										<!-- νμ¨ -->         
										<p class="textshort" ng-if="curren != 'KRW'" style="font-size: 12px;">       
											( {{curren}} <span ng-bind="bid_price_input_online_CURR" id="bidPriceInputOnlineCurr"></span> )  
										</p> 
							  		</button>   
							  	</span>   
							  	<span ng-if="custInfo.CUST_NO > 0 && lot.LIVE_CLOSE_YN!='N' && offBidList.length > 0 && custInfo.PADD_NO > 0">
									<button type="button" ng-disabled="lot.IS_WIN == 'Y'">   
						  				<span ng-if="locale=='ko'">μμ°°λ§κ°</span> 	 
						  				<span ng-if="locale!='ko'">Bid Closed</span>  
							  		</button> 
							  	</span> 
							  	<span ng-if="custInfo.CUST_NO > 0 && lot.LIVE_CLOSE_YN!='N' && offBidList.length == 0 && custInfo.PADD_NO > 0">
									<button type="button">  
						  				<span ng-if="locale=='ko'">μμ°°μ€λΉ</span> 	
						  				<span ng-if="locale!='ko'">Bid Ready</span>
							  		</button> 
							  	</span>
							  	<span ng-if="!custInfo.CUST_NO">
									<button type="button" onClick="location.href='/login'">
										<spring:message code="label.go.bid.loginlog" /> 
									</button>	
							  	</span>
							  	<!-- ν¨λ€λ²νΈ μλ κ²½μ° -->
							  	<span ng-if="custInfo.CUST_NO > 0 && !custInfo.PADD_NO">
									<button type="button" disabled > 
									<span ng-if="locale=='ko'">μ¬μ  μ μ²­νμ  λΆλ§ μμ°° κ°λ₯ν©λλ€</span>
									<span ng-if="locale=='en'">Only those who have applied in advance can bid</span>
									</button>	
							  	</span>  
							</div><!-- //bidlive_clinet_btn -->    
						</div> <!-- //Rcaption_price -->  
					</div> <!-- //bidlive_Rtop -->     
					
					<!-- κΈ°μ€ν΅ν/id/pw--> 
					<div class="clearfix" style="padding: 10px;">                  
						<div class="bidlive_accountlist">       
							<span><strong>ID</strong>: <span ng-bind="custInfo.LOGIN_ID"></span></span>   
							<span><strong>My PaddleNo. <span ng-bind="custInfo.PADD_NO" style="font-weight:900; color:#0026f9;"></span></strong></span> 
						</div>     
						<div class="bidlive_currency"><span ng-if="locale=='ko'">ν΅ν:</span><span ng-if="locale!='ko'">Currency:</span>&nbsp;[{{sale.CURR_CD}}]</div>
					</div> 
					 
					<!-- tabs -->  
					<div class="bidlive_tab m_only clearfix">       
						<div class="tab m_tab">         
							<button class="tablinks m_tablinks" onclick="Downtab(event, 'A1')" id="TabOpen">Lot</button>
							<button class="tablinks m_tablinks" onclick="Downtab(event, 'B1')"><span ng-if="locale=='ko'">μμ°°κΈ°λ‘</span><span ng-if="locale=='en'">Bid history</span></button>
							<button class="tablinks m_tablinks" onclick="Downtab(event, 'C1')"><span ng-if="locale=='ko'">κ΄μ¬μν</span><span ng-if="locale=='en'">Wish List</span></button>     
						</div>    
					</div>        
					      
					<div id="A1" class="bid_livebox_table tabtab clearfix"> 
						<!-- scroll START (2018.04.18 YDH) -->   
						<div class="fixed-table-container A1_table">    
							<div class="fixed-table-header"></div> 
							<div class="fixed-table-wrap">     
								<table id="tbl_employee" class="fixed-table"> 
									<colgroup> 
										<col width="50%"/>  
										<col width="50%"/>  
									</colgroup>
									<thead>
										<tr> 
											<th scope="col"> 
												<div class="th-text client_th-text" style="width: 50%;"><span>Paddle No</span>
												</div>  
											</th>
											<th scope="col">
												<div class="th-text client_th-text" style="width: 50%;">  
													<span ng-if="locale == 'ko'">μμ°°κΈμ‘</span><span ng-if="locale != 'ko'">Bid Price</span>
												</div>
											</th>      
										</tr> 
									</thead>
									<tbody id="tblOffBidListBody">      
										<tr ng-show="offBidList.length == 0" class="Rorr"><td colspan="2"><span ng-if="locale == 'ko'">κ³§ μμ°°μ΄ μμλ©λλ€.</span><span ng-if="locale != 'ko'">The bidding stats soon.</span></td></tr>
										<tr ng-repeat="bid in offBidList"> 
											<td ng-if="bid.BID_NOTICE == null"> 
												<span ng-if="bid.BID_KIND_CD == 'online' && locale == 'ko'"><font color="blue" style="font-weight:bolder">{{bid.ONLINE_BID_ID}}</font></span>
												<span ng-if="bid.BID_KIND_CD != 'online' && locale == 'ko'">νμ₯ μμ°°</span>
												<span ng-if="bid.BID_KIND_CD == 'online' && locale != 'ko'"><font color="blue" style="font-weight:bolder">{{bid.ONLINE_BID_ID}}</font></span>
												<span ng-if="bid.BID_KIND_CD != 'online' && locale != 'ko'">Floor</span>
											</td>     
											<td ng-if="bid.BID_NOTICE == null">
												<span ng-if="$first"><font color="red" style="font-weight:bolder">{{bid.BID_PRICE | number:0}}</font></span>
												<span ng-if="!$first">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.BID_PRICE | number:0}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.BID_PRICE | number:0}}</span>
												</span>
											</td><!-- background: #f4f4f4;  -->
											<td ng-if="bid.BID_NOTICE != null && $first" colspan="2" style="color:red; text-align:center; background: #f4f4f4; "><span ng-if="locale == 'ko'">{{bid.BID_NOTICE}}</span><span ng-if="locale != 'ko'">{{bid.BID_NOTICE_EN}}</span></td>
										</tr> 
									</tbody>
								</table>
							</div>
						</div>   
					</div> <!--//bid_livebox_table--> 
							       
					<!-- //μμ°°κΈ°λ‘ -->   
					<div id="B1" class="bid_livebox_table tabtab client_m_only">  
						<!-- scroll START (2018.04.18 YDH) -->     
						<div class="fixed-table-container B1_table">    
							<div class="fixed-table-header"></div>  
	       						<div class="fixed-table-wrap B1_history_tablebox"> 
								<table id="tbl_employee" class="fixed-table">   
									<caption style="text-indent: -9999px;" ng-if="locale=='ko'">μμ°°κΈ°λ‘</caption> <caption style="text-indent: -9999px;" ng-if="locale=='en'">bid history</caption> 
									<colgrop> 
										<col width="15%" />  
										<col width="35%" />       
										<col width="35%" />      
										<col width="15%" />        
									</colgrop>    
									<thead> 
										<tr> 
											<th scope="col">
												<div class="th-text th_history_txt" style="width:15%;">   
													Lot		
					                            </div> 
											</th>   
											<th scope="col">
												<div class="th-text th_history_txt" style="width:35%;"> 
													Max bid price	
					                            </div>
											</th> 
											<th scope="col">
												<div class="th-text th_history_txt" style="width:35%;">
													Sell price
					                            </div>
											</th>
											<th scope="col">
												<div class="th-text th_history_txt" style="width:15%;"> 
													satus	
					                            </div> 
											</th>  
										</tr>   
									</thead>
									<tbody id="tblOffBidListBody" style="text-align:center;"> 
										<tr ng-repeat="myBidHistory in myBidHistory">
											<td ng-bind="myBidHistory.LOT_NO"></td> 
											<td ng-bind="myBidHistory.LAST_BID_PRICE | number : 0"></td>   
											<td ng-bind="myBidHistory.HAMMER_BID_PRICE | number : 0"></td>
											<td ng-if="myBidHistory.LOT_NO != lot.LOT_NO && myBidHistory.LAST_BID_PRICE != myBidHistory.HAMMER_BID_PRICE"></td> 
											<td ng-if="myBidHistory.LOT_NO == lot.LOT_NO"></td> <!-- μ§νμ€ -->
											<td ng-if="myBidHistory.HAMMER_STAT == 'hammer'">Hammer</td>
										</tr>
									</tbody>  
								</table> 
							</div> 
						</div>  
					</div> <!--//μμ°°κΈ°λ‘-->	
					
					<!-- κ΄μ¬μν --> 
					<div id="C1" class="bid_livebox_table tabtab clearfix">    
						<div class="m_bidlive_wishListwarp m_only">   
							<div ng-if="lotFAV.length <= 0" style="display:flex; justify-content: center; align-items: center; height: 60px;">
								<p style="color: #999;">Your list is empty</p> 
							</div>
							<div class="m_wishList_box" ng-if="lotFAV.length > 0" ng-repeat="lot in lotFAV">       
								<div class="img_navigation">        
									<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" 
										alt="{{lot.TITLE}}" />        
								</div>
								<div class="bidnav_lotinfo wishilist_info">    
									<span class="lotNo" ng-bind="lot.LOT_NO"></span> 
									<span ng-if="lot.INTE_LOT_DEL != 'N'" class="wish_btn bidlive_wishbtn" ng-click="inteSave({'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO, 'inte_stat':lot.INTE_LOT_DEL});"></span> <!-- κ΄μ¬μνμλλ -->
							        <span ng-if="lot.INTE_LOT_DEL == 'N'" class="wish_btn bidlive_wishbtn bidlive_wishbtn_sele" ng-click="inteSave({'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO, 'inte_stat':lot.INTE_LOT_DEL});"></span> <!-- κ΄μ¬μνμΌλ -->      
							        <span ng-if="lotNavi.STAT_CD != 'reentry'"> <%-- μΆνμ·¨μ μ¬λΆ νμ --%>  
										<p class="textshort artistName" ng-bind="lot.ARTIST_NAME_JSON[locale]" style="margin-top: 5px;"></p>     
										<p class="textshort titleName" ng-bind="lot.TITLE_JSON[locale]"></p>     
										<p class="textshort priceInfo" ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null">
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
			    							<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
			    							<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
										</p>
									</span> 
									<div style="text-align:right;">     
										<a style="color: #999; font-size:12px; font-weight: bold; text-decoration: underline; margin-right:3px;" ng-href="{{'/lotDetail?sale_no=' + sale.SALE_NO + '&lot_no=' + lot.LOT_NO}}" target="_blank">
											Art Detail       
										</a>         
									</div>  
								</div>   
							</div><!-- //m_wishList_box -->
						</div><!-- //bidlive_wishListwarp -->      
					</div> 					
				</div><!-- //bidlive_boxRight --> 
				
				<div class="btn_wrap" style="margin-bottom: 10px; clear:both;">     
					<span class="btn_style01 gray mid btn_pop_close" id="cancelBtn">
						<button type="button"><spring:message code="label.close" /></button>
					</span> 
				</div>  
				
				<!--footer-->     
				<div style="background-color:#f1f1f1; padding:10px;"> 
					<div align="center"> 
		    			<p style="color: #000; font-size:11px; padding-top:20px; padding-bottom:20px; line-height:18px;">
		    				* LOT information and Current Bidding may be delayed depending on network speed.
						</p> 
					</div>
				</div><!--footer-->
			</div> <!-- //bidlive_resizeFull -->
		</div><!-- // 1200 -->      
	</div> <!-- pop_wrap --> 
</body>
<script>
	$(function(){ /* notice μ¬λΌμ΄λ λ°°λ */   
		setInterval(function(){
			if(matchMedia("screen and (min-width:1100px)").matches) {                  
				$(".bidlivenotice_txtbox_en>ul").delay(3500);     
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-31px"});    
				$(".bidlivenotice_txtbox_en>ul").delay(3500); 
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-60px"});  
				$(".bidlivenotice_txtbox_en>ul").delay(3500); 
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-90px"});       
				$(".bidlivenotice_txtbox_en>ul").delay(3500); 
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-120px"});     
				$(".bidlivenotice_txtbox_en>ul").delay(3500);       
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"0"});   
			};
			if(matchMedia("(min-width:769px) and (max-width:1099px)").matches){                        
				$(".bidlivenotice_txtbox_en>ul").delay(3500);     
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-30px"});              
				$(".bidlivenotice_txtbox_en>ul").delay(3500);  
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-65px"});                             
				$(".bidlivenotice_txtbox_en>ul").delay(3500);
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-95px"});                               
				$(".bidlivenotice_txtbox_en>ul").delay(3500);   
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-121px"});                      
				$(".bidlivenotice_txtbox_en>ul").delay(3500);        
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"0px"}); 
			};
			if(matchMedia("(min-width:320px) and (max-width: 768px)").matches) {                              
				$(".bidlivenotice_txtbox_en>ul").delay(3500);      
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-46px"});            
				$(".bidlivenotice_txtbox_en>ul").delay(3500);       
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-86px"});                     
				$(".bidlivenotice_txtbox_en>ul").delay(3500);
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-127px"});                          
				$(".bidlivenotice_txtbox_en>ul").delay(3500); 
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"-168px"});                      
				$(".bidlivenotice_txtbox_en>ul").delay(3500);       
				$(".bidlivenotice_txtbox_en>ul").animate({marginTop:"0px"});          
			}; 
		}); 
	});   
	
	// μ νΈλ¦¬ν° νμ¨ λ©λ΄
	$(document).ready(function(){  
		$(".utility_curren > a, .m_utility_curren > a").click(function(){    
			$(".sub_uti_curren, .m_sub_uti_curren").stop().slideToggle("fast"); 
			$(".white_down").toggleClass("on");    
		});   	  
				
		
		$(".sub_uti_curren > li > a, .m_sub_uti_curren > li > a").click(function(){            
			$(".sub_uti_curren, .m_sub_uti_curren").stop().slideToggle("fast"); 
			$(".white_down").toggleClass("on");   
		});   
	});
		  
	
	//μ΄λ―Έμ§ λ€λΉκ²μ΄μ ν­
	$(document).ready(function(){ 
		$(".bidnav_tapname ul li").click(function(){
			var tab_navi = $(this).attr('data-tab'); 
			
			$('.bidnav_tapname ul li').removeClass("bidnav_tapOn");
			$('.naviImgbox').removeClass("on");     
			
			$(this).addClass("bidnav_tapOn");     
			$("#"+tab_navi).addClass('on');             
		});  
	});  
	
	
	/* μΉ λ²μ  μ€μ νλ¨ ν­ λ©λ΄ */   
	function Centertab(evt, Centertab_name) {
		var i, tabcontent, tablinks; 
		tabcontent = document.getElementsByClassName("tabcontent");      
		for (i = 0; i < tabcontent.length; i++) {  
			tabcontent[i].style.display = "none";  
		}
		tablinks = document.getElementsByClassName("tablinks"); 
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className.replace(" active",""); 
		} 
		document.getElementById(Centertab_name).style.display = "block"; 
		evt.currentTarget.className += " active";   
	} 
	
	document.getElementById("defaultOpen").click();  
	
	/* mobile νλ¨ ν­ λ©λ΄ */   
	function Downtab(evt, Downtab_name){
		var t, tabtxt, m_tablinks;
		tabtxt = document.getElementsByClassName("tabtab"); 
		for (t = 0; t < tabtxt.length; t++) {
			tabtxt[t].style.display = "none";
		}
		m_tablinks = document.getElementsByClassName("m_tablinks"); 
		for (t = 0; t < m_tablinks.length; t++) {
			m_tablinks[t].className = m_tablinks[t].className.replace(" active",""); 
		}
		document.getElementById(Downtab_name).style.display = "block"; 
		evt.currentTarget.className += " active"; 
	}
	document.getElementById("TabOpen").click();
	
	 
	/* LIVE κΉλΉ‘μ΄λ ν¨κ³Ό */  
	var element = $(".bidlive_LIVEicon"); 
	var delelement = $(".bidlive_LIVEicon_del");     
	
	var shown = true;   
	
	setInterval(toggle, 1000);      
	
	function toggle() {
		if(shown){
			element.hide();   
			shown = false;
			
			delelement.show();  
		}else{
			element.show();   
			shown = true;  
			
			delelement.hide();  
		}; 
	};   
</script>   

<script src="/js/simple.js?ver=1.0.0"></script>
</html>