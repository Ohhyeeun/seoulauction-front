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
						<p style="line-height:30px; font-size:16px;">서울옥션은 2019년 1월 서울 강남구 신사동에 서울옥션 강남센터 문을 열었습니다. 평창동 서울옥션 사옥과 인천국제공항 등을 설계한 프랑스 건축가 장 미셸 빌모뜨(Jean-Michel Wilmotte)가 디자인과 설계를 맡은 건물로, 지상 8층, 지하 5층 규모로 경매장, 전시장, 아카데미홀 등으로 구성되었습니다. 서울옥션 강남센터는 강남을 대표하는 랜드마크로서 대중들이 일상 속에서 미술을 향유하고, 미술품 경매를 보다 가깝게 느끼고 경험하는 문화공간으로 다가가고자 합니다.</p>
						
						<!--<div class="box_gray type01">
							<div class="contact">
								<div class="title">문의 Contact</div>
								<div class="info">
									<div class="highlight">서울옥션 보관고 <strong>김경순 팀장</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>010-4703-0481</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:kks@seoulauction.com">kks@seoulauction.com</a></div>
								</div>
							</div>
							<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
							</div>
						</div>-->
					</div>

					<div><img src="/images/img/img_storage01_banner02.jpg" alt="인사 아트 스토리지" style="width:100%; height:auto;"/></div>

					
					
					<div class="storage_cont">	
						<div class="tit_h3 through">
							<h3>Location</h3>
						</div>
						
						<div class="map_area">
							<div class="left">
								<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1582.086245384522!2d127.03382800000001!3d37.527431!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x20893aab0caffe0c!2zKOyjvCnshJzsmrjsmKXshZgg6rCV64Ko7IKs7JilIFNlb3VsIEF1Y3Rpb24gR2FuZ25hbSBCcmFuY2g!5e0!3m2!1sko!2skr!4v1547512793615" width="500" height="350" frameborder="0" style="border:0"></iframe>
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
                                    <dl>
										<dt>문의</dt>
										<dd>02-395-0330<br />
                        02-545-0330</dd>
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