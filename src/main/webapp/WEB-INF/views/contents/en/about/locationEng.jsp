<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>
<script>
	$(document).ready(function() {
		var winWidth = $(window).innerWidth();
		var nFrameWidth = 0;
		if(winWidth > 1024) {
			nFrameWidth = 960;
		}
		else {
			// 모바일인 경우 (?)
			nFrameWidth = winWidth - 40;
		}
		var mapCenterIframe = "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12642.426185048713!2d126.97563500000001!3d37.61141800000001!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xcdaccdc4d2e8f1f5!2zKOyjvCnshJzsmrjsmKXshZg!5e0!3m2!1sko!2skr!4v1637227447238!5m2!1sko!2skr&key=AIzaSyAsNYEu50L2cUvOpslYGvGik1jKbLliqWI&amp;language=KO' width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>";     
		$("#mapCenter").html(mapCenterIframe);    
	});
</script>
<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">

		<div id="container">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
					<jsp:include page="../../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>Location</h2>
						
					</div>

					<!-- 20150608 -->
					<div class="tab_wrap type01 location">
						<div class="tab tab01 sele"><a href="">HEAD OFFICE, SEOUL</a></div>
						<div class="tab_cont sele">
							<div class="cont location_cont">
								<div class="map_area" style="border-bottom: 1px solid #e1e1e1; padding-bottom:30px;">
									<div id="mapCenter" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>HEAD OFFICE</h3>
								<div class="both_cont">
									<div class="left">
										<div class="inner">
											<div class="cont">
												<dl>
													<dt style="padding-right:10px;">Land-lot number</dt><br>
													<dd>465-10, Pyeongchang-dong, Jongno-gu, Seoul, Korea</dd>
													<dd>98, Pyeongchang-dong, Jongno-gu, Seoul, Korea</dd>
												</dl>

												<dl>
													<dt>Road name</dt><br>
													<dd>11, Pyeongchang 31-gil, Jongno-gu, Seoul, Korea</dd>
													<dd>24, Pyeongchang 30-gil, Jongno-gu, Seoul, Korea</dd>
												</dl>
											</div>
											<div> 
												<div><strong>Tel</strong> +82 (0)2 2075 4422 (English)<br> &nbsp; &nbsp; &nbsp;+82 (0)2 2075 4391 (中國語)</div>
												<div><strong>Fax</strong>  +82 (0)2 395 0338</div>
												<div><strong>E-mail</strong> <a href="mailto:info@seoulauction.com">info@seoulauction.com</a></div>
											</div>
										</div>
									</div>
									<div class="right">
										<div class="inner" style="height:253px;">
											<ul>
												<li>
													<div class="tit">Bus</div>
													<div class="cont">
														<div><strong>Lotte Samsung Apartment </strong></div>
														<div class="txt">1711, 1020, 7211, 110, 153</div>
													</div>
												</li>
												<li>
													<div class="tit">Subway</div>
													<div class="cont">
														<div class="metro3"><span>Line 3</span> <strong>Gyeongbokgung, Hongje</strong></div>
														<div class="metro4"><span>Line 4</span> <strong>Gireum</strong></div>
													</div>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						
                        
                        <div class="tab tab02"><a href="">GANGNAM CENTER, SEOUL</a></div>
						<div class="tab_cont">
							<div class="cont location_cont">
								<div class="map_area" style="border-bottom: 1px solid #e1e1e1; padding-bottom:30px;">
									<div id="mapGangnam1" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>Seoul Auction GANGNAM CENTER</h3>
								<div class="both_cont">
									<div class="left">
										<div class="inner">
											<div class="cont">												
												<dl>
													<dt>Road name</dt>
													<dd>864, Eonju-ro, Gangnam-gu, Seoul, Republic of Korea</dd>
												</dl>
											</div>
											<div>
												<div><strong>Tel</strong>+82 (0)2-545-0330 +82<br> &nbsp; &nbsp; &nbsp;(0)2 2075 4422 (English)<br> &nbsp; &nbsp; &nbsp;+82 (0)2 2075 4385 (中國語)</div>
												<div><strong>E-mail</strong> <a href="mailto:info@seoulauction.com">info@seoulauction.com</a></div>
											</div>

										</div>
									</div>
									<div class="right">
										<div class="inner">
											<ul>
												<li>
													<div class="tit">Bus</div>
													<div class="cont">
														<div><strong>Shingu Middle school</strong></div>
														<div class="txt"></div>
                                                        <div><strong>Hyundai APT</strong></div>
														<div class="txt"></div>
													</div>
												</li>
												<li>
													<div class="tit">Subway</div>
													<div class="cont">
														<div class="metro3"><span>Line 3</span> <strong>Apgujeong Station</strong></div>
													</div>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
                        
                        
                        <div class="tab tab03"><a href="">HONG KONG LIMITED</a></div>
						<div class="tab_cont">  
							<div class="cont location_cont"> 
								<div class="map_area"> 
									<div id="mapHongkong" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>SEOUL AUCTION HONG KONG LIMITED</h3>
								<div class="both_cont">
									<div class="left">
										<div class="inner">
											<p>7/F, Nan Fung Tower, 88 Connaught Road Central, Sheung Wan, Hong Kong</p> 
											<div>
												<div><strong>Tel</strong> +852 2537 1880</div>
												<div><strong>Fax</strong> +852 2537 2810</div>
												<div><strong>E-mail</strong> <a href="mailto:info@seoulauction.com.hk">info@seoulauction.com.hk</a></div> 
											</div>
										</div>
									</div>
									<div class="right">
										<div class="inner"></div>
									</div>
								</div>
							</div>
						</div>
                        
                        
						<!-- 서울옥션 부산점 추가 -->
						
						<div class="tab tab04"><a href="">BUSAN BRANCH, BUSAN</a></div>
						<div class="tab_cont">
							<div class="cont location_cont">
								<div class="map_area" style="border-bottom: 1px solid #e1e1e1; padding-bottom:30px;">
									<div id="mapBusan" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>Seoul Auction BUSAN BRANCH</h3>
								<div class="both_cont">
									<div class="left">  
										<div class="inner">
											<div class="cont">												
												<dl>
													<dt>Road name</dt>  
													<dd>292, Haeundaehaebyeon-ro, Haeundae-gu, Busan, Republic of Korea</dd>
												</dl>
											</div>
											<div>
												<div><strong>Tel</strong>  +82 (0)51 744 2020</div>
												<div><strong>Fax</strong>  +82 (0)51 744 6255</div>
											</div>

										</div>
									</div>
									<div class="right">
										<div class="inner">
											<!--<ul>
												<li>
													<div class="tit">Bus</div>
													<div class="cont">
														<div><strong>Haeundae Beach Entrance</strong></div>
														<div class="txt">1003(express city bus), 139</div>
													</div>
												</li>
												<li>
													<div class="tit">Subway</div>
													<div class="cont">
														<div class="metro2"><span>Line 2</span> <strong>Haeundae</strong></div>
													</div>
												</li>
											</ul>-->
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 서울옥션 부산점 추가 -->
						
						<!--<div class="tab tab05"><a href="">SeoulAuction Blue, SEOUL</a></div>
						<div class="tab_cont">
							<div class="cont location_cont">
								<div class="map_area" style="border-bottom: 1px solid #e1e1e1; padding-bottom:30px;">
									<div id="mapGangnam" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>SeoulAuction Blue</h3>
								<div class="both_cont">
									<div class="left">
										<div class="inner">
											<div class="cont">
												<dl>
													<dt>Land-lot number</dt>
													<dd>651-16, Sinsa-dong, Gangnam-gu, Seoul, Korea</dd>
												</dl>

												<dl>
													<dt>Road name</dt>
													<dd>6, Dosan-daero 45-gil, Gangnam-gu, Seoul, Korea</dd>
												</dl>
											</div>
											<div>
												<div><strong>Tel</strong>  +82 (0)2 514 2505</div>
												<div><strong>Fax</strong>  +82 (0)2 514 2515</div>
											</div>
										</div>
									</div>
									<div class="right">
										<div class="inner">
											<ul>
												<li>
													<div class="tit">Bus</div>
													<div class="cont">
														<div><strong>Cine City, Horim Art Center, Yeongdong Fire Branch, Jeil Bank</strong></div>
														<div class="txt">145, 440, 3011, 4212</div>
														<div><strong>Dosan Park Intersection</strong></div>
														<div class="txt">145, 3011, 4212</div>
														<div><strong>Dosan park</strong></div>
														<div class="txt">141, 3011</div>
													</div>
												</li>
												<li>
													<div class="tit">Subway</div>
													<div class="cont">
														<div class="metroy"><span>Bundang Line</span> <strong>Apgujeongrodeo, Gangnam-gu Office</strong></div>
													</div>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>-->
						
						
					</div>
					<!-- //20150608 -->
				</div>
			</div>


		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />