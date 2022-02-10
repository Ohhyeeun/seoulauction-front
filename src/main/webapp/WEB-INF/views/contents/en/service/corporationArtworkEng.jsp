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
						<h2>Art Consulting &#38; Corporate Marketing</h2>
					</div>

					<!-- 배너 슬라이드 ->
					<div class="sub_banner02" id="slides">
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
						<div><img src="/images/eng/img/img_corp_banner01.jpg" alt="기업미술품" /></div>
						<div><img src="/images/eng/img/img_corp_banner01.jpg" alt="기업미술품" /></div>
						<div><img src="/images/eng/img/img_corp_banner01.jpg" alt="기업미술품" /></div>
					</div> --> 

					<div class="storage_cont title_area"> 
						<div class="line"></div>     
						<div class="title">    
							<!-- <p style="padding-bottom: 5px;">ART CONSULTING & CORPORATE MARKETING</p> -->  
							
							<div class="artcon_wrap artcon_marketing_infobox">           
								Seoul Auction offers diverse, individually tailored opportunities through corporate partnerships to help companies realize the goals they wish to pursue.   
								Create new opportunities through the extensive experience, expertise, and art market networks of <span class="txt_green">Seoul Auction</span> - Korea’s largest art business company.
							</div>   
						</div> 
					</div>

					<div class="storage_cont corp storage_cont_marnon"> 		
						<div class="artcon_wrap">  
							<ul class="artcon_boxwrap">  
								<li class="artcon_box artcon_img">
									<img src="/images/img/artcon/artconlist_01.jpg" alt="vip marketing img" title="vip marketing img">
								</li> 
								
								<li class="artcon_box artcon_caption artcon_caption_en">
									<div class="artcon_caption_ver artcon_caption_ver_en">    
										<h2 class="artcon_caption_tit artcon_caption_tit_en">VIP Customer Marketing through<br>Arts and Culture</h2>
										<div class="zero_btn02 artcon_morebtn artcon_morebtn_en">  
											<a href="/service/page?view=corporationArtwork-marketing">SEE MORE</a>  
										</div> 
									</div>	
								</li>
							</ul>     
							<ul class="artcon_boxwrap"> 
								<li class="artcon_box artcon_img">
									<img src="/images/img/artcon/artconlist_02.jpg" alt="special auction img" title="special auction img">
								</li> 
								
								<li class="artcon_box artcon_caption artcon_caption_en">
									<div class="artcon_caption_ver artcon_caption_ver_en">    
										<h2 class="artcon_caption_tit artcon_caption_tit_en">Special Auction</h2>
										<div class="zero_btn02 artcon_morebtn artcon_morebtn_en">  
											<a href="/service/page?view=corporationArtwork-specialauction">SEE MORE</a>  
										</div> 
									</div>	
								</li>
							</ul> 
							<ul class="artcon_boxwrap">  
								<li class="artcon_box artcon_img">
									<img src="/images/img/artcon/artconlist_03.jpg" alt="artservice img" title="artservice img">
								</li> 
								
								<li class="artcon_box artcon_caption artcon_caption_en">
									<div class="artcon_caption_ver artcon_caption_ver_en">    
										<h2 class="artcon_caption_tit artcon_caption_tit_en">Corporate Art Service</h2>
										<div class="zero_btn02 artcon_morebtn artcon_morebtn_en">  
											<a href="/service/page?view=corporationArtwork-artservice">SEE MORE</a>  
										</div> 
									</div>	
								</li>
							</ul>  
							<ul class="artcon_boxwrap">  
								<li class="artcon_box artcon_img"> 
									<img src="/images/img/artcon/artconlist_04.jpg" alt="artconsulting img" title="artconsulting img">
								</li> 
								
								<li class="artcon_box artcon_caption artcon_caption_en">
									<div class="artcon_caption_ver artcon_caption_ver_en">    
										<h2 class="artcon_caption_tit artcon_caption_tit_en">Art Consulting</h2>
										<div class="zero_btn02 artcon_morebtn artcon_morebtn_en">  
											<a href="/service/page?view=corporationArtwork-artconsulting">SEE MORE</a>  
										</div>  
									</div>	
								</li>
							</ul>   
						</div> 
					</div><!-- //storage_cont corp --> 
					
					<div class="box_gray type01">
						<div class="contact"> 
							<div class="title">문의 Contact</div>
							<div class="info">   
								<div class="highlight">Associate Manager / Marketing Team <strong>H.H KIM</strong></div> 
								<div class="tel"><strong class="tit">Tel</strong><span>+82-2-2075-4435</span></div>
								<div class="email"><strong class="tit">E-mail</strong><a href="mailto:hyunhee@seoulauction.com">hyunhee@seoulauction.com</a></div>
							</div>  
						</div>
						<div class="right">
							<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1 문의</a><span class="ico next02"></span></span>
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

		// 20150623
		maxH();
		$(window).resize(function() {
			$('.both_cont > div .inner').css('height', 'auto');
			maxH();
		});
		function maxH() {
			if ($(window).width() > 767) {
				$('.both_cont > div .inner').each(
						function() {
							var maxHeight = Math.max($(this).parent().parent()
									.height());
							$(this).css('height', maxHeight + 'px');
						});
			} else {
				$('.both_cont > div .inner').css('height', 'auto');
			}
		}
	</script>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />