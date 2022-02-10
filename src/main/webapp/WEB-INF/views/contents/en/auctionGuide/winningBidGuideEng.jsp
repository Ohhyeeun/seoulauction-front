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
				<button type="button" class="m_only btn_submenu"><span class="hidden">menu</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2 border">
						<h2>How To Buy</h2>
						<p>Did you get a successful bid of Auction works you wanted? Follow the instructions about the criteria of successful bid and process after the confirmation.</p>
					</div>
					<div class="num_cont_wrap">
						<div class="num_cont join_guide guide03">
							<div class="num odd">1</div>
							<div class="tit_h3">
								<h3>Successful Bid and Priority Order</h3>
								<p>Auction works are auctioned off to a bidder who presented the highest price. If there are more than two bidders who get the same amount, the successful bid will determine to the following instructions.</p>
							</div>
							<div class="box_style08 type02">
								<div class="both_cont">
									<div>
										<div class="inner">
											<h4 class="tit_arrow">Off-line Auction</h4>
											<p>If the bidders who applied at the auction house, written report, or phone call have a competition with another bidder who has the same amount, the priority order will determine in the order of <strong class="txt_green">written &gt; Auction house &gt; Phone call.</strong></p>
										</div>
									</div>
									<div>
										<div class="inner">
											<h4 class="tit_arrow">Online Auction</h4>
											<p>Priority order of successful online auction is granted to <strong class="txt_green">Automatic bidding &gt; Bidding.</strong></p>
											<p>If the bidders who has the bidding price, priority order is granted to a person who submit bidding price first by server time.</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont">
							<div class="num">2</div>
							<div class="tit_h3">
								<h3>Confirmation of Successful Bidding</h3>
								<p>When you get the bid successfully at Off-line auction, you should write the signature on the confirmation of successful bid at the auction place. Otherwise, when you get the bid successful at online auction, you will get the confirmation email successfully.<br><strong class="txt_green txt_under">Log in &gt; My Account &gt; Auction Transactional Information &gt; Purchase List</strong></p>
								<p>When you inevitably need to withdraw the objects, the bidder should notify the intention of withdrawal with a document within 7 days from the day of successful bid.</p>
								<div class="btns">
									<span class="btn_style01">
										<a href="/terms/page?view=auctionTerms" target="_blank" title="Terms"> Terms</a>
									</span>
								</div>
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont">
							<div class="num odd">3</div>
							<div class="tit_h3">
								<h3>Commission</h3>
								<p>The commission fee for the succeeded bid is set according to the following policy, but the other rate of commission can be applied through the internal policy.</p>
							</div>
							<div class="list_style03 type02">
								<ul>
									<li>
										<strong>Seoul(Domestic) Auction Purchase Fee</strong>
										<div class="list_style01">
											<ul>
												<li>15% of hammer price(tax excluded)</li>
												
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
						</div>
						<!-- //num_cont -->
						<div class="num_cont join_guide guide03">
							<div class="num">4</div>
							<div class="tit_h3">
								<h3>Settlement</h3>
							<!--	<p>The auctioned off Items should be paid as follows.</p>
							</div>
							<div class="box_style08 type02">
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
							</div>-->
                            <div class="list_style03 type03">
								<ul>
									<li><strong>Inquiry email </strong><span> : <a href="mailto:info@seoulauction.com">info@seoulauction.com</a></span></li>
									<li><strong> HEAD OFFICE. SEOUL </strong><span> : +82 (0)2 2075 4422 (English)</span><span>  +82 (0)2 2075 4385 (中國語)</span></li>
								</ul>
							</div>
							<div class="list_style01 mt15">
								<ul>
									<li>Winning bidder should pay the buying commission within 7 days after the day of auction(If the purchasing price is more than KRW 3,000,000,000 won, please pay within 21 days) then, pick up your art works/objects.</li>
									<li>Winning bidder can make the purchase fee to divided payment by agreement with Seoul Auction before bidding.</li>
									<li>Winning bidder can pay the total purchase price by bank transfer, cheque, cash, etc. </li>
									<li>Online auction is available to pay the purchase at website. (Please check the ailable payment card 'Visa, MASTERCARD...')</li>
									<li>If you want to pay by credit card which is  payment card, you can visit Seoul Auction office(Head office at Pyeongchang-dong/ Gangnam branch). When you give the notification in advance our accounting team will assist you.</li>
									
								</ul>
							</div>
						</div>
						<!-- //num_cont -->
					</div>
					<!-- //num_cont_wrap -->
				</div>
			</div>


		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />