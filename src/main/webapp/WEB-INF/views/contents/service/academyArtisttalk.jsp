<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>

<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>

<script>
$(document).ready(function(){
	
});

app.requires.push("bw.paging");

app.controller('academyListCtl', function($scope, consts, common, is_login, locale) {
	$scope.pageRows = 8; 
	$scope.reqRowCnt = 8;
	$scope.currentPage = 1;
	$scope.totalCount = 0;
	$scope.is_login = is_login;
	
 	$scope.loadAcademyList = function($page){
 		$scope.currentPage = $page;
 		$scope.parmsList1 = [];

 		$d = {"baseParms":{"academy_cd":"artisttalk"},
 				"actionList":[
				{"actionID":"get_academy_cnt", "actionType":"select" , "tableName": "ACADEMY_LIST_CNT" ,"parmsList":[{"for_count":true}]},
              	{"actionID":"get_academy_list", "actionType":"select" , "tableName": "ACADEMY_LIST" ,"parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt)}]}, 
              	{"actionID":"get_academy_now_count", "actionType":"select" , "tableName": "ACADEMY_LIST_NOW_CNT" ,"parmsList":[{"for_count":true}]},
              	{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]}
 			 ]};

 	   	$d["actionList"][1]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 

 	   common.callActionSet($d, $s);
	}
 		
 	var $s = function(data, status) { 
 		$scope.totalCount = data["tables"]["ACADEMY_LIST_CNT"]["rows"][0]["CNT"];
 		$scope.academyList = data["tables"]["ACADEMY_LIST"]["rows"];
 		$scope.academyListRow = data["tables"]["ACADEMY_LIST"]["rows"][0];
 		$scope.academyNewCnt = data["tables"]["ACADEMY_LIST_NOW_CNT"]["rows"][0];
 		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
 		
 		$scope.db_now = $scope.academyListRow.DB_NOW;		
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
						<h2><spring:message code="label.academy.artisttalk" /></h2>						 
					</div>
					
					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="culture_grid_wrap clearcontents"> 
	                   		<!--//내용 반복-->   
				            <div class="culture_grid_box clearcontents" ng-repeat="academyList in academyList">   
				                <div class="culture_box" style="cursor: pointer" ng-if="custInfo.EMP_GB == 'Y'"> 
				                	<a href="/academyArtisttalkView?academy_no={{academyList.ACADEMY_NO}}" class="culture_grid_a" >   
				                        <div class="culture_img resize-img"> 
				                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}">   
				                            <div class="culture_img_hover">
				                            </div> 
				                            <div class="culture_img_icon">
				                                <i class="material-icons"> 
				                                    loupe 
				                                </i>
				                            </div> 
				                        </div>
				                     
				                        <div class="culture_caption">
				                            <p>
				                                {{academyList.TITLE_JSON[locale]}}
				                            </p>
				                            <div class="culture_btn_box">
				                                <a class="culture_btn" href="/academyArtisttalkView?academy_no={{academyList.ACADEMY_NO}}" target="_new">상세보기</a>
				                            </div> 
				                        </div><!--//cultuer_caption-->
				                    </a> 
								</div> 
								
								<div class="culture_box" style="cursor: pointer" ng-if="custInfo.EMP_GB != 'Y'"> 
				                	
				                	<div ng-if="academyList.TO_DT.substring(0,10) > db_now">
				                	<a href="/academyArtisttalkView?academy_no={{academyList.ACADEMY_NO}}" class="culture_grid_a" >   
				                        <div class="culture_img resize-img"> 
				                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}" >   
				                            <div class="culture_img_hover">
				                            </div> 
				                            <div class="culture_img_icon">
				                                <i class="material-icons"> 
				                                    loupe 
				                                </i>
				                            </div> 
				                        </div>
				                     
				                        <div class="culture_caption">
				                            <p>
				                                {{academyList.TITLE_JSON[locale]}}
				                            </p>
				                            <div class="culture_btn_box">
				                                <a class="culture_btn" href="#" target="_new">상세보기</a>
				                            </div> 
				                        </div><!--//cultuer_caption-->
				                    </a> 
				                    </div>
				                    
				                    <div ng-if="academyList.TO_DT.substring(0,10) < db_now">
				                    <a href="#" class="culture_grid_a"  >   
				                        <div class="culture_img resize-img"> 
				                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}" >   
				                            <div class="culture_img_hover">
				                            </div> 
				                            <div class="culture_img_icon">
				                                <i class="material-icons"> 
				                                    loupe 
				                                </i>
				                            </div> 
				                        </div>
				                     
				                        <div class="culture_caption">
				                            <p>
				                                {{academyList.TITLE_JSON[locale]}}
				                            </p>
				                            <div class="culture_btn_box">
				                                <a class="culture_btn" href="#" target="_new">상세보기</a>
				                            </div> 
				                        </div><!--//cultuer_caption-->
				                    </a> 
				                    </div>
								</div>
								
				            </div><!--culture_grid_box-->
			            </div><!-- //culture_grid_wrap -->    
			            
					<div class="wrap_paging">
							<!-- S : paging 영역 -->
							<paging page="currentPage" 
							page-size="pageRows"
								total="totalCount" 
								adjacent="10"
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
								text-last-class="page_btn sp_btn btn_next"> 
								</paging>
							<!-- E : paging 영역 -->
							<div class="right">
								<span class="btn_style01 icon02 btn_scrolltop mbtn">
									<button type="button">
										<span>위로</span>
									</button> <span class="ico up"></span>
								</span>
							</div>
						</div>
					<%-- YDH 추가 끝--%>	
				</div> 
					
				</div><!-- //contents -->
			</div> <!-- //contents_wrap -->

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
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />