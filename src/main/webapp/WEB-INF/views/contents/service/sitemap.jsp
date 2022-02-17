<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="../../include/header.jsp" flush="false"/>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
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
						<h2>Sitemap</h2>
					</div>
					<div class="cont_sitemap_wrap"> 
						<div class="cont_sitemap first"> 
							<div>
								<div class="tit_h3 through">
									<h3>경매</h3>
								</div>
								<ul> 
									<li><a href="/currentAuction?sale_kind=offline_only"><spring:message code="label.auction.offlinecurrent" /></a></li>      
									<li><a href="/upcomingAuction?sale_kind=offline_only">예정경매</a></li>
									<li><a href="/resultAuction?sale_kind=offline_only">경매결과</a></li>
                                    <li><a href="/auctionGuide/page?view=biddingGuide">경매안내</a></li>
                                    <li><a href="/auctionGuide/page?view=commissionGuide">위탁안내</a></li>
									<!--<li><a href="/otherSales">전시판매</a></li>-->
								</ul>
							</div>
                            
                            <div>
								<div class="tit_h3 through">
									<h3>온라인 경매</h3>
								</div>
								<ul>
									<li><a href="/currentAuction?sale_kind=online_only">진행경매</a></li>
                                    <li><a href="/currentAuction?sale_kind=offline_only&sale_no=563">아트시 경매</a></li> 
									<li><a href="/upcomingAuction?sale_kind=online_only">예정경매</a></li>
 									<li><a href="/auctionGuide/page?view=onlinebidGuide">경매안내</a></li>
                                    <li style="border-bottom: 1px solid #333; height: 10px;"><li>  
                                    <li style="padding-top: 10px;"><a href="/currentAuction?sale_kind=zerobase_only"><span ng-if="locale=='ko'">제로베이스 경매</span><span ng-if="locale!='ko'">Zero base</span></a> 
                              </li>
                              <li><a href="https://www.seoulauction.com/zerobaseArtist"><span ng-if="locale=='ko'">제로베이스 작가</span><span ng-if="locale!='ko'">Zero base Artist</span></a></li>  
									<!--<li><a href="/otherSales">전시판매</a></li>-->
								</ul>
							</div>
                            
                            <div>
								<div class="tit_h3 through">
									<h3>참여안내</h3> 
								</div> 
								<ul>
									<li><a href="/auctionGuide/page?view=commissionGuide">위탁안내</a></li>  
									<li><a href="/auctionGuide/page?view=biddingGuide">경매안내</a></li> 
									<li><a href="/auctionGuide/page?view=onlinebidGuide">온라인경매안내</a></li>
								</ul>
							</div>
                            
                            <div>
								<div class="tit_h3 through">
									<h3>Private Sale</h3> 
								</div>
								<ul>
                                	<li><a href="/currentPrivate">프라이빗 세일</a></li> 
                                    <!-- <li><a href="/ps/page?view=gallery_network">갤러리 네트워크</a></li> -->
                                    <li><a href="/ps/page?view=priGuide">P/S 가이드</a></li>
                                    <!-- 기존 -->
									<!-- <li><a href="/auctionGuide/page?view=commissionGuide">위탁안내</a></li>
									<li><a href="/auctionGuide/page?view=priGuide">프라이빗 세일</a></li>
									<li><a href="/service/page?view=chinaArtwork">중국미술품위탁감정</a></li> -->
								</ul>
							</div>
                         </div>   
							
                            
                          <div class="cont_sitemap">
							<div>
								<div class="tit_h3 through">
									<h3>검&nbsp;&nbsp;&nbsp;색</h3>  
								</div>
								<ul>
									<li><a href="/search">작품검색</a></li>
									
								</ul>
							</div>
							
                            <div>
								<div class="tit_h3 through">
									<h3>이용안내</h3>
								</div>
								<ul>
									<li><a href="/terms/page?view=auctionTerms">경매약관</a></li>
									<li><a href="/terms/page?view=privateInfo">개인정보처리방침</a></li>
									<li><a href="/terms/page?view=infoManage">내부정보관리규정</a></li>
								</ul>
							</div>
                     
                        
							<div>
								<div class="tit_h3 through">
									<h3>서비스</h3>
								</div>
								<ul>
									<li><a href="/service/page?view=academy">아카데미</a></li>
									<li><a href="/service/page?view=corporationArtwork">아트컨설팅 &#38; 기업컨설팅</a></li> 
                                    <li><a href="/service/page?view=rentExhibitionCenter">전시장대관</a></li> 
                                    <li><a href="/service/page?view=securedLoan">담보대출</a></li>  
                                    <li><a href="/service/page?view=chinaArtwork">중국미술품위탁감정</a></li>
									<li><a href="/service/page?view=storageInsa">미술품보관</a></li>
                                    <!-- <li><a href="/service/page?view=ArtDonations">후원 및 기증</a></li> -->  
                                    <li><a href="/service/page?view=Newsletter">뉴스레터</a></li>   
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
                         </div>  						
                        
                        <div class="cont_sitemap">
							<div>
								<div class="tit_h3 through"> 
									<h3>서울옥션</h3>
								</div>
									<ul>
                                        <li><a href="/about/page?view=introduction">서울옥션 소개</a></li>
                                        <li><a href="/about/page?view=introGang">서울옥션 강남센터</a></li>
                                        <li><a href="/about/page?view=history">연혁</a></li>
                                        <!-- <li><a href="/about/page?view=investRealtime">투자정보</a></li> -->  
                                        <li><a href="/noticeList">공지사항</a></li>
										<li><a href="/recruitList">채용공고</a></li>  
                                        <li><a href="/about/page?view=pressList">언론보도</a></li>
                                        <li><a href="/about/page?view=location">위치안내</a></li>
                                        <li><a href="/about/page?view=faq">FAQ</a></li>
									</ul>
							</div> 
                            
                            <div>
								<div class="tit_h3 through">
									<h3>링&nbsp;&nbsp;&nbsp;크</h3>
								</div>
								<ul> 
                                	<!--<li><a href="/about/page?view=gnExhibition">서울옥션 강남센터 Exhibition</a></li>--> 
                                    <!-- 강남전시 1,2 -> 
									<li><a href="/about/page?view=gnExhibition">서울옥션 강남센터 Exhibition Ⅰ</a></li>
                                    <li><a href="/about/page?view=gnExhibition02">서울옥션 강남센터 Exhibition Ⅱ</a></li> -->
                                    <!-- <li><a href="/about/page?view=saplus">서울옥션 홍콩 리미티드</a></li> --> 
								</ul>
							</div> 
                                                    
                            <!-- <div>
								<div class="tit_h3 through">
									<h3>SNS 채널</h3>
								</div> 
								<ul>
									<li><a target="_blank" href="https://www.facebook.com/seoulauction">Facebook</a></li>
									<!-- <li><a target="_blank" href="https://twitter.com/seoulauctionkr">Twitter</a></li>
									<li><a target="_blank" href="http://blog.naver.com/PostList.nhn?blogId=s_auction">Naver Blog</a></li>
									<li><a target="_blank" href="https://www.youtube.com/user/SeoulAuction">Youtube</a></li>
								</ul>
							</div> -->
                            <div>
								<div class="tit_h3 through">
									<h3>패밀리사이트</h3>
								</div>
								<ul>
                                <li><a target="_blank" href="http://www.auctionblue.com ">Auction Blue</a></li>
									<li><a target="_blank" href="http://www.printbakery.co.kr">프린트 베이커리</a></li>
									<li><a target="_blank" href="http://www.ganaart.com/">가나아트 갤러리</a></li>
									<li><a target="_blank" href="http://www.artpark.co.kr/ ">장흥 아트파크</a></li>
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
                       
					</div>
				</div>
			</div>
			<div style="display:none;">
				<span class="btn_style01 gray03 btn_modal pop08">
					<button type="button">회원탈퇴신청</button>
				</span>
			</div>

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li><img src="/images/img/img_sitemap.jpg" alt="작품1" class="img_master" /></li>
					</ul>
				</div>
			</div>-->
		</div>
	</div>
</div>
<!-- //#wrap -->

<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />