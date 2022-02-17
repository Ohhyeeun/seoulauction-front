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
<!-- Expose 'llnwrtssdk' on the window global to reference in your 'subscribe' script -->
<script type="text/javascript" src="https://llrtsprod.s.llnwi.net/v1/sdk/html/current/llnwrtssdk.min.js"></script>
<!-- Recommended shim for cross-browser WebRTC support. -->
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>

<!-- Emp.css 다른페이지와 class혼동 방지 -->   
<style> 
	html, body{ 
		height:100%;
	}
	#tblOffBidListBody tr{
		height:80px;  
		font-size:35px;  
	}    
	table.fixed-table tr:nth-child(odd) { 
	 	background: #f4f4f4;        
	}  
</style>
<script>
	app.value('locale', 'ko');
	app.value('is_login', 'false');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN
	
	var winHeight = window.innerHeight;

	app.controller('liveAuctionCtl', function($scope, consts, common, $interval) {
		
		$scope.sale_no = getParameter('sale_no');
		
		$scope.init = function(){
			$scope.loadLiveAuction();
	 	} 
		 
		$scope.loadLiveAuction = function(){
			$d = {"baseParms":{"sale_no":$scope.sale_no },
					"actionList":[
// 						{"actionID":"liveLotNoInfo", "actionType":"select" , "tableName": "LOT"},
// 						{"actionID":"offBidList", "actionType":"select", "tableName":"BID_OFF_LIST"}, // Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
						{"actionID":"offBidListEmp", "actionType":"select" , "tableName": "BID_OFF_LIST"},
					]};	 	   	
			common.callActionSet($d, $s);
		}
		
		var $s = function(data, status) {
			
			$scope.offBidList = data["tables"]["BID_OFF_LIST"]["rows"];// Live 진행 LOT번호 응찰금액 호출 추가(2018.04.18 YDH)
			$scope.lotNo = $scope.offBidList[0].LOT_NO;
		}
		
		$scope.$on('ngRepeatFinished', function (ngRepeatEndEvent) { 
			var bidval = $("#tblOffBidListBody").children().first().attr("data-attr"); //마지막 응찰 현장/온라인 구분
			$scope.lastBidKind = $scope.isValidString(bidval)? bidval : "현장"; //null이면 현장 !null이면 온라인
		});
		
		
		// Lot Refresh : 1초단위 
		$interval(function(){$scope.loadLiveAuction();},1000); 
		
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
		
		$scope.winHeight = function(type){
			if(type == "table"){
				return {"height" : window.innerHeight - 120 +"px"} // window.innerHeight - (header높이) - (thead높이)
			}else{
				return {"height" : window.innerHeight - 55 +"px"} // window.innerHeight - (header높이)
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
		<div class="title bidlive_header web_only"><h2>Seoul Auction LIVE</h2></div>       
		<div ng-controller="liveAuctionCtl" data-ng-init="init()" style="display:flex">    
			<div id="" ng-style="winHeight()" class="bid_livebox_table PaddNo_width">        
				<span id="paddNo" class="posi_ab Paddtit_blue" style="right:20px;">PADD NO.</span>       
				<span id="lotNo" class="posi_ab" style="left:20px;">Lot. {{lotNo}}</span>    
				<span id="bidKindTxt1">{{lastBidKind}}</span>   
			</div>       
			  
			<div id="" style="width:55%; display: flex; flex-direction: column;" class="bid_livebox_table tabtab clearfix">    
			<div class="bidlive_currency" style="text-align:right;padding:3px;"><span ng-if="locale=='ko'">통화:</span><span ng-if="locale!='ko'">Currency:</span>&nbsp;[KRW]</div><!-- {{sale.CURR_CD}} -->
			
			<!-- scroll START (2018.04.18 YDH) -->   
			<div class="fixed-table-container A1_table">    
				<div class="fixed-table-header"></div> 
				<div class="fixed-table-wrap" style="max-height:unset; overflow:hidden; overflow-y:scroll" ng-style="winHeight('table')"  >     <!-- ng-style="winHeight('table')"style="overflow:hidden; overflow-y:scroll;" -->
					<table id="tbl_employee" class="fixed-table"> 
						<colgroup> 
							<col width="35%"/>  
							<col width="65%"/>  
						</colgroup>
						<thead>
							<tr>
								<!-- <th scope="col">
									<div class="th-text client_th-text">
										<span ng-if="locale == 'ko'">응찰구분</span><span ng-if="locale != 'ko'">Bidding</span>
									</div> 
								</th> -->
								<th scope="col">
									<div class="th-text client_th-text" style="width: 35%;"><span>Paddle No</span>
									</div>  
								</th>
								<th scope="col">
									<div class="th-text client_th-text" style="width: 65%;">   
										<span ng-if="locale == 'ko'">응찰금액</span><span ng-if="locale != 'ko'">Bid Price</span>
									</div>
								</th>
								<!-- <th scope="col">
									<div class="th-text">
										<span ng-if="locale == 'ko'">기준통화</span><span ng-if="locale != 'ko'">Currency</span>
									</div>
								</th> -->    
							</tr>
						</thead>
						<tbody id="tblOffBidListBody" >     
							<tr ng-repeat="bid in offBidList" ng-if="bid.BID_NOTICE == null" data-attr="{{bid.ONLINE_BID_ID}}" on-finish-render-filters>        
								<td ng-if="bid.BID_NOTICE == null" > 
									<span ng-if="bid.BID_KIND_CD == 'online' && locale == 'ko'"><font color="blue" style="font-weight:bolder">{{bid.ONLINE_BID_ID}}</font></span>
									<span ng-if="bid.BID_KIND_CD != 'online' && locale == 'ko'">현장 응찰</span>
									<span ng-if="bid.BID_KIND_CD == 'online' && locale != 'ko'"><font color="blue" style="font-weight:bolder">{{bid.ONLINE_BID_ID}}</font></span>
									<span ng-if="bid.BID_KIND_CD != 'online' && locale != 'ko'">Floor</span>
								</td>     
								<td ng-if="bid.BID_NOTICE == null">
									<span ng-if="$first"><font color="red" style="font-weight:bolder">{{bid.BID_PRICE | number:0}}</font></span>
									<span ng-if="!$first">
										<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{bid.BID_PRICE | number:0}}</font></span>
										<span ng-if="bid.BID_KIND_CD != 'online'">{{bid.BID_PRICE | number:0}}</span>
									</span>
								</td>
<!-- 									<td ng-if="bid.BID_NOTICE != null" colspan="2" style="color:red; text-align:center;"><span ng-if="locale == 'ko'">{{bid.BID_NOTICE}}</span><span ng-if="locale != 'ko'">{{bid.BID_NOTICE_EN}}</span></td> -->
								<!-- <td ng-if="bid.BID_NOTICE == null">  
									<span ng-if="bid.BID_KIND_CD == 'online'"><font color="blue" style="font-weight:bolder">{{sale.CURR_CD}}</font></span>
									<span ng-if="bid.BID_KIND_CD != 'online'">{{sale.CURR_CD}}</span>
								</td> --> 
							</tr>
							<tr ng-show="offBidList.length == 0" class="Rorr"><td colspan="2"><span ng-if="locale == 'ko'">곧 응찰이 시작됩니다.</span><span ng-if="locale != 'ko'">The bidding stats soon.</span></td></tr>
							
						</tbody>
					</table>
				</div>
			</div>  
<!-- 			<div style="display:flex; justify-content: center; align-items:center; margin-top:auto;"> -->
<!-- 				<span id="lotNo" style="font-size:190px; font-weight:bold;">Lot. {{lotNo}}</span> -->
<!-- 			</div> -->
			</div> <!--//bid_livebox_table--> 
		</div><!-- controller -->
	</div> <!--pop_wrap-->
</body>

<script src="/js/simple.js"></script>
</html>