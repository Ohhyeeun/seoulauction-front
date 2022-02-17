<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="include/header.jsp" flush="false"/>
<!-- 모바일용 커튼 배너 호출. YDH 
--> 
<!-- 모바일용 커튼 배너 호출 . YDH -->
<link href="/css/angular/ng-animation.css" rel="stylesheet">  
<link href="/css/jquery.bxslider.min.css" rel="stylesheet">           
<link href="/css/main_bxslider.css" rel="stylesheet">            

<!-- <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-animate.min.js"></script> -->
<script type="text/javascript" src="/js/angular/angular-animate.min.js"></script> 
<script type="text/javascript" src="/js/jquery.bxslider.min.js"></script>      

<script>
var screenType = "P";
$(document).ready(function() {
	var winWidth = $(window).innerWidth();
	if(winWidth > 768) {
		location.href = "/";
	}
});

$(window).resize(function() {
	var winWidth = $(window).innerWidth(); 
	if(winWidth > 768) {
		location.href = "/";
	}
}); 


var m_aPopImages = new Array();


app.requires.push.apply(app.requires, ["ngAnimate"]);

app.controller('bannerListCtl', function($scope, consts, common) {
	$scope.ani_effect = "slide-down";
	
	$scope.loadBannerList = function(){
 		$d = {"baseParms":{"bann_id":"main"}, 
 			  "actionList":[
 				{"actionID":"banner_list", "actionType":"select" , "tableName": "BANNERS"},
 				{"actionID":"banner_image_list", "actionType":"select" , "tableName": "IMAGES"}
 			 ]};

 	   	common.callActionSet($d, $s);
	}
 		
 	var $s = function(data, status) {
 		$scope.bannerList = data["tables"]["BANNERS"]["rows"];
 		$scope.imageList = data["tables"]["IMAGES"]["rows"];
		$scope.banner = 1;			
		$scope.banner_sub = 1;
	};

 	$scope.setBannerArticle = function($n){
 		if($n < 1){
 			
 		}else if($n > $scope.bannerList.length){
 			
 		}else{
 			if($scope.banner < $n){
 				$scope.ani_effect = "slide-up"
 			}else{
 				$scope.ani_effect = "slide-down"
 			}

			$scope.banner = $n
			$scope.banner_sub = 1;
		}
 	}
 		
	$scope.setBannerArticleSub = function($n){
		if($scope.banner_sub < $n){
			$scope.ani_effect = "slide-left"
		}else{
			$scope.ani_effect = "slide-right"
		}

		$scope.banner_sub = $n;
 	}
});

/*$(window).on('load', function(){
	if(screenType == "M"){
		$("body").removeClass("main");
	}
	else{
		$("body").addClass("main");
	}
});
*/

</script>

 
<body>  
<jsp:include page="include/topSearch.jsp" flush="false"/>
<div class="loading"><div></div></div> 

<div id="wrap">
<jsp:include page="include/topMenu.jsp" flush="false"/> 
<div class="container_wrap" style="min-height:0;">
		<div class="contents m_contents">  
			<div class="m_main_banner"> 
<%-- 				<c:if test="${locale == 'ko'}">  --%>
					<jsp:include page="./inc_home_slide_mobile.jsp" flush="false" />
<%-- 				</c:if>  --%>
<%-- 				<c:if test="${locale == 'en'}"> --%>
<%-- 					<jsp:include page="./inc_home_slide_mobile_en.jsp" flush="false" /> --%>
<%-- 				</c:if>  --%>

				<%-- <a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
				<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
				<c:if test="${locale == 'ko'}">
				<jsp:include page="./inc_home_slide_mobile.jsp" flush="false" />
				</c:if>
				<c:if test="${locale == 'en'}">
				<jsp:include page="./inc_home_slide_mobile_en.jsp" flush="false" />
				</c:if> --%>
			</div>
		</div> 
	</div>
</div>
<script type="text/javascript">  
	/* 오피스 입력연동 작업으로 mSlideCtl에서 처리 */
	/* mobile main slider 20201123 em */   
// 	$(function(){   
// 		$(".m_ver_sliderwrap .bxslider").bxSlider({      
// 			auto:true,   
// 			controls: true, 
// 			autoControls: true, 
// 			/* autoControlsCombine:true, */      
// 			pause: 3500,    
// 			adaptiveHeight:true, 
// 		}); 
// 	});  
	
// 	// YBK. 20170208. origin --> $(".loading").fadeOut("slow"); 
// 	$(".loading").fadeOut("1000"); 
</script>
		

<jsp:include page="include/main_in.jsp" flush="false" />
<jsp:include page="include/footer.jsp" flush="false" />
 