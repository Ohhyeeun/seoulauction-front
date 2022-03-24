<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
src960 = $("#topLayerImage").attr("");   
src768 = $("#topLayerImage").attr("");	
src320 = $("#topLayerImage").attr("");	

function closePop(name, expiredays){
	setCookie( name, "done" , expiredays);   
   $("#kanggTopLayer").hide();
}

window.onload=function(){
	if(getCookie("topLayer") == 'done'){
		$("#kanggTopLayer").hide();
	}else{
		$("#kanggTopLayer").show();
	}
}
	
</script> 
  
	<div id="kanggTopLayer" class="curtain_wrapper">
	<c:if test="${locale == 'ko'}">  <!-- 국문페이지인 경우만 오픈 -->
		<div class="curtain_wrap">
			<a href="https://www.auctionblue.com/" target="blank">
				<img id="topLayerImage" src="nas_img/front/homepage/blue3.jpg" alt="옥션블루 온라인 경매" />   <!-- 모바일 버전 이미지 링크. htdoc/images/img/img_banner_320.png, img_banner_768.png, img_banner_960.png -->
			</a> 
			
				<button class="btn_curtain_close" onclick="closePop('topLayer',1);">
					<span>오늘그만보기</span>
				</button>
		</div>
	</c:if>
	</div>
