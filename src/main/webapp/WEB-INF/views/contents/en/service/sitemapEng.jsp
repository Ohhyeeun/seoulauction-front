<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
									<h3>Auction</h3>   
								</div>
								<ul> 
									<li><a href="/currentAuction?sale_kind=offline_only"><spring:message code="label.auction.offlinecurrent" /></a></li>  
									<li><a href="/upcomingAuction?sale_kind=offline_only">Upcoming</a></li>
									<li><a href="/resultAuction?sale_kind=offline_only">Result</a></li>
                                    <li><a href="/auctionGuide/page?view=biddingGuide">Guide</a></li>
                                    <li><a href="/auctionGuide/page?view=commissionGuide">How To Sell</a></li>
									<!--<li><a href="/otherSales">Other Sales</a></li>-->
								</ul>
							</div> 
					
                            <div>
                                <div class="tit_h3 through">
                                    <h3>Online Auction</h3>
                                </div>
                                <ul>
                                    <li><a href="/currentAuction?sale_kind=online_only">Current</a></li>
                                    <li><a href="/currentAuction?sale_kind=offline_only&sale_no=563">ARTSY Auction</a></li>  
                                    <li><a href="/upcomingAuction?sale_kind=online_only">Upcoming</a></li>
                                    <li><a href="/auctionGuide/page?view=onlinebidGuide">Guide</a></li>
                                    <li style="border-bottom: 1px solid #333; height: 10px;"><li>  
                                    <li style="padding-top: 10px;"><a href="/currentAuction?sale_kind=zerobase_only">Zero base</a> 
                              </li>
                              <li><a href="https://www.seoulauction.com/zerobaseArtist">Zero base Artist</a></li>   
                                    <!--<li><a href="/otherSales">전시판매</a></li>-->  
                                </ul>
                            </div>                    	
								
                                
                            <div>
								<div class="tit_h3 through">
									<h3>How To</h3>
								</div>
								<ul>
									<li><a href="/auctionGuide/page?view=biddingGuide">How To Bid</a></li>
									<li><a href="/auctionGuide/page?view=winningBidGuide">How To Buy</a></li>
									<li><a href="/auctionGuide/page?view=deliveryGuide">Shipping Info</a></li>
								</ul>
							</div>
                               
                            <div>
								<div class="tit_h3 through">
									<h3>Private Sale</h3>
								</div>
								<ul>
                               	 	<li><a href="/currentPrivate">Private Sale</a></li> 
                                    <!-- <li><a href="/ps/page?view=gallery_network">갤러리 네트워크</a></li> -->
                                    <li><a href="/ps/page?view=priGuide">P/S Guide</a></li>
                                	<!-- 기존 -->
									<!-- <li><a href="/auctionGuide/page?view=commissionGuide">How To Sell</a></li>
									<li><a href="/auctionGuide/page?view=priGuide">Private Sale</a></li>
									<li><a href="/service/page?view=chinaArtwork">Consignment Appraisal of Chinese Art</a></li> -->
								</ul>
							</div>
                         </div>                    
                         
                         
                         <div class="cont_sitemap">
                            <div>
                                <div class="tit_h3 through">
                                    <h3>Search</h3>
                                </div>
                                <ul>
                                    <li><a href="/search">Search</a></li>
                                    
                                </ul>
                            </div>
							
                            <div>
								<div class="tit_h3 through">
									<h3>Terms</h3>
								</div>
								<ul>
									<li><a href="/terms/page?view=auctionTerms&lang=en">Terms</a></li>
									<li><a href="/terms/page?view=privateInfo">Privacy Policy</a></li>
                                    <li><a href="/terms/page?view=infoManage">Information Mgmt. Rules</a></li>
                                    
								</ul>
							</div>
                            
                                                        
							<div>
								<div class="tit_h3 through">
									<h3>Service</h3>
								</div>
								<ul>
									<li><a href="/service/page?view=corporationArtwork">Consulting &#38; Corporate Marketing</a></li>
                                    <li><a href="/service/page?view=rentExhibitionCenter">Rental of Space</a></li>
                                    <li><a href="/service/page?view=securedLoan">Art Collateral Loans</a></li>
