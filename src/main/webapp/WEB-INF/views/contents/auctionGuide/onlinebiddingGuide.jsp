<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">

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
						<h2>온라인 경매 안내</h2>
						<p>서울옥션이 국내 최초로 시작한 온라인 경매는 폭넓은 작가군과 합리적인 가격의 작품을 선보입니다.<br/>
                        미술품과 더불어 명품 및 주얼리, 오디오, 디자인가구, 피규어 등 누구나 쉽게 경매에 참여할 수 있는 라이프스타일 아이템을 선보입니다.</p>
					</div>
					<div class="num_cont_wrap">
						<div class="num_cont">
							<div class="num">1</div>
							<div class="tit_h3">
								<h3>회원가입</h3>
								<p>서울옥션 미술품 온라인 경매는 별도의 가입비 없이 홈페이지에서 회원 가입 후 경매 전 본인인증을 마치면 누구나 참여 가능합니다. <br/> 
                                <a href="/currentAuction" class="btn_main_more sky" style="width:180px;margin-top:10px; padding-bottom:10px; margin-bottom:10px;" target="new">현재 진행중인 경매 바로가기</a>  <br/> 
                                단, 오프라인 미술품 경매는 정회원(유료 회원)에 가입한 회원에 한해 응찰에 참여하실 수 있습니다. </p>
							</div>

						</div>

						<div class="num_cont">
							<div class="num odd">2</div>
							<div class="tit_h3">
								<h3>프리뷰 관람</h3>
								<p>&bull;&nbsp;프리뷰는 경매에 출품된 모든 작품을 감상하고 상태를 확인할 수 있는 전시회입니다. <br/> 
                                &bull;&nbsp;프리뷰 관람은 경매 응찰과 관계없이 누구나 무료로 관람이 가능합니다. <br/> 
                                &bull;&nbsp;프리뷰 전시장에서 스페셜리스트에게 요청하시면 경매 작품에 대한 안내를 받으실 수 있습니다. <br/> 
                                &bull;&nbsp;프리뷰 일정은 문자, SNS, 홈페이지, 도록(초대장) 등을 통해 공지 됩니다. <br/> 
                                </p>
							</div>
							<div class="list_style01">
								<ul>
									<li>당사는 경매물품을 있는 그대로 출품합니다.</li>
									<li>경매되는 작품상태에 대한 보증은 경매 시점의 상태에 준합니다.</li>
									<li>전시를 통해 작품의 실물을 확인하였음을 전제로 진행합니다. </li>
									<li>따라서 경매 시작 전 프리뷰(PREVIEW) 기간 중 충분히 상태를 확인하신 후 응찰하시길 권유합니다.</li>
								</ul>
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont join_guide guide02">
							<div class="num">3</div>
							<div class="tit_h3">
								<h3>응찰</h3>
								<p>&bull;&nbsp;프리뷰 전시 기간 동안 홈페이지를 통해 응찰 가능하며, 경매 마감 시간부터 lot 번호 순차적으로 마감됩니다. <br/>
                                &bull;&nbsp;경매 마감시간 30초 전에 응찰이 있을 경우, 자동으로 30초 연장 됩니다. <br/>
                                &bull;&nbsp;온라인 경매 회차에 따라 위 마감 시간이 다를 수 있습니다.<br/>
                                </p>
                                <p>&loz; 온라인 경매 전, 익스플로러를 사용 하시는 경우 설정을 확인해 주시기 바랍니다.&nbsp;
                                <a href="/images/img/online_ie.jpg" class="btn_main_more yellow" style="width:260px;margin-top:10px; padding-bottom:10px; margin-bottom:10px;" target="new">온라인 경매 페이지 자동 새로고침 해결 방법</a> 
                                </p>
							</div>

							<div class="box_style08">
								<h4 class="tit_arrow">온라인 경매 응찰 /On-line Bidding</h4>
                                
								<div class="both_cont">
									<div>
										<div class="inner">										
											<div class="bg_img bg23">
												<div class="title">수동응찰 / Bid</div>
												<p>주어진 금액에 따라 1회씩 응찰</p>
											</div>
										</div>
									</div>
									<div>
										<div class="inner">
											<div class="bg_img bg23">
												<div class="title">자동응찰 / Automatic bid</div>
												<p>작품의 한도액을 미리 설정해 자동으로 응찰<br/>
                                                *자동응찰의 경우 응찰자가 없으면 최소 금액으로 낙찰됩니다. </p>
											</div>										
										</div>
									</div>
								</div>
								<div class="border_space02">
									<h4 class="tit_arrow">온라인 경매 응찰</h4>
									<div class="wrap">
										<div class="list_style01">
											<ul>
												<li>온라인 경매의 프리뷰 기간 동안 홈페이지를 통해 응찰 가능하며, 경매 마감 시간부터 순차적으로 마감됩니다.</li>
												<li>경매 마감시간 30초 전에 응찰이 있을 경우, 자동으로 30초 연장됩니다.</li>
												<li>온라인 경매 회차에 따라 위 마감시간이 다를 수 있습니다.</li>
                                                <li>동의 절차를 거친 뒤 온라인 응찰을 진행하실 수 있습니다.</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont">
							<div class="num odd">4</div>
							<div class="tit_h3">
								<h3>낙찰</h3>
                                <br/><br/>
								<p style="font-size:16px; font-weight:600;">1 낙찰 및 우선 순위</p>
                                <p>경매 낙찰은 시작 후 최고가를 제시한 응찰자에게 경매작품이 낙찰되며, 자동응찰 > 수동 응찰 순으로 우선적으로 낙찰 기회가 주어집니다.<br/>
                                동일한 금액의 응찰이 발생할 경우 서버시각에 따라 먼저 응찰금액을 입력하신 분에게 우선 순위가 주어집니다.<br/>
                                응찰 시 응찰 단위 기준으로 금액이 상승합니다</p>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600;">2 낙찰 확인</p>
                                <p>낙찰 시, 이메일로 낙찰확인서가 발송 됩니다. 혹은 홈페이지 로그인 > 회원정보 > 경매거래내역 > 구매내역에서 낙찰 금액 및 수수료를 확인 하실 수 있습니다. <br/>
                                낙찰자는 낙찰을 철회할 수 없습니다. 부득이 철회를 하는 경우에는 낙찰일로부터 7일 이내에 서면으로 철회의사를 통보하고, 위약별로 낙찰가의 30%에 해당하는 금액을 낙찰일로부터 7일 이내에 납부하여야 합니다.
                                </p>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600;">3 구매 수수료</p>
                                <p>낙찰가에 따른 낙찰수수료는 기본적으로 아래의 방침을 따릅니다. 단, 내부정책에 따라 다른 수수료율이 적용되는 경우가 있습니다.<br/>
                                온라인 경매 일괄 18% (부가세 별도)<br/>
                                낙찰가(Hammer Price) : 경매사가 낙찰봉을 두드리면서 낙찰된 금액<br/>
                                구매가(Purchase Price) : 낙찰가 + 낙찰 수수료 + 부가가치세가 합산된 금액
                                </p>
                                <br/><br/>
                                <p style="font-size:16px; font-weight:600;">4 결제 안내</p>
                                <p>낙찰받은 작품에 대한 총 구매대금 결제방법은 아래와 같습니다.<br/>
                                  ▶계좌 입금<br/>
                                  우리은행 1005-200-281649 (주)서울옥션 (입금 후 전화 확인 바랍니다)<br/>
                                  문의: 전화 02-395-0330 메일 sos@seoulauction.com<br/>
                                  * 계좌입금 시 입금 메모란에 실제 낙찰자의 이름을 명시해 주십시오. 입금자와 낙찰자의 이름이 일치하지 않을 경우, 입금확인이 어려울 수 있으며, 이에 대한 불이익은 서울옥션에서 책임지지 않습니다.<br/><br/>
                                  ▶홈페이지 결제<br/>
                                  온라인 경매의 작품은 홈페이지 내에서 카드 결제가 가능합니다. 고가품의 경우 카드사의 방침에의해 결제가 불가능할 수 있습니다. <br/>
                                  낙찰자는 로그인 후, 낙찰내역 확인과 결제를 진행해 주시기 바랍니다. <br/><br/>
                                  ▶방문결제<br/>
                                  온라인 결제가 불가능한 카드로 결제를 원하실 경우, 서울옥션 (평창동 본사)에  방문 후결제가 가능합니다.<br/>
                                  사전에 결제 문의를 주시면 담당자가 관련 안내 드리겠습니다.<br/>
                                  * 낙찰자는 경매후 7일(낙찰가 3억원 이상인 경우는 21일) 이내에 구매수수료를 포함한 금액을 입금하신 후 작품을 인수하시기 바랍니다.<br/>
                                  * 낙찰자는 응찰전 당사와의 합의에 의하여 구매대금을 분할 납부할 수 있습니다.<br/>
                                  * 낙찰자는 총 구매대금을 당사 지정의 은행계정송금, 자기앞수표, 현금 등으로 지불할 수 있습니다.
                                  
                                  </p>
							</div>
							
						</div>
						<!-- //num_cont -->
						<div class="num_cont">
							<div class="num">5</div>
							<div class="tit_h3">
								<!-- <h3>온라인경매 무료배송</h3>  -->
								<h3>작품의 수령, 배송, 설치 안내</h3>
							</div>
							<div class="list_style01" style="line-height:22px; font-size:14px;">
									
									<br><strong class="txt_green">* 낙찰자 작품 인수 방법</strong>
									<br><br>1. 경매의 낙찰작품은 <strong class="txt_green">구매자 직접 작품수령</strong>을 원칙으로 합니다.
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
						<div class="num_cont bg03">
							<div class="tit_h3">
								<h3>★ 기본 배송비 - 1점 기준 (편도)</h3>
							</div>
							<div class="box_style08">
								<div class="list_style01">
									<ul style="margin-left:20px;">
										<li style="font-weight:600; font-size:16px; line-height:24px;">서울 : 5만원 / 점</li>
										<li style="font-weight:600; font-size:16px; line-height:24px;">수도권 : 10만원 / 점</li>
                                        <li style="font-weight:600; font-size:16px; line-height:24px;">그 외 지역 : 15만원 / 점 (도서산간지역 비용 추가)</li>
                                        <li style="font-weight:600; font-size:16px; line-height:24px;">제주도 : 별도문의</li>
                                        <br><br>
                                        <p style="line-height:32px;"><font style="font-size:20px; color:#F30; font-weight:600;"> * 추가1점당 +1만원 (단, 동일 시간/장소일 경우)</font><br>
                                             &nbsp; &nbsp; &nbsp;예) 서울권 3점 낙찰시 : 5만원(서울 기본 배송료) + 2만원 (추가 2점 각 1만원씩 x 2 ) = 총 7만원 배송료 지불.</font></p>
						             	<p style="line-height:32px;"><font style="font-size:20px;font-weight:600;">★ 작품의 설치  - 별도비용 발생 (현장 기사님에게 추가비용 지불)</font></p>
                                        <p style="line-height:32px;"><font style="font-size:20px;font-weight:600;">★ 추가 인원이 필요한 작품은 별도비용 발생 (현장 기사님에게 추가비용 지불)</font></p>
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
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />