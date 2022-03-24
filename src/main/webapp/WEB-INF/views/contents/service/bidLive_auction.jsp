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

<script>
	app.value('locale', 'ko');
	app.value('is_login', 'false');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN

	app.controller('liveAuctionMeCtl', function($scope, consts, common, $interval) {
		$scope.cnt = 0; // 네비게이션 실행여부 확인(2018.04.25)
		$scope.lot_move_init = "NO";
		$scope.sale_no = getParameter('sale_no');
		
		$scope.init = function(){
			$scope.loadLiveAuction();
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
			$scope.live_lot_no = $scope.lot.LOT_NO;  //현재 진행중인 LOT 번호
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
		<div ng-controller="liveAuctionMeCtl" data-ng-init="init()">
			<div class="auction_ready_wrap" ng-if="lot.LOT_NO == null"><!-- 경매 준비중인 경우 -->  
				<h2 class="auction_ready">  
					<span ng-if="locale=='ko'">경매 준비중입니다.</span><span ng-if="locale!='ko'">Auction Preparing.</span>
				</h2> 
			</div>
			<div ng-if="lot.LOT_NO != null"><!-- 경매 진행중인 경우 -->
	            <!--main --> 
				<div class="onepcssgrid-1200 client_onepcssgrid-1200 clearfix">
					<!-- 오른쪽 화면 -->  
					<div class="clearfix">
					<div class="clearfix" style="padding: 10px; padding-top: 25px;">                
							<div class="bidlive_accountlist">      
								LOT. <span ng-bind="lot.LOT_NO"></span> 
							</div>     
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
											</tr>
										</tbody>
									</table>
								</div>
							</div>  
						</div> <!--//bid_livebox_table--> 
					</div><!-- //bidlive_50 clearfix --> 
				</div><!-- // 1200 -->  
			</div>
		</div>  
	</div> <!--pop_wrap-->  
</body>
</html>