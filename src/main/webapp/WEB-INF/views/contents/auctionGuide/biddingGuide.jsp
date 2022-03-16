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
			<div class="sub_menu_wrap menu02">
				<div class="sub_menu">
					<jsp:include page="../include/howtoSubMenu.jsp" flush="false"/> 
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2 border">
						<h2>경매안내</h2>
						<p style="line-height:30px; font-size:16px;">서울옥션 미술품 경매는 지난 1998년부터 서울에서 시작해 지난 2008년에는 홍콩에 진출하였으며 매년 부산과 대구 등에서도 열리고 있습니다.</p>
                        <p style="line-height:30px; font-size:14px;">&bull;&nbsp;메이저 경매 : 3월, 6월, 9월, 12월에 서울에서 열리는 정기 경매로 한국 근현대 작품과 고미술품 등이 출품됩니다. <br/>
                       &bull;&nbsp;홍콩 경매 : 한국 근현대 작품을 세계 시장에 알리고 해외에 흩어진 고미술품을 환수하며 또한 해외 유명 작가의 작품이 출품되는 경매로 연간 3-4회 열립니다. <br/>
                       &bull;&nbsp;기획 경매 : 기획 경매는 부산, 대구 등의 지역 경매는 물론 신진 작가 소개 및 자선 경매 등 테마가 있는 기획 작품을 선보입니다. <br/>
                        </p>
					</div>
                    
                    <div class="bidding_step">
						<ul>
							<li>
								<div class="step">step<br>01</div>
								<dl><!-- 20150621 -->
									<dt>회원 가입</dt>
									<dd>
									</dd>
								</dl>
							</li>
							<li>
								<div class="step">step<br>02</div>
								<dl>
									<dt>프리뷰 관람</dt>
									<dd></dd>
								</dl>
							</li>
							<li>
								<div class="step">step<br>03</div>
								<dl>
									<dt>경매 응찰</dt>
									<dd></dd>
								</dl>
							</li>
							<li>
								<div class="step">step<br>04</div>
								<dl>
									<dt>낙찰</dt>
									<dd></dd>
								</dl>
							</li>
							<li>
								<div class="step">step<br>05</div>
								<dl>
									<dt>배송</dt>
									<dd></dd>
								</dl>
							</li>
						</ul>
					</div>
                    
					<div class="num_cont_wrap">
						<div class="num_cont bg101">
							<!--<div class="num odd">1</div>-->
							<div class="tit_h3">
								<h3>회원가입</h3>
								 <p style="line-height:30px; font-size:16px;">1. 서울옥션 미술품 경매는 정회원에 가입한 회원에 한해 응찰에 참여할 수 있습니다. <br/>
                                  2. 정회원 가입은 서울옥션 홈페이지 신청은 물론 전시 및 경매 현장에서도 가입 가능합니다. <br/>
                                  3. 정회원의 연회비는 국내 거주자 20만원, 해외 거주자 500USD이며 부가세는 별도입니다. <br/>
                                  4. 정회원 등록시 도록, 전시 안내 등의 간행물 수령은 물론 다양한 혜택을 받을 수 있습니다. <br/>
                                 ※ 단, 정회원에 현장가입되었더라도 서울옥션 홈페이지 회원에 가입되지 않은 회원은 온라인 경매에 참여하실 수 없으므로 온라인 경매 참여를 원할시 서울옥션 홈페이지 www.seoulauction.com에 회원 가입을 별도로 해 주시기 바랍니다.
                                  </p>
							</div>
							<!--<div class="list_style03">
								<ul>
									<li>
										<div class="tit">정회원</div>
										<p>정회원은 <strong>유료(연회비 국내회원 20만원, 국외회원 Usd 500, 배송비포함)</strong>로 운영되며 서울옥션이 발행하는 간행물(각종 도록, 전시 안내 등)의 무료 수신 외에도 다양한 혜택을 받으실 수 있습니다.</p>
									</li>
									<li>
										<div class="tit">준회원</div>
										<p>서울옥션 온라인 경매 응찰이 가능하며, 홈페이지 내의 경매 관련 정보 서비스를 받으실 수 있습니다.</p>
									</li>
								</ul>
							</div>-->
							<div class="box_style08 join_guide mt30">
								<h4 class="tit_arrow">회원가입 방법</h4>
								<div class="both_cont">
									<div>
										<div class="inner">										
											<div class="bg_img bg18">
												<div class="tit_border">홈페이지에서 가입</div>
												<p>서울옥션 홈페이지 회원가입시 회원 가입 절차에 따라 작성을 완료해 주시기 바랍니다.</p>
												
												<div class="btns"><span class="btn_style01"><a href="/join/agree">회원가입 바로가기</a></span></div>
												
												<p class="pt20">※ 기존에 홈페이지 준회원으로 가입하신 경우, 로그인 후 홈페이지 ACCOUNT에서 주황색 결제하기 버튼을 눌러 정회원을 신청해주시면 됩니다.</p> 
												<!--<div class="btns">
													<span class="btn_style01">
														<a href="/customer/myPage">MY Seoul Auction 고객유형이력보기</a>
													</span>
												</div>-->
                                              
											</div>
										</div>
									</div>
									<div>
										<div class="inner">										
											<div class="bg_img bg19">
												<div class="tit_border">전시/경매 현장 및 각 지점에서 가입</div>
												<p>서울옥션 본사 및 강남사옥, 홍콩 법인 등 방문 시 정회원 등록을 신청하시면 가입하실 수 있습니다. </p>
												<div class="list_style03 mt15">
													<ul>
														<li>
															<div class="tit">현장에서 회원가입 및 결제를 진행하신 경우,</div>
															<p>가입담당직원이 확인 후 정회원으로 승격하여 드립니다.<br>정회원 전환 문의: 대표번호 02-395-0330 이메일 : sos@seoulauction.com</p>
														</li>
														<li>
															<div class="tit">도록 뒷장에 신청서를 작성하며 FAX로 보내신 경우</div>
															<p>정회원 계좌안내 : 우리은행 1005-701-207754 서울옥션<br>
                                                            ※ 입금 뒤 전화하시면 회원 가입 여부를 신속하게 확인할 수 있습니다. <br/>
                                                            문의: 전화 02-395-0330 이메일 sos@seoulauction.com
<br/>
                                                            </p>
														</li>
													</ul>
												</div>
											</div>			
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //num_cont -->
						<!--<div class="num_cont bg109">
							<div class="num odd">2</div>
							<div class="tit_h3">
								<h3>서울옥션 경매 소개</h3>
							</div>
							<div class="list_style03">
								<ul>
									<li>
										<div class="tit">오프라인 경매</div>									
										<div class="list_style01">
											<ul>
												<li><strong>메이저경매</strong> : 한국 근현대, 고미술 작품들 및 해외 미술품 등을 경매합니다.</li>
												<li><strong>홍콩경매 </strong> : 한국, 미국, 유럽, 일본, 중국 등 전세계 유명작가의 작품을 경매합니다.</li>
												<li><strong>기획경매</strong> : 하나의 테마를 중심으로 봄과 가을 1년에 두 번 열립니다. 기업과 신진작가들과의 콜라보레이션 등 기존 경매와 차별화된 아이템으로 구성됩니다.</li>
											</ul>
										</div>
									</li>
									<li>
										<div class="tit">온라인 경매</div>
										<p>온라인 경매는 기존 경매보다 폭넓은 작가군과 합리적인 가격의 작품들을 선보입니다.<br>별도의 이용료 없이 간단한 인터넷 가입과 경매 전 본인인증만으로 참여 가능합니다.</p>
										<div class="btns">
											<span class="btn_style01">
												<a href="/currentAuction">현재 진행중인 경매 바로가기</a>
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
								<h3>프리뷰</h3>
								 <p style="line-height:30px; font-size:16px;">&bull;&nbsp;프리뷰는 경매에 출품된 모든 작품을 감상하고 상태를 확인할 수 있는 전시회입니다. <br/>
                                &bull;&nbsp;프리뷰 관람은 경매 응찰과 관계없이 누구나 무료로 관람이 가능합니다. <br/>
                                &bull;&nbsp;프리뷰 전시장에서 스페셜리스트에게 요청하시면 경매 작품에 대한 안내를 받으실 수 있습니다. <br/>
                                &bull;&nbsp;프리뷰 일정은 문자, SNS, 홈페이지, 도록(초대장) 등을 통해 공지 됩니다. 
                                </p>
							</div>
							<div class="list_style01" style="color:#F60;">
								<ul>
									<li>당사는 경매물품을 있는 그대로 출품합니다.</li>
									<li>경매되는 작품상태에 대한 보증은 경매 시점의 상태에 준합니다.</li>
									<li>전시를 통해 작품의 실물을 확인하였음을 전제로 진행합니다. </li>
									<li>프리뷰 전시를 통해 작품의 상태를 충분히 확인하시고 응찰하시길 권유합니다. </li>
								</ul>
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont join_guide guide02 bg103">
							<!--<div class="num odd">4</div>-->
							<div class="tit_h3">
								<h3>응찰방법</h3>
								<p style="line-height:30px; font-size:16px;">경매 응찰 방법은 아래와 같이 3가지 방법으로 가능합니다. 경매 응찰 후 해당 작품을 낙찰 받으시면 구매 취소가 어려우니 신중히 선택하시기 바랍니다. </p>
							</div>
							<div class="btn_filedown"><span class="btn_style01 gray03 xsmall icon02"><a href="/images/form/bidform_20220218.pdf" target="_blank">응찰등록신청서 (서면/전화) 받기</a><span class="ico download"></span></span></div> 
							<div class="box_style08">
								<h4 class="tit_arrow">오프라인 경매 응찰</h4> 
								<div class="both_cont tri">
									<div> 
										<div class="inner">										
											<div class="bg_img bg20">
												<div class="title">현장 응찰 / In Person</div>
												<p style="line-height:30px; font-size:16px;">경매 당일 현장에서 응찰 등록서 작성 후, 직접 패들을 부여 받으신 후 응찰.</p>
											</div>
										</div>
									</div>
									<div>
										<div class="inner">
											<div class="bg_img bg21">
												<div class="title">전화 응찰 / Telephone Bidding</div>
												<p style="line-height:30px; font-size:16px;">경매가 진행될 때 담당직원과 전화통화로 실시간 응찰.</p>
											</div>										
										</div>
									</div>
									<div>
										<div class="inner">
											<div class="bg_img bg22">
												<div class="title">서면 응찰 / Absentee Bidding</div>
												<p style="line-height:30px; font-size:16px;">접수된 서면(당사의 소정 양식에 따라 서면 으로 작품 희망가 최고 한도까지 제출하는 방식)은 보조경매사를 통해 대리 응찰.</p>
												<p class="mt10" style="line-height:30px; font-size:16px;">서면응찰자의 응찰금액이 동일할 경우에는 당사에 먼저 응찰서를 제출한 응찰자에게 낙찰됩니다.</p>
											</div>										
										</div>
									</div>
								</div>
								<!--<div class="border_space02">
									<h4 class="tit_arrow">온라인 경매 응찰</h4>
									<div class="wrap">
										<div class="list_style01">
											<ul>
												<li>온라인 경매의 프리뷰 기간 동안 홈페이지를 통해 응찰 가능하며, 경매 마감 시간부터 순차적으로 마감됩니다.</li>
												<li>경매 마감시간 30초 전에 응찰이 있을 경우, 자동으로 30초 연장됩니다.</li>
												<li>온라인 경매 회차에 따라 위 마감시간이 다를 수 있습니다.</li>
											</ul>
										</div>
										<div class="bid_online">
											<div class="title">온라인 응찰 / On-line Bidding</div>
											<div class="list_style03">
												<ul>
													<li>
														<div class="tit">응찰 / Bid </div>
														<p>주어진 금액에 따라 1회씩 응찰</p>
													</li>
													<li>
														<div class="tit">자동 응찰 / Automatic bid </div>
														<p>빈칸에 해당 작품에 대한 한도액을 미리 설정하여 자동으로 비딩 되는 방식.<br>상대 응찰자가 없으면 최소금액으로 낙찰.</p>
													</li>
												</ul>
											</div>
										</div>
										<div class="box_white">
											<p class="notice_style02">신중한 온라인 경매 응찰을 위하여 작품상태 확인 및 동의 절차를 거친 뒤 온라인 응찰을 진행하실 수 있습니다.</p>
										</div>
									</div>
								</div>-->
							</div> 
						</div>
						<!-- //num_cont -->
						<div class="num_cont bg110">
							<!--<div class="num odd">5</div>-->
							<div class="tit_h3">
								<h3>오프라인 응찰예약 안내</h3>
								<p style="line-height:30px; font-size:16px;">오프라인 경매 참여 시, 미리 경매참여 예약을 하실 수 있습니다.</p>
							</div>
							<div class="list_style03" style="line-height:30px; font-size:16px;"> 
								<ul>
									<li>
										<div class="tit">응찰등록신청서 제출</div>									
										<div class="list_style01">
											<ul>
												<li>경매의 서면 및 전화로 응찰을 원하는 회원분들은 도록 뒷부분에 있는 응찰등록 신청서를 작성해 제출해주시기 바랍니다.</li>
												<li>응찰 마감을 위한 서류 접수는 팩스를 통해 경매 전일 오후 7시까지 접수해주시기 바랍니다.</li>
											</ul>
										</div>
									</li>
									<li>
										<div class="tit">홈페이지 응찰예약 신청</div>									
										<div class="list_style01">
											<ul>
												<li>현장/서면/전화 응찰을 원하는 경우, 홈페이지에서 편리하게 작품응찰 신청이 가능합니다.</li>
                                                <li>홈페이지 가입 후 정회원이면 홈페이지에서 응찰 신청이 가능합니다.</li>
												<li>작품응찰신청 내역은 회원정보 > 예약 및 신청 > 응찰등록신청에서 확인하실 수 있습니다.</li>
                                                <li>응찰 마감은 홈페이지에서 가능하며 응찰신청은 경매 전일까지 접수 가능합니다.</li>
											</ul>
										</div>
									</li>
								</ul>
							</div>
							<!--<div class="btns">
								<span class="btn_style01">
									<a href="javascript:goBidReserve();">응찰등록신청 바로가기</a>
								</span>
							</div>-->
						</div>
						<!-- //num_cont -->
                        <div class="num_cont bg104">
							<!--<div class="num odd">5</div>-->
							<div class="tit_h3">
								<h3>낙찰</h3>
								<p style="font-size:16px; font-weight:600; line-height:30px;">1. 낙찰 및 우선 순위</p>
                                <p style="line-height:30px; font-size:16px;">내정가 이상으로 최고가를 제시한 응찰자에게 경매작품이 낙찰되며, 동일 금액의 경우 아래 기준에 따라 낙찰이 결정됩니다.<br/>
                                현장, 서면, 전화응찰자가 동일한 금액으로 경합할 경우에는 서면 > 현장 > 전화응찰자순으로 우선 순위가 주어집니다.</p>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600; line-height:30px;">2. 낙찰 확인</p>
                                <p style="line-height:30px; font-size:16px;">낙찰 시, 현장에서 낙찰확인서에 본인 서명을 반드시 해 주시기 바랍니다. <br/>
                                ※ 낙찰자는 낙찰을 철회할 수 없습니다. 부득이 철회를 하는 경우에는 낙찰일로부터 7일 이내에 서면으로 철회의사를 통보하고, 위약별로 낙찰가의 30%에 해당하는 금액을 낙찰일로부터 7일 이내에 납부하여야 합니다.
                                </p>
                                <div class="btns">
									<span class="btn_style01">
										<a href="/terms/page?view=auctionTerms" target="_blank" title="새창">경매약관 바로보기</a>
									</span>
								</div>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600; line-height:30px;">3. 구매 수수료</p>
                                <div class="list_style03 type02">
                                    <ul>
                                        <li>
                                            <strong>국내 경매</strong>
                                            <div class="list_style01">
                                                <ul>
                                                    <li>일괄 18% (부가세 별도)</li> 
                                                    
                                                </ul>
                                            </div>										
                                        </li>
                                        <li>
                                            <strong>홍콩 경매</strong>
                                            <div class="list_style01">
                                                <ul> 
                                                    <li>일괄 18%</li>
                                                </ul>
                                            </div>										
                                        </li>
                                    </ul>							
                                </div>
                                <div class="box_style07 type02 mt30">
                                    <div class="notice_style02">
                                        <strong>낙찰가(Hammer Price)</strong> : 경매사가 낙찰봉을 두드리면서 낙찰된 금액<br>
                                        <strong>구매가(Purchase Price)</strong> : 낙찰가 + 낙찰 수수료 + 부가가치세가 합산된 금액
                                    </div>
                                </div>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600; line-height:30px;">4. 결제 안내</p>
                                <p style="line-height:30px; font-size:16px;">낙찰받은 작품에 대한 총 구매대금 결제방법은 아래와 같습니다.<br/>
                                  ▶계좌 입금<br/>
                                  우리은행 1005-902-012409 (주)서울옥션 (입금 후 전화 확인 바랍니다)<br/>
                                  문의: 전화 02-395-0330 메일 sos@seoulauction.com<br/>
                                  * 계좌입금 시 입금 메모란에 실제 낙찰자의 이름을 명시해 주십시오. 입금자와 낙찰자의 이름이 일치하지 않을 경우, 입금확인이 어려울 수 있으며, 이에 대한 불이익은 서울옥션에서 책임지지 않습니다.<br/><br/>
                                  * 낙찰자는 경매후 7일(낙찰가 3억원 이상인 경우는 21일) 이내에 구매수수료를 포함한 금액을 입금하신 후 작품을 인수하시기 바랍니다.<br/>
                                  * 낙찰자는 응찰전 당사와의 합의에 의하여 구매대금을 분할 납부할 수 있습니다.<br/>
                                  * 낙찰자는 총 구매대금을 당사 지정의 은행계정송금, 자기앞수표, 현금 등으로 지불할 수 있습니다.
                                  
                                  </p>
							</div>
							
						</div>
						<!-- //num_cont -->
						<div class="num_cont bg105">
							<!--<div class="num">5</div>-->
							<div class="tit_h3">
								<!-- <h3>온라인경매 무료배송</h3>  -->
								<h3>작품의 수령, 배송, 설치 안내</h3>
							</div>
							<div class="list_style01" style="line-height:22px; font-size:16px;">
									
									<br><strong class="txt_green">* 낙찰자 작품 인수 방법</strong>
									<br><br>1. 경매의 낙찰작품은 <strong class="txt_green">담당자를 통해 </strong>일정을 확인 할 수 있습니다.
									<br><br>2. 작품 직접 수령장소 : <strong class="txt_green">서울시 종로구 평창30길 24 (평창동98번지) 서울옥션하우스 지하1층 수장고</strong>에서만 가능합니다.
									<br><br>3. 낙찰 작품의 <strong class="txt_green">희망 수령 날짜 하루 전까지</strong> '판매 담당자'와 <strong class="txt_green">방문일자 예약 필히</strong> 하신 후 방문 부탁드립니다. 
									<br>&nbsp;&nbsp;* 전일 방문 예약제로 운영하오니, <strong class="txt_green">예약없이 당일 방문시 작품 수령 불가능합니다.</strong>
									<br><br>4. 작품수령 가능 요일, 시간 : <strong class="txt_green">월요일 ~ 금요일</strong>(법정 공휴일 제외) / 당사 업무시간 오전 9시 ~ 6시 점심시간(오전 12시~오후1시) 제외.
									<br>&nbsp;&nbsp;* 낙찰자 승용차에 작품 상차시 참고 : 작품 전체 크기 <strong class="txt_red">90 × 118cm</strong>까지 가능함(캔버스 50호 크기)
									<br><br>5. 낙찰자 직접 작품 수령이 어려울 경우 당사는 <strong class="txt_green">낙찰자의 책임과 비용부담 하에</strong> 작품의 운송(미술품운송 전문업체)을 주선해드립니다.
									<br>&nbsp;&nbsp;* 작품 파손, 분실의 위험이 크므로 <strong class="txt_green">택배업체는 주선 안함</strong>.									
								
							</div>
						</div>
						<!-- //num_cont -->
						<!--<div class="num_cont">
							<div class="tit_h3">
								<h3>★ 기본 배송비 (편도)</h3>
							</div>
							<div class="box_style08">
								<div class="list_style01">
									<ul style="margin-left:20px;">
										<li style="font-weight:600; font-size:16px; line-height:24px;">서울 및 수도권 지역 무료 배송 진행</li>
										<li style="font-weight:600; font-size:16px; line-height:24px;">수도권 외 지역은 월 2회 운송사 지정 일정(주말 포함)에 맞춰 일괄 무료 배송 진행</li>
                                        <li style="font-weight:600; font-size:16px; line-height:24px;">상기 일정 외 개별 운송 진행 및 도서 산간(제주 포함)지역, 해외 운송의 경우 운송비 고객 부담 </li>
                                        <li style="font-weight:600; font-size:16px; line-height:24px;">특수 설치 및 추가 운송 인력 소요 작품의 경우 고객 비용 부담</li>
                                        <li style="font-weight:600; font-size:16px; line-height:24px;">배송 문의: 02-2075-4404</li>
									</ul>
								</div>
							</div>
                        </div>-->
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
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />