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
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
					<jsp:include page="../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>투자정보</h2>
						<p>국내외 예술품 경매 시장의 성장세와 더불어 안정적이고 장기적인 성장 전략을 수립하여 추진함으로써, <br>주주가치와 기업가치의 극대화를 실현해 나갑니다.</p>
					</div>	

					<div class="tab_wrap type02">
						<ul>
							<li class="tab"><a href="/about/page?view=investRealtime">실시간 주가상황</a></li>
							<li class="tab"><a href="/about/page?view=investFinance">재무정보</a></li>
							<li class="tab sele"><a href="#">공시정보</a></li>
							<!-- <li class="tab"><a href="/about/page?view=investIR">IR 정보</a></li> -->
						</ul>
						<div class="cont">
							<div class="invest_area"><!-- 20150630 -->
								<div>
									<!--  <iframe src="http://asp2.krx.co.kr/IR/HtmlService/063170/discls_info.jsp" width="700px" height="500px" scrolling="no" frameborder=0 z-index="-20"></iframe> -->
									<jsp:include page="./include_krx/disInfo.jsp" flush="false"/>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/img/img_menu04.jpg" alt="" class="img_master">
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