<%--                                    <li><a href="/service/page?view=chinaArtwork">Consignment Appraisal of Chinese Art</a></li>--%>
                                    <li><a href="/service/page?view=storageInsa">Art Storage</a></li>
                                    <!-- <li><a href="/service/page?view=ArtDonations">Art Donation</a></li> --> 
                                    <!-- <li><a href="/service/page?view=Newsletter">News Letter</a></li> -->
								</ul>  
							</div>
                            
                            <div>
								<div class="tit_h3 through">
									<h3>Language</h3>
								</div>
								<ul>
									<li><a href="/?lang=ko">KOR</a></li> 
									<li><a href="/?lang=en">ENG</a></li>
								</ul>
							</div>
                         </div> 
                         
                            
                        <div class="cont_sitemap">
                          <div> 
                              <div class="tit_h3 through">
                                  <h3>Seoul Auction</h3>
                              </div>
                                  <ul>
                                      <li><a href="/about/page?view=introduction">About Us</a></li>
                                      <li><a href="/about/page?view=introGang">Seoul Auction Gangnam Center</a></li>
                                      <li><a href="/about/page?view=history">History</a></li>
                                      <!-- <li><a href="/about/page?view=investRealtime">Investor Relations</a></li> --> 
                                      <li><a href="/noticeList">Notice</a></li> 
                                      <li><a href="/about/page?view=location">Location</a></li>
                                      <li><a href="/about/page?view=faq">FAQ</a></li> 
                                  </ul>
                          </div>
                          
                           <div>
                              <div class="tit_h3 through">
                                  <h3>Link</h3>
                              </div> 
                              <ul>
                              	  <!-- <li><a href="/about/page?view=gnExhibition">Gangnam Center Exhibition</a></li> --> 
                                  <!-- 강남전시 1,2 -> 
                                  <li><a href="/about/page?view=gnExhibition">Gangnam Center Exhibition Ⅰ</a></li>  
                                  <li><a href="/about/page?view=gnExhibition02">Gangnam Center Exhibition Ⅱ</a></li> --> 
                                  <!-- <li><a href="/about/page?view=saplus">Seoul Auction Hong Kong Limited</a></li> -->
                              </ul>
                          </div>
                          
                          <div>
								<div class="tit_h3 through">
									<h3>Family Site</h3>
								</div>
								<ul>
                                    <li><a target="_blank" href="http://www.auctionblue.com ">Auction Blue</a></li>
                                    <li><a target="_blank" href="http://www.printbakery.co.kr">PRINT BAKERY</a></li>
                                    <li><a target="_blank" href="http://www.ganaart.com/">ganaart</a></li>
                                    <li><a target="_blank" href="http://www.artpark.co.kr/ ">Artpark</a></li>
								</ul> 
						  </div>   
                          
                          <div>		
                          		<div class="tit_h3 through">
                                	<h3>Login/Register</h3>
	                            </div> 
                                <ul>
                                    <li><a href="/login">Login/Register</a></li>
                                </ul>
                          </div>  
                            
                       <!-- <div>
								<div class="tit_h3 through">
									<h3>SNS</h3>
								</div>
								<ul>
									<li><a target="_blank" href="https://www.facebook.com/seoulauction">Facebook</a></li>
									<!-- <li><a target="_blank" href="https://twitter.com/seoulauctionkr">Twitter</a></li>
									<li><a target="_blank" href="http://blog.naver.com/PostList.nhn?blogId=s_auction">Naver Blog</a></li>
									<li><a target="_blank" href="https://www.youtube.com/user/SeoulAuction">Youtube</a></li>
								</ul>
							</div> -->  
                        </div>     
					</div>
				</div>
			</div>
         
			<div style="display:none;">
				<span class="btn_style01 gray03 btn_modal pop08">
					<button type="button">회원탈퇴신청</button>
				</span>
			</div>

			
		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />