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
						<h2>강남센터 Exhibition</h2>
					</div>     
					<!-- 전시썸네일 이미지 슬라이드 -->
					<%-- <div class="sub_banner02" id="slides">
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>  
						<!-- 세로이미지 일 때 -->  
						<div><img class="verticalimg_slide" src="/images/img/gnag/img_banner31.jpg" alt="gangnam" /></div>
						<div><img class="verticalimg_slide" src="/images/img/gnag/img_banner32.jpg" alt="gangnam" /></div>
						<!-- 가로이미지  일 때 -->    
						<div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
                        <div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
					</div> --%>
					 
					<!-- 전시썸네일 이미지 단일 -->
                    <!-- <div class="exhibition_img_box">
                     	<img src="/images/img/gnag/img_banner29.jpg" alt="강남전시 배너" style="margin-bottom: 10px;"/>
                    </div> -->
                    <div class="exhibition_img_box">
                     	<img src="/images/img/gnag/img_banner33.jpg" alt="강남전시 배너" />
                    </div>
                          
					<div class="storage_cont title_area">
						<div class="exhibition_firstbox"> 
							<div class="title" style="margin-bottom: 10px;">   
								<p>강남센터 전시기획</p>
								<h3 style="margin-top:10px; font-weight:800;">하태임<br>Yellow, 찬란한 기억
								</h3>
							</div>   
							<p style="line-height:30px; font-size:16px;">
								2022. 05. 27 (금) - 06. 12 (일)<br>
								10am - 7pm<br>
								강남센터 6F
							</p>      
	                        <!--<a href="/currentExhibit?sale_kind=exhibit_only&sale_no=637" class="btn_main_more green exhibiton_listbtn">작품보기</a>   
                            <a href="https://www.seoulauction.com/nas_img/front/homepage/e-book/mariKim/index.html" class="btn_main_more green exhibiton_listbtn" target="_blank" >도록보기</a>     
	                         <a href="https://www.seoulauction.com/service/page?view=auction360VRPop_ex"  class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 15px 45px 17px;font-size: 18px; font-weight:700; color:#FFF; width:120px;" target="new" >전시장 보기</a>  -->
	                    </div>   
                        <div style="border-top: #CCC solid 1px; padding-top: 20px;">                
                        	<div style="line-height:30px; text-align: justify;">    
                            	<p style="margin-bottom: 15px;">
									Yellow, 찬란한 기억<br>
									온화함과 기쁨을 담고 있는 빛 줄기의 색<br><br>

									'노랑'은 '빛'이다. 찬란한 기억과 치유의 에너지, 이 생명의 에너지 가득한 노란색은 내 기억의 첫머리를 장식하고 있다.<br>
									나에게 색이란 음악에서 다양한 높낮이를 가지고 있는 음표들이 하나의 곡을 완성해가듯 색들의 반복과 차이를 통해 펼쳐지는 하나의 노래이며 미지의 세계로 열려있는 '문'이자 '통로'이다.<br>
									- 하태임, 2022
								</p>
                                <p style="margin-bottom: 15px;">
									하태임 작가의 작업에서 캔버스에 칠해진 각각의 색은 고유한 상징과 의미로서 존재합니다. 컬러밴드 하나하나에 인간의 사고와 정서, 느낌과 기분을 감각적으로 구현해 이야기를 담아내는데, 묽게 탄 물감에 붓을 적셔 느린 호흡으로 천천히 칠하고 그것이 온전히 마르기를 기다린 후 또 똑 같은 호흡으로 그 위에 다시 붓질을 하는 수행과도 같은 작업을 통해 하나의 작품이 완성됩니다.

								</p>
                                <p style="margin-bottom: 15px;">
									이번 전시를 위해 작가는 그 동안 작품 속에서 보여주었던 다양한 컬러들 중 노란색 컬러를 택했습니다. ‘Yellow’라는 주조색을 통해 작가가 캔버스 위에 풀어내는 고유의 상징과 의미들을 함께 느껴 볼 수 있는 시간이 되기를 바랍니다.
								</p>
								<%-- <p style="font-weight: bold; margin-bottom: 15px;">
									관람예약: 02-545-0330<br>
									전시운영시간: 10am – 7pm
								</p> --%>
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
									<div class="highlight">전시마케팅팀 <strong>김희진 선임</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>02-2075-4397</span></div>
                                    <div class="email"><strong class="tit">E-mail</strong> <a href="mailto:hjk@seoulauction.com">hjk@seoulauction.com</a></div>
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
								<div class="title">강남센터</div> 
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