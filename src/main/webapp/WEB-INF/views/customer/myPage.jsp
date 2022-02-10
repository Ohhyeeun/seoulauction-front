<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>

<link href="/css/angular/ngDialog.min.css" rel="stylesheet">
<link href="/resources/css/angular/popup.css" rel="stylesheet">
<link href="<c:url value="/css/old/onepcssgrid.css" />" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script src="/resources/js/angular/checklist-model.js"></script>

<script>
app.requires.push.apply(app.requires, ["checklist-model", "ngDialog"]);
app.controller('myPageCtl', function($scope, consts, common, ngDialog) {
	
	$scope.init = function(){
 		$d = {"baseParms":{},
 				"actionList":[
					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
 				]
 		};

 	   	common.callActionSet($d, function(data, status){
 	   		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
		});
	}

	$scope.showMemHisPopup = function($input) {
		$modal = ngDialog.open({
			template: '/customer/memHisPop',
			controller: 'memHisPopCtl',
			closeByDocument: false,
			showClose: false,
			animationEndSupport: false,
		});
	}
	
	$scope.leave = function(){
		
		if($scope.locale == 'ko'){
			if(!confirm("탈퇴하시겠습니까?")) return;
		} else {
			if(!confirm("Do you want leave?")) return;
		}
		
		$d = {"baseParms":{},
 				"actionList":[
					{"actionID":"modify_cust_stat_cd_for_leave", "actionType":"update" , "tableName": "CUST" ,"parmsList":[{}]}
 				]};
		console.log($d);
 	   	common.callActionSet($d, function(data, status){
 	   		console.log(data);
			if(data.tables["CUST"]["rows"].length > 0){
				if($scope.locale == 'ko'){
					alert("탈퇴 되었습니다. 이용해주셔서 감사합니다.");
				} else {
					alert("You are unsubscribed. Thank you for using.");
				}
				document.getElementById('logoutForm').submit();
			}
		});	
	}
	
	$scope.showRegularPayPopup = function(){
	//모바일에서 결제막음 - blueerr
	if(getCookie("mobileFlag") == 'mobile'){
		alert('앱모바일 결제는 준비중입니다. PC 또는 모바일 브라우저에서 결제를 하시기 바랍니다.');
		return;
	}
	window.open('/customer/TermCheckPop?locale='+$scope.locale,'popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0,left=500,top=100');
//	window.open('/customer/payRegularRequest','popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0');
	}
	
});

app.controller('memHisPopCtl', function($scope, consts, common) {
	$scope.init = function(){
 		$d = {"baseParms":{},
 				"actionList":[
					{"actionID":"get_customer_custpay_list", "actionType":"select" , "tableName": "CUST_PAY" ,"parmsList":[]},
 				]
 		};

 	   	common.callActionSet($d, function(data, status){
 	   		$scope.custPayList = data["tables"]["CUST_PAY"]["rows"];
		});
	}
});


</script>

<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		
		<div id="container" ng-controller="myPageCtl" data-ng-init="init()">
			<div class="sub_menu_wrap menu06">
				<div class="sub_menu ">
					<jsp:include page="../include/customerSubMenu.jsp" flush="false"/>
				</div>
				
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
                <div class="contents">
                    <div class="account_bg box_width">
                        <div class="my_box">
                            <div class="my_bg"></div>
                            <div class="my_h2">
                                <h2 style="color:#00acac">MY Seoul Auction</h2>
                            </div>
                        </div> 
                    </div> 
                <div class="clearfix"></div> 
                    <div class="box_gray type01">  
                        <div class="contact account_contact">      
                            <div class="title account_title" style="color: #6C9">ACCOUNT</div> 
                            <div class="info account_info">   
                                <span class="highlight">{{custInfo.CUST_NAME}}&nbsp;&nbsp;&nbsp;</span>    
                                <!-- 직원용 메뉴 -->  
                                <a ng-if="custInfo.EMP_GB == 'Y' || custInfo.emp_gb == 'Y' " href="/customer/Customer_admin" class="account_admin">고객 담당자 확인</a>      
                            </div>  
                        </div>
                        <div class="right account_right">  
                            <span class="btn_style01 icon02"><a href="/customer/inquiryList" class="fix">
                                    <spring:message code="label.membership.inquery"></spring:message></a><span class="ico next02"></span></span>
                        </div>
                    </div>
                
                <div class="clearfix"></div>
        
                    <div class="tit_h3 through">
                        <h3>&nbsp;<spring:message code="label.membership">&nbsp;</spring:message></h3>
                    </div>
                    
                <div class="clearfix"></div>
                    
                    <div class="onepcssgrid-1200">
                        <div class="my_bg2"><img src="/images/bg/bg_img108.png" width="189px;" height="156px;" alt="마이페이지 이미지"></div>
                        <div class="my_name">
                            {{custInfo.CUST_NAME}} <spring:message code="label.membership.jja07" /> 
                            <span style="font-weight:700;">
                                <span ng-if="custInfo.MEMBERSHIP_YN == 'Y'" style="font-weight:700;"><spring:message code="label.membership.jj" /></span>
                                <span ng-if="custInfo.MEMBERSHIP_YN == 'N'" style="font-weight:700;"><spring:message code="label.membership.j" /></span>
                            </span>&nbsp;
                            <spring:message code="label.membership.jja08" />
                        </div>
                           
                        <div class="account_box box_width">
                            <div class="account_p">
                                <p>
                                    <spring:message code="label.membership.jja09" />
                                </p>
                            </div>
                            <div class="account_btn">
                                <div class="btn_right">
                                    <div class="my_btn1">
                                    	<div ng-if="custInfo.CUST_NO == '108855'" class="emp_div" >
	                                        <span class="btn_style01 xlarge green02 mypage_btn"><button type="button" ng-click="showRegularPayPopup();" style="padding: 0 21px;"><spring:message code="label.membership.payment" /> test</button></span>
	                                    </div>
                                        <span ng-if="custInfo.MEMBERSHIP_YN == 'N'" class="btn_style01 xlarge green02 mypage_btn"><button type="button" ng-click="showRegularPayPopup();" style="padding: 0 21px;"><spring:message code="label.membership.payment" /></button></span>
                                    </div> 
                                    <div class="my_btn2">
                                        <button type="button" ng-click="showMemHisPopup(this);"><spring:message code="label.membership.pay" /></button>
                                    </div>                
                                </div>
                            </div>
                        </div><!-- // account_box -->              
                    </div><!--- // onepcssgrid-1200 ---->
                    
                <div class="clearfix"></div>
                
                    <div class="storage_cont">		
                        <div class="tit_h3 through">
                            <h3>&nbsp;<spring:message code="label.submenu">&nbsp;</spring:message></h3>
                        </div>
                        <div class="account_listwrap">                   
                            <div class="account_list">
                                <div class="acclist_img">
                                    <img src="/images/bg/bg_img101.png" width="65px" alt="회원정보 이미지">
                                </div>
                                <div class="acclist_box">
                                    <h4 class="txt_style04"><spring:message code="label.membership.AccInfo" /></h4>                       
                                    <p><a href="/customer/modifyForm"><spring:message code="label.membership.ChangeInfo" /></a></p>
                                    <p><a href="#" ng-click="leave();"><spring:message code="label.membership.DeleteAccount" /></a></p>
                                    <p><button type="button" ng-click="showMemHisPopup(this);" ><spring:message code="label.membership.pay" /></button></p>
                                </div>                        
                            </div>
        
                            <div class="account_list">
                                <div class="acclist_img" style="vertical-align: middle;">
                                <img src="/images/bg/bg_img103.png" width="65px" alt="오프라인경매 이미지">
                                </div>
                                <div class="acclist_box">
                                    <h4 class="txt_style04"><spring:message code="label.mypage.offauction" /></h4>    
                                        <p><a href="/customer/offlineBidReqList"><spring:message code="label.mypage.offauctionlist" /></a></p>
                                        <p><a href="/customer/offlineInteList/offline"><spring:message code="label.mypage.offintelist" /></a></p>
                                        <p><a href="/customer/offlineCRInteList"><spring:message code="label.mypage.offcrintelist" /></a></p>
                                </div> 
                            </div>
        
                            <div class="account_list">
                                <div class="acclist_img"><img src="/images/bg/bg_img108.png" alt="온라인경매 목록 이미지" width="65px"></div>
                                
                                <div class="acclist_box">
                                    <h4 class="txt_style04"><spring:message code="label.mypage.online" /></h4>  
                                        <p><a href="/customer/onlineBidList"><spring:message code="label.mypage.bidding" /></a></p>
                                        <p><a href="/customer/onlineAutoBidList"><spring:message code="label.mypage.autobidding" /></a></p>
                                        <p><a href="/customer/onlinePayList"><spring:message code="label.mypage.onlimepay" /></a></p>
                                        <p><a href="/customer/onlinePayList"><spring:message code="label.mypage.onlimepaylist" /></a></p>
                                        <p><a href="/customer/onlineInteList/online"><spring:message code="label.mypage.onintelist" /></a></p>
                                </div>                       
                            </div>
                            
                            
                            <div class="account_list">
                                <div class="acclist_img"><img src="/images/bg/bg_academy.png" alt="아카데미 신청 목록이미지" width="65px"></div>
                                <div class="acclist_box">
                                    <h4 class="txt_style04"><spring:message code="label.mypage.academylist" /></h4>
                                        <p><a href="/customer/academyList"><spring:message code="label.mypage.academylist" /></a></p>
                                </div>
                            </div>
                            
                            <div class="account_list">
                                <div class="acclist_img"><img src="/images/bg/bg_inquery.png" width="65px" alt="1대1문의 이미지">
                                </div>
                                <div class="acclist_box">
                                    <h4 class="txt_style04"><spring:message code="label.membership.inquery" /></h4> 
                                        <p><a href="/customer/inquiryList"><spring:message code="label.membership.inquery" /></a></p>
                                </div>                      
                            </div>
                        </div><!--- // account_list --->
                    </div><!--storage_cont-->
                    <div class="clearfix"></div>
                </div><!--- // contents ---->
            </div><!--- // contents_wrap ---->
            
		</div>
	</div>
</div>

<!-- //#wrap -->
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />