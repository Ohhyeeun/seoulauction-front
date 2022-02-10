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
					<jsp:include page="../../include/gangSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">  
                    <div class="tit_h2">
						<h2>SA Gangnam Center Exhibition</h2>    
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
                     	<img src="/images/img/gnag/img_banner29.jpg" alt="exhibition banner" />          
                        <!-- 이미지 추가 일시  
                        <img src="/images/img/main/gang/sa12.jpg" alt="saplus" width="100%" height="auto" style="margin-top: 10px;" /> --> 
                    </div>   
                     
                    <div class="storage_cont title_area">  
						<div class="exhibition_firstbox">
                        	<div class="title" style="margin-bottom: 10px;">
								<p>Seoul Auction Gangnam Center Exhibition</p>  
								<h3 style="margin-top:10px; font-weight: 800;">ART NOW 5</h3>         
							</div>  
							<p style="line-height:30px; font-size:16px;">      
	                            (Fri)14 - (Thu)27 May, 2021<br>
                                10am - 7pm<br>
                                Seoul Auction Gangnam Center 6F 
							</p>          
	                        <!--<a href="/currentExhibit?sale_kind=exhibit_only&sale_no=640" class="btn_main_more green exhibiton_listbtn" >LIST</a>  
							<a href="/nas_img/front/homepage/e-book/mariKim/index.html" class="btn_main_more green exhibiton_listbtn" target="_blank" >CATALOGUE</a>      
	                        <a href="/service/page?view=auction360VRPop_ex"  class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 15px 45px 17px;font-size: 18px; font-weight:700; color:#FFF; width:120px;" target="new" >EXHIBITION</a> -->
                        </div><!-- //exhibition_firstbox --> 
                        
                        <div style="border-top: #CCC solid 1px; padding-top: 20px;">               
							<p style="line-height:27px; font-size:16px; text-align: justify;">        
                                Folloiwng from 'ART NOW 4', Seoul Auction is pleased to present 'ART NOW 5' with 5 new contemporary artists group exhibition. Unlike the previous show, 'ART NOW5' plans to bring in artists from outside Korea to expand the scope of the work display. Through the various use of mateirals, themes, and technqiues, Seoul Auction hopes to provide an opportunity for the audience to experience various aspects of ongoing contemporary art around the world and to feel the artistic passion and energy transmitted through this exhibition. Seoul Auction will continue to discover and introduce leading contemporary artists throguh the ART NOW series exhibition
							</p> 
                            
                            <!-- <p style="font-size: 12px; margin-top: 20px;">    
                               <strong>Artists</strong><br/> 
                                Sylvie Enjalbert<br/>
                                Ernst Gamperl<br/> 
                                Bodil Manz <br/>
                                Shimoo Design<br/>
                                -<br/>
                                Lee UFan<br/>
                                Park SeoBo <br/> 
                                Ha ChongHyun<br/>
                                Chung SangHwa<br/>
                                Kim TschangYeul<br/>
                                Lee DongYup<br/>
                                Oh SuFan<br/>
                                Yang Haegue <br/>
                                Choi YoungWook<br/>
                                Hong SooYeon
                            </p> -->  
                        </div> 
                        
						<!--<div class="btns mt10">  
							<span class="btn_style01">
								<a href="/about/page?view=location" target="_blank" title="Location">Seoul Auction Location</a>
							</span>
						</div>-->

						<div class="box_gray type01">
							<div class="contact">  
								<div class="title">Contact</div>  
								<div class="info">
									<div class="highlight"><strong>Seoul Auction Gangnam Center</strong></div> 
									<div class="tel"><strong class="tit">Tel</strong> <span>Office +82 (0)2-2075-4426</span></div>
                                    <div class="email"><strong class="tit">E-mail</strong> <a href="mailto:syk@seoulauction.com">syk@seoulauction.com</a></div>   
								</div>    
							</div>
							<!--<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">Inquiry</a><span class="ico next02"></span></span>
							</div>--> 
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