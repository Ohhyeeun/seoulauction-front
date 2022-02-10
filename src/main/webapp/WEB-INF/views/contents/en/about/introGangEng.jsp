<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>
<link href="<c:url value="/css/old/onepcssgrid.css" />" rel="stylesheet">
<link href="/resources/css/jquery.bxslider.min.css" rel="stylesheet">            
<link href="/resources/css/main_bxslider.css" rel="stylesheet"> 

<script type="text/javascript" src="/resources/js/jquery.bxslider.js"></script> 

<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2" style="padding-top:30px;">
						<h2>Seoul Auction Gangnam Center</h2>
					</div>
					

					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="title">
							<h3>Art in Life, Seoul Auction <span class="txt_green">Gangnam Center</span></h3>
						</div>
						<p style="line-height:30px; font-size:16px;">Seoul Auction opened Seoul Auction Gangnam Center in Sinsa-dong, Gangnam District in January 2019. It is designed by a French architect Jean-Michel Wilmotte who has built Seoul Auction in Pyeonchang-dong and Incheon International Airport. It has eight floors above ground and five underground. The center is consists of an auction room, an exhibition hall and an academy hall etc. Seoul Acution Gangnam Center aspires to become a landmark in Gangnam and a cultural space that enables people to enjoy art and art auction in their daily lives.</p>

					</div>
                    
                    <div class="storage_cont">	

                        <div class="onepcssgrid-1200">
                            <div class="col6" style="padding-top:20px; overflow:hidden">
                                <table style="line-height:50px; font-size:14px;">
                                    <p style="padding-bottom:30px; font-size:24px; font-weight:700;">Floor information</p>
                                    <tbody style="border-top:#000 solid 1px; ">
                                        <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">8F</td>
                                            <td>Meeting Room</td>
                                        </tr>
                                        <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">6-7F</td>
                                            <td>Auction Room</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">5F</td>
                                            <td>Exhibition Hall</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">4F </td>
                                            <td>Office</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">3F</td>
                                            <td>Academy Hall</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">GF</td>
                                            <td>Lobby</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">B1F</td>
                                            <td>Restaurant</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">B2-3F</td> 
                                            <td>Parking Lot</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">B4-5F</td>
                                            <td>Exhibition Hall and Event Hall</td>
                                         </tr>
                                    </tbody>
                                </table>
                                <div class="btns mt30">
                                <span class="btn_style01"><a href="/service/page?view=rentExhibitionCenter" target="_blank" title="새창">Gangnam Center Rental of Space</a></span>
                                <span class="btn_style01"><a href="/nas_img/front/homepage/ganam_brochure.pdf" target="_blank" title="새창">Venue Rental PDF</a></span>
                                </div>
                            </div> 
                            <div class="col6 last" style="padding-top:70px; padding-bottom: 20px;" align="center"><img src="/images/img/img_intro_gang01.jpg" alt="Seoulauction" style="width:80%;" /></div>
                            <div class="onerow"></div>
                        </div>

					</div>
                    
                    <div class="web_only">
                    	<div class="sub_banner02 mt20" id="slides"> 
							<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
							<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>  
							<div><img src="/images/img/img_intro_gang02.jpg" alt="Seoulauction" /></div>
	                        <div><img src="/images/img/img_intro_gang03.jpg" alt="Seoulauction" /></div>
	                        <div><img src="/images/img/img_intro_gang05.jpg" alt="Seoulauction" /></div>
							<div><img src="/images/img/img_intro_gang04.jpg" alt="Seoulauction" /></div>
						</div>
                    </div>  
                    <div class="m_only"> 
		            	<div class="sub_slide">
							<div class="bxslider">  
			            		<div class="sub_banner02">   
					                <div><img src="/images/img/img_intro_gang02.jpg" alt="Seoulauction" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/img_intro_gang03.jpg" alt="Seoulauction" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/img_intro_gang05.jpg" alt="Seoulauction" /></div>
					            </div>
					            <div class="sub_banner02">     
					                <div><img src="/images/img/img_intro_gang04.jpg" alt="Seoulauction" /></div>
					            </div>
			            	</div> 
		                </div>
		            </div><!--//m_only -->  
					
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
                                    <dl>
										<dt>Tel</dt>
										<dd>+82 (0)2-545-0330</dd>
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

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/img/img_menu03.jpg" alt="" class="img_master">
						</li>
					</ul>
				</div>
			</div>-->
		</div>
	</div>
	<script>
		/* m_only banner slider */
		$(".sub_slide .bxslider").bxSlider({        
			auto:true,   
			autoControls: true,  
			pause: 4000,        
			/* stopAutoOnClick:true, */    
		}); 
	</script>
	<!-- 20150521 -->
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
	<!-- //20150521 -->
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />