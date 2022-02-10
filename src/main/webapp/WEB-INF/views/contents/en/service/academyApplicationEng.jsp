<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link href="<c:url value="/resources/css/old/onepcssgrid_new.css" />" rel="stylesheet">
<link href="/resources/css/angular/ngDialog.css" rel="stylesheet">
<link href="/resources/css/angular/popup.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script src="/resources/js/angular/checklist-model.js"></script>
<script type="text/javascript" src="/resources/js/join.js?${resources.timestamp}"></script>

<script>

app.requires.push.apply(app.requires, ["checklist-model", "ngDialog"]);


$.urlParam = function(name){
    var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
    return results[1] || 0;
}

academy_no = Number($.urlParam('academy_no'));

app.controller('academyListCtl', function($scope, consts, common) {
	$scope.loadAcademyList = function($page){
	
 		$d = {"baseParms":{"academy_no": academy_no },  //
 				"actionList":[
 				{"actionID":"get_academy_info","actionType":"select" , "tableName": "ACADEMY_LIST" ,"parmsList":[]},
		 	]};

			   common.callActionSet($d, $s);
			}
	
			var $s = function(data, status) { 
				$scope.academyList = data["tables"]["ACADEMY_LIST"]["rows"];
			};
});

app.controller("joinCtl", function($scope, consts, common, join, joinService, ngDialog, $interval) {
	$scope.form_data = {"cust_kind_cd": $scope.locale == "en" ? "person" : "${CUST_KIND_CD}", "local_kind_cd":$scope.locale == "ko" ? "korean" : "foreigner"};
	joinService.setScope($scope);
	
	$scope.init = function(){
 		$d = {"actionList":[
 				{"actionID":"code_list", "actionType":"select" , "tableName": "CODES", "parmsList":[{"grp_ids":["push_way", "interest_area", "nation"]}]},
 				{"actionID":"get_customer_by_cust_no","actionType":"select" , "tableName": "ACADEMY_USERINFO" ,"parmsList":[]}
 			 ]};
 		
 	   	common.callActionSet($d,
 	   		function(data, status) {
 	 	    	$scope.codeList = data["tables"]["CODES"]["rows"];
 	 	    	$scope.academyuserinfo = data["tables"]["ACADEMY_USERINFO"]["rows"];
 	   		}
 	   	);
 	   	
	}
	
	
	$scope.showPurchasePopup = function(academy_pay){
		console.log(academy_pay);
		console.log(academy_no);
		
		window.open('/customer/payAcademyRequest?academy_pay='+academy_pay+'&academy_no='+academy_no,'popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0');
	};
});






</script>

<%-- YDH 추가 끝--%>
<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="academyListCtl" data-ng-init="loadAcademyList(1)">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../../include/serviceSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">menu</span></button>
			</div>
			<!-- //sub_menu_wrap -->
            
            <div ng-controller="joinCtl" data-ng-init="init();" ng-repeat="art in academyList">

                <div class="contents_wrap" ng-repeat="userinfo in academyuserinfo">
                    <div class="contents">
                        <div class="tit_h2" style="padding-top:20px;">
                            <h2><spring:message code="label.mypage.academylistlist" /></h2>
                        </div>
                        <p style="font-size:12px; line-height:18px;" ng-if="locale!='ko'">※ Classes are held only in Korean.</p>
                        <p style="font-size:12px; line-height:18px;">※ 신청내역을 확인 후 결제하여 주시기 바랍니다.</p>
                        <p style="font-size:12px; line-height:18px; color:#F00">※ 수업 시작 후에는 환불이 불가합니다. </p>
                        <p style="font-size:12px; line-height:18px;">문의 : 02-2075-4466, 02-545-0330(강남센터)</p>
                        <span class="btn_style01 icon02"  style="margin-top:10px; margin-bottom:30px;"><a href="/customer/inquiryForm" class="fix">Inquiry</a><span class="ico next02"></span></span> 
                        
                        <div class="onepcssgrid-1200" style="border-bottom:#e4e4e4 1px solid;" ng-repeat="art in academyList">
                        
                            <div style="border-top:#333 2px solid; border-bottom:#e4e4e4 1px solid; padding-top:20px; padding-bottom:20px;">
                                <h2 style="font-weight:600; font-size:20px;" ng-model="form_data.title_blob" name="form_data.title_blob" >{{art.TITLE_JSON[locale]}}</h2>
                            </div>
                            
                            <div class="col4" style="padding-top:20px; padding-bottom:20px;">
                                <p style="padding-bottom:5px;font-size:14px; line-height:28px;">
                                성함 : <font id="cust_name" ng-model="form_data.cust_name" name="form_data.cust_name">{{userinfo.CUST_NAME}}</font><br/>
                                이메일 : <font ng-model="form_data.email" name="form_data.email">{{userinfo.EMAIL}}</font><br/>
                                휴대폰 : <font ng-model="form_data.hp" name="form_data.hp" >{{userinfo.HP}}</font><br/>
                                </p>
                                
                               <!-- <div ng-if="locale == 'ko' && checkHp.valid">
                                    <span scope="row"><label for="">휴대폰 인증</label><span class="ico_essen"><span class="hidden">필수입력</span></span></span>
                                    <div class="fl_wrap type02">
                                        <div class="input_phone_auh">
                                            <span  ng-if="!checkHpAuth.valid" class="btn_style01 gray02"><button type="button" ng-click="authNumRequest()">{{auth_req_btn_txt}}</button></span>
                                            <input ng-if="checkHp.valid && !checkHpAuth.valid" type="text" ng-model="form_data.auth_num" 
                                                ng-style="getValidInput(checkHpAuth.valid)"
                                            onkeypress="return onlyNumber(event);" class="tac" placeholder="인증번호" maxlength=6 />
                                            <span  ng-if="checkHp.valid && !checkHpAuth.valid" class="btn_style01 gray02"><button type="button" ng-click="authNumConfirm()">인증</button></span>
                                            <p class="tbl_txt" ng-style="checkHpAuth.valid ? styleValid : styleInvalid">{{getHpAuthMsg()}}</p>
                                            <input type="hidden" name="checkHpAuth" ng-model="checkHpAuth.check" ng-required="locale == 'ko'" />
                                        </div>
                                    </div>
                                 </div>-->
                                
                                 <p style="padding-bottom:5px; font-size:12px; color:#F30;">※ 신청하신분의 정보가 정확한지 확인해주시기 바랍니다.</p>
    
                                 <div style="clear:both;"></div>
                            </div>
                            
                            <div class="col4" style="padding-top:20px; padding-bottom:20px;">
                                <p style="padding-bottom:5px;font-size:14px; line-height:28px;">
                                수강료 : <font ng-model="form_data.academy_pay" name="form_data.academy_pay">{{art.ACADEMY_PAY}} (부가세포함)</font><br/>
                                </p>
                                <div style="clear:both;"></div>
                            </div>
                            
                            <div class="col4 last" style="padding-top:20px; padding-bottom:20px;">
                                <span class="btn_style01" style="padding:3px 20px 3px 20px; background-color:#F60;">
                                    <button type="button" ng-click="showPurchasePopup(art.ACADEMY_PAY);" style="color:#FFF; font-size:14px; font-weight:700;">결제하기</button>
                                </span>
                                <a href="javascript:history.go(-1)">
                                    <span class="btn_style01" style="padding:3px 20px 3px 20px; background-color:#F60;">
                                    <button type="button" style="color:#FFF; font-size:14px; font-weight:700;">취소</button>
                                    </span>
                                </a>
                                <div style="clear:both;"></div>
                            </div>
                            <div class="onerow"></div>
    
      
                        </div><!--onepcssgrid-1200-->
                    </div><!--contents-->
                </div><!--contents_wrap-->
                
            </div>
            
		</div>
	</div>
</div>

<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />