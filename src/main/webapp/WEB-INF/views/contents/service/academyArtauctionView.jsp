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

 		$d = {"baseParms":{"academy_cd": "artauction","academy_no": "${academy_no}"},  //
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
						<h2><spring:message code="label.academy.artauction" /></h2>		 		 		 
					</div>
					
					<div class="storage_cont title_area">
						<div class="line"></div> 
						<div class="culture_wrap clearcontents" ng-repeat="art in academyView">  
		                    <div class="culture_detail_warp"> 
		                        <div class="culture_detail_box culture_detail_caption"> 
		                            <p class="tit">  
		                                {{art.TITLE_JSON[locale]}}<br>
		                                {{art.FROM_DT}} ~ {{art.TO_DT}}	<br> 
		                                	{{art.ACADEMY_TIME}} 
		                            </p>  
		                            <p ng-bind-html="art.CONTENTS_JSON[locale]">
		                            </p>    
			                        <div class="academy_btn">     
				                        <span class="btn_style01 white" ng-if="art.ACADEMY_COMPLETE == 0 && is_login=='true' && art.CLOSE_YN != 'Y' && (art.ACADEMY_PAY !=null && art.ACADEMY_PAY != 0) && art.TO_DT.substring(0,10) > db_now">  
											<a href="/service/page?view=academyApplication&academy_no={{art.ACADEMY_NO}}"><span>신청하기</span></a>      
										</span> 
										<span ng-if="is_login == 'false' && art.CLOSE_YN != 'Y'" class="btn_style01 white" style="margin-top:10px;" onClick="alert('로그인을 해주시기 바랍니다.\n Please login for use.')">  
											<a href="#"><span>결제하기</span></a>       
										</span>   
										<span ng-if="art.CLOSE_YN == 'Y'" class="btn_style01 white" style="margin-top:10px;" >  
											<a href="#"><span>수강 모집 완료</span></a>      
										</span>   
										<span ng-if="art.ACADEMY_COMPLETE > 0 && is_login=='true' && (art.ACADEMY_PAY !=null && art.ACADEMY_PAY != 0)" class="btn_style01 white" style="margin-top:10px;" >  
											<a href="#"><span>결제완료</span></a>      
										</span>       
									</div>   
		                        </div>
		                        <div class="culture_detail_box culture_detail_img resize-img">    
                                	<a href="<spring:eval expression="@configure['img.root.path']" />{{art.IMG_VIEW_PATH}}/{{art.VIEW_FILE_NAME}}" target="_blank">
			                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{art.IMG_VIEW_PATH}}/{{art.VIEW_FILE_NAME}}" >
                                    </a>  
		                        </div>	
		                    </div><!--//culture_detail_box--> 
		                       
		                </div><!--//공통 culture_rap--> 
					</div>    
					
					<%-- YDH 추가 끝--%>	
				</div><!-- //contents --> 
			</div><!-- //contents_wrap -->

			
		</div>
	</div>
</div>

<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />