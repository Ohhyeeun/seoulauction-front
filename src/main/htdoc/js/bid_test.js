app.factory("bid", function ($interval, ngDialog) {
	var objs = {
		showBidPopup: function($input) {
			if(!$input.parent.is_login){
				document.location.href='/login';
				return;
			}

			$input.parent.cancelLotRefresh();
			$input.parent.modal = ngDialog.open({
				template: '/bid?sale_no=' + $input.sale.SALE_NO + '&lot_no=' + $input.lot.LOT_NO,
				controller: 'bidListCtl',
				showClose: false,
				closeByDocument: false,
				animationEndSupport: false,
				resolve: {input: function(){return $input;}}
			});
			
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
			alert("서면/전화 작품응찰신청은 정회원만 이용하실 수 있습니다.");
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
	$scope.low_price = $scope.bid_price = $scope.bid_auto_price = $filter("number")(($scope.lot.LAST_PRICE ? $scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE : $scope.lot.START_PRICE), 0);
	
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
			    {"actionID":"lot_list_refresh_test", "actionType":"select" , "tableName":"LOT", "parmsList":[{"lot_nos":[$scope.lot.LOT_NO]}]},
			    {"actionID":"last_auto_bid_req", "actionType":"select" , "tableName":"AUTO"},
			    {"actionID":"bid_list", "actionType":"select" , "tableName":"LIST", "parmsList":[{"limit":20}]} //, "parmsList":[{"last_bid_no":$scope.last_bid_no}]
 			 ]};
		
  	   	common.callActionSet($d, $s, $e, finalRefresh);
	}

	$scope.bidOnce = function(){
		if($scope.is_processing) return;

		if($scope.lot.IS_WIN == 'Y'){
			alert("최고가 응찰 중 입니다.");
			return;
		}
		
		if (!$scope.chkAgree){
			alert("응찰 동의 체크해야 응찰하실 수 있습니다.");
			return;
		}
		
		if($scope.lot.LAST_PRICE >= parseInt($scope.bid_price.replace(/,/gi, "")) ){
			alert("응찰가가 현재가 보다 커야 합니다.");
			return;
		}
		
		if($scope.auto_req_price > $scope.lot.LAST_PRICE){
			alert("자동 응찰 중에는 수동으로 응찰하실 수 없습니다.");
		}else{
			$scope.is_processing = true;
			$d = {"baseParms":{"sale_no":$scope.sale.SALE_NO, "lot_no":$scope.lot.LOT_NO},
	 				"actionList":[
				    {"actionID":"bid_once", "actionType":"insert" , "tableName":"BID", "parmsList":[{"bid_price":parseInt($scope.bid_price.replace(/,/gi, "")) }]}
				    , {"actionID":"lot_list_refresh_test", "actionType":"select" , "tableName":"LOT", "parmsList":[{"lot_nos":[$scope.lot.LOT_NO]}]}
				    , {"actionID":"bid_list", "actionType":"select" , "tableName":"LIST", "parmsList":[{"limit":20}]} //,  "parmsList":[{"last_bid_no":$scope.last_bid_no}]
	 		]};
	  	   	common.callActionSet($d, $s, $e);//, finalRefresh);
		}
	}

	$scope.bidAuto = function(){
		if($scope.is_processing) return;

		$d = {"baseParms":{"sale_no":$scope.sale.SALE_NO, "lot_no":$scope.lot.LOT_NO}, "actionList":[]};

		if ($scope.lot.MY_BID_AUTO_CNT < 1){
			if(confirm("자동응찰 중지하기 전까지의 응찰 및 낙찰 내역은 모두 기록되며 유효합니다.\n응찰 하시겠습니까?") == false){
				return
			}
		}
				
		if (!$scope.chkAgree){
			alert("응찰 동의 체크해야 응찰하실 수 있습니다.");
			return;
		}
		
		if($scope.auto_req_price > $scope.lot.LAST_PRICE){
			if(confirm('자동응찰 중지하기는 자동 응찰 취소가 아닙니다.\n비딩이 올라간 상태에서 정지됩니다.\n자동 응찰을 중지 하겠습니까?')){
				$scope.is_processing = true;
				var action = {"actionID":"bid_auto_cancel", "actionType":"update" , "tableName":"BID", "parmsList":[{"req_no":$scope.auto_req_no}]};
				$d.actionList.push(action);
			}
			else{
				return;
			}
		}
		else{
			
			if($scope.lot.LAST_PRICE >= parseInt($scope.bid_auto_price.replace(/,/gi, "")) ){
				alert("자동 응찰가가 현재가 보다 커야 합니다.");
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
		$d.actionList.push({"actionID":"lot_list_refresh_test", "actionType":"select" , "tableName":"LOT", "parmsList":[{"lot_nos":[$scope.lot.LOT_NO]}]});
		$d.actionList.push({"actionID":"bid_list", "actionType":"select" , "tableName":"LIST", "parmsList":[{"limit":20}]}); //, "parmsList":[{"last_bid_no":$scope.last_bid_no}]}
  	   	common.callActionSet($d, $s, $e);//, finalRefresh);//, finalRefresh);

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
		
		$scope.low_price = ($scope.lot.LAST_PRICE ? $scope.lot.LAST_PRICE + $scope.lot.GROW_PRICE : $scope.lot.START_PRICE);
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

	$scope.setBidAutoPrice = function(flag) {
		var p = parseInt($scope.bid_auto_price.replace(/,/gi, ""));
		 
		if(flag == 'up')		p += $scope.lot.GROW_PRICE;
		else if(flag == 'down')	p -= $scope.lot.GROW_PRICE;
		
		if(p < $scope.low_price) p = $scope.low_price; 
		$scope.bid_auto_price = $filter("number")(p, 0);
	};

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

app.controller('bidRequestCtl', function($scope, consts, common, $interval, input) {
	$scope.sale = input.sale;
	$scope.lot =  input.lot;
	$scope.parent = input.parent;
	
	$scope.custInfo = input.parent.custInfo;
	
	$scope.base_currency = $scope.sale.CURR_CD;
	
	$scope.loadBidRequest = function(){
		/*$d = {"baseParms":{"sale_no":$scope.sale.SALE_NO, "lot_no":$scope.lot.LOT_NO, "last_bid_no":$scope.last_bid_no},
 				"actionList":[
 			    {"actionID":"bid_list", "actionType":"select" , "tableName": "LIST"}
 			 ]};

  	   	var $s = function(data, status) { $scope.bidList = data["tables"]["LIST"]["rows"]; };
  		
  	   	common.callActionSet($d, $s);*/
	}
	
	$scope.chkConfirm = false;
	$scope.chkAgree = false;
	$scope.save_data = {};
	$scope.save_data.sale_no = $scope.sale.SALE_NO;
	$scope.save_data.lot_no = $scope.lot.LOT_NO;
	$scope.save_data.bid_kind_cd = "phone";
	$scope.save_data.bid_price = null;

	$scope.save_data.hp = $scope.custInfo.HP;
	$scope.save_data.email = $scope.custInfo.EMAIL;
	
	$scope.saveBidRequest = function(form){
		if(!$scope.chkConfirm){
			alert("상태확인 후 동의 바랍니다.");
			return;
		}
		if(!$scope.chkAgree){
			alert("약관 확인 후 동의 바랍니다.");
			return;
		}
		
		if(!confirm("응찰하시겠습니까?")) return;
		
		if($scope.save_data.bid_price){
			$scope.save_data.bid_price = parseInt($scope.save_data.bid_price.replace(/,/gi, ""));
		}

		if($scope.save_data.bid_kind_cd == 'paper_online' && $scope.lot.EXPE_PRICE_INQ_YN != 'Y' && $scope.lot.EXPE_PRICE_FROM_JSON.KRW > $scope.save_data.bid_price){
			alert("응찰금액은 낮은 추정가 보다 커야 합니다.");
			return;
		}
		
		var $d = {"baseParms":{},
 				"actionList":[
 			    {"actionID":"addAutoBidReq", "actionType":"insert" , "tableName": "RESULT","parmsList":[$scope.save_data]}
 			 ]};
  		
  	   	common.callActionSet($d, function(data, status) {
   	   			if(data.tables["RESULT"]["rows"].length > 0){
   					alert("응찰 완료 되었습니다.");
					
   					form.closeThisDialog();
   	   			}else{
   					alert("실패하셨습니다.\n다시 시도해주세요.");
   	   			}
   	   		},
   			function(data, status, headers, config) {
				alert("실패하셨습니다.\n다시 시도해주세요.");
   		    }
   		);
	}
	
	$scope.changeBidKind = function(){
		//var bid_kind = element(by.binding('save_data.bid_kind_cd'));
		if($scope.save_data.bid_kind_cd != 'paper_online'){
			$scope.save_data.bid_price = null;
		}
	}
});
