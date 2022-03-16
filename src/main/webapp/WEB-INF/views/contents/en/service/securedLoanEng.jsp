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
						<h2>Art Collateral Loans</h2>
						<p>SeoulAuction executes the loan with the security of art article and antique.<br>You Collectors are requested to have much concern.</p>
					</div>

					<div class="loan_step">
						<ul>
							<li class="first">
								<div class="step">step<br>01</div>
								<dl><!-- 20150621 -->
									<dt>Send Email</dt>
									<dd>
										 <p>A client sends images and information of artworks<br>to Seoul Auction's e-mail address.</p>
										 <div class="txt_mail" style="margin-bottom: 10px;"><a href="mailto:jlee@seoulauction.com">jlee@seoulauction.com</a></div> 
                                        <!-- <div class="txt_mail"><a href="mailto:leehh@seoulauction.com">leehh@seoulauction.com</a><br/> -->
										<p class="txt_dark"><strong>Title of an e-mail : 'Inquiry of Artwork - the sender's name' </strong></p> 
										<p class="txt_pale">※ Do not use the word ‘mortgage’ or<br>‘loan’ at the title of email. If you use the word,<br>email can be classified as spam.</p>
									</dd>
								</dl>
							</li>
							<li class="second">
								<div class="step">step<br>02</div>
								<dl>
									<dt>Specialist’s Reply</dt>
									<dd>The specialist in charge appraises the artwork and replies with the availability of lending.</dd>
								</dl>
							</li>
							<li>
								<div class="step">step<br>03</div>
								<dl>
									<dt>Artwork Valuation</dt>
									<dd>Receive the original artwork and appraises the authenticity and price.</dd>
								</dl>
							</li>
							<li>
								<div class="step">step<br>04</div>
								<dl>
									<dt>Notify Confirmation</dt>
									<dd>Confirm the availability of collateral loans.</dd>
								</dl>
							</li>
							<li>
								<div class="step">step<br>05</div>
								<dl>
									<dt>Visit and Submit</dt>
									<dd>Fill out the paperwork and visit Seoul Auction to submit the form.</dd>
								</dl>
							</li>
							<li class="last">
								<div class="step">step<br>06</div>
								<dl>
									<dt>Guide for Deposit</dt>
									<dd>After deliberation of the paperwork, the loan is paid within a week.</dd>
								</dl>
							</li>
						</ul>
					</div>

					<div class="loan_cont_wrap">
						<div class="section">
							<div class="tit_h3 noborder">
								<h3>Preparation of documents for personal customer</h3>
							</div>
							<div class="box_style08">
								<div class="list_style01">
									<ul>
										<li>Personal legal seal (stamp)</li>
										<li>Certification of personal legal (within to 3 months)</li>
										<li>Photocopy of identification</li>
										<li>Photocopy of money passbook</li>
									</ul>
									<ul>
										<li>Certification of amount of income (National Tax Service)</li>
										<li>Certification of full payment (National Tax Service)</li>
										<li>Certification of council taxes (district office)</li>
									</ul>
								</div>
							</div>
							<p class="notice_style02">Any default of national taxes is unavailable to apply.</p>
							<p class="notice_style01">Disapproval loan if at least one document is not exist.</p>
						</div>

						<div class="section">
							<div class="tit_h3 noborder">
								<h3>Preparation of documents for business corporation</h3>
							</div>
							<div class="box_style08">
								<div class="list_style01">
									<ul>
										<li>Certified photocopy of registration/license</li>
										<li>Certification of corporate of legal seal (within to 3 months)</li>
										<li>Corporate of legal seal</li>
										<li>Certified copy of corporate of the register (within 3 months)</li>
										<li>Certified copy of personal of the register (within 3 months)</li>
										<li>Photocopy of identification (president CEO)</li>
									</ul>
									<ul>
										<li>Photocopy of conference of directors</li>
										<li>Photocopy of money passbook</li>
										<li>A statement of audit (past year)</li>
										<li>Imposing tax of assessments of statement (past year)</li>
										<li>Certification of detailed imposing tax and payment of tax</li>
									</ul>
								</div>
							</div>
							<p class="notice_style02"><strong>If a person representing the president CEO : 1. Identification of your representative, 2. Legal seal of letter of attorney</strong></p>
							<p class="notice_style01">Disapproval loan if at least one document is not exist.</p>
						</div>

						<div class="section">
							<div class="tit_h3 noborder">
								<h3>Type of collateral</h3>
							</div>
							<p class="txt_dark lh20">artwork available for auction<br>(Example) Modern and contemporary Art, antiques <span class="txt_impo02">(Except for Chinese ceramics)</span></p>
						</div>

						<div class="section">
							<div class="tit_h3 noborder">
								<h3>Condition of Loan</h3>
							</div>
							<div class="tbl_style02 web_only">
								<table>
									<caption>Condition of Loan</caption>
									<colgroup>
										<col style="width:13%;" />
										<col style="width:17%;" />
										<col style="width:17%;" />
										<col style="width:17%;" />
										<col style="width:18%;" />
										<col />
									</colgroup>
									<thead>
										<tr>
											<th>Sort</th>
											<th>Interest Rate</th>
											<th>Overdue interest rate</th>
											<th>Regular Loan Period</th>
											<th>Charge Interest</th>
											<th>Loan limit</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>Default</td>
											<td>12% per year</td>
											<td>15% per year</td>
											<td>3 months</td>
											<td>Principle: Payment in advance</td>
											<td>50% of appraisal amount</td>
										</tr>
										<!--
										<tr>
											<td>Auction</td>
											<td>1% per month</td>
											<td>2% per month</td>
											<td>6 months</td>
											<td>Principle: Payment in advance</td>
											<td>150%</td>
										</tr>
										-->
									</tbody>
								</table>
							</div>
							<div class="tbl_style02 m_only m_tbl_z022">
								<table>
									<caption>Qualification</caption>
									<!--
									<colgroup>
										<col style="width:14%;" />
										<col style="width:43%;" />
										<col />
									</colgroup>
									-->
									<thead>
										<tr>
											<th>Sort</th>
											<th>Default</th>
											<!--<th>Auction</th>-->
										</tr>
									</thead>
									<tbody>
										<tr>
											<th>Interest Rate</th>
											<td>12% per year</td>
											<!--<td>1% per month</td>-->  
										</tr>  
										<tr>
											<th>Default Rate</th>
											<td>15% per year</td>
											<!--<td>2.5% per month</td>-->
										</tr>
										<tr>
											<th>Regular Loan Period</th>
											<td>3 months</td>
											<!--<td>6 months</td>-->
										</tr>
										<tr>
											<th>Charge Interest</th>
											<td>Principle: Payment in advance</td>
											<!--<td>Principle: Payment in advance</td>-->
										</tr>
										<tr>
											<th>Loan limit</th>
											<td>50% of appraisal amount</td>  
											<!--<td>150%</td>-->
										</tr>
									</tbody>
								</table>
							</div>
							<p class="txt_small">※ Conditions above are adjustable depending on each case.</p>
						</div>

						<div class="box_gray type01">
							<div class="contact">
								<div class="title">Contact</div>
								<div class="info">
									<div class="highlight"><strong>Lee J.H</strong></div> 
									<div class="tel"><strong class="tit">Tel</strong> <span><a href="tel:+82 (0)2-2075-4499">+82 (0)2 2075 4499</a></span></div> 
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:jlee@seoulauction.com">jlee@seoulauction.com</a></div>
                                    <!-- <div class="highlight"><strong>Lee H.H</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>+82-2-2075-4437</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:leehh@seoulauction.com">leehh@seoulauction.com</a></div> -->
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