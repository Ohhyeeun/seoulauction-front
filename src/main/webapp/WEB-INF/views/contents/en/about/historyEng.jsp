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
						<h2>History</h2>
						<p>Seoul Auction is the first auction house of South Korea.</p>
					</div>
					<div class="history_step history_step_en">         
						<ol> 
							<li class="year01 sele"><a href="#history01"><span style="margin: 0 auto;">Establishment of Seoul Auction</span></a></li> 
							<li class="year02"><a href="#history02"><span style="margin: 0 auto;">Lee Woo-fan's 'Dongpung' surpasses 3 billion won for the first time in Korea as a surviving artist</span></a></li> 
							<li class="year03"><a href="#history03"><span style="margin: 0 auto;">The 20th anniversary of Seoul Auction, Opening of the Gangnam Center</span></a></li> 
							<li class="year04"><a href="#history04"><span style="margin: 0 auto;">The opening of SA+, an art gallery of Seoul Auction in Hong Kong</span></a></li> 
							<li class="year05"><a href="#history05"><span style="margin: 0 auto;">Listed on the KOSDAQ</span></a></li>   
						</ol>  
					</div>   
					<div class="history_cont">
						<div class="year now" id="year01">Now</div>
						<ol>
							<!----------------------------------2021---------------------------------->
							<li id="history02">    
								<dl>
									<dt>2021</dt> 
									<dd>
										<ul> 
											<li><div>Lee UFan became the first Korean artist whose painting was sold above 3 billion won in lifetime.  </div>   
                                                <div class="img"><img src="/images/img/img_history19.jpg" alt="이우환" height="200px" width="auto"/></div>  
                                            </li>
                                            <li><div>Chung Sun broke the artist’s auction records among his real landscape painting.</div>   
                                                <div class="img"><img src="/images/img/img_history20.jpg" alt="겸재 실경" width="auto" height="200px"/></div> 
                                            </li>
                                            <li><div>Kim TschangYeul broke the artist’s auction records.  </div>     
                                                <div class="img"><img src="/images/img/img_history21.jpg" alt="김창열" height="auto" width="200px"/></div>    
                                            </li>
										</ul> 
									</dd>
								</dl>
							</li>
							<!----------------------------------2020---------------------------------->					
							<li class="odd"> 
								<dl>
									<dt>2020</dt>  
									<dd>
										<ul>
                                            <li>
                                            	<div>Seoul Auction and the cultural foundation of local government co-hosted ZeroBase, auction for young artists.  </div>   
                                                <div class="img"><img src="/images/img/img_history18.jpg" alt="제로베이스 X 전남, 경기 문화재단 경매 진행" width="200px" height="auto"></div> 
                                            </li> 
										</ul>
									</dd>
								</dl> 
							</li>
                            <!----------------------------------2019---------------------------------->
                            <li id="history03">  
								<dl>
									<dt>2019</dt>
									<dd>
										<ul>
											<li><div>The 20th anniversary of Seoul Auction, Opening of the Gangnam Center</div> 
                                                <div class="img"><img src="/images/img/img_history13.jpg" alt="Gangnam Branch" style="  height:200px;
  width:auto;" /></div>
                                            </li>
										</ul>
									</dd>
								</dl> 
							</li>
							<!----------------------------------2019---------------------------------->
							<!----------------------------------2018---------------------------------->					
							<li class="odd">  
								<dl>
									<dt>2018</dt> 
									<dd>
										<ul>
											<li><div>Kim WhanKi’s 3-II-72 #220 renews record price for Korean artwork</div> 
                                                <div class="img"><img src="/images/img/img_history17.jpg" alt="Kim WhanKi" style="  height:200px;
  width:auto;" /></div>
                                            </li>
											<li id="history04"><div>The opening of SA+, an art gallery of Seoul Auction in Hong Kong</div> 
                                                <div class="img"><img src="/images/img/img_history14.jpg" alt="SA+" style="  height:200px;
  width:auto;" /></div>
                                            </li>
											<li> 
												<div>Lee JungSeob's Bull broke the artist's auction records</div>
                                                <div class="img"><img src="/images/img/img_history15.jpg" alt="Lee JungSeob" style="  height:150px;
  width:auto;" /></div>
                                            </li>
                                            <li>
												<div>New Auction Record: Kim WhanKi's "Jar and Poetry", the work of conception </div>
                                                <div class="img"><img src="/images/img/img_history16.jpg" alt="Kim WhanKi" style="  height:150px;
  width:auto;" /></div>
                                            </li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2018---------------------------------->
                            <!----------------------------------2017---------------------------------->
                            <li>
								<dl>
									<dt>2017</dt>
									<dd>
										<ul>
											<li><div>Chang UcChin’s Jar broke the artist’s auction records</div></li>
											<li>
												<div>Lee UFan’s With Winds broke the auction records of with winds series</div>
												<div class="img"><img src="/images/img/img_history08.jpg" alt="Lee UFan’s With Winds" style="  height:150px;
  width:auto;" /></div>
											</li>
                                            <li><div>The first Busan Sale, Sell-through Rate: 93%</div></li>
                                            <li>
                                            	<div>Nam June Paik's Stag broke the artist’s auction records</div>
                                            	<div class="img"><img src="/images/img/img_history09.jpg" alt="Nam June Paik's Stag" style="  height:150px;
  width:auto;" /></div>
                                            </li>
                                            <li><div>Special Exhibition on Kim Sou is held in 22nd Hong Kong Sale</div></li>
                                            <li>
                                            	<div>The first Daegu Sale, Sell-through Rate: 84%) </div>
                                            </li>
                                            <li>
                                            	<div>Lee UngNo's People broke the artist’s auction records)</div>
                                            	<div class="img"><img src="/images/img/img_history10.jpg" alt="Lee UngNo" style="  height:150px;
  width:auto;" /></div>
                                            </li>
                                            <li>
                                            	<div>Kim WhanKi's Morning Star broke the auction records of semiabstract paintings)</div>
                                            	<div class="img"><img src="/images/img/img_history11.jpg" alt="Kim WhanKi" style="  height:150px;
  width:auto;" /></div>
                                            </li>
                                            <li>
                                            	<div>Yayoi Kusama's A-Pumpkin [BAGN8] which is the biggest of pumpkin series broke the auction records of pumpkin series)</div>
                                            	<div class="img"><img src="/images/img/img_history12.jpg" alt="쿠사마" style="  height:200px;
  width:auto;" /></div>
                                            </li> 
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2017---------------------------------->
							
							<!----------------------------------2016---------------------------------->					
							<li class="odd">
								<dl> 
									<dt>2016</dt> 
									<dd>
										<ul>
											<li><div>&lt;SeoulAuction TV&gt;, is launched on Olleh tv (Channel #889)</div></li>
											<li><div>The biggest preview exhibition is held in Hong Kong to celebrate the 20th Hong Kong Sale</div></li>
											<li>
												<div>Kim WhanKi’s 12-V-70 #172 renews record price for Korean artwork</div>
                                                <div class="img"><img src="/images/img/img_history07.jpg" alt="Kim WhanKi’s 12-V-70 #172" style="  height:200px;
  width:auto;" /></div>
                                            </li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2016---------------------------------->
						
							<!----------------------------------2015---------------------------------->
                            <li>
								<dl>
									<dt>2015</dt>
									<dd>
										<ul>
											<li><div>Cumulative sales since foundation of Seoul Auction exceed KRW 100 billion.</div></li>
											<li><div>Korean art component created for Hong Kong Sale.</div></li>
                                            <li><div>Hanging Painting of Mt. Cheongryang’s Buddha(National Treasure No. 1210) sold for highest auction price in traditional Korean art component.</div></li>
                                            <li><div>Kim WhanKi’s 19-VII-71 #209 sold for highest auction price in modern Korean art component.</div>
                                                <div class="img"><img src="/images/img/img_history06.jpg" alt="Kim WhanKi 19-VII-71 #209" style="  height:200px;
  width:auto;" /></div>
                                            </li>
                                            
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2015---------------------------------->
							
							<!----------------------------------2014---------------------------------->
							<li class="odd">  
								<dl>
									<dt>2014</dt>
									<dd>
										<ul>
											<li><div>Set Record for Bid Price Rate: 87%</div></li>
											<li><div>Launch of eBid Now Online Auction</div></li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2014---------------------------------->
							
							<!----------------------------------2013---------------------------------->
							<li>
								<dl>
									<dt>2013</dt>
									<dd>
										<ul>
											<li>												
												<div>Special Auction of Collection of Ex-president Chun Do-hwan</div>
												<div class="img"><img src="/images/eng/img/img_history01.jpg" alt="Special Auction of Collection of Ex-president Chun Do-hwan" /></div>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2013---------------------------------->
							
							<!----------------------------------2012---------------------------------->
							<li class="odd top01" id="history04">  
								<dl>
									<dt>2012</dt>
									<dd>
										<ul>
											<li>
												<div>Launch of Print Bakery</div>
												<div class="img"><img src="/images/eng/img/img_history02.jpg" alt="Launch of Print Bakery" /></div>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2012---------------------------------->
							
							<!----------------------------------2010---------------------------------->
							<li>
								<dl>
									<dt>2010</dt>
									<dd><div>First Design Auction</div></dd>
								</dl>
							</li>
							<!----------------------------------2010---------------------------------->
							
							<!----------------------------------2008---------------------------------->
							<li class="odd">  
								<dl> 
									<dt>2008</dt> 
									<dd>
										<ul>
											<li>
												<div>Opening of the Hong Kong Branch</div>
												<div class="img"><img src="/images/eng/img/img_history03.jpg" alt="Opening of the Hong Kong Branch" /></div>
											</li>
											<li id="history05" class="m_mt15"><div>Listed on the KOSDAQ</div></li><!-- 20150612 -->
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2008---------------------------------->
							
							<!----------------------------------2007---------------------------------->
							<li class="top01" id="history02"> 
								<dl>
									<dt>2007</dt>
									<dd>
										<ul>
											<li><div>First COEX Auction Show</div></li>
											<li>
												<div> “A Wash Place” by Park SooKeun Sets Highest Bid Record</div>
												<div class="img"><img src="/images/eng/img/img_history04.jpg" alt=" “A Wash Place” by Park SooKeun" /></div>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2007---------------------------------->
							
							<!----------------------------------2006---------------------------------->
							<li class="odd">
								<dl>
									<dt>2006</dt>
									<dd>
										<ul>
											<li><div>Opening of the Busan and Insa Branch</div></li>
											<li><div>100th Auction Event Milestone</div></li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2006---------------------------------->
							
							<!----------------------------------2005---------------------------------->
							<li>
								<dl>
									<dt>2005</dt>
									<dd><div>Opening of the Gangnam Branch</div></dd>
								</dl>
							</li>
							<!----------------------------------2005---------------------------------->
							
							<!----------------------------------2004---------------------------------->
							<li class="odd">
								<dl>
									<dt>2004</dt>
									<dd>
										<ul>
											<li><div>First Open Auction</div></li>
											<li><div>First Public Auction</div></li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2004---------------------------------->
							
							<!----------------------------------2002---------------------------------->
							<li>
								<dl>
									<dt>2002</dt>
									<dd><div>Opening of the Seoul Auction Center</div></dd>
								</dl>
							</li>
							<!----------------------------------2002---------------------------------->
							
							<!----------------------------------2000---------------------------------->
							<li class="odd">
								<dl>
									<dt>2001</dt>
									<dd>
										<ul>
											<li><div>Company Name Changed to “Seoul Auction”</div></li>
										</ul>
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt>2000</dt>
									<dd>
										<ul>
											<li><div>First Jewelry Auction</div></li>
											<li><div>First Wine Auction</div></li>
										</ul>
									</dd>
								</dl> 
							</li>
							<!----------------------------------2000---------------------------------->
							
							<!----------------------------------1998---------------------------------->
							<li class="odd" id="history01">
								<dl>
									<dt>1998</dt>
									<dd>
										<ul>
											<li>
												<div>Establishment of Seoul Auction</div>
												<div class="img"><img src="/images/eng/img/img_history05.jpg" alt="Seoul Auction" /></div>
											</li>
											<!-- <li><div>First Auction Event</div></li> 20150612-->
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------1998---------------------------------->
						</ol>	
					</div>
				</div> 
			</div> 
		</div>
	</div>
	
	<script type="text/javascript" src="/js/jquery.scrollTo.min.js"></script> 
	<script type="text/javascript"> 
	
		 $(".history_step li a").on("click", function( e ) {
			e.preventDefault();

			$("body, html").animate({ 
				scrollTop: $( $(this).attr('href') ).offset().top - 100  
			}, 600);      

			if($(this).parent().hasClass('sele')){
				
			} else {
				$('.history_step li').removeClass('sele');
				$(this).parent().addClass('sele');
			} 
		});
	</script>
	
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />