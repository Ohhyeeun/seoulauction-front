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
</head>  

<%-- YDH 추가 시작--%>
<script type="text/javascript" src="/js/angular/paging.js"></script>
<!-- Expose 'llnwrtssdk' on the window global to reference in your 'subscribe' script -->
<script type="text/javascript" src="https://llrtsprod.s.llnwi.net/v1/sdk/html/current/llnwrtssdk.min.js"></script>
<!-- Recommended shim for cross-browser WebRTC support. -->
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>      
 
 
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
		$scope.cnt = 0; // 네비게이션 실행여부 확인(2018.04.25)
		$scope.lot_move_init = "NO";
		$scope.sale_no = getParameter('sale_no');
		
		$scope.init = function(){
			$scope.loadLiveAuction();
			$scope.loadInitInfo();
	 	}
		
		$scope.loadLiveAuction = function(){
			$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
					"actionList":[
					{"actionID":"liveSaleInfo", "actionType":"select" , "tableName": "SALE"},
					{"actionID":"liveLotInfo", "actionType":"select" , "tableName": "LOT"},
					{"actionID":"offBidList", "actionType":"select", "tableName":"BID_OFF_LIST"}, // Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
				]};	 	   	
			common.callActionSet($d, $s);
		}
		
		var $s = function(data, status) { 
			$scope.sale = data["tables"]["SALE"]["rows"][0];
			$scope.lot = data["tables"]["LOT"]["rows"][0];
			$scope.offBidList = data["tables"]["BID_OFF_LIST"]["rows"];// Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
			
			$scope.LotNo = $scope.lot.LOT_NO;

			$scope.base_currency = $scope.sale.CURR_CD;
			$scope.sub_currency = ($scope.sale.CURR_CD == "KRW" ? "HKD" : "KRW");
			
			$scope.live_lot_no = $scope.lot.LOT_NO;  //현재 진행중인 LOT 번호
			$scope.max_lot_no = $scope.sale.MAX_LOT_NO;  // LOT 번호 MAX 번호
		
			$scope.sale_no = $scope.sale.SALE_NO;
			$scope.lot_no = $scope.lot.LOT_NO;		//조회된 LOT을 무조건 동기화
			
			//추정가 별도인 경우 제외
			if ($scope.lot.EXPE_PRICE_INQ_YN == 'N'){	
				if($scope.lot.LAST_PRICE != null && $scope.lot.LAST_PRICE != ''){
					$scope.bid_price_input_online = $scope.commaSetting($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE); //고객용 응찰금액(최고가+호가) 설정				
			 		$scope.bid_price_input_online_KO = $scope.numberToKorean($scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE);	
				}else{
					if($scope.lot.START_PRICE == null || $scope.lot.START_PRICE == ''){
						$scope.lot.START_PRICE = 0;
					} 
					$scope.bid_price_input_online = $scope.commaSetting($scope.lot.START_PRICE); //고객용 응찰금액(시작가) 설정
			 		$scope.bid_price_input_online_KO = $scope.numberToKorean($scope.lot.START_PRICE);	
				}
			} else {//추정가 별도 문의시 처리
				$scope.bid_price_input_online = ""; //고객용 응찰금액(시작가) 설정
		 		$scope.bid_price_input_online_KO = "";	
			}
		}
		
		
		$scope.loadInitInfo = function(){
	 		$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
	 				"actionList":[
	 					{"actionID":"get_bidMy_history", "actionType":"select" , "tableName": "MY_BID_HISTORY"},
	 					{"actionID":"get_lotInfo_naviation", "actionType":"select" , "tableName": "LOT_NAVI"},
	 					{"actionID":"get_bidLive_info", "actionType":"select" , "tableName": "GET_CUST_INFO" ,"parmsList":[]},
	 		]};
	 		
	 	   	common.callActionSet($d, function(data, status) {
	 	   		$scope.custInfo = data["tables"]["GET_CUST_INFO"]["rows"][0];
	 	   		$scope.myBidHistory = data["tables"]["MY_BID_HISTORY"]["rows"];
	 	   		$scope.lotNavi = data["tables"]["LOT_NAVI"]["rows"];
	 		});
		}
		
		
		$scope.elClick = function( lotNo, artist, title, cdMn, fromPrice, toPrice, fileName, filePath ){
	 		$("#lotNo").html(lotNo);
	 		$("#artistName").html(artist);
	 		$("#titleName").html(title);
	 		$("#cdMnEn").html(cdMn);
	 		$("#startPrice").html("KRW " +comma(fromPrice));
	 		$("#toPrice").html(comma(toPrice));
	 		var imgUrl = "https://www.seoulauction.com/nas_img"+filePath+"/"+fileName;
	 		$('#imgSrc').empty();
	 		$('#imgSrc').attr('src',  imgUrl);
		}
		
		
		$scope.nowLotMove= function( lot_no, artistName, title, cdMn, fromPrice, toPrice, fileName, filePath ){
			$("#lotNo").html(lot_no);
	 		$("#artistName").html(artistName);
	 		$("#titleName").html(title);
	 		$("#cdMnEn").html(cdMn);
	 		$("#startPrice").html("KRW "+comma(fromPrice));
	 		$("#toPrice").html(comma(toPrice));
	 		var imgUrl = "https://www.seoulauction.com/nas_img"+filePath+"/"+fileName;
	 		$('#imgSrc').empty();
	 		$('#imgSrc').attr('src',  imgUrl);  
			
		}
		
		// Live 진행 LOT번호 응찰금액 로직 추가(2018.04.17 YDH), bid_price는 콤마(,)제거
		$scope.liveLotBidPriceSave = function($input) {	
			if ($input == 'online'){
				$scope.bid_price_input_online = $("#bidPriceInputOnline").val();
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
		};
		
		
		// Lot Refresh : 1초단위, Navi Refresh : 30초단위
		$interval(function(){$scope.loadLiveAuction();},1000);
		/* $interval(function(){$scope.naviMove();},30000); */ //네비게이션 동기화는 버튼 클릭시만 진행
		
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
	
	function CloseWindow(){
		var win=window.open("","_self");
		window.close();
	}
</script>

<body>     
	<div class="pop_wrap"> 
		<div class="title"><h2>Seoul Auction LIVE</h2></div>  
        
		<div ng-controller="liveAuctionCtl" data-ng-init="init()">
			<div class="auction_ready_wrap" ng-if="lot.LOT_NO == null"><!-- 경매 준비중인 경우 -->  
				<h2 class="auction_ready">  
					<span ng-if="locale=='ko'">경매 준비중입니다.</span><span ng-if="locale!='ko'">Auction Preparing.</span>
				</h2> 
			</div> 
			
			<div ng-if="lot.LOT_NO != null"><!-- 경매 진행중인 경우 -->  
	            <!--main --> 
				<div class="onepcssgrid-1200 client_onepcssgrid-1200 clearfix">  
					<div class="bidlive_5010 clearfix"> 
						<div class="bidlive_video bidlive_video_member">
							<div>   
								<video id="llnw-rts-subscriber" width="640" height="480" autoplay controls playsinline muted></video>
							</div>  
						</div><!-- //video -->  
						
						<div class="re-flash">         
							<a onClick="window.location.reload()" style="cursor:pointer; color: #444;">        
								<i class="material-icons" style="vertical-align:middle; font-size: 20px; font-weight: bold; color: #444;">     
									refresh 
								</i>      
								Refrash the Video   
							</a>   
						</div> <!-- //새로고침 -->   
						
						<!-- tabs -->  
						<div class="bidlive_tab client_web_only clearfix" style="padding-bottom: 10px;">  
							<div class="tab">  
								<button class="tablinks" onclick="openCity(event, 'London')" id="defaultOpen">Lot</button>
								<button class="tablinks" onclick="openCity(event, 'Paris')"><span ng-if="locale=='ko'">응찰기록</span><span ng-if="locale=='en'">Bid history</span></button>  
							</div>     
							
							<div id="London" class="tabcontent clearfix">         
								<!-- lot 정보  -->    
								<div class="tab_lotcaption">  
									<div class="tab_box_img">  
										<img id="imgSrc" oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" alt="{{lot.TITLE}}" />
									</div>      
									<div class="tab_box_img_caption" style="float:left; width: 60%;">  
										<span style="font-size: 20px; font-weight:bold;" id="lotNo" ng-bind="lot.LOT_NO"></span> 
										<span style="float:right; cursor:pointer; font-size: 12px; padding-right: 10px; color: #444;" ng-click="nowLotMove(lot.LOT_NO,lot.ARTIST_NAME_JSON[locale],lot.TITLE_JSON[locale], lot.MATE_NM_EN, lot.EXPE_PRICE_FROM_JSON[base_currency],lot.EXPE_PRICE_TO_JSON[base_currency],lot.FILE_NAME,lot.FILE_PATH)">
											<i class="material-icons" style="font-size:20px; vertical-align:text-bottom;">touch_app</i>MOVE NOW LOT</span>      
										<p class="textshort" style="font-size: 20px; font-weight:bold;" id="artistName" ng-bind="lot.ARTIST_NAME_JSON[locale]"></p> 
										<p class="textshort" style="font-size: 20px; font-weight:bold;" id="titleName" ng-bind="lot.TITLE_JSON[locale]"></p> 
										<p class="textshort" id="cdMnEn" ng-bind="lot.MATE_NM_EN"></p>
										<p class="textshort">
										<span id="startPrice" ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
		    							<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
		    							<span id="toPrice" ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
										</p>  
									</div>    
								</div>     
							</div>
							
							<div id="Paris" class="tabcontent clearfix">      	 				 
								<!-- //응찰기록 -->       
								<div class="tab_history">       
									<table class="bid_history_table"> 
										<caption style="text-indent: -9999px;"><span ng-if="locale=='ko'">응찰기록</span><span ng-if="locale=='en'">Bid history</span></caption> 
										<colgrop>  
											<col width="10%" />  
											<col width="20%" />   
											<col width="30%" />   
											<col width="30%" />   
											<col width="10%" />    
										</colgrop>    
										<thead> 
											<tr>
												<th scope="col">
													<div class="bidtable_tit">
														Lot
													</div>
												</th> 
												<!-- <th scope="col">
													<div class="bidtable_tit">
														작가/작품명
													</div>
												</th>  -->
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
												<!-- <td ng-bind="myBidHistory.ARTIST_NAME_JSON[locale]"></td> -->
												<td ng-bind="myBidHistory.LAST_BID_PRICE | number : 0"></td>  
												<td ng-bind="myBidHistory.HAMMER_BID_PRICE | number : 0"></td>
												<td ng-if="myBidHistory.LOT_NO != lot.LOT_NO && myBidHistory.LAST_BID_PRICE != myBidHistory.HAMMER_BID_PRICE"></td> 
												<td ng-if="myBidHistory.LOT_NO == lot.LOT_NO">Now</td> 
												<td ng-if="myBidHistory.LAST_BID_PRICE == myBidHistory.HAMMER_BID_PRICE">Successful Bid</td> 
											</tr>
										</tbody>  
									</table> 
								</div> 
							</div><!-- //tab_box -->   
						</div>   
						
						<!-- 이미지 네비게이션 -->  
						<div class="imgnavigation_box client_web_only">   	
							<div class="bidlive_navigation_width" id="naviDiv">    
								<div class="bidnav_lotimg" ng-repeat="lotNavi in lotNavi" ng-click="elClick(lotNavi.LOT_NO, lotNavi.ARTIST_NAME_JSON[locale], lotNavi.TITLE_JSON[locale], lotNavi.MATE_NM_EN , lotNavi.EXPE_PRICE_FROM_JSON[base_currency], lotNavi.EXPE_PRICE_TO_JSON[base_currency], lotNavi.FILE_NAME, lotNavi.FILE_PATH )">   
									<div class="img_navigation">    
										<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lotNavi.FILE_NAME | imagePath1 : lotNavi.FILE_PATH : 'detail'}}" 
											alt="{{lotNavi.TITLE}}" />     
									</div>  
									<div class="bidnav_lotinfo" style="width:100px; float: left;">     
										<p class="lotNo" ng-bind="lotNavi.LOT_NO"></p> 
										<p class="textshort artistName" ng-bind="lotNavi.ARTIST_NAME_JSON[locale]"></p>  
										<p class="textshort titleName" ng-bind="lotNavi.TITLE_JSON[locale]"></p>   
										<p class="textshort priceInfo">
										<span ng-bind="lotNavi.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
		    							<span ng-if="(lotNavi.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lotNavi.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
		    							<span ng-bind="lotNavi.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
										</p> 
									</div> 
								</div>    
							</div> 
						</div><!-- navigation -->
					</div><!-- //bidlive_5010 -->  	
						
					<!-- 오른쪽 화면 -->  
					<div class="bidlive_50 clearfix">
						<!-- 현재 진행 응찰 정보-->
						<div class="right_heightbox">  
							<div class="tab_box_right">  
								<div class="tab_lotcaption">  
									<div class="tab_box_img">       
										<img oncontextmenu="return false" ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.FILE_NAME | imagePath1 : lot.FILE_PATH : 'detail'}}" alt="{{lot.TITLE}}" />    
									</div>       
									<div class="tab_box_img_caption" style="float:left; width: 60%;">   
										<p class="bidimg_tit" ng-bind="lot.LOT_NO" id="mainLotNo"></p>
										<p class="textshort bidimg_tit"><span ng-bind="lot.ARTIST_NAME_JSON[locale]"></span></p> 
										<p class="textshort bidimg_tit" ng-bind="lot.TITLE_JSON[locale]"></p> 
										<p class="textshort"><!-- <span ng-bind="lot.MAKE_YEAR_JSON[locale]"></span><span ng-if="lot.MAKE_YEAR_JSON[locale]"> | </span> --><span ng-bind="lot.MATE_NM_EN"></span></p>
										<!-- <p class="textshort" ng-repeat="size in lot.LOT_SIZE_JSON"><span ng-bind="size | size_text"></span></p>   -->
										<p class="textshort">
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span> 
			    							<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)"> ~ </span>	
			    							<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
										</p>  
									</div>  
								</div>   
							</div>
						 
							<!-- notice -->  
							<div class="notice_slide clearfix">  
								<div class="bidlivenotice_list bidlivenotice_list_en">  
									<ul>  
										<li class="txt_impo02 notice_slide_center">          
											<span class="notice_style01" style="vertical-align:middle;"></span> 
											<span class="">Online bids cannot be withdrawn.</span>     	
										</li> 
										<li class="txt_impo02">   
											 <span class="notice_style01" style="vertical-align:middle;"></span>
											 <span class="bidlivenotice_en_line">The order of priority is written > site > online.</span>  
										</li> 
										<li class="txt_impo02">   
											 <span class="notice_style01" style="vertical-align:middle;"></span>
											 <span class="bidlivenotice_en_line">Online bidding is only available for regular members who have applied for bidding.</span>  
										</li> 
										<li class="txt_impo02">    
											 <span class="notice_style01" style="vertical-align:middle;"></span> 
											 The amount of the video may vary, so please bid after checking the bid price on the bid screen.    
										</li>
										<li class="txt_impo02">    
											 <span class="notice_style01" style="vertical-align:middle;"></span>
											 <span class="bidlivenotice_en_line"> It is recommended to use a chrome browser.</span>  
										</li>
									</ul> 
								</div>  
							</div>  
						
							<!-- 현재가/호가/응찰가 --> 
							<div class="bid_livebox_client clearfix">
								<div style="display: flex; align-items: center;"> 
									<div class="bid_livebox_font">    
										<!-- 현재가 --> 
										<div class="hogatable client_hogatable"> 
											<label for="lastPrice"> 
												<font><span ng-if="locale=='ko'">현재가</span><span ng-if="locale!='ko'">Current price</span></font>
											</label>
											<!-- <input type="text" ng-model="lot.LAST_PRICE | number:0" id="lastPrice" name="lastPrice" readonly/>&nbsp;[{{sale.CURR_CD}}] -->
											<strong style="vertical-align:middle;"><span ng-if="sale.CURR_CD=='KRW'">￦</span><span ng-if="sale.CURR_CD=='HKD'">HKD</span>&nbsp;{{lot.LAST_PRICE | number:0}}<!-- &nbsp;[{{sale.CURR_CD}}] --></strong>
										</div>  
										<!-- 호가 -->
										<div class="hogatable client_hogatable">   
											<label for="growPrice">  
												<font><span ng-if="locale=='ko'">호&nbsp;&nbsp;&nbsp;가</span><span ng-if="locale!='ko'">Asking price</span></font>
											</label>
											<!-- <input type="text" ng-model="lot.GROW_PRICE==0?lot.START_GROW_PRICE:lot.GROW_PRICE | number:0" id="growPrice" name="growPrice" readonly/>&nbsp;[{{sale.CURR_CD}}] -->
											<strong style="vertical-align:middle;"><span ng-if="sale.CURR_CD=='KRW'">￦</span><span ng-if="sale.CURR_CD=='HKD'">HKD</span>&nbsp;{{lot.GROW_PRICE==0?lot.START_GROW_PRICE:lot.GROW_PRICE | number:0}}<!-- &nbsp;[{{sale.CURR_CD}}] --></strong>
										</div>  
										<!-- 응찰가 -->  
										<div class="hogatable client_hogatable02">   
											<label for="bidPriceInputOnline" style="vertical-align:middle; overflow: hidden;">           
												<font style="color:#ff0000;">   
													<span ng-if="locale=='ko'">응찰가</span><span ng-if="locale!='ko'">Biding price</span>
													<strong><span ng-if="sale.CURR_CD=='KRW'">￦</span><span ng-if="sale.CURR_CD=='HKD'">HKD</span></strong>	
												</font>  
											</label> 
											<input type="text" style="color:#ff0000; font-weight:bold; border: 0; padding-left: 0;" ng-model="bid_price_input_online" id="bidPriceInputOnline" name="bidPriceInputOnline" onkeyup="getNumber(this)" readonly/>
											<!-- &nbsp;[{{sale.CURR_CD}}] -->    
										</div> 
										<!-- 응찰가 국문 -->    
										<!-- <p style="text-align:center; width: 100%; margin: 0 auto;">  
											<font style="font-weight:bold;">
												<span ng-bind="bid_price_input_online_KO" id="bid_price_input_online_KO" >&nbsp;[{{sale.CURR_CD}}]</span> 
											</font>
										</p> --> 
								   </div>
									   
									<!-- 응찰 버튼 (고객용) --> 	
									<div class="bidlive_clinet_btn clearfix">             
										<span class="btn_style01 green02 bidlive_bidbtn"><!-- 응찰버튼 조건 : 정회원 이거나 국외회원 응찰허용 인경우, 메이저/홍콩/기획경매만 응찰버튼 활성화 && (custInfo.MEMBERSHIP_YN == 'Y' || custInfo.FORE_BID_YN == 'Y') &&--> 
											<span ng-if="custInfo.CUST_NO > 0 && lot.LIVE_CLOSE_YN=='N' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">
												<button type="button" ng-click="liveLotBidPriceSave('online');" ng-disabled="lot.IS_WIN == 'Y'">  
													<span ng-if="locale=='ko'"><span ng-if="lot.IS_WIN == 'N'">응찰하기</span><span ng-if="lot.IS_WIN == 'Y'">최고가 응찰중</span></span>  	
										  			<span ng-if="locale!='ko'"><span ng-if="lot.IS_WIN == 'N'">Bid</span><span ng-if="lot.IS_WIN == 'Y'">Highest bidding</span></span>
										  		</button>
										  	</span>   
										  	<span ng-if="custInfo.CUST_NO > 0 && lot.LIVE_CLOSE_YN!='N' && offBidList.length > 0">
												<button type="button" ng-disabled="lot.IS_WIN == 'Y'">   
									  				<span ng-if="locale=='ko'">응찰마감</span> 	 
									  				<span ng-if="locale!='ko'">Bid Closed</span>  
										  		</button>
										  	</span>
										  	<span ng-if="custInfo.CUST_NO > 0 && lot.LIVE_CLOSE_YN!='N' && offBidList.length == 0">
												<button type="button">  
									  				<span ng-if="locale=='ko'">응찰준비</span> 	
									  				<span ng-if="locale!='ko'">Bid Ready</span>
										  		</button> 
										  	</span>
										  	<span ng-if="!custInfo.CUST_NO">
												<button type="button" onClick="location.href='https://www.seoulauction.com/login'"> 
													<spring:message code="label.go.bid.loginlog" /> 
												</button>	
										  	</span>  
										</span> 
									</div><!-- //bidlive_clinet_btn -->   
								</div> 
							</div><!-- //bid_livebox_client -->  
						</div> 
						
						<!-- 기준통화/id/pw-->
						<div class="clearfix" style="padding: 10px;">                 
							<div class="bidlive_accountlist">      
								<span><strong>ID</strong>: <span ng-bind="custInfo.LOGIN_ID"></span></span> 
								<span><strong>My PaddleNo.</strong>: <span ng-bind="custInfo.PADD_NO"></span></span>
							</div>     
							<div class="bidlive_currency" style="text-align:right;"><span ng-if="locale=='ko'">통화:</span><span ng-if="locale!='ko'">Currency:</span>&nbsp;[{{sale.CURR_CD}}]</div>
						</div>    
						      
						<div id="A1" class="bid_livebox_table tabtab clearfix"> 
							<!-- scroll START (2018.04.18 YDH) -->   
							<div class="fixed-table-container">  
								<div class="fixed-table-header"></div> 
								<div class="fixed-table-wrap"> 
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
														<span ng-if="locale == 'ko'">응찰구분</span><span ng-if="locale != 'ko'">Bidding</span>
													</div> 
												</th>
												<th scope="col">
													<div class="th-text client_th-text">
														<span ng-if="locale == 'ko'">응찰금액</span><span ng-if="locale != 'ko'">Bid Price</span>
													</div>
												</th>
												<th scope="col">
													<div class="th-text client_th-text"><span ng-if="locale == 'ko'">Paddle No</span><span ng-if="locale != 'ko'">ID</span>  
													</div>
												</th>
												<!-- <th scope="col">
													<div class="th-text">
														<span ng-if="locale == 'ko'">기준통화</span><span ng-if="locale != 'ko'">Currency</span>
													</div>
												</th> -->    
											</tr>
										</thead>
										<tbody id="tblOffBidListBody"> 
											<tr ng-show="offBidList.length == 0"><td colspan="3"><span ng-if="locale == 'ko'">곧 응찰이 시작됩니다.</span><span ng-if="locale != 'ko'">The bidding stats soon.</span></td></tr>
											<tr ng-repeat="bid in offBidList">
												<td ng-if="bid.BID_NOTICE == null">
													<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">
														<span ng-if="!bid.ONLINE_BID_ID.includes('***')"><font color="red" style="font-weight:bolder">▶</font></span>
														<span ng-if="locale=='ko' && bid.BID_KIND_CD=='online'">온라인</span>
														<span ng-if="locale!='ko' && bid.BID_KIND_CD=='online'">online</span></font>
													</span>
													<span ng-if="bid.BID_KIND_CD != 'online'">
														<span ng-if="locale=='ko' && bid.BID_KIND_CD=='floor'">현장</span>
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
						</div> <!--//bid_livebox_table--> 
							       
						<!-- //응찰기록 -->     
						<div id="B1" class="tab_history tabtab client_m_only">   
							<div class="fixed-table-container">  
								<div class="fixed-table-header"></div> 
	        						<div class="fixed-table-wrap">
									<table id="tbl_employee" class="fixed-table">   
										<caption style="text-indent: -9999px;" ng-if="locale=='ko'">응찰기록</caption> <caption style="text-indent: -9999px;" ng-if="locale=='en'">bid history</caption> 
										<colgrop> 
											<col width="20%" /> 
											<col width="20%" />    
											<col width="20%" />  
											<col width="20%" />    
											<col width="20%" />      
										</colgrop>    
										<thead> 
											<tr> 
												<th scope="col">
													<div class="th-text th_history_txt"> 
														Lot		
						                            </div> 
												</th> 
												<!-- <th scope="col">
													<div class="th-text th_history_txt">
														작가/작품명		
						                            </div> 
												</th>  -->
												<th scope="col">
													<div class="th-text th_history_txt">
														bid price		
						                            </div>
												</th> 
												<th scope="col">
													<div class="th-text th_history_txt">
														sell price		
						                            </div>
												</th>
												<th scope="col">
													<div class="th-text th_history_txt"> 
														status	
						                            </div>
												</th>  
											</tr>   
										</thead>
										<tbody id="tblOffBidListBody" style="text-align:center;"> 
											<tr ng-repeat="myBidHistory in myBidHistory">
												<td ng-bind="myBidHistory.LOT_NO"></td>
												<!-- <td ng-bind="myBidHistory.ARTIST_NAME_JSON[locale]"></td> -->
												<td ng-bind="myBidHistory.LAST_BID_PRICE | number : 0"></td>  
												<td ng-bind="myBidHistory.HAMMER_BID_PRICE | number : 0"></td>
												<td ng-if="myBidHistory.LOT_NO != lot.LOT_NO && myBidHistory.LAST_BID_PRICE != myBidHistory.HAMMER_BID_PRICE"></td> 
												<td ng-if="myBidHistory.LOT_NO == lot.LOT_NO">진행중</td> 
												<td ng-if="myBidHistory.LAST_BID_PRICE == myBidHistory.HAMMER_BID_PRICE">낙찰</td> 
											</tr>
										</tbody>  
									</table> 
								</div> 
							</div>
						</div><!-- //응찰기록 -->      
						
						<!-- tabs -->  
						<div class="bidlive_tab client_m_only clearfix">    
							<div class="tab m_tab">       
								<button class="tablinks m_tablinks" onclick="openBtn(event, 'A1')" id="TabOpen">Lot</button>
								<button class="tablinks m_tablinks" onclick="openBtn(event, 'B1')"><span ng-if="locale=='ko'">응찰기록</span><span ng-if="locale=='en'">Bid history</span></button>  
							</div>  
						</div>
					</div><!-- //bidlive_50 clearfix --> 

					<!--네비게이션-->
					<%-- <div class="col12 client_web_only" align="center" style="padding-top:10px; border-top:#666 1px solid; position: relative;">
						<span class="btn_style01 green02" style="float:right;"><button type="button" ng-click="naviMoveInit(lot.LOT_NO);">
							<span ng-if="locale == 'ko'">경매중인 작품으로 이동</span><span ng-if="locale != 'ko'">Go to the Auction Item</span></button>
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
											<span ng-show="naviList.STAT_CD == 'reentry'"><font color="#999999"><span ng-if="locale == 'ko'">출품취소</span><span ng-if="locale != 'ko'">Canceled</span></font></span>
											<!-- <span ng-if="naviList.STAT_CD != 'reentry' && naviList.LIVE_STAT == 'LIVE'">
												<font color="#ffffff" size="-1" style="background:#C00; padding:4px;"><span ng-if="locale == 'ko'">경매중</span><span ng-if="locale != 'ko'">Bidding</span></font>
											</span>	 -->
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
					</div> --%><!--네비게이션-->					    
				</div><!-- // 1200 -->  
			</div>  
		</div>  
		<div class="btn_wrap">
			<span class="btn_style01 gray mid btn_pop_close" id="cancelBtn">
				<button type="button"><spring:message code="label.close" /></button>
			</span>
		</div>
	</div> <!--pop_wrap-->     
</body>   
<script>
	$(function(){ /* notice 슬라이드 배너 */   
		setInterval(function(){
			if(matchMedia("screen and (min-width:1201px)").matches) {                 
				$(".bidlivenotice_list_en>ul").delay(2500);     
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-30px"}); 
				$(".bidlivenotice_list_en>ul").delay(2500); 
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-60px"}); 
				$(".bidlivenotice_list_en>ul").delay(2500); 
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-90px"});
				$(".bidlivenotice_list_en>ul").delay(3000);
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-120px"}); 
				$(".bidlivenotice_list_en>ul").delay(2500); 
				$(".bidlivenotice_list_en>ul").animate({marginTop:"0"});  
			};
			if(matchMedia("(min-width:1024px) and (max-width:1200px)").matches) {                  
				$(".bidlivenotice_list_en>ul").delay(3000);     
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-30px"});          
				$(".bidlivenotice_list_en>ul").delay(3000);  
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-78px"});                     
				$(".bidlivenotice_list_en>ul").delay(3000);
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-118px"});                      
				$(".bidlivenotice_list_en>ul").delay(3000); 
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-150px"});                 
				$(".bidlivenotice_list_en>ul").delay(3000);
				$(".bidlivenotice_list_en>ul").animate({marginTop:"0px"}); 
			};
			if(matchMedia("(min-width:768px) and (max-width:1023px)").matches) {              
				$(".bidlivenotice_list_en>ul").delay(3000);     
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-30px"});          
				$(".bidlivenotice_list_en>ul").delay(3000);  
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-70px"});                  
				$(".bidlivenotice_list_en>ul").delay(3000);
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-118px"});                     
				$(".bidlivenotice_list_en>ul").delay(3000); 
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-150px"});                 
				$(".bidlivenotice_list_en>ul").delay(3000);
				$(".bidlivenotice_list_en>ul").animate({marginTop:"0px"});         
			}; 		
			if(matchMedia("(min-width:374px) and (max-width:767px)").matches) {         
				$(".bidlivenotice_list_en>ul").delay(3000);     
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-30px"});          
				$(".bidlivenotice_list_en>ul").delay(3000);  
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-78px"});                
				$(".bidlivenotice_list_en>ul").delay(3000);
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-118px"});                     
				$(".bidlivenotice_list_en>ul").delay(3000); 
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-150px"});                 
				$(".bidlivenotice_list_en>ul").delay(3000);
				$(".bidlivenotice_list_en>ul").animate({marginTop:"0px"});         
			}; 
			if(matchMedia("all and (max-width:373px)").matches) {      
				$(".bidlivenotice_list_en>ul").delay(3000);     
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-38px"});             
				$(".bidlivenotice_list_en>ul").delay(3000);  
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-78px"});                 
				$(".bidlivenotice_list_en>ul").delay(3000);
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-122px"});                        
				$(".bidlivenotice_list_en>ul").delay(3000); 
				$(".bidlivenotice_list_en>ul").animate({marginTop:"-170px"});                         
				$(".bidlivenotice_list_en>ul").delay(3000);
				$(".bidlivenotice_list_en>ul").animate({marginTop:"0px"});         
			}; 
			
			
		}); 
	});
	/* 탭 메뉴 */ 
	function openCity(evt, cityName) {
		var i, tabcontent, tablinks; 
		tabcontent = document.getElementsByClassName("tabcontent");      
		for (i = 0; i < tabcontent.length; i++) {  
			tabcontent[i].style.display = "none";  
		}
		tablinks = document.getElementsByClassName("tablinks"); 
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className.replace(" active",""); 
		} 
		document.getElementById(cityName).style.display = "block";
		evt.currentTarget.className += " active";   
	} 
	
	document.getElementById("defaultOpen").click();
	
	/* mobile 탭 메뉴 */ 
	function openBtn(evt, openBtn){
		var t, tabtxt, m_tablinks;
		tabtxt = document.getElementsByClassName("tabtab"); 
		for (t = 0; t < tabtxt.length; t++) {
			tabtxt[t].style.display = "none";
		}
		m_tablinks = document.getElementsByClassName("m_tablinks"); 
		for (t = 0; t < m_tablinks.length; t++) {
			m_tablinks[t].className = m_tablinks[t].className.replace(" active",""); 
		}
		document.getElementById(openBtn).style.display = "block";
		evt.currentTarget.className += " active"; 
	}
	document.getElementById("TabOpen").click();
	
	    
</script>
<script src="/js/simple.js"></script>        
</html>