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
					<div class="tit_h2">      
						<h2>Rental of Space</h2>
					</div>

					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="title">
							<p>Optimal Place for value improvement</p>
							<h3>Seoul Auction Gangnam Center</h3>
						</div>
                        
                        <p style="line-height:30px; font-size:16px;">
							Seoul Auction Gangnam Center is going forward to be remembered as a special place with luxury brands, car launching shows, VIP events, and pop-up stores.
						</p>
						<p style="line-height:30px; font-size:16px;">
							We are equipped with the optimal space for art exhibitions. Moreover, the exhibition space can be modified upon the exhibits.<br/>
                            We will proceed to enhance customer brand value with the solutions that we have developed. If you need to find a place for a special invitation or event,<br/>
                            please join us at the Seoul Auction Gangnam Center.
						</p>
                           
  						<div class="btns mt10">
							<span class="btn_style01">
								<a href="/about/page?view=location" target="_blank" title="Location">Seoul Auction Location</a>
							</span>
                            <span class="btn_style01"><a href="/service/page?view=auction360VRPop_ex01" target="new" title="VR">Seoul Auction Gangnam Center VR</a></span>
                            <span class="btn_style01"><a href="/nas_img/front/homepage/ganam_brochure.pdf" target="new" title="brochure">Venue Rental PDF</a></span>
						</div>

						<div class="box_gray type01">
							<div class="contact">
								<div class="title">Contact</div>
								<div class="info">  
									<div class="highlight">Exhbition & Operations <strong>JISeok Lee</strong></div>   
									<div class="tel"><strong class="tit">Tel</strong> <span>+82-2-2075-4450</span></div>          
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:a7885@seoulauction.com">a7885@seoulauction.com</a></div>
								</div>
							</div>
							<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">Inquiry</a><span class="ico next02"></span></span>
							</div>
						</div>
					</div>
                    
                    <div class="web_only"> 
                    	<div class="sub_banner02" id="slides">
							<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
							<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
							<!-- <div><img src="/images/img/img_rental_banner01.jpg" alt="전시장대여" /></div> -->
							<!-- <div><img src="/images/img/1-1.jpg" alt="전시장대여" /></div> -->
	                        <div><img src="/images/img/2-2.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/3-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/4-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/5-1.jpg" alt="전시장대여" /></div>
							<div><img src="/images/img/6-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/7-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/8-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/9-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/10-1.jpg" alt="전시장대여" /></div>
							<div><img src="/images/img/11-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/12-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/13-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/14-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/15-1.jpg" alt="전시장대여" /></div>
							<div><img src="/images/img/16-1.jpg" alt="전시장대여" /></div>
	                        <div><img src="/images/img/17-1.jpg" alt="전시장대여" /></div>
						</div>
                    </div>
                    <div class="m_only">
		            	<div class="sub_slide">
							<div class="bxslider">  
			            		<div class="sub_banner02">   
					                <div><img src="/images/img/2-2.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/3-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/4-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/5-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/6-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/7-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/8-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/9-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/10-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/11-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/12-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/13-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/14-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/15-1.jpg" alt="전시장대여" /></div>
					            </div>
					            <div class="sub_banner02">    
					                <div><img src="/images/img/16-1.jpg" alt="전시장대여" /></div>
					            </div>
			            	</div> 
		                </div>
		            </div><!--//m_only -->   
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
<jsp:include page="../../../include/footer.jsp" flush="false" />