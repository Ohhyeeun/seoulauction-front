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
						<h2>배송안내</h2>
						<p>결제까지 완료된 작품 배송에 대해 안내해 드립니다.</p>
					</div>
					<div class="num_cont_wrap">
						<div class="num_cont bg105">
							<!--<div class="num odd">2</div>-->
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

			<!-- <div class="sub_banner">
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