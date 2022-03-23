<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>

<link href="/css/angular/ngDialog.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script src="/js/angular/checklist-model.js"></script>
<script type="text/javascript" src="/js/join.js?ver=20220322"></script>
<script type="text/javascript">

app.requires.push.apply(app.requires, ["checklist-model", "ngDialog"]);

app.controller("joinCtl", function($scope, consts, common, join, joinService, ngDialog, locale, is_login) {
	$scope.form_data = {};
	$scope.is_login = is_login;
	joinService.setScope($scope);

	$scope.init = function(){
 		$d = {"baseParms":{},
 				"actionList":[
				{"actionID":"code_list", "actionType":"select" , "tableName": "CODES", "parmsList":[{"grp_ids":["push_way", "interest_area" , "nation"]}]},
  				{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
  				{"actionID":"get_inte_artist_list_by_cust_no", "actionType":"select" , "tableName": "INTE_ARTIST_LIST" ,"parmsList":[]}
 			 ]};

 	   	common.callActionSet($d, function(data, status){
	 	    $scope.codeList = data["tables"]["CODES"]["rows"];
	 		var custInfo = data["tables"]["CUST_INFO"]["rows"][0];
	 		$scope.interest_artists = data["tables"]["INTE_ARTIST_LIST"]["rows"];
	 		
	 		$scope.form_data = convertKeysToCamelCase(custInfo);
	 		console.log("=====");
			console.log(custInfo);
	 		if($scope.form_data.local_kind_cd == 'korean'){
	 			if($scope.isValidString($scope.form_data.hp)){
			 		$scope.form_data.hp1 = $scope.form_data.hp.split("-")[0];
			 		$scope.form_data.hp2 = $scope.form_data.hp.split("-")[1];
			 		$scope.form_data.hp3 = $scope.form_data.hp.split("-")[2];
		 		}
		 		
		 		if($scope.isValidString($scope.form_data.tel)){
			 		$scope.form_data.tel1 = $scope.form_data.tel.split("-")[0];
			 		$scope.form_data.tel2 = $scope.form_data.tel.split("-")[1];
			 		$scope.form_data.tel3 = $scope.form_data.tel.split("-")[2];
		 		}
		 		
		 		if($scope.isValidString($scope.form_data.fax)){
			 		$scope.form_data.fax1 = $scope.form_data.fax.split("-")[0];
			 		$scope.form_data.fax2 = $scope.form_data.fax.split("-")[1];
			 		$scope.form_data.fax3 = $scope.form_data.fax.split("-")[2];
		 		}
		 		
		 		if($scope.isValidString($scope.form_data.zipno)){
			 		$scope.form_data.zipno1 = $scope.form_data.zipno.split("-")[0];
			 		$scope.form_data.zipno2 = $scope.form_data.zipno.split("-")[1];
		 		}

		 		if($scope.isValidString($scope.form_data.deli_zipno)){
			 		$scope.form_data.deli_zipno1 = $scope.form_data.deli_zipno.split("-")[0];
			 		$scope.form_data.deli_zipno2 = $scope.form_data.deli_zipno.split("-")[1];
		 		}
	 		}
	 		

	 		if($scope.isValidString($scope.form_data.email)){
		 		$scope.form_data.email1 = $scope.form_data.email.split("@")[0];
		 		$scope.form_data.email2 = $scope.form_data.email.split("@")[1];
	 		}

	 		$scope.passwdPattern = "/^{4,}$/";
	 		$scope.form_data.re_passwd = $scope.form_data.passwd2 = $scope.form_data.passwd;

	 		if($scope.isPerson() && $scope.isValidString($scope.form_data.born_dt)){
		 		$scope.form_data.born_dt = $scope.form_data.born_dt.replace(/-/gi, "");
	 		}
			$scope.push_ways = $scope.isValidString($scope.form_data.push_way_json) ? $scope.form_data.push_way_json : [];
			$scope.interest_areas = $scope.isValidString($scope.form_data.inte_area_json) ? $scope.form_data.inte_area_json : [];
			$scope.bindArtistNamesHtml();
			//$scope.form_data.re_passwd = $scope.form_data.passwd2 = $scope.form_data.passwd = data.passwd;
			
			$scope.checkDupId.valid = true;
	 		$scope.checkDupId.check = "ok";
	 		$scope.checkConfirmPwd.check = "ok";
	 		$scope.checkDupCompNo.valid = true;
	 		$scope.checkDupCompNo.check = "ok"
		 	$scope.validCompNo = "ok";
	 		$scope.checkHp.check = "ok";
	 		$scope.checkHpAuth.check = "ok";
	 		$scope.checkHpAuth.valid = true;
			// 신세계 ID 여부
			$scope.isSSG = /(_SSG_\d+)$/i.test(custInfo.login_id);
 		}, null);
	}
	
    
	$scope.save = function(){
		
		
		var chbReceiveChK = $("#chbReceiveChk input:checkbox[name=is_check]:checked").length;
		
		if ( chbReceiveChK > 0 ) {
			$scope.form_data.marketing_chk = "Y";
		} else {
			$scope.form_data.marketing_chk = "N";
		};
		
		if(!$scope.validationBasic($scope)) return;
        $scope.setFormData($scope);
        
        $scope.param_addInfoList = [];
        $scope.setParamInfoList("pushway", $scope.push_ways, "push_way_cd");
	    $scope.setParamInfoList("area", $scope.interest_areas, "inte_area_cd");
	    $scope.setParamInfoList("artist", $scope.interest_artists, "artist");

		$d = {"baseParms":{},
 				"actionList":[
 		    	{"actionID":"modify_cust_info", "actionType":"update", "tableName": "CUST", "parmsList":[$scope.form_data]},
//  		    	{"actionID":"delete_add_info", "actionType":"delete", "tableName":"DEL_ADD_INFO", "parmsList": [{}]},
		    	{"actionID":"insert_addInfo", "actionType":"insert", "tableName":"INS_ADD_INFO", "parmsList": $scope.param_addInfoList},
//  		    	{"actionID":"add_join_push_ways", "actionType":"insert", "tableName": "CUST_PUSH_WAY", "parmsList": $scope.push_way_cds},
//  		    	{"actionID":"add_join_inte_area", "actionType":"insert", "tableName": "CUST_INTE_AREA", "parmsList": $scope.interest_areas_cds},
//  		    	{"actionID":"add_join_inte_artist", "actionType":"insert", "tableName": "CUST_INTE_ARTIST", "parmsList": $scope.interest_artists}
 			]};

		console.log($d);
   	   	
		common.callActionSet($d,
   	   		function(data, status) {
   	   			console.log("====>" + data);
   	   			if(data.tables["CUST"]["rows"].length > 0){
   					if(locale == 'ko'){
	   					alert("정보가 수정되었습니다.");
	   				} else {
	   					alert("It is changed.");
	   				}
   					document.location.href="/customer/myPage";
   	   			}else{
   					if(locale == 'ko'){
	   					alert("실패하셨습니다.\n다시 시도해주세요.");
	   				} else {
	   					alert("You failed.\nPlease try again.");
	   				}
   	   			}
   	   		},
   			function(data, status, headers, config) {
   	   			if(locale == 'ko'){
					alert("실패하셨습니다.\n다시 시도해주세요.");
				} else {
					alert("You failed.\nPlease try again.");
				}
   		    }
   		);
	}
	
	$scope.showAddressFinderPopup = join.showAddressFinderPopup;
	$scope.showArtistFinderPopup = join.showArtistFinderPopup;

});


</script>
<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>

<div class="container_wrap">
	
	<div id="container" ng-controller="joinCtl" data-ng-init="init();">
		<div class="sub_menu_wrap menu05">
			<div class="sub_menu">
				<jsp:include page="../include/customerSubMenu.jsp" flush="false"/>
			</div>
		</div>
		<!-- //sub_menu_wrap -->

		<div class="contents_wrap">
			<div class="contents">
				<div class="tit_h2">
					<h2><spring:message code="label.membership.ChangeInfo" /></h2>
				</div>
				<form name="joinForm" method="post" ng-submit="submitForm()">
					<fieldset>
						<legend>회원정보수정</legend>
						<div class="tbl_style01 m_tbl_z050">
							<table>
								<caption><spring:message code="label.membership.ChangeInfo" /></caption>
								<colgroup>
									<col style="width:15%;">
									<col>
								</colgroup>
								<tbody>
									<jsp:include page="./include/incJoinFormDefault.jsp" flush="false"/>
									<jsp:include page="./include/incJoinFormAdd.jsp" flush="false"/>
								</tbody>
							</table>
						</div>
						<div class="btn_wrap">
							<span class="btn_style01 white xlarge"><a ng-click="save();"><spring:message code="label.membership.ChangeInfosumit" /></a></span>
						</div>						
					</fieldset>

				</form>
			</div>
		</div>

	</div>
</div>
</div>
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
