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
			<div class="sub_menu_wrap menu03 artcon_submenu">
				<div class="sub_menu">
					<jsp:include page="../../include/artconsultingSubMenu.jsp" flush="false"/>
				</div>    
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->  
 
			<div class="contents_wrap">
				<div class="contents"> 
					<div class="tit_h2 artcon_tit_h2">
						<h2>Corporate Art Service</h2> 
					</div>
					
					<div class="storage_cont title_area artcon_wrapbox"> 
						<div class="line line_mar"></div>   
						<div class="title"></div>   
 
						<div class="storage_cont corp storage_cont_marnon">	
							<div class="artcon_wrap">     
								<div class="artcon_marketing_infobox artcon_marketing_infobox_en">  
									<p>  
										From the purchase of artworks to its long-term maintenance, Seoul Auction offers the appropriate planning and systematic management for everything related to corporate art collections.   
									</p>
								</div>  
								
								<div class="artcon_marketing_infobox artcon_marketing_infobox_en">   
									<dl>      
										<dt class="artcon_list_tit">
										<i class="material-icons md-20">image_search</i>Valuation</dt> 
										<dd>From ownership of a single work of art to a large collection, come to Seoul Auction for an honest appraisal of Korean and international artworks.</dd>  
									</dl>  
									
									<dl>  
										<dt class="artcon_list_tit">
										<i class="material-icons md-20">shopping_cart</i>Purchasing</dt>
										<dd>Consult with a Seoul Auction expert on the entire process of purchasing an artwork, from budget allocation to artwork analysis, determining an appropriate purchase time, and insurance & shipping.</dd>  
									</dl>
									
									<dl>  
										<dt class="artcon_list_tit"> 
										<i class="material-icons md-20">nature</i>Selling</dt> 
										<dd>Seoul Auction helps corporations find the ideal way to sell artworks. Based on comprehensive consideration of the ever-changing conditions of the art market, we provide assistance with determining the prices of artworks and deciding whether to sell via auction, private sale, or some other platforms.</dd>  
									</dl>
									
									<dl>  
										<dt class="artcon_list_tit">   
										<i class="material-icons md-20">settings</i>Comprehensive Care Service</dt> 
										<dd>Seoul Auction conveniently and safely undertakes every step of the corporate art acquisition process, from proposing artworks that best complement the given corporate space to shipping, installation, inspection of the artwork’s condition, and removal. Comprehensive care service is offered in conjunction with consulting on the management, maintenance, and improvement of the company’s existing art collection.</dd>  
									</dl> 
								</div>
							</div>
							<!-- 배너 슬라이드 -->
							<div class="web_only">
								<div class="sub_banner02" id="slides"> 
									<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
									<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
									<div><img src="/images/img/artcon/artservice01.jpg" alt="기업미술품" /></div>
									<div><img src="/images/img/artcon/artservice02.jpg" alt="기업미술품" /></div> 
								</div>
								<!-- 배너 1개 일 때 ->
		                        <div class="col12 last" style="padding-top:10px; overflow:hidden"> 
		                            <img src="/images/img/artcon/artservice.jpg" alt="banner" style="width:100%;"/>
		                        </div>  -->
							</div>
							<div class="m_only">
				            	<div class="sub_slide">
									<div class="bxslider">  
					            		<div class="sub_banner02">   
							                <div><img src="/images/img/artcon/artservice01.jpg" alt="기업미술품" /></div>
							            </div>
							            <div class="sub_banner02">    
							                <div><img src="/images/img/artcon/artservice02.jpg" alt="기업미술품" /></div>
							            </div>
					            	</div> 
				                </div>
				            </div><!--//m_only -->
						</div> 
					</div>	
						
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
			</div> <!-- //contents_wrap --> 
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