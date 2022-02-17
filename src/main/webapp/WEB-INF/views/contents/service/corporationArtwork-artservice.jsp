<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<link href="<c:url value="/css/old/common.css" />" rel="stylesheet">
<link href="/css/jquery.bxslider.min.css" rel="stylesheet">           
<link href="/css/main_bxslider.css" rel="stylesheet">
<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="/js/angular/paging.js"></script>
<script type="text/javascript" src="/js/jquery.bxslider.js"></script>     
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">  
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container"> 
			<div class="sub_menu_wrap menu03 artcon_submenu"> 
				<div class="sub_menu">
					<jsp:include page="../include/artconsultingSubMenu.jsp" flush="false"/>
				</div> 
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->  
			
			<div class="contents_wrap">
				<div class="contents"> 
					<div class="tit_h2 artcon_tit_h2">
						<h2>미술품 컬렉션</h2>
					</div>  
					
					<div class="storage_cont title_area artcon_wrapbox">
						<div class="line line_mar"></div>   
						<div class="title"></div>   

						<div class="storage_cont corp storage_cont_marnon">		
							<div class="artcon_wrap">   
								<div class="artcon_marketing_infobox">  
									<p> 
										미술품 구입부터 관리, 보관, 판매까지<br> 
										서울옥션이 기업의 컬렉션 전반에 관한 기획과 체계적인 관리를 도와드립니다.   
									</p>
								</div>  
								
								<div class="artcon_marketing_infobox">   
									<dl>      
										<dt class="artcon_list_tit">
										<i class="material-icons md-20">image_search</i>미술품 가치 평가 서비스</dt>
										<dd>단 한 점의 소장품부터 대규모 컬렉션까지, 국내외 모든 미술품의 가치는 서울옥션에서 확인하십시오.</dd>  
									</dl>
									
									<dl>  
										<dt class="artcon_list_tit">
										<i class="material-icons md-20">shopping_cart</i>미술품 구매 서비스</dt>
										<dd>미술품 구매의 예산 책정, 작품 분석부터 적합한 구매 시점과 보험·운송까지, 작품 구매에 필요한 전 과정을 서울옥션의 전문가와 상의하십시오.</dd>  
									</dl>
									
									<dl>  
										<dt class="artcon_list_tit">  
										<i class="material-icons md-20">nature</i>미술품 판매 서비스</dt>
										<dd>수시로 변하는 미술시장의 상황을 고려한 작품의 가격 산정, 경매, 프라이빗 세일 등 최선의 방식을 찾아 기업의 작품의 판매를 진행합니다.</dd>  
									</dl>
									
									<dl>  
										<dt class="artcon_list_tit">   
										<i class="material-icons md-20">settings</i>토탈 케어 서비스</dt>  
										<dd>사옥 공간에 맞는 작품 제안, 운송, 설치, 작품 상태 점검, 철수까지 작품을 다룸에 있어 필요한 전 과정을 편리하고 안전하게 대행합니다.<br> 나아가, 기존의 기업 소장품 관리 및 유지, 개선에 대한 컨설팅 서비스도 함께 진행합니다. </dd>  
									</dl> 
								</div>
								
								<!-- 배너 슬라이드 -->
								<div class="web_only">
									<div class="sub_banner02" id="slides"> 
										<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
										<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
										<div><img src="/images/img/artcon/artservice01.jpg" alt="기업미술품" /></div>
										<div><img src="/images/img/artcon/artservice02.jpg" alt="기업미술품" /></div> 
										
										<!-- 배너 1개 일 때 -> 
				                        <div class="col12 last" style="padding-top:10px; overflow:hidden"> 
				                            <img src="/images/img/artcon/artservice.jpg" alt="banner" style="width:100%;"/>
				                        </div>  -->
									</div>	     
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
					</div>	
					
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