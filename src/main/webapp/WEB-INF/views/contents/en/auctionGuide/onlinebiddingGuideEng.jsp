<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">

		<div id="container">
			<div class="sub_menu_wrap menu02">
				<div class="sub_menu">
					<jsp:include page="../../include/howtoSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2 border">
						<h2>How To Bid - Online Auction</h2>
						<p>You need to bid in the auction to get art works that you want. Please follow the instruction, how to bid.
                        <br/>contact : info@seoulauction.com</p>
					</div>
					<div class="num_cont_wrap">
						<div class="num_cont">
							<div class="num">1</div>
							<div class="tit_h3">
								<h3>Register on the website</h3>
								<p>When entering Membership in SeoulAuction, please complete filling up according to a regular member admission procedures.<br/>
                                <br/>Please check the Fill the Bidding registration -> YES<br/>
                                ※ Yes -> We will contact you by email or phone. You can bid two days after application. <br/>
 ※ All fields are required. By submitting the information, you will be eligible to transact in any of our sales online, without future interruption. </p>
								<div class="btns"><span class="btn_style01"><a href="/join/agree">Register</a></span></div>
							</div>

						</div>

						<div class="num_cont">
							<div class="num odd">2</div>
							<div class="tit_h3">
								<h3>PREVIEW</h3>
								<p>Preview is a simple and small exhibition for check the condition of objects and art works before the auction begins. Anyone can enter the preview show and get a detail service regarding the objects and art works. The dates of preview exhibition and current auction will be notice through the invitation or website.
                                </p>
							</div>
							<div class="list_style01">
								<ul>
									li>We submit the auction art works/objects as they are at the preview show.</li>
									<li>We ensure the conditions of the items from the point we presented items on the auction.</li>
									<li>The auction proceed with based on check the real objects through the preview show. Thus, we recommend that please fully check the condition of qualities of art woks/ objects.</li>
								</ul>
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont join_guide guide02">
							<div class="num">3</div>
							<div class="tit_h3">
								<h3>Bidding Method</h3>
								<p>&bull;&nbsp;You can make a bid through Homepage Preview period of Online Auction, Action is closed in order from auction ending time.<br/>
                                &bull;&nbsp;In case of a bidding 30 seconds prior to Auction deadline, it is extended for 30 seconds automatically .<br/>
                                &bull;&nbsp;Above deadline can vary according to Online Auction Turn.<br/>
                                &bull;&nbsp;Send the ID-opening  requests by e-mail : info@seoulauction.com<br/>
                                </p>
                                <p>&loz; 온라인 경매 전, 익스플로러를 사용 하시는 경우 설정을 확인해 주시기 바랍니다.&nbsp;
                                <a href="/images/img/online_ie.jpg" class="btn_main_more yellow" style="width:260px;margin-top:10px; padding-bottom:10px; margin-bottom:10px;" target="new">온라인 경매 페이지 자동 새로고침 해결 방법</a> 
                                </p>
							</div>

							<div class="box_style08">
								<h4 class="tit_arrow">On-line Bidding</h4>
                                
								<div class="both_cont">
									<div>
										<div class="inner">										
											<div class="bg_img bg23">
												<div class="title"> Bid</div>
												<p>Submit the bid each single round according to the given amount.</p>
											</div>
										</div>
									</div>
									<div>
										<div class="inner">
											<div class="bg_img bg23">
												<div class="title">Automatic bid</div>
												<p>Bidder setting the limited amount.</p>
											</div>										
										</div>
									</div>
								</div>
								
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont">
							<div class="num odd">4</div>
							<div class="tit_h3">
								<h3>Confirmation of Successful Bidding</h3>
                                <br/><br/>
								<p>When you get the bid successfully at Off-line auction, you should write the signature on the confirmation of successful bid at the auction place. Otherwise, when you get the bid successful at online auction, you will get the confirmation email successfully.<br><strong class="txt_green txt_under">Log in &gt; My Account &gt; Auction Transactional Information &gt; Purchase List</strong></p>
								<p>When you inevitably need to withdraw the objects, the bidder should notify the intention of withdrawal with a document within 7 days from the day of successful bid.</p>
								<div class="btns">
									<span class="btn_style01">
										<a href="/terms/page?view=auctionTerms" target="_blank" title="Terms"> Terms</a>
									</span>
								</div>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600;">Commission</p>
                                <p>The commission fee for the succeeded bid is set according to the following policy, but the other rate of commission can be applied through the internal policy.<br/>
                                18% of hammer price(tax excluded)
                                </p>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600;">Settlement</p>
                                <div class="list_style03 type03">
                                    <ul>
                                        <li><strong>Inquiry email </strong><span> : <a href="mailto:info@seoulauction.com">info@seoulauction.com</a></span></li>
                                        <li><strong> HEAD OFFICE. SEOUL </strong><span> : +82 (0)2 2075 4422 (English)</span><span>  +82 (0)2 2075 4385 (中國語)</span></li>
                                    </ul>
                                </div>
							</div>
							
						</div>
						
					</div>
					<!-- //num_cont_wrap -->
				</div>
			</div>

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/img/img_menu02.jpg" alt="" class="img_master">
						</li>
					</ul>
				</div>
			</div>-->
		</div>
	</div>
</div>

<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />