<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../../include/header.jsp" flush="false"/>

<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script>

app.value('locale', 'ko');
app.requires.push("bw.paging");
app.controller("recuitListCtl", function($scope, consts, common, locale) {
	$scope.pageRows = 20; 
	$scope.reqRowCnt = 20;
	$scope.currentPage = 1;
	$scope.totalCount = 0;
	$scope.locale = locale;
	$scope.recruitment_no = (getParameter("recruitment_no"));

	$scope.loadrecuitDetail = function($page) {

		$scope.currentPage = $page;
	$d = {
			"baseParms" : {	"recruitment_no" : $scope.recruitment_no},
			"actionList" : [ 
				{"actionID" : "get_recruit_detail","actionType" : "select","tableName" : "RECRUIT_DETAIL","parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt)}]} 
				
		]};

		$d["actionList"][0]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 
		common.callActionSet($d, $s);
	}

	var $s = function(data, status) {
		$scope.recuitDetail = data["tables"]["RECRUIT_DETAIL"]["rows"][0];
	};
	
	
	 
});

</script>

<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container" ng-controller="recuitListCtl" data-ng-init="loadrecuitDetail(1);">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
                    <jsp:include page="../../contents/include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">	 
				<div class="contents"  style="min-height:700px; overflow:visible;">	 
					<div class="tit_h2">
						<h2>채용공고</h2> 
					</div>
					<div class="board_read type02">
						<div class="title" ng-bind="recuitDetail.recruitment_title"></div>
						<div class="info" ng-if="recuitDetail.recruitment_form_file_name_org != ''">
							<strong>입사지원서 :</strong> 
							<a class="recruit_btn" href="/nas_img/{{recuitDetail.recruitment_form_file_path}}/{{recuitDetail.recruitment_form_file_name}}">
								<strong>다운받기</strong>    
							</a>  
						</div>
						<div class="cont recruit_cont" style="line-height:28px;">
							<p ng-if="recuitDetail.recruitment_dt_none == 'N'">
                        		<strong>채용기간 :</strong> <span ng-bind="recuitDetail.recruitment_from_dt | date:'yyyy-MM-dd'"></span> ~ <span ng-bind="recuitDetail.recruitment_to_dt | date:'yyyy-MM-dd'"></span> 
                        	</p> 
                        	<p ng-if="recuitDetail.recruitment_dt_none == 'Y'">
                        		<strong>수시채용</strong>  
                        	</p> 
                        	<p>
                        		<span ng-bind-html="recuitDetail.MEMO_JSON[locale]"></span>
                        	</p>
                        	<br>
                        	<br>
                        	<img ng-if="recuitDetail.recruitment_img_file_path" src="/nas_img/{{recuitDetail.recruitment_img_file_path}}/{{recuitDetail.recruitment_img_file_name}}" alt="서울옥션 채용공고 이미지" title="서울옥션 채용공고 이미지" style="max-width: 100%; max-height: 100%;"> 
						</div> 
					</div> 
				</div>
			</div>

		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />