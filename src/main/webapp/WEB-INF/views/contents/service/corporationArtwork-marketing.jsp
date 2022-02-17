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
						<h2>문화예술을 활용한 VIP 고객 마케팅</h2> 
					</div>
					
					<div class="storage_cont title_area artcon_wrapbox">      
						<div class="line line_mar"></div>   
						<div class="title"></div> 

						<div class="storage_cont corp storage_cont_marnon">
							<div class="artcon_wrap">     
								<div class="artcon_marketing_infobox">   
									<p> 
										투명한 미술시장을 선도하는 서울옥션의 브랜드는 국내외 두터운 신뢰를 받고 있습니다. 이를 바탕으로 서울옥션은 기업의 문화예술 마케팅을 다양한 형식으로 진행합니다. 
										럭셔리 브랜드부터 투자은행에 이르기까지 여러 분야의 기업과 관계를 맺고 각각의 VIP 고객에게 차별화된 서비스를 제공해오고 있습니다.  
										최근 수많은 브랜드들이 VIP 고객의 라이프 스타일에 맞게 여행, 호텔, 명품 등 분야별 최상위 서비스를 제공하며 문화마케팅에 주력하고 있습니다.   
										미술품이 가득한 서울옥션만의 특별한 공간에서 귀사의 고객에게 높은 수준의 새로운 경험을 선사해보십시오. 
									</p>
								</div>
								
								<div class="artcon_marketing_infobox">
									<ul class="artcon_listbox">  
										<li class="artcon_list_tit">내용 및 기대효과</li>   
										<li><i class="material-icons" style="font-size:13px;">check</i>문화예술 마케팅을 통한 기업의 장기적 경쟁력 확보 및 지속가능한 전략 개발</span></li>  
										<li><i class="material-icons" style="font-size:13px;">check</i>각 기업에 특화된 콘텐츠/서비스 제공에 따른 기업의 브랜딩 차별화</span></li>  
										<li><i class="material-icons" style="font-size:13px;">check</i>문화예술을 매개로 기존 고객과의 소통 확장</span></li>
										<li><i class="material-icons" style="font-size:13px;">check</i>세련되고 감각적인 기업 이미지 제고 및 가치 향상</li> 
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
		
		$('.artcon_submenu').slideup(200);
	</script>
	<!-- //20150521 -->
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />