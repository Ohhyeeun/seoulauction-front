app.service("inquiryService", function ($rootScope, common, locale) {
	this.setScope = function($scope){
		$scope.hp1s = ["010", "011", "016", "017", "018", "019"];  	  	  	  	   	  	       		
		$scope.emails = ["naver.com", "nate.com", "gmail.com", "daum.net", "hanmail.net", "hotmail.com"];
		$scope.form_data = {};
		$scope.sell_data = {};
		$scope.init = function(){
			$scope.parmsList1 = [{"grp_ids":["bbs_inquiry_category"]}];
	 		$d = {"baseParms":{},
	 				"actionList":[
						{"actionID":"code_list", "actionType":"select" , "tableName": "CODE_LIST" ,"parmsList":$scope.parmsList1},
						{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
	 			 ]};

	 	   	common.callActionSet($d, function(data, status){
	 	   		$scope.inqCate = data["tables"]["CODE_LIST"]["rows"];
	 	   		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];

				if($scope.custInfo.EMAIL !== null) {
					$scope.form_data.email1 = $scope.custInfo.EMAIL.split("@")[0];
					$scope.form_data.email2 = $scope.custInfo.EMAIL.split("@")[1];
					$scope.email_select = $scope.form_data.email2;
				}
				if($scope.custInfo.HP !== null) {
					$scope.form_data.hp1 = $scope.custInfo.HP.split("-")[0];
					$scope.form_data.hp2 = $scope.custInfo.HP.split("-")[1];
					$scope.form_data.hp3 = $scope.custInfo.HP.split("-")[2];
				}
			});
		}
		
		$scope.changeCate1 = function(){
			if($scope.form_data.cate1 == "sell" || $scope.form_data.cate1 == "chineseart" ){
				$(".hide_row").show();
			}
			else{
				$(".hide_row").hide();
			}
			$scope.inqCate2 = [];
			for(i in $scope.inqCate){
				if($scope.inqCate[i].P_CD_ID == $scope.form_data.cate1){
					$scope.inqCate2.push($scope.inqCate[i]);
				}
			}
		}
		
		$scope.checkValidData = function(){
			if(!$scope.isValidString($scope.form_data.cate1)){
				if(locale=="ko"){
					alert("카테고리(대분류)를 선택하세요.");
				} else {
					alert("Select a category(Major category).");
				}
				return false;
			}
			
			if(($scope.form_data.cate1 == 'sell' || $scope.form_data.cate1 == 'payment' || $scope.form_data.cate1 == 'others' || $scope.form_data.cate1 == 'homepage') && !$scope.isValidString($scope.form_data.cate2) && $scope.form_data.cate2 == undefined){
				if(locale=="ko"){
					alert("카테고리(중분류)를 선택하세요.");
				} else {
					alert("Select a category(subdivision).");
				}
				return false;
			}
			
			if($scope.form_data.email_yn == 'Y' && !$scope.isValidString($scope.form_data.email)){
				if(locale=="ko"){
					alert("이메일 답변을 원하시면 이메일을 넣어주셔야 합니다.");
				} else {
					alert("If you want to reply to email, please put an email.");
				}
				return false;
			}
			
			if($scope.form_data.sms_yn == 'Y' && !$scope.isValidString($scope.form_data.hp)){
				if(locale=="ko"){
					alert("핸드폰 답변 알림을 원하시면 핸드폰 번호를 넣어주셔야 합니다.");
				} else {
					alert("If you want to be notified of cellphone answer, please put in your cell phone number.");
				}
				return false;
			}
			
			if(!$scope.isValidString($scope.form_data.title)){
				if(locale=="ko"){
					alert("제목을 넣어주세요.");
				} else {
					alert("Please put a title.");
				}
				return false;
			}

			if(!$scope.isValidString($scope.form_data.contents)){
				if(locale=="ko"){
					alert("내용을 넣어주세요.");
				} else {
					alert("Please put the contents.");
				}
				return false;
			}
			
			if(($scope.form_data.cate1 == 'sell' || $scope.form_data.cate1 == "chineseart") && !$scope.isValidString($scope.sell_data.artist_name)){
				if(locale=="ko"){
					alert("작가명을 넣어주세요");
				} else {
					alert("Please put the image of the work.");
				}
				return false;
			}

			if($scope.form_data.cate1 == 'sell' && !$scope.isValidString($scope.sell_data.work_size)){
				if(locale=="ko"){
					alert("작품 크기를 넣어주세요.");
				} else {
					alert("Please put the size of the artwork.");
				}
				return false;
			}
			
			if(($scope.form_data.cate1 == 'sell' || $scope.form_data.cate1 == "chineseart") && !$scope.isValidString($scope.sell_data.possession_details)){
				if(locale=="ko"){
					alert("소장 경위를 입력해주세요.");
				} else {
					alert("Please enter the reason of ownership.");
				}
				return false;
			}
			
			if(($scope.form_data.cate1 == 'sell' || $scope.form_data.cate1 == "chineseart") && !$scope.isValidString($scope.form_file_data.att_files_name)){
				if(locale=="ko"){
					alert("작품 이미지를 넣어주세요.");
				} else {
					alert("Please put the image of the work.");
				}
				return false;
			}

			return true;
			
			
			
			
		}
		
		$scope.email_yn = false;
		$scope.sms_yn = false;
		
		$scope.cancel = function(){
			window.history.back();
		}
		
		$scope.saveForm = function(){

			if(!$scope.isValidString($scope.form_data.cate1) && !$scope.isValidString($scope.form_data.cate2)){
				if(locale=="ko"){
					alert("카테고리를 선택하세요.");
				} else {
					alert("Select a category.");
				}
				return false;
			}
			
			$scope.form_data.cate_cd = $scope.isValidString($scope.form_data.cate2) ? $scope.form_data.cate2 : $scope.form_data.cate1;
			
			for(i in $scope.inqCate){
				if($scope.inqCate[i].CD_ID == $scope.form_data.cate_cd){
					$scope.form_data.emp_no = $scope.inqCate[i].CD_VAL;
				}
			}
			
			if($scope.email_yn){
				$scope.form_data.email_yn = 'Y';
			}
			else{
				$scope.form_data.email_yn = 'N';
			}

			if($scope.sms_yn){
				$scope.form_data.sms_yn = 'Y'; 
			}
			else{
				$scope.form_data.sms_yn = 'N';
			}

			$scope.form_data.email = 
	        	($scope.isValidString($scope.form_data.email1) ? $scope.form_data.email1 : "")
		    	+ ($scope.isValidString($scope.form_data.email2) ? "@" + $scope.form_data.email2 : "");
			$scope.form_data.email = $scope.isValidString($scope.form_data.email) ? $scope.form_data.email : null;
			
	        $scope.form_data.hp = 
	        	($scope.isValidString($scope.form_data.hp1) ? $scope.form_data.hp1 : "") 
		    	+ ($scope.isValidString($scope.form_data.hp2) ? "-" + $scope.form_data.hp2 : "")
		    	+ ($scope.isValidString($scope.form_data.hp3) ? "-" + $scope.form_data.hp3 : "");
	        $scope.form_data.hp = $scope.isValidString($scope.form_data.hp) ? $scope.form_data.hp : null;
	        
	        if($scope.form_data.cate1 == "sell" || $scope.form_data.cate1 == "chineseart"){
	        	
	        	$("#tmp_work_name").html($scope.sell_data.work_name);
	        	$("#tmp_artist_name").html($scope.sell_data.artist_name);
	        	$("#tmp_work_material").html($scope.sell_data.work_material);
	        	
	        	var category = "";
	        	if($scope.isValidString($scope.sell_data.work_category1)){
	        		category = $scope.sell_data.work_category1;
	        		if($scope.isValidString($scope.sell_data.work_category2)){
	        			category += " < " + $scope.sell_data.work_category2;
	        			if($scope.isValidString($scope.sell_data.work_category3)){
	        				category += " < " + $scope.sell_data.work_category3;
	        			}
	        		}
	        	}
	        	$("#tmp_work_category").html(category);
	        	$("#tmp_work_estate").html($scope.sell_data.work_estate);
	        	$("#tmp_hope_price").html($scope.sell_data.hope_price);
	        	$("#tmp_artist_desc").html($scope.sell_data.artist_desc);
	        	$("#tmp_work_desc").html($scope.sell_data.work_desc);
	        	$("#tmp_possession_details").html($scope.sell_data.possession_details);
	        	$("#tmp_work_size").html($scope.sell_data.work_size);
	        	
	        	$scope.form_data.contents = $scope.form_data.content + "\n\n" + $("#sell_form").html();
	        }
	        else{
	        	$scope.form_data.contents = $scope.form_data.content;
	        }
	        
	        if($scope.checkValidData()){
				console.log($scope.form_file_data.att_files);
				
				$d = {"baseParms":{},
		 				"actionList":[
		 		    	{"actionID":"addInquiryWrite", "actionType":"insert", "uidKey":"write_no", "tableName": "INQUIRY", "parmsList":[$scope.form_data]},
		 		    	{"actionID":"addInquiryWriteFile", "actionType":"insert", "tableName": "INQUIRY_FILE", "parmsList": $scope.form_file_data.att_files}
		 			]};


				common.callActionSet($d,
		   	   		function(data, status) {
		   	   			console.log("====>" + data);
		   	   			if(data.tables["INQUIRY"]["rows"].length > 0){
		   					if($scope.locale == 'ko'){
		   	   					alert("등록되었습니다.");
		   	   				} else {
		   	   					alert("Registered.");
		   	   				}
		   					document.location.href="/customer/inquiryList";
		   	   			}else{
		   	   				if($scope.locale == 'ko'){
		   	   					alert("실패하셨습니다.\n다시 시도해주세요.");
		   	   				} else {
		   	   					alert("You failed.\nPlease try again.");
		   	   				}
		   	   			}
		   	   		},
		   			function(data, status, headers, config) {
			   	   		if($scope.locale == 'ko'){
	   	   					alert("실패하셨습니다.\n다시 시도해주세요.");
	   	   				} else {
	   	   					alert("You failed.\nPlease try again.");
	   	   				}
		   		    }
		   		);
	        }
		}
		
		
		$scope.sell_categories1 = ["근현대", "고미술", "기타"];
		$scope.sell_categories1_1 = ["국내", "국외"];
		$scope.sell_categories1_1_1 = ["회화","조각","사진","멀티플","공예품","기타"];
		$scope.sell_categories1_2 = ["회화","서예","도자기-청자","도자기-백자","도자기-분청","목기","공예품","기타"];
		$scope.sell_categories1_3 = ["시계","보석/장신구","와인","서적","인형/장난감/모형","포스터","스포츠수집품","가구/디자인소품","부동산","자동차","근현대사자료","기타"];
		
		$scope.changeSellCate1 = function(){
			$("#work_category2").hide();
			$("#work_category3").hide();
			$scope.sell_categories2 = [];
			$scope.sell_categories3 = []; 	

			if($scope.sell_data.work_category1 == "근현대"){
				$scope.sell_categories2 = $scope.sell_categories1_1;
				$("#work_category2").show();
			}
			else if($scope.sell_data.work_category1 == "고미술"){
				$scope.sell_categories2 = $scope.sell_categories1_2;
				$("#work_category2").show();
			}
			else if($scope.sell_data.work_category1 == "기타"){
				$scope.sell_categories2 = $scope.sell_categories1_3;
				$("#work_category2").show();
			}
		}
		
		$scope.changeSellCate2 = function(){
			$("#work_category3").hide();
			$scope.sell_categories3 = []; 	

			if($scope.sell_data.work_category1 == "근현대"){
				$scope.sell_categories3 = $scope.sell_categories1_1_1; 	
				$("#work_category3").show();
			}
		}
		
		$scope.form_file_data = {};
		$scope.form_file_data.att_files = [];
		$scope.form_file_data.att_files_name = [];
		
		$scope.removeFile = function(index){

			var data = [{"file_name" : $scope.form_file_data.att_files[index].file_name,
				"file_path" : $scope.form_file_data.att_files[index].file_path}];
        	common.callCustomAction('remove_file', data, function(data, status){
        		if(data.tables["RESULT"]["rows"].length > 0 && data.tables["RESULT"]["rows"][0]){
					$scope.form_file_data.att_files.splice(index, 1);
					$scope.form_file_data.att_files_name.splice(index, 1);
   	   			}else{
   	   				if($scope.locale == 'ko'){
	   					alert("실패하셨습니다.\n다시 시도해주세요.");
	   				} else {
	   					alert("You failed.\nPlease try again.");
	   				}
   	   			}
        	},
        	function(data, status, headers, config) {
        		if($scope.locale == 'ko'){
   					alert("실패하셨습니다.\n다시 시도해주세요.");
   				} else {
   					alert("You failed.\nPlease try again.");
   				}
   		    });

		}

		//$scope.uploadFile = function(input){
		$scope.uploadFile = function(base64String, filename){
	        /*var fileReader = new FileReader();
	        fileReader.onload = function(event) {
	        	console.log(event.target.result);
	        	console.log(btoa(event.target.result));
	        	var data = [{"file_name" : input.files[0].name, "file" : btoa(event.target.result)}];
	        	common.callCustomAction('upload_file', data, function(data, status){
	        		console.log("====>");
	        		console.log(data.tables["RESULT"]);
	        		if(data.tables["RESULT"] != undefined && data.tables["RESULT"]["rows"].length > 0){
			            $scope.form_file_data.att_files.push(data.tables["RESULT"]["rows"][0]);
				        $scope.form_file_data.att_files_name.push(input.files[0].name);
	   	   			}else{
	   					alert("실패하셨습니다.\n다시 시도해주세요.");
	   	   			}
	        	},
	        	function(data, status, headers, config) {
					alert("실패하셨습니다.\n다시 시도해주세요.");
	   		    });
	        };
	        fileReader.readAsDataURL(input.files[0]);
	        $scope.$apply();*/
			
        	var data = [{"file_name" : filename, "file" : base64String}];
        	common.callCustomAction('upload_file', data, function(data, status){
        		console.log("====>");
        		console.log(data.tables["RESULT"]);
        		if(data.tables["RESULT"] != undefined && data.tables["RESULT"]["rows"].length > 0){
		            $scope.form_file_data.att_files.push(data.tables["RESULT"]["rows"][0]);
			        $scope.form_file_data.att_files_name.push(filename);
   	   			}else{
   	   				if($scope.locale == 'ko'){
	   					alert("실패하셨습니다.\n다시 시도해주세요.");
	   				} else {
	   					alert("You failed.\nPlease try again.");
	   				}
   	   			}
        	},
        	function(data, status, headers, config) {
        		if($scope.locale == 'ko'){
   					alert("실패하셨습니다.\n다시 시도해주세요.");
   				} else {
   					alert("You failed.\nPlease try again.");
   				}
   		    });
        	$scope.$apply();
		}	
	}
});
