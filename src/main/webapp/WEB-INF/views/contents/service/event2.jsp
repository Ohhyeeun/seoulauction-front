<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
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
						<h2>이벤트</h2>
					</div>
					<!-- 20150521 -->
                    <div align="center">
					<img src="/nas_img/front/homepage/1609 KT 이벤트광고(인증샷이벤트).jpg"></div>
					<!-- //20150521 -->

					<div class="storage_cont title_area">
						<div class="title">
							<p class="txt_style02"><strong>올레tv 시청자를 위한 퀴즈, 서울옥션 tv 인증샷 이벤트</strong></p>
						</div>
						<p>미술품 경매의 생생한 감동, 서울옥션tv
                        <br/>퀴즈와 인증샷 행사에 참여하시는 분들 중 총 100분을 추첨해 푸짐한 선물을 드립니다.
                        <br/>행사기간 2016년 9월 1일 - 9월 30일
                        <br/>1.퀴즈 행사 참여 방법 : 서울옥션 페이스북의 퀴즈 행사 게시글에 댓글을 달아주세요! (50명 선정)
                        <br/>2.인증샷 행사 참여방법 : 서울옥션 페이스북의 인증샷 행사 게시글에 인증과 해시태크(#서울옥션)를 넣어 댓글을 달아주세요! (50명 선정)
                        <br/>당첨발표 2016년 10월 5일
                        <br/><br/>가입상담 : 070-8018-0343 (서울옥션 고객 전용)</p>
						

					</div>
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
	<!-- 20150521 -->
	<script>
		$(function() {
			$('#slides').slidesjs({
				height : 400,//??
				navigation : false,
				start : 1,
				play : {
					auto : true
				}
			});
		});
	</script>
	<!-- //20150521 -->
</div>

<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />
