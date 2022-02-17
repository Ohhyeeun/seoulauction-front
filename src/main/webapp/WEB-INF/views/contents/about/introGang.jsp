<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<link href="<c:url value="/css/old/onepcssgrid.css" />" rel="stylesheet">
<link href="/css/jquery.bxslider.min.css" rel="stylesheet">           
<link href="/css/main_bxslider.css" rel="stylesheet"> 

<script type="text/javascript" src="/js/jquery.bxslider.js"></script> 

<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2" style="padding-top:30px;">
						<h2>서울옥션 강남센터</h2>
					</div>
					

					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="title">
							<h3>일상 속 예술을 지향하는 <span class="txt_green">서울옥션 강남센터</span></h3>
						</div>
						<p style="line-height:30px; font-size:16px;">서울옥션은 2019년 1월 서울 강남구 신사동에 서울옥션 강남센터 문을 열었습니다. 평창동 서울옥션 사옥과 인천국제공항 등을 설계한 프랑스 건축가 장 미셸 빌모트(Jean-Michel Wilmotte)가 디자인과 설계를 맡은 건물로, 지상 8층, 지하 5층 규모로 경매장, 전시장, 아카데미홀 등으로 구성되었습니다. 서울옥션 강남센터는 강남을 대표하는 랜드마크로서 대중들이 일상 속에서 미술을 향유하고, 미술품 경매를 보다 가깝게 느끼고 경험하는 문화공간으로 다가가고자 합니다.</p>

					</div>
                    
                    <div class="storage_cont">	

                        <div class="onepcssgrid-1200">
                            <div class="col6" style="padding-top:20px; overflow:hidden">
                                <table style="line-height:50px; font-size:14px;">
                                    <p style="padding-bottom:30px; font-size:24px; font-weight:700;">층별 안내</p>
                                    <tbody style="border-top:#000 solid 1px; ">
                                        <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">8F</td>
                                            <td>미팅룸</td>
                                        </tr>
                                        <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">6-7F</td>
                                            <td>경매장</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">5F</td>
                                            <td>전시장</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">4F </td>
                                            <td>사무실</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">3F</td>
                                            <td>아카데미홀</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">GF</td>
                                            <td>로비</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">B1F</td>
                                            <td>-</td>
                                         </tr> 
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">B2-3F</td>
                                            <td>주차장</td>
                                         </tr>
                                         <tr style="border-bottom:#e4e4e4 solid 1px; ">
                                            <td style="padding-left:15px; width: 30%">B4-5F</td>
                                            <td>전시장 및 이벤트홀</td>
                                         </tr>
                                    </tbody>
                                </table>
                                <div class="btns mt30">
                               	 <span class="btn_style01"><a href="/service/page?view=rentExhibitionCenter" target="_blank" title="새창">서울옥션 전시장대여</a></span>&nbsp;&nbsp;
                                 <span class="btn_style01"><a href="/nas_img/front/homepage/ganam_brochure.pdf" target="_blank" title="새창">강남센터 대관 브로셔</a></span>
                                </div>
                            </div>  
                            <div class="col6 last" style="padding-top:70px; padding-bottom: 20px;" align="center"><img src="/images/img/img_intro_gang00.png" alt="Seoulauction" style="width:80%;" /></div>
                            <div class="onerow"></div>
                        </div>

					</div>
                    
                    <div class="web_only">
                    	<div class="sub_banner02 mt20" id="slides"> 
							<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
							<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>  
							<div><img src="/images/img/img_intro_gang01.jpg" alt="Seoulauction" /></div>
							<div><img src="/images/img/img_intro_gang02.jpg" alt="Seoulauction" /></div>
	                        <div><img src="/images/img/img_intro_gang03.jpg" alt="Seoulauction" /></div>
							<div><img src="/images/img/img_intro_gang04.jpg" alt="Seoulauction" /></div>
							<div><img src="/images/img/img_intro_gang05.jpg" alt="Seoulauction" /></div>
						</div>
                    </div>
                    <div class="m_only">
		            	<div class="sub_slide">
							<div class="bxslider">  
			            		<div class="sub_banner02">   
					                <div><img src="/images/img/img_intro_gang01.jpg" alt="Seoulauction" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/img_intro_gang02.jpg" alt="Seoulauction" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/img_intro_gang03.jpg" alt="Seoulauction" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/img_intro_gang04.jpg" alt="Seoulauction" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/img_intro_gang05.jpg" alt="Seoulauction" /></div>
					            </div>
			            	</div> 
		                </div>
		            </div><!--//m_only -->  
                    
                    
					
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
										<dd>서울특별시 강남구 신사동 636-4<span style="display: block; line-height: 1.5;">(주차장 이용 시, 신사동 636-6)<span></dd>   
									</dl>
									<dl>
										<dt>도로명주소</dt>
										<dd>서울특별시 강남구 언주로 864</dd>
									</dl>
                                    <dl>
										<dt>Tel</dt>
										<dd>02-545-0330</dd> 
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