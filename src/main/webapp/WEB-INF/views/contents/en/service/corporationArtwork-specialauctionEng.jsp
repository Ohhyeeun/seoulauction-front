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
						<h2>Special Auction</h2>    
					</div>
					
					<div class="storage_cont title_area artcon_wrapbox">   
						<div class="line line_mar"></div>   
						<div class="title"></div> 

						<div class="storage_cont corp storage_cont_marnon">   	
							<div class="artcon_wrap">
								<div class="artcon_marketing_infobox artcon_marketing_infobox_en">  
									<p>  
										Based on its extensive expertise and experience, Seoul Auction has designed several fascinating auctions over the years in collaboration with luxury brands. Its special auctions feature a wide range of items (cars, wine, jewelry, designer furniture, etc.) and promote each brand’s rare-edition items through the very special platform of the auction.
										A special auction is an opportunity for a company to create positive synergy by introducing its products to Seoul Auction customers, who have an excellent eye for art and acquire high-priced artworks.
									</p>  
								</div>
								
								<div class="artcon_marketing_infobox artcon_marketing_infobox_en">
									<ul class="artcon_listbox">  
										<li class="artcon_list_tit">Expected benefits</li>    
										<li><i class="material-icons" style="font-size:13px;">check</i>Product exposure through exhibition(s) at Seoul Auction and greater recognition of the company in its field</li>  
										<li><i class="material-icons" style="font-size:13px;">check</i>Provision of infrastructure (personnel, facilities, etc.) required for an exhibition and/or auction</li>  
										<li><i class="material-icons" style="font-size:13px;">check</i>PR/marketing through advertisements and/or product pages in Seoul Auction’s catalogue</li>
										<li><i class="material-icons" style="font-size:13px;">check</i>Generation of optimum auction outcomes and PR effect through consultations with a Seoul Auction expert</li>
										<li><i class="material-icons" style="font-size:13px;">check</i>Networking with collectors and art enthusiasts who have an ongoing relationship with Seoul Auction</li>
										<li><i class="material-icons" style="font-size:13px;">check</i>Promotion of a brand and/or relevant auctions through Seoul Auction’s PR channels</li>
									</ul>
								</div>
							</div>
							
							<!-- 배너 슬라이드 -->
							<div class="web_only">
								<div class="sub_banner02" id="slides"> 
									<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
									<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
									<div><img src="/images/img/artcon/special01.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
									<div><img src="/images/img/artcon/special02.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
									<div><img src="/images/img/artcon/special03.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
								</div> 
								<!-- 배너 1개 일 때 ->
		                        <div class="col12 last" style="padding-top:10px; overflow:hidden"> 
		                            <img src="/images/img/artcon/marketing01.jpg" alt="banner" style="width:100%;"/>
		                        </div> -->
							</div>
							<div class="m_only">
				            	<div class="sub_slide">
									<div class="bxslider">  
					            		<div class="sub_banner02">   
							                <div><img src="/images/img/artcon/special01.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
							            </div>
							            <div class="sub_banner02">   
							                <div><img src="/images/img/artcon/special02.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
							            </div>
							            <div class="sub_banner02">    
							                <div><img src="/images/img/artcon/special03.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
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