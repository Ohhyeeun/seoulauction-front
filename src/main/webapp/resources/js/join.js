function selectOldAddr() {
	$('.tab01').addClass('sele');
	$('.tab02').removeClass('sele');
	$('#tab_cont01').addClass('sele');
	$('#tab_cont02').removeClass('sele');
}

function selectNewAddr() {
	$('.tab01').removeClass('sele');
	$('.tab02').addClass('sele');
	$('#tab_cont01').removeClass('sele');
	$('#tab_cont02').addClass('sele');
}

app.service("joinService", function ($rootScope, common, ngDialog, locale, $interval, $sce, $compile) {
	this.setScope = function($scope) {
		$scope.join_step = "done"; // done/basic;
		$scope.v_passwd = false;	// 비밀번호 확인 및 검증 여부
		$scope.v_comp_no = false;	// 사업자 등록번호 중복 확인 및 검증 여부

		$scope.form_data.nation_cd = $scope.locale == "ko" ? "KR" : null;
		$scope.param_addInfoList = [];
		$scope.push_ways = [];
		$scope.interest_areas = [];
		$scope.interest_artists = [];
		
		$scope.push_way_cds = {};
		$scope.interest_areas_cds = {};
		
		
		$scope.comp_documents = {};
		$scope.styleValid = {'color': 'blue', 'font-weight': 'bold'};
		$scope.styleInvalid = {'color': 'red', 'font-weight': 'bold'};
		$scope.styleInvalidInput = {'background-color' : '#ffdddd'};
		$scope.checkDupId = {"valid" : false, "message":"", "check": "" };
		$scope.checkHp = {"valid" : false, "message":"", "check": "" };
		$scope.checkDupEmail = {"valid" : false, "message":"", "check": "" };
		$scope.checkConfirmPwd = {"valid" : false, "message":"", "check": "" };
		$scope.checkConfirmBorn = {"valid" : false, "message":"", "check": ""};
		$scope.checkDupCompNo = {"valid" : false, "message":"", "check": "" };
		$scope.checkValidCompNo = {"valid" : false, "message":"", "check": "" };
		$scope.form_data.auth_num = null;
		$scope.auth_req_btn_txt = "인증번호요청";
		$scope.checkHpAuth = {"valid" : false, "message":"", "check": ""};
		$scope.validChekForm = false;
		$scope.fore_req_bid = false;
		$scope.isDisable = true;
		
		$scope.getValidInput = function(validInput) {
			if($scope.validChekForm && !validInput) {
				return $scope.styleInvalidInput;
			}else {
				return {};
			}
		}		
		$scope.isPerson = function() {
			return $scope.form_data.cust_kind_cd == 'person';
		}
		
		$scope.changeDomain = function(email_select){
			if(email_select == 'userinput'){
				$scope.form_data.email2 = '';
				$scope.isDisable = false;
			}else{
				$scope.form_data.email2 = email_select;
				$scope.isDisable = true;
			}
		}
		
		$scope.init = function() {
	 		$d = {"actionList":[
	 				{"actionID":"code_list", "actionType":"select" , "tableName": "CODES", "parmsList":[{"grp_ids":["push_way", "interest_area", "nation"]}]}
	 			 ]};	 		
	 	   	common.callActionSet($d,
	 	   		function(data, status) {
	 	 	    	$scope.codeList = data["tables"]["CODES"]["rows"];
	 	   		}
	 	   	);
		}	 		
	 	$scope.tel1s = ["02", "031", "032", "033", "041", "042", "051", "052", "053", "054", "055", "061", "062", "063", "064", "0502", "0505", "0506", "070"];  	  	  	  	   	  	       		
		$scope.hp1s = ["010", "011", "016", "017", "018", "019"];  	  	  	  	   	  	       		
		$scope.emails = ["naver.com", "nate.com", "gmail.com", "daum.net", "hanmail.net", "hotmail.com"];  	  	  	  	   	  	       		


		// 아이디 중복확인
		$scope.initValidIdCheck = function() {
			console.log("=======>> initValidIdCheck ");
			$scope.checkDupId.valid=false;
			$scope.checkDupId.message='';
			$scope.checkDupId.check='';
		}		
		$scope.checkExistId = function () {
			if(!$scope.joinForm.login_id.$valid) {
	        	common.setFocus("login_id");
				return;
			}			
			var $v_d = {"actionList":[{"actionID":"join_used_attr", "actionType":"select" , "tableName": "CUST", "parmsList":[{"login_id":$scope.form_data.login_id}]}]};
	  	   	common.callActionSet($v_d, 
	  	   		function(data, status) {
					if(data.tables["CUST"]["rows"].length > 0) {
						$scope.checkDupId.valid = false;
						$scope.checkDupId.check = "";
						if($scope.locale == 'ko') {
							$scope.checkDupId.message = "이미 사용중인 ID 입니다.";
						} else {
							$scope.checkDupId.message = "This ID is already in use.";
						}
					}else {
						$scope.checkDupId.valid = true;


						$scope.checkDupId.check = "ok";
						if($scope.locale == 'ko') {
							$scope.checkDupId.message = "사용 가능한 ID 입니다.";
						} else {
							$scope.checkDupId.message = "ID available.";
						}
					}
	   	  	   	}
	  	   	);
		}

		$scope.initValidPasswdCheck = function() {
			$scope.checkConfirmPwd.valid = false;
			$scope.checkConfirmPwd.message = "";
			$scope.checkConfirmPwd.check = "";			
			if(!$scope.joinForm.passwd.$valid || !$scope.isValidString($scope.form_data.passwd2)) return;
			if($scope.form_data.passwd == $scope.form_data.passwd2) {
				$scope.checkConfirmPwd.valid = true;
				if($scope.locale =='ko') {
					$scope.checkConfirmPwd.message = "비밀번호가 일치합니다.";
				}else {
					$scope.checkConfirmPwd.message = "Your passwords did match.";
				}
				$scope.checkConfirmPwd.check = "ok";
			}
			else {
				$scope.checkConfirmPwd.valid = false;
				if($scope.locale == 'ko') {
					$scope.checkConfirmPwd.message = "비밀번호가 일치하지 않습니다.";
				}else {
					$scope.checkConfirmPwd.message = "Your passwords did not match. Please try again.";
				}
				$scope.checkConfirmPwd.check = "";
			}
		}
		// YBK.생년월일 체크 함수////////////////////////////////////////////////////////////////////////////////////
		$scope.initValidBornCheck = function() {
			$scope.checkConfirmBorn.valid = false;
			$scope.checkConfirmBorn.message = "";
			$scope.checkConfirmBorn.check = "";
			if(!$scope.joinForm.born_dt.$valid) return;
		}
		
		$scope.checkNumber = function() {
			var objEv = event.srcElement;
			var numPattern = /([^0-9])/;
			var numPattern = objEv.value.match(numPattern);
			if(numPattern != null) {
				alert("숫자만 입력하세요");
				objEv.value = "";
				objEv.focus();
				return false;
			}
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////////
		$scope.initValidCompNoCheck = function(){
			$scope.checkDupCompNo.valid = false;
			$scope.checkDupCompNo.message = "";
			$scope.checkDupCompNo.check = "";
			$scope.checkValidCompNo.check = "";
			$scope.checkValidCompNo.message = "";
			$scope.checkValidCompNo.valid = false;
			if($scope.checkCompNo($scope.form_data.comp_no)){
				$scope.checkValidCompNo.check = "ok";
				$scope.checkValidCompNo.message = "";
				$scope.checkValidCompNo.valid = true;
			}
			else{
				$scope.checkValidCompNo.check = "";
				$scope.checkValidCompNo.message = "";
				$scope.checkValidCompNo.valid = false;
			}
		}
		$scope.checkExistCompNo = function () {
			if(!$scope.joinForm.comp_no.$valid || !$scope.checkValidCompNo.valid){
				$scope.initValidCompNoCheck();
				common.setFocus("comp_no");
				return;
			}		
			var $v_d = {"actionList":[{"actionID":"join_used_attr", "actionType":"select" , "tableName": "CUST", "parmsList":[{"comp_no":$scope.form_data.comp_no}]}]};
	  	   	common.callActionSet($v_d, 
	 	   		function(data, status) {
	 	   			if(data.tables["CUST"]["rows"].length > 0) {
		 	   			$scope.checkDupCompNo.valid = false;
		 				$scope.checkDupCompNo.message = "이미 사용중인 사업자 등록번호 입니다.";
		 				$scope.checkDupCompNo.check = "";
	 	   			}else {
		 	   			$scope.checkDupCompNo.valid = true;
		 				$scope.checkDupCompNo.message = "사용 가능한 사업자 등록번호 입니다.";
		 				$scope.checkDupCompNo.check = "ok";
	 	   			}
	 	   		}
	 	   	);
		}

		$scope.checkExistMobile = function (isPerson) {
			var cust_kind = isPerson? 'person' : 'company';
			if(locale == 'ko' && (!$scope.joinForm.hp1.$valid || !$scope.joinForm.hp2.$valid || !$scope.joinForm.hp3.$valid)) {
				common.setFocus("hp1");
				return;
			}else if(locale == 'en' && !$scope.joinForm.hp.$valid) {
				common.setFocus("hp");
				return;
			}			
			$scope.checkHp.valid = false;
			$scope.checkHp.check = "";
			
			if(locale == 'ko') {
				$scope.form_data.hp =
		        	($scope.isValidString($scope.form_data.hp1) ? $scope.form_data.hp1 : "") 
			    	+ ($scope.isValidString($scope.form_data.hp2) ? "-" + $scope.form_data.hp2 : "")
			    	+ ($scope.isValidString($scope.form_data.hp3) ? "-" + $scope.form_data.hp3 : "");
			}
			
			var $v_d = {"actionList":[{"actionID":"join_used_attr", "actionType":"select" , "tableName": "CUST", "parmsList":[{"hp":$scope.form_data.hp, "cust_kind_cd":cust_kind }]}]};
	  	   	common.callActionSet($v_d, 
	 	   		function(data, status) {
	 	   			if(data.tables["CUST"]["rows"].length > 0) {
						$scope.checkHp.message = "사용중인 휴대폰 번호 입니다.";
						$scope.checkHp.check = "";
						$scope.checkHp.valid = false;
					}else {
						$scope.checkHp.message = "사용 가능한 휴대폰 번호 입니다.";
						$scope.checkHp.check = "ok";
						$scope.checkHp.valid = true;
	 	   			}
	 	   		}
	 	   	);
		}
		
		$scope.checkExistEmail = function () {
			if(!$scope.joinForm.email1.$valid || !$scope.joinForm.email2.$valid) {
	        	common.setFocus("email1");
				return;
			}			
			$scope.form_data.email = 
	        	($scope.isValidString($scope.form_data.email1) ? $scope.form_data.email1 : "") 
	        	+ ($scope.isValidString($scope.form_data.email2) ? "@" + $scope.form_data.email2 : "");
			
			var $v_d = {"actionList":[{"actionID":"join_used_attr", "actionType":"select" , "tableName": "CUST", "parmsList":[{"email":$scope.form_data.email}]}]};

	  	   	common.callActionSet($v_d, 
	  	   		function(data, status) {
					if(data.tables["CUST"]["rows"].length > 0) {						
						$scope.checkDupEmail.valid = false;
						$scope.checkDupEmail.check = "";
						
						if($scope.locale == 'ko') {
							$scope.checkDupEmail.message = "이미 사용중인 EMAIL 입니다.";
						}else {
							$scope.checkDupEmail.message = "The email you entered is already in use.";
						}
					}else {
						$scope.checkDupEmail.valid = true;
						$scope.checkDupEmail.check = "ok";

						if($scope.locale == 'ko') {
							$scope.checkDupEmail.message = "사용 가능한 EMAIL 입니다.";
						}else {
							$scope.checkDupEmail.message = "The email you entered is available.";
						}
					}
	   	  	   	}
	  	   	);
		}
		$scope.nextStep = function () {
			if($scope.is_processing) return;
			$scope.is_processing = true;
			$scope.validChekForm = true;
			
			if($scope.join_step == "basic" && $scope.validationBasic()) {
				$scope.join_step = "done";
				$scope.save();
				$(".step_style01 li").removeClass("sele");
				$(".step_style01 #step_li03").addClass("sele");
			}else if($scope.join_step == "done") {
				
			}/*else if($scope.join_step == "compDocument") {
				$scope.save();
			}*/else {
				$scope.join_step = "basic";
			}
			$scope.is_processing = false;
		}
		$scope.backStep = function () {
			if($scope.is_processing) return;
			$scope.is_processing = true;
			
			if($scope.join_step == "addInfo") {
				$scope.join_step = "basic";
			} /*else if($scope.join_step == "compDocument") {
				$scope.join_step == "addInfo";
			}*/
			$scope.is_processing = false;
		};
		$scope.setParamList = function(list, paramName) {
	    	var result = [];
	    	for(i in list){
	        	var map = {};
	    		map[paramName] = list[i]; 
	    		result.push(map);
	    	}
	    	return result;
	    }
		$scope.validationBasic = function () {
			// 회원가입 양식의 필수 입력사항들 입력 여부 체크해야함

			var chkList = "";
			var chk = true;

			if ($scope.join_step == "basic"){
				if(!$scope.joinForm.login_id.$valid || !$scope.joinForm.checkId.$valid){
					chkList = "ID, ";
					chk = false;
				}
				if(!$scope.joinForm.passwd.$valid || !$scope.joinForm.checkPasswd.$valid){
					if(locale == 'ko') chkList = chkList+ '비밀번호, ';
					if(locale != 'ko') chkList = chkList+ 'Password, ';
					chk = false;
				}
				if(!$scope.joinForm.cust_name.$valid){
					if(locale == 'ko') chkList = chkList+ '이름, ';
					if(locale != 'ko') chkList = chkList+ 'Name, ';
					chk = false;
				}
				if(!$scope.joinForm.checkDupCompNo.$valid && !$scope.isPerson()) {
					chkList = chkList+ '사업자등록번호, ';
					chk = false;
				}
				/* IOS앱 등록으로 인해 일시적으로 주석처리
				 * if(!$scope.joinForm.born_dt.$valid && $scope.isPerson()){
					if(locale == 'ko') chkList = chkList+ '생년월일, ';
					if(locale != 'ko') chkList = chkList+ 'Date of birth, ';
					chk = false;
				}*/
				if(locale == 'ko' && (!$scope.joinForm.hp1.$valid || !$scope.joinForm.hp2.$valid || !$scope.joinForm.hp3.$valid || !$scope.checkHpAuth.valid)) {
					chkList = chkList+ '휴대폰번호 및 중복확인, ';
					chk = false;
				}
				/*if(locale == 'en' && !$scope.joinForm.hp.$valid) {
					chkList = chkList+ 'Mobile Number, ';
					chk = false;				
				}*/
				if(!$scope.joinForm.email1.$valid || !$scope.joinForm.email2.$valid) {
					if(locale == 'ko') chkList = chkList+ '이메일, ';
					if(locale != 'ko') chkList = chkList+ 'E-mail, ';
					chk = false;
				}	
				if(locale == 'en' && !$scope.joinForm.nation_cd.$valid) {
					chkList = chkList+ 'Country, ';
					chk = false;
				}
				if(!$scope.joinForm.addr.$valid) {
					if(locale == 'ko') chkList = chkList+ '주소';
					if(locale != 'ko') chkList = chkList+ 'Address';
					chk = false;
				}
			}

			if(chk == false){
				if(locale == 'ko') alert("아래 사항을 확인해주세요.\n"+chkList);
				if(locale != 'ko') alert("Please check below.\n"+chkList);
				return false;
			}
			/*
			if(!$scope.joinForm.$valid) {
				alert("필수 항목을 반드시 입력해 주세요."+chkList);
				return false;

			}
			*/			
	   		return true;
		}
		$scope.characterCheck = function(obj) {
			  var regExp = /[@ ]/gim; //@, 공백

			  if( regExp.test(obj) ){
//			     console.log("특수문자는 입력하실수 없습니다. : " + obj.value);
				 return obj.replace(regExp, ''); // 입력한 특수문자 한자리 지움
			  }else{
//				  console.log("입력한 값 : " + obj.value);
				  return obj;
			  }
		}
		
		$scope.setFormData= function() {
			if(locale == 'ko') {
				$scope.form_data.hp = 
		        	($scope.isValidString($scope.form_data.hp1) ? $scope.form_data.hp1 : "") 
			    	+ ($scope.isValidString($scope.form_data.hp2) ? "-" + $scope.form_data.hp2 : "")
			    	+ ($scope.isValidString($scope.form_data.hp3) ? "-" + $scope.form_data.hp3 : "");

		        $scope.form_data.tel = 
		        	($scope.isValidString($scope.form_data.tel1) ? $scope.form_data.tel1 : "") 
			    	+ ($scope.isValidString($scope.form_data.tel2) ? "-" + $scope.form_data.tel2 : "")
			    	+ ($scope.isValidString($scope.form_data.tel3) ? "-" + $scope.form_data.tel3 : "");
		
			    $scope.form_data.fax = 
		        	($scope.isValidString($scope.form_data.fax1) ? $scope.form_data.fax1 : "") 
			    	+ ($scope.isValidString($scope.form_data.fax2) ? "-" + $scope.form_data.fax2 : "")
			    	+ ($scope.isValidString($scope.form_data.fax3) ? "-" + $scope.form_data.fax3 : "");
				
		        $scope.form_data.zipno = 
//		        	($scope.isValidString($scope.form_data.zipno1) ? $scope.form_data.zipno1 : "") 
//		        	+ ($scope.isValidString($scope.form_data.zipno2)? "-" + $scope.form_data.zipno2 : "");
		        	($scope.isValidString($scope.form_data.zipno) ? $scope.form_data.zipno : "")
		        	
		        $scope.form_data.deli_zipno = 
//		        	($scope.isValidString($scope.form_data.deli_zipno1) ? $scope.form_data.deli_zipno1 : "") 
//		        	+ ($scope.isValidString($scope.form_data.deli_zipno2) ? "-" + $scope.form_data.deli_zipno2 : "");
		        	($scope.isValidString($scope.form_data.deli_zipno) ? $scope.form_data.deli_zipno : "")		
			}
	        $scope.form_data.email = 
	        	($scope.isValidString($scope.form_data.email1) ? $scope.characterCheck($scope.form_data.email1) : "") 
	        	+ ($scope.isValidString($scope.form_data.email2) ? "@" + $scope.characterCheck($scope.form_data.email2) : "");
	               
	    	$scope.push_way_cds = $scope.setParamList($scope.push_ways, "push_way_cd");
	        $scope.interest_areas_cds = $scope.setParamList($scope.interest_areas, "inte_area_cd");
		},
		
		$scope.setFormAddData = function(){
			$scope.push_way_cds = $scope.setParamList($scope.push_ways, "push_way_cd");
	        $scope.interest_areas_cds = $scope.setParamList($scope.interest_areas, "inte_area_cd");
		}

		// 배송주소가 집주소와 동일한 경우 체크
		$scope.same_addr = {val:false};
		$scope.checkSameAddr = function () {
			if($scope.same_addr.val) {
				$scope.form_data.deli_zipno = $scope.form_data.zipno; 
				$scope.form_data.deli_addr_old_yn = $scope.form_data.addr_old_yn;
//				$scope.form_data.deli_zipno1 = $scope.form_data.zipno1;
//				$scope.form_data.deli_zipno2 = $scope.form_data.zipno2;
				$scope.form_data.deli_addr = $scope.form_data.addr;
				$scope.form_data.deli_addr_dtl = $scope.form_data.addr_dtl;
			}else {
				$scope.form_data.deli_zipno = null;
				$scope.form_data.deli_addr_old_yn = null;
//				$scope.form_data.deli_zipno1 = null;
//				$scope.form_data.deli_zipno2 = null;
				$scope.form_data.deli_addr = null;
				$scope.form_data.deli_addr_dtl = null;
			}
		}
		$scope.setHomeAddr = function(addr, form) {
			//$scope.modal.close();
			form.$parent.closeThisDialog();
//			$scope.form_data.zipno1 = addr.postcode1;
//			$scope.form_data.zipno2 = addr.postcode2;

//			if(addr.addrBase) {
//				$scope.form_data.addr_old_yn = 'N';
//				$scope.form_data.addr = addr.addrBase;
//			}else {
//				$scope.form_data.addr_old_yn = 'Y';
//				$scope.form_data.addr = addr.addrOld.split('     ')[0];
//			}
			$scope.form_data.zipno = addr.postcd;
			$scope.form_data.addr = addr.address;
			$scope.form_data.addr_old_yn = 'N';
			
			common.setFocus("addr_dtl");
		};
		
		$scope.setDeliAddr = function(addr, form) {
			//$scope.modal.close();
			form.$parent.closeThisDialog();
//			$scope.form_data.deli_zipno1 = addr.postcode1;
//			$scope.form_data.deli_zipno2 = addr.postcode2;			

//			if(addr.addrBase) {
//				$scope.form_data.deli_addr_old_yn = 'N';
//				$scope.form_data.deli_addr = addr.addrBase;
//			}else {
//				$scope.form_data.deli_addr_old_yn = 'Y';
//				$scope.form_data.deli_addr = addr.addrOld.split('     ')[0];
//			}
			
			$scope.form_data.deli_zipno = addr.postcd;
			$scope.form_data.deli_addr_old_yn = 'N';
			$scope.form_data.deli_addr = addr.address;
			
			common.setFocus("deli_addr_dtl");
		};
		
		$scope.setParamInfoList = function(infoType, list, paramName) {
	    	for(i in list){
	        	var map = {};
	    		map[paramName] = list[i]; 
	    		map["info_type"] = infoType; 
	    		$scope.param_addInfoList.push(map);
	    	}
	    }

		$scope.addInterestArtist = function(artists, popup) {
			popup.closeThisDialog();
			
			artists.forEach(function(a) {
				var exist = false;
				for(i in $scope.interest_artists) {
					if($scope.interest_artists[i].ARTIST_NO == a.ARTIST_NO) {
						exist = true;
						break;
					}
				}
				if(!exist) {
					$scope.interest_artists.push(a);
				}
	    	});
			
			$scope.bindArtistNamesHtml();
		};
		
		$scope.getInterestArtistNames = function(){
			var s = "";
		
			for(k in $scope.interest_artists) {
		    	if(s && s != ""){
		    		s += ", ";
		    	}
		    	//s = s + $scope.interest_artists[k]["ARTIST_NAME"];
		    	s += $scope.interest_artists[k].ARTIST_NAME_JSON[locale] + '<span ng-click="delInteArtist();">X</span>';
			}		
	    	return s;
	    };
	    
	    $scope.bindArtistNamesHtml = function(){
			var s = "";
			
			for(k in $scope.interest_artists) {
		    	s += '<span class="inteArtistName">'+ $scope.interest_artists[k].ARTIST_NAME_JSON[locale] 
		    				+ '<span ng-click="delInteArtist('+k+');" class="imgcloseBtn Favorite_ArtistCloseBtn"></span>, </span>';    
			}	
			
			if($scope.interest_artists.length > 0){
				$("#inteArtistNames").html($compile(angular.element(s))($scope));
			}else{
				$("#inteArtistNames").html("");
			}
			
		}
	    
	    $scope.delInteArtist= function(index){
	    	$scope.interest_artists.splice(index,1);
	    	$scope.bindArtistNamesHtml();
	    }
	    
	    $scope.changeHpValue = function() {
			$scope.checkHp.message = "";
			$scope.checkHpAuth.message = "";
			$scope.checkHp.valid=false;
			$scope.checkHpAuth.valid=false;
			$scope.checkHp.check = "";
			$scope.checkHpAuth.check = "";
		}
		
		$scope.authNumRequest = function() {
			$scope.form_data.auth_num = null;
			$interval.cancel($scope.timer_duration);
			$scope.checkHpAuth.message = "";
			$scope.form_data.hp = 
	        	($scope.isValidString($scope.form_data.hp1) ? $scope.form_data.hp1 : "") 
		    	+ ($scope.isValidString($scope.form_data.hp2) ? "-" + $scope.form_data.hp2 : "")
		    	+ ($scope.isValidString($scope.form_data.hp3) ? "-" + $scope.form_data.hp3 : "");
			
			$d = {"to_phone":$scope.form_data.hp};

			common.callAPI('/join/send_auth_num', $d, 
				function(data, status) {
					try {
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
		
		$scope.authNumConfirm = function() {
			if($scope.form_data.auth_num == null || $scope.form_data.auth_num == '') {
				$scope.checkHpAuth.message = "인증번호를 넣으세요.";
				return;
			}
			$d = {"auth_num":$scope.form_data.auth_num};
			common.callAPI('/join/confirm_auth_num', $d, 
				function(data, status) {
					if(data) {
						$scope.checkHpAuth.message ="인증에 성공 하였습니다.";
						$scope.checkHpAuth.check = "ok";
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
			if(!$scope.checkHp.valid){
				$interval.cancel($scope.timer_duration);
			}
	 		var f = 'm:s';
	    	var s = moment($scope.auth_end_time).diff(moment(new Date()), 'seconds');
	    	if(s > 0) {
	    		$scope.checkHpAuth.message = "남은시간 : " + moment.duration(s, "seconds").format(f);
	    	}
	    	else if (s == 0) {
	    		//$scope.duraionEnd();
	    		$scope.checkHpAuth.message = "0";
	    		$interval.cancel($scope.timer_duration);
	    		console.log("======> cancel timer");
	    		common.callAPI('/join/clear_auth_num', {}, function(){
	    			$scope.checkHpAuth.message = "인증 시간이 초과되었습니다. 다시 요청 하세요.";
	    		});
	    	}
	    }
		
		//사업자 등록번호 체크 함수
		$scope.checkCompNo = function (bizID) {
			// 사업자등록번호 체크
		    // bizID는 숫자만 10자리로 해서 문자열로 넘긴다.
			if(bizID == undefined || bizID == null || bizID == "") return false;
			var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
			var tmpBizID, i, chkSum = 0, c2, remander;
			bizID = "" + bizID.replace(/-/gi, '');

			for(i = 0; i <= 7; i++) {
				chkSum += checkID[i] * bizID.charAt(i);
			}
			c2 = "0" + (checkID[8] * bizID.charAt(8));
			c2 = c2.substring(c2.length - 2, c2.length);
			chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1));
			remander = (10 - (chkSum % 10)) % 10;

			if (Math.floor(bizID.charAt(9)) == remander) {
				return true; // OK!
			}
			return false;
		};
	};
});

app.factory("join", function (ngDialog) {
	var objs = {
		showAddressFinderPopup: function($input) {
			$input.parent.modal = ngDialog.open({
				template: '/addressFinder',
				controller: 'addressCtl',
				closeByDocument: false,
				showClose: false,
				animationEndSupport: false,
				resolve: {input: function(){return $input;}},
			    preCloseCallback: function(ng_scope) {
			    	$input.parent.modal = null;
			    	return true;
			    },
			});
		},
		showArtistFinderPopup: function($input) {
			$input.parent.modal = ngDialog.open({
				template: '/artistFinder',
				controller: 'artistCtl',
				closeByDocument: false,
				showClose: false,
				animationEndSupport: false,
				resolve: {input: function(){return $input;}},
			    preCloseCallback: function(ng_scope) {
			    	$input.parent.modal = null;
			    	return true;
			    }
			});
		}
	};	
	return objs;
});


app.controller('addressCtl', function($scope, consts, common, input) {
	$scope.returnFunction = input.return_function;

//	$scope.find_type = "road";
	
//	// 구주소 검색을 위한 Form Submit
//	$scope.findAddrOldForm = function () {
//		if(!$scope.find_word) {
//			alert("검색 내용을 입력하셔야 합니다.");
//			return;
//		}

//		var $s =function(data, status) {
//			$scope.addrListOld = data["tables"]["RESULT"]["rows"];
//   		};

//		common.callCustomAction('findAddr', [{"find_type":"dong", "find_word":$scope.find_word}], $s);
//	}

//	//  신주소 검색을 위한 Form Submit
//	$scope.findAddrNewForm = function () {
//		if(!$scope.find_word1 || !$scope.find_word2) {
//			alert("검색 내용을 모두 입력하셔야 합니다.");
//			return;
//		}

//		var $s =function(data, status) {
//			$scope.addrListNew = data["tables"]["RESULT"]["rows"];
//   		};
//
//		common.callCustomAction('findAddr', [{"find_type":$scope.find_type, "find_word":$scope.find_word1 + " " + $scope.find_word2}], $s);
//	}
//	
//	$scope.handleNewRadio = function() {
//		if($scope.find_type == "road"){
//			$("#find_word1").attr("placeholder", "도로명 입력");
//			$("#find_word2").attr("placeholder", "건물번호 입력");
//		}
//		else {
//			$("#find_word1").attr("placeholder", "동(읍/면) 입력");
//			$("#find_word2").attr("placeholder", "지번 입력");
//		}
	
	//  신주소 검색을 위한 Form Submit
	$scope.findAddrNewForm = function () {
		
		var $s = function(data, status) {
			$scope.addrListNew = data["tables"]["RESULT"]["rows"];
   		};

//		common.callCustomAction('findAddr', [{"find_type":$scope.find_type, "find_word":$scope.find_word1 + " " + $scope.find_word2}], $s);
		common.callCustomAction('findAddr', [{"find_type":$scope.find_type, "find_word":$scope.find_word1}], $s);
	}
});

app.controller('artistCtl', function($scope, consts, common, input) {
	$scope.returnFunction = input.return_function;
	$scope.checked_artists = [];
	
	$scope.findArtist = function () {
		if(!$scope.find_word) {
			alert("검색하실 작가 명을 입력하세요.");
			return;
		}

		var $s =function(data, status) {
			$scope.checked_artists = [];
			$scope.artistList = data.tables["ARTIST"]["rows"];
   		};

 		$d = {"actionList":[
 	 			{"actionID":"artist_find", "actionType":"select" , "tableName": "ARTIST", "parmsList":[{"find_word":$scope.find_word}]}
 	 		]};
 	   common.callActionSet($d, $s);
	}
});
