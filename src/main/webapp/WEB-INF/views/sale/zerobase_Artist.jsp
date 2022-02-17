<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:include page="../include/header.jsp" flush="false" />
<link href="<c:url value="/css/sa.common.2.1.css" />" rel="stylesheet">
<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" src="/js/angular/paging.js"></script>
<!-- script 추가 -->
<style>
	body, html{
		scroll-behavior: smooth;
	}
</style>

<script>
	app.value('locale', 'ko');
	app.requires.push("bw.paging");
	
	app.controller('artListCtl', function($scope, consts, common) {

		$scope.pageRows = 6; 
		$scope.reqRowCnt = 6;
		$scope.currentPage = 1;
		$scope.totalCount = 0;
		$scope.arg_str = "";
		
		$scope.select_zb = 'all'
		
		$scope.init = function(){
			
			$d = {
				"baseParms" : {	"arg_str" : $scope.artist },
				"actionList" : [ 
// 					{"actionID" : "zero_base_artist_count", "actionType":"select" , "tableName": "ART_CNT" ,"parmsList":[{"arg_new" : "new"}]},
// 					{"actionID" : "zero_base_artist_paging","actionType" : "select","tableName" : "ART_LIST_NEW","parmsList":[{"arg_new" : "new", "from": 0, "rows":parseInt($scope.reqRowCnt)}]},
					{"actionID" : "zero_base_artist", "actionType" : "select", "tableName" : "ART_LIST_NEW", "parmsList":[{"arg_new" : "new"}]}, 
					{"actionID" : "zero_base_sale_list", "actionType":"select" , "tableName": "ZB_SALE_LIST" ,"parmsList":[{  }]},
					{"actionID" : "get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
					
			]};
			
			common.callActionSet($d, function(data, status) {
				$scope.artListNew = data["tables"]["ART_LIST_NEW"]["rows"];
				$scope.zbSaleList = data["tables"]["ZB_SALE_LIST"]["rows"];
				$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
// 				$("#new_zerobase_title").html("adsd");
				console.log($scope.artListNew[0].SALE_TITLE_EN)
				$("#new_zerobase_title").html($scope.artListNew[0].SALE_TITLE_EN);
			});
			
			$scope.loadArtList(1, false);
		}
		
		$scope.loadArtList = function($page, scroll) {
			if(getCookie('curr_url').indexOf("zerobase_Artist") > -1){
				$page = $page;
			}else{
		 		if(getCookie('zerobase_Artist') != $page && getCookie('zerobase_Artist') > 1){
		 			$page = getCookie('zerobase_Artist');
		 		}
			}
			
			$scope.currentPage = $page;
			setCookie('zerobase_Artist', $page, 1);
			
			$d = {
				"baseParms" : {	"arg_str" : $scope.artist , "sale_no" : $scope.select_zb},
				"actionList" : [ 
					{"actionID" : "zero_base_artist_count", "actionType":"select" , "tableName": "ART_CNT" ,"parmsList":[{"arg_prev" : "prev"}]},
					{"actionID" : "zero_base_artist_paging","actionType" : "select","tableName" : "ART_LIST","parmsList":[{"arg_prev" : "prev", "from": 0, "rows":parseInt($scope.reqRowCnt)}]},
					
			]};
			
			$d["actionList"][1]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 
			common.callActionSet($d, $s);
			
			if(scroll){ fnMove(); }
		}

		var $s = function(data, status) {
			$scope.artList = data["tables"]["ART_LIST"]["rows"];
			if($scope.select_zb =="all"){
				$("#prv_zerobase_title").html("ZERO BASE");
			}else{
				$("#prv_zerobase_title").html($scope.artList[0].SALE_TITLE_EN);
			}
			
			$scope.totalCount = data["tables"]["ART_CNT"]["rows"][0]["CNT"]; 
		};
		
		function fnMove(){
	        var offset = $("#prv_artist").offset().top; //"#prv_artist"
	        offset = offset > 0 ? offset : offset + document.querySelector('body').scrollTop;
	        $("body, html").stop().animate({scrollTop : offset}, 0);
	    }
		
	});
</script>

<body>

	<jsp:include page="../include/topSearch.jsp" flush="false" />

<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false" />

	<div class="container_wrap">

	<div id="container" ng-controller="artListCtl" data-ng-init="init()">

	<div class="contents_wrap">
			<div class="contents">
				<div class="tit_h2 zero_logo_none"><!-- style="padding-top:30px" 세로 가운데 정렬 하기위해 없앰(아카데미 만) -->
					<!-- <h2>Zero Base Artist</h2> -->
					<div class="zero_logo">
						<img src="../images/img/zero_base/zero_base_logo01.jpg" alt="zero base logo" width="100%">
					</div>
				</div>
			<div class="zero_subimgwrap">
				<div class="zero_subimg"> 
					<img src="/images/img/zero_base/zero_subimg01.jpg" alt="제로베이스 서브이미지" />
					<div class="zero_subimg_right">
						<div class="zero_subimg_txtwrap"> 
							<span style="line-height:20px; color:#00acac;">  
									<c:if test="${locale == 'ko'}">서울옥션</c:if> 
									<span><c:if test="${locale != 'ko'}">SeoulAuction</c:if></span>
							</span>
								<div class="zero_h1">
									<c:if test="${locale == 'ko'}">ZERO BASE</c:if>
									<c:if test="${locale != 'ko'}">ZERO BASE</c:if>	 
								</div>
									<p>
										<c:if test="${locale == 'ko'}">
											누군가의 잣대가 아닌 스스로의 판단으로 작품을 선택하는 새로운 컬렉션의 시작 ZERO BASE<br />
											꾸준히 활동해 온 작가들에게 작품을 선보일 수 있는 창구이자,<br />
											본인의 취향을 찾는 컬렉터들에게 새로운 선택의 기회를 제공하는 경매입니다.<br />
										</c:if>
										<c:if test="${locale != 'ko'}">
											ZERO BASE, the beginning of a new collection that selects a artwork by own judgment, not by someone’s yardstick.<br />
	                                        For the artists, ZERO BASE is the stage of the steady stream of their work.<br />
	                                        For the collectors who seek for their new tastes, it is the only auction giving the various choices.
										</c:if>	
									</p>
						</div><!-- //zero_subimg_txtwrap -->
					</div><!-- //zero_subimg_right -->              
				</div>
			</div><!-- //zero_subimgwrap -->
		
		<div class="artist_contents" ng-show="artListNew.length > 0" >
			<div class="artist_title">
				<div class="artist_h1">
					<span class="zero_artist_count" id="new_zerobase_title"></span>
				</div>    
			</div> 
			
			<div class="artist_wrap">
				
				<div class="artist_float" ng-repeat="artListNew in artListNew" ng-if="artListNew.ARTIST_NO != 14973">
					<div class="artist_box">
					<figure class="effect-julia">
						<a href="{{artListNew.ARTIST_URL}}" target="_blank">
							<img ng-src="<spring:eval expression="@configure['img.root.path']"/>{{artListNew.FILE_NAME | imagePath : artListNew.FILE_PATH}}" height="100%;" alt="" />
						</a> 
						 <figcaption ng-if="artListNew.ARTIST_URL != null">
							<!-- <h2><span>영상보기</span></h2> -->   
                            <div>
                                <!-- <p>서울옥션 제로베이스 아티스트</p>  -->
                                <c:if test="${locale == 'ko'}"><p>작가 영상 보기</p></c:if>
                                <c:if test="${locale != 'ko'}"><p>View the artist's video</p></c:if>
                            </div> 
						</figcaption> 	
					</figure> 
					</div>
					
					<div class="zero_namebtn_box">
						<div class="zero_artist_name">
							<a href="../zerobaseList?artist_no={{artListNew.ARTIST_NO}}&sale_no={{artListNew.SALE_NO}}">{{artListNew.ARTIST_NAME_BLOB_KO}}<sup>{{artListNew.BORN_YEAR}}</sup><br />{{artListNew.ARTIST_NAME_BLOB_EN}}
							</a>
						</div>
						<div class="zero_btn" ng-if="artListNew.ARTIST_URL != null">
							<a href="{{artListNew.ARTIST_URL}}" target="_blank">
								<c:if test="${locale == 'ko'}">작가 영상 보기</c:if>
								<c:if test="${locale != 'ko'}">artist's video</c:if>
							</a>
						</div>
					</div><!-- // zero_namebtn_box -->
				</div>	
			</div><!-- //artist_wrap --> 
			
		</div><!-- //artist_contents -->		
		
		
		
		<div class="artist_contents" id="prv_artist">
			<div class="artist_title">
				<div class="artist_h1">
					<span class="zero_artist_count" id="prv_zerobase_title"></span>
				</div> 
				<div class="artist_zbselectbox">   
					<form>    
						<fieldset>  
							<select class="" id="select_zb" ng-change="loadArtList(1,false)" ng-model="select_zb"> 
								<option value="all" selected>작가 전체보기</option>    
								<option ng-repeat="zbSaleList in zbSaleList" value="{{zbSaleList.SALE_NO}}">{{zbSaleList.TITLE_JSON[locale]}}</option>
							</select>
						</fieldset>   
					</form> 
				</div>    
			</div>
			<div class="artist_wrap">
				
				<div class="artist_float" ng-repeat="artList in artList" ng-if="artList.ARTIST_NO != 14973">
					<div class="artist_box">
					<figure class="effect-julia">      
						<a href="{{artList.ARTIST_URL}}" target="_blank">       
							<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{artList.FILE_NAME | imagePath : artList.FILE_PATH}}" height="100%;" alt="asdasd" />
						</a>      
						 <figcaption ng-if="artList.ARTIST_URL != null">
							 <!-- <h2><span>영상보기</span></h2> -->
                            <div> 
                                <!-- <p>서울옥션 제로베이스 아티스트</p>  -->
                                <c:if test="${locale == 'ko'}"><p>작가 영상 보기</p></c:if>
                                <c:if test="${locale != 'ko'}"><p>View the artist's video</p></c:if>
                            </div> 
						</figcaption> 	
					</figure>
					</div>
					
					<div class="zero_namebtn_box">
						<div class="zero_artist_name">
							<a ng-if="custInfo.EMP_GB == 'Y'" href="../zerobaseList?artist_no={{artList.ARTIST_NO}}">{{artList.ARTIST_NAME_BLOB_KO}}<sup>{{artList.BORN_YEAR}}</sup><br />{{artList.ARTIST_NAME_BLOB_EN}}
							</a>
							<a ng-if="custInfo.EMP_GB != 'Y'" >{{artList.ARTIST_NAME_BLOB_KO}}<sup>{{artList.BORN_YEAR}}</sup><br />{{artList.ARTIST_NAME_BLOB_EN}}
							</a>
						</div>
						<div class="zero_btn">
							<a href="{{artList.ARTIST_URL}}" target="_blank">
								<c:if test="${locale == 'ko'}">작가 영상 보기</c:if>
								<c:if test="${locale != 'ko'}">artist's video</c:if>
							</a>
						</div>
					</div><!-- // zero_namebtn_box -->
				</div>
				
			</div><!-- //artist_wrap --> 
			
			<div class="wrap_paging">
				<paging page="currentPage"
						page-size="pageRows"
						total="totalCount"
						paging-action="loadArtList(page,true)"
						scroll-top="false"
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
			
			
		</div><!-- //artist_contents -->		
			</div><!-- //contents -->
			</div><!-- //contents_wrap -->
		</div><!-- //container -->
	</div><!-- //container_wrap -->
</div><!-- //wrap -->
		
	
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />

