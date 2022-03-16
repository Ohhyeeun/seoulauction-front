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
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../include/serviceSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>담보대출</h2>
						<p style="line-height:30px; font-size:16px;">서울옥션에서는 미술품 및 골동품을 담보로 대출을 시행하고 있습니다. 소장가 여러분의 많은 관심 바랍니다.</p>
					</div>

					<div class="loan_step">
						<ul>
							<li class="first">
								<div class="step">step<br>01</div>
								<dl>
									<dt>이메일 접수</dt>
									<dd>
										<p>이메일 주소로 <strong>미술품 이미지와 작품정보</strong>를 <strong>고미술품은 고미술 이메일</strong>로,<br /><strong>근현대미술품은 근현대 이메일</strong>로 보내기</p>
                                        <div class="txt_mail" style="margin-bottom: 10px;"><a href="mailto:jlee@seoulauction.com ">jlee@seoulauction.com </a>(미술품경매팀 - 이지희 이사)</div>
                                        <p class="txt_dark"><strong>※메일 제목 : '미술품 문의 - 보내시는분 성함'</p>
                                        <p class="txt_pale"></strong>&nbsp;(제목에 담보, 대출 단어가 들어가면 스팸 메일이 되어 확인이 어렵습니다.)</p>
                                        <!-- <div class="txt_mail"><a href="mailto:leehh@seoulauction.com">leehh@seoulauction.com</a>(미술품경매팀-근현대)</div> -->
									</dd>
								</dl>
							</li>
							<li class="second">								
								<div class="step">step<br>02</div>
								<dl>
									<dt>담당자 회신</dt>
									<dd>담보 대출 가능여부 판단 후<br>담당자 회신</dd>
								</dl>
							</li>
							<li>								
								<div class="step">step<br>03</div>
								<dl>
									<dt>작품 평가</dt>
									<dd>작품 실물입고 후<br>진위 및 가격 평가</dd>
								</dl>
							</li>
							<li>								
								<div class="step">step<br>04</div>
								<dl>
									<dt>확정 여부 회신</dt>
									<dd>담보 대출 확정 여부 회신</dd>
								</dl>
							</li>
							<li>								
								<div class="step">step<br>05</div>
								<dl>
									<dt>방문 서류 접수</dt>
									<dd>개인 고객, 법인 고객별<br>구비서류 준비 후 방문 접수</dd>
								</dl>
							</li>
							<li class="last">								
								<div class="step">step<br>06</div>
								<dl>
									<dt>대출금 입금 및 안내</dt>
									<dd>서류 심의 후, 일주일내로<br>대출금 입금 및 안내</dd>
								</dl>
							</li>
						</ul>
					</div>

					<div class="loan_cont_wrap">
						<div class="section">
							<div class="tit_h3 noborder" style="padding-top:40px;">
								<h3>개인 고객 준비 서류 안내</h3>
							</div>
							<div class="box_style08">
								<div class="list_style01">
									<ul>
										<li>개인 인감 도장</li>
										<li>개인 인감 증명서 1부 (3개월 이내)</li>
										<li>신분증 사본 1부	 </li>
										<li>입금통장 사본 1부</li>
									</ul>
									<ul>
										<li>소득금액 증명원 1부 (국세청)</li>
										<li>완납 증명서 1부 (국세청)</li>
										<li>지방세 납세 증명서 1부 (동사무소)</li>
									</ul>
								</div>
							</div>
							<p class="notice_style02" style="line-height:24px;">국세 체납이 있을 경우 접수 불가합니다.</p>
							<p class="notice_style01" style="line-height:24px;">위 서류중 하나라도 없으면 대출 불허되오니 참고 바랍니다.</p>
						</div>

						<div class="section">
							<div class="tit_h3 noborder" style="padding-top:40px;">
								<h3>법인고객 준비서류 안내</h3>
							</div>
							<div class="box_style08">
								<div class="list_style01">
									<ul>
										<li>사업자등록증 사본</li>
										<li>법인 인감 증명서 1부 (3개월 이내)</li>
										<li>법인인감 및 대표이사 인감</li>
										<li>법인 등기부등본 (3개월 이내)</li>
									</ul>
									<ul>
										<li>대표이사 개인인감증명서 (3개월 이내)</li>
										<li>신분증 사본 (대표자)</li>
										<li>이사회의사록 사본</li>
										<li>입금통장 사본</li>
									</ul>
									<ul>
										<li>최근 1년 감사 보고서</li>
										<li>최근 1년 부과세 과세표준증명원</li>
										<li>세목별 과세 증명서 및 납세증명서</li>
									</ul>
								</div>
							</div>
							<p class="notice_style02" style="line-height:24px;"><strong>대리인 방문시 : 1. 대리인 신분증, 2. 인감도장 날인된 위임장</strong></p>
							<p class="notice_style01" style="line-height:24px;">위 서류중 하나라도 없으면 대출 불허되오니 참고 바랍니다.</p>
						</div>
						
						<div class="section">				
							<div class="tit_h3 noborder" style="padding-top:40px;">
								<h3>담보 종류 안내</h3>
							</div>
							<p class="txt_dark lh20">경매가 가능한 미술작품<br>예) 근현대미술품, 고미술품 (<span class="txt_impo02">중국도자기는 제외</span>됩니다.)</p>
						</div>

						<div class="section">				
							<div class="tit_h3 noborder" style="padding-top:40px;">
								<p>미술품 담보 대출 조건 안내</p>
							</div>
							<div class="tbl_style02 web_only">
								<table>
									<caption>미술품 담보 대출 조건 안내</caption>
									<colgroup>
										<col style="width:14%;" />
										<col style="width:18%;" />
										<col style="width:18%;" />
										<col style="width:18%;" />
										<col style="width:18%;" />
										<col />
									</colgroup>
									<thead>
										<tr>
											<th>구분</th>
											<th>이자율</th>
											<th>연체이자율</th>
											<th>기본대출기간</th>
											<th>이자징수</th>
											<th>대출한도</th>
										</tr>
									</thead>
									<tbody>
										<tr class="noselect">
											<td>일반담보대출</td>
											<td>12% / 연</td>
											<td>15% / 연</td>
											<td>3개월</td>
											<td>원칙 : 선취</td>
											<td>작품평가액의 50%</td>
										</tr>
										<!--
										<tr class="noselect">
											<td>경매</td>
											<td>1% / 월</td>
											<td>2% / 월</td>
											<td>6개월</td>
											<td>원칙 : 선취</td>
											<td>150%</td>
										</tr>
										-->
									</tbody>
								</table>
							</div>
							<div class="tbl_style02 m_only m_tbl_z022">
								<table>
									<caption>대출 조건 안내</caption>
									<!--
									<colgroup>
										<col style="width:14%;" />
										<col style="width:43%;" />
										<col />
									</colgroup>
									-->
									<thead>
										<tr>
											<th>구분</th>
											<th>일반담보대출</th>
											<!--<th>경매</th>-->
										</tr>
									</thead>
									<tbody>
										<tr>
											<th>이자율</th>
											<td>12% / 연</td>
											<!--<td>1% / 월</td>-->
										</tr>
										<tr>
											<th>연체이자율</th>
											<td>15% / 연</td>
											<!--<td>2.5% / 월</td>-->
										</tr>
										<tr>
											<th>기본대출기간</th>
											<td>3개월</td>
											<!--<td>6개월</td>-->
										</tr>
										<tr>
											<th>이자징수</th>
											<td>원칙 : 선취</td>
											<!--<td>원칙 : 선취</td>-->
										</tr> 
										<tr>
											<th>대출한도</th>
											<td>작품평가액의 50%</td> 
											<!--<td>150%</td>-->
										</tr>
									</tbody>
								</table>
							</div>
							<p style="line-height:24px;">※ 상기조건은 개별건에 따라서 변경 가능합니다.</p>
						</div>
						
						<!-- YBK.20170331.경매대출안내추가 -->
						<div class="section">				
							<p class="loan-info"> 
                               대부업체명: ㈜ 서울옥션 대표이사 : 이옥경<br/>
                               등록번호: 2011-서울종로-00069(대부업)<br/>
                               소재지 : 서울시 종로구 평창 30길 24 (평창동)<br/> 
                               전화번호: 02-395-0330  
                            </p>
                            <p class="loan-info"> 
                            	대부이자율 12%/연 연체이자율 15%/연<br/>
								조기상환수수료 2% 조기상환조건 및 기타비용 없음
							</p> 
                            <p class="loan-info"> 
								중개수수료를 요구하거나 받는 것은 불법입니다.<br/> 
								과도한 빚은 당신에게 큰 불행을 안겨줄 수 있습니다.<br/>
								대출 시 귀하의 신용등급이 하락할 수 있습니다.  
							</p>  
							<p style="padding:15px; background-color: #F60; color:#FFF; width: 230px;"><a href="https://www.fss.or.kr/s1332/search/search0601.jsp" target="new" style="padding:20px; color:#FFF">등록대부업체 통합조회 서비스</a></p><br/> 
						</div>
						<!-- YBK.20170331.경매대출안내추가 --> 
						
						<div class="box_gray type01">  
							<div class="contact"> 
								<div class="title">문의 Contact</div>
								<div class="info">
									<div class="highlight">미술품경매팀 <strong>이지희 이사</strong></div> 
									<div class="tel"><strong class="tit">Tel</strong><span><a href="tel:02-2075-4499">02-2075-4499</a></span></div>
									<div class="email"><strong class="tit">E-mail</strong><a href="mailto:jlee@seoulauction.com">jlee@seoulauction.com</a></div> 
                                    <!-- <div class="highlight">미술품경매팀 근현대 <strong>이현희 팀장</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>02-2075-4437</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:leehh@seoulauction.com">leehh@seoulauction.com</a></div> -->
								</div>
							</div>
							<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
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
		</div><!-- id="container" -->
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />
