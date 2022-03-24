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
						<h2><spring:message code="label.seoulauction.introgang2" /></h2> 
					</div>   
					<!-- 20150521 --> 
					 <!--<div class="sub_banner02" id="slides"> 
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>  
						<div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
                        <div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
						<div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
                        <div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
                        <div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div> 
					</div>-->
					<!-- //20150521 --> 
                     <div><img src="/images/img/gnag/img_banner17.jpg" alt="saplus" width="100%" height="auto" /></div>   
    
                    <br/><br/><br/><br/>   
					<div class="storage_cont title_area">
					 	<div class="title" style="margin-bottom: 10px;"> 
							<p>서울옥션 강남센터 전시기획</p>   
							<h3 style="margin-top:10px;">object : be beautiful, be useful</h3>
						</div>  
						<p style="line-height:30px; font-size:16px;">
							2020.4.30(木) - 2020.5.28(木)<br>
                            10am - 7pm<br>
                            서울옥션 강남센터 6층 (서울시 강남구 언주로 864) 
						</p>
                        <br/>
                        <!-- <a href="/currentExhibit?sale_kind=exhibit_only&sale_no=539"  class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 15px 45px 17px;font-size: 18px; font-weight:700; color:#FFF;" >작품 보기</a>
                        <!-- &nbsp;&nbsp;-->
                        <!-- <a href="https://www.seoulauction.com/service/page?view=auction360VRPop_ex"  class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 15px 45px 17px;font-size: 18px; font-weight:700; color:#FFF; width:120px;" target="new" >전시장 보기</a>  -->
                        <br/><br/><br/>  
						<p style="border-top: #CCC solid 1px; line-height:30px; font-size:16px;"><br/><br/>
                            몇 년 전부터 세계적으로 이슈화 된 로컬리티에 대한 관심 덕분으로 지역에 온전하게 뿌리를 둔 '공예'가 재조명 받기 시작하였고,
                            이런 흐름을 영리하게 잡아낸 스페인의 로에베(Loewe)는 ‘로에베 공예상(Loewe Craft Prize)’을 제정하면서 에르메스, 루이비통, 까르띠에 등 유수의 럭셔리 브랜드가 현대 미술에 올인하는 동안 상대적으로 잊힌 ‘공예’라는 이슈를 선점하였습니다.
                            이렇듯 19세기 말 영국에서 윌리엄 모리스를 중심으로 일어났던 Art and Crafts Movement의 이론이 현재시점에 다시 회자되며 그 중요성을 일깨우고 있으며, 삶의 질과 풍요로움,
                            그리고 아름다움을 추구하는 현대 사회의 욕구와도 상통하는 공예는 Only One 이라는 한정성으로 그 가치를 더하고 있습니다.  
							이에 강남센터에서는 프랑스와 덴마크, 독일, 일본을 기반으로 물성을 탐구하여 고유의 미감을 보여주는 작가의 오브제들과 한국을 대표하는 작가들의 회화를 통해 아름다운 라이프 스타일을 제시하고자 합니다.  
						</p>  
                        <p style="font-size: 12px; margin-top: 20px;">
                        	<strong>참여작가</strong><br/> 
                            Sylvie Enjalbert<br/>
                            Ernst Gamperl<br/>
                            Bodil Manz <br/>
                            Shimoo Design<br/>
                            -<br/>
                            Lee UFan<br/>
                            Park SeoBo <br/>
                            Ha ChongHyun<br/>
                            Chung SangHwa<br/>
                            Kim TschangYeul<br/>
                            Lee DongYup<br/>
                            Oh SuFan<br/>
                            Yang Haegue <br/>
                            Choi YoungWook<br/>
                            Hong SooYeon
                        </p>
                        <br/><br/><br/>  
 
						<div class="box_gray type01">  
							<div class="contact"> 
								<div class="title">문의 Contact</div>
								<div class="info">
									<div class="highlight">서울옥션 <strong>윤가람 선임</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>02-2075-4422</span></div>
                                    <div class="email"><strong class="tit">E-mail</strong> <a href="mailto:hyoon@seoulauction.com">kyoon@seoulauction.com</a></div>
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
								<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12655.621508400407!2d127.03040534787746!3d37.533727752054204!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x20893aab0caffe0c!2zKOyjvCnshJzsmrjsmKXshZgg6rCV64Ko7IKs7JilIFNlb3VsIEF1Y3Rpb24gR2FuZ25hbSBCcmFuY2g!5e0!3m2!1sko!2skr!4v1547529016843" width="500" height="350" frameborder="0" style="border:0"></iframe>
							</div>
							<div class="right">
								<div class="title">서울옥션 강남센터</div>
								<!-- 20150608 -->
								<div class="cont">
									<dl>
										<dt>지번주소</dt>
										<dd>서울특별시 강남구 신사동 636-4</dd>
									</dl>
									<dl>
										<dt>도로명주소</dt>
										<dd>서울특별시 강남구 언주로 864</dd>
									</dl>
									<dl class="bus">
										<dt><img src="/images/icon/bus.jpg" style="width:60px; height:auto;"/></dt>
										<dd>										
											<div>
												<div class="tit"><strong>신구중학교 정류장</strong></div>
												<div class="txt"></div>
											</div>
											<div>
												<div class="tit"><strong>압구정파출소 정류장</strong></div>
												<div class="txt"></div>
											</div>
											<div>
												<div class="tit"><strong>현대아파트 정류장(압구정역근처)</strong></div>
												<div class="txt"></div>
											</div>
										</dd>
									</dl>
									<dl class="subway">
										<dt><img src="/images/icon/subway.jpg" style="width:60px; height:auto;"/></dt>
										<dd>
											<div class="metro3"><span>3호선</span> <strong>압구정역</strong></div>	
                                            <div class="txt">2번 출구<br/>
출구에서 뒤로 돌아나와 압구정로 대로에서 직진.<br/>압구정 중학교 근처 큰사거리에서 우회전 <br/>횡단보도 건너세요. 도보 약 10분 (약590m)
</div>
										
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