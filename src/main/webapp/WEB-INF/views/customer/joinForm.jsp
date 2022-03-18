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
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script src="/js/angular/checklist-model.js"></script>
<script type="text/javascript" src="/js/join.js?ver=20220317"></script>

	<style> 
		#loading {
			display:none;
		    width: 100%;
		    height: 100%;
		    background: rgba(255,255,255,0.9);
		    z-index: 99;
		    position: fixed;
	    }
	    #loading-image {
		    position: relative;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    -webkit-transform: translate(-50%, -50%);
		    -moz-transform: translate(-50%, -50%);
		    -ms-transform: translate(-50%, -50%);
		    -o-transform: translate(-50%, -50%);
		}
	</style>

<script type="text/javascript">

app.requires.push.apply(app.requires, ["checklist-model", "ngDialog"]);

app.controller("joinCtl", function($scope, consts, common, join, joinService, ngDialog, $interval) {
	
	$scope.joinOneCheck = false;
	$scope.nextStep = joinService.nextStep;
	$scope.setFormAddData = joinService.setFormAddData;
	
	$scope.form_data = {"cust_kind_cd": $scope.locale == "en" ? "person" : "${CUST_KIND_CD}", "local_kind_cd":$scope.locale == "ko" ? "korean" : "foreigner"};
	joinService.setScope($scope);
	
	$scope.init = function(){
 		$d = {"actionList":[
 				{"actionID":"code_list", "actionType":"select" , "tableName": "CODES", "parmsList":[{"grp_ids":["push_way", "interest_area", "nation"]}]}
 			 ]};
 		
 	   	common.callActionSet($d,
 	   		function(data, status) {
 	 	    	$scope.codeList = data["tables"]["CODES"]["rows"];
 	   		}
 	   	);
 	   	
	}
	$scope.save = function(){
		$('#loading').show();//
		setTimeout($scope.saveTime, 700);
	}
	
	$scope.setParamInfoList = function(infoType, list, paramName) {
    	for(i in list){
        	var map = {};
    		map[paramName] = list[i]; 
    		map["info_type"] = infoType; 
    		$scope.param_addInfoList.push(map);
    	}
    }
	
	$scope.saveAddInfo = function(){
		$scope.param_addInfoList = [];
		
	    $scope.setParamInfoList("pushway", $scope.push_ways, "push_way_cd");
	    $scope.setParamInfoList("area", $scope.interest_areas, "inte_area_cd");
	    $scope.setParamInfoList("artist", $scope.interest_artists, "artist");
		    
		$d = {"baseParms":{ "cust_no" : $scope.save_cust_no }, 
			"actionList":[
		    	{"actionID":"delete_add_info", "actionType":"delete", "tableName":"DEL_ADD_INFO", "parmsList": [{}]},
		    	{"actionID":"insert_addInfo", "actionType":"insert", "tableName":"INS_ADD_INFO", "parmsList": $scope.param_addInfoList},
// 		    	{"actionID":"add_join_push_ways", "actionType":"insert", "tableName": "CUST_PUSH_WAY", "parmsList": $scope.push_way_cds},
// 		    	{"actionID":"add_join_inte_area", "actionType":"insert", "tableName": "CUST_INTE_AREA", "parmsList": $scope.interest_areas_cds },
// 		    	{"actionID":"add_join_inte_artist", "actionType":"insert", "tableName": "CUST_INTE_ARTIST", "parmsList": $scope.interest_artists }
		]};
		
		common.callActionSet($d, function(data, status) {
			alert($scope.locale == 'ko'? "저장되었습니다. 로그인 페이지로 이동합니다." : "It's saved. Go to the login page.");
			location.href="/login";
		});
	}
	
	$scope.saveTime = function(){
		
		if($scope.joinOneCheck != true){
		$scope.joinOneCheck = true; 
		var param = $(location).attr('search').slice($(location).attr('search').indexOf('=')+1);
		
		var chbReceiveChK = $("#chbReceiveChk input:checkbox[name=is_check]:checked").length;
		
		if( chbReceiveChK > 0 ) {
			param = 'Y';
		}
		
        if(!$scope.validationBasic($scope)) return;
        $scope.form_data.marketing_chk = param;
        $scope.setFormData($scope);
        
      //저장전에 국적기준으로 foreigner, korean구분
        if ($scope.form_data.nation_cd == "KR"){
        	$scope.form_data.local_kind_cd = "korean";
        } else {
       		$scope.form_data.local_kind_cd = "foreigner";
        }
      
      
		$d = {"baseParms":{},
 				"actionList":[
 		    	{"actionID":"add_join", "actionType":"insert", "tableName": "CUST", "parmsList":[$scope.form_data]},
 		    	{"actionID":"select_join_cust", "actionType":"select", "tableName": "CUST_INFO", "parmsList":[$scope.form_data]},
 			]};
   	   	common.callActionSet($d,
   	   		function(data, status) {
				$('#loading').hide();
				$scope.save_cust_no = data.tables["CUST_INFO"]["rows"][0].CUST_NO;
				
   	   			if(data.tables["CUST"]["rows"].length > 0){
   	   				if($scope.locale == 'ko'){
						$scope.nextStep();
   	   				}else{
	   	   				$d = $scope.form_data;
		   	   			common.callAPI('/join/send_join_mail', $d, 
		   	   				function(data, status) {
		   	   					try{
		   	   						if(data){
										$scope.nextStep();
		   	   						}
		   	   						else{
			   	    					alert("Join success, but failed to authenticate mail.\n Please contact webmaster@seoulauction.com.");
			   	    					//document.location.href="/";
		   	   						}
		   	   					}
		   	   					catch(err){
		   	    					alert("Join success, but failed to authenticate mail.\n Please contact webmaster@seoulauction.com..");
		   	    					//document.location.href="/";
		   	   					}
		   	   		   		}
		   	   			); 
   	   				}
   	   				
   	   			}else{
   					alert("회원가입에 실패하셨습니다.\n다시 시도해주세요.");
   	   			}
   	   		},function(error){
   	   			alert("회원가입에 실패하셨습니다.\n다시 시도해주세요.");
   	   			document.location.href="/login";
   	   		});
   	   
		} else { return;}
		
	}
	

	$scope.showAddressFinderPopup = join.showAddressFinderPopup;
	$scope.showArtistFinderPopup = join.showArtistFinderPopup;
	
	$scope.sendMail = function(){
		$d = {"login_id": $scope.form_data.login_id, "authURL": "https://www.seoulauction.com"};
 			common.callAPI('/join/send_join_mail', $d, 
 				function(data, status) {
 					try{
 						if(data){
 							alert("회원 가입이 완료되었습니다.");
  	   						//document.location.href="/login";
 						}
 						else{
    						alert("Join success, but failed to authenticate mail.\n Please contact webmaster@seoulauction.com.");
    					//document.location.href="/";
 						}
 					}
 					catch(err){
  						alert("Join success, but failed to authenticate mail.\n Please contact webmaster@seoulauction.com..");
  					//document.location.href="/";
 					}
 		   		}
 			);
	}
	
});

function handleNewRadio(elRadio) {
	if(elRadio == document.getElementById("rb_new_road")) {
		$("#holder_new_first").val("");
		$("#holder_new_second").val("");
		$("#holder_new_first").attr("placeholder", "도로명 입력");
		$("#holder_new_second").attr("placeholder", "건물번호 입력");
	}
	else if(elRadio == document.getElementById("rb_new_dong")) {
		$("#holder_new_first").val("");
		$("#holder_new_second").val("");
		$("#holder_new_first").attr("placeholder", "동(읍/면) 입력");
		$("#holder_new_second").attr("placeholder", "지번 입력");
	}
}


</script>
<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
<div id="loading"><img id="loading-image" src="/images/loading.gif" alt="Loading..." /></div>
<div class="container_wrap">
	<div class="shadow left"><span class="corner"></span></div>
	<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
	<div id="container" ng-controller="joinCtl" data-ng-init="init();">
		<div class="sub_menu_wrap menu05">
			<div class="sub_menu">
				<ul>
					<li><a href="/login"><spring:message code="label.login" /></a></li>
					<li class="sele"><a href="#"><spring:message code="label.agree" /></a></li>
				</ul>
			</div>
		</div>
		<!-- //sub_menu_wrap -->

		<div class="contents_wrap">
			<div class="contents">
				<div class="tit_h2">
					<h2><spring:message code="label.agree" /></h2>
				</div>
				<div class="step_style01">
					<ol>
						<li id="step_li01" ><div><a href="#" onClick="return false;">01<br><spring:message code="label.agree.ag01" /></a></div></li>
						<li id="step_li02" ng-class="{'sele' : join_step == 'basic'}" ><div><a href="#">02<br><spring:message code="label.agree.ag02" /></a></div></li>
<%-- 						<li><div><a href="#" onClick="return false;">03<br><spring:message code="label.agree.ag03" /></a></div></li> --%>
						<li id="step_li03" ng-class="{'sele' : join_step == 'done'}" ><div><a href="#" onClick="return false;">03<br><spring:message code="label.agree.ag04" /></a></div></li>
					</ol>
				</div>
				<form name="joinForm" method="post" ng-submit="submitForm()">
					<fieldset ng-if="join_step=='basic'">
						<div class="tit_h3 noborder">
							<h3><spring:message code="label.mem.joinform" /></h3>
							<p><spring:message code="message.mem.joinform" /></p>
						</div>
						<legend><spring:message code="label.mem.joinform" /></legend>
						<div class="tbl_style01 m_tbl_z040">
							<table>
								<caption><spring:message code="label.mem.joinform" /></caption>
								<colgroup>
									<col style="width:15%;">
									<col>
								</colgroup>
								<tbody>
									<jsp:include page="./include/incJoinFormDefault.jsp" flush="false"/>
								</tbody>
							</table>
						</div>
						<div class="btn_wrap">
							<span class="btn_style01 white xlarge"><a ng-click="nextStep();" tabindex="36"><spring:message code="label.mem.sumit" /></a></span>
						</div>
					</fieldset>
					<fieldset ng-if="join_step=='done'">
						<div class="tit_h3 noborder noListbox " style="height:200px; text-align:center;">
							<h3 style="font-weight:500"><spring:message code="message.mem.done" /></h3>
														
						</div>
						<div class="tit_h3 noborder">
<%-- 							<h3><spring:message code="label.mem.joinform01" /></h3> --%>
							<p><spring:message code="message.mem.joinform01" /></p>
						</div>
						<legend><spring:message code="label.mem.joinform01" /></legend>
						<div class="tbl_style01 m_tbl_z040">
							<table>
								<caption><spring:message code="label.mem.joinform01" /></caption>
								<colgroup>
									<col style="width:15%;">
									<col>
								</colgroup>
								<tbody>
									<jsp:include page="./include/incJoinDone.jsp" flush="false"/>
								</tbody>
							</table>
						</div>
						<div class="btn_wrap">
							<span class="btn_style01 white xlarge"><a ng-click="saveAddInfo()" tabindex="36">{{locale=='ko'? "저장하기" : "Save"}}</a></span>
						</div>
					</fieldset>
					<%-- <fieldset ng-if="join_step=='addInfo'">
						<div class="tit_h3 noborder">
							<h3><spring:message code="label.mem.joinform01" /></h3>
							<p><spring:message code="message.mem.joinform01" /></p>
						</div>
						<legend><spring:message code="label.mem.joinform01" /></legend>
						<div class="tbl_style01 m_tbl_z043">
							<table>
								<caption><spring:message code="label.mem.joinform01" /></caption>
								<colgroup>
									<col style="width:20%;">
									<col>
								</colgroup>
								<tbody>
									<jsp:include page="./include/incJoinFormAdd.jsp" flush="false"/>
								</tbody>
							</table>
						</div>
						<div class="btn_wrap">
							<span class="btn_style01 white xlarge" style="float:left;"><a ng-click="backStep();" tabindex="27"><spring:message code="label.back.prev" /></a></span>
							<span class="btn_style01 white xlarge"><a ng-click="nextStep();"><spring:message code="label.mem.sumit" /></a></span>
						</div>						
					</fieldset> --%>
					<fieldset ng-if="join_step=='compDocument'">
						<div class="tit_h3 noborder">
							<h3>개인/법인 사업자 증빙서류 제출</h3>
							<p>개인/법인 증빙서류를 제출하여 회원가입을 완료해주세요.</p>
						</div>
						<div class="box_style01">
							<div class="list_style01 type02">
								<ul>
									<li><strong>사업자등록증 사본 1부, 담당자 재직증명서 1부</strong>를 필수로 등록해주시고, 기타 증빙이 가능한 서류를 등록해주세요.</li>
									<li>담당자의 주민등록번호 뒤 7자리는 가린 상태로 등록해주셔야 합니다.</li>
									<li>제출된 서류와 입력하신 정보가 틀릴 경우에는 가입 승인되지 않을 수 있습니다.</li>
									<li>파일을 새로 등록하시면 기존 등록하신 파일은 삭제됩니다.</li>
								</ul>
							</div>
						</div>
						<div class="wrap_search attach">
							<div class="search_box" id="uploadContainer">
								<div class="row">
									<dl>
										<dt>사업자등록증 사본<span class="ico_essen"><span class="hidden">필수입력</span></span></dt>
										<dd>
											<div id="registeredFileContainer" class="fl_wrap">
												<!--
												<span class="btn_style01 gray02 wide">
													<button type="button" id="btnRegistered">파일등록</button>
												</span>
												-->
												<ul class="fl_menu" id="selectedRegisteredList">
													<!--
													<li><a href="">사업자등록증.jpg</a> <button type="button" class="sp_btn btn_attach_close"><span class="hidden">닫기</span></button></li>
													<li><a href="">사업자등록증.jpg</a> <button type="button" class="sp_btn btn_attach_close"><span class="hidden">닫기</span></button></li>
													-->
												</ul>
												<input type="file" name="" id="proofDocRegisteredFile" />
												<input type="hidden" name="proof_doc_registered_file_new" id="proofDocRegisteredNew" />
												<input type="hidden" name="proof_doc_registered_file_old" id="proofDocRegisteredOld" />
												<input type="hidden" name="proof_doc_registered_file_size" id="proofDocRegisteredSize" />
												<input type="hidden" name="proof_doc_registered_file_path" id="proofDocRegisteredPath" />
											</div>
										</dd>
									</dl>
								</div>
							</div>
						</div>
						<div class="btn_wrap">
							<span class="btn_style01 white xlarge" style="float:left;"><a ng-click="backStep();" tabindex="27"><spring:message code="label.back.prev" /></a></span>
							<span class="btn_style01 dark xlarge">
								<button type="button" ng-click="nextStep();"><spring:message code="label.mem.sumit" /></button>
							</span>
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
