<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<link href="<c:url value="/css/old/common.css" />" rel="stylesheet">
<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="/js/angular/paging.js"></script>  
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
						<h2>아트 컨설팅 &#38; 기업 마케팅</h2> 
					</div>  
					
					<div class="storage_cont title_area artcon_wrap">  
						<div class="line"></div>    
						<div class="title">   
							<!-- <p style="padding-bottom: 5px;">아트 컨설팅 & 기업 마케팅</p> -->   
							<p class="artcon_info01">     
								미술품과 함께하는 기업의 새로운 도약<br>
								<span class="txt_green">서울옥션</span>과 함께 하십시오.
							</p> 
						</div>	
						<p class="artcon_info02">       
							서울옥션은 기업 파트너십을 통해 다양한 맞춤형 기회를 제공함으로써 기업이 추구하는 목표를 완성시켜 드립니다.<br>
							 국내 최고의 아트 비즈니스 기업인 서울옥션만의 축적된 노하우, 전문지식, 미술시장 내 네트워크를 통해 새로운 기회를 만들어 보십시오.
						</p>   
					</div>

					<div class="storage_cont corp storage_cont_marnon">  		
						<div class="artcon_wrap"> 
							<ul class="artcon_boxwrap">  
								<li class="artcon_box artcon_img">  
									<img src="/images/img/artcon/artconlist_01.jpg" alt="vip 고객 마케팅 이미지" title="vip 고객 마케팅 이미지">
								</li> 
								
								<li class="artcon_box artcon_caption">
									<div class="artcon_caption_ver">    
										<h2 class="artcon_caption_tit">문화예술을 활용한 VIP 고객 마케팅 </h2>
											서울옥션의 특별한 공간에서 귀사의 VIP 고객에게 높은 수준의 문화예술 경험을 선사해보십시오.
										<div class="zero_btn02 artcon_morebtn">   
											<a href="/service/page?view=corporationArtwork-marketing">자세히 보기</a>  
										</div> 
									</div> 
								</li> 
							</ul>   
							<ul class="artcon_boxwrap">  
								<li class="artcon_box artcon_img">
									<img src="/images/img/artcon/artconlist_02.jpg" alt="기획경매 이미지" title="기획경매 이미지">
								</li> 
								
								<li class="artcon_box artcon_caption">
									<div class="artcon_caption_ver">    
										<h2 class="artcon_caption_tit">기획 경매</h2>
											좋은 안목으로 고가의 미술품을 구매하는 서울옥션의 고객분들께 귀사의 제품을 소개함으로서 긍정적인 시너지 효과를 기대해보십시오. 
										<div class="zero_btn02 artcon_morebtn">  
											<a href="/service/page?view=corporationArtwork-specialauction">자세히 보기</a>  
										</div>  
									</div> 
								</li>
							</ul> 
							<ul class="artcon_boxwrap">  
								<li class="artcon_box artcon_img">
									<img src="/images/img/artcon/artconlist_03.jpg" alt="미술품 컬렉션" title="미술품 컬렉션">
								</li> 
								
								<li class="artcon_box artcon_caption">
									<div class="artcon_caption_ver">     
										<h2 class="artcon_caption_tit">미술품 컬렉션</h2>
											서울옥션이 미술품 구입부터 관리까지 기업의 컬렉션 전반에 관한 기획과 체계적인 관리를 도와드립니다. 
										<div class="zero_btn02 artcon_morebtn">   
											<a href="/service/page?view=corporationArtwork-artservice">자세히 보기</a>  
										</div>      
									</div>
								</li>
							</ul>  
							<ul class="artcon_boxwrap">  
								<li class="artcon_box artcon_img">
									<img src="/images/img/artcon/artconlist_04.jpg" alt="기획경매 이미지" title="기획경매 이미지">
								</li>
								
								<li class="artcon_box artcon_caption">
									<div class="artcon_caption_ver">    
										<h2 class="artcon_caption_tit">아트 컨설팅</h2>
											1:1 비즈니스 컨설팅을 통해 기업 특성에 맞는 문화예술 마케팅과 그 외 모든 고민을 서울옥션과 함께 나눠보세요.
										<div class="zero_btn02 artcon_morebtn"> 
											<a href="/service/page?view=corporationArtwork-artconsulting">자세히 보기</a>  
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
								<div class="highlight">서울옥션 홍보마케팅팀 <strong>김현희 팀장</strong></div>   
								<div class="tel"><strong class="tit">Tel</strong><a href="tel:02-2075-4435"><span>02-2075-4435</span></a></div> 
								<div class="email"><strong class="tit">E-mail</strong><a href="mailto:hyunhee@seoulauction.com">hyunhee@seoulauction.com</a></div> 
							</div>
						</div> 
						
						<div class="right">
							<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1 문의</a><span class="ico next02"></span></span>
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
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />