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
						<h2>Consignment Appraisal of Chinese Art</h2>
						<p>Seoul Auction handles consignment appraisals of Chinese artworks to be featured in our auctions.<br/>
An artwork is deemed eligible for inclusion in an auction when it meets the criteria set by Seoul Auction as confirmed by an expert.<br/>We welcome inquiries from all holders of Chinese artworks.
</p>
					</div>

					<div class="loan_step type02">
						<ul>
							<li>
								<div class="step">step<br>01</div>
								<dl>
									<dt>Submission of an online application</dt>
									<dd>
										<p>Apply for a membership on the Seoul Auction website<br/>→ upload photo(s) and document(s) under “Inquiry” of “Consignment Appraisal of Chinese Art”<br/>
Confirmation of receipt of the application sent (within 1 to 7 business days from submission date)<br/>
Inquiry regarding the artwork made to an overseas expert (15 to 30 days after submission of application)
</p>
										<!--<div class="txt_mail"><a href="mailto:beijing@seoulauction.com">beijing@seoulauction.com</a></div>-->
										<!--<p class="txt_dark"><strong>E-mail : ‘Chinese Art - Your Name’</strong></p>-->
									</dd>
								</dl>
							</li>
							<li>
								<div class="step">step<br>02</div>
								<dl>
									<dt>Decision on whether the artwork is appropriate for sale at auction</dt>
									<dd>Check notification of decision through “Inquiry” section of the Seoul Auction website</dd>
								</dl>
							</li>
							<li>
								<div class="step">step<br>03</div>
								<dl>
									<dt>Appraisal</dt>
									<dd>Appraisal once the artwork is evaluated as an auctionable artwork</dd>
								</dl>
							</li>
							<li class="last">
								<div class="step">step<br>04</div>
								<dl>
									<dt>Participation in the auction</dt>
									<dd>Consignment handling by Seoul Auction Hong Kong Sale or overseas auction house Artwork featured in the auction </dd>
								</dl>
							</li>
						</ul>
					</div>

					<div class="loan_cont_wrap">
						<div class="section">
							<div class="tit_h3 noborder">
								<h3>1. Artworks eligible for consignment appraisal</h3>
							</div>
							<div class="list_style01">
								<ul>
									
									<li>Antique paintings and calligraphic works, modern/contemporary artworks (paintings, sculptures, and installations)</li>
								</ul>
							</div>
						</div>
                        <div class="section">
							<div class="tit_h3 noborder">
								<h3>2. Items required for consignment appraisal</h3>
							</div>
							<div class="list_style01">
								<ul>	
									<li>Evidential document<br/>
                                    (must submit one of the following: artwork warranty, exhibition catalogue, or evidence of inclusion in a Korean or overseas auction and/or exhibition)
                                    </li>
                                    <li>List that includes the artist’s name, title of artwork, year created, size of artwork, and a brief explanation of how the artwork came into the owner’s possession</li>
                                    <li>One high-resolution JPEG image file per artwork<br/>
                                    * Photo requirements<br/>
                                    For two-dimensional artwork (painting or calligraphic work): one photo that shows the entire artwork (including mounting and/or frame)<br/>
                                    Seal and calligraphy must be clearly visible after photo enlargement.<br/>
                                    For three-dimensional artwork (etc.): one full-size photo per side, one photo of the base (side view), and one photo of the underside of the base
                                   Sculpture, etc.: one photo of full façade and rear view, one photo each of the top and bottom views, and one photo of signature<br/>
                                   <span style="color:#F00">--If the attached evidential documents and/or photos are insufficient, an inquiry will not be conducted (notification will not be sent to the individual (owner of the artwork) who submitted the evidential documents/photos).</span>

                                    </li>
								</ul>
							</div>
						</div>
                        <div class="section">
							<div class="tit_h3 noborder">
								<h3>3. Appraisal inquiry method/procedure</h3>
							</div>
							<div class="list_style01">
								<ul>
									<li>Apply for a membership on the Seoul Auction website → post photo(s) and/or document(s) under “Inquiry” (“Service” → “Consignment Appraisal of Chinese Art” → “Inquiry”)</li>
                                    <li>Confirmation of receipt of application (within 1 to 7 business days from submission date)</li>
                                    <li>Inquiry made to an overseas expert (15 to 30 days after receipt of application)</li>
                                    <li>Check the Seoul Auction website under “Inquiry” to see whether your artwork has been evaluated as auctionable</li>
                                    <li>If your item meets our eligibility criteria, Seoul Auction will conduct an appraisal of the artwork.</li>
                                    <li>Seoul Auction will negotiate the auction estimate with you before making a consignment decision (in case of consignment, 0.2% of insurance fee is accepted as commission)</li>
                                    <li>Artwork is then featured in an auction</li>
                                    <li>Fee calculation → imposition of consignment commission (10% of contract/bid price (VAT excluded), transfer tax may be levied depending on the artwork)</li>
								</ul>
							</div>
						</div>
                        <div class="section">
							<div class="tit_h3 noborder" style="padding-top:40px;">
								<h3>4. Appraisal of the artwork</h3>
							</div>
                            <div class="list_style01">
								<ul>
									<li>Appraisal of the artwork: payment of appraisal fee required (*waived if artwork is consigned for the auction) → Art appraisal statements are not issued.</li>
								</ul>
							</div>
							<div class="box_style08">
								<div class="list_style03">
									<ul>
										<li>Calligraphic work: 	KRW 100,000</li>
										<li>Painting: 		KRW 200,000</li>
                                        <!-- <li>Ceramic: 		KRW 200,000</li>  -->
                                        <li>Album of paintings: 	KRW 300,000</li>
                                        <li>(Prices are per piece)</li>
                                        <li>(Bank account of Seoul Auction’s Management Control Division for wire transfers: Woori Bank 1005-801-015803)</li>
                                        <li>--Schedule for artwork appraisal will be discussed.</li>
									</ul>
								</div>
							</div>
							
						</div>

						<div class="box_gray type01">
							<div class="contact">
								<div class="title">Contact</div>
								<div class="info">
									<div class="highlight">Specialist <strong>U.J. JANG</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>Office +82-2-2075-4391</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:ujin0618@seoulauction.com">ujin0618@seoulauction.com</a></div>
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
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />