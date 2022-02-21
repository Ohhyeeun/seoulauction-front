app.factory("bid", function ($interval, ngDialog) {
	var saleCert = function($input, $callBack) {
		$input.parent.cancelLotRefresh();

		// cookie.provider_type = ssg
		const isSSG = getCookie('provider_type');
		let controller = 'saleCertCtl';

		if (isSSG && isSSG === 'ssg') {
			controller = 'saleCertSSGCtl';
		}

		$input.parent.modal = ngDialog.open({
			template: '/saleCert?sale_no=' + $input.sale.SALE_NO + '&ssg=y',
			controller: controller,
			showClose: false,
			closeByDocument: false,
			animationEndSupport: false,
			resolve: {input: function(){return $input;}}
		});
	};
	
	var bidPopup = function($input) {
		$input.parent.cancelLotRefresh();
		$input.parent.modal = ngDialog.open({
			template: '/bid?sale_no=' + $input.sale.SALE_NO + '&lot_no=' + $input.lot.LOT_NO,
			controller: 'bidListCtl',
			showClose: false,
			closeByDocument: false,
			animationEndSupport: false,
			resolve: {input: function(){return $input;}}
		});
	};
	
	var objs = {
		
		saleCertCheck: function($input) {
			//if($input.parent.is_login == "true" && $input.parent.locale == 'ko' && ($input.parent.sale_cert.CNT || 0) <= 0){
			if($input.parent.is_login == "true" && $input.parent.custInfo.LOCAL_KIND_CD != 'foreigner' && ($input.parent.sale_cert.CNT || 0) <= 0){
				$input.parent.cancelLotRefresh();
				saleCert($input);
			}
		},

		showBidPopup: function($input) {
			if(!$input.parent.is_login){
				document.location.href='/login';
				return;
			}

			//if($input.parent.locale == 'ko' && ($input.parent.sale_cert.CNT || 0) <= 0){
			if($input.parent.custInfo.LOCAL_KIND_CD != 'foreigner' && ($input.parent.sale_cert.CNT || 0) <= 0){
				$input.parent.cancelLotRefresh();
				$input.callBack = bidPopup;
				saleCert($input);
			}else{
				bidPopup($input);
			}
		},

		showBidRequestPopup: function($input) {
			$input.parent.modal = ngDialog.open({
				template: '/bidRequest?sale_no=' + $input.sale.SALE_NO + '&lot_no=' + $input.lot.LOT_NO,
				controller: 'bidRequestCtl',
				showClose: false,
				closeByDocument: false,
				animationEndSupport: false,
				resolve: {input: function(){return $input;}}
			});
		},
		
		showConditionReportPopup: function($input) {
			$input.parent.modal = ngDialog.open({
				template: '/conditionReport?sale_no=' + $input.sale_no + '&lot_no=' + $input.lot_no,
				showClose: false,
				closeByDocument: false,
				animationEndSupport: false,
				resolve: {input: function(){return $input;}}
			});
		},
		
		liveAuctionBidPopup: function($input) {
			$input.parent.modal = ngDialog.open({
				template: '/liveAuctionPop?padd_no=' + $input,
				showClose: false,
				closeByDocument: false,
				animationEndSupport: false,
				resolve: {input: function(){return $input;}}
			});
		},

		showBidHistoryPopup: function($input) {
			$input.parent.modal = ngDialog.open({
				template: '/bidHistory?sale_no=' + $input.sale.SALE_NO + '&lot_no=' + $input.lot.LOT_NO,
				controller: 'bidHistoryCtl',
				closeByDocument: false,
				showClose: false,
				animationEndSupport: false,
				resolve: {input: function(){return $input;}}
			});
		},
		
		memberAlert: function() {
			if($scope.locale == 'ko'){
				alert("서면/전화 작품응찰신청은 정회원만 이용하실 수 있습니다.");
			} else {
				alert("Written/Telephone works can only be used by Subscription Members.");
			}
		},

		/* 국외회원 응찰자격 확인 */
		showBiddingMemberPopup: function() {
			if(m_bIsLogged) {
				if(confirm("Only bidding member can bid online auction. Do you want to become a bidding memeber?")) {
					$(".pop15").click(); // /eng/biddingMember 팝업
				}
			}
			else {
				alert("Please log in to use the service.");
			}
		},
		
	};
	
	return objs;
});

app.controller('bidListCtl', function($scope, consts, common, $interval, input, locale, $filter) {
	
	$scope.sale = input.sale;
	$scope.lot =  input.lot;
	$scope.parent = input.parent;
	
	$scope.last_bid_no = 0;
	$scope.auto_req_price = 0;
	$scope.auto_req_no = null;
	
	$scope.low_price = $scope.bid_price = $scope.bid_auto_price = $filter("number")(($scope.lot.LAST_PRICE !== null ? $scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE : $scope.lot.START_PRICE), 0);
	
	$scope.bidList = [];

	$scope.closed = false;
	$scope.base_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKD" : "KRW");
	$scope.timer_bid_start = false;
	$scope.chkAgree = ($scope.lot.MY_BID_SALE_CNT > 0 ? true : false);
	
	$scope.close = function(modal){
		$scope.cancelTimer();
		$scope.parent.refreshLots();
		$scope.parent.runLotsRefresh();
		modal.closeThisDialog();
	}
	
	$scope.init = function(){
		$scope.loadBidList();
	}
	
	$scope.loadBidList = function(){
		if($scope.is_processing) return;
		
		$d = {"baseParms":{"sale_no":$scope.sale.SALE_NO, "lot_no":$scope.lot.LOT_NO},
 				"actionList":[
			    {"actionID":"lot_list_refresh", "actionType":"select" , "tableName":"LOT", "parmsList":[{"lot_nos":[$scope.lot.LOT_NO]}]},
			    {"actionID":"last_auto_bid_req", "actionType":"select" , "tableName":"AUTO"},
			    {"actionID":"bid_list", "actionType":"select" , "tableName":"LIST", "parmsList":[{"limit":20}]} //, "parmsList":[{"last_bid_no":$scope.last_bid_no}]
 			 ]};
		
  	   	common.callActionSet($d, $s, $e, finalRefresh);
	}

	$scope.bidOnce = function(){
		if($scope.is_processing) return;

		if($scope.lot.IS_WIN == 'Y'){			
			if(locale == 'ko'){
				alert("최고가 응찰 중 입니다.");
			} else {
				alert("Hightest bid has just been made");
			}
			return;
		}
		
/*		if (!$scope.chkAgree){
			if(locale == 'ko'){
				alert("응찰 동의 체크해야 응찰하실 수 있습니다.");
			} else {
				alert("You can bid after 'Accept the bidding' check.");
			}
			return;
		}
*/		
		if($scope.lot.LAST_PRICE !== null && $scope.lot.LAST_PRICE >= parseInt($scope.bid_price.replace(/,/gi, "")) ){
			if(locale == 'ko'){
				alert("응찰가가 현재가 보다 커야 합니다.");
			} else {
				alert("The bidding price must be greater than the current price.");
			}
			return;
		}
		
		if($scope.auto_req_price > $scope.lot.LAST_PRICE){
			if(locale == 'ko'){
				alert("자동 응찰 중에는 수동으로 응찰하실 수 없습니다.");
			} else {
				alert("You can not manually bidding during auto bidding.");
			}
		}else{
			$scope.is_processing = true;
			$d = {"baseParms":{"sale_no":$scope.sale.SALE_NO, "lot_no":$scope.lot.LOT_NO},
	 				"actionList":[
				    {"actionID":"bid_once", "actionType":"insert" , "tableName":"BID", "parmsList":[{"bid_price":parseInt($scope.bid_price.replace(/,/gi, "")) }]}
				    , {"actionID":"lot_list_refresh", "actionType":"select" , "tableName":"LOT", "parmsList":[{"lot_nos":[$scope.lot.LOT_NO]}]}
				    , {"actionID":"bid_list", "actionType":"select" , "tableName":"LIST", "parmsList":[{"limit":20}]} //, "parmsList":[{"last_bid_no":$scope.last_bid_no}]
	 		]};
	  	   	common.callActionSet($d, $s, $e);//, finalRefresh);
		}
	}

	$scope.bidAuto = function(){
		if($scope.is_processing) return;

		$d = {"baseParms":{"sale_no":$scope.sale.SALE_NO, "lot_no":$scope.lot.LOT_NO}, "actionList":[]};
		
		if ($scope.lot.MY_BID_AUTO_CNT < 1){			
			if(locale == 'ko'){
				if(confirm("자동응찰 중지하기 전까지의 응찰 및 낙찰 내역은 모두 기록되며 유효합니다.\n응찰 하시겠습니까?") == false){
					return
				}
			} else {
				if(confirm("All bid and bid records before automatic bidding is stopped are recorded and valid.\nWould you like to bidding?") == false){
					return
				}
			}
		}
				
		/*if (!$scope.chkAgree){
			if(locale == 'ko'){
				alert("응찰 동의 체크해야 응찰하실 수 있습니다.");
			} else {
				alert("You can bid after 'Accept the bidding' check.");
			}
			return;
		}*/
		
		
		////2018.09.10 blueerr 자동입찰가를 직접입력가능하게 하므로 호가단위를 체크한다. 호가 변경으로 주석처리(2019.09.17 YDH)
		//var tmp_p = parseInt($scope.bid_auto_price.replace(/,/gi, "")) - $scope.lot.START_PRICE;
		//var remain = (tmp_p % $scope.lot.GROW_PRICE);
		//if(remain > 0){
		//	alert("자동 응찰가는 호가단위로 입력하셔야 합니다.");
		//	return;
		//}

		if($scope.auto_req_price > $scope.lot.LAST_PRICE){
			if(locale == 'ko'){
				if(confirm('자동응찰 중지하기는 자동 응찰 취소가 아닙니다.\n비딩이 올라간 상태에서 정지됩니다.\n자동 응찰을 중지 하겠습니까?')){
					$scope.is_processing = true;
					var action = {"actionID":"bid_auto_cancel", "actionType":"update" , "tableName":"BID", "parmsList":[{"req_no":$scope.auto_req_no}]};
					$d.actionList.push(action);
				}
				else{
					return;
				}
			} else {
				if(confirm('Stopping automatic bidding is not a cancellation of automatic bidding.\nThe bidding will stop when it is up.\nDo you want to stop automatic bidding?')){
					$scope.is_processing = true;
					var action = {"actionID":"bid_auto_cancel", "actionType":"update" , "tableName":"BID", "parmsList":[{"req_no":$scope.auto_req_no}]};
					$d.actionList.push(action);
				}
				else{
					return;
				}
			}
		}
		else{
			
			if($scope.lot.LAST_PRICE !== null && $scope.lot.LAST_PRICE >= parseInt($scope.bid_auto_price.replace(/,/gi, "")) ){
				if(locale == 'ko'){
					alert("자동 응찰가가 현재가 보다 커야 합니다.");
				} else {
					alert("The bidding price must be greater than the current price.");
				}
				return;
			}
			////호가단위 입력 체크로직 추가(2018.07.25)
			//if(parseInt($scope.bid_auto_price.replace(/,/gi, ""))%$scope.lot.GROW_PRICE != 0 ){
			//	alert("자동 응찰가는 호가단위로 입력하셔야 합니다.");
			//	return;
			//}
			
			$scope.is_processing = true;
			var action = {"actionID":"bid_auto_add", "actionType":"insert" , "tableName":"BID", "parmsList":[{"bid_price":parseInt($scope.bid_auto_price.replace(/,/gi, "")) }]};
			$d.actionList.push(action);
		}
		$d.actionList.push({"actionID":"last_auto_bid_req", "actionType":"select" , "tableName":"AUTO"});
		$d.actionList.push({"actionID":"lot_list_refresh", "actionType":"select" , "tableName":"LOT", "parmsList":[{"lot_nos":[$scope.lot.LOT_NO]}]});
		$d.actionList.push({"actionID":"bid_list", "actionType":"select" , "tableName":"LIST", "parmsList":[{"limit":20}]}); //, "parmsList":[{"last_bid_no":$scope.last_bid_no}]}
  	   	common.callActionSet($d, $s, $e);//, finalRefresh);

	}
	
	var $e = function(){
		$scope.cancelTimer();
	   	$scope.is_processing = false;
	}
	
	var $s = function(data, status) {
		if(data["tables"]["AUTO"] && data["tables"]["AUTO"]["rows"].length > 0){
			$scope.auto_req_price = data["tables"]["AUTO"]["rows"][0].BID_PRICE;
			$scope.auto_req_no = data["tables"]["AUTO"]["rows"][0].REQ_NO;
		}
		else{
			$scope.auto_req_price = 0;
			$scope.auto_req_no = null;
		}
		
		var src = data["tables"]["LIST"]["rows"];
		
		if(src.length > 0){
			$scope.bidList = src;
			//$scope.bidList = src.concat($scope.bidList);
		}
		
		//angular.extend($scope.bidList, data["tables"]["LIST"]["rows"]);
		var $lotInfo = data["tables"]["LOT"]["rows"][0];
		$scope.lot["STAT_CD"] =$lotInfo["STAT_CD"];
		$scope.lot["TO_DT"] = $lotInfo["TO_DT"];
		$scope.lot["LAST_PRICE"] = $lotInfo["LAST_PRICE"];
		$scope.lot["LAST_CUST_ID"] = $lotInfo["LAST_CUST_ID"];
		$scope.lot["SOLD_YN"] = $lotInfo["SOLD_YN"];
		$scope.lot["BID_CNT"] = $lotInfo["BID_CNT"];
		$scope.lot["IS_WIN"] = $lotInfo["IS_WIN"];
		$scope.lot["END_YN"] = $lotInfo["END_YN"];
		$scope.lot["GROW_PRICE"] = $lotInfo["GROW_PRICE"];
		
		$scope.parent.db_now = moment($lotInfo["DB_NOW"]);
		
		$scope.low_price = ($scope.lot.LAST_PRICE !== null ? $scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE : $scope.lot.START_PRICE);
		$scope.bid_price = parseInt($scope.bid_price.replace(/,/gi, "")) <= $scope.low_price ? $filter("number")($scope.low_price, 0) : $scope.bid_price;
		$scope.bid_auto_price = parseInt($scope.bid_auto_price.replace(/,/gi, "")) <= $scope.low_price ? $filter("number")($scope.low_price, 0) : $scope.bid_auto_price;
		
		if($scope.lot.END_YN == 'Y'){
			$scope.cancelTimer();
			$d = {"baseParms":{"sale_no":$scope.sale.SALE_NO, "lot_no":$scope.lot.LOT_NO}
				, "actionList":[{"actionID":"bid_list", "actionType":"select" , "tableName":"LIST"}]
			};
			
			common.callActionSet($d, function(data, status){
				var src = data["tables"]["LIST"]["rows"];
				if(src.length > 0){
					$scope.bidList = src;
				}
			});
			//$scope.closed = true;
		}
		$scope.is_processing = false;
	};
	
	$scope.getDuration = function(){
		if(locale == 'ko'){
			return $scope.lot.END_YN == 'Y' ? '종료' : $scope.parent.getDurationTime($scope.lot.TO_DT, locale == 'ko' ? 'd일 h:m:s' : 'd[Days] h:m:s');
		} else {
			return $scope.lot.END_YN == 'Y' ? 'Closed' : $scope.parent.getDurationTime($scope.lot.TO_DT, locale == 'ko' ? 'd일 h:m:s' : 'd[Days] h:m:s');
		}
	}

	var finalRefresh = function(){
		//if($scope.closed) return;
		$scope.is_processing = false;
		if($scope.timer_bid_start) return;
		console.log("========> start bid timer");
		$scope.timer_bid_list_refersh = $interval($scope.loadBidList, 5000);//, 1);
		$scope.timer_bid_start = true;
	}
	
	$scope.cancelTimer = function(){
		$interval.cancel($scope.timer_bid_list_refersh);
		console.log("============>> cancel BidTimer");
	} 
	
	$scope.setBidPrice = function(flag) {
		var p = parseInt($scope.bid_price.replace(/,/gi, ""));
		 
		if(flag == 'up')		p += $scope.lot.GROW_PRICE;
		else if(flag == 'down')	p -= $scope.lot.GROW_PRICE;
		
		if(p < $scope.low_price) p = $scope.low_price; 
		$scope.bid_price = $filter("number")(p, 0);
	};

	$scope.setBidAutoPriceBak = function(flag) {
		var p = parseInt($scope.bid_auto_price.replace(/,/gi, ""));
		 
		if(flag == 'up')		p += $scope.lot.GROW_PRICE;
		else if(flag == 'down')	p -= $scope.lot.GROW_PRICE;
		
		if(p < $scope.low_price) p = $scope.low_price; 
		$scope.bid_auto_price = $filter("number")(p, 0);
	};

	//2018.09.10 blueerr 자동입찰가를 직접입력가능하게 하므로 호가단위로 +,- 처리
	$scope.setBidAutoPrice = function(flag) {
		var tmp_p = parseInt($scope.bid_auto_price.replace(/,/gi, "")) - $scope.lot.START_PRICE;
		var p = parseInt(tmp_p / $scope.lot.GROW_PRICE) * $scope.lot.GROW_PRICE; 
		var remain = (tmp_p % $scope.lot.GROW_PRICE);
		
		if(flag == 'up')		p += $scope.lot.GROW_PRICE;
		else if(flag == 'down' && remain == 0)	p -= $scope.lot.GROW_PRICE;
		
		p += $scope.lot.START_PRICE;
		
		if(p < $scope.low_price) p = $scope.low_price; 
		$scope.bid_auto_price = $filter("number")(p, 0);
	};
	
	//2019.08.05 호가 자동 변경 처리
	$scope.setBidAutoPriceAuto = function(flag){
		//자동 호가 범위 변수
		var tmp_grow_price = 0;
		var bidAutoPrice = parseInt($scope.bid_auto_price.replace(/,/gi, ""));
		//alert(bidAutoPrice);
		if (flag == 'up'){
			if (bidAutoPrice < 1000000){
				tmp_grow_price = 50000;
				//alert("호가- 50만미만");
			//} else if (bidAutoPrice >= 500000 && bidAutoPrice < 1000000){
			//	tmp_grow_price = 50000;
			//	//alert("호가- 100만미만");
			} else if (bidAutoPrice >= 1000000 && bidAutoPrice < 3000000){
				tmp_grow_price = 100000;
				//alert("호가- 300만미만");
			} else if (bidAutoPrice >= 3000000 && bidAutoPrice < 5000000){
				tmp_grow_price = 200000;
				//alert("호가- 500만미만");
			} else if (bidAutoPrice >= 5000000 && bidAutoPrice < 10000000){
				tmp_grow_price = 300000;
				//alert("호가- 1000만미만");
			} else if (bidAutoPrice >= 10000000 && bidAutoPrice < 30000000){
				tmp_grow_price = 500000;
				//alert("호가- 3000만미만");
			} else if (bidAutoPrice >= 30000000 && bidAutoPrice < 50000000){
				tmp_grow_price = 1000000;
				//alert("호가- 5000만미만");
			} else if (bidAutoPrice >= 50000000 && bidAutoPrice < 100000000){
				tmp_grow_price = 2000000;
				//alert("호가- 1억미만");
			} else if (bidAutoPrice >= 100000000 && bidAutoPrice < 200000000){
				tmp_grow_price = 3000000;
				//alert("호가- 2억미만");
			} else if (200000000 <= bidAutoPrice){
				tmp_grow_price = 5000000;
				//alert("호가- 2억이상");
			} else {
				tmp_grow_price = $scope.lot.GROW_PRICE;
				//alert("호가- 기본값 설정");
			}
		} else {
			if (bidAutoPrice <= 1000000){
				tmp_grow_price = 50000;
				//alert("호가- 50만미만");
			//} else if (bidAutoPrice > 500000 && bidAutoPrice <= 1000000){
			//	tmp_grow_price = 50000;
			//	//alert("호가- 100미만");
			//	if((bidAutoPrice - tmp_grow_price) < 500000){
			//		tmp_grow_price = 10000;
			//	}
			} else if (bidAutoPrice > 1000000 && bidAutoPrice <= 3000000){
				tmp_grow_price = 100000;
				//alert("호가- 300만미만");
				if((bidAutoPrice - tmp_grow_price) < 1000000){
					tmp_grow_price = 50000;
				}
			} else if (bidAutoPrice > 3000000 && bidAutoPrice <= 5000000){
				tmp_grow_price = 200000;
				//alert("호가- 500만미만");
				if((bidAutoPrice - tmp_grow_price) < 3000000){
					tmp_grow_price = 100000;
				}
			} else if (bidAutoPrice > 5000000 && bidAutoPrice <= 10000000){
				tmp_grow_price = 300000;
				//alert("호가- 1000만미만");				
				if((bidAutoPrice - tmp_grow_price) < 5000000){
					tmp_grow_price = 100000;
				}
			} else if (bidAutoPrice > 10000000 && bidAutoPrice <= 30000000){
				tmp_grow_price = 500000;
				//alert("호가- 3000만미만");alert("test");
				if((bidAutoPrice - tmp_grow_price) < 10000000){
					tmp_grow_price = 300000;
				}
			} else if (bidAutoPrice > 30000000 && bidAutoPrice <= 50000000){
				tmp_grow_price = 1000000;
				//alert("호가- 5000만미만");
				if((bidAutoPrice - tmp_grow_price) < 30000000){
					tmp_grow_price = 500000;
				}
			} else if (bidAutoPrice > 50000000 && bidAutoPrice <= 100000000){
				tmp_grow_price = 2000000;
				//alert("호가- 1억미만");
				if((bidAutoPrice - tmp_grow_price) < 50000000){
					tmp_grow_price = 1000000;
				}
			} else if (bidAutoPrice > 100000000 && bidAutoPrice <= 200000000){
				tmp_grow_price = 3000000;
				//alert("호가- 2억미만");
				if((bidAutoPrice - tmp_grow_price) < 100000000){
					tmp_grow_price = 2000000;
				}
			} else if (200000000 < bidAutoPrice){
				tmp_grow_price = 5000000;
				//alert("호가- 2억이상");
				if((bidAutoPrice - tmp_grow_price) < 200000000){
					tmp_grow_price = 3000000;
				}
			} else {
				tmp_grow_price = $scope.lot.GROW_PRICE;
				//alert("호가- 기본값 설정");
			}
		}
		
		//alert(tmp_grow_price);
		//현재 자동응찰 금액 과 호가폭 산정
		// up / down
		if(flag == 'up')		bidAutoPrice += tmp_grow_price;
		else if(flag == 'down')	bidAutoPrice -= tmp_grow_price;

		// 금액이 낮은 가격보다 작을 경우 
		if(bidAutoPrice < $scope.low_price) bidAutoPrice = $scope.low_price; 
		$scope.bid_auto_price = $filter("number")(bidAutoPrice, 0);
	}

	$scope.setLastBidNo = function($bid_no) {
		if($bid_no > $scope.last_bid_no) $scope.last_bid_no = $bid_no;
	};
	
	$scope.setChkAgree = function(flag) {
		$scope.chkAgree = flag;
	};
});

app.controller('bidHistoryCtl', function($scope, consts, common, $interval, input) {
	$scope.sale = input.sale;
	$scope.lot =  input.lot;
	$scope.parent = input.parent;
	$scope.base_currency = ($scope.sale.SALE_KIND_CD == 'hongkong' ? "HKD" : "KRW");
	
	$scope.loadBidHistory = function(){
		$d = {"baseParms":{"sale_no":$scope.sale.SALE_NO, "lot_no":$scope.lot.LOT_NO},//, "last_bid_no":$scope.last_bid_no},
 				"actionList":[
 			    {"actionID":"bid_list", "actionType":"select" , "tableName": "LIST"}
 			 ]};

  	   	common.callActionSet($d, 
  	   			function(data, status) { 
  	   		$scope.bidList = data["tables"]["LIST"]["rows"]; 
  	   	});
	}
});
/* aa */
app.controller('bidRequestCtl', function($scope, consts, common, $interval, input, $filter) {
	$scope.sale = input.sale;
	$scope.lot =  input.lot;
	$scope.parent = input.parent;
//	$scope.base_currency = $scope.lot.CURR_CD == 'HKD' ? $scope.lot.CURR_CD : 'KRW';
	$scope.base_currency = $scope.sale.CURR_CD;
	$scope.bid_auto_price = $filter("number")($scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency], 0); //시작가 or 낮은 추정가
	$scope.low_price = $scope.lot.EXPE_PRICE_FROM_JSON[$scope.base_currency];
	
	$scope.custInfo = input.parent.custInfo;
	
	$scope.base_currency = $scope.sale.CURR_CD;
	
	$scope.loadBidRequest = function(){
		$d = {"baseParms":{"cust_no":$scope.custInfo.CUST_NO},
 				"actionList":[
 			    {"actionID":"get_customer_manager", "actionType":"select" , "tableName": "CUSTM"}
 			 ]};

  	   	var $s = function(data, status) { $scope.cust_manager = data["tables"]["CUSTM"]["rows"][0]; };
  		
  	   	common.callActionSet($d, $s);
	}
	
	$scope.chkConfirm = false;
	$scope.chkAgree = false;
	$scope.chkCustInfo = false;
	$scope.save_data = {};
	$scope.save_data.sale_no = $scope.sale.SALE_NO;
	$scope.save_data.lot_no = $scope.lot.LOT_NO;
	$scope.save_data.bid_kind_cd = "phone";
	$scope.save_data.bid_price = null;

	$scope.save_data.hp = $scope.custInfo.HP;
	$scope.save_data.email = $scope.custInfo.EMAIL;
	
	$scope.returnOfflineGrowPrice = $scope.parent.returnOfflineGrowPrice;
	
	$scope.saveBidRequest = function(form){
		// 경매일 전날까지만 응찰신청가능. 경매일 이후부터는 응찰 불가 처리. 로컬 타임존을 표준시(UTC)+KST(9)반영 일자 변경
		var dt = new Date();
		var kst_base_tz = (dt.getTime() + (dt.getTimezoneOffset() * 60000) + (9 * 3600000)); // 현지 타임존 기준으로 UTC 표준시 + KST 변환
		dt.setTime(kst_base_tz);  // KST기준으로 TIME ZONE 변경
		
		var kst_base_dt = dt.getFullYear()+(dt.getMonth()+1 > 9? '' : '0')+(dt.getMonth()+1)+(dt.getDate() > 9? '' : '0')+(dt.getDate()); // KST시간

		var sale_to_dt = new Date($scope.lot.SALE_TO_DT);
		var kst_base_tz1 = (sale_to_dt.getTime() + (sale_to_dt.getTimezoneOffset() * 60000) + (9 * 3600000)); // 현지 타임존 기준으로 SALE_TO_DT를 UTC 표준시 + KST 변환
		sale_to_dt.setTime(kst_base_tz1);  // KST기준으로 TIME ZONE 변경
		var kst_sale_to_dt = sale_to_dt.getFullYear()+(sale_to_dt.getMonth()+1 > 9? '' : '0')+(sale_to_dt.getMonth()+1)+(sale_to_dt.getDate() > 9? '' : '0')+(sale_to_dt.getDate()); // KST시간 
		
		if($scope.sale.CURR_CD != 'USD' && $scope.save_data.bid_kind_cd != 'phone')	
			$scope.save_data.bid_price = $scope.bid_auto_price;
		
		if( kst_base_dt >= kst_sale_to_dt){  //경매종료일 기준으로 현재일자가 이전이어야 함. 당일 미포함!
			if($scope.locale == 'ko'){
				alert("응찰 가능한 시간이 아닙니다. 경매일 전날까지만 응찰이 가능합니다.");
			} else{
				alert("It's not time for bidding. It is possible to bid only until the day before Auction Day.");
			}			
			return;
		}
		
		if(!$scope.chkCustInfo){
			if($scope.locale == 'ko'){
				alert("연락처 정보를 확인 후 동의 바랍니다.");
			} else{
				alert("Please, confirm your contact information.");
			}			
			return;
		}
		
		var checkboxLen = $("input:checkbox[name=agreePop_checkbox]").length; //체크박스 전체 개수
		var checkedLen = $("input:checkbox[name=agreePop_checkbox]:checked").length; //체크된 개수
		
		if(checkboxLen != checkedLen){
			alert($scope.locale == 'ko'? "약관에 모두 동의해주세요." : "Please agree to all the terms and conditions." );
			return;
		}
		
			                 
		if($scope.locale == 'ko'){
			if(!confirm("응찰하시겠습니까?")) return;
		}else {
			if(!confirm("Are you going to bid?")) return;
		}
		
		if($scope.save_data.bid_price){
			$scope.save_data.bid_price = parseInt($scope.save_data.bid_price.replace(/,/gi, ""));
		}
		
		$scope.changeBidKind();
		
		if($scope.sale.CURR_CD == 'KRW'){
			if($scope.save_data.bid_kind_cd != 'phone' && $scope.lot.EXPE_PRICE_INQ_YN != 'Y' && $scope.lot.EXPE_PRICE_FROM_JSON.KRW > $scope.save_data.bid_price){
				if($scope.locale == "ko"){
					alert("응찰금액은 낮은 추정가(KRW) 보다 커야 합니다.");
				} else{
					alert("The Maximum price should be higher than the low estimate price(KRW).");
				}
				return;
			}
		} 
		
		if($scope.sale.CURR_CD == 'USD'){
			if($scope.save_data.bid_kind_cd != 'phone' && $scope.lot.EXPE_PRICE_INQ_YN != 'Y' && $scope.lot.EXPE_PRICE_FROM_JSON.USD > $scope.save_data.bid_price){
				if($scope.locale == "ko"){
					alert("응찰금액은 낮은 추정가(USD) 보다 커야 합니다.");
				} else{
					alert("The Maximum price should be higher than the low estimate price(USD).");
				}
				return;
			}
		} 
			
		if($scope.sale.CURR_CD == 'HKD'){
			if($scope.save_data.bid_kind_cd != 'phone' && $scope.lot.EXPE_PRICE_INQ_YN != 'Y' && $scope.lot.EXPE_PRICE_FROM_JSON.HKD > $scope.save_data.bid_price){
				if($scope.locale == "ko"){
					alert("응찰금액은 낮은 추정가(HKD) 보다 커야 합니다.");
				} else{
					alert("The Maximum price should be higher than the low estimate price(HKD).");
				}
				return;
			}
		} 
		
		var $d = {"baseParms":{},
 				"actionList":[
 			    {"actionID":"addAutoBidReq", "actionType":"insert" , "tableName": "RESULT","parmsList":[$scope.save_data]}
 			 ]};
 		
  	   	common.callActionSet($d, function(data, status) {
   	   			if(data.tables["RESULT"]["rows"].length > 0){
   					if($scope.locale == 'ko'){
   						alert("응찰 완료 되었습니다.");
   					}else{
   						alert("The bid has been processed.");
   					}
   	   				
   					form.closeThisDialog();
   	   			}else{
   	   				if($scope.locale == 'ko'){
   	   					alert("실패하셨습니다.\n다시 시도해주세요.");
					}else{
						alert("Failed.\nPlease try again.");
					}
   	   			}
   	   		},
   			function(data, status, headers, config) {
	   	   		if($scope.locale == 'ko'){
	  					alert("실패하셨습니다.\n다시 시도해주세요.");
				}else{
					alert("Failed.\nPlease try again.");
				}
   		    }
   		); 
	}
	
	$scope.changeBidKind = function(){
		//var bid_kind = element(by.binding('save_data.bid_kind_cd'));
		if($scope.save_data.bid_kind_cd == 'phone'){
			$scope.save_data.bid_price = null;
		}
	}
	
	//호가 자동 변경 처리
	$scope.setBidAutoPriceAuto = function(flag){
		
		//자동 호가 범위 변수
		var tmp_grow_price = 0;
		var bidAutoPrice = parseInt($scope.bid_auto_price.replace(/,/gi, ""));
		
		if($scope.sale.SALE_KIND_CD == 'hongkong'){
			tmp_grow_price = $scope.returnOfflineHkGrowPrice(flag, bidAutoPrice);
		}else{
			tmp_grow_price = $scope.returnOfflineGrowPrice(flag, bidAutoPrice);
		}
		
		console.log(tmp_grow_price);
		//현재 자동응찰 금액 과 호가폭 산정
		// up / down
		if(flag == 'up')		bidAutoPrice += tmp_grow_price;
		else if(flag == 'down')	bidAutoPrice -= tmp_grow_price;

		// 금액이 낮은 가격보다 작을 경우 
		if(bidAutoPrice < $scope.low_price) bidAutoPrice = $scope.low_price; 
		$scope.bid_auto_price = $filter("number")(bidAutoPrice, 0);
	}
	
	$scope.checkboxAll = function(){ 
		if($("#agreePop_checkbox_all").prop("checked")){
			$("input:checkbox[name=agreePop_checkbox]").prop("checked", true);
		}else{
			$("input:checkbox[name=agreePop_checkbox]").prop("checked", false);
		}
	}
	
	$scope.viewKorean = function(num) { 
  		var num = $scope.isValidString(num) ? num.replace(/,/gi, "") : "";
		var hanA = new Array("","일","이","삼","사","오","육","칠","팔","구","십"); 
		var danA = new Array("","십","백","천","","십","백","천","","십","백","천","","십","백","천"); 
		var result = ""; 
		
			for(i=0; i<num.length; i++) { 
				str = ""; 
				han = hanA[num.charAt(num.length-(i+1))]; 
				
				if(han != "") 
					str += han+danA[i]; 
				
				if(i == 4) str += "만"; 
				if(i == 8) str += "억"; 
				if(i == 12) str += "조"; 
				result = str + result; 
			} 
			
			if(result.indexOf('undefined') > -1) 
				result = ""; 
			else if(num == 0) 
				result = "영"; 
			else if(num != 0)
				result = result;
			
			//krw일때만 단위 표시
			if($scope.base_currency.toLowerCase() == 'krw')
				result += " 원";
		
		return result ; 
		
	}

	$scope.returnOfflineGrowPrice = function(flag, inputPrice){
		var tmp_grow_price = 0;
		if(flag == 'up'){
			if (inputPrice < 1000000){
				tmp_grow_price = 50000;
				//alert("호가- 100만미만");
			}else if (inputPrice >= 1000000 && inputPrice < 2000000){
				tmp_grow_price = 100000;
				//alert("호가- 200만미만");
			}else if (inputPrice >= 2000000 && inputPrice < 4000000){
				tmp_grow_price = 200000;
				//alert("호가- 400만미만");
			}else if (inputPrice >= 4000000 && inputPrice < 10000000){
				tmp_grow_price = 300000;
				//alert("호가- 1000만미만");
			}else if (inputPrice >= 10000000 && inputPrice < 20000000){
				tmp_grow_price = 500000;
				//alert("호가- 2000만미만");
			}else if (inputPrice >= 20000000 && inputPrice < 30000000){
				tmp_grow_price = 1000000;
				//alert("호가- 3000만미만");
			}else if (inputPrice >= 30000000 && inputPrice < 50000000){
				tmp_grow_price = 2000000;
				//alert("호가- 5000만미만");
			}else if (inputPrice >= 50000000 && inputPrice < 100000000){
				tmp_grow_price = 3000000;
				//alert("호가- 1억미만");
			}else if (inputPrice >= 100000000 && inputPrice < 200000000){
				tmp_grow_price = 5000000;
				//alert("호가- 2억미만");
			}else if (inputPrice >= 200000000 && inputPrice < 300000000){
				tmp_grow_price = 10000000;
				//alert("호가- 3억미만");
			}else if (inputPrice >= 300000000 && inputPrice < 500000000){
				tmp_grow_price = 20000000;
				//alert("호가- 5억미만");
			}else if (inputPrice >= 500000000 && inputPrice < 1000000000){
				tmp_grow_price = 30000000;
				//alert("호가- 10억미만");
			}else if (1000000000 <= inputPrice){
				tmp_grow_price = 50000000;
				//alert("호가- 10억이상");
			} else {
				tmp_grow_price = $scope.lot.GROW_PRICE;
				//alert("호가- 기본값 설정");
			}
		}else{
			if (inputPrice <= 1000000){
				tmp_grow_price = 50000;
				//alert("호가- 100만미만");
			} else if (inputPrice > 1000000 && inputPrice <= 2000000){
				tmp_grow_price = 100000;
				//alert("호가- 200만미만");
				if((inputPrice - tmp_grow_price) < 1000000){
					tmp_grow_price = 50000;
				}
			} else if (inputPrice > 2000000 && inputPrice <= 4000000){
				tmp_grow_price = 200000;
				//alert("호가- 400만미만");
				if((inputPrice - tmp_grow_price) < 2000000){
					tmp_grow_price = 100000;
				}
			} else if (inputPrice > 4000000 && inputPrice <= 10000000){
				tmp_grow_price = 300000;
				//alert("호가- 1000만미만");				
				if((inputPrice - tmp_grow_price) < 4000000){
					tmp_grow_price = 200000;
				}
			} else if (inputPrice > 10000000 && inputPrice <= 20000000){
				tmp_grow_price = 500000;
				//alert("호가- 2000만미만");				
				if((inputPrice - tmp_grow_price) < 10000000){
					tmp_grow_price = 300000;
				}
			} else if (inputPrice > 20000000 && inputPrice <= 30000000){
				tmp_grow_price = 1000000;
				//alert("호가- 3000만미만");alert("test");
				if((inputPrice - tmp_grow_price) < 20000000){
					tmp_grow_price = 500000;
				}
			} else if (inputPrice > 30000000 && inputPrice <= 50000000){
				tmp_grow_price = 2000000;
				//alert("호가- 5000만미만");
				if((inputPrice - tmp_grow_price) < 30000000){
					tmp_grow_price = 1000000;
				}
			} else if (inputPrice > 50000000 && inputPrice <= 100000000){
				tmp_grow_price = 3000000;
				//alert("호가- 1억미만");
				if((inputPrice - tmp_grow_price) < 50000000){
					tmp_grow_price = 2000000;
				}
			} else if (inputPrice > 100000000 && inputPrice <= 200000000){
				tmp_grow_price = 5000000;
				//alert("호가- 2억미만");
				if((inputPrice - tmp_grow_price) < 100000000){
					tmp_grow_price = 3000000;
				}
			} else if (inputPrice > 200000000 && inputPrice <= 300000000){
				tmp_grow_price = 10000000;
				//alert("호가- 3억미만");
				if((inputPrice - tmp_grow_price) < 200000000){
					tmp_grow_price = 5000000;
				}
			} else if (inputPrice > 300000000 && inputPrice <= 500000000){
				tmp_grow_price = 20000000;
				//alert("호가- 5억미만");
				if((inputPrice - tmp_grow_price) < 300000000){
					tmp_grow_price = 10000000;
				}
			} else if (inputPrice > 500000000 && inputPrice <= 1000000000){
				tmp_grow_price = 30000000;
				//alert("호가- 10억미만");	
				if((inputPrice - tmp_grow_price) < 500000000){
					tmp_grow_price = 20000000;
				}
			} else if (1000000000 < inputPrice){
				tmp_grow_price = 50000000;
				//alert("호가- 10억이상");
				if((inputPrice - tmp_grow_price) < 1000000000){
					tmp_grow_price = 30000000;		 
				}
			} else {
				tmp_grow_price = $scope.lot.GROW_PRICE;
				//alert("호가- 기본값 설정");
			}
		}
		return tmp_grow_price;
	}
	
	$scope.returnOfflineHkGrowPrice = function(flag, inputPrice){
		var tmp_grow_price = 0;
		if(flag == 'up'){
			if (inputPrice < 10000){
				tmp_grow_price = 500;
				//alert("호가- 1만미만");
			}else if (inputPrice >= 10000 && inputPrice < 20000){
				tmp_grow_price = 1000;
				//alert("호가- 2만미만");
			}else if (inputPrice >= 20000 && inputPrice < 50000){
				tmp_grow_price = 2000;
				//alert("호가- 5만미만");
			}else if (inputPrice >= 50000 && inputPrice < 100000){
				tmp_grow_price = 5000;
				//alert("호가- 10만미만");
			}else if (inputPrice >= 100000 && inputPrice < 200000){
				tmp_grow_price = 10000;
				//alert("호가- 20만미만");
			}else if (inputPrice >= 200000 && inputPrice < 500000){
				tmp_grow_price = 20000;
				//alert("호가- 50만미만");
			}else if (inputPrice >= 500000 && inputPrice < 1000000){
				tmp_grow_price = 30000;
				//alert("호가- 1백만미만");
			}else if (inputPrice >= 1000000 && inputPrice < 2000000){
				tmp_grow_price = 50000;
				//alert("호가- 2백만미만");
			}else if (inputPrice >= 2000000 && inputPrice < 5000000){
				tmp_grow_price = 100000;
				//alert("호가- 3백만미만");
			}else if (inputPrice >= 5000000 && inputPrice < 10000000){
				tmp_grow_price = 200000;
				//alert("호가- 5백만미만");
			}else if (10000000 <= inputPrice){
				tmp_grow_price = 500000;
				//alert("호가- 1천만이상");
			} else {
				tmp_grow_price = $scope.lot.GROW_PRICE;
				//alert("호가- 기본값 설정");
			}	
		}else{
			if (inputPrice <= 10000){
				tmp_grow_price = 500;
				//alert("호가- 1만미만");
			}else if (inputPrice > 10000 && inputPrice <= 20000){
				tmp_grow_price = 1000;
				//alert("호가- 2만미만");
				if((inputPrice - tmp_grow_price) < 10000){
					tmp_grow_price = 500;
				}
			}else if (inputPrice > 20000 && inputPrice <= 50000){
				tmp_grow_price = 2000;
				//alert("호가- 5만미만");
				if((inputPrice - tmp_grow_price) < 20000){
					tmp_grow_price = 1000;
				}
			}else if (inputPrice > 50000 && inputPrice <= 100000){
				tmp_grow_price = 5000;
				//alert("호가- 10만미만");
				if((inputPrice - tmp_grow_price) < 50000){
					tmp_grow_price = 2000;
				}
			}else if (inputPrice > 100000 && inputPrice <= 200000){
				tmp_grow_price = 10000;
				//alert("호가- 20만미만");
				if((inputPrice - tmp_grow_price) < 100000){
					tmp_grow_price = 5000;
				}
			}else if (inputPrice > 200000 && inputPrice <= 500000){
				tmp_grow_price = 20000;
				//alert("호가- 50만미만");
				if((inputPrice - tmp_grow_price) < 200000){
					tmp_grow_price = 10000;
				}
			}else if (inputPrice > 500000 && inputPrice <= 1000000){
				tmp_grow_price = 30000;
				//alert("호가- 1백만미만");
				if((inputPrice - tmp_grow_price) < 500000){
					tmp_grow_price = 20000;
				}
			}else if (inputPrice > 1000000 && inputPrice <= 2000000){
				tmp_grow_price = 50000;
				//alert("호가- 2백만미만");
				if((inputPrice - tmp_grow_price) < 1000000){
					tmp_grow_price = 30000;
				}
			}else if (inputPrice > 2000000 && inputPrice <= 5000000){
				tmp_grow_price = 100000;
				//alert("호가- 3백만미만");
				if((inputPrice - tmp_grow_price) < 2000000){
					tmp_grow_price = 50000;
				}
			}else if (inputPrice > 5000000 && inputPrice <= 10000000){
				tmp_grow_price = 200000;
				//alert("호가- 5백만미만");
				if((inputPrice - tmp_grow_price) < 5000000){
					tmp_grow_price = 100000;
				}
			}else if (10000000 < inputPrice){
				tmp_grow_price = 500000;
				//alert("호가- 1천만이상");
				if((inputPrice - tmp_grow_price) < 10000000){
					tmp_grow_price = 200000;
				}
			} else {
				tmp_grow_price = $scope.lot.GROW_PRICE;
				//alert("호가- 기본값 설정");
			}	
		}
		return tmp_grow_price;
	}
	
});

app.controller('saleCertCtl', function($scope, consts, common, $interval, input, locale, $filter) {
	$scope.sale = input.sale;
	$scope.parent = input.parent;
	$scope.sale_cert = $scope.parent.sale_cert;
	$scope.callBack = input.callBack;
	
	$scope.close = function(){
		if($scope.parent.refreshLots) $scope.parent.refreshLots();
		if($scope.parent.runLotsRefresh) $scope.parent.runLotsRefresh();
		$scope.parent.modal.close();
		
 		if(($scope.parent.sale_cert.CNT || 0) <= 0) setCookie('sale_cert_cancel', true); //브라우저가 닫히면 세션을 지운다.
 		else if($scope.callBack) $scope.callBack(input);
	}
	
	var $e = function(){
	   	$scope.is_processing = false;
	}
	
	var $s = function(data, status) {
		$scope.is_processing = false;
	};
	
	var finalRefresh = function(){
		$scope.is_processing = false;
	}
	
	$scope.hp1s = ["010", "011", "016", "017", "018", "019"];  	  	  	  	   	  	       		

	$scope.form_data = {"can_auth": false};
	$scope.form_data.auth_num = null;
	$scope.auth_req_btn_txt = "인증번호요청";
	$scope.checkHpAuth = {"valid" : false, "message":"", "check": ""};

	$scope.authNumRequest = function() {
		
//		$scope.chkAgree = $("input:checkbox[id='chkAgree']").is(":checked") == true;
		
//		console.log($scope.chkAgree);
		
		var checkboxLen = $("input:checkbox[name=agreeCert_checkbox]").length; //체크박스 전체 개수
		var checkedLen = $("input:checkbox[name=agreeCert_checkbox]:checked").length; //체크된 개수
		
		if(checkboxLen != checkedLen){
			alert($scope.locale == 'ko'? "약관에 모두 동의해주세요." : "Please agree to all the terms and conditions." );
			return;
		} else {
			if(($scope.form_data.hp2 == null || $scope.form_data.hp2 == '')){
				alert("휴대폰 번호를 입력해주세요");
				return;
			}  
			if(($scope.form_data.hp3 == null || $scope.form_data.hp3 == '')){
				alert("휴대폰 번호를 입력해주세요");
				return;
			}  
		}

		
    	$scope.form_data.can_auth = false;

    	$scope.form_data.auth_num = null;
		$interval.cancel($scope.timer_duration);

    	$scope.checkHpAuth.message = "";
		$scope.form_data.hp = $scope.form_data.hp1 + "-" + $scope.form_data.hp2 + "-" + $scope.form_data.hp3;

		$d = {"to_phone":$scope.form_data.hp};
		
		

		common.callAPI('/join/send_auth_num', $d, 
			function(data, status) {
				try {
			    	$scope.form_data.can_auth = true;
			    	
			    	$scope.auth_num_send_status = data.SEND_STATUS;
					$scope.auth_end_time = moment(new Date()).add(120, 'seconds');
					if($scope.auth_num_send_status){
						$scope.timer_duration = $interval($scope.setAuthDuration, 1000);
						console.log("======> set timer");
					}
					$scope.auth_req_btn_txt = "인증번호 재요청";
				}
				catch(err) {
					$scope.auth_num_send_status = false;
				}
	   		}
		);
	}
	
	$scope.checkboxAll = function(){ 
		if($("#agreeCert_checkbox_all").prop("checked")){
			$("input:checkbox[name=agreeCert_checkbox]").prop("checked", true);
		}else{
			$("input:checkbox[name=agreeCert_checkbox]").prop("checked", false);
		}
	}
	
	$scope.authNumConfirm = function() {
		
		if($scope.form_data.auth_num == null || $scope.form_data.auth_num == '') {
			$scope.checkHpAuth.message = "인증번호를 넣으세요.";
			return;
		}
		
		
		var is_same_hp = (($scope.sale_cert.HP || '').replace(/[^\d]/g, "") == $scope.form_data.hp.replace(/[^\d]/g, ""));
		$d = {"sale_no": $scope.sale.SALE_NO, "hp": $scope.form_data.hp, "done_cd": (is_same_hp ? "no_modify" : "un_modify"), "auth_num": $scope.form_data.auth_num};
		
		common.callAPI('/join/confirm_auth_num4sale', $d, 
			function(data, status) {
				if(data && data.resultCode == 0) {
					$scope.checkHpAuth.message ="인증에 성공 하였습니다.";
					$scope.checkHpAuth.check = "ok";
					
					$scope.parent.sale_cert.CNT = 1;

					if(!is_same_hp){
						if(confirm("고객정보의 핸드폰번호와 일치하지 않습니다.\n인증받은 핸드폰번호로 갱신하시겠습니까?")){
					 		$d = {"actionList":[
					 				{"actionID":"sale_cert_hp_mod", "actionType":"update" , "tableName": "CERT", "parmsList":[{"hp": $scope.form_data.hp, "sale_cert_no": data.tables.CERT.rows[0].sale_cert_no}]}
					 			 ]};
					 		
					 	   	common.callActionSet($d, function(){
					 	   		$scope.parent.sale_cert.HP = $scope.form_data.hp;
					 	   	}, null, $scope.close);
						}else{
							$scope.close();
						}
					}else{
						$scope.close();
					}
				}else {
					$scope.checkHpAuth.message ="인증에 실패 하였습니다. 다시 요청 하세요.";
					$scope.checkHpAuth.check = "";
				}
				$scope.checkHpAuth.valid = data;
	   		}
		, null, function() {
			$interval.cancel($scope.timer_duration);
			console.log("======> cancel timer");
			$scope.form_data.auth_num = null;
		});
	}
	
	$scope.getHpAuthMsg = function() {
		return $scope.checkHpAuth.message;
	}
	
	$scope.setAuthDuration = function() {
 		var f = 'm:s';
    	var s = moment($scope.auth_end_time).diff(moment(new Date()), 'seconds');
    	if(s > 0) {
    		$scope.checkHpAuth.message = "남은시간 : " + moment.duration(s, "seconds").format(f);
    	}
    	else if (s == 0) {
    		//$scope.duraionEnd();
    		$scope.form_data.can_auth = false;
    		$scope.checkHpAuth.message = "0";
    		$interval.cancel($scope.timer_duration);
    		console.log("======> cancel timer");
    		common.callAPI('/join/clear_auth_num', {}, function(){
    			$scope.checkHpAuth.message = "인증 시간이 초과되었습니다. 다시 요청 하세요.";
    		});
    	}
    }
});
