<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		
		<div id="container">
			<div class="sub_menu_wrap menu03"> 
				<div class="sub_menu">
					<jsp:include page="../include/PS_Submenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

		<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2><img src="/images/img/saplus.jpg" alt="saplus" /></h2>
					</div>
					<!-- 20150521 -->
					<!-- <div class="sub_banner02" id="slides">  
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>  
						<div><img src="/images/img/sa/img_saplus_banner27.jpg" alt="saplus" /></div>
                        <div><img src="/images/img/sa/img_saplus_banner28.jpg" alt="saplus" /></div>
						<div><img src="/images/img/sa/img_saplus_banner29.jpg" alt="saplus" /></div>
                        <div><img src="/images/img/sa/img_saplus_banner30.jpg" alt="saplus" /></div>
                        <div><img src="/images/img/sa/img_saplus_banner31.jpg" alt="saplus" /></div>
					</div> -->
					<!-- //20150521 -->
                    <div><div><img src="/images/img/img_saplus_banner2020022501.jpg" alt="saplus" style="width:100%"/></div></div>

                    <br/><br/><br/><br/>
					<div class="storage_cont title_area">
					 	<div class="title">
							<p>서울옥션 홍콩 SA+ 전시기획</p> 
							<h3>Winter Collection with Special Section of PAIK NAMJUNE</h3>
						</div>
						<p style="line-height:30px; font-size:16px;">
							2020.1.29(水) – 2020.3.28(土)<br />
                          	10am–7pm(매주 월요일 휴관)<br />
                            서울옥션 홍콩 SA+ (11F, H Queen’s, 80 Queen's Road Central, Central, Hong Kong)<br /><br />
                            +852-2537-1880 / saplus@seoulauction.com
						</p> 
                        <br/>
                        <!-- <a href="/currentExhibit?sale_kind=exhibit_only&sale_no=538"  class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 15px 45px 17px;font-size: 18px; font-weight:700; color:#FFF;" >작품 보기</a>
                         &nbsp;&nbsp;
                        <!-- <a href="/service/page?view=auction360VRPop_online2"  class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 15px 30px 17px;font-size: 18px; font-weight:700; color:#FFF; width:120px;"  target="new" >전시장보기</a>
                        <br/<br/><br/> -->
						<p style="border-top: #CCC solid 1px; line-height:30px; font-size:16px;"><br/><br/>
                         2020년을 맞이하여 SA+에서는 피에르 오귀스트 르누아르, 탐 웨슬만, 윤형근, 줄리안 오피, 요시토모 나라 등 미술계의 스펙트럼을 넓힌 유명 작가들의 작품들로 구성된 Winter Collection 전시와 더불어, 플럭서스 운동의 핵심 멤버이자 비디오아트의 창시자인 백남준의 작품세계를 재조명한다.
						기술과학에 바탕을 둔 첨단 매체에 큰 관심을 가졌던 백남준의 다양한 작품들을 한자리에 모은 스페셜 섹션은, 서커스 단원의 모습을 로봇으로 재현한 대형 설치작품부터 영감의 원천이었던 존 케이지의 퍼포먼스 영상을 활용한 작품 그리고 1998년부터 2000년까지의 드로잉을 모니터 영상으로 나타낸 평면 미디어작품까지 백남준의 창조적 발상이 돋보이는 다양한 작품들로 구성되었다. 또한 1963년 3월 독일에서 첫 개인전 당시 소의 머리를 전시해 놓았던 파격적인 현장이 고스란히 담긴 판화들과 생전 백남준의 모습을 그대로 담아낸 임영균의 사진작품들은 다양한 표현과 전위적인 실험정신이 깃든 백남준 예술의 진면목을 살펴볼 수 있는 기회를 제공한다.
						화려한 팝아트부터 단색 추상미술, 그리고 기술발달의 최전선에 자리했던 미디어를 다양한 예술 영역에 융합한 백남준의 작품까지, 전 세계 근 현대 미술의 다양한 면모를 이번 전시를 통해 감상해 보길 바란다.
						</p>
                        <br/><br/><br/> 
                        

						<div class="box_gray type01">
							<div class="contact">
								<div class="title">문의 Contact</div>
								<div class="info">
									<div class="highlight"><strong>SA+</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>+852-2537-1880</span></div>
                                    <div><strong class="tit">Fax</strong> <span>+852-2537-2810</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:saplus@seoulauction.com">saplus@seoulauction.com</a></div>
                                    <div><strong class="tit">Instagram</strong> <a href="https://www.instagram.com/saplushk" target="new">saplushk</a></div>
								</div>
							</div>
							<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
							</div>
						</div>
					</div>
                    
                    
                     <div class="storage_cont">	
						<div class="tit_h3 through">
							<h3>Location</h3>
						</div>
						
						<div class="map_area">
							<div class="left">
								<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d922.9663384497002!2d114.15541616181474!3d22.283089741982685!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3404007b56b8bc71%3A0x674006e435d48fcd!2sSA%2B+%2F+Seoul+Auction+Plus+HongKong!5e0!3m2!1sko!2skr!4v1539326118876" width="300" height="240" frameborder="0" style="border:0"></iframe>
							</div>
							<div class="right">
								<div class="title">SA+</div>
								<!-- 20150608 -->
								<div class="cont">
									<dl>
                                        <dt>ADDRESS</dt>
                                        <dd>11F, H Queen’s, 80 Queen's Road Central, Central, Hong Kong</dd>
                                    </dl>
                    
									<dl class="subway">
										<dt><img src="/images/icon/subway.jpg" style="width:60px; height:auto;"/></dt>
										<dd>
											<div class="metro"><span>Island Line</span> <strong>Central Station 中環站 </strong></div>	
											<div class="metro"><span>Tsuen Wan Line</span> <strong>Central Station 中環站</strong></div>
										</dd>
									</dl>
								</div> 
								<!-- //20150608 -->
							</div>
						</div>
                	</div>
				</div>
			</div>
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
	</script>
	<!-- //20150521 -->
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />