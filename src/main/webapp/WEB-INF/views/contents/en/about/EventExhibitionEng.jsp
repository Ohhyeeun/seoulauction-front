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
			<div class="sub_menu_wrap menu03"> 
				<div class="sub_menu"> 
					<jsp:include page="../../include/EventSubMenu.jsp" flush="false"/>       
				</div>  
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div> 
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">   
				<div class="contents">   
                    <div class="tit_h2" style="display: none;">   
						<h2><spring:message code="label.seoulauction.introgang0" /></h2>  
					</div> 
 					<!-- 20150521 --> 
					<!-- <div class="sub_banner02" id="slides"> 
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>  
						<div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
                        <div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
                        <div><img src="/images/img/gnag/img_banner07.jpg" alt="gangnam" /></div>
						<div><img src="/images/img/gnag/img_banner08.jpg" alt="gangnam" /></div>
                        <div><img src="/images/img/gnag/img_banner09.jpg" alt="gangnam" /></div> 
                        <div><img src="/images/img/gnag/img_banner10.jpg" alt="gangnam" /></div> 
					</div> -->
					<!-- //20150521 -->   
                    <div class="exhibition_img_box"> 
                     	<img src="/images/img/gnag/img_banner26.jpg" alt="saplus" width="100%" height="auto" /> 
                        <!-- 이미지 추가 일시 
                        <img src="/images/img/main/gang/sa12.jpg" alt="saplus" width="100%" height="auto" style="margin-top: 10px;" /> --> 
                     </div>  

					<br/><br/><br/><br/>
                    <div class="storage_cont title_area"> 
						<div class="title" style="margin-bottom: 10px;">
							<!-- <p>Seoul Auction Gangnam Center Exhibition</p> --> 
							<h3 style="margin-top:10px;">〈THE KING OF WHISKY - Royal Salute Contemporary Art Digital Festival〉</h3>  
						</div>  
						<p style="line-height:30px; font-size:16px;">    
							Digital Exhibition<br> 
							(Mon)4 January, 2021 - (Sun)14 March<br> 
							Seoul Auction Homepage, Seoul Auction Instagram<br><br> 
							Offline Exhibition<br>
							: Seoul Auction Gangnam Center<br> 
							1)	(Tue)16 February - (Tue)23 February, 2021<br>
							2)	(Mon)15 March - (Thu)18 March, 2021 
						</p>
                        <br/>    
                        <a href="/currentExhibit?sale_kind=exhibit_only&sale_no=617" class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 10px 45px 15px;font-size: 18px; font-weight:700; color:#FFF;" >LIST</a>
                        <a href="https://www.royalsaluteart.kr" class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 10px 45px 15px;font-size: 18px; font-weight:700; color:#FFF; width:auto;" >EVENT</a>   
                        
                        <br/><br/><br/>
                        
                        <p style="border-top: #CCC solid 1px; line-height:30px; font-size:16px;"><br/><br/>  
                        	In January 2021, Seoul Auction will be hosting a revolutionary art exhibition, Royal Salute Contemporary Art Digital Festival, which will be an exclusive opportunity for art enthusiasts to enjoy the combination of Royal Salute’s artistic brand story and contemporary art.<br/><br/> 
                            In 2019, Royal Salute unveiled a visual identity that transforms the global whiskey manufacturer’s image into one that is much more contemporary while not detracting from its luxury/high-end name value. The new visual identity was first put on display in Korea through the “Royal Salute Contemporary Art Exhibition.” Overseen by prominent Icelandic artist Kristjana S. Williams, the exhibition was popular for providing visitors with a full sensory experience (sight, smell, and taste) of both artworks and whiskey. The exhibition was also well-received by whiskey enthusiasts and art collectors as the successful transition of a commercial whiskey brand into a mode of contemporary art.<br/><br/> 
                            The festival is the collective effort of Seoul Auction, five contemporary Korean artists, and Royal Salute, a global brand that has used contemporary art frequently over the years as a means of communicating with consumers, to empower Korea’s contemporary art scene while also giving joy to consumers. Joining forces with Royal Salute to offer audiences an art festival that is as radical as it is entertaining are five artists who have been gaining increasing attention in Korea’s contemporary art community: contemporary artist Kim Sunwoo, whose creations on dreams and freedom are based on a dodo motif; cross media artist Adrian Seo, who is known for his characteristic blending of digital technology with a love of fashion; visual artist 275c, whose bold drawings in vivid colors are based on pop art; illustrator Qwaya, who creates warm, elaborate depictions of ordinary citizens and their lives by manipulating colors and light; and painter/illustrator Sung Nak Jin, who spotlights the lifestyles of contemporary men through period fashion.<br/><br/>
                            The festival’s theme is “The King of Whisky,” based on Royal Salute’s reputation as the “king of whiskies.” It is an unconventional art festival in that the creations of the five artists, who present their modern-day interpretations of fascinating histories linked to Royal Salute’s luxury lineup, will be shared with the public through various digital channels. The artists’ works, which will be featured on Royal Salute products ranging from the 21 Years Old to the 52 Years Old Time Series Collection, will be available for viewing from January 4, 2021, on Seoul Auction’s website and official Instagram page (@seoulauction).<br/><br/>
                        	The festival is already the focus of significant attention simply for the fact that a global whiskey brand is collaborating with Korean artists who are rapidly gaining prominence. 
The festival, which joins with Royal Salute to provide a witty, fun occasion where participants feel like they have become “kings,” offers not only the unique experience of viewing artworks online but also a wealth of creative inspiration for trendsetters, art collectors, and members of the MZ generation who are interested in a luxurious lifestyle.
    
                        
                        </p>
                        
						<div class="box_gray type01">
							<div class="contact">  
								<div class="title">Contact</div>    
								<div class="info"> 
									<div class="highlight"><strong>Specialist, hyunhee Kim</strong></div>  
									<div class="tel"><strong class="tit">Tel</strong> <span>Tel +82 (0)2-2075-4435</span></div> 
                                    <div class="email"><strong class="tit">E-mail</strong> <a href="mailto:hyunhee@seoulauction.com">hyunhee@seoulauction.com</a></div>     
								</div>    
							</div>  
							<!-- <div class="right">  
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">Inquiry</a><span class="ico next02"></span></span>
							</div> -->
						</div>
					</div>
                     
                     <div class="storage_cont">	
						<div class="tit_h3 through">
							<h3>Location</h3>
						</div>
						
						<div class="map_area">
							<div class="left">
								<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12655.621508400407!2d127.03040534787746!3d37.533727752054204!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x20893aab0caffe0c!2zKOyjvCnshJzsmrjsmKXshZgg6rCV64Ko7IKs7JilIFNlb3VsIEF1Y3Rpb24gR2FuZ25hbSBCcmFuY2g!5e0!3m2!1sko!2skr!4v1547529016843" width="500" height="350" frameborder="0" style="border:0"></iframe>
							</div>
							<div class="right">
								<div class="title">Seoul Auction Gangnam Center</div>
								<!-- 20150608 -->
								<div class="cont">
									<dl>
										<dt>Road name</dt>
										<dd>864, Eonju-ro, Gangnam-gu, Seoul, Republic of Korea</dd>
									</dl>
									<dl class="bus">
										<dt><img src="/images/icon/bus.jpg" style="width:60px; height:auto;"/></dt>
										<dd>										
											<div>
												<div class="tit"><strong>Shingu Middle school</strong></div>
												<div class="txt"></div>
											</div>
											<div>
												<div class="tit"><strong>Hyundai APT</strong></div>
												<div class="txt"></div>
											</div>
										</dd>
									</dl>
									<dl class="subway">
										<dt><img src="/images/icon/subway.jpg" style="width:60px; height:auto;"/></dt>
										<dd>
											<div class="metro3"><span>Line 3</span> <strong>Apgujeong Station</strong></div> 
										</dd>
									</dl>
								</div>
								<!-- //20150608 -->
							</div>
						</div>
               		</div>
				</div>  
			</div>
		</div> 
	</div>
  
	<script>
		$(function() {
			$('#slides').slidesjs({
				height : 400,//??
				navigation : false,
				start : 1,
				play : {
					auto : true
				}
			});
		});
	</script>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />  