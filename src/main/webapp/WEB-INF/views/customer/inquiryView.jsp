<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="../include/header.jsp" flush="false"/>
<script>

	app.controller("inquiryViewCtl", function($scope, consts, common) {
		//inquiryService.setScope($scope);
		
		$scope.init = function(){
	 		$d = {"baseParms":{write_no:"${param.write_no}"},
	 				"actionList":[
					{"actionID":"bbs_inquiry_info", "actionType":"select" , "tableName": "INQUIRY_VIEW" ,"parmsList":[{}]},
					{"actionID":"bbs_inquiry_reply", "actionType":"select" , "tableName": "INQUIRY_REPLY" ,"parmsList":[{}]},
					{"actionID":"bbs_file_list", "actionType":"select" , "tableName": "INQUIRY_FILE" ,"parmsList":[{}]}
					
	 			 ]};

	 	   	common.callActionSet($d, function(data, status){
				$scope.inquiry = data["tables"]["INQUIRY_VIEW"]["rows"][0];
				$scope.replyList = data["tables"]["INQUIRY_REPLY"]["rows"];
				$scope.fileList = data["tables"]["INQUIRY_FILE"]["rows"];
			});
		};
		
	});

</script>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container" ng-controller="inquiryViewCtl" data-ng-init="init()">
			<div class="sub_menu_wrap menu06">
				<div class="sub_menu">
					<jsp:include page="../include/customerSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>1대1문의</h2>
                        <p>한국 근현대 및 고미술 그리고 해외미술에 문의하신 작품은 경매 진행 가능 여부를 검토 후, 7일 이내에 답변을 드리고 있습니다. </p>
					</div>
					<div class="board_read">
						<div class="title">{{inquiry.TITLE}}</div>
						<div class="info">
							<ul>
								<li>
									<span>문의종류 : </span>
									<span>{{inquiry.P_CATE_NM}}</span> <span ng-if="inquiry.CATE_NM != ''"> / {{inquiry.CATE_NM}} </span>
								</li>
								<li>
									<span>담당자 : </span>
									{{inquiry.EMP_NAME}}
								</li>
								<li>
									<span>처리현황 : </span>
									<!--  <span>{{inquiry.EMP_READ_YN == 'Y' ? '<spring:message code="label.membership.inqueryread" />' : '<spring:message code="label.membership.inquerynotread" />'}}</span> -->
									<span>{{inquiry.REPLY_YN == 'Y' ? '<spring:message code="label.membership.inqueryread" />' : '<spring:message code="label.membership.inquerynotread" />'}}</span>
								</li>
								<li>
									<span>최종답변일 : </span>
									<span>{{inquiry.LAST_REPLY_DT | date:'yyyy-MM-dd'}}</span>
								</li>
							</ul>
						</div>
						<div class="cont">
							<div class="area question">
								<div class="tit">
									<span class="sp_icon bul_question">
										<span class="hidden">질문</span>
									</span>
									회원님 질문내용
									<span class="bar_space02">{{inquiry.REG_DT | date:'yyyy-MM-dd'}}</span></div>
								<div class="txt" ng-bind-html="inquiry.CONTENT"></div>
								<div class="file_area" ng-if="fileList.length > 0">
									<p class="ico_file">첨부파일</p>
									<span ng-repeat="file in fileList">
									<a href="/fileDownload?fileName={{file.FILE_NAME}}&path={{file.FILE_PATH}}/&orgName={{file.FILE_NAME_ORG | urlEncode}}">{{file.FILE_NAME_ORG}}</a>&nbsp;&nbsp;
									</span>
								</div>
							</div>
							<div class="area answer" ng-repeat="reply in replyList">					
								<div class="tit">
									<span class="sp_icon bul_answer">
										<span class="hidden">답변</span>
									</span>
									<strong>{{reply.EMP_NAME}}</strong> 담당자 답변내용 <span class="bar_space02">{{reply.REG_DT | date:'yyyy-MM-dd'}} </span>
								</div>
								<div class="txt" ng-bind-html="reply.CONTENT"></div>
							</div>
						</div>
					</div>
					<div class="btn_wrap link">
						<div class="right">
							<span class="btn_style01 white02 icon btn_list mbtn">
								<span class="ico list"></span>
								<a href="/customer/inquiryList">
									<span>목록</span>
								</a>
							</span>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />