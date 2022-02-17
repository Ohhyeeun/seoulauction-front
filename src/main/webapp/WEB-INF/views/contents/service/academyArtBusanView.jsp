<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>

<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="/js/angular/paging.js"></script>

<script>
$(document).ready(function(){
	
});

app.controller('academyListCtl', function($scope, consts, common, is_login) {
	$scope.is_login = is_login;
	$scope.loadAcademyList = function($page){

 		$d = {"baseParms":{"academy_cd": "artbusan","academy_no": "${academy_no}"},  //
 				"actionList":[
				{"actionID":"get_academy_view", "actionType":"select" , "tableName": "ACADEMY_VIEW" ,"parmsList":[]},
				{"actionID":"get_academy_now_count", "actionType":"select" , "tableName": "ACADEMY_LIST_NOW_CNT" ,"parmsList":[{"for_count":true}]}
 			 ]};

 	   	
 	   common.callActionSet($d, $s);	}
 		
 	var $s = function(data, status) { 
 		$scope.academyView = data["tables"]["ACADEMY_VIEW"]["rows"];
 		$scope.academyViewRow = data["tables"]["ACADEMY_VIEW"]["rows"][0];
 		$scope.academyNewCnt = data["tables"]["ACADEMY_LIST_NOW_CNT"]["rows"][0];
 		
 		$scope.db_now = $scope.academyViewRow.DB_NOW;
	};
});
</script>

<%-- YDH 추가 끝--%>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap" ng-controller="academyListCtl" data-ng-init="loadAcademyList(1)">
		
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../include/serviceSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2" style="padding-top:30px;">
						<h2>예술소요(부산)</h2>						
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
												<!--  {{art.CONTENTS_JSON[locale]}}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->												
												<span ng-bind-html="art.CONTENTS_JSON[locale]" ></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<br />
																									
												<span ng-if="art.ACADEMY_COMPLETE == 0 && is_login=='true' && (art.ACADEMY_PAY !=null && art.ACADEMY_PAY != 0) && art.TO_DT.substring(0,10) > db_now" class="btn_style01 white02" style="margin-top:10px;">
													<a href="service/page?view=academyApplication&?academy_no={{art.ACADEMY_NO}}" ><span ng-if="locale=='ko'">결제하기</span></a> 
												</span><!--결제하기-로그인O-->	
												<span ng-if="art.ACADEMY_COMPLETE == 0 && is_login=='false' && (art.ACADEMY_PAY !=null && art.ACADEMY_PAY != 0) && art.TO_DT.substring(0,10) > db_now" class="btn_style01 white02 reqBtn" style="margin-top:10px;">
													<a>결제하기</span></a> 
												</span><!--결제하기-로그인X-->	
												 <span ng-if="art.ACADEMY_COMPLETE > 0 && is_login=='true' && (art.ACADEMY_PAY !=null && art.ACADEMY_PAY != 0)" class="btn_style01 white02" style="margin-top:10px;">
													<a ><span ng-if="locale=='ko'">결제완료</span></a> 
												</span>
										</span>																			
									</div>	
                                <div style="padding-top:30px;">
                                <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{art.IMG_VIEW_PATH}}/{{art.VIEW_FILE_NAME}}" alt='ART &amp; AUCTION' width="100%"/>
                                </div>
							</li>
						</ul>
					</div>
					 
					<%-- YDH 추가 끝--%>
				</div>
			</div>

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/img/img_menu03.jpg" alt="" class="img_master">
						</li>
					</ul>
				</div>
			</div>-->
		</div>
	</div>
</div>

<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />