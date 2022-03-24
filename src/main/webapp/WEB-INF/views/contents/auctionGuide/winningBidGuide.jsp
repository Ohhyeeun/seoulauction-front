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
						<h2>낙찰안내</h2>
						<p>원하시는 경매 작품을 낙찰 받으셨나요? 낙찰 기준 및 확정 후의 절차와 내용에 대해 안내해 드립니다.</p>
					</div>
					<div class="num_cont_wrap">
						<div class="num_cont bg104">
							<!--<div class="num odd">5</div>-->
							<div class="tit_h3">
								<h3>낙찰 및 우선 순위</h3>
								<p>내정가 이상으로 최고가를 제시한 응찰자에게 경매작품이 낙찰되며, 동일 금액의 경우 아래 기준에 따라 낙찰이 결정됩니다.</p>
							</div>
							<div class="box_style08 type02">
								<div class="both_cont">
									<div>
										<div class="inner">
											<h4 class="tit_arrow">오프라인 경매</h4>
											<p>현장, 서면, 전화응찰자가 동일한 금액으로 경합할 경우에는 <br><strong class="txt_green">서면 &gt;  현장 &gt; 전화응찰자</strong>순으로 우선 순위가 주어집니다. </p>
										</div>
									</div>
									<div>
										<div class="inner">
											<h4 class="tit_arrow">온라인 경매</h4>
											<p>온라인 경매 낙찰 우선순위 <strong class="txt_green">자동응찰 &gt; 응찰</strong> 순으로 우선 순위가 주어집니다.</p>
											<p>동일한 금액의 응찰이 발생할 경우 서버시각에 따라 먼저 응찰금액을 입력하신 분에게 우선 순위가 주어집니다.</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont">
							<div class="num">2</div>
							<div class="tit_h3">
								<h3>낙찰 확인</h3>
								<p>오프라인 경매의 경우 낙찰 시, 현장에서 낙찰확인서에 싸인을 받게 됩니다. 온라인 경매의 경우 낙찰 시, 이메일로 낙찰확인서가 발송 됩니다.<br><strong class="txt_green txt_under">홈페이지 로그인 &gt; 회원정보 &gt; 경매거래내역 &gt; 구매내역</strong>에서 낙찰 금액 및 수수료를 확인 하실 수 있습니다.</p>
								<p>낙찰자는 낙찰을 철회할 수 없습니다. 부득이 철회를 하는 경우에는 낙찰일로부터 7일 이내에 서면으로 철회의사를 통보하고,<br>위약별로 낙찰가의 30%에 해당하는 금액을 낙찰일로부터 7일 이내에 납부하여야 합니다.</p>
								<div class="btns">
									<span class="btn_style01">
										<a href="/terms/page?view=auctionTerms" target="_blank" title="새창">경매약관 바로보기</a>
									</span>
								</div>
							</div>
						</div>
						<!-- //num_cont -->
						<div class="num_cont">
							<div class="num odd">3</div>
							<div class="tit_h3">
								<h3>낙찰수수료</h3>
								<p>낙찰가에 따른 낙찰수수료는 기본적으로 아래의 방침을 따릅니다. 단, 내부정책에 따라 다른 수수료율이 적용되는 경우가 있습니다.</p>
							</div>
							<div class="list_style03 type02">
								<ul>
									<li>
										<strong>국내 오프라인 경매</strong>
										<div class="list_style01">
											<ul>
												<li>일괄 18% (부가세 별도)</li>  
											</ul>
										</div>										
									</li>
                                    <li>
										<strong>온라인경매</strong>
										<div class="list_style01">
											<ul>
												<li>일괄 18% (부가세 별도)</li> 
											</ul>
										</div>	 									
									</li>
									<li>
										<strong>홍콩경매 구매수수료</strong>
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
						</div>
						<!-- //num_cont -->
						<div class="num_cont join_guide guide03">
							<div class="num">4</div>
							<div class="tit_h3">
								<h3>결제 안내</h3>
								<p>낙찰받은 작품에 대한 총 구매대금 결제방법은 아래와 같습니다. </p>
							</div>
                            <div class="box_style08 type02">
								<div class="both_cont">
									<div>
										<div class="inner">
											<h4 class="tit_arrow">방문결제</h4>	
											<p>서울옥션 사무실(평창동 본사) 방문결제 가능합니다.<br>사전에 결제 문의를 주시면 담당자가 관련 안내 드리겠습니다.</p>
										</div>
									</div>
									<div>
										<div class="inner">
											<h4 class="tit_arrow">계좌입금</h4>	
											<p class="account">[오프라인 경매]<br/><span>우리은행 1005-902-012409 </span><span>서울옥션 (입금뒤 전화주세요)</span></p><br/>
                                            <p class="account">[온라인 경매]<br/><span>우리은행 1005-200-281649 </span><span>서울옥션 (입금뒤 전화주세요)</span></p>
										</div>
									</div>
								</div>
							</div>
							<div class="list_style01 mt15">
								<ul>
									<li>낙찰자는 경매후 7일(낙찰가 3억원 이상인 경우는 21일) 이내에 구매수수료를 포함한 금액을 입금하신 후 작품을 인수하시기 바랍니다.</li>
									<li>낙찰자는 응찰전 당사와의 합의에 의하여 구매대금을 분할 납부할 수 있습니다.</li>
									<li>낙찰자는 총 구매대금을 당사 지정의 은행계정송금, 자기앞수표, 현금 등으로 지불할 수 있습니다.</li>
									
									<li><strong>대표전화 02-395-0330</strong></li>
								</ul>
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