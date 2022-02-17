<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<!--<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>-->
		<div id="container">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
					<jsp:include page="../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2><img src="/images/img/sa_logo_grey.png" alt="한국을 넘어 세계로 도약하는 Seoul Auction"  style="width:300px; height:auto;  padding-top:30px;"/>
                        </h2>
						
					</div>

					<div class="intro_auction">
						<div class="intro_cont intro01">
							<!--<div class="tit_h3 through">
								<h3>Seoul Auction</h3>
							</div>-->
							<div class="intro_visual">
								<div><img src="/images/img/img_intro.jpg" class="web_only" alt="한국을 넘어 세계로 도약하는 Seoul Auction"  style="width:100%; height:auto;"/><img src="/images/mobile/img/img_intro.jpg" class="m_only" alt="한국을 넘어 세계로 도약하는 Seoul Auction" style="width:100%; height:auto"/></div>
								<div style="padding-top:80px;"/>
									<p style="font-size:20px; font-weight:700; line-height:36px;" align=center>미술품 경매가 보다 많은 사람들에게 일상의 축제가 되도록 노력하겠습니다.</p>
									<div class="cont">
										<p style="font-size:16px; line-height:30px;">서울옥션은 1998년 설립된 국내 최초의 미술품 경매 회사로 창사 이래 지속적으로 시장 점유율과 경매 기록에서 한국 미술 경매 시장을 리딩하는 대표 기업입니다.
                                        한국 고미술과 근현대 미술은 물론 콜렉터블 아트, 와인, 보석, 건축에 이르기까지 다양한 취향을 반영한 경매를 선보이고 있습니다.
                                        또한 평창동 본사와 강남센터는 물론 홍콩 전시장을 갖추고 있어 경매 외에 다양한 문화 이벤트와 아카데미 등을 통해 보다 많은 사람들과 일상 속 예술의 경험과 기쁨을 나누고자 합니다.
                                        </p>
									</div>
                                    </br></br><br/><br/><br/>
                                    <div class="btn_filedown"  align=right>
                                        <span class="btn_style01 gray03 xsmall icon02"><a href="/nas_img/front/homepage/20160317_seoulauction_K.pdf" target="new">회사소개서(한국어)</a><span class="ico download"></span></span>
                                        <span class="btn_style01 gray03 xsmall icon02"><a href="/nas_img/front/homepage/20160317_seoulauction_E.pdf 
    " target="new">회사소개서(ENG)</a><span class="ico download"></span></span>
                                        <span class="btn_style01 gray03 xsmall icon02"><a href="/nas_img/front/homepage/20160317_seoulauction_C.pdf" target="new">회사소개서(中國語) </a><span class="ico download"></span></span>
                                        <span class="btn_style01 gray03 xsmall icon02"><a href="/nas_img/front/homepage/20160317_seoulauction_J.pdf" target="new">회사소개서(日本語) </a><span class="ico download"></span></span>
                                    </div>
								</div>
							</div>
						</div>

						<div class="intro_cont intro02">
							<div class="tit_h3 through">
								<h3>Our Values</h3>
							</div>
							<div class="both_cont tri">
								<div class="bg_img bg11 tac">
									<div class="title">Creative</div>
									<div class="cont">서울옥션은 끊임없이 새로운 아이템 개발을 통해<br>다양한 경매 서비스를 제공합니다.</div>
								</div>
								<div class="bg_img bg12 tac">
									<div class="title">Global</div>
									<div class="cont">서울옥션은 전세계 작품 출품 및 홍콩 경매 개최를<br>통해 아시아를 선도하는 대표 경매회사로<br>도약하고 있습니다.</div>
								</div>
								<div class="bg_img bg13 tac">
									<div class="title">Customer</div>
									<div class="cont">서울옥션은 고객의 신뢰와 만족을<br>최우선으로 생각하며 항상 노력합니다.</div>
								</div>
							</div>
						</div>
					
						
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />