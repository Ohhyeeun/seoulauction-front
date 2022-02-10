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
						<p>Seoul Auction, the first art auction house in Korea to launch an online bidding system, offers artworks by a broad range of artists at reasonable prices.<br/>
                        In addition to artworks, our auctions also feature various types of lifestyle items (luxury goods, jewelry, designer furniture, figurines, etc.), offering something for everyone.<br/>
                        contact : info@seoulauction.com
                        </p>
					</div>
					<div class="num_cont_wrap">
						<div class="num_cont bg106">
							<!--<div class="num">1</div>-->
							<div class="tit_h3">
								<h3>Register on the website</h3>
								<p>Seoul Auction’s online auctions can be participated in by anyone without having to pay a membership fee. All one must do is register for membership on the Seoul Auction website and complete a simple self-authentication procedure before the auction begins.<br/>
                                Bidding for offline art auctions can only be done by regular (paying) members.<br/><br/>
                                ※ To apply for membership, <span style="color:#F60">an email certification process must be completed.</span> Therefore, please provide a valid email address when applying for membership.<br/><br/>
                                <span style="color:#F60">
                                Please check the Fill the Bidding registration -> YES<br/>
                                </span>
                                <!--※ Yes -> We will contact you by email or phone. You can bid two days after application. <br/>
                                ※ All fields are required. By submitting the information, you will be eligible to transact in any of our sales online, without future interruption. <br/>-->
                                * To be able to participate in online auctions, you must check “Yes” under “Bidding Registration” when applying for membership.<br/>
                                * The bidding button will become available for use one or two weekdays after selecting “Yes.”<br/>
                                * If the bidding button does not become available, please send an email inquiry to info@seoulauction.com<br/>
                                * If you register for membership near the closing time of an auction and make an email or phone inquiry related to bidding, Seoul Auction will provide all necessary assistance.<br/>
                                * If you require the assistance of an employee regarding a bidding-related matter, please do not hesitate to contact us at any time.
                                </p>
								<div class="btns"><span class="btn_style01"><a href="/join/agree">Register</a></span></div>
							</div>

						</div>

						<div class="num_cont bg102">
							<!--<div class="num odd">2</div>-->
							<div class="tit_h3">
								<h3>PREVIEW</h3>
								<p>Preview is a simple and small exhibition for check the condition of objects and art works before the auction begins. Anyone can enter the preview show and get a detail service regarding the objects and art works. The dates of preview exhibition and current auction will be notice through the invitation or website.
                                </p>
							</div>
							<div class="list_style01">
								<ul>
									<li>We submit the auction art works/objects as they are at the preview show.</li>
									<li>We ensure the conditions of the items from the point we presented items on the auction.</li>
									<li>The auction proceed with based on check the real objects through the preview show. Thus, we recommend that please fully check the condition of qualities of art woks/ objects.</li>
								</ul>
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont join_guide guide02 bg108">
							<!--<div class="num">3</div>-->
							<div class="tit_h3">
								<h3>Bidding</h3>
								<p style="line-height:30px; font-size:16px;">
                                &bull;&nbsp;Bidding can be done on the Seoul Auction website during the preview exhibition. Lots will be opened and closed by numerical sequence from the closing time of the auction.<br/>
                                &bull;&nbsp;If a bid is made less than 30 seconds before closing time, the auction will be automatically extended for 30 seconds.<br/>
                                &bull;&nbsp;The closing time may vary depending on the online auction number.<br/>
                                &bull;&nbsp;Bidders may participate in online bidding after completing a procedure to confirm consent.<br/>
                                </p>
                                <p>&loz; If you use Internet Explorer, please verify your settings before the online auction begins.<br/>
                                <a href="/images/img/online_ie_en.jpg" class="btn_main_more yellow" style="width:430px;margin-top:10px; padding-bottom:10px; margin-bottom:10px;" target="new">How to enable the automatic refresh function on the online auction page</a> 
                                <br/><br/>
                                </p>
							</div>

							<div class="box_style08">
								<h4 class="tit_arrow">On-line Bidding</h4>
                                
								<div class="both_cont">
									<div>
										<div class="inner">										
											<div class="bg_img bg23">
												<div class="title">Single bid</div>
												<p>Manual bidding is made once at a time as given amount of the money.</p>
											</div>
										</div>
									</div>
									<div>
										<div class="inner">
											<div class="bg_img bg23">
												<div class="title">Automatic bid</div>
												<p>Automatic bidding after establishing bid limit in advance<br/>
                                                *For automatic bidding, if there is no other bidder, the lowest bid will be designated as the successful bid.</p>
											</div>										
										</div>
									</div>
								</div>
								<!--<div class="border_space02">
									<h4 class="tit_arrow">CHECK! - ACCOUNT</h4>
									<div class="wrap">
										<div class="list_style01">
											<ul>
												<li>To be able to participate in online auctions, you must check “Yes” under “Bidding Registration” when applying for membership.</li>
											</ul>
										</div>
									</div>
								</div>-->
							</div>
                            
                            
                            
                          <!------------------- 온라인 경매 호가단위 테이블 추가 (em) ------------->
			
							<div class="box_style08" style="margin-top: 20px;">
								<h4 class="tit_arrow" style="margin-bottom: 20px;">호가단위 자동 변경기준</h4>
								<div style="padding: 0 40px;">
									<ul>
										<li style="padding: 1px 0 1px 17px; line-height: 24px; background: url(/images/bg/bul_box.gif) no-repeat 0 12px;">다음과 같이 온라인 경매 응찰 금액대별 호가단위가 자동 변경됩니다.<br />
										이는 2019년 11월 1일자 기준, 온라인 상에서 진행되는 모든 경매부터 적용됩니다.</li>
									</ul>
								</div>
								
							<table class="price_table">
									<tr>
										<th>From(￦)</th>
										<th>To(￦)</th>
										<th>By(￦)</th>
									</tr>
									
									<tr>
										<td>~</td>
										<td>1million won</td>
										<td>50,000 won</td>
									</tr>
									
									<tr>
										<td>1million won</td>
										<td>3million won</td>
										<td>100,000 won</td>
									</tr>
									
									<tr>
										<td>3million won</td>
										<td>5million won</td>
										<td>200,000 won</td>
									</tr>
									
									<tr>
										<td>5million won</td>
										<td>10million won</td>
										<td>300,000 won</td>
									</tr>
									
									<tr>
										<td>10million won</td>
										<td>30million won</td>
										<td>500,000 won</td>
									</tr>
									
									
									<tr>
										<td>30million won</td>
										<td>50million won</td>
										<td>1,000,000 won</td>
									</tr>
									
									<tr>
										<td>50million won</td>
										<td>100million won</td>
										<td>2,000,000 won</td>
									</tr>
									
									<tr>
										<td>100million won</td>
										<td>200million won</td>
										<td>3,000,000 won</td>
									</tr>
									
									<tr>
										<td>200million won</td>
										<td>~</td>
										<td>5,000,000 won</td>
									</tr>
							</table>
								
							</div>
			<!------------------- // 온라인 경매 호가단위 테이블 추가 (em) ------------->
            
            
            
            
						</div>
						<!-- //num_cont -->
						<div class="num_cont bg107">
							<!--<div class="num">4</div>-->
							<div class="tit_h3">
								<h3>Successful bid</h3>
                               <!-- <p>When you get the bid successfully at On-line auction, you should write the signature on the confirmation of successful bid at the auction place. Otherwise, when you get the bid successful at online auction, you will get the confirmation email successfully.<br><strong class="txt_green txt_under">Log in &gt; Account &gt; Auction Transactional Information &gt; Purchase List</strong></p>-->
								<p style="font-size:16px; font-weight:600; line-height:30px;">1. Successful bid and bid priority</p>
                                <p style="line-height:30px; font-size:16px;">A successful auction bid is granted to the bidder with the highest bid price. Opportunities for successful bids are granted with priority given to automatic bids, followed by manual bids.<br/>
                                If two identical bids are made, priority will be given to the individual who entered his or her bid price first (based on the time indicated by the server).<br/>
                                When a bid is made, the auction bid increases based on the bid increment.</p>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600; line-height:30px;">2. Confirmation of successful bid</p>
                                <p style="line-height:30px; font-size:16px;">Once a successful bid has been determined, an email confirmation of the successful bid is sent. The bidder may also confirm the successful bid price and commission fees on the Seoul Auction website (Log in > Account > Auction Transaction Information > Purchase List).<br/>
                                The bidder cannot cancel his or her bid without incurring a penalty. In the event a bid must be cancelled, the bidder’s intention to cancel must be expressed in writing within seven days of the successful bid being made. A penalty corresponding to 30 percent of the successful bid price must be paid within seven days for breach of contract.
                                </p>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600; line-height:30px;">3. Purchase commission</p>
                                <p style="line-height:30px; font-size:16px;">The bid commission for successful bids is generally imposed in accordance with the relevant regulations, which are listed below. The commission rates may be applied differently, in accordance with internal policy.<br/>
                                Online auction: 18% (VAT not included)<br/>
                                Hammer price: price announced by the auctioneer upon banging the gavel<br/>
                                Purchase price: sum of the hammer price, bid commission, and VAT
                                </p>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600; line-height:30px;">4. Payment guidelines</p>
                                <p style="line-height:30px; font-size:16px;">Methods of paying the full price of the artwork successfully bid upon are listed below.<br/>
                                  ▶Wire transfer<br/>
                                  Bank : Woori Bank (Pyeongchangdong Branch)<br>
                                  <strong>(Online Auction)</strong> Account :1005-500-700549<br>  
                                  <strong>(Zero Base Auction)</strong> Account :1005-403-971518<br>
                                  Account Name : SEOUL AUCTION<br/>  
                                  Swift code : HVBKKRSEXXX<br/>
                                  Inquiries : (Phone) +82-2-2075-4422 (Email) info@seoulauction.com<br/>
                                  Business hours: (KST) 9:00-18:00<br/>
                                  * When making an account transfer, please write the name of the successful bidder in the deposit memo section. If the name of the account holder and name of the bidder are not the same, the deposit confirmation may be delayed. Seoul Auction assumes no responsibility for any inconvenience that may arise from a discrepancy between the name of the account holder and the name of the bidder.
<br/><br/>
                                  ▶Website payment<br/>
                                  For an artwork bid upon via online auction and payment with a credit card that is accepted in Korea, credit card payments may be made on the Seoul Auction website. For a high-value item, there is a chance that credit card payment may not be accepted, in accordance with the policy of the relevant credit card company. The successful bidder should make the payment after logging in to the Seoul Auction website and confirming the hammer price. <br/><br/>
                                  ▶In-person payment<br/>
                                  If the bidder would like to make the payment with a credit card that cannot be used online, he or she may make the payment in person at the Pyeongchang-dong office of Seoul Auction.<br/>
                                  If a payment inquiry is made in advance, the employee in charge will provide the relevant guidelines.<br/>
                                  * The bidder must make the payment for the artwork (including purchase commission) within seven days of the auction (or 21 days, for hammer prices of KRW 300 million or higher) and take possession of the relevant artwork.<br/>
                                  * The bidder may make the payment for an artwork via installment based on negotiation with Seoul Auction prior to the auction.<br/>
                                  * The bidder may pay the full price for the artwork via cashier’s check, cash, or wire transfer to Seoul Auction’s designated bank account. 
                                  </p>
							</div>
							
						</div>
						<!-- //num_cont -->
						<div class="num_cont bg105">
							<!--<div class="num">5</div>-->
							<div class="tit_h3">
								<h3>Guidelines on the receipt, shipment, and installation of artworks</h3>
                                <p style="line-height:30px; font-size:16px;">
								<strong>Inquiry</strong> : +82 (0)2 2075 4422 (English), +82 (0)2 2075 4391 (中國語)(Head Office)<br>
                                Business hours: (KST) 9:00-18:00
                                </p>
							</div>
							<div class="list_style01" style="line-height:22px; font-size:16px;">
									
									<br><strong class="txt_green">* Ways for the bidder to receive the artwork</strong>
									<br><br>1. Artworks bid upon in an auction <strong class="txt_green">must be received directly by the bidder. </strong>
									<br><br>2. Pick-up location : <strong class="txt_green">Seoul Auction House (B1, Storage), 24 (Pyeongchang-dong 98), Pyeongchang 30-gil, Jongro-gu, Seoul, </strong>or the Hong Kong office (SA+) for artworks held in Hong Kong
									<br><br>3. Please  <strong class="txt_green">make a reservation</strong> with a sales employee <strong class="txt_green">for the date and time you wish to pick up </strong>artwork <strong class="txt_green">by the day before pick-up.</strong>
									<br>&nbsp;&nbsp;Pick-up is conducted based entirely on an advance reservation system.  <strong class="txt_green">. If you arrive at the office without a reservation, you will not be able to pick up the artwork.</strong>
									<br><br>4. Pick-up days and times : <strong class="txt_green">Monday to Friday </strong>(excluding national holidays) / Seoul Auction business hours: 9 a.m. to 6 p.m. (excluding lunch hour (12 p.m. to 1 p.m.)
									<br>&nbsp;&nbsp;* For pick-up by car: artworks up to <strong class="txt_red">90 × 118cm </strong>in size can be loaded into a car (up to No. 50 canvas)
									<br><br>5. If the bidder is unable to pick up the artwork directly, Seoul Auction can recommend the services of an art shipment company. In this case, the shipment of the artwork shall be <strong class="txt_green">the responsibility of (and paid for by) the bidder.</strong>
									<br>&nbsp;&nbsp;<strong class="txt_green">* Regular delivery companies are not recommended</strong>due to the risk of damage to or loss of the artwork.									
								
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont">
							<div class="tit_h3">
								<h3>★ Basic shipping fee (One Way)</h3>
							</div>
							<div class="box_style08">
								<div class="list_style01">
									<ul style="margin-left:20px;">
										<li style="font-weight:600; font-size:16px; line-height:24px;">Shipping fee is free of charge for Seoul and Gyeonggi-do. For other provinces, it will be shipped twice a month on the designated day for free of charge. (Including weekend) </li>
										<li style="font-weight:600; font-size:16px; line-height:24px;">Additional fee is charged for individual shipping, mountainous, remotes areas, Jeju Island and overseas.</li>
                                        <li style="font-weight:600; font-size:16px; line-height:24px;">Additional fee is paid to the on-site employee who does the installation and artworks that require additional personnel for installation. (Quotation will be provided in advance)</li>
                                        <li style="font-weight:600; font-size:16px; line-height:24px;">Inquiry: +82-2-2075-4404</li>
                                        <li style="font-weight:600; font-size:16px; line-height:24px;">Overseas: Estimated on request</li>
									</ul>
								</div>
							</div>
                        </div>
						<!-- //num_cont -->

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