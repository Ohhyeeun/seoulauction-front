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
<script type="text/javascript" src="/js/join.js"></script>   

<style>
.required{
	color:red;
	margin-right:2px;
}

input[type=radio]{
	margin-right:3px;
}
</style>

<script type="text/javascript">

app.controller('custCtl', function($scope, common) {
	
	$scope.form_data = {};
	$scope.hp1s = ["010", "011", "016", "017", "018", "019"];  	  	  	  	   	  	       		
	$scope.emails = ["naver.com", "nate.com", "gmail.com", "daum.net", "hanmail.net", "hotmail.com"];  	  
	
	$scope.init = function(){
		
		$("#rq_mail").hide();
		
		$d = {"baseParms":{},
 				"actionList":[
					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
 				]
 		};

 	   	common.callActionSet($d, function(data, status){
 	   		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
		});
 	   	
	}
	
	$scope.resultCustomerList = function(){
		//조회할 데이터 미입력시 처리. !! : 비어있으면 true
		var nameIsEmpty = !!$scope.form_data.Customer_name; 
		var hpIsEmpty = !!$scope.form_data.Customer_phone && !!$scope.form_data.Customer_phone2 && !!$scope.form_data.Customer_phone3;
		var emailIsEmpty = !!$scope.form_data.Customer_mail1 && !!$scope.form_data.Customer_mail2;
		var isKorean = $scope.form_data.local_kind == 'korean' ? true : false; //외국인 체크
		
		if(isKorean && (!nameIsEmpty || !hpIsEmpty)){ //내국인이면서 필수값이 비어있으면 return
			$("[name=Customer_name]").attr("required" , true);
			$("[name=Customer_phone]").attr("required" , true);
			$("[name=Customer_phone2]").attr("required" , true);
			$("[name=Customer_phone3]").attr("required" , true);
			$("[name=Customer_mail1]").attr('required', false);
			$("[name=Customer_mail2]").attr('required', false);
			return; 
		}else if(!isKorean && (!nameIsEmpty || !emailIsEmpty)){ //외국인이면서 필수값이 비어있으면 return
			$("[name=Customer_name]").attr("required" , true);
			$("[name=Customer_phone]").attr("required" , false);
			$("[name=Customer_phone2]").attr("required" , false);
			$("[name=Customer_phone3]").attr("required" , false);
			$("[name=Customer_mail1]").attr('required', true);
			$("[name=Customer_mail2]").attr('required', true);
			return;
		}
		
		//db호출
		$scope.customer_name = $scope.form_data.Customer_name;
		$scope.customer_hp = $scope.form_data.Customer_phone + $scope.form_data.Customer_phone2 + $scope.form_data.Customer_phone3;
		$scope.customer_email = $scope.form_data.Customer_mail1 + $scope.form_data.Customer_mail2;
		
		$d = {"baseParms":{"customer_name" : $scope.customer_name, "customer_hp" : $scope.customer_hp, "customer_email" : $scope.customer_email, "local_kind" : $scope.form_data.local_kind },
 				"actionList":[
					{"actionID":"get_customer_admin", "actionType":"select" , "tableName": "CUSTLIST" ,"parmsList":[]},
 				]
 		};

 	   	common.callActionSet($d, function(data, status){
 	   		$scope.custlist = data["tables"]["CUSTLIST"]["rows"];
		});
 	   	
	}
	
	//입력 초기화시 값 초기화
	$scope.reset = function(reset){
		$scope.form_data.Customer_name = '';
		$scope.form_data.Customer_phone = '';
		$scope.form_data.Customer_phone2 = '';
		$scope.form_data.Customer_phone3 = '';
		$scope.form_data.Customer_mail1 = '';
		$scope.form_data.Customer_mail2 = '';
		$scope.select_mail2 ='';
		if(reset){//취소버튼눌렀을떄
			$("#local_ko").click();
			$('input:radio[name="local_kind"]:input[value=korean]').attr("checked", true);
// 			$('input:radio[name="local_kind"]').val(['korean']);
// 	 		$('input:radio[name="local_kind"]').change();
		}
		
	}
	
	//내/외국인 선택 이벤트처리
	$('input:radio[name="local_kind"]').change(function(){
		var value = $('input:radio[name="local_kind"]:checked').val();
		if(value == 'foreigner'){ //외국인
			$("#Customer_phone").attr('required', false);
			$("#Customer_phone2").attr('required', false);
			$("#Customer_phone3").attr('required', false);
			
			$("#Customer_mail1").attr('required', true);
			$("#Customer_mail2").attr('required', true);
			
			$("#rq_hp").hide();
			$("#rq_mail").show();
			
			$("#notice").text("※ '이름', '이메일' 필수 입력");
	    }else{//내국인
	    	$("#Customer_phone").attr('required', true);
			$("#Customer_phone2").attr('required', true);
			$("#Customer_phone3").attr('required', true);
			
			$("#Customer_mail1").attr('required', false);
			$("#Customer_mail2").attr('required', false);
			
			$("#rq_hp").show();
			$("#rq_mail").hide();
			
			$("#notice").text("※ '이름', '휴대폰' 필수 입력");
	    }
	});
	
});

</script> 
 
<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">   
		<div id="container" ng-controller="custCtl" data-ng-init="init();"> 
			<div class="sub_menu_wrap menu05">
				<div class="sub_menu">
					<jsp:include page="../include/customerSubMenu.jsp" flush="false"/>
				</div>
			</div>
			<!-- //sub_menu_wrap -->
	
			<div class="contents_wrap">
				<div class="contents">  
					<div class="tit_h2">  
						<h2>고객 담당자 확인</h2>
					</div>  
					<div class="cstm_boxwrap">
						
						<div class="cstm_admin_txtform clearfix"> 
							<p id="notice" style="padding-bottom:3px;">※ '이름', '휴대폰' 필수 입력</p>
							<form name="joinForm" method="post" onSubmit="return false;">   
								
								<fieldset>
									<legend>고객 확인 검색</legend> 
									<div class="tbl_style01 m_tbl_z050" style="border-top: none;">    
										<table> 
											<caption>고객 확인 검색</caption>  
											<colgroup> 
												<col style="width:20%">           
												<col style="width: *">
											</colgroup> 
											<tbody class="customer_tbody" style="border-top: 2px solid #333;">   
												<tr>  
													<th scope="row">   
														<label for="Customer_name" style="font-weight: bold;"><span class="required">*</span><spring:message code="label.mem.name" /></label> 
													</th>
													<td>
														<input type="text" id="Customer_name" name="Customer_name" ng-model="form_data.Customer_name" style="float:left" required/>    
<!-- 													</td> -->
<!-- 													<td> -->
														<div style="padding:0px 10px; float:left; line-height:32px;">
															<label for="local_ko" style="margin-right:16px;"><input type="radio" id="local_ko" name="local_kind" ng-model="form_data.local_kind" value="korean" ng-change="reset()" ng-init="form_data.local_kind='korean'"/>내국인</label>
															<label for="local_for" style=""><input type="radio" id="locak_for" name="local_kind" ng-model="form_data.local_kind" ng-change="reset()" value="foreigner"/>외국인</label>  
														</div>
													</td>
												</tr><!-- //이름 -->
												<tr id="hp_tr"> 
													<th scope="row">  
														<label for="Customer_phone" style="font-weight: bold;"><span id="rq_hp" class="required" >*</span><spring:message code="label.mem.mobile" /></label>
													</th> 
													<td> 
														<div class="fl_wrap type02 Customer_fl_wrap">     
															<div class="input_phone input_phone_customer">   
																<select id="Customer_phone" name="Customer_phone" ng-model="form_data.Customer_phone" style="margin-right: 0;" >        
																	<option value="" selected>선택</option>
																	<option ng-repeat="hp in hp1s" value="{{hp}}">{{hp}}</option> 
																</select>  
																<span class="tbl_label" style="margin-right: 0;">-</span>   
																<input type="text" id="Customer_phone2" name="Customer_phone2" ng-model="form_data.Customer_phone2" value="" class="tac" placeholder="앞자리" maxlength=4  style="margin-right: 0; ime-mode:disabled;" />   
																<span class="tbl_label" style="margin-right: 0;">-</span>  
																<input type="text" id="Customer_phone3" name="Customer_phone3" ng-model="form_data.Customer_phone3" value="" class="tac" placeholder="뒷자리" maxlength=4  style="margin-right: 0; ime-mode:disabled;" />  
															</div>  
														</div> 
													</td>
												</tr><!-- //휴대폰 --> 
												<tr > 
													<th scope="row"> 
														<label for="Customer_mail" style="font-weight: bold;"><span id="rq_mail" class="required" >*</span><spring:message code="label.mem.email" /></label>
													</th> 
													<td>
														<div class="fl_wrap type02"> 
															<div class="input_email input_email_customer">  
																<input type="text" name="Customer_mail1" id="Customer_mail1" ng-model="form_data.Customer_mail1" value="">      
																<span class="tbl_label">@</span>   
																<input type="text" name="Customer_mail2" id="Customer_mail2" ng-model="form_data.Customer_mail2" value="" >           
																<select  ng-model="select_mail2" ng-change="form_data.Customer_mail2=select_mail2;">   
																	<option value="">선택하기</option>   
																	<option ng-repeat="email in emails" value="{{email}}" >{{email}}</option> 
																</select>
															</div>
														</div> 
													</td>
												</tr>  <!--//이메일 --> 
											</tbody> 
										</table> 
									</div>						
								</fieldset> 
								<div class="btn_wrap clearfix"> 
									<button class="cstm_adminbtn" type="submit" ng-click="resultCustomerList()">조회</button>   
									<button class="cstm_adminbtn_close" type="reset" ng-click="reset(true)">취소</button>    
								</div> 
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form> 
						</div><!-- //customer_txtform --> 
		 				
						<div class="cstm_admin_detail clearfix">
							<div class="cstm_tablescroll">        
								<table class="cstm_table">
									<thead>
										<tr>   
											<th scope="col">고객번호</th>
<!-- 											<th scope="col">성함</th> -->
											<th scope="col">담당자</th>
											<th scope="col">구분</th>    
<!-- 											<th scope="col">ID</th>     -->
<!-- 											<th scope="col">휴대폰</th>   -->
											<th scope="col">이메일</th>   
											<th scope="col">가입일</th>
		 									<th scope="col">정회원</th>
		 									<th scope="col">기간</th>
										</tr>  
									</thead>  
									<tbody>
									<tr ng-if="custlist.length <= 0">  
										<td colspan="10" style="background: #e8eafc;">조회할 데이터가 없습니다.</td>  
									</tr> 
									<tr ng-if="custlist.length > 0" ng-repeat="cust in custlist">
										<td>{{cust.cust_no}}</td>
<!-- 										<td>{{cust.cust_name}}</td> -->
										<td>{{cust.pid}}</td>
										<td>{{cust.join_kind_cd}}</td>
<!-- 										<td>{{cust.login_id}}</td> -->
<!-- 										<td>{{cust.hp}}</td> -->
										<td>{{cust.email}}</td>
										<td>{{cust.reg_dt | date : 'yyyy-MM-dd'}}</td>    
	 									<td>{{cust.membership_yn}}</td> 
	 									<td ng-if="cust.membership_yn == 'Y'" >{{cust.from_dt | date : 'yyyy-MM-dd'}} ~ {{cust.to_dt | date : 'yyyy-MM-dd'}}</td> 
	 									<td ng-if="cust.membership_yn == 'N'" ></td> 
									</tr>
									</tbody>  
								</table>
							</div><!-- //cstm_tablescroll --> 
						</div><!-- //customer_detail -->
						
						<p class="cstm_psnotice">  
							* 모바일에선 table 좌우 스크롤이 가능 합니다. 
						</p>
					</div><!-- //cstm_boxwrap -->
				</div> <!-- //contents -->    
			</div><!-- //contents_wrap --> 
		</div><!-- //container-->   
	</div>
</div>
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
 

