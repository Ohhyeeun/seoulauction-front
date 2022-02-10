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
					<div class="tit_h2 donation-pd">  
						<h2>Art Donations</h2> 
					</div>   
					
					<div class="storage_cont title_area artcon_wrapbox">  
						<!-- <div class="line"></div> -->
						<div class="line"></div>         
						<div class="title"> 
							<!-- <div class="artcon_wrap">     
								<p class="artcon_info01">  
									<span class="txt_green">서울옥션</span> 여러분의 소중한 후원을 기다립니다.
								</p>   
							</div> -->     
						</div>	 
 
						<div class="storage_cont corp storage_cont_marnon" style="margin-top: 10px;">  
							<div class="artcon_wrap">   	
								<div class="artcon_marketing_infobox artcon_marketing_infobox_en">  
									<p>    
										<span class="txt_green">Seoul Auction</span> awaits your invaluable contributions to the community. As Korea’s most representative art auction company and based on our strong sense of corporate social responsibility, Seoul Auction has consistently participated in efforts to discover and spread awareness of Korean cultural heritage assets that are located overseas. As a result, several of such assets have been repatriated to Korea through Seoul Auction.
										Based on such experiences, Seoul Auction signed an MOU in 2018 with the Overseas Korean Cultural Heritage Foundation (OKCHF), which is affiliated with the Cultural Heritage Administration. One of the most important annual activities conducted through this partnership is the Charity Auction for the Repatriation of Overseas Korean Cultural Heritage Assets, which is made possible by the general public’s donations of artworks and objects. The auction proceeds, which are conveyed to the OKCHF in the form of a donation, are used to repatriate Korean cultural heritage assets currently housed overseas.
										We anticipate increased interest and participation in the 2020 Charity Auction for the Repatriation of Overseas Korean Cultural Heritage Assets.
									</p>
								</div>
								
								<div class="artcon_marketing_infobox artcon_marketing_infobox_en">   	
									<dl>     
										<dt class="artcon_list_tit">
										<i class="material-icons md-20">redeem</i>Donated Items</dt>
										<dd>Works of traditional or modern/contemporary Korean art, works of international art, and any of various types of objects in-kind</dd>  
										<dd class="artcon_info_red" style="color:#333;">Examples of objects in-kind : restaurant gift voucher, brand gift voucher, airline tickets, fashion & luxury goods, etc.</dd>    
									</dl>      
									
									<dl>  
										<dt class="artcon_list_tit">
										<i class="material-icons md-20">iso</i>Range of donation amount</dt>
										<dd>Between 50% and 100% of consignment fee</dd>  
									</dl>
								
									<table class="artcon_table" summary="후원혜택 표">     
										<caption><i class="material-icons md-20">thumb_up</i>Donation Benefits</caption>
										<colgroup>
											<col width="50%">
											<col width="*">
										</colgroup>  
										<thead>  
											<tr>  
												<th scope="col">Individual</th>  
												<th scope="col">Corporation</th>
											</tr>  
										</thead>
										<tbody>  
											<tr>
												<td>
													<ul>
														<li>Issuance of donation receipt that deducts 15% of the donated amount from calculated / assessed tax amount of total income (30% for amounts in excess of KRW 10,000,000) </li>
													</ul>  
												</td> 
												<td>
													<ul>
														<li>  
															Corporations: designation of up to 50% of the income amount as deductible expenses
														</li>
														<li>
															Issuance of donation receipt 
		  												</li>
													</ul>
												</td>
											</tr>
											<tr>
												<td colspan="2">   
													<ul>
														<li>
															Issuance of donation receipt 
														</li>
														<li>   
															Listing donor companies’ name in the event of a press release
														</li>
													</ul>
												</td> 
											</tr>  
										</tbody>
									</table>  
									
									<div class="artcon_info_red" style="margin-top: 10px; margin-bottom: 50px;">     
										※ Issuance of donation receipt in the name of a legal contribution agency (National Trust forCultural Heritage)
									</div>  
								 
									<dl>     
										<dt class="artcon_list_tit">
										<i class="material-icons md-20">apartment</i>About Overseas Korean Cultural Heritage Foundation (OKCHF)</dt>
										<dd>    
											The Overseas Korean Cultural Heritage Foundation (OKCHF) is affiliated with the Cultural Heritage Administration. Since its founding in 2012, the OKCHF has implemented a comprehensive range of projects related to overseas Korean cultural heritage assets (support for survey/recovery/utilization, preservation/restoration of overseas cultural heritage assets, cooperation with private sector, etc.). In particular, through constant monitoring of the international art market, the OKCHF purchases Korean artifacts to bring them back to Korea. Recently, the 'Bamboo Investiture Book for the Consort of Crown Prince Hyomyeon' and 'Seal of Princess Deokon (Deok’on gongju ji in)' were repatriated.
										</dd>    
									</dl>  
								</div>  
							</div>  
								
							<!-- 배너 슬라이드 -->
							<div class="web_only">
								<div class="sub_banner02" id="slides"> 
									<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
									<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a> 
									<div><img src="/images/img/artcon/support01.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
									<div><img src="/images/img/artcon/support02.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
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
							                <div><img src="/images/img/artcon/support01.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
							            </div>
							            <div class="sub_banner02">    
							                <div><img src="/images/img/artcon/support02.jpg" alt="문화예술을 활용한 VIP 고객 마케팅" /></div>
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