<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container">
			<div class="sub_menu_wrap menu02">
				<div class="sub_menu">
					<jsp:include page="../include/PS_Submenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>P/S 가이드</h2>  
					</div>
					
					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="title">
							<h3><span class="txt_green">당신의 작품</span>을 가장 글로벌하고 가치 있게 보여 드립니다. </h3>
						</div>
						<p style="line-height:30px; font-size:16px;">1998년 설립한 국내 최초의 미술품 경매 회사 서울옥션은 서울의 평창동과 강남 사옥, 부산과 홍콩 전시장까지, 다양한 작품을 감상할 수 있는 최상의 전시장을 보유하고 있습니다. 강남과 강북의 다양한 고객층을 위한 본사와 강남 사옥을 운영하는 것은 물론 서울옥션은 설립 20주년을 맞이하여 홍콩의 아트 랜드마크인 H Queen’s 11층에 프라이빗 전시장 에스에이플러스(SA+)를 오픈했습니다. 김환기, 이우환 등의 한국 작가뿐 아니라 해외 유명 작가의 전시를 관람할 수 있습니다. 전세계 컬렉터와 호흡하는 서울옥션이 보유한 다양한 공간에서 당신 작품의 가치를 보여 드립니다. </p>
                        <br/><br/>
                        <div class="title">
							<h3>서울옥션 <span class="txt_green">프라이빗 세일</span>의 전문성</h3>
						</div>
						<p style="line-height:30px; font-size:16px;">서울옥션은 한국 최초의 미술품 경매 회사로 꾸준히 경매를 이어오며 미술품 가치의 새로운 기준을 제시해왔습니다. 단 한 점의 소장품부터 대규모 컬렉션, 고미술품부터 해외 미술에 이르기까지 미술품의 가치를 평가하는 고객 밀착형 서비스를 시행합니다. 특히, 서울옥션의 프리이빗 세일 노하우는 글로벌 플랫폼과 전문성 그리고 낙찰 기록을 바탕으로 다양한 고객들에게 작품의 가치를 전달합니다. 당신 작품의 가치를 가장 만족스럽게 보장해 드립니다. </p>
                        
						
						<div class="box_gray type01"> 
							<div class="contact">
								<div class="title">문의 Contact</div>
								<div class="info">  
									<div class="highlight">서울옥션 파트너그룹 <strong>김승엽 선임</strong></div>  
									<div class="tel"><strong class="tit">Tel</strong> <span>02-2075-4426</span></div>
                                    <div class="tel"><strong class="tit">H.P</strong> <span>010-9045-0315</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:rinda@seoulauction.com">syk@seoulauction.com</a></div>
								</div> 
							</div>   
							<!--<div class="right">  
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
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
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />