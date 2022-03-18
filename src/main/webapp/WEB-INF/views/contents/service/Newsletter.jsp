<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<link href="<c:url value="/css/old/common.css" />" rel="stylesheet">
<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="/js/angular/paging.js"></script>

<script>
app.value('locale', 'ko');
	app.requires.push("bw.paging");
	app.controller('newLetterListCtl', function($scope, consts, common, locale) {

		$scope.pageRows = 20; 
		$scope.reqRowCnt = 20;
		$scope.currentPage = 1;
		$scope.totalCount = 0;
		$scope.locale = locale;
		$scope.date = 202003;
		
		$scope.loadNewletterList = function($page) {
			$scope.currentPage = $page;
		$d = {
				"baseParms" : {	"arg_str" : "" },
				"actionList" : [ 
					{"actionID" : "get_newletter_list","actionType" : "select","tableName" : "NEWLETTER_LIST","parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt)}]}, 
					{"actionID" : "get_newletter_list_count","actionType":"select" , "tableName": "NEWLETTER_CNT" ,"parmsList":[{"for_count":true}]},					
					
			]};

			$d["actionList"][0]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 
			common.callActionSet($d, $s);
		}

		var $s = function(data, status) {
			$scope.newletterList = data["tables"]["NEWLETTER_LIST"]["rows"];
			console.log($scope.newletterList);
			$scope.totalCount = data["tables"]["NEWLETTER_CNT"]["rows"][0]["CNT"]; 
		};
		
		
	});
</script>

    
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap" ng-controller="newLetterListCtl" data-ng-init="loadNewletterList(1)">
	
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
					<div class="tit_h2">
						<h2>뉴스레터</h2> 
					</div>   
					
					<div class="storage_cont title_area">
						<div class="line"></div>
					</div>    
					 
					<!-- newsletter contents 내용 -->   
					<div class="newsletter_contentsbox" >
						<div class="newsletter_gridwrap" style="cursor:pointer;" ng-repeat="newletterList in newletterList" ng-if="newletterList.NEWLETTER_TITLE_KO"> 
							<div class="newsletter_gridbox" ng-if=" date == newletterList.NEWSLETTER_DATE">
								<a href="/nas_img/front/homepage/newsletter/{{newletterList.NEWSLETTER_DATE}}/{{newletterList.NEWSLETTER_DATE}}.html">
									<div class="newsletter_gridbox_imgbox"> 
										<div class="newsletter_gridbox_img"> 
											<img src="https://www.seoulauction.com/nas_img/{{newletterList.FILE_PATH}}/{{newletterList.FILE_NAME}}" alt="뉴스레터 이미지사진"/>
											<!-- img 예시 --> 
										</div> 
									</div>    
									<div class="newsletter_gridbox_infor"> 
										<h3 class="newsletter_headline txt-over" ng-if="locale=='ko'">{{newletterList.NEWLETTER_TITLE_KO}} </h3>     
										<h3 class="newsletter_headline txt-over" ng-if="locale=='en'">{{newletterList.NEWLETTER_TITLE_EN}} </h3>    
										<div class="newsletter_headline_txt" style="padding: 10px 10px 20px; height: 85px;">
											<span class="newsletter_back"></span>   
<pre class="newsletter_summary txt-over" style="white-space:pre;">
{{newletterList.NEWSLETTER_MEMO}}
</pre><!-- 공백,여백 때문에 붙여놓음 --> 
											<p style="font-weight:bold; border-top:2px solid #ccc; font-size: 12px; margin-top: 20px; padding: 20px 10px 0; text-align: center;"> 
												{{newletterList.NEWSLETTER_DATE}}
											</p>  
										</div>
									</div> 
								</a>
							</div>
							
							<div class="newsletter_gridbox" ng-if=" date != newletterList.NEWSLETTER_DATE">
								<a href="/nas_img/front/homepage/newsletter/{{newletterList.NEWSLETTER_DATE}}/KOR/{{newletterList.NEWSLETTER_DATE}}_KOR.html">
									<div class="newsletter_gridbox_imgbox"> 
										<div class="newsletter_gridbox_img"> 
											<img src="https://www.seoulauction.com/nas_img/{{newletterList.FILE_PATH}}/{{newletterList.FILE_NAME}}" alt="뉴스레터 이미지사진"/>
											<!-- img 예시 --> 
										</div> 
									</div>    
									<div class="newsletter_gridbox_infor"> 
										<h3 class="newsletter_headline txt-over" ng-if="locale=='ko'">{{newletterList.NEWLETTER_TITLE_KO}} </h3>     
										<h3 class="newsletter_headline txt-over" ng-if="locale=='en'">{{newletterList.NEWLETTER_TITLE_EN}} </h3>    
										<div class="newsletter_headline_txt" style="padding: 10px 10px 20px; height: 85px;">
											<span class="newsletter_back"></span>   
<pre class="newsletter_summary txt-over" style="white-space:pre;">
{{newletterList.NEWSLETTER_MEMO}}
</pre><!-- 공백,여백 때문에 붙여놓음 --> 
											<p style="font-weight:bold; border-top:2px solid #ccc; font-size: 12px; margin-top: 20px; padding: 20px 10px 0; text-align: center;"> 
												{{newletterList.NEWSLETTER_DATE}}
											</p>  
										</div>
									</div> 
								</a>
							</div>
							
							
						</div> <!-- //newsletter_gridwrap -->   
					</div><!-- //newsletter_contentsbox -->
					
				</div><!-- //newsletter_contents --> 
				
			</div><!-- //contents_wrap -->
			<div class="wrap_paging">
						<paging page="currentPage"
								page-size="pageRows"
								total="totalCount"
								paging-action="loadNewletterList(page)"
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
						<div class="right">
							<span class="btn_style01 icon02 mbtn btn_scrolltop">
								<button type="button"><spring:message code="label.move.top" /></button>
								<span class="ico up"></span>
							</span>
						</div>
					</div>
			
		</div><!-- //container -->
	</div> 
</div><!-- //wrap -->
	
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />