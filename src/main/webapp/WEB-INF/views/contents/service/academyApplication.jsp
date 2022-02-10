<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>

<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link href="<c:url value="/resources/css/old/onepcssgrid_new.css" />" rel="stylesheet">
<link href="/resources/css/angular/ngDialog.css" rel="stylesheet">
<link href="/resources/css/angular/popup.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> <!-- //달력 플러그인 css-->

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script src="/resources/js/angular/checklist-model.js"></script>
<script type="text/javascript" src="/resources/js/join.js?${resources.timestamp}"></script> 


<script>


$(document).ready(function(){
});

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
 	 	    	$scope.academyuserinfo = data["tables"]["ACADEMY_USERINFO"]["rows"][0];
 	 	    	
 	 	    	$("#aca_name").val($scope.academyuserinfo.CUST_NAME);
 	 	    	$("#aca_myday").val($scope.academyuserinfo.BORN_DT);
 	 	    	$("#aca_hp").val($scope.academyuserinfo.HP);
 	 	    	$("#aca_mail").val($scope.academyuserinfo.EMAIL); 
 	 	    	
 	   		}
 	   	);
 	   	
	}
	
	
	$scope.showPurchasePopup = function(academy_pay){
		
		if($scope.total_aca_pay){
			academy_pay = $scope.total_aca_pay;
		}
		
		console.log(academy_pay);
		console.log(academy_no);
		
		window.open('/customer/payAcademyRequest?academy_pay='+academy_pay+'&academy_no='+academy_no,'popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0');
	};
	
	
	$scope.discountSum = function(academy_pay){
		
		var aca_rename = $("#aca_rename").val();
		var aca_rehp = $("#aca_rehp").val();
		
		if(!aca_rename){
			alert("추천인 성함을 입력해주세요");
		}
		if(!aca_rehp){
			alert("추천인 번호를 입력해주세요");
		}
		
		var aca_pay = $("#aca_pay").val();
		var aca_pay_sum = aca_pay.replace(/,/g, '');
		var dis_aca_pay = parseInt(aca_pay_sum)*0.05;
		
		
		$scope.total_dis_aca_pay = dis_aca_pay;
		$scope.total_aca_pay = aca_pay_sum-dis_aca_pay;
		
		console.log($scope.total_dis_aca_pay);
		console.log($scope.total_aca_pay);
		
		
		$("#aca_dcpay").val(comma($scope.total_dis_aca_pay));
		$("#aca_totalpay").val(comma($scope.total_aca_pay));
		
	};
});






</script>

<%-- YDH 추가 끝--%>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
    <div class="container_wrap" ng-controller="academyListCtl" data-ng-init="loadAcademyList(1)" >
		
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../include/serviceSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->
			
            <div ng-controller="joinCtl" data-ng-init="init();" ng-repeat="art in academyList">
                <div class="contents_wrap">
                    <div class="contents">
                   		<div class="tit_h2" style="padding-top:30px;"> 
							<h2><spring:message code="label.mypage.academylistlist" /></h2> 					
						</div> 
						
						<div class="storage_cont title_area">  
						<div class="line"></div>  
							<div class="culture_grid_wrap clearcontents">
					            <div class="culture_grid_box register_academy_thum clearcontents">     
					                <div class="culture_box" style="width: auto;">    
				                        <div class="culture_img resize-img">    
				                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{art.IMG_PATH}}/{{art.FILE_NAME}}" alt="문화예찬 썸네일 이미지" title="문화예찬 썸네일 이미지">
				                        </div>
				                     
				                        <div class="culture_caption" style="text-align:center; height: auto;">      
				                            <p>
				                            	{{art.TITLE_JSON[locale]}}
				                            </p>
				                            <p>  
				                               {{art.FROM_DT}} ~ {{art.TO_DT}}
				                            </p> 
				                            <p>
				                                {{art.ACADEMY_TIME}} 
				                            </p>   
				                        </div><!--//cultuer_caption-->
									</div> 
					            </div><!--culture_grid_box-->  
								
								<div class="aca_form_box_wrap">   
									<div class="aca_form">      
										<form action=""> 
											<fieldset class="aca_form_box culture_grid_box01">      
												<legend>신청 정보 (본인)</legend>      
													<div>    
														<label for="aca_name" class="culture_grid_box01">성함 </label><input type="text" name="aca_name" id="aca_name" readonly style="cursor:auto;">  
													</div>
													<div> 
														<label for="aca_myday">생년월일</label><input type="text" name="aca_myday" id="aca_myday" readonly style="cursor:auto;">          
													</div>
													<div> 
														<label for="aca_hp">휴대폰</label><input type="tel" name="aca_hp" id="aca_hp" readonly style="cursor:auto;"> 
													</div> 
													<div>     
														<label for="aca_mail">이메일</label><input type="email" name="aca_mail" id="aca_mail" readonly style="cursor:auto;">   
													</div>   
											</fieldset>      
											
											<!-- <fieldset class="aca_form_box culture_grid_box01">        
												<legend>신청 정보 (추천인)</legend>  
													<div>
														<label for="aca_rename">성함 </label><input type="text" name="aca_rename" id="aca_rename" placeholder="추천인 성함">
													</div>
													<div> 
														<label for="aca_rehp">휴대폰</label><input type="tel" name="aca_rehp" id="aca_rehp" placeholder="010-0000-0000"> 
													</div> 
													<div class="academy_btn ac_regitor_btn">       
								                        <a class="btn_style01 white" ng-click="discountSum();">    
															<span>추천인 추가</span>   
														</a>          
													</div> 
											</fieldset>    -->	   
										</form>
									</div> 
									
									<div class="aca_form">      
										<form action=""> 
											<fieldset class="aca_form_box culture_grid_box01">     
												<legend>결제 금액</legend>      
													<div>
														<label for="aca_pay">수강료</label><input type="text" name="aca_pay" id="aca_pay" readonly style="cursor: auto;" ng-model="art.ACADEMY_PAY | number : 0">  
													</div>
													<div> 
														<label for="aca_dcpay">할인금액</label><input type="text" name="aca_dcpay" id="aca_dcpay" readonly style="cursor: auto;">
													</div>
													<div>    
														<label for="aca_totalpay" style="color:#F00;">총 결제 금액</label><input type="text" name="aca_totalpay" id="aca_totalpay" readonly style="cursor: auto;" ng-model="art.ACADEMY_PAY | number : 0"> 
													</div> 
													<div class="academy_btn ac_regitor_btn">   
								                        <a class="btn_style01 white" style="margin-top:10px;" ng-click="showPurchasePopup(art.ACADEMY_PAY);">   
															<span>결제하기</span>  
														</a>          
													</div>    
											</fieldset>        
										</form>
									</div>   
								</div> <!-- //aca_form_box_wrap -->
							</div>
							
							<div class="academy_paynotice">   
		                        <p style="font-size:12px; line-height:18px;">※ 신청내역을 확인 후 결제하여 주시기 바랍니다.</p> 
		                        <p style="font-size:12px; line-height:18px; color:#F00">※ 수업 시작 후에는 환불이 불가합니다. </p>
		                        <p style="font-size:12px; line-height:18px;">문의 : 02-2075-4466, 02-545-0330(강남센터)</p> 
		                        <span class="btn_style01 icon02"  style="margin-top:10px; margin-bottom:30px;"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
	    					</div> 
                        </div><!--//storage_cont title_area-->
                    </div><!--contents-->
                </div><!--contents_wrap-->
			</div>
		</div>	
    </div>   
</div>

<script> /* 달력 플러그인 */     
	$(function(){
		$("#aca_myday").datepicker({ 
			dateFormat: 'yy년 mm월 dd일'      
            ,showOtherMonths: true  
            ,showMonthAfterYear:true  
            ,changeYear: true
            ,changeMonth: true   
            ,yearSuffix: "년"
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']   
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] 
            ,dayNamesMin: ['일','월','화','수','목','금','토'] 
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']    
		    ,yearRange: 'c-100:c+5'   
		    ,showButtonPanel: true  
		    ,closeText: '닫기' 
		});   
	});
</script>
 
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />