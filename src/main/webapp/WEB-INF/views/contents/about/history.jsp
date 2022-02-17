<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
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
						<h2>연혁</h2>
						<p>한국 최초의 경매회사로 시작하여, 고객과 함께 성장해온 서울옥션의 역사를 소개합니다.</p>
					</div>
					<div class="history_step">
						<ol> 
							<li class="year02 sele"><a href="#history02"><span style="margin: 0 auto;">이우환 ‘동풍’ 국내생존작가 첫 30억 돌파</span></a></li> 
							<li class="year03"><a href="#history03"><span style="margin: 0 auto;">강남센터 오픈</span></a></li>   
							<li class="year04"><a href="#history04"><span style="margin: 0 auto;">홍콩 프라이빗 세일 전시장 SA+ 개관</span></a></li>   
							<li class="year05"><a href="#history05"><span style="margin: 0 auto;">코스닥(KOSDAQ) 상장</span></a></li>   
                            <li class="year01"><a href="#history01"><span style="margin: 0 auto;">서울경매 설립</span></a></li>  
						</ol> 
					</div>
					<div class="history_cont">
						<div class="year now">Now</div>
						<ol>
							<!----------------------------------2021---------------------------------->
							<li id="history02">    
								<dl>
									<dt>2021</dt> 
									<dd>
										<ul> 
											<li><div>이우환 ‘동풍’ 낙찰가 31억원(162회 경매) 국내생존작가 첫 30억원 돌파 </div>  
                                                <div class="img"><img src="/images/img/img_history19.jpg" alt="이우환" height="200px" width="auto"/></div>  
                                            </li>
                                            <li><div>겸재 실경 작품 최고가 기록(161회 경매) 낙찰가 4억 4,000만원</div>   
                                                <div class="img"><img src="/images/img/img_history20.jpg" alt="겸재 실경" width="auto" height="200px"/></div> 
                                            </li>
                                            <li><div>김창열 작가 레코드 기록(159회 경매) 낙찰가 10억 4천만원 </div>   
                                                <div class="img"><img src="/images/img/img_history21.jpg" alt="김창열" height="auto" width="200px"/></div>    
                                            </li>
										</ul> 
									</dd>
								</dl>
							</li>
							<!----------------------------------2020---------------------------------->					
							<li class="odd"> 
								<dl>
									<dt>2020</dt>  
									<dd>
										<ul>
                                            <li>
                                            	<div>제로베이스 X 전남, 경기 문화재단 경매 진행</div>  
                                                <div class="img"><img src="/images/img/img_history18.jpg" alt="제로베이스 X 전남, 경기 문화재단 경매 진행" width="200px" height="auto"></div> 
                                            </li> 
										</ul>
									</dd>
								</dl> 
							</li>
                            <!----------------------------------2019---------------------------------->
                            <li id="history03"> 
								<dl>
									<dt>2019</dt>
									<dd>
										<ul>  
											<li><div>서울옥션 설립 20주년, 강남센터 오픈</div> 
                                                <div class="img"><img src="/images/img/img_history13.jpg" alt="강남사옥" style="  height:200px;
  width:auto;" /></div>
                                            </li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2019---------------------------------->
                            <!----------------------------------2018---------------------------------->					
							<li class="odd"> 
								<dl>
									<dt>2018</dt> 
									<dd>
										<ul>
                                            <li><div>김환기 “3-II-72 #220” 한국 미술품 최고 낙찰가 기록 경신</div> 
                                                <div class="img"><img src="/images/img/img_history17.jpg" alt="김환기" style="  height:200px;
  width:auto;" /></div>
                                            </li> 
											
											<li id="history04"><div>홍콩 프라이빗 세일 전시장 SA+ 개관</div>       
                                                <div class="img"><img src="/images/img/img_history14.jpg" alt="SA+" style="  height:200px;
  width:auto;" /></div>
                                            </li>
											<li> 
												<div>이중섭 "소" 작가 레코드 경신</div>
                                                <div class="img"><img src="/images/img/img_history15.jpg" alt="이중섭 소" style="  height:150px;
  width:auto;" /></div>
                                            </li>
                                            <li>
												<div>김환기 "항아리와 시" 구상작품 중 최고가 기록</div>
                                                <div class="img"><img src="/images/img/img_history16.jpg" alt="김환기" style="  height:150px;
  width:auto;" /></div>
                                            </li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2018---------------------------------->
							<!----------------------------------2017---------------------------------->
                            <li>
								<dl>
									<dt>2017</dt>
									<dd>
										<ul>
											<li><div>장욱진 &lt;독&gt; 작가 레코드 경신</div></li>
											<li>
												<div>이우환 &lt;With Winds&gt; 시리즈 최고가 낙찰</div>
												<div class="img"><img src="/images/img/img_history08.jpg" alt="이우환 With Winds" style="  height:150px;
  width:auto;" /></div>
											</li>
                                            <li><div>첫 부산경매 실시, 낙찰률 93%</div></li>
                                            <li>
                                            	<div>백남준 &lt;Stag&gt; 작가 레코드 경신</div>
                                            	<div class="img"><img src="/images/img/img_history09.jpg" alt="백남준 Stag" style="  height:150px;
  width:auto;" /></div>
                                            </li>                                      
                                            <li><div>22회 홍콩경매, 김흥수 특별전시 진행 특별전시 진행</div></li>
                                            <li><div>첫 대구 경매 실시, 낙찰률 84% </div></li>
                                            <li>
                                            	<div>이응노 &lt;People&gt; 작가 레코드 경신</div>
                                            	<div class="img"><img src="/images/img/img_history10.jpg" alt="이응노" style="  height:150px;
  width:auto;" /></div>
                                            </li>
                                            <li>
                                            	<div>김환기 &lt;Morning Star&gt; 반추상 작품 중 최고가 기록 </div>
                                            	<div class="img"><img src="/images/img/img_history11.jpg" alt="김환기" style="  height:150px;
  width:auto;" /></div>
                                            </li>
                                            <li>
                                            	<div>야요이 쿠사마 &lt;A-Pumpkin [BAGN8]&gt; 호박 시리즈 중 최대 사이즈, 월드 최고가 기록</div>
                                            	<div class="img"><img src="/images/img/img_history12.jpg" alt="쿠사마" style="  height:200px;
  width:auto;" /></div>
                                            </li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2017---------------------------------->
							
							<!----------------------------------2016---------------------------------->					
							<li class="odd">
								<dl>
									<dt>2016</dt> 
									<dd>
										<ul>
											<li><div>올레 tv 889번 <서울옥션 TV> 채널 런칭</div></li>
											<!--<li><div>서울옥션 FTSE 신규 편입 선정</div></li>-->
											<li><div>홍콩경매 20회, 최대 규모의 홍콩 현지 프리뷰 전시 진행</div></li>
											<li>
												<div>김환기 “12-V-70 #172” 최고가 낙찰가 기록 재 경신</div>
                                                <div class="img"><img src="/images/img/img_history07.jpg" alt="김환기 12-V-70 #172" style="  height:200px;
  width:auto;" /></div>
                                            </li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2016---------------------------------->
							
							<!----------------------------------2015---------------------------------->
                            <li>
								<dl>
									<dt>2015</dt>
									<dd>
										<ul>
											<li><div>1998년 창립 이후 낙찰 총액 1천억원 초과 달성</div></li>
											<li><div>보물 제 1210호 “청량산괘불탱” 고미술 최고가 기록</div></li>
                                            <li><div>홍콩경매 한국 고미술 부분 개최</div></li>
                                            <li><div>고서첩 경매 개최, 낙찰률 100% 달성</div></li>
                                            <li>
                                            	<div>김환기 “19-VII-71 #209” 근현대 최고 낙찰가 기록</div>
                                                <div class="img"><img src="/images/img/img_history06.jpg" alt="김환기 19-VII-71 #209" style="  height:200px;
  width:auto;" /></div>
                                            </li>
                                            
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2015---------------------------------->
							
							<!----------------------------------2014---------------------------------->
							<li class="odd" id="history06">
								<dl>
									<dt>2014</dt>
									<dd>
										<ul>
											<li><div>경매 낙찰률 87% 기록</div></li>
											<li><div>eBid Now 온라인 경매 런칭</div></li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2014---------------------------------->
							
							<!----------------------------------2013---------------------------------->
							<li>
								<dl>
									<dt>2013</dt>
									<dd>
										<ul>
											<li>												
												<div>전두환 컬렉션 특별 경매</div>
												<div class="img"><img src="/images/img/img_history01.jpg" alt="전두환 컬렉션 경매" /></div>
											</li>
										</ul>
									</dd>  
								</dl>
							</li>
							<!----------------------------------2013---------------------------------->
							
							<!----------------------------------2012---------------------------------->
							<li class="odd top01" id="history04">
								<dl>
									<dt>2012</dt>
									<dd>
										<ul>
											<li>
												<div>프린트베이커리 런칭</div>
												<div class="img"><img src="/images/img/img_history02.jpg" alt="print bakery" /></div>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2012---------------------------------->
							
							<!----------------------------------2010---------------------------------->
							<li>
								<dl>
									<dt>2010</dt>
									<dd><div>디자인 경매 개시</div></dd>
								</dl>
							</li>
							<!----------------------------------2010---------------------------------->
							
							<!----------------------------------2008---------------------------------->
							<li class="odd">  
								<dl>
									<dt>2008</dt> 
									<dd>
										<ul>
											<li>
												<div>홍콩시장 진출</div>
												<div class="img"><img src="/images/img/img_history03.jpg" alt="홍콩경매 전경" /></div>
											</li>
											<li id="history05" class="m_mt15"><div>코스닥(KOSDAQ) 상장</div></li><!-- 20150612 -->
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2008---------------------------------->
							
							<!----------------------------------2007---------------------------------->
							<li class="top01" id="history02">
								<dl>
									<dt>2007</dt>
									<dd>
										<ul>
											<li><div>제1회 코엑스 옥션쇼 개최</div></li>
											<li>
												<div>박수근 ‘빨래터’ 최고 낙찰가 기록</div>
												<div class="img"><img src="/images/img/img_history04.jpg" alt="박수근 빨래터" /></div>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2007---------------------------------->
							
							<!----------------------------------2006---------------------------------->
							<li class="odd">
								<dl>
									<dt>2006</dt>
									<dd>
										<ul>
											<li><div>서울옥션 부산점, 인사점 오픈</div></li>
											<li><div>100회 경매</div></li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2006---------------------------------->
							
							<!----------------------------------2005---------------------------------->
							<li>
								<dl>
									<dt>2005</dt>
									<dd><div>서울옥션 강남점 오픈</div></dd>
								</dl>
							</li>
							<!----------------------------------2005---------------------------------->
							
							<!----------------------------------2004---------------------------------->
							<li class="odd">
								<dl>
									<dt>2004</dt>
									<dd>
										<ul>
											<li><div>제1회 열린경매</div></li>
											<li><div>제1회 커팅엣지</div></li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2004---------------------------------->
							
							<!----------------------------------2002---------------------------------->
							<li>
								<dl>
									<dt>2002</dt>
									<dd><div>서울옥션 센터 개관</div></dd>
								</dl>
							</li>
							<!----------------------------------2002---------------------------------->
							
							<!----------------------------------2001---------------------------------->
							<li class="odd">
								<dl>
									<dt>2001</dt>
									<dd>
										<ul>
											<li><div>서울옥션으로 상호 변경</div></li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2001---------------------------------->
							
							<!----------------------------------2000---------------------------------->
							<li>
								<dl>
									<dt>2000</dt>
									<dd>
										<ul>
											<li><div>제1회 보석경매</div></li>
											<li><div>제1회 와인경매</div></li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------2000---------------------------------->
							
							<!----------------------------------1998---------------------------------->
							<li class="odd" id="history01">
								<dl>
									<dt>1998</dt>
									<dd>
										<ul>
											<li>
												<div>서울경매 설립</div>
												<div class="img"><img src="/images/img/img_history05.jpg" alt="서울경매 사옥 외관" /></div>
											</li>
										</ul>
									</dd>
								</dl>
							</li>
							<!----------------------------------1998---------------------------------->
						</ol>
					</div>
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
	
	<script type="text/javascript" src="/js/jquery.scrollTo.min.js"></script>
	<script type="text/javascript">
	
		 $(".history_step li a").on("click", function( e ) {
			e.preventDefault();

			$("body, html").animate({ 
				scrollTop: $( $(this).attr('href') ).offset().top - 100          
			}, 600);         

			if($(this).parent().hasClass('sele')){   
				
			} else {
				$('.history_step li').removeClass('sele');
				$(this).parent().addClass('sele');
			}

		});
	</script>
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />