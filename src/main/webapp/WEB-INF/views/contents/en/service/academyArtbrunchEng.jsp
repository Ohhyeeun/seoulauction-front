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

app.requires.push("bw.paging");

app.controller('academyListCtl', function($scope, consts, common) {0
	$scope.pageRows = 10; 
	$scope.currentPage = 1;
	$scope.academyCnt = 0;
	
 	$scope.loadAcademyList = function($page){
 		$scope.currentPage = $page;
 		$scope.parmsList1 = [];

 		$d = {"baseParms":{"academy_cd":"artbrunch"},
 				"actionList":[
				{"actionID":"get_academy_cnt", "actionType":"select" , "tableName": "ACADEMY_LIST_CNT" ,"parmsList":$scope.parmsList1},
              	{"actionID":"get_academy_list", "actionType":"select" , "tableName": "ACADEMY_LIST" ,"parmsList":[{"from":0, "rows":$scope.pageRows}]},
              	{"actionID":"get_academy_now_count", "actionType":"select" , "tableName": "ACADEMY_LIST_NOW_CNT" ,"parmsList":[{"for_count":true}]}
 			 ]};

 	   	$d["actionList"][1]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 

 	   common.callActionSet($d, $s);
	}
 		
 	var $s = function(data, status) { 
 		$scope.academyCnt = data["tables"]["ACADEMY_LIST_CNT"]["rows"][0]["CNT"];
 		$scope.academyList = data["tables"]["ACADEMY_LIST"]["rows"];
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
						<h2>ART & Brunch</h2>						
					</div>

					<div>
						<ul>
							<li ng-repeat="art in academyList" ng-init="{first:$first || $index == 1}" style="padding-top:15px; padding-bottom:15px; border-bottom:dotted 1px #999999; ">
								<div class="hidden_box">
									<div >
										<span>
											<div style="float:left;">
											<a href="#" onClick="return false;" style="cursor: default;">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{art.IMG_PATH_EN}}/{{art.FILE_NAME_EN}}" alt='ART & Brunch' height="200" width="200"/>
											</a>
											</div>
										</span>	
										<span>
											<div style="padding-left:30px;float:left;">
                                                <span style="font-size:14px; line-height:24px; font-weight:600;">
												{{art.TITLE_JSON[locale]}}</span>
												<br />
												<span style="font-size:14px; line-height:24px;">{{art.FROM_DT}} ~ {{art.TO_DT}}										
												<br />
												{{art.ACADEMY_TIME}}
												<br />  
                                                </span>
	
					  							<span class="btn_style01 white02" style="margin-top:10px;"> 
													<a href="/academyArtbrunchView?academy_no={{art.ACADEMY_NO}}"><spring:message code="label.academy.detail" /></a>
												</span>		
											</div>
										</span>																			
									</div>	
								</div>
							</li>
						</ul>
					</div>
					<div class="wrap_paging">
						<paging page="currentPage"
								page-size="pageRows"
								total="academyCnt"
								paging-action="loadAcademyList(page)"
								scroll-top="true"
								hide-if-empty="true"
								show-prev-next="true"
								show-first-last="true"
								ul-class="page_ul"
								active-class="page_active"
							    disabled-class="page_disable"
							    text-next-class="page_btn sp_btn btn_next02"
							    text-prev-class="page_btn sp_btn btn_prev02"
							    text-first-class="page_btn sp_btn btn_prev"
							    text-last-class="page_btn sp_btn btn_next"
						>
						
						</paging>
						<div class="right">
							<span class="btn_style01 icon02 mbtn btn_scrolltop">
								<button type="button"><spring:message code="label.move.top" /></button>
								<span class="ico up"></span>
							</span>
						</div>
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