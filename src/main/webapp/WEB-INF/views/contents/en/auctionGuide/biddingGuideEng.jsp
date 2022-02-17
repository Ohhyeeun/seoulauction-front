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
						<h2>How To Bid</h2>
						<p>You need to bid in the auction to get art works that you want. Please follow the instruction, how to bid.
                        <br/>contact : info@seoulauction.com</p>
					</div>
					<div class="num_cont_wrap">
						<div class="num_cont bg101">
							<!--<div class="num odd">1</div>-->
							<div class="tit_h3">
								<h3>Membership</h3>
								<p>All of the auction bidders should register for a membership of Seoul Auction.<br>Please create the membership at website (homepage), exhibition, or Seoul auction office. </p>
							</div>
							<div class="list_style03">
								<ul>
									<li>
										<div class="tit">Subscription Member(Full Member)</div>
										<p>A regular member requires a membership fee(yearly USD 500) and have diversity of advantages with free receipt of periodicals issued by Seoul Auction(unique catalogues, preview exhibition guide book, etc.). You can Bid the all auctions(Art auction, Hong Kong Auction, Special Auction).</p>
									</li>
									<li>
										<div class="tit">Associate Member</div>
										<p><!--Capable of Seoul Action only e-Bid Now bidding after check your information (Send the requests by e-mail : info@seoulauction.com), and -->Can receive the auction-related information service in Homepage.</p>
									</li>
								</ul>
							</div>
							<div class="box_style08 join_guide mt30">
								<h4 class="tit_arrow">Method of Membership Admission</h4>
								<div class="both_cont">
									<div>
										<div class="inner">
											<div class="bg_img bg18">
												<div class="tit_border">Register on the website</div>
												<p>When entering Membership in SeoulAuction, please complete filling up according to a regular member admission procedures.</p>
												<div class="btns"><span class="btn_style01"><a href="/join/agree">Register</a></span></div>
                                                
												<p class="pt20">If you already registered Associate member, you are able to pay yearly membership fee at Customer Type Career after log in. You would have a qualification of the Full Member.</p>
												<div class="btns">
													<span class="btn_style01">
														<a href="/customer/myPage">MY Seoul Auction - Customer Type</a>
													</span>
												</div>
											</div>
										</div>
									</div>
									<div>
										<div class="inner">
											<div class="bg_img bg19">
												<div class="tit_border">Register at Exhibition/Office</div>
												<p>If you visit SeoulAuction Head Office or each Branch and register a regular member, you can join a regular membership.</p>
												<div class="list_style03 mt15">
													<ul>
														<li>
															<div class="tit">The customer who just registered for the Associate member wants to upgrade to Full member.</div>
															<p>After Admission Team will confirm, you will be upgrade to Full member.<br>Question regarding to Full Membership: +82-2-2075-4422 (info@seoulauction.com)</p>
														</li>
														<!--<li>
															<div class="tit">If you send the application form by e-mail after you fill it in. To acquire full membership, please transfer admission fee to Seoul Auction bank account.</div>
															
														</li>-->
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //num_cont -->
						<!--<div class="num_cont">
							<div class="num">2</div>
							<div class="tit_h3">
								<h3>Introduction about Seoul Auction</h3>
							</div>
							<div class="list_style03">
								<ul>
									<li>
										<div class="tit">OFF-LINE AUCTION</div>
										<div class="list_style01">
											<ul>
												<li><strong>Major Auction</strong> : We sell varieties of contemporary, modern, and antique art works created by various Korean and international artists through the auction.</li>
												<li><strong>Hong Kong Auction </strong> : We sell art pieces which is globally famous Korean, Japan, China, Europe, United States and etc.</li>
												<li><strong>Special Auction</strong> : For the Special Auction we focus on one specific theme. We hold special auctions twice a year, during spring and autumn. It is comprised of works created through the collaboration between corporations and emerging artists.</li>
											</ul>
										</div>
									</li>
									<li>
										<div class="tit">e-Bid Now (ONLINE AUCTION)</div>
										<p>The "e-Bid Now" online auction provide the differentiation of wide-ranging artists and reasonable purchase prices. No need admission fee for able to join the auction through simple registration and certification of identification. While the period of preview exhibition, you can check the real items/art works.</p>
										<div class="btns">
											<span class="btn_style01">
												<a href="/currentAuction">Go to Current Auction</a>
											</span>
										</div>
									</li>
								</ul>
							</div>
						</div>-->
						<!-- //num_cont -->
						<div class="num_cont bg102">
							<!--<div class="num odd">2</div>-->
							<div class="tit_h3">
								<h3>PREVIEW</h3>
								<p>Preview is a simple and small exhibition for check the condition of objects and art works before the auction begins. Anyone can enter the preview show and get a detail service regarding the objects and art works. The dates of preview exhibition and current auction will be notice through the invitation or website.</p>
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
						<div class="num_cont join_guide guide02 bg103">
							<!--<div class="num odd">4</div>-->
							<div class="tit_h3">
								<h3>Bidding Method</h3>
								<p>Please follow the instructions: Off-line auction and Online Auction.<br>It is unchangeable or cannot cancel after the bidding so please carefully when you submit the bid.</p>
							</div>
							<div class="btn_filedown"><span class="btn_style01 gray03 xsmall icon02"><a href="/nas_img/front/homepage/202009_Absentee_Telephone BIDDING FORM.pdf" target="new">Download Absentee(Telephone/Written) Bid Form</a><span class="ico download"></span></span></div> 
							<div class="box_style08">
								<h4 class="tit_arrow">OFF-LINE AUCTION BIDDING</h4>
								<div class="both_cont tri"> 
									<div>
										<div class="inner">
											<div class="bg_img bg20">
												<div class="title">Bidding in Person</div>
												<p>Bidders can make a bid by using one of the bid paddles provided at the auction.</p>
											</div>
										</div>
									</div>
									<div>
										<div class="inner">
											<div class="bg_img bg21">
												<div class="title">Absentee(Telephone) Bidding</div>
												<p>You can place the bid in real live by phone call with Seoul Auction staff.
                                               </p>
												<ul>
													<li>i. <a href="/nas_img/front/homepage/202009_Absentee_Telephone BIDDING FORM.pdf" target="new"><span class="txt_green txt_under">Download Absentee Bid Form</span></a><br/>
                                                    info@seoulauction.com</li>
												</ul>
											</div>
										</div>
									</div> 
									<div>
										<div class="inner">
											<div class="bg_img bg22">
												<div class="title">Absentee(Written) Bidding</div>
												<p>You should submit an absentee bid form specifying the highest amount that you are willing to pay for the art works/objects, at least a day prior to the auction.</p>

												<p>Bid forms are accepted by e-mail only.</p>
												<ul>
													<li>i. Absentee bidding is done via SeoulAuction's assistant auctioneer.</li> 
													<li>ii. <a href="/nas_img/front/homepage/202009_Absentee_Telephone BIDDING FORM.pdf" target="new"><span class="txt_green txt_under">Download Absentee Bid Form</span></a><br/>
                                                    info@seoulauction.com</li>
                                                    
                                                   
												</ul>
											</div>
										</div>
									</div>
								</div>
								<!--<div class="border_space02">
									<h4 class="tit_arrow">ON-LINE AUCTION BIDDING</h4>
									<div class="wrap">
										<div class="list_style01">
											<ul>
												<li>You can make a bid through Homepage Preview period of Online Auction, Action is closed in order from auction ending time.</li>
												<li>In case of a bidding 30 seconds prior to Auction deadline, it is extended for 30 seconds automatically .</li>
												<li>Above deadline can vary according to Online Auction Turn.</li>
                                                <li>Send the ID-opening  requests by e-mail : info@seoulauction.com</li>
											</ul>
										</div>
										<div class="bid_online">
											<div class="title">ON-LINE BIDDING</div>
											<div class="list_style03">
												<ul>
													<li>
														<div class="tit">Bidding</div>
														<p>Submit the bid each single round according to the given amount.</p>
													</li>
													<li>
														<div class="tit">Automatic Bid</div>
														<p>Bidder setting the limited amount.</p>
													</li>
												</ul>
											</div>
										</div>
										<div class="box_white">
											<p class="notice_style02">For the safety to bid online auction, you can proceed online bidding through the procedures of confirming and consenting the work status.</p>
										</div>
									</div>
								</div>-->
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont bg110">
							<!--<div class="num odd">5</div>-->
							<div class="tit_h3">
								<h3>How to reserve Auction</h3>
								<p>For participate auction, you can reserve the seat in advance.</p>
							</div>
							<div class="list_style03">
								<ul>
									<li>
										<div class="tit">How to register the application form of bidding</div>
										<p>The member who wants bidding through the written report or phone call, please fill the application form completely and submit at the website or the back of catalogue. The form of bidding registration is close on one day before.</p>
									</li>
									<!--<li>
										<div class="tit">How to reserve the bidding via application form at website</div>
										<p>If you want bidding at the office/written report/phone call, you can write the application form of bidding reservation at the website. You can check the detailed statement of bid application through this process. <strong class="txt_green">Member Information &gt; Reservation and Application &gt; Bidding Reservation Application</strong></p>
									</li>-->
								</ul>
							</div>
							<!--
							<div class="btns">
								<span class="btn_style01"><a href="">Go To Bid Reservation</a></span>
							</div>
							-->
						</div>
						<!-- //num_cont -->
                         <div class="num_cont bg104">
							<!--<div class="num odd">5</div>-->
                            <div class="tit_h3">
								<h3>Successful Bidding</h3>
								<p style="font-size:16px; font-weight:600; line-height:30px;">1. Successful Bid and Priority Order</p>
                                <p style="line-height:30px; font-size:16px;">Auction works are auctioned off to a bidder who presented the highest price. If there are more than two bidders who get the same amount, the successful bid will determine to the following instructions.</p>
                                <p style="line-height:30px; font-size:16px;">If the bidders who applied at the auction house, written report, or phone call have a competition with another bidder who has the same amount, the priority order will determine in the order of <strong class="txt_green">written &gt; Auction house &gt; Phone call.</strong></p>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600; line-height:30px;">2. Confirmation of Successful Bidding</p>
                                <p style="line-height:30px; font-size:16px;">When you get the bid successfully at Off-line auction, you should write the signature on the confirmation of successful bid at the auction place. <!--Otherwise, when you get the bid successful at online auction, you will get the confirmation email successfully.<br><strong class="txt_green txt_under">Log in &gt; My Account &gt; Auction Transactional Information &gt; Purchase List</strong>--></p>
								 <p style="line-height:30px; font-size:16px;">When you inevitably need to withdraw the objects, the bidder should notify the intention of withdrawal with a document within 7 days from the day of successful bid.</p>
								<div class="btns">
									<span class="btn_style01">
										<a href="/terms/page?view=auctionTerms" target="_blank" title="Terms"> Terms</a>
									</span>
								</div>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600; line-height:30px;">3. Commission</p>
                                <div class="list_style03 type02">
                                    <ul>
                                        <li>
                                            <strong>Seoul(Domestic) Auction Purchase Fee</strong>
                                            <div class="list_style01">
                                                <ul>
                                                    <li>18% of hammer price(tax excluded)</li> 
                                                    
                                                </ul>
                                            </div>										
                                        </li>
                                        <li>
                                            <strong>Hong Kong Auction Purchase Fee</strong>
                                            <div class="list_style01">
                                                <ul>
                                                    <li>18% of hammer price</li>
                                                </ul>
                                            </div>										
                                        </li>
                                    </ul>							
                                </div>
                                <div class="box_style07 type02 mt30">
                                    <div class="notice_style02">
                                        <strong>Hammer Price</strong> : The price of the highest bid, finalized by the fall of hammer and being called out his or her paddle number by the auctioneer.<br>
                                        <strong>Purchase Price</strong> : The sum of hammer price + successful bid fee + VAT
                                    </div>
                                </div>
                               <!-- <br/><br/>
                                <p style="font-size:16px; font-weight:600; line-height:30px;">4. 결제 안내</p>
                                <p style="line-height:30px; font-size:16px;">낙찰받은 작품에 대한 총 구매대금 결제방법은 아래와 같습니다.<br/>
                                  ▶계좌 입금<br/>
                                  우리은행 1005-902-012409 (주)서울옥션 (입금 후 전화 확인 바랍니다)<br/>
                                  문의: 전화 02-395-0330 메일 sos@seoulauction.com<br/>
                                  * 계좌입금 시 입금 메모란에 실제 낙찰자의 이름을 명시해 주십시오. 입금자와 낙찰자의 이름이 일치하지 않을 경우, 입금확인이 어려울 수 있으며, 이에 대한 불이익은 서울옥션에서 책임지지 않습니다.<br/><br/>
                                  * 낙찰자는 경매후 7일(낙찰가 3억원 이상인 경우는 21일) 이내에 구매수수료를 포함한 금액을 입금하신 후 작품을 인수하시기 바랍니다.<br/>
                                  * 낙찰자는 응찰전 당사와의 합의에 의하여 구매대금을 분할 납부할 수 있습니다.<br/>
                                  * 낙찰자는 총 구매대금을 당사 지정의 은행계정송금, 자기앞수표, 현금 등으로 지불할 수 있습니다.
                                  
                                  </p>-->
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont bg105">
							<!--<div class="num">5</div>-->
							<div class="tit_h3">
								<h3>Settlement</h3>
								<!--<p>The auctioned off Items should be paid as follows.</p>-->
							</div>
							<!--<div class="box_style08 type02">
								<div class="both_cont tri">
									<div class="first">
										<div class="inner">
											<h4 class="tit_arrow">Bank Transfer</h4>
											<p class="account"><span>Kukmin Bank</span><span>642237-04-003005 </span><span>Seoul Auction</span></p>
										</div>
									</div>
									<div class="second">
										<div class="inner">
											<h4 class="tit_arrow">Online Auction Payment</h4>
											<p>You can pay by credit card when the purchase price is up to KRW 3,000,000 won at online auction. (Unavailable payment card: Hyundai, Nonghyup, Hana)</p>
											<p class="pt15">The winning bidder should log in then, check the purchase list with pay the hammer price.</p>
											<div class="btns">
												<span class="btn_style01" style="letter-spacing:-0.09em;">
													<a href="javascript:goPurchaseHistory();">Winning bid breakdown “File Shortcut”</a>
												</span>
											</div>
										</div>
									</div>
									<div class="third">
										<div class="inner">
											<h4 class="tit_arrow">Visit Payment</h4>
											<p>If you want to pay by credit card which is unavailable payment card, you can visit Seoul Auction office(Head office at Pyeongchang-dong/ Gangnam branch). When you give the notification in advance our accounting team will guide you.</p>
											<p class="pt15"><strong>Main telephone : 02-395-0330</strong></p>
										</div>
									</div>
								</div>
							</div>
							<div class="list_style01 mt15">
								<ul>
									<li>Winning bidder should pay the buying commission within 7 days after the day of auction(If the purchasing price is more than KRW 3,000,000,000 won, please pay within 21 days) then, pick up your art works/objects.</li>
									<li>Winning bidder can make the purchase fee to divided payment by agreement with Seoul Auction before bidding.</li>
									<li>Winning bidder can pay the total purchase price by bank transfer, cheque, cash, etc. </li>
									<li>Online auction is available to pay the purchase at website. (Please check the ailable payment card 'Visa, MASTERCARD...')</li>
									<li>If you want to pay by credit card which is  payment card, you can visit Seoul Auction office(Head office at Pyeongchang-dong/ Gangnam branch). When you give the notification in advance our accounting team will assist you.</li>
									
								</ul>
							</div>-->
                             <p style="line-height:30px; font-size:16px;">After payment is confirmed, delivery is possible.
								<br><strong class="txt_green">You can pick it up directly at Head Office.</strong>
								<br><br><strong>Inquiry</strong> : +82 (0)2 2075 4422 (English), +82 (0)2 2075 4391 (中國語)(Head Office)
								<br>Operation time : Mon~Fri 9:00-17:00 (lunch time 12:00-1:00)</p>
						</div>
						<!-- //num_cont -->
                        
					</div>
					<!-- //num_cont_wrap -->
				</div>
			</div>

		</div>
	</div>
	<!-- 20150623 -->
	<script type="text/javascript">
		maxH();
		$(window).resize(function(){
			$('.both_cont.tri > div .inner').css('height', 'auto');
			maxH();
		});
		function maxH(){
			if($(window).width() > 767){
				$('.both_cont.tri > div .inner').each(function(){
					var maxHeight = Math.max($(this).parent().parent().height());
					$(this).css('height', maxHeight + 'px');
				});
			} else {
				$('.both_cont.tri > div .inner').css('height','auto');
			}
		}
	</script>
</div>
<c:set var="paypal_url" value="https://www.paypal.com/cgi-bin/webscr" />
<%-- <c:set var="paypal_url" value="https://www.sandbox.paypal.com/cgi-bin/webscr" /> --%>
<form id="frmPaypal" name="frm_paypal" target="_blank" action="${paypal_url }" method="post">
	<input type="hidden" name="cmd" value="_xclick" />
	<input type="hidden" name="business" value="sauctionpay@seoulauction.com" />
	<input type="hidden" name="item_name" value="Seoul Auction - Regular Member" />
	<input type="hidden" name="item_number" value="" />
	<input type="hidden" name="currency_code" value="USD" />
	<input type="hidden" name="amount" value="${usd_price }" />
	<input type="hidden" name="charset" value="UTF-8" />
</form>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />