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
			<div class="sub_menu_wrap menu02">
				<div class="sub_menu">
					<jsp:include page="../../include/PS_Submenu.jsp" flush="false"/>
				</div> 
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>P/S Guide</h2>  
					</div> 
					

					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="title">
							<h3>Featuring <span class="txt_green">your artwork </span>in the most elegant, globally oriented way</h3>
						</div>
						<p style="line-height:30px; font-size:16px;">Founded in 1998 as Korea’s first art auction house, Seoul Auction now has several state-of-the-art facilities (Pyeongchang-dong and Gangnam offices, Busan exhibition space, and Hong Kong exhibition space) where various types of artworks can be appreciated. In addition to its offices north and south of the Han River, which cater to its diverse clientele, Seoul Auction recently opened a private exhibition space (SA+) on the 11th floor of H Queen’s, an art landmark in Hong Kong, in celebration of its 20th anniversary. It not only features artworks of Korean artists, such as Kim WhanKi and Lee UFan, but also holds exhibitions of famous foreign artists. Feature your artwork in Seoul Auction’s diverse exhibition spaces, where they can be enjoyed by collectors from all over the world.</p>
                        <br/><br/>
                        <div class="title">
							<h3>The professionalism of Seoul Auction’s  <span class="txt_green">Private Sales</span></h3>
						</div> 
						<p style="line-height:30px; font-size:16px;">As Korea’s first art auction house, Seoul Auction has consistently created new standards for art appreciation through its many auctions. It operates a customer-centric art appreciation service that assesses the value of artworks, including single pieces, large-scale collections, and ancient and foreign artworks. Seoul Auction’s Private Sales, in particular, conveys the value of prominent works of art to a diverse client based on its global platform, expertise, and extensive successful bid records. Seoul Auction guarantees that the value of your artwork will be recognized through methods you can depend on.</p>
                        
						
						<div class="box_gray type01">
							<div class="contact">
								<div class="title">Contact</div> 
								<div class="info">
									<div class="highlight">Seoul Auction Partner Group <strong>S.Y Kim</strong></div>       
									<div class="tel"><strong class="tit">Tel</strong> <span>82-2-2075-4426</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:rinda@seoulauction.com">syk@seoulauction.com</a></div>
								</div>  
							</div>
							<!-- <div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1:1 Inquiry</a><span class="ico next02"></span></span>
							</div> -->
						</div>
					</div>
                    
                    <div><img src="/images/img/img_pri_banner01.jpg" alt="PRIVATE"  style="width:100%; height:auto;"/></div>

					<!-- 20150521 
					<div class="sub_banner02" id="slides">
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
						<div><img src="/images/img/img_corp_banner01.jpg" alt="기업미술품" /></div>
						<div><img src="/images/img/img_corp_banner01.jpg" alt="기업미술품" /></div>
						<div><img src="/images/img/img_corp_banner01.jpg" alt="기업미술품" /></div>
					</div>-->
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
		maxH();
		$(window).resize(function(){
			$('.both_cont > div .inner').css('height', 'auto');
			maxH();
		});		
		function maxH(){
			if($(window).width() > 767){	
				$('.both_cont > div .inner').each(function(){
					var maxHeight = Math.max($(this).parent().parent().height());
					$(this).css('height', maxHeight + 'px');
				});
			} else {
				$('.both_cont > div .inner').css('height','auto');
			}
		}
	</script>
	<!-- //20150521 -->
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />