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
	<meta name="viewport" content="width=device-width, initial-scale=1.0" http-equiv="X-UA-Compatible" content="IE=edge"> 
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

<%-- YDH μΆκ° μμ--%>
<script type="text/javascript" src="/js/angular/paging.js"></script>

<script>
	app.value('locale', 'en');
	app.value('is_login', 'false');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN

	$(document).ready(function(){
		$("#cancelBtn").click(function(){
			console.log("ν΄λ¦­!!!!!!!!!");
			self.opener = self;
			window.close();
		});
	});
	
	app.controller('liveAuctionCtl', function($scope, consts, common, $interval) {
		$scope.cnt = 0; // λ€λΉκ²μ΄μ μ€νμ¬λΆ νμΈ(2018.04.25)
		$scope.lot_move_init = "NO";
		
		$scope.loadLiveAuction = function(){
			$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
					"actionList":[
					{"actionID":"liveSaleInfo", "actionType":"select" , "tableName": "SALE"},
					{"actionID":"liveLotInfo", "actionType":"select" , "tableName": "LOT"},
					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
					{"actionID":"offBidList", "actionType":"select", "tableName":"BID_OFF_LIST"}, // Live μ§ν LOTλ²νΈ μμ°°κΈμ‘ νΈμΆ μΆκ°(2018.04.18 YDH)
					{"actionID":"liveLotNaviList", "actionType":"select", "tableName":"LOT_NAVI", "parmsList":[{}]}, // navi μ΅μ ν. Editλͺ¨λμμλ§ μ€νν  κ²
				]};	 	   	
			common.callActionSet($d, $s);
		}
	 		
		var $s = function(data, status) { 
			$scope.sale = data["tables"]["SALE"]["rows"][0];
			$scope.lot = data["tables"]["LOT"]["rows"][0];
			$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
			$scope.offBidList = data["tables"]["BID_OFF_LIST"]["rows"];// Live μ§ν LOTλ²νΈ μμ°°κΈμ‘ νΈμΆ μΆκ°(2018.04.18 YDH)
			$scope.lot_navi = data["tables"]["LOT_NAVI"]["rows"];// Live μ§ν LOTλ²νΈ 5κ±΄ νΈμΆ μΆκ°(2018.04.19 YDH). Editλͺ¨λμμλ§ μ€νν  κ²

			$scope.base_currency = $scope.sale.CURR_CD;
			$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
			
			$scope.live_lot_no = $scope.lot.LOT_NO;  //νμ¬ μ§νμ€μΈ LOT λ²νΈ
			$scope.max_lot_no = $scope.sale.MAX_LOT_NO;  // LOT λ²νΈ MAX λ²νΈ
		
			$scope.sale_no = $scope.sale.SALE_NO;
			$scope.lot_no = $scope.lot.LOT_NO;		//μ‘°νλ LOTμ λ¬΄μ‘°κ±΄ λκΈ°ν
			
			//μΆμ κ° λ³λμΈ κ²½μ° μ μΈ
			if ($scope.lot.EXPE_PRICE_INQ_YN == 'N'){	
				if($scope.lot.LAST_PRICE != null && $scope.lot.LAST_PRICE != ''){
					$scope.bid_price_input_online = $scope.commaSetting($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE); //κ³ κ°μ© μμ°°κΈμ‘(μ΅κ³ κ°+νΈκ°) μ€μ 				
			 		$scope.bid_price_input_online_KO = $scope.numberToKorean($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE);	
				}else{
					if($scope.lot.START_PRICE == null || $scope.lot.START_PRICE == ''){
						$scope.lot.START_PRICE = 0;
					}
					$scope.bid_price_input_online = $scope.commaSetting($scope.lot.START_PRICE); //κ³ κ°μ© μμ°°κΈμ‘(μμκ°) μ€μ 
			 		$scope.bid_price_input_online_KO = $scope.numberToKorean($scope.lot.START_PRICE);	
				}
			} else {//μΆμ κ° λ³λ λ¬Έμμ μ²λ¦¬
				$scope.bid_price_input_online = ""; //κ³ κ°μ© μμ°°κΈμ‘(μμκ°) μ€μ 
		 		$scope.bid_price_input_online_KO = "";	
			}
			
	 		// μ΅μ΄ μ€νλ κ²½μ° μ€ν. μ΅μ΄ μ€νμμλ mid_lot_noλ NULL!
			if($scope.mid_lot_no == null || $scope.mid_lot_no == 'undefined'){
				$scope.naviMoveInit($scope.live_lot_no);
			}
			// λ€λΉκ²μ΄μ λ²νΌ μ€νν μ μ΄ μλ κ²½μ°μλ§ λ€λΉκ²μ΄μ λ¦¬μ€νΈλ λκΈ°ν. (2018.04.25)
			if ($scope.cnt == 0 && (($scope.mid_lot_no+2) < $scope.live_lot_no ||($scope.mid_lot_no-2) > $scope.live_lot_no)){
				$scope.naviMoveInit($scope.live_lot_no);
			}
		}
		
		/* $scope.Cancel = function() {
			self.opener = self;
			window.close();
			//self.close(); 		  
		}; */
		
		// Live μ§ν LOTλ²νΈ μμ°°κΈμ‘ λ‘μ§ μΆκ°(2018.04.17 YDH), bid_priceλ μ½€λ§(,)μ κ±°
		$scope.liveLotBidPriceSave = function($input) {	
			if ($input == 'online'){
				$scope.bid_price_input_online = $("#bidPriceInputOnline").val();
				$scope.bid_price = $scope.bid_price_input_online.replace(/[^\d]+/g,'');
				console.log("####online Bid####");console.log($scope.bid_price);
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
		};
		
		// Live νλ¨ λ€λΉκ²μ΄μ λ¦¬μ€νΈ
		$scope.liveLotNaviList = function($input){
			var $d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$input}, 
						"actionList":[
						{"actionID":"liveLotNaviList", "actionType":"select", "tableName":"LOT_NAVI", "parmsList":[{}]}
					]};
			
			common.callActionSet($d, function(data, status) {
				$scope.lot_navi = data["tables"]["LOT_NAVI"]["rows"];// Live μ§ν LOTλ²νΈ 5κ±΄ νΈμΆ μΆκ°(2018.04.19 YDH)
				$scope.mid_lot_navi = data["tables"]["LOT_NAVI"]["rows"][0]; // Live μ§ν MID_LOT_NO νΈμΆ μΆκ°(2018.04.19 YDH)
				
				$scope.mid_lot_no = $scope.mid_lot_navi.MID_LOT_NO;
				
				$scope.loadLiveAuction();
			})
		};
		
		$scope.naviMove = function($input){
			$scope.cnt = $scope.cnt + 1; //λ€λΉκ²μ΄μ μ€νν Count λμ 
			
			if($scope.mid_lot_no == null || $scope.mid_lot_no == 'undefined'){
				if($scope.live_lot_no < 3){
					$scope.live_lot_no = 3;
				}
				$scope.mid_lot_no = $scope.live_lot_no;
			} ;

			$scope.mid_lot_no = $scope.mid_lot_no + $input;
			
			// lot_noκ° 3μ΄νμΌκ²½μ° 3λ‘ μ€μ , μ΅λ lot_no OverμΌ κ²½μ° μ΅λlot_no-2λ‘ μ€μ . κΈ°λ³Έ 5κ±΄ λ³΄μ¬μ£ΌκΈ°μν΄μ μ²λ¦¬
			if($scope.mid_lot_no < 3){
				$scope.mid_lot_no = 3;
			} else if ($scope.mid_lot_no > $scope.max_lot_no-2){
				$scope.mid_lot_no = $scope.max_lot_no-2;
			}
			
			$scope.liveLotNaviList($scope.mid_lot_no);
		};
		
		$scope.naviMoveInit = function($input){
			$scope.cnt = 0; //λ€λΉκ²μ΄μ μ€ν Count μ΄κΈ°ν
			
			// lot_noκ° 3μ΄νμΌκ²½μ° 3λ‘ μ€μ , μ΅λ lot_no OverμΌ κ²½μ° μ΅λlot_no-2λ‘ μ€μ . κΈ°λ³Έ 5κ±΄ λ³΄μ¬μ£ΌκΈ°μν΄μ μ²λ¦¬
			$scope.mid_lot_no = $input;
			
			if($scope.mid_lot_no < 3){
				$scope.mid_lot_no = 3;
			} else if ($scope.mid_lot_no > $scope.max_lot_no-2){
				$scope.mid_lot_no = $scope.max_lot_no-2;
			}
			
			$scope.liveLotNaviList($scope.mid_lot_no);
		};
		
		// Lot Refresh : 1μ΄λ¨μ, Navi Refresh : 30μ΄λ¨μ
		$interval(function(){$scope.loadLiveAuction();},1000);
		$interval(function(){$scope.naviMove();},30000); //λ€λΉκ²μ΄μ λκΈ°νλ λ²νΌ ν΄λ¦­μλ§ μ§ν
		
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
		        resultString = String(resultArray[i]) + resultString;
		    }
			$scope.bidPriceInputKO = resultString;
		    return resultString;
		}
		
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
		console.log("##########");
		var win=window.open("","_self");
		window.close();
	}
</script>

<body>    
	<div class="pop_wrap">
		<div class="title"><h2>Seoul Auction LIVE</h2></div>
        
		<div ng-controller="liveAuctionCtl" data-ng-init="loadLiveAuction()">
			<div class="auction_ready_wrap" ng-if="lot.LOT_NO == null"><!-- κ²½λ§€ μ€λΉμ€μΈ κ²½μ° -->  
				<h2 class="auction_ready">  
					<span ng-if="locale=='ko'">κ²½λ§€ μ€λΉμ€μλλ€.</span><span ng-if="locale!='ko'">Auction Preparing.</span>
				</h2>
			</div>
			<div ng-if="lot.LOT_NO != null"><!-- κ²½λ§€ μ§νμ€μΈ κ²½μ° -->
	            <!--main -->
				<div class="cont m_cont02">            
					<div class="cont_title02">
					<!-- <h3 ng-bind="(sale.TITLE_JSON[locale])"></h3> -->
						<h3 style="font-weight: normal; color:#ff0000; font-size: 12px; line-height: 20px;">
							μ¨λΌμΈ μμ°°μ μ² νκ° λΆκ°λ₯ν©λλ€.<br> 
							μμ°° μ°μ  μμλ μλ©΄ > νμ₯ > μ¨λΌμΈ μμλλ€.
						</h3> 
					</div><!--cont_title02--> 
	
					<div class="onepcssgrid-1200 client_onepcssgrid-1200 clearfix">                  
	    				<!-- <div class="onerow"></div> <!--clear->
						<!-- μν μ λ³΄ νμ μμ­ -->       
						<div class="col5 client_col5">           
							<!--web_only-->
							<!--img-->
							<div class="web_only client_web_only">
								<div ng-show="lot.LOT_NO != null" style="margin:0 auto; position:relative; overflow:hidden;" align="center">
									<div class="bid_live_img_box" align="center"> 
										<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" 
										alt="{{lot.TITLE}}" style="max-width: 100%; max-height: 100%; vertical-align: middle;"/>
									</div> 
								</div>
							</div>
	
							<!--detail-->
							<div class="web_only client_web_only bidlive_caption" style="height: 120px; padding-top:15px; padding-bottom:10px; line-height:35px; border-top: solid  #666 1px;">
								<span ng-show="lot.LOT_NO == null">μ§ν λκΈ°μ€</span>  
								<span ng-show="lot.LOT_NO != null">
									<span style="font-size:30px; color:#000;"><strong><span ng-bind="lot.LOT_NO"></span></strong></span>
									<!-- μμΈνλ³΄κΈ° λ²νΌ κ΅¬μ± -->
									<span class="btn_style01 green02" style="margin-left:10px;">
										<a ng-if="lot.STAT_CD != 'reentry'" ng-href="{{'/lotDetail?sale_no=' + lot.SALE_NO + '&lot_no=' + lot.LOT_NO + '&sale_status=ING&view_type=LIST'}}" target="new">
										<span ng-if="locale == 'ko'">μμΈν λ³΄κΈ°</span><span ng-if="locale != 'ko'">Detail</span></a>
									</span>
									
									<br/>
									<strong><span style="font-size:28px; color:#000;" ng-bind="lot.ARTIST_NAME_JSON[locale]"></span></strong>
									<span style="font-size:18px;" ng-if="locale != 'en'" ng-bind="lot.ARTIST_NAME_JSON.en"></span>
									<span style="font-size:18px;" class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh"></span>
									<br/>
									<strong><span style="font-size:20px; color:#000;" ng-bind="lot.TITLE_JSON[locale]"></span></strong>
									<span style="font-size:18px;" ng-bind="lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale]"></span>
									<p ng-if="lot.TITLE_JSON['zh'] != lot.TITLE_JSON['en']">
		  									<span style="font-size:18px;" ng-if="lot.TITLE_JSON.zh != null" ng-bind="lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale]"></span>
									</p>
								</span>
							</div> <!--detail-->
	
							<!--price-->
							<div class="web_only client_web_only" style="padding-top:10px; border-top: solid #e4e4e4 1px;">
								<!-- μΆμ κ° λ³λλ¬Έμ -->
								<span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
								<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'">
	    							<!-- κΈ°μ€ν΅ν -->  
									<p style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
		    							<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
		    							<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
		    							<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
									</p>
									<!-- USD -->
									<!-- <p>
										<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
										<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)"> ~ </span>	 
										<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
									</p> -->
									<!-- μλΈν΅ν -->
									<!-- <p>
										<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
										<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)"> ~ </span>	 
										<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
									</p>     -->                           
								</span>      
							</div><!--price-->
							<!-- // web_only  -->
	
							<!-- // m_only  -->
							<!-- <div class="m_only"> -->
							<div class="client_m_only client_m_vertical" style="border-bottom: 2px solid #222; overflow:hidden;">  
								<div ng-show="lot.LOT_NO != null" style="display:table; margin:auto; position:relative; overflow:hidden;" align="center">
									<div class="bid_live_img_box" align="center">
										<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" 
											alt="{{lot.TITLE}}" style="max-width: 100%; max-height: 100%; vertical-align: middel;"/>
									</div>
								</div>
							</div>
							<!--img-->
		
							<!--detail-->  
							<div class="client_m_only client_m_only_txtbox bidlive_caption">   
								<div class="bidlive_caption" style="padding-bottom:10px; line-height:30px;"> 
									<span ng-show="lot.LOT_NO == null" style="text-align:center;">μ§ν λκΈ°μ€</span>
									<span ng-show="lot.LOT_NO != null"> 
										<span style="font-size:30px; color:#000;"><strong><span ng-bind="lot.LOT_NO"></span></strong></span>
										<!-- μμΈνλ³΄κΈ° λ²νΌ κ΅¬μ± -->
										<span class="btn_style01 green02" style="margin-left:10px;">
											<a ng-if="lot.STAT_CD != 'reentry'" ng-href="{{'/lotDetail?sale_no=' + lot.SALE_NO + '&lot_no=' + lot.LOT_NO + '&sale_status=ING&view_type=LIST'}}" target="new">
											<span ng-if="locale == 'ko'">μμΈν λ³΄κΈ°</span><span ng-if="locale != 'ko'">Detail</span></a>
										</span>
										 
										<p style="margin-top: 5px;text-overflow: ellipsis; white-space: nowrap; overflow: hidden; ">
										<strong><span style="font-size:28px; color:#000;" ng-bind="lot.ARTIST_NAME_JSON[locale]"></span></strong>
										<strong><span style="font-size:18px;" ng-if="locale != 'en'" ng-bind="lot.ARTIST_NAME_JSON.en"></span></strong>
										<strong><span style="font-size:18px;" class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh"></span></strong>
										</p> 
										
										<strong><span style="font-size:20px; color:#000;" ng-bind="lot.TITLE_JSON[locale]"></span></strong>
										<strong><span style="font-size:18px;" ng-bind="lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale]"></span></strong>
										<p ng-if="lot.TITLE_JSON['zh'] != lot.TITLE_JSON['en']">
			  								<strong><span style="font-size:18px;" ng-if="lot.TITLE_JSON.zh != null" ng-bind="lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale]"></span></strong>
										</p>
									</span>
								</div> <!-- //bidlive_caption -->
								
								<!--price-->  
								<div style="padding: 10px 0 5px; border-top: solid #e4e4e4 1px; line-height:22px; height:30px;"> 
									<!-- μΆμ κ° λ³λλ¬Έμ -->
									<span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
									<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'">
		    							<!-- κΈ°μ€ν΅ν -->
										<p style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">  
			    							<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
			    							<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
			    							<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
										</p>
										<!-- USD -->
										<!-- <p>
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)"> ~ </span>	 
											<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
										</p> -->
										<!-- μλΈν΅ν -->
										<!-- <p>
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null ) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)"> ~ </span>	 
											<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
										</p>    -->                           
									</span>      
								</div><!--price-->
							</div> 
						</div><!--col5--><!-- μν μ λ³΄ νμ μμ­ --> 	
						
						<!-- κ²½λ§€ μμ/λ§κ° & κ²½λ§€ λ¬Έκ΅¬ μλ ₯(κ³ κ°μ©)--> 
						<div class="col7 last bid_livebox bid_livebox_client">   
							<!-- κ³ κ° μμ°°μ λ³΄(μμκ°/νΈκ°/νμ¬κ°/μμ°°κ°) -->    
							<div class="bid_livebox_font bid_livebox_font_en">           
								<!-- μμκ°  -->   
								<!-- <div class="hogatable client_hogatable"> 
									<label for="startPrice">
										<font style="padding-left:15px; padding-right:5px; display:table-cell; vertical-align:middle;"><span ng-if="locale=='ko'">μμκ°</span><span ng-if="locale!='ko'">Start price</span></font>
									</label>
									<input type="text" ng-model="lot.START_PRICE | number:0" id="startPrice" name="startPrice" readonly/>&nbsp;[{{sale.CURR_CD}}]
									<strong><span ng-if="sale.CURR_CD=='KRW'">οΏ¦</span><span ng-if="sale.CURR_CD=='HKD'">HK$</span>&nbsp;{{lot.START_PRICE | number:0}}</strong>
								</div> -->
								<!-- νμ¬κ° -->  
								<div class="hogatable client_hogatable"> 
									<label for="lastPrice">
										<font style="padding-right:5px; display:table-cell; vertical-align:middle;"><span ng-if="locale=='ko'">νμ¬κ°</span><span ng-if="locale!='ko'">Current price</span></font>
									</label>
									<!-- <input type="text" ng-model="lot.LAST_PRICE | number:0" id="lastPrice" name="lastPrice" readonly/>&nbsp;[{{sale.CURR_CD}}] -->
									<strong><span ng-if="sale.CURR_CD=='KRW'">οΏ¦</span><span ng-if="sale.CURR_CD=='HKD'">HKD</span>&nbsp;{{lot.LAST_PRICE | number:0}}<!-- &nbsp;[{{sale.CURR_CD}}] --></strong>
								</div>
								
								<!-- νΈκ° -->
								<div class="hogatable client_hogatable client_hogatable_en">  
									<label for="growPrice"> 
										<font style="padding-right:5px; display:table-cell; vertical-align:middle;"><span ng-if="locale=='ko'">νΈκ°</span><span ng-if="locale!='ko'">Asking price</span></font>
									</label>
									<!-- <input type="text" ng-model="lot.GROW_PRICE==0?lot.START_GROW_PRICE:lot.GROW_PRICE | number:0" id="growPrice" name="growPrice" readonly/>&nbsp;[{{sale.CURR_CD}}] -->
									<strong><span ng-if="sale.CURR_CD=='KRW'">οΏ¦</span><span ng-if="sale.CURR_CD=='HKD'">HKD</span>&nbsp;{{lot.GROW_PRICE==0?lot.START_GROW_PRICE:lot.GROW_PRICE | number:0}}<!-- &nbsp;[{{sale.CURR_CD}}] --></strong>
								</div> 
								
								<!-- μμ°°κ° -->  
								<div class="hogatable client_hogatable02">   
									<label for="bidPriceInputOnline">      
										<font style="display:table-cell; vertical-align:middle; font-weight:bold; color:#ff0000;">  
											<span ng-if="locale=='ko'">μμ°°κ°</span><span ng-if="locale!='ko'">Biding price</span>&nbsp;
										<strong><span ng-if="sale.CURR_CD=='KRW'">οΏ¦</span><span ng-if="sale.CURR_CD=='HKD'">HKD</span></strong>	
										</font> 
									</label>
									<input type="text" style="color:#ff0000; font-weight:bold; border:2px solid #00acac; background: #f8f8f8;"  ng-model="bid_price_input_online" id="bidPriceInputOnline" name="bidPriceInputOnline" onkeyup="getNumber(this)" readonly/>
									<!-- &nbsp;[{{sale.CURR_CD}}] -->    
								</div> 
								<!-- μμ°°κ° κ΅­λ¬Έ -->    
								<p style="text-align:center; width: 100%; margin: 0 auto;"> 
									<!-- <font style="font-weight:bold;">
										<span ng-bind="bid_price_input_online_KO" id="bid_price_input_online_KO" >&nbsp;[{{sale.CURR_CD}}]</span>
									</font> -->
								</p>	
						   </div><!-- //μμκ° & νΈκ° -->  
							   
							<!-- μμ°° λ²νΌ (κ³ κ°μ©) --> 	
							<div class="bidlive_clinet_btn bidlive_clinet_btn_en">              
								<span class="btn_style01 green02 offauction_btn offauction_btn_en"><!-- μμ°°λ²νΌ μ‘°κ±΄ : μ νμ μ΄κ±°λ κ΅­μΈνμ μμ°°νμ© μΈκ²½μ°, λ©μ΄μ /νμ½©/κΈ°νκ²½λ§€λ§ μμ°°λ²νΌ νμ±ν && (custInfo.MEMBERSHIP_YN == 'Y' || custInfo.FORE_BID_YN == 'Y') &&--> 
									<span ng-if="custInfo.CUST_NO > 0 && lot.LIVE_CLOSE_YN=='N' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">
										<button type="button" ng-click="liveLotBidPriceSave('online');" ng-disabled="lot.IS_WIN == 'Y'">
											<span ng-if="locale=='ko'"><span ng-if="lot.IS_WIN == 'N'">μμ°°νκΈ°</span><span ng-if="lot.IS_WIN == 'Y'">μ΅κ³ κ° μμ°°μ€</span></span>	
								  			<span ng-if="locale!='ko'"><span ng-if="lot.IS_WIN == 'N'">Bid</span><span ng-if="lot.IS_WIN == 'Y'">Highest bidding</span></span>
								  		</button>
								  	</span>  
								  	<span ng-if="custInfo.CUST_NO > 0 && lot.LIVE_CLOSE_YN!='N' && offBidList.length > 0">
										<button type="button" ng-disabled="lot.IS_WIN == 'Y'">  
							  				<span ng-if="locale=='ko'">μμ°°λ§κ°</span>	
							  				<span ng-if="locale!='ko'">Bid Closed</span>
								  		</button>
								  	</span>
								  	<span ng-if="custInfo.CUST_NO > 0 && lot.LIVE_CLOSE_YN!='N' && offBidList.length == 0">
										<button type="button">
							  				<span ng-if="locale=='ko'">μμ°°μ€λΉ</span>	
							  				<span ng-if="locale!='ko'">Bid Ready</span>
								  		</button> 
								  	</span>
								  	<span ng-if="!custInfo.CUST_NO">
										<button type="button" onClick="location.href='https://www.seoulauction.com/login'"> 
											<spring:message code="label.go.bid.loginlog" />
										</button>	
								  	</span>  
								</span>
							</div>
						</div>
						
						<!-- κΈ°μ€ν΅ν -->
						<div class="col7 last bid_livebox">
							<div style="text-align:right; margin-bottom:10px;"><span ng-if="locale=='ko'">ν΅ν:</span><span ng-if="locale!='ko'">Currency:</span>&nbsp;[{{sale.CURR_CD}}]</div>   
						</div> 
						
						<!-- μμ°° μ λ³΄ νμ μμ­ --> 
						<div class="col7 last bid_livebox">
							<!-- scroll START (2018.04.18 YDH) -->
							<div class="fixed-table-container" style="height: 200px;"> <!-- <div class="scrollable web" style="margin-top:22px;"> -->
								<div class="fixed-table-header"></div>  <!-- <div class="scroller"> -->
								<div class="fixed-table-wrap"> <!-- <div class="tbl_style02"> -->
									<table id="tbl_employee" class="fixed-table">
										<colgroup>
											<col width="33.3%"/>
											<col width="33.3%"/>
											<col width="33.3%"/>
										</colgroup>
										<thead>
											<tr>
												<th scope="col">
													<div class="th-text client_th-text">
														<span ng-if="locale == 'ko'">μμ°°κ΅¬λΆ</span><span ng-if="locale != 'ko'">Bidding</span>
													</div> 
												</th>
												<th scope="col">
													<div class="th-text client_th-text">
														<span ng-if="locale == 'ko'">μμ°°κΈμ‘</span><span ng-if="locale != 'ko'">Bid Price</span>
													</div>
												</th>
												<th scope="col">
													<div class="th-text client_th-text"><span ng-if="locale == 'ko'">ID</span><span ng-if="locale != 'ko'">ID</span>
													</div>
												</th>
												<!-- <th scope="col">
													<div class="th-text">
														<span ng-if="locale == 'ko'">κΈ°μ€ν΅ν</span><span ng-if="locale != 'ko'">Currency</span>
													</div>
												</th> -->    
											</tr>
										</thead>
										<tbody id="tblOffBidListBody"> 
											<tr ng-show="offBidList.length == 0"><td colspan="3"><span ng-if="locale == 'ko'">κ³§ μμ°°μ΄ μμλ©λλ€.</span><span ng-if="locale != 'ko'">The bidding stats soon.</span></td></tr>
											<tr ng-repeat="bid in offBidList">
												<td ng-if="bid.BID_NOTICE == null">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">
														<span ng-if="!bid.ONLINE_BID_ID.includes('***')"><font color="red" style="font-weight:bolder">βΆ</font></span>
														<span ng-if="locale=='ko' && bid.BID_KIND_CD=='online'">μ¨λΌμΈ</span>
														<span ng-if="locale!='ko' && bid.BID_KIND_CD=='online'">online</span></font>
													</span>
													<span ng-if="bid.BID_KIND_CD != 'online'">
														<span ng-if="locale=='ko' && bid.BID_KIND_CD=='floor'">νμ₯</span>
														<span ng-if="locale!='ko' && bid.BID_KIND_CD=='floor'">floor</span>
													</span>
												</td>
												<td ng-if="bid.BID_NOTICE == null">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.BID_PRICE | number:0}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.BID_PRICE | number:0}}</span>
												</td>
												<td ng-if="bid.BID_NOTICE == null">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.ONLINE_BID_ID}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.ONLINE_BID_ID}}</span>
												</td>
												<td ng-if="bid.BID_NOTICE != null" colspan="3" style="color:red; text-align:center;"><span ng-if="locale == 'ko'">{{bid.BID_NOTICE}}</span><span ng-if="locale != 'ko'">{{bid.BID_NOTICE_EN}}</span></td>
												<!-- <td ng-if="bid.BID_NOTICE == null">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{sale.CURR_CD}}</font></span>
													<span ng-if="bid.BID_KIND_CD != 'online'">{{sale.CURR_CD}}</span>
												</td> --> 
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div> <!--col7-->
						
						
						<div class="onerow"></div><!--clear--> 
	
						<!--λ€λΉκ²μ΄μ-->
						<%-- <div class="col12 client_web_only" align="center" style="padding-top:10px; border-top:#666 1px solid; position: relative;">
							<span class="btn_style01 green02" style="float:right;"><button type="button" ng-click="naviMoveInit(lot.LOT_NO);">
								<span ng-if="locale == 'ko'">κ²½λ§€μ€μΈ μνμΌλ‘ μ΄λ</span><span ng-if="locale != 'ko'">Go to the Auction Item</span></button>
							</span>
							<div style="clear:both"></div><!--clear-->
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
												<span ng-show="naviList.STAT_CD == 'reentry'"><font color="#999999"><span ng-if="locale == 'ko'">μΆνμ·¨μ</span><span ng-if="locale != 'ko'">Canceled</span></font></span>
												<!-- <span ng-if="naviList.STAT_CD != 'reentry' && naviList.LIVE_STAT == 'LIVE'">
													<font color="#ffffff" size="-1" style="background:#C00; padding:4px;"><span ng-if="locale == 'ko'">κ²½λ§€μ€</span><span ng-if="locale != 'ko'">Bidding</span></font>
												</span>	 -->
												<span ng-if="naviList.STAT_CD != 'reentry' && naviList.LIVE_STAT != 'LIVE' && naviList.BID_PRICE > 0">
													<font color="#ffffff" size="-1" style="background:#999; padding:4px;"><span ng-if="locale == 'ko'">μ’λ£</span><span ng-if="locale != 'ko'">Close</span></font>
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
						</div><!--λ€λΉκ²μ΄μ--> --%>
	
						<div class="onerow"></div><!--clear-->    
					</div> <!--onepcssgrid-1200-->
				</div> <!--cont-->
			</div><!-- κ²½λ§€μ§νμ€μΈ κ²½μ° -->
		</div> <!--liveAuctionCtl-->
					
		<!--footer
		<div style="background-color:#e4e4e4; padding:10px; text-align:left;">	 
			<div align="center" ng-if="locale == 'ko'">
    			<p style="color: #000; font-size:11px; padding-top:20px; padding-bottom:20px; line-height:18px;">
    				* μ¨λΌμΈ μμ°°μ λμ°° ν μ·¨μκ° λΆκ°λ₯ ν©λλ€.<br/>
    				* μμ°° μ°μ μμλ [μλ©΄>νμ₯>μ¨λΌμΈ] μμλλ€. νμ₯κ³Ό μ¨λΌμΈμ κΈμ‘μ΄ λμΌν  κ²½μ°, νμ₯μμ°° μ°μ μλλ€.<br/>
    				* μμ°° κ²½ν©μ μ¨λΌμΈ μμ°°κΈμ‘ λ²νΌμ΄ μλμΌλ‘ λ³κ²½λμ΄ μμ°°νκ³ μ νλ κΈμ‘λ³΄λ€ λμ κΈμ‘μ μμ°°μ΄ μ΄μμ§ μ μμΌλ λ²νΌμ λλ₯΄κΈ° μ§μ κΉμ§ μ£Όμνμμ μμ°°νμκΈΈ λ°λλλ€. 
				</p>
			</div>
			<div align="center" ng-if="locale != 'ko'">
    			<p style="color: #000; font-size:11px; padding-top:20px; padding-bottom:20px; line-height:18px;">
    				* LOT information and Current Bidding may be delayed depending on network speed.
				</p>
			</div>
		</div>	footer-->
          
	</div> <!--pop_wrap-->
	</br></br>
	<div class="btn_wrap">
		<span class="btn_style01 gray mid btn_pop_close" id="cancelBtn">
			<button type="button"><spring:message code="label.close" /></button>
		</span>
	</div>
</body>
</html>