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
<script type="text/javascript" src="/js/angular/angular-animate.min.js"></script>  
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
						<h2>기획 경매</h2>
					</div>

					<div class="storage_cont title_area artcon_wrapbox">   
						<div class="line line_mar"></div>   
						<div class="title"></div>  
 
						<div class="storage_cont corp storage_cont_marnon">		
							<div class="artcon_wrap"> 
								<div class="artcon_marketing_infobox">  
									<p> 
										서울옥션은 그간의 노하우를 바탕으로 다양한 럭셔리 브랜드와 함께 스페셜 경매 기획을 진행해왔습니다. 
										기획경매를 통해 자동차, 와인, 보석, 디자인 가구 등을 선보이며 각 브랜드의 귀한 에디션 제품을 경매라는 특별한 플랫폼을 통해 홍보했습니다.
										좋은 안목으로 고가의 예술품을 구매하는 서울옥션의 고객분들께 귀사의 제품을 소개함으로서 긍정적인 시너지 효과를 기대해보십시오.   
									</p> 
								</div>
								
								<div class="artcon_marketing_infobox">
									<ul class="artcon_listbox">    
										<li class="artcon_list_tit">내용 및 기대효과</li>   
										<li><i class="material-icons" style="font-size:13px;">check</i>경매 및 전시, 부대행사 프로그램 진행에 따른 제반사항 제공 (인력, 시설 등)</li>  
										<li><i class="material-icons" style="font-size:13px;">check</i>서울옥션 전문가와의 컨설팅을 통한 최적의 경매 성과 및 홍보효과 도출</li>   
										<li><i class="material-icons" style="font-size:13px;">check</i>서울옥션 공간에서의 전시를 통한 제품 노출 및 문화예술계 내 주목도 향상 </li>
										<li><i class="material-icons" style="font-size:13px;">check</i>서울옥션 경매 도록 내 광고지면 삽입 및 제품 소개를 통한 홍보·마케팅</li>
										<li><i class="material-icons" style="font-size:13px;">check</i>서울옥션의 주요 컬렉터, 미술품 애호가들과의 네트워킹</li>
										<li><i class="material-icons" style="font-size:13px;">check</i>서울옥션 홍보채널을 통한 파트너사 브랜드 및 경매 홍보</li> 
									</ul>
								</div>
								
								<!-- 배너 슬라이드 -->
								<div class="web_only"> 
									<div class="sub_banner02" id="slides"> 
										<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
										<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
										<div><img src="/images/img/artcon/special01.jpg" alt="기업미술품" /></div>
										<div><img src="/images/img/artcon/special02.jpg" alt="기업미술품" /></div>  
										<div><img src="/images/img/artcon/special03.jpg" alt="기업미술품" /></div>
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
								                <div><img src="/images/img/artcon/special01.jpg" alt="기업미술품" /></div>
								            </div>
								            <div class="sub_banner02">   
								                <div><img src="/images/img/artcon/special02.jpg" alt="기업미술품" /></div>
								            </div>
								            <div class="sub_banner02">   
								                <div><img src="/images/img/artcon/special03.jpg" alt="기업미술품" /></div> 
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