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
			<div class="sub_menu_wrap menu03 artcon_submenu">
				<div class="sub_menu">
					<jsp:include page="../../include/artconsultingSubMenu.jsp" flush="false"/>
				</div>    
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->  
 
			<div class="contents_wrap">
				<div class="contents"> 
					<div class="tit_h2 artcon_tit_h2 artcon_tit_h2_en">   
						<h2>VIP Customer Marketing through Arts and Culture</h2> 
					</div>
					
					<div class="storage_cont title_area artcon_wrapbox">    
						<div class="line line_mar"></div>    
						<div class="title"></div> 

						<div class="storage_cont corp storage_cont_marnon">  
							<div class="artcon_wrap">	  
								<div class="artcon_marketing_infobox artcon_marketing_infobox_en">   
									<p> 
										Seoul Auction, which is a strong proponent of transparency in the art market, has built a brand that is widely trusted both in Korea and overseas. 
										It is based on such recognition that Seoul Auction is able to undertake arts/culture marketing for corporations in diverse ways.  
										It forges relationships with companies in a wide range of areas, from luxury brands to investment banks, and provides unparalleled services for the VIP customers of these companies. 
										Many brands have recently increased their focus on “culture marketing” by providing VIP customers with services of the highest quality in various sectors (travel, luxury goods, etc.) that match their lifestyles.
										Offer your VIP customers an elegant and novel experience in the art-filled spaces of Seoul Auction.
									</p> 
								</div>  
								
								<div class="artcon_marketing_infobox artcon_marketing_infobox_en">
									<ul class="artcon_listbox">   
										<li class="artcon_list_tit">Expected benefits</li>       
										<li><i class="material-icons" style="font-size:13px;">check</i>Securing and development of sustainable strategies for long-term corporate competitiveness through arts/culture marketing</li>  
										<li><i class="material-icons" style="font-size:13px;">check</i>Differentiating corporate branding through the provision of content/services that are specifically tailored to each company</li>  
										<li><i class="material-icons" style="font-size:13px;">check</i>Expansion of communication points with company’s existing customers through arts and culture</li>
										<li><i class="material-icons" style="font-size:13px;">check</i>Transformation of corporate image that is more elegant and stylish, and enhancement of corporate value</li> 
									</ul>
								</div>
							</div>
							<!-- 배너 슬라이드 ->
							<div class="sub_banner02" id="slides"> 
								<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
								<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
								<div><img src="/images/img/artcon/artconlist_03.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
								<div><img src="/images/eng/img/img_corp_banner01.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
								<div><img src="/images/eng/img/img_corp_banner01.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
							</div> -->
							
							<!-- 배너 1개 일 때 -->
	                        <div class="col12 last" style="padding-top:10px; overflow:hidden"> 
	                            <img src="/images/img/artcon/marketing01.jpg" alt="banner" style="width:100%;"/>
	                        </div>   
                        </div> 
					</div>
					
					<div class="box_gray type01"> 
						<div class="contact">  
							<div class="title">Contact</div> 
							<div class="info">   
								<div class="highlight">PR & Marketing Team <strong>H.H KIM</strong></div>   
								<div class="tel"><strong class="tit">Tel</strong><a href="tel:+82 (0)2-2075-4435"><span>+82 (0)2-2075-4435</span></a></div> 
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