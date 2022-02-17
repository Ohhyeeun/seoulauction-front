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
					<jsp:include page="../include/EventSubMenu.jsp" flush="false"/>  
				</div> 
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->
  
			<div class="contents_wrap">    
				<div class="contents"> 
					<div class="tit_h2" style="display: none;">    
						<h2><spring:message code="label.seoulauction.introgang0" /></h2>   
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
                     <div class="exhibition_img_box">      
                     	<img src="/images/img/gnag/img_banner26.jpg" alt="강남전시 배너" width="100%" height="auto" />         
                        <!-- 이미지 추가 일시 
                        <img src="/images/img/main/gang/sa12.jpg" alt="saplus" width="100%" height="auto" style="margin-top: 10px;" /> -->
                     </div>   
    
                    <br/><br/><br/><br/>      
					<div class="storage_cont title_area">
					 	<div class="title" style="margin-bottom: 10px;">   
							<!-- <p>서울옥션 강남센터 전시기획</p> -->     
							<h3 style="margin-top:10px;">〈THE KING OF WHISKY - 로얄살루트 컨템포러리 아트 디지털 페스티벌〉</h3> 
						</div>   
						<p style="line-height:30px; font-size:16px;">  
							디지털 전시<br>
							: 2021.1.4.(月) - 3.14(日) 서울옥션 홈페이지, 서울옥션 인스타그램<br><br> 
							오프라인 전시<br>
							: 서울옥션 강남센터 1층<br>  
                            1차) 2021.2.16(火) - 2.23(火)<br> 
                            2차) 2021.3.15(月) - 3.18(木)
						</p>  
                        <br/>      
                        <!-- <a href="/currentExhibit?sale_kind=exhibit_only&sale_no=617" class="btn_main_more green" style="margin-top:15px; margin-right: 10px; margin-bottom:15px; padding: 10px 45px 15px;font-size: 18px; font-weight:700; color:#FFF;" >작품 보기</a>
						<a href="https://www.royalsaluteart.kr" class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 10px 45px 15px;font-size: 18px; font-weight:700; color:#FFF; width:auto;" >EVENT</a> --> 
                        <br/><br/><br/>      
						<p style="border-top: #CCC solid 1px; line-height:30px; font-size:16px;"><br/><br/> 
                        	2021년 1월, 유일하게 21년부터 시작하는 궁극의 럭셔리 위스키 로얄살루트의 예술적인 브랜드 스토리와 컨템포러리 아트를 함께 즐길 수 있는 획기적인 아트 전시회 ‘로얄살루트 컨템포러리 아트 디지털 페스티벌’이 펼쳐집니다. <br><br>
                        	로얄살루트는 2019년, 더욱 컨템포러리해진 새로운 럭셔리의 세계를 제시하며 브랜드 전면 리뉴얼을 진행했고, 이를 기념해 첫 번째 아트 전시회 ‘로얄살루트 컨템포러리 아트 전시회’를 선보였습니다. 로얄살루트의 새로운 브랜드 세계를 창조한 글로벌 컨템포러리 아티스트 ‘크리스트자나 윌리엄스’와 함께 했던 ‘로얄살루트 컨템포러리 아트 전시회’는 시각∙후각∙미각 등 오감을 통해 미술 작품과 예술적 위스키를 함께 경험할 수 있었던 전시로, 로얄살루트를 현대적 예술로 승화시켰다는 평가를 받으며 위스키 애호가와 아트 콜렉터들에게 큰 호응을 얻었습니다.<br><br>
                        	‘로얄살루트 컨템포러리 아트 디지털 페스티벌’은 컨템포러리 아트를 통해 소비자와 소통해 온 글로벌 브랜드 로얄살루트가 한국의 컨템포러리 아티스트 5인, 그리고 서울옥션과의 협업을 통해 한국의 컨템포러리 아트에 힘을 실어주고, 소비자들에게도 즐거움을 선사하는 장이 될 것입니다. ‘도도새’라는 매개체를 통해 꿈과 자유를 이야기하는〈현대미술작가 김선우〉, 특유의 패셔너블한 감성과 디지털 터치가 돋보이는〈크로스 미디어 아티스트 아드리안 서〉 , 팝 아트 기반의 비비드한 컬러와 파격적인 드로잉으로 대표되는〈비주얼 아티스트 275c〉, 보통의 사람과 그들이 살아가는 일상을 따뜻하고 화려한 컬러와 빛으로 그려내는 〈일러스트레이터 콰야〉, 그리고 시대의 패션과 동시대의 남성들의 라이프스타일을 표현하는〈화가 겸 일러스트레이터 성낙진〉 등 국내 컨템포러리 아트 분야에서 큰 관심과 기대를 얻고 있는 5인의 아티스트가 로얄살루트와 만나 파격적인 아트 페스티벌을 선보입니다. <br><br>
                        	이번 아트 페스티벌은 위스키의 왕으로 불리는 로얄살루트의 상징성에 걸맞게 ‘THE KING OF WHISKY’라는 주제로 펼쳐집니다. 5명의 아티스트가 위스키의 왕 ‘로얄살루트’의 럭셔리 라인업이 가진 풍부하고 차별화된 스토리를 한층 더 현대적인 예술작품으로 창조하고, 이 작품들을 디지털 채널을 통해 새로운 방식으로 즐길 수 있는 파격적인 아트 페스티벌입니다. 21년 라인업부터 52년 하이엔드 컬렉션까지 로얄살루트의 전 제품을 5명의 아티스트가 현대적으로 재해석한 작품들은 2021년 1월 4일부터 서울옥션 홈페이지와 공식 인스타그램(@seoulauction), 그리고 로얄살루트 아트 전시 사이트(www.royalsaluteart.kr)에서 만나실 수 있습니다. <br><br>
                        	세계적인 글로벌 위스키 브랜드 로얄살루트와 국내 컨템포러리 아티스트의 만남 그 자체로 큰 화제와 기대감을 불러일으키고 있는 ‘로얄살루트 컨템포러리 아트 디지털 페스티벌’! 로얄살루트와 함께 하면 ‘왕’과 같은 주인공이 될 수 있다는 즐거움과 위트를 선사해 줄 ‘로얄살루트 컨템포러리 아트 디지털 페스티벌’은 디지털에서 예술작품을 감상할 수 있는 유니크한 경험은 물론 나만의 차별화된 럭셔리 라이프를 향유하는 트렌드 세터와 MZ세대, 그리고 아트 콜렉터들에게 창의적이고 색다른 영감을 선사해 줄 것입니다. 
						</p>    
                        <br/><br/><br/>  
 
						<div class="box_gray type01">    
							<div class="contact">   
								<div class="title">문의 Contact</div>
								<div class="info">
									<div class="highlight">서울옥션 전시마케팅팀 <strong>김현희 팀장</strong></div> 
									<div class="tel"><strong class="tit">Tel</strong> <span>02-2075-4435</span></div> 
                                    <div class="email"><strong class="tit">E-mail</strong> <a href="mailto:hyunhee@seoulauction.com">hyunhee@seoulauction.com</a></div> 
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