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
						<h2>자주하시는 질문</h2> 
					</div>
					<div class="faq_list">
						<ul>
												
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">온라인경매 페이지 자동 새로고침 해결방법?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>1. 익스플로러 설정 클릭 (보통 톱니바퀴 모양)<br/>2. 인터넷 옵션 클릭<br/>3. 일반 -> 검색기록 -> 설정 클릭<br/>4. 웹 페이지를 열 때 마다 클릭<br/>5. 확인(저장) <br/>6. 확인(저장) <br/><br/>
                                    <img src="/images/img/online_ie.jpg" style="width:100%; max-width:860px;"/> 
                                    </div>  
								</div> 
							</li> 
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">위탁은 어떻게 하나요?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>art@seoulauction.com<br/> 
	1. 성함 2. 연락처 3. 작품제목 4. 사이즈 5. 소장경위 6. 작품사진 - 전체컷, 싸인 등의 부분컷(중요부분) 을 보내주시면,<br/>작품별 스페셜리스트에게 전달되어 답변드리겠습니다.<br/>
    자세한 내용은 위탁안내 페이지를 참고 해주시기 바랍니다.&nbsp;&nbsp;
    <a href="/auctionGuide/page?view=commissionGuide" style="border:solid 1px #999999; color:#666; padding:3px;">위탁안내 바로가기</a></div>
								</div>  
							</li>					
							
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">경매 응찰을 하고 싶습니다.</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>경매 응찰 방법은 전화응찰과 서면응찰, 현장에서 직접 응찰하는 방법이 있습니다.<br/><br/> 
	
	1. 응찰 신청서는 프리뷰기간동안 전시장에서 신청 하실 수도 있고, 홈페이지에서도 응찰 신청이 가능합니다. <br/>
	정회원으로 가입하시면 응찰 권한이 주어지며, 특히 홈페이지에서는 정회원 가입이 완료되면, 바로 전화응찰 또는 서면응찰을 편안하게 하실 수 있습니다.<br/> 
	2. 응찰 기간은 프리뷰 오픈일부터 입니다.<br/>
	3. 응찰 마감은 종이서류(팩스)는 경매 전일 오후7시까지, 홈페이지에서 응찰신청은 경매 전일까지 접수해주시기 바랍니다.<br/>
    4. 현장 응찰을 희망하는 회원께서는 좌석과 패들을 미리 전화 예약하시기 바랍니다.</div>
								</div>
							</li>					
							
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">준회원과 정회원은 어떤 차이가 있습니까?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>준회원과 정회원은 오프라인응찰 가능과 불가능 차이가 있습니다.<br/><br/> 
1. 준회원(연회비없음) - 홈페이지 준회원 가입. 홈페이지 서비스 이용, 온라인경매 이용가능<br/> 
2. 정회원(연회비있음) - 연회비 20만원. 홈페이지 서비스 이용,  서울옥션 전체 경매 응찰 자격 부여(낙찰 시, 수수료 별도 부가), 경매도록 등 발송 서비스 혜택(회원기간 1년 동안), 온라인경매 이용가능<br/> 
* 도록은 정회원의 경매 응찰을 위한 참고 자료이며, 정회원 분들께 경매 전에 배포하고 있습니다. <br/>
* 정회원 가입을 원하시는 경우, 회원가입을 새로 하실때, 정회원 신청을 하시거나, 이미 홈페이지에 가입하신 분들(준회원의 경우)은 로그인 후 홈페이지 ACCOUNT에서 주황색 결제하기 버튼은 눌러 정회원을 신청해주시면 됩니다.</div>  
								</div> 
							</li>
                            
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">지난 경매 도록을 한 권 구매하고 싶습니다.</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>서울옥션에서는 도록을 낱권으로 판매하지 않습니다. 도록은 정회원의 경매 응찰을 위한 참고 자료이며, 정회원 분들께 경매 전에 배포하고 있습니다.<br/> 
	정회원은 가입기간은 1년, 연회비는 20만원입니다.<br/> 
	정회원 가입을 원하시는 경우, 회원가입을 새로 하실때, 정회원 신청을 하시거나, 이미 홈페이지에 가입하신 분들(준회원의 경우)은 로그인 뒤 홈페이지 상에서 정회원을 신청해주시면 됩니다.</div>
								</div>
							</li>					
							
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">전시장(경매장)에서 정회원가입을 했는데, 홈페이지에선 준회원으로 나옵니다.</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>1. 현장가입 정회원고객님께서 홈페이지 회원을 원하시는 경우, 홈페이지 가입 후 담당자 또는 대표번호02-395-0330으로 연락 주시면 확인 후 정회원으로 승격하여 드리겠습니다.<br/> 
	2. 사전에 홈페이지 준회원으로 가입한 뒤 현장에서 정회원비를 납부하신 경우, 가입서류 성함 옆에 아이디를 적어주시면 담당자에게 전달 후 승격됩니다. <br/>
	3. 기존에 홈페이지를 통해 정회원으로 가입하신 분이 만료 후, 현장에서 정회원비를 납부하신 경우에도 가입서류 성함 옆에 아이디를 적어주시면 담당자에게 전달뒤 승격됩니다.</div>
								</div> 
							</li>					
							
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">전시 및 경매 안내 문자와이메일을 수신하고 싶은데 어떻게 해야하나요?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>홈페이지 회원가입시 본인의 휴대폰 번호를 기입하신 뒤 휴대폰 SMS 문자수신에 "예, 수신하겠습니다"를 체크합니다.<br/>
	이메일 또한 받으실 이메일 주소를 적고, 정보메일 수신에 "예, 수신하겠습니다"를 체크한 뒤 저장하면 됩니다.<br/>
	마이페이지(My Page)의 회원정보 수정에서도 같은 방법으로 체크 후 저장하면 서울옥션의 전시와 경매 안내 문자를 받으시거나 이메일을 받아보실 수 있습니다.<br/>
	수신을 원하지 않는 경우 "아니오, 수신하지 않겠습니다"를 체크하시면 발송되지 않습니다.</div>
								</div>
							</li>					
							
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">비밀번호 변경은 어떻게 하나요?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>로그인(LOGIN)후 어카운트(ACCOUNT)의 마이페이지(My Page)의 회원정보 수정에서<br/>변경하실 비밀번호를 변경과 확인까지 동일한 비밀번호를 2번 입력한 뒤<br/>하단의 확인 버튼을 누르시면 비밀번호가 수정됩니다.<br/>로그아웃 한 뒤, 다시 로그인 할때 수정된 비밀번호로 적용됩니다.</div>
								</div> 
							</li>	
                            
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">경매와 전시는 구경 가능한가요?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>서울옥션의 경매와 전시는 무료 관람입니다. 입찰여부와 상관없이 경매구경이 가능합니다. <br/>경매와 전시 날짜는 홈페이지를 통해 확인하실 수 있습니다.<br/>경매 응찰은 정회원만 가능합니다. 응찰을 원하실 경우, 홈페이지를 참고하시거나 문의해주시면 안내드리겠습니다.<br/>경매 응찰 시 당일 좌석 예약을 원하는 경우 경매 전날까지 대표전화를 통해 예약 신청하시면 됩니다.</div>
								</div> 
							</li>
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">양도소득세?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>개인이 서화(書畵), 골동품을 양도할 때, 양도가액이 6천만원 이상인 경우 양도소득세가 부과됩니다.<br/>양도가액이 6천만원 이상이더라도 양도일 현재 생존해 있는 국내 원작자의 작품 양도로 발생하는 소득, 문화재 보호법에 따라 국가 지정문화재로 지정된 서화(書畵), 골동품의 양도로 발생하는 소득, 박물관 또는 미술관에 양도함으로써 발생하는 소득에 대해서는 양도소득세가 부과되지 않습니다.</div>  
								</div> 
							</li>
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">카드결제 가능한가요?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>온라인 경매의 경우 전체 금액 카드 결제가 가능합니다.<br/>오프라인 경매는 수수료에 한해서 카드결제가 가능합니다. </div>  
								</div> 
							</li>
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">현금영수증 발행이 가능한가요?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>현금영수증은 수수료분과 과세만 발행되고 낙찰 금액은 비과세로 발행이 가능합니다.</div>  
								</div> 
							</li>
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">고미술품의 수출.입에 대해 궁금합니다.</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>경매물품은 대한민국의 수출 관련 법령 및 관련국의 수입 관련 법령에 의한 제한을 받을 수 있습니다. 경매물품의 해외반출,반입에 필요한 허가를 취득해야 할 책임은 낙찰자에게 있습니다. 특히, 한국의 문화재 및 유물 등으로 추정되는 경매물품의 응찰 시에는 한국의 문화재보호법에 따라 문화재 및 유물 등은 국외로 수출 또는 반출이 금지되어 있으므로 응찰자는 이 점을 충분히 숙지하고 응찰 및 낙찰에 임해야 합니다.</div>  
								</div> 
							</li>
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">문의하려면 어떻게 해야하나요?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>서울옥션에 문의 하실 내용이 있으신 경우 아래와같이 3가지 방법중 한가지를 선택해 문의 하실 수 있습니다.<br/><br/>1. 홈페이지의 1:1 문의 - 로그인 후 ACCOUNT의 1:1 문의를 이용하시면, 답변을 드리고 있습니다.<br/>2. 전화문의 - 대표전화 02-395-0330 로 문의 주시면, 문의 사항에 따른 답변을 드리고 있습니다.<br/>3. 이메일로 문의 - 홈페이지 사용에 관련한 문의 : webmaster@seoulauction.com  / 작품 위탁에 관한 문의 : art@seoulauction.com</div>  
								</div> 
							</li>	
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">동영상 재생오류 해결방법?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>1. 페이지를 새로고침 합니다. <br/>2. Chrome, Edge, firefos 등 HTML5 지원 브라우저 사용을 권장합니다.<br/>3. 브라우저를 최신버젼으로 업그레이드하세요.<br/>4. 자바스크립트를 모든 사이트에서 항상 실행을 하도록 설정해 주세요.<br/>5. 캐시와 쿠키 삭제해주세요. <br/>6. 스피커 등 입력장치 연결이 안된 경우 연결이 잘 되었는지 확인하세요.</div>  
								</div> 
							</li>
                            <li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">휴대폰 인증번호 받지 못한 경우?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>1. 안드로이드 폰에 해당<br/>2. 메세지 리스트의 설정으로 이동<br/>3. 메세지 차단<br/>4. 차단메세지<br/>5. 차단된 번호 리스트가 뜸<br/>6. 해당되는 번호 누르고 복원을 클릭</div>  
								</div> 
							</li>
							<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">정회원 환불절차가 어떻게 진행되나요?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>정회원 유효기간 만료 전 이용계약을 해지하는 경우, 아래 기준에 따라 연회비를 환불 받을 수 있습니다.<br><br>
										가입 직후 – 1개월 미만 : 전액 환불<br>
										1개월 이상 – 3개월 미만 : 80% 환불<br>
										3개월 이상 – 6개월 미만 : 60% 환불<br>
										가입 후 6개월 이상 : 환불 미진행
									</div>
								</div>
							</li>
                            <!--<li>
								<div class="question">
									<span class="sp_icon bul_question"><span class="hidden">질문</span></span>
									<a href="#">고객원격지원?</a>
								</div>
								<div class="answer" style="display: none;">
									<span class="sp_icon bul_answer"><span class="hidden">답변</span></span>
									<div>1. 서울옥션 홈페이지에 문의가 있는경우 상담원의 필요의 의해 원격 지원을 할 수도 있습니다.<br/>2. 상담원과 통화중인 상태에서 고객님의 동의하에서만 지원이 가능합니다. (고객님의 컴퓨터에서 번호 동의가 없으면 지원이 불가합니다.)<br/>3. 아래의 주황색 버튼으로 접속해주세요.<br/>4. 크롬에서는 별도의 설치 파일이 필요합니다.<br/><br/><a href="https://113366.com/" target="new" style="background-color:#F93; color:#000; padding:5px;">고객원격지원</a></div>  
								</div> 
							</li>-->
                            
						</ul>
					</div>
				</div>
			</div>

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li><img src="/images/img/img_menu04.jpg" alt="작품1" class="img_master" /></li>
					</ul>
				</div>
			</div>-->
		</div>
	</div>
</div>

<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />