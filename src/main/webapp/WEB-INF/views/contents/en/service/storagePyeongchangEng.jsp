<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>
<link href="/resources/css/jquery.bxslider.min.css" rel="stylesheet">           
<link href="/resources/css/main_bxslider.css" rel="stylesheet">

<script type="text/javascript" src="/resources/js/jquery.bxslider.js"></script> 
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
					<jsp:include page="../../include/serviceSubMenu.jsp" flush="false"/> 
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button> 
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2 pd-top"> 
						<h2>Pyeongchang Art Storage</h2>  
					</div> 
					<!-- 이미지 2개 이상 슬라이드 일 때 -->  
					<!-- <div class="web_only">
						<div class="sub_banner02" id="slides"> 
							<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
							<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
							<div><img src="/images/eng/img/img_storage01_banner01.jpg" alt="Insa Art Storage" /></div>
							<div><img src="/images/eng/img/img_storage01_banner02.jpg" alt="Insa Art Storage" /></div>
						</div>
					</div> 
					
					<div class="m_only">
		            	<div class="sub_slide">
							<div class="bxslider">  
			            		<div class="sub_banner02">   
					                <div><img src="/images/eng/img/img_storage01_banner01.jpg" alt="Insa Art Storage" /></div>
					            </div>
					            <div class="sub_banner02">    
					                <div><img src="/images/eng/img/img_storage01_banner02.jpg" alt="Insa Art Storage" /></div>
					            </div>
			            	</div> 
		                </div>
		            </div> --><!--//m_only -->
 
					<div class="storage_cont title_area"> 
						<div class="line"></div>    
						<div class="title">   
							<p>Special Storage for Artworks and Valuables</p>  
							<h3>Pyeongchang Art Storage</h3> 
						</div>
						<p>The Pyeongchang Storage is 19.8m²~26.4m² in area, located in Pyeongchang-dong, Seoul. This place  will meet needs of clients, not only those who want to check and replace their artworks, but also submit works to auction.</p>  
						<div class="box_gray type01"> 
							<div class="contact">
								<div class="title">Contact</div>
								<div class="info">
									<div class="highlight">Team Leader, Art Storage Team <strong>Kyoungsoon Kim</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>Office +82-10-4703-0481</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:kks@seoulauction.com">kks@seoulauction.com</a></div>
								</div>
							</div>
							<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">Inquiry</a><span class="ico next02"></span></span>
							</div>
						</div>
					</div> 
					
					<div><img src="/images/img/img_storage03_banner03.JPG" alt="Pyeongchang Art Storage" style="width:100%; height:auto;"/></div>  

					<div class="storage_cont">
						<div class="tit_h3 through">
							<h3>Art Storage System</h3>
						</div>
						<div class="both_cont tri">
							<div>
								<div>
									<h4 class="txt_style04">Isothermal-Isohumidity System</h4>
									<p>Maintains optimal condition for each and every artwork for 24 hours a day, 7 days a week.</p>
									<div class="list_style01">
										<ul>
											<li>Constant temperature (18~22°c) </li>
											<li>Constant humidity (45~55%)</li>
										</ul>
									</div>
									<div><img src="/images/eng/img/img_storage01_01.jpg" alt="humidity" /></div>
								</div>
							</div>
							<div>
								<div>
									<h4 class="txt_style04">Fire Protection System</h4>
									<p>A cutting-edge Halon gas fire extinguisher puts out fire without damaging artworks. </p>
									<div class="list_style01">
										<ul>
											<li>Central fire-alarm system</li>
											<li>Automatic heat sensors / smoke detectors.</li>
										</ul>
									</div>
									<div style="margin-top: 36px;"><img src="/images/eng/img/img_storage01_02.jpg" alt="heat sensors" /></div>
								</div>
							</div>
							<div class="last">
								<div>
									<h4 class="txt_style04">Security System</h4>
									<p>A cutting-edge 24 hours security system with the Korea's top security company, SECOM</p>
									<div class="list_style01">
										<ul>
											<li>Operates CCTV 24-hour-a-day for the security monitoring</li>
											<li>Strictly controls all visitors</li>
										</ul>
									</div>
									<div style="margin-top: -18px;"><img src="/images/eng/img/img_storage01_03.jpg" alt="Strictly" /></div>
								</div>
							</div>
						</div>
					</div>

					<div class="storage_cont">
						<div class="tit_h3 through"> 
							<h3>Location</h3>
						</div>

						<div class="map_area storage_map_area"> 
							<div class="left storage_location_left"> 
								<div class="storage_location_google"> 
									<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3160.606546262178!2d126.97563500000001!3d37.61141800000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357cbd3f81484fa5%3A0xcdaccdc4d2e8f1f5!2zKOyjvCnshJzsmrjsmKXshZg!5e0!3m2!1sko!2s!4v1431436261224" width="100%" height="100%" frameborder="0" style="border:0"></iframe>
								</div>   
							</div>
							<div class="right storage_location_right"> 
								<div class="title">Pyeongchang Art Storage</div>  
								<!-- 20150608 -->
								<div class="cont cont_en"> 
									<dl>
										<dt>Land-lot number</dt>
										<dd>465-10, Pyeongchang-dong, Jongno-gu, Seoul, Korea</dd>
										<dd>98, Pyeongchang-dong, Jongno-gu, Seoul, Korea</dd> 
									</dl>
									<dl>
										<dt>Road name</dt>
										<dd>11, Pyeongchang 31-gil, Jongno-gu, Seoul, Korea</dd>
										<dd>24, Pyeongchang 30-gil, Jongno-gu, Seoul, Korea</dd> 
									</dl>  
									<dl class="bus"> 
										<dt>Bus</dt>
										<dd>
											<div>
												<div class="tit"><strong>Lotte Samsung Apartment</strong></div> 
												<div class="txt">1711, 1020, 7211, 110, 153</div>  
											</div> 
										</dd>
									</dl>
									<dl class="subway">
										<dt>Subway</dt>
										<dd>
											<div class="metro3"><span>Line 3</span> <strong>Anguk, Jongno 3(sam)-ga</strong></div>
											<div class="metro1"><span>Line 1</span> <strong>Jonggak</strong></div>
											<div class="metro5"><span>Line 5</span> <strong>Jongno 3(sam)-ga</strong></div>
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
		/* m_only banner slider */
		$(".sub_slide .bxslider").bxSlider({        
			auto:true,   
			autoControls: true,  
			pause: 4000,        
			/* stopAutoOnClick:true, */    
		});  
	</script>
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
<jsp:include page="../../../include/footer.jsp" flush="false" /></body>
