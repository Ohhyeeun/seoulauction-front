<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<link href="/resources/css/jquery.bxslider.min.css" rel="stylesheet">           
<link href="/resources/css/main_bxslider.css" rel="stylesheet">

<script type="text/javascript" src="/resources/js/jquery.bxslider.js"></script> 
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
					<jsp:include page="../include/serviceSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>전시장대관</h2>
					</div>
					

					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="title">
							<p>가치 향상을 위한 최적의 공간</p>
							<h3>서울옥션 강남센터</h3>
						</div>
						<p style="line-height:30px; font-size:16px;">
							서울옥션 강남센터는 명품, 자동차 런칭쇼, VIP 행사, 팝업스토어 등을 통해 특별한 공간으로 기억되고자 합니다.
						</p>
						<p style="line-height:30px; font-size:16px;">
							미술품 전시를 위한 최적의 공간으로도 시스템을 갖추고 있으며, 다양한 전시공간은 전시작품에 맞추어  변형이 가능합니다.<br>
							앞선 솔루션을 통해 고객 브랜드 가치 향상을 위하여 나아가겠습니다.<br>
							특별한 초대를 위한 공간을 찾으신다면, 서울옥션 강남센터에서 함께 하십시오.
						</p>
						<!-- 20150519 -->
						<div class="btns mt10">
							<span class="btn_style01"><a href="/about/page?view=location" target="_blank" title="새창">서울옥션 위치안내</a></span>&nbsp;&nbsp;
                            <span class="btn_style01"><a href="/service/page?view=auction360VRPop_ex01" target="new" title="VR">서울옥션 강남센터 전시장 VR보기</a></span>&nbsp;&nbsp;
                            <span class="btn_style01"><a href="/nas_img/front/homepage/ganam_brochure.pdf" target="_blank" title="강남센터 대관 브로셔">강남센터 대관 브로셔</a></span>
						</div>
						<!-- //20150519 -->

						<div class="box_gray type01"> 
							<div class="contact">
								<div class="title">문의 Contact</div>
								<div class="info">
									<div class="highlight">서울옥션 브랜드기획팀 <strong>이지석 팀장</strong></div>    
									<div class="tel"><strong class="tit">Tel</strong><span>02-2075-4450</span></div>      
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:a7885@seoulauction.com">a7885@seoulauction.com</a></div>  
								</div>
							</div>
							<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
							</div>
						</div>
					</div>
					
					<!-- 20150521 -->
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
					<!-- //20150521 -->
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
	<!-- 20150521 -->
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
		/* web banner slider */
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
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />