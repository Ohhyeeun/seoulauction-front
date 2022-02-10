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
					<jsp:include page="../include/gangSubMenu.jsp" flush="false"/>
				</div> 
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->
  
			<div class="contents_wrap">    
				<div class="contents">
					<div class="tit_h2">    
						<h2>서울옥션 강남센터 Exhibition</h2>      
					</div>     
					<!-- 전시썸네일 이미지 슬라이드 -->       
					<div class="sub_banner02" id="slides">     
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>  
						<!-- 세로이미지 일 때 -->  
						<div><img class="verticalimg_slide" src="/images/img/gnag/img_banner31.jpg" alt="gangnam" /></div> 
						<div><img class="verticalimg_slide" src="/images/img/gnag/img_banner32.jpg" alt="gangnam" /></div>  
						<!-- 가로이미지  일 때 -->    
						<!-- <div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
                        <div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div> -->   
					</div>  
					 
					<!-- 전시썸네일 이미지 단일 -->       
                    <!-- <div class="exhibition_img_box">     
                     	<img src="/images/img/gnag/img_banner29.jpg" alt="강남전시 배너" style="margin-bottom: 10px;"/>               
                    </div>   
                    <div class="exhibition_img_box">     
                     	<img src="/images/img/gnag/img_banner30.jpg" alt="강남전시 배너" />                           
                    </div> -->  
                          
					<div class="storage_cont title_area">
						<div class="exhibition_firstbox"> 
							<div class="title" style="margin-bottom: 10px;">   
								<p>서울옥션 강남센터 전시기획</p>   
								<h3 style="margin-top:10px; font-weight:800;">승효상, 최덕주<br> 결구(結構)와 수직(手織)의 풍경</h3>     
							</div>   
							<p style="line-height:30px; font-size:16px;">    
	                            2021.6.29(火) - 7.18(日)<br>
                                10am - 7pm<br>  
                                서울옥션 강남센터 6층    
							</p>      
	                        <!--<a href="/currentExhibit?sale_kind=exhibit_only&sale_no=637" class="btn_main_more green exhibiton_listbtn">작품보기</a>   
                            <a href="/nas_img/front/homepage/e-book/mariKim/index.html" class="btn_main_more green exhibiton_listbtn" target="_blank" >도록보기</a>     
	                         <a href="/service/page?view=auction360VRPop_ex"  class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 15px 45px 17px;font-size: 18px; font-weight:700; color:#FFF; width:120px;" target="new" >전시장 보기</a>  -->
	                    </div>   
                        <div style="border-top: #CCC solid 1px; padding-top: 20px;">                
                        	<div style="line-height:30px; text-align: justify;">    
                            	<p style="margin-bottom: 15px;">                                   
                                	서울옥션은 오는 6월 29일(화)부터 7월 18일(일)까지 특별전시 승효상과 최덕주 2인전 &#60;결구(結構)와 수직(手織)의 풍경&#62;을 선보입니다.<br> 
                                약 45점의 가구와 조각보, 근현대 회화로 구성된 이번 전시는 다양한 예술품을 한자리에서 감상할 수 있는 기회로 보다 다양한 예술의 본질을 공유하고자 합니다.
                                </p>
                                <p style="margin-bottom: 15px;">                                  
                                	승효상의 가구와 최덕주의 조각보는 여러모로 닮은 점이 있습니다. 결과로서 이뤄지는 형상에 대한 신념이 있어야 하며, 그 형상을 이루기 위한 면밀한 계획과 계산이 수반되어야 합니다. 마지막으로 막대한 노동이 뒤따르는 것이 그 둘의 공통점으로 가구와 조각보가 이 과정적 원칙에 충실하다면 그 자체의 진실성으로 다른 요소가 개입할 이유가 없습니다. 다시 말해, 결구에 충실하고 수직에 집중되었다면 그대로 감동적이라 할 수 있습니다.
                                </p>
                                <p style="margin-bottom: 15px;">                                  
                                	이번 전시에 등장하는 모든 가구들과 조각보들은 수사와 장식을 멀리합니다. 특히 가구는 겉으로 보기에는 단순하고 평온해 보이지만, 결구를 이루는 부재들 사이의 투쟁이 있으며, 이것은 가구들이 때로는 긴장을 부르는 이유이기도 합니다. 그래서 승효상 작가는 스스로 추방된 이들이 거주하는 수도원의 가구라는 부제까지 달았습니다. 조각보는 염색부터 직조까지 문자 그대로의 수고로 이루어진 것으로 한 땀 한 땀이라는 글귀가 갖는 진지함과 색조의 얇은 천 속에는 보이지 않는 치열과 집요가 담겨있습니다.
                                </p>
                                <p>                                     
                                	가구와 조각보를 함께 전시하는 일은 흔하지 않습니다. 어떻게 보면 결구와 수직은 최첨단기술도 닿을 수 없는 세계의 삶이라는 같은 결을 가지며, 이 둘의 모임은 하나보다 더욱 아름다운 풍경을 이룰 수도 있을 것이라 여겨집니다. 
결구와 수직의 풍경이 관람객들을 위로하며 쉬게 해주는 전시가 되기를 바랍니다.    
								</p>   
								
								<p style="font-weight: bold; margin: 20px 0;">       
									※ 사회적 거리두기 4단계 지침 시행에 따라 사전예약하지 않으신 분은 전시 관람이 어려우니, 하기 전화번호로 반드시 예약 후 방문해주시기 바랍니다.<br>
								</p>  
								<p style="font-weight: bold; margin-bottom: 15px;">   
									관람예약: 02-545-0330<br>  
									전시운영시간: 10am – 7pm 
								</p>
							</div> 
                        </div> 
                              
                        <!-- <p style="font-size: 12px; margin-top: 20px;"> 
                        	<strong>참여작가</strong><br/> 
							음하영, 안소현, 우국원, 김재용, 장형선, 김보민, 지니리, 허수연, 이정인, 노보   
                        </p> --> 
                        
						<div class="box_gray type01">     
							<div class="contact"> 
								<div class="title">문의 Contact</div>  
								<div class="info"> 
									<div class="highlight">서울옥션 전시마케팅팀 <strong>윤가람 선임</strong></div>         
									<div class="tel"><strong class="tit">Tel</strong> <span>02-2075-4422</span></div> 
                                    <div class="email"><strong class="tit">E-mail</strong> <a href="mailto:kyoon@seoulauction.com">kyoon@seoulauction.com</a></div>        
								</div>      
							</div> 
                           <!-- <div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
							</div>  --> 
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
										<dd>서울특별시 강남구 신사동 636-4<span style="display: block; line-height: 1.5;">(주차장 이용 시, 신사동 636-6)<span></dd>   
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
				height : 400,    
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