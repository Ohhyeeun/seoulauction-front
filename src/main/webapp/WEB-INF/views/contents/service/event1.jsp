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
					<img src="/nas_img/front/homepage/1609 KT 이벤트광고(가입이벤트).jpg"></div>
					<!-- //20150521 -->

					<div class="storage_cont title_area">
						<div class="title">
							<p class="txt_style02"><strong>서울옥션 고객을 위한 올레TV 가입 이벤트</strong></p>
						</div>
						<p>올레tv 가입하고, 홍콩 그랜드 하얏트 호텔에 미술품 경매 보러가자!
                        <br/>행사 기간 내에 070-8018-0343 을 통해 올레tv에 가입하신 분 중 50분을 추첨해 다양한 선물을 드립니다.
                         <br/>행사기간 2016년 9월 1일 - 9월 30일
                         <br/>참여방법 : 서울옥션 고객 전용 상담번호를 통해 올레tv에 가입하시면 자동 응모 됩니다.
                         <br/>당첨발표 2016년 10월 5일
                         <br/>가입상담 : 070-8018-0343 (서울옥션 고객 전용)</p>
						

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
