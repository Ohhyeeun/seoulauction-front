<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>

<script>
$(document).ready(function(){
	
});

app.controller('academyListCtl', function($scope, consts, common) {0
	$scope.loadAcademyList = function($page){

 		$d = {"baseParms":{"academy_cd": "artisttalk","academy_no": "${academy_no}"},  //
 				"actionList":[
				{"actionID":"get_academy_view", "actionType":"select" , "tableName": "ACADEMY_VIEW" ,"parmsList":[]},
				{"actionID":"get_academy_now_count", "actionType":"select" , "tableName": "ACADEMY_LIST_NOW_CNT" ,"parmsList":[{"for_count":true}]}
 			 ]};

 	   	
 	   common.callActionSet($d, $s);	}
 		
 	var $s = function(data, status) { 
 		$scope.academyView = data["tables"]["ACADEMY_VIEW"]["rows"];
 		$scope.academyNewCnt = data["tables"]["ACADEMY_LIST_NOW_CNT"]["rows"][0];
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

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>Artist Talk</h2>						
					</div>
					
					<div>
						<ul>
							<li ng-repeat="art in academyView" ng-init="{first:$first || $index == 1}">
									<div style="border-bottom:#CCC 1px solid; padding:10px;">
										<span style="font-size:18px; line-height:26px;">{{art.TITLE_JSON[locale]}}</span>	
												<br />
										<span style="font-size:14px; line-height:24px;">
                                                {{art.FROM_DT}} ~ {{art.TO_DT}}										
												<br />
												{{art.ACADEMY_TIME}}
												<br />
												<!--  {{art.CONTENTS_JSON[locale]}} -->
												<span ng-bind-html="art.CONTENTS_JSON[locale]" ></span>
												<br />
										</span>																			
									</div>	
                                <div style="padding-top:30px;">
                                <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{art.IMG_VIEW_PATH_EN}}/{{art.VIEW_FILE_NAME_EN}}" alt='Artist Talk' width="100%"/>
                                </div>
							</li>
						</ul>
					</div>
					 
					<%-- YDH 추가 끝--%>	
				</div>
			</div>

			
		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />