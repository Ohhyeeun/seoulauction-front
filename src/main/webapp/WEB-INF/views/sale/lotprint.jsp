<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../include/header.jsp" flush="false"/>



<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">		
				<div class="contents">
					<div class="tit_h2">
						<h2>Videos</h2>
					</div>
					<div class="cont_sitemap_wrap">
						<div class="cont_sitemap first">
							<div>
								<div class="tit_h3 through">
									<h3>경매</h3>
								</div>
								<ul>
									<li><a href="/currentAuction">진행경매</a></li>
									<li><a href="/upcomingAuction">예정경매</a></li>
									<li><a href="/resultAuction">경매결과</a></li>
									<!--<li><a href="/otherSales">전시판매</a></li>-->
								</ul>
							</div>
							<div>
								<div class="tit_h3 through">
									<h3>참여안내</h3>
								</div>
								<ul>
									<li><a href="/auctionGuide/page?view=biddingGuide">응찰안내</a></li>
									<li><a href="/auctionGuide/page?view=winningBidGuide">낙찰안내</a></li>
									<li><a href="/auctionGuide/page?view=commissionGuide">위탁안내</a></li>
									<li><a href="/auctionGuide/page?view=deliveryGuide">배송안내</a></li>
								</ul>
							</div>
							<div>
								<div class="tit_h3 through">
									<h3>서비스</h3>
								</div>
								<ul>
									<li><a href="/service/page?view=displayPlan">행사기획</a></li>
									<li><a href="/service/page?view=rentExhibitionCenter">전시장대여</a></li>
									<li><a href="/service/page?view=storageInsa">미술품보관</a></li>
									<li><a href="/service/page?view=corporationArtwork">기업미술품</a></li>
									<li><a href="/service/page?view=securedLoan">담보대출</a></li>
									<li><a href="/service/page?view=academyArtculture">아카데미</a></li>
<%--									<li><a href="/service/page?view=chinaArtwork">중국미술품감정</a></li>--%>
								</ul>
							</div>
							<div>
								<div class="tit_h3 through">
									<h3>서울옥션</h3>
								</div>
								<ul>
									<li><a href="/about/page?view=introduction">서울옥션소개</a></li>
									<li><a href="/about/page?view=history">연혁</a></li>
									<li><a href="/about/page?view=investRealtime">투자정보</a></li>
									<li><a href="/about/page?view=location">위치안내</a></li>
									<li><a href="/about/page?view=snsChannels">SNS채널</a></li>
									<li><a href="/noticeList">공지사항</a></li>
									<li><a href="/about/page?view=faq">FAQ</a></li>
								</ul>
							</div>
						</div>
						<div class="cont_sitemap">
							<div>
								<div class="tit_h3 through">
									<h3>이용안내</h3>
								</div>
								<ul>
									<li><a href="/terms/page?view=auctionTerms">경매약관</a></li>
									<li><a href="/terms/page?view=privateInfo">개인정보취급방침</a></li>
									<li><a href="/terms/page?view=infoManage">내부정보관리규정</a></li>
								</ul>
							</div>
							<div>
								<div class="tit_h3 through">
									<h3>언어지원</h3>
								</div>
								<ul>
									<li><a href="/?lang=ko">한국어</a></li>
									<li><a href="/?lang=en">ENG</a></li>
								</ul>
							</div>
							<div>
								<div class="tit_h3 through">
									<h3>SNS채널</h3>
								</div>
								<ul>
									<li><a target="_blank" href="https://www.facebook.com/seoulauction">Facebook</a></li>
									<li><a target="_blank" href="https://twitter.com/seoulauctionkr">Twitter</a></li>
									<li><a target="_blank" href="http://blog.naver.com/PostList.nhn?blogId=s_auction">Naver Blog</a></li>
									<li><a target="_blank" href="https://www.youtube.com/user/SeoulAuction">Youtube</a></li>
								</ul>
							</div>
							<div>
								
									
									
								<div class="tit_h3 through">
									<h3>로그인/회원가입</h3>
								</div>
								<ul>
									<li><a href="/login">로그인/회원가입</a></li>
								</ul>
									
								
							</div>
						</div>
						<div class="cont_sitemap">
							<div>
								<div class="tit_h3 through">
									<h3>패밀리사이트</h3>
								</div>
								<ul>
									<li><a target="_blank" href="http://www.printbakery.co.kr">프린트 베이커리</a></li>
									<li><a target="_blank" href="http://www.ganaart.com/">가나아트 갤러리</a></li>
									<li><a target="_blank" href="http://www.artpark.co.kr/ ">장흥 아트파크</a></li>
								</ul>
							</div>						
						</div>
					</div>
				</div>
			</div>
			<div style="display:none;">
				<span class="btn_style01 gray03 btn_modal pop08">
					<button type="button">회원탈퇴신청</button>
				</span>
			</div>

			<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li><img src="/images/img/img_sitemap.jpg" alt="작품1" class="img_master" /></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //#wrap -->

<jsp:include page="../include/footer.jsp" flush="false" />