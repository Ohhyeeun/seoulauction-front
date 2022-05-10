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
						<h2>FAQ</h2>
					</div>
					<div class="faq_list">
						<ul>
							
							
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">How to enable the automatic refresh function on the online auction page</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>1.	Click on “Settings” in Internet Explorer (icon shaped like a sprocket)<br/>2. Click on “Internet Options”<br/>3. Go to General -> Browsing history -> Settings<br/>4. Click “Every time I visit the webpage” under Temporary Internet Files<br/>5. OK (Save) <br/>6. OK (Save)  <br/><br/>
                                    <img src="/images/img/online_ie_en.jpg" style="width:100%; max-width:860px;"/> 
                                    </div>  
								</div> 
							</li> 
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">How do you make a consignment?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>art@seoulauction.com<br/>Please send the types of information listed below to art@seoulauction.com. The information you provide will be conveyed to the respective specialist, who will provide you with the relevant details.<br/>
                                    1. Name 2. Phone number 3. Title of artwork 4. Size of artwork 5. Description of how the artwork came into your possession 6. Photos of artwork (full and partial views, showing the signature, important parts, etc.) <br/>
                                    Please refer to the consignment guidelines page for further information. &nbsp;&nbsp;<a href="/auctionGuide/page?view=commissionGuide&lang=en" style="border:solid 1px #999999; color:#666; padding:3px;">Consignment</a></div>
								</div>  
							</li>					
							
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">I would like to bid in an auction.</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>There are three ways to make a bid in an auction: phone bid, written bid, and on-site (direct) bid.<br/><br/>
                                    1. Bid applications can be submitted at the exhibition venue during the preview period as well as on the Seoul Auction website. <br/>
                                    Regular registered members of Seoul Auction have the right to make auction bids. Immediately upon completing membership registration via the website, you are eligible to make phone or written bids.<br/>
                                    2. The bid period begins on the first day of the preview exhibition.<br/>
                                    3. For paper (facsimile) bids, the deadline is 7 p.m. on the day before the auction, while for online bid applications, it is 11:59 p.m. on the day before the auction.<br/>
                                    4. Members who wish to make a bid in person at the auction should reserve a seat and paddle in advance by phone.
                                    </div>
								</div>
							</li>					
							
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">What is the difference between associate and regular members?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>The difference between associate and regular members is the ability to make offline Auction bids.<br/><br/> 
1. Associate member (no membership fee): registered on Seoul Auction website as associate member and can use website services and make bids in online auctions.<br/> 
2. Regular member (membership fee): pays annual membership fee and can use website services and make bids in all Seoul Auction auctions (in case of successful bid, separate commission fee is charged), receive shipment-related services (auction catalogue, etc., during the one-year membership period), and participate in online auctions.<br/> 
* Auction catalogues serve as references to assist regular members in the bidding process. Catalogues are mailed to all regular members before each auction. <br/>
* Current members who are newly applying for regular membership (or have already applied for regular membership via the website but are still associate members because they have not paid the membership fee) should log in to the Seoul Auction website and click the orange payment button under “My Account” to complete the membership application process.</div>  
								</div> 
							</li>
                            
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">I would like to purchase a catalogue from a previous auction.</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>Seoul Auction does not sell its catalogues individually. Auction catalogues serve as references to assist regular members in the bidding process and are mailed to all regular members before each auction.<br/> 
	Regular members have a membership period of one year.<br/> 
	Those who wish to apply for regular membership should do so when renewing their membership application or, if they have already applied for associate membership via the website, should log in to the Seoul Auction website and reapply.</div>
								</div>
							</li>					
							
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">I applied for regular membership at the exhibition (auction) venue, but I still appear as an associate member on the website.</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>1.	Those who applied for regular membership via paper application form at an exhibition (auction) venue should also apply for regular membership via the Seoul Auction website and then contact the employee in charge or call Seoul Auction’s main landline (+82-2-2075-4422) to ensure that the online and offline applications are integrated into a single membership account. After confirmation, the membership status will be upgraded to regular membership.<br/> 
	2. Those who applied for associate membership on the website and then paid the regular membership fee in person should write down their ID next to their name on the application form. The employee in charge will then elevate the individual’s status to regular membership. <br/>
	3. Those who applied for regular membership on the website and then paid the regular membership fee in person after their online membership expired should also write their ID next to their name on the application form. The employee in charge will then elevate the individual’s status to regular membership.</div>
								</div> 
							</li>					
							
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="">How can I change my password?</a>
								</div>
								<div class="answer">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>After logging in to the Seoul Auction website, go to “My Page” under “Account” to change your password. After entering your new password twice and clicking “OK” at the bottom of the page, the password will be changed.<br/>
The new password will be applied after logging out for the last time with the previous password and logging in again.
<br/>
Log in  -> Account -> Change Information -> Password -> Sumit</div>
								</div>
							</li>		
                            
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">Should I pay entry fee to visit auctions and exhibitions?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>Seoul Auction’s auctions and exhibitions are open to anyone free of charge. People can sit in on auctions regardless of whether they actually make a bid. <br/>
	Auction and exhibition dates are posted on the Seoul Auction website.<br/>
	Auction bids can only be made by regular members. Those who wish to make a bid should visit to check the information on the website or make a separate inquiry.<br/>
	Those who wish to make a seat reservation, please make a phone call before the auction day.</div>
								</div>
							</li>	
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">What is the transfer income tax?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>When an individual transfers a painting or antique with a transferrable fee that exceeds KRW 60 million, the transfer income tax is levied.<br/>In the following cases, even when the transfer price exceeds KRW 60 million, the transfer income tax is not levied: income generated by the transfer of an artwork of a living Korean artist (alive as of the date of transfer), income generated by the transfer of a painting or antique designated as a national cultural property in accordance with the Cultural Properties Protection Law, and income generated by the transfer of an artwork to a museum or art museum.</div>  
								</div> 
							</li>
                           
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">I would like to know more about the import and export of high-value artworks.</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>Auctioned items may be restricted by Korean export laws or the export laws of other relevant countries. The responsibility for securing the permits necessary to bring auctioned items into or out of a given country lies solely with the bidder. In particular, items for which successful bids were made that are believed to be cultural heritage properties/relics of Korea are not permitted to be exported out of Korea, in accordance with the Cultural Properties Protection Law. The bidder must be fully aware of this fact before making a bid.</div>  
								</div> 
							</li>
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">How do I make an inquiry?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>Inquiries may be made to Seoul Auction in one of the three ways listed below.<br/><br/>1. 1:1 inquiry on the Seoul Auction website: Log in and go to “1:1 Inquiry” under “Account” to receive a response.<br/>2. Phone inquiry: Inquiries directed to main landline (02-395-0330) are answered promptly.<br/>3. Email inquiry: Inquiries regarding website use (info@seoulauction.com) or artwork consignment (art@seoulauction.com).</div>  
								</div> 
							</li>	
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">How can I resolve a video playback error?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>1. Refresh the page.<br/>2. Try using an HTML5 browser (Chrome, Edge, Firefox, etc.).<br/>3. Upgrade your browser to the latest version.<br/>4. Change your settings so that JavaScript is used for all websites.<br/>5. Delete your browser’s cache and cookies.<br/>6. Make sure that your speaker and other relevant devices are connected properly.</div>  
								</div> 
							</li>
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">What if I can’t get a mobile authorization code?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>(when using a Korean mobile phone number and Seoul Auction’s Korean language website)<br/>1. Applies to Android phones<br/>2. Go to the message list settings<br/>3. Block messages<br/>4. Blocked message<br/>5. Blocked number lists are visible.<br/>6. Select the relevant phone number and press “unblock”<br/>*If a mobile authorization pop-up appears in the auction list, it is because you are on the Korean language website.<br/>*If a mobile authorization pop-up appears in the auction list, it is because you are a global (foreign) member.</div>  
								</div> 
							</li>
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">What if I don’t receive an email after applying for membership?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>1. If you write your email address incorrectly, you will not receive an email.<br/>2. Please check your Spam folder.<br/>3. If you contact info@seoulauction.com to let us know that the email certification was not completed during your membership application process, we will address the problem in a timely manner.</div>  
								</div> 
							</li>
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">Q</span></span>
									<a href="#">I would like to get my subscription fee refund?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">A</span></span>
									<div>If you cancel your membership before the expiration of the validity period of your regular membership, you can receive a refund of the annual fee according to the criteria below.<br><br>

										Immediately after joining - Less than 1 month: Full refund<br>
										More than 1 month - Less than 3 months: 80% refund<br>
										More than 3 months - Less than 6 months: 60% refund<br>
										More than 6 months after joining: No refund
									</div>
								</div>
							</li>
							<!--<li>
                                <div class="question">
                                    <span class="sp_icon bul_question"><span class="hidden">Q</span></span>
                                    <a href="#">고객원격지원?</a>
                                </div>
                                <div class="answer" style="display: none;">
                                    <span class="sp_icon bul_answer"><span class="hidden">A</span></span>
                                    <div>1. 서울옥션 홈페이지에 문의가 있는경우 상담원의 필요의 의해 원격 지원을 할 수도 있습니다.<br/>2. 상담원과 통화중인 상태에서 고객님의 동의하에서만 지원이 가능합니다. (고객님의 컴퓨터에서 번호 동의가 없으면 지원이 불가합니다.)<br/>3. 아래의 주황색 버튼으로 접속해주세요.<br/>4. 크롬에서는 별도의 설치 파일이 필요합니다.<br/><br/><a href="https://113366.com/" target="new" style="background-color:#F93; color:#000; padding:5px;">고객원격지원</a></div>
                                </div>
                            </li>-->
						</ul>
					</div>
				</div>
			</div>

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li><img src="/images/img/img_menu04.jpg" alt="작품1" class="img_master" /></li>
					</ul>
				</div>
			</div>-->
		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />