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
						<h2>Investor Relations</h2>
						<p>Together with the growth of home and abroad artwork auction market, we establish a stable and long-term growth strategy, and realize the maximization of stockholder values and corporate values.</p>
					</div>	

					<div class="tab_wrap type02">
						<ul>
							<li class="tab"><a href="/about/page?view=investRealtime">Real-Time Stock Quotes</a></li>
							<li class="tab"><a href="/about/page?view=investFinance">Financial Information</a></li>
							<li class="tab sele"><a href="/about/page?view=investAnnounce">Disclosure Information</a></li>
							<li class="tab"><a href="/about/page?view=investIR">IR Information</a></li>
						</ul>
						<div class="cont">
							<div class="invest_area"><!-- 20150630 -->
								<div>
									<!--   <iframe src="http://asp2.krx.co.kr/IR/HtmlService/063170/discls_info.jsp" width="700px" height="500px" scrolling="no" frameborder=0 z-index="-20"></iframe> -->
									<jsp:include page="./include_krx/disInfoEng.jsp" flush="false"/>
								</div>
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