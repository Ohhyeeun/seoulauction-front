<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<link href="<c:url value="/css/old/onepcssgrid_new.css" />" rel="stylesheet">

<script type="text/javascript" src="/js/angular/paging.js"></script>
<script>

app.requires.push("bw.paging");

app.controller('academyListCtl', function($scope, consts, common) {
	$scope.pageRows = 10; 
	$scope.currentPage = 1;
	$scope.academyCnt = 0;
	var cust_no = ${CUST_NO};
	console.log(cust_no);
	
 	$scope.loadAcademyList = function($page){
 		$scope.currentPage = $page;
 		$scope.parmsList1 = [];

 		$d = {"baseParms":{"cust_no": cust_no },
 				"actionList":[
              	{"actionID":"get_academy_reqlist", "actionType":"select" , "tableName": "ACADEMY_LIST" ,"parmsList":[]}
 			 ]};

 	   common.callActionSet($d, $s);
	}
 		
 	var $s = function(data, status) { 
 		$scope.academyList = data["tables"]["ACADEMY_LIST"]["rows"];
 		$("#academyCount").html($scope.academyList.length);
	};
});


</script>


<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="academyListCtl" data-ng-init="loadAcademyList(1)"> <!--  ng-repeat="art in academyList" -->
		
		<div id="container" >
			<div class="sub_menu_wrap menu06">
				<div class="sub_menu">
					<jsp:include page="../include/customerSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap" >
				<div class="contents">
					<div class="tit_h2" style="padding-top:20px;">
						<h2><spring:message code="label.mypage.academylist" /></h2>
					</div>
                    <p style="font-size:12px; line-height:18px;" ng-if="locale!='ko'">※ Classes are held only in Korean.</p>
                    <p style="font-size:12px; line-height:18px;">※ 신청내역을 확인 후 결제하여 주시기 바랍니다.</p>
                    <p style="font-size:12px; line-height:18px; color:#F00">※ 수업 시작 후에는 환불이 불가합니다. </p>
                    <!--<p style="font-size:12px; line-height:18px;">입금 계좌안내 : 우리은행 1005-701-016159 (주)서울옥션</p>
                    <p style="font-size:12px; line-height:18px;">입금자명이 본인 성함과 다를 시 입금자명을 알려주시기 바랍니다.</p>-->
                    <p style="font-size:12px; line-height:18px;">문의 : 02-2075-4466, 02-545-0330(강남센터)</p>
                    <span class="btn_style01 icon02" ng-if="locale=='ko'" style="margin-top:10px; margin-bottom:30px;"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
                    <span class="btn_style01 icon02" ng-if="locale!='ko'" style="margin-top:10px; margin-bottom:30px;"><a href="/customer/inquiryForm" class="fix">Inquiry</a><span class="ico next02"></span></span>
                      
					<div style="padding-bottom:20px;">
							<div class="txt">총 <span class="txt_green" id="academyCount"></span>건의 내역이 있습니다.</div>
					</div>
                    
                    
                    <div class="onepcssgrid-1200" style="border-bottom:#e4e4e4 1px solid;" ng-repeat="art in academyList">
                    
                        <div style="border-top:#333 2px solid; border-bottom:#e4e4e4 1px solid; padding-top:20px; padding-bottom:20px;">
                            <h2 style="font-weight:600; font-size:20px;">{{art.TITLE_JSON[locale]}}</h2>
                        </div>
                        
                        <div class="col4" style="padding-top:20px; padding-bottom:20px;">
                            <p style="padding-bottom:5px;font-size:14px; line-height:28px;">
                            성함 : {{art.CUST_NAME}}<br/>
                            이메일 : {{art.EMAIL}}<br/>
                            휴대폰 : {{art.HP}}<br/>
                            </p>
                             <p style="padding-bottom:5px; font-size:12px; color:#F30;">※ 신청하신분의 정보가 정확한지 확인해 주시기 바랍니다.</p>
                              <div style="clear:both;"></div>
                        </div>
                        
                        <div class="col4" style="padding-top:20px; padding-bottom:20px;">
                            <p style="padding-bottom:5px;font-size:14px; line-height:28px;">
                            수강료 : <span ng-bind="art.ACADEMY_PAY | number : 0"></span> (부가세포함)<br/>
                            신청일시 : {{art.REG_DT | date:'yyyy-MM-dd'}}
                            </p>
                            <div style="clear:both;"></div>
                        </div>
                        
                        <div class="col4 last" style="padding-top:20px; padding-bottom:20px;">
                            <p style="padding-bottom:5px;font-size:14px; line-height:28px;">
                            총결제액 : <span ng-bind="art.ACADEMY_PAY | number : 0"></span> (부가세포함)<br/>
                            결제현황 : <span>
                                          <!-- <span>결제전</span> -->
                                          <span ng-if="art.CANCEL_YN === 'Y'" style="color: #FF3300;">결제취소</span>
                                          <span ng-if="art.CANCEL_YN === 'N'">결제완료</span>
                                      </span>
                                      <br/>
                           <!--  결제방법 : 신용카드 -->
                            </p>
                            <!-- <span class="btn_style01" style="padding:3px 20px 3px 20px; background-color:#F60;">
                                <button type="button" ng-click="showPurchasePopup(lot.LOT_NO, lot.SALE_NO);" style="color:#FFF; font-size:14px; font-weight:700;">결제하기</button>
                            </span> -->
                            <div style="clear:both;"></div>
                        </div>
                        <div class="onerow"></div>

  
                        
                    </div><!--onepcssgrid-1200-->
				</div><!--contents-->
			</div><!--contents_wrap-->

			
		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />