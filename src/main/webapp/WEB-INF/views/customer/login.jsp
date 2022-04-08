<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="../include/header.jsp" flush="false"/>
<style>
	.hidden_btn {
		position: absolute;
		top: 35px;
		left: 240px;
		width: 80px;
		height: 80px;
	}
</style>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>

<link href="/css/angular/ngDialog.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">
<script src="/js/LoginSave.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script src="/js/angular/checklist-model.js"></script>
 
<script type="text/javascript">
var search_kind = "";

app.requires.push.apply(app.requires, ["checklist-model", "ngDialog"]);
app.controller('loginCtl', function($scope, consts, common, ngDialog) {
	

	$scope.searchAccountPopup = function($input) {
		search_kind = $input.search_kind;
		$modal = ngDialog.open({
			template: '/join/searchAccountPop',
			controller: 'searchAccountPopCtl',
			closeByDocument: false,
			showClose: false,
			animationEndSupport: false,
		});
	}
	
	
});

app.controller('searchAccountPopCtl', function($scope, consts, common, locale) {
	$scope.search_kind = search_kind;
	$scope.form_data ={};
	$scope.search_way = locale == 'ko'? 'phone' : 'email';
	$scope.hp1s = ["010", "011", "016", "017", "018", "019"];  	  	  	  
	
	$scope.searchId = function(){
		var param = {};
		
		if(!$scope.isValidString($scope.form_data.cust_name)){
			return;
		}
		/* if(!$scope.isValidString($scope.form_data.p_email1) || !$scope.isValidString($scope.form_data.p_email2)){
			return;
		} */
		
		if($scope.search_way == 'phone' && (!$scope.isValidString($scope.form_data.p_phone) || !$scope.isValidString($scope.form_data.p_phone2) || !$scope.isValidString($scope.form_data.p_phone3))){
			return;
		}
		
		if($scope.search_way == 'email' && (!$scope.isValidString($scope.form_data.p_email1) || !$scope.isValidString($scope.form_data.p_email2))){
			return;
		}
		
		param = {
			search_way : $scope.search_way,
			cust_name: $scope.form_data.cust_name,
			phone : $scope.form_data.p_phone + "-" +$scope.form_data.p_phone2 + "-" +$scope.form_data.p_phone3,
			email: $scope.form_data.p_email1 + "@" + $scope.form_data.p_email2
		}
		
		
 		$d = {"baseParms":{},
 				"actionList":[
					{"actionID":"find_customer_login_id", "actionType":"select" , "tableName": "FIND_CUST" ,"parmsList":[param]},
 				]
 		};

 	   	common.callActionSet($d, function(data, status){
 	   		$scope.custInfo = data["tables"]["FIND_CUST"]["rows"];
		});
	}
	
	$scope.checkSendMail = false; 
	$scope.searchPasswd = function(){
		$scope.checkSendMail = false;
		var isReturn = false;
		var $d = {};
			
		//빈값체크
		if(!$scope.isValidString($scope.form_data.p_login_id)){
			return;
		}
		if(!$scope.isValidString($scope.form_data.cust_name)){
			return;
		}
		
		if($scope.search_way == 'phone' && (!$scope.isValidString($scope.form_data.p_phone) || !$scope.isValidString($scope.form_data.p_phone2) || !$scope.isValidString($scope.form_data.p_phone3))){
			return;
		}
		
		if($scope.search_way == 'email' && (!$scope.isValidString($scope.form_data.p_email1) || !$scope.isValidString($scope.form_data.p_email2))){
			return;
		}
		
		$d = {
			locale: locale,
			login_id: $scope.form_data.p_login_id,			
			cust_name: $scope.form_data.cust_name,
			search_way : $scope.search_way,
			to_phone : $scope.form_data.p_phone + $scope.form_data.p_phone2 + $scope.form_data.p_phone3,
			phone : $scope.form_data.p_phone + "-" +$scope.form_data.p_phone2 + "-" +$scope.form_data.p_phone3,
			email: $scope.form_data.p_email1 + "@" + $scope.form_data.p_email2
		}
		
			
		if($scope.search_way == 'phone'){
// 			console.log("phone")
			common.callAPI('/join/send_passwd_sms', $d, 
				function(data, status) {
					try {
						$scope.checkSendMail = data.SEND_STATUS;
						console.log($scope.checkSendMail);
						
						if($scope.checkSendMail){
							alert("문자가 발송 되었습니다.");
	   						document.location.href="/login";
						}else{
							alert("일치하는 회원 정보가 없습니다.");
						}
						
					}
					catch(err) {
						alert("문자 발송시 문제가 발생하였습니다. 관리자에게 문의 하세요.");
						document.location.href="/";
					}
		   		}
			, null, function(){
				$scope.checkSendMail = false;
			}); 
			
		}else if($scope.search_way == 'email'){
			common.callAPI('/join/send_passwd_mail', $d, 
				function(data, status) {
					$scope.checkSendMail = true;
					try{
						if(data){
							alert("메일이 발송 되었습니다.");
	   						document.location.href="/login";
						}
						else{
							alert("일치하는 회원 정보가 없습니다.");
					//document.location.href="/";
						}
					}
					catch(err){
						alert("메일 발송시 문제가 발생하였습니다. 관리자에게 문의 하세요.");
						document.location.href="/";
					}
				}
			, null, function(){
				$scope.checkSendMail = false;
			});
		}
		
	}
	
});
</script>

<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container" ng-controller="loginCtl">
			<div class="sub_menu_wrap menu05">
				<div class="sub_menu">
					<ul>
						<li class="sele"><a href="/login"><spring:message code="label.login" /></a></li>
						<li><a href="/join/agree"><spring:message code="label.agree" /></a></li> 
					</ul> 
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden"><spring:message code="label.submenu" /></span></button>
			</div>
			<!-- //sub_menu_wrap -->
		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>
			<div class="contents_wrap">
				<div class="contents">
					<div class="both_cont login_wrap"><!-- [D]회원가입 완료시 회원가입부분 보이지 않게 처리 -> 클래스 'login' 추가 -->
						<div>
							<form id="loginForm" action="/processLogin" method="post">
								<fieldset>
									<legend><spring:message code="label.login" /></legend>
									<!-- <div class="inner bg_img bg01"> -->
									<div class="bg_img bg01"> 
										<div class="hidden_btn"></div>
										<div class="tit_h2 type02">
											<h2><spring:message code="label.login" /></h2>
											<p><spring:message code="label.loginmess" /></p> 
										</div>
										<div class="form">  
											<div class="login_checkbox login_checkbox01">  
												<input type="text" name="loginId" id="loginId" placeholder="<spring:message code="label.loginId" />" title="Id"  autofocus="autofocus"/>
												<input type="password" name="password" id="password" placeholder="<spring:message code="label.putpassword" />" title="password" />
											</div> 
											
											<div class="login_checkbox login_checkbox02">   
												<fieldset> 
													<input type="checkbox" name="checkedID" id="checkedID" />    
													<label for="checkedID">
														<span ng-if="locale == 'ko'">ID 저장</span>  
														<span ng-if="locale != 'ko'">Save ID</span>   
													</label>   
												</fieldset>  
												<fieldset>
													<input type="checkbox" name="checkedPW" id="checkedPW" />    
													<label for="checkedPW">
														<span ng-if="locale == 'ko'">PW 저장</span> 
														<span ng-if="locale != 'ko'">Save PW</span>  
													</label>
												</fieldset>
												<fieldset>
													<input type="checkbox" name="_spring_security_remember_me" id="remember-me">
													<label for="remember-me">
														<span ng-if="locale == 'ko'">로그인 상태 유지</span>
														<span ng-if="locale != 'ko'">Stay signed in</span>
													</label>
												</fieldset>
											</div>
											
											<div class="clearfix">    
												<span class="btn_style01 green02 high"><button type="submit"><spring:message code="label.login" /></button></span>
											</div> 
											
											<div class="search">
												<a href="" class="pop12id btn_modal pop12" ng-click="searchAccountPopup({'search_kind':'id'});"><spring:message code="label.loginIdfind" /></a> 
													<span style="height: 7px; width: 1px; border-right: 1px solid #ddd; margin: 0 10px; vertical-align: middle;"></span>             
												<a href="" class="pop12pw btn_modal pop12" ng-click="searchAccountPopup({'search_kind':'passwd'});"><spring:message code="label.passwordfind" /></a> 
											</div> 
										</div>  
									</div>
								</fieldset>   
								<input type="hidden" name="targetUrl" value="${targetUrl}" /> 
		  						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
						</div>
						
						<c:if test="${not empty error}"> 
						<div class="login_errorbox">
							<div id="divLoginFailed" class="box_style02">
								<div class="bg_img bg09">
									<p class="txt_style02"><strong class="txt_green"><spring:message code="label.logerror" /></strong></p>
									<!--<p id="notConfirmed"><spring:message code="label.logerrornotConfirmed" /></p>-->
								</div>
							</div>
						</div> 
						</c:if>
						
						<div class="join">
							<div class="inner bg_img bg02">
								<div class="tit_h2 type02">
									<h2><spring:message code="label.agree" /></h2>
									<p><spring:message code="label.agreemessage" /></p><br/><br/>
									<div class="btn_wrap">
										<span class="btn_style01 dark xlarge"><a href="/auctionGuide/page?view=biddingGuide"><spring:message code="label.howto.bid" /></a></span>
										<span class="btn_style01 green02 xlarge"><a href="/join/agree"><spring:message code="label.agreenow" /></a></span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<c:choose>
						<c:when test="${status == 'completed'}">
							<c:choose>
								<c:when test="${clientType == 'P' }">
					<div class="box_style02">
						<div class="bg_img bg03">
							<p class="txt_style02"><strong class="txt_green">${name }</strong><spring:message code="label.logcomplet" /></p>
                            <p><spring:message code="label.logcompletadd" /></p>
							
						</div>
					</div>
								</c:when>
								<c:when test="${clientType == 'C' }">
					<div class="box_style02">
						<div class="bg_img bg03">
							<p class="txt_style02"><strong class="txt_green">${name }</strong><spring:message code="label.logcomp" /></p>
						</div>
					</div>
								</c:when>
							</c:choose>
							<script>
								$(".login_wrap").addClass("login");
							</script>
						</c:when>
					</c:choose>
					
					<c:if test="${not empty logoutMsg}">
					<div id="divLogoutSucceed" class="box_style02">
						<div class="bg_img bg03">
							<p class="txt_style02"><strong class="txt_green"><spring:message code="label.logout" /></strong></p>
						</div>
					</div>
					</c:if>
					
					<c:if test="${not empty joinSuccess}">
					<div class="box_style02">
						<div class="bg_img bg03">
							<p class="txt_style02"><spring:message code="label.logcomplet" /></p>
						</div>
					</div>
					</c:if>

					<div class="ex_list_area">
						<c:if test="${not empty upcomingList and fn:length(upcomingList) > 0 }">
						<div class="area">
							<div class="title"><spring:message code="auction.upcoming" /></div>
							<div class="hidden_box">
								<ul>
								<c:forEach var="upcoming" items="${upcomingList }" varStatus="status">
									<li>
										<a target="_blank" href="/auction/upcoming?from=L&salesPlanningId=${upcoming.sales_planning_id }">
											<img src="${uploadUrl}${upcoming.upcomingImage.path}${upcoming.upcomingImage.file_name}" alt="${upcoming.work_title_kr }">
										</a>
										<div>
											<span>제 ${upcoming.salesPlanning.times }회 ${upcoming.salesPlanning.name_kr }</span>
										</div>
									</li>
								</c:forEach>
								</ul>
							</div>
						</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />

<script>
	$(document).ready(function(){ 
		if(window.matchMedia("screen and (min-width:797px)").matches){            
			$(".login_errorbox").show(function(){ 
				$(".login_wrap").css("padding-bottom","220px"); 
			});	 
		}else{ 
			$(".login_errorbox").show(function(){
				$(".login_wrap").css("padding-bottom","0");
			}); 
		}
		
	})
</script>