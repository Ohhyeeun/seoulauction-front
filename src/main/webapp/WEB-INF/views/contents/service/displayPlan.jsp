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
						<h2>행사기획</h2>
					</div>
					

					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="title">
							<p class="txt_style02"><strong>미술시장을 선도하는 서울옥션은 풍부한 경험을 바탕으로 고객을 위한 특별한 행사를 기획합니다.</strong></p>
							<h3>특별한 행사기획 </h3>
						</div>
						<p>
							미술 시장의 이론과 실전을 함께 경험할 수 있는 강의와 전시 투어, <br />
							사계절 아름다운 북한산을 바라보며 함께하는 식사와 이벤트, <br />
							테마를 담은 특별한 전시 기획까지, <br />
							VIP 고객을 위한 품격있는 행사를 통해 문화를 향유하는 기업으로서의 가치를 높여 보십시오.
						</p>
						
						<div class="box_gray type01">
							<div class="contact">
								<div class="title">문의 Contact</div>
								<div class="info">
									<div class="highlight">서울옥션 마케팅팀 <strong>김현희 총괄</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>02-2075-4435</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:hyunhee@seoulauction.com">hyunhee@seoulauction.com</a></div>
								</div>
							</div>
							<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
							</div>
						</div>
					</div>
					
					<!-- 20150521 -->
					<div class="sub_banner02" id="slides">
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
						<div><img src="/images/img/img_ex_banner01.jpg" alt="행사정보" /></div>
						<div><img src="/images/img/img_ex_banner02.jpg" alt="행사정보" /></div>
						<div><img src="/images/img/img_ex_banner03.jpg" alt="행사정보" /></div>
						<div><img src="/images/img/img_ex_banner04.jpg" alt="행사정보" /></div>
						<div><img src="/images/img/img_ex_banner05.jpg" alt="행사정보" /></div>
					</div>
					<!-- //20150521 -->
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
