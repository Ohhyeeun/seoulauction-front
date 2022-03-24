<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<link href="<c:url value="/css/old/common.css" />" rel="stylesheet">
<%-- YDH 추가 시작--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link href="/css/jquery.bxslider.min.css" rel="stylesheet">           
<link href="/css/main_bxslider.css" rel="stylesheet">

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
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../include/serviceSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div> 
			<!-- //sub_menu_wrap --> 

			<div class="contents_wrap">  
				<div class="contents"> 
					<div class="tit_h2 donation-pd">     
						<h2>후원 및 기증</h2> 
					</div>  
					
					<div class="storage_cont title_area artcon_wrapbox">
						<!-- <div class="line"></div> -->
						<div class="line"></div>           
						<div class="title"> 
							<div class="artcon_wrap">     
								<p class="artcon_info01">   
									<span class="txt_green">서울옥션</span>은 여러분의 소중한 후원을 기다립니다.  
								</p>   
							</div>    
						</div>	
 
						<div class="storage_cont corp storage_cont_marnon" style="margin-top: 10px;">  
							<div class="artcon_wrap">   	
								<div class="artcon_marketing_infobox">   
									<p>       
										한국의 대표 미술품 경매회사인 서울옥션은 해외 곳곳에 흩어진 우리 문화재를 발굴해 국내에 소개하는 과업에 대해 기업의 사회적 책임의식(CSR)을 갖고 지속적인 활동을 펼쳐왔습니다. 그 결과 다수의 문화재가 서울옥션을 통해 한국에 돌아온 바 있습니다.
										이러한 경험을 바탕으로 서울옥션은 2018년 문하재청 산하 국외소재문화재재단과 업무협약을 체결하고, 여러분이 기부해주시는 소중한 미술품과 물품을 모아 매해 ＜국외소재 문화재 환수를 위한 후원경매＞를 진행하고 있습니다. 경매 수익금은 후원금 형태로 재단에 전달, 해외에 흩어진 우리 문화재를 고국으로 환수하는 사업에 사용되고 있습니다.
										올해도 어김없이 진행되는 ＜2020 국외소재 문화재 환수를 위한 후원경매＞에 여러분의 많은 기부와 참여 부탁드립니다.  
									</p>
								</div>   
								
								<div class="artcon_marketing_infobox"> 	
									<dl>     
										<dt class="artcon_list_tit">
										<i class="material-icons md-20">redeem</i>후원품</dt>
										<dd>한국 근현대 및 고미술, 해외 미술작품을 비롯한 다양한 형태의 물품과 현물</dd>     
										<dd class="artcon_info_red" style="color:#333;">현물 예시) 레스토랑 이용권, 브랜드 상품권, 항공권, 가방 및 의류 등</dd>    
									</dl> 
									
									<dl>  
										<dt class="artcon_list_tit">
										<i class="material-icons md-20">iso</i>후원금 범위</dt>
										<dd>위탁금액의 최소 50%부터 최대 100%까지</dd>  
									</dl>
								
									<table class="artcon_table" summary="후원혜택 표">     
										<caption><i class="material-icons md-20">thumb_up</i>후원혜택</caption>
										<colgroup>
											<col width="50%">
											<col width="*">
										</colgroup>  
										<thead>  
											<tr>  
												<th scope="col">개인</th>  
												<th scope="col">법인</th>
											</tr>  
										</thead>
										<tbody>  
											<tr>
												<td>
													<ul>
														<li>종합소득산출세액에서 기부금의 15%를 공제한 기부영수증 발행<br>(1,000만원 초과분은 30%)</li>
													</ul>  
												</td> 
												<td>
													<ul>
														<li>  
															소득금액 50%까지 손금산입
														</li>
														<li>
															기부영수증 발행 
		  												</li>
													</ul>
												</td>
											</tr>
											<tr>
												<td colspan="2">   
													후원 금액에 따른 경매도록 내 광고 페이지 제공
												</td> 
											</tr>
											<tr>         
												<td colspan="2"> 
													언론보도 시 후원사명 게재
		  										</td> 
											</tr>
										</tbody>
									</table>
									
									<div class="artcon_info_red" style="margin-top: 10px; margin-bottom: 50px;">       
										※ 기부영수증은 국외소재문화재재단의 법정기부금 단체인 ‘문화유산국민신탁’ 명의로 발행
									</div>
									 
									<dl>     
										<dt class="artcon_list_tit">  
										<i class="material-icons md-20">apartment</i>국외소재문화재재단 소개</dt>
										<dd>    
											문화재청 산하 국외소재문화재재단은 2012년 설립된 이래 해외 한국문화재의 조사, 환수, 활용, 보존복원 지원, 민간협력 등 국외문화재에 관한 사업들을 종합적으로 수행해오고 있습니다. 특히 해외 미술품 유통시장을 상시 모니터링하여 우리 유물을 다시 국내로 매입하는 활동을 펼치고 있으며, 최근 효명세자빈책봉죽책, 덕온공주동제인장 등 중요 문화재들이 한국으로 돌아온 바 있습니다.
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
								<div class="highlight">서울옥션 전시마케팅팀 <strong>김현희 팀장</strong></div>   
								<div class="tel"><strong class="tit">Tel</strong><span>02-2075-4435</span></div>
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
	<!-- 20150521 -->
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