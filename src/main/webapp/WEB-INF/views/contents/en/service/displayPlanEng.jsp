<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../../include/serviceSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>Exhibition Curating</h2>
					</div>

					<div class="sub_banner02" id="slides">
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
						<div><img src="/images/eng/img/img_ex_banner01.jpg" alt="Exhibition Curating" /></div>
						<div><img src="/images/eng/img/img_ex_banner02.jpg" alt="Exhibition Curating" /></div>
						<div><img src="/images/eng/img/img_ex_banner03.jpg" alt="Exhibition Curating" /></div>
						<div><img src="/images/eng/img/img_ex_banner04.jpg" alt="Exhibition Curating" /></div>
						<div><img src="/images/eng/img/img_ex_banner05.jpg" alt="Exhibition Curating" /></div>
					</div>

					<div class="storage_cont title_area">
						<div class="title">
							<p class="txt_style02"><strong>Seoul Auction leads the art market. <br>We bring our rich experience dealing with diverse artworks to our exhibitions.</strong></p>
						</div>
						<p>We carefully select profound and exceptional themes for our exhibitions and auction. All artworks we present to clients are crafted by outstanding artists and will reveal your company’s great passion for culture.</p>

						<div class="box_gray type01">
							<div class="contact">
								<div class="title">Contact</div>
								<div class="info">
									<div class="highlight">Team Leader, Marketing Team<strong> Hyunhee Kim</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>Office +82-2-2075-4435</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:hyunhee@seoulauction.com">hyunhee@seoulauction.com</a></div>
								</div>
							</div>
							<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">Inquiry</a><span class="ico next02"></span></span>
							</div>
						</div>
					</div>
				</div>
			</div>

			
		</div>
	</div>

	<script>
		$(function() {
		  $('#slides').slidesjs({
			height:400,//??
			navigation: false,
			start: 1,
			play: {
			  auto: true
			}
		  });
		});
	</script>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />