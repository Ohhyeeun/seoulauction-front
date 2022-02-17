<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
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
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<!--<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>-->
		<div id="container">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
					<jsp:include page="../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>위치안내</h2>
						<p>도심 속에서 예술품을 만나보실 수 있는 공간, 보다 편하고 빠르게 서울옥션에 오시는 길을 알려드립니다. </p>
					</div>	

					<!-- 20150608 -->
					<div class="tab_wrap type01 location">
						<div class="tab tab01 sele"><a href=""><span class="web_only">HEAD OFFICE, SEOUL</span>서울옥션 <span>본사</span><!--<span class="web_only">(서울옥션 스페이스)</span><--></a></div><!-- 20150615 -->
						<div class="tab_cont sele">
							<div class="cont location_cont">
								<div class="map_area" style="border-bottom: 1px solid #e1e1e1; padding-bottom:30px;">
									<div id="mapCenter" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>서울옥션 본사</h3>
								<div class="both_cont">
									<div class="left">
										<div class="inner">
											<div class="cont">
												<dl>
													<dt>도로명 주소</dt>
													<dd>서울특별시 종로구 평창31길 11</dd>
													<dd>서울특별시 종로구 평창30길 24</dd>
												</dl>
												<dl>
													<dt>지번 주소</dt>
													<dd>서울특별시 종로구 평창동 465-10</dd>
													<dd>서울특별시 종로구 평창동 98번지</dd>
												</dl>
											</div>
											<div>
												<div><strong>Tel</strong>  02 395 0330</div>
												<div><strong>Fax</strong>  02 395 0338</div>
												<div><strong>E-mail</strong> <a href="mailto:webmaster@seoulauction.com">webmaster@seoulauction.com</a></div>
											</div>
										</div>
									</div>
									<div class="right">
										<div class="inner">
											<ul>
												<li>
													<div class="tit"><img src="/images/icon/bus.jpg" /></div>
													<div class="cont">
														<div><strong>롯데삼성아파트</strong></div>
														<div class="txt">1711번, 1020번, 7211번, 110번, 153번<br/><br/><br/></div>
													</div>
												</li>
												<li>
													<div class="tit"><img src="/images/icon/subway.jpg"/></div>
													<div class="cont">
														<div class="metro3"><span>3호선</span> <strong>경복궁역</strong></div>	
														<ol>
															<li>3번 출구</li>
															<li>버스 1020번, 1711번 환승 </li>
															<li><strong>롯데아파트 정류장 하차</strong></li>
														</ol>

														<div class="metro3"><span>3호선</span> <strong>홍제역</strong></div>	
														<ol>
															<li>유진상가 앞</li>
															<li>버스 110번, 153번 환승</li>
															<li><strong>롯데아파트 정류장 하차</strong></li>
														</ol>

														<div class="metro4"><span>4호선</span> <strong>길음역</strong></div>
														<ol>
															<li>3번 출구</li>
															<li>버스 153번, 7211번 환승</li>
															<li><strong>롯데아파트 정류장 하차</strong></li>
														</ol>
													</div>
												</li>
												<li>
													<div class="tit"><img src="/images/icon/car.jpg"/></div>
													<div class="cont">
														<div>
															<div><strong>강남에서 출발</strong></div>
															<ol>
																<li>강변북로</li>
																<li>내부순환도로(홍제동 방면)</li>
																<li>내부순환도로 국민대램프</li>
																<li>국민대(북악터널 방면)</li>
																<li>북악터널 지나서 횡단보도 우회전</li>
															</ol>
														</div>
														<div>
															<div><strong>종로에서 출발</strong></div>
															<ol>
																<li>광화문</li>
																<li>3호선 경복궁역에서 우회전(자하문 터널 방면)</li>
																<li>홍지동 3거리 (상명대앞)</li>
																<li>북악터널 방면</li>
																<li>롯데아파트 횡단보도에서 좌회전</li>
															</ol>
														</div>
													</div>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						
                        
                        <!-- 서울옥션 강남점 추가 -->
						<div class="tab tab02"><a href=""><span class="web_only">GANGNAM BRANCH, SEOUL</span>서울옥션 <span>강남센터</span></a></div>
						<div class="tab_cont">
							<div class="cont location_cont">
								<div class="map_area" style="border-bottom: 1px solid #e1e1e1; padding-bottom:30px;">
									<div id="mapGangnam1" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>서울옥션 강남센터</h3>
								<div class="both_cont">
									<div class="left">
										<div class="inner">
											<div class="cont">
												<dl>
													<dt>도로명 주소</dt>
													<dd>서울특별시 강남구 언주로 864</dd>
												</dl>
												<dl>
													<dt>지번 주소</dt>
													<dd>서울특별시 강남구 신사동 636-4</dd>
												</dl>
                                                <dl>
													<dt>주차장 주소</dt>
													<dd>서울특별시 강남구 신사동 636-6</dd>
												</dl>
												
											</div>
											<div>
												<div><strong>Tel</strong>  02-545-0330</div>
												<div><strong>E-mail</strong> <a href="mailto:webmaster@seoulauction.com">webmaster@seoulauction.com</a></div>
											</div>

										</div>
									</div>
									<div class="right">
										<div class="inner"> 
											<ul>
												<li>
													<div class="tit"><img src="/images/icon/bus.jpg" /></div>
													<div class="cont">
														<div><strong>신구중학교 정류장</strong></div>
														<div class="txt"></div>
                                                        <div><strong>압구정파출소 정류장</strong></div>
														<div class="txt"></div>
                                                        <div><strong>현대아파트 정류장(압구정역근처)</strong></div>
														<div class="txt"></div>
													</div>
												</li>
												<li>
													<div class="tit"><img src="/images/icon/subway.jpg" /></div>
													<div class="cont">
														<div class="metro3"><span>3호선</span> <strong>압구정역</strong></div>	
														<ol>
															<li>2번 출구</li>
															<li>출구에서 뒤로 돌아나와 압구정로 대로에서 직진. 압구정 중학교 근처 큰사거리에서 우회전 뒤, 횡단보도 건너세요. 도보 약 10분 (약590m)</li>
														</ol>
													</div>
												</li>
											</ul> 
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 서울옥션 강남점 추가 -->
                         
                        
                        <div class="tab tab03"><a href=""><span class="web_only">SEOUL AUCTION HONG KONG LIMITED</span>서울옥션<span> 홍콩 리미티드</span></a></div><!-- 20150615 -->	
						<div class="tab_cont">  
							<div class="cont location_cont"> 
								<div class="map_area" style="border-bottom: 1px solid #e1e1e1; padding-bottom:30px;">
									<div id="mapHongkong" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>서울옥션 홍콩 리미티드</h3>
								<div class="both_cont">
									<div class="left">
										<div class="inner">
										    <div class="cont">
												<dl>
													<dt>ADDRESS</dt> 
													<dd>7/F, Nan Fung Tower, 88 Connaught Road Central, Sheung Wan, Hong Kong</dd>
												</dl>
											</div>
											<div>
												<div><strong>Tel</strong> +852-2537-1880</div>
												<div><strong>Fax</strong> +852-2537-2810</div> 
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
						<div class="tab tab04"><a href=""><span class="web_only">BUSAN BRANCH, BUSAN</span>서울옥션 <span>부산</span></a></div>
						<div class="tab_cont">
							<div class="cont location_cont">
								<div class="map_area" style="border-bottom: 1px solid #e1e1e1; padding-bottom:30px;">
									<div id="mapBusan" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>서울옥션 부산</h3>
								<div class="both_cont">
									<div class="left">
										<div class="inner">
											<div class="cont">
												<dl>
													<dt>도로명 주소</dt>
													<dd>부산광역시 해운대구 해운대해변로 292 그랜드 조선 부산 4층</dd> 
												</dl>
												<dl>
													<dt>지번 주소</dt>
													<dd>부산광역시 해운대구 중동 1405-16</dd>  
												</dl>
												
											</div> 
											<div>
												<div><strong>Tel</strong>  051 744 2020</div>
												<div><strong>Fax</strong>  051 744 6255</div>
											</div>

										</div>
									</div>
									<div class="right">
										<div class="inner">
											<ul>
												<li>
													<div class="tit"><img src="/images/icon/bus.jpg" /></div>
													<div class="cont">
														<div><strong>망미2동 정류소</strong></div>
														<div class="txt">54번</div>
                                                        <div><strong>수영성당 정류소</strong></div>
														<div class="txt">115번<br/><br/></div>
													</div>
												</li>
												<li>
													<div class="tit"><img src="/images/icon/subway.jpg" /></div>
													<div class="cont">
														<div><span>2호선</span> <strong>수영역</strong></div>
                                                        <ol>
																<li>5번, 11번 출구 택시 이용 (예상소요시간 8분)</li>
															</ol>
                                                        <div><span>2호선</span> <strong>센텀시티역</strong></div>
                                                        <ol>
																<li>10번, 12번 출구 택시 이용</li>
															</ol>
													</div>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 서울옥션 부산점 추가 -->
						
						<!--<div class="tab tab05"><a href=""><span class="web_only">SeoulAuction Blue, SEOUL</span>서울옥션 <span>블루</span></a></div>
						<div class="tab_cont">
							<div class="cont location_cont">
								<div class="map_area" style="border-bottom: 1px solid #e1e1e1; padding-bottom:30px;">
									<div id="mapGangnam" style="background:white; height:500px; text-align:center;"></div>
								</div>
								<h3>서울옥션 블루</h3>
								<div class="both_cont">
									<div class="left">
										<div class="inner">
											<div class="cont">
												<dl>
													<dt>도로명주소</dt>
													<dd>서울시 강남구 도산대로45길 6 호림아트센터 1층</dd>
												</dl>
												<dl>
													<dt>지번주소</dt>
													<dd>서울특별시 강남구 신사동 651-16 </dd>
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
													<div class="tit"><img src="/images/icon/bus.jpg" /></div>
													<div class="cont">
														<div><strong>씨네시티, 호림아트센터앞, 영동소방파출소, 제일은행</strong></div>
														<div class="txt">145번, 440번, 3011번, 4212번</div>
														<div><strong>도산공원사거리</strong></div>
														<div class="txt">145번, 3011번, 4212번</div>
														<div><strong>도산공원</strong></div>
														<div class="txt">141번, 3011번</div>
													</div>
												</li>
												<li>
													<div class="tit"><img src="/images/icon/subway.jpg" /></div>
													<div class="cont">
														<div class="metroy"><span>분당선</span> <strong>압구정로데오역</strong></div>
														<div class="metroy"><span>분당선</span> <strong>강남구청역 </strong><br/><br/><br/></div>
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

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/img/img_menu04.jpg" alt="" class="img_master">
						</li>
					</ul>
				</div>
			</div>-->
		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />