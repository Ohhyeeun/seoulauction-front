<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		<!--<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>-->
		<div id="container">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
					<jsp:include page="../../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2><img src="/images/img/sa_logo_grey.png" class="web_only" alt="Seoul Auction"  style="width:300px; height:auto;  padding-top:30px;"/></h2>
						
					</div>

					<div class="intro_auction">
						<div class="intro_cont intro01">
							<!--<div class="tit_h3 through">
								<h3>Seoul Auction</h3>
							</div>-->
							<div class="intro_visual">
								<div><img src="/images/img/img_intro.jpg" class="web_only" alt="Seoul Auction"  style="width:100%; height:auto;"/><img src="/images/mobile/img/img_intro.jpg" class="m_only" alt="Seoul Auction" style="width:100%; height:auto"/></div>
								<div style="padding-top:80px;">
									<p style="font-size:20px; font-weight:700; line-height:36px;" align="center">We strive to make art auction available to more people.</p>
									<div class="cont">
										<p style="font-size:16px; line-height:30px;">Established in 1998, Seoul Auction is the leading art auctioneer in the Korean art market, 
										in terms of market share and auction sales records. To achieve our goal of becoming a top-rate global auction house, 
										Seoul Auction opened a branch office in Hong Kong in 2008 and has facilitated to introduce modern and 
										contemporary Korean art to worldclass collectors. We organize auctions each year on a wide range of artworks and themes and 
										also conduct online auctions on a regular basis. Our mission is to share the joy of art collecting with art lovers the world over.</p>
									</div>
                                    <br/><br/><br/><br/><br/>
                                    <div class="btn_filedown"  align=right>
                                        <span class="btn_style01 gray03 xsmall icon02"><a href="/nas_img/front/homepage/20160317_seoulauction_E.pdf" target="new">Introduction(ENG)</a><span class="ico download"></span></span>
                                        <span class="btn_style01 gray03 xsmall icon02"><a href="/nas_img/front/homepage/20160317_seoulauction_C.pdf" target="new">Introduction(中國語) </a><span class="ico download"></span></span>
                                        <span class="btn_style01 gray03 xsmall icon02"><a href="/nas_img/front/homepage/20160317_seoulauction_J.pdf" target="new">Introduction(日本語) </a><span class="ico download"></span></span>
                                        <span class="btn_style01 gray03 xsmall icon02"><a href="/nas_img/front/homepage/20160317_seoulauction_K.pdf" target="new">Introduction(한국어)</a><span class="ico download"></span></span>
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
									<div class="cont">SeoulAuction constantly provides a variety of auction services through the development of new items.</div>
								</div>
								<div class="bg_img bg12 tac">
									<div class="title">Global</div>
									<div class="cont">SeoulAuction takes a leap as a representative auction company leading Asia through global work exhibition and Hong Kong Auction commencement.</div>
								</div>
								<div class="bg_img bg13 tac">
									<div class="title">Customer</div>
									<div class="cont">SeoulAuction makes every effort considering customers’ reliability and satisfaction with top priority. </div>
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
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />