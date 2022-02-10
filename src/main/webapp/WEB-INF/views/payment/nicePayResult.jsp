<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.nicevan.nicepay.adapter.web.NicePayHttpServletRequestWrapper"%>
<%@ page import="kr.co.nicevan.nicepay.adapter.web.NicePayWEB"%>
<%@ page import="kr.co.nicevan.nicepay.adapter.web.dto.WebMessageDTO"%>

<%

request.setCharacterEncoding("euc-kr"); 
/** 1. Request Wrapper 클래스를 등록한다.  */ 
NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);

/** 2. 소켓 어댑터와 연동하는 Web 인터페이스 객체를 생성한다.*/
NicePayWEB nicepayWEB = new NicePayWEB();

/** 2-1. 로그 디렉토리 설정 */
nicepayWEB.setParam("NICEPAY_LOG_HOME","/wwwroot/ipg_adaptor_log/log");

/** 2-2. 어플리케이션로그 모드 설정(0: DISABLE, 1: ENABLE) */
nicepayWEB.setParam("APP_LOG","1");

/** 2-3. 이벤트로그 모드 설정(0: DISABLE, 1: ENABLE) */
nicepayWEB.setParam("EVENT_LOG","1");

/** 2-4. 암호화플래그 설정(N: 평문, S:암호화) */
nicepayWEB.setParam("EncFlag","S");

/** 2-5. 서비스모드 설정(결제 서비스 : PY0 , 취소 서비스 : CL0) */
nicepayWEB.setParam("SERVICE_MODE", "PY0");

/** 2-6. 통화구분 설정(현재 KRW(원화) 가능)  */
nicepayWEB.setParam("Currency", "KRW");

/** 2-7. 결제수단 설정 (신용카드결제 : CARD, 계좌이체: BANK, 가상계좌이체 : VBANK, 휴대폰결제 : CELLPHONE ) */
String payMethod = request.getParameter("PayMethod");
nicepayWEB.setParam("PayMethod",payMethod);

nicepayWEB.setParam("EncodeKey","33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A==");

/** 3. 결제 요청 */
WebMessageDTO responseDTO = nicepayWEB.doService(httpRequestWrapper,response);

/** 4. 결제 결과 */
String resultCode = responseDTO.getParameter("ResultCode"); // 결과코드 (정상 :3001 , 그 외 에러)
String resultMsg = responseDTO.getParameter("ResultMsg");   // 결과메시지
String authDate = responseDTO.getParameter("AuthDate");   // 승인일시 YYMMDDHH24mmss
String authCode = responseDTO.getParameter("AuthCode");   // 승인번호

String buyerName = responseDTO.getParameter("BuyerName");   // 구매자명
String mallUserID = responseDTO.getParameter("MallUserID");   // 회원사고객ID
String goodsName = responseDTO.getParameter("GoodsName");   // 상품명
String mid = responseDTO.getParameter("MID");  // 상점ID
String tid = responseDTO.getParameter("TID");  // 거래ID
String moid = responseDTO.getParameter("Moid");  // 주문번호
String amt = responseDTO.getParameter("Amt");  // 금액

String cardCode = responseDTO.getParameter("CardCode");   // 결제카드사코드
String cardName = responseDTO.getParameter("CardName");   // 결제카드사명
String cardQuota = responseDTO.getParameter("CardQuota");  // 카드 할부개월 (00:일시불,02:2개월)

String bankCode = responseDTO.getParameter("BankCode");   // 은행코드
String bankName = responseDTO.getParameter("BankName");   // 은행명
String rcptType = responseDTO.getParameter("RcptType"); //현금 영수증 타입 (0:발행되지않음,1:소득공제,2:지출증빙)
String rcptAuthCode = responseDTO.getParameter("RcptAuthCode"); //현금영수증 승인 번호
String rcptTID = responseDTO.getParameter("RcptTID"); //현금 영수증 TID   

String carrier = responseDTO.getParameter("Carrier");       // 이통사구분
String dstAddr = responseDTO.getParameter("DstAddr");       // 휴대폰번호

String vbankBankCode = responseDTO.getParameter("VbankBankCode");   // 가상계좌은행코드
String vbankBankName = responseDTO.getParameter("VbankBankName");   // 가상계좌은행명
String vbankNum = responseDTO.getParameter("VbankNum");   // 가상계좌번호
String vbankExpDate = responseDTO.getParameter("VbankExpDate");   // 가상계좌입금예정일

boolean paySuccess = false;		// 결제 성공 여부

/** 위의 응답 데이터 외에도 전문 Header와 개별부 데이터 Get 가능 */
if(payMethod.equals("CARD")){	//신용카드
	if(resultCode.equals("3001")) paySuccess = true;	// 결과코드 (정상 :3001 , 그 외 에러)
}else if(payMethod.equals("BANK")){		//계좌이체
	if(resultCode.equals("4000")) paySuccess = true;	// 결과코드 (정상 :4000 , 그 외 에러)
}else if(payMethod.equals("CELLPHONE")){			//휴대폰
	if(resultCode.equals("A000")) paySuccess = true;	//결과코드 (정상 : A000, 그 외 비정상)
}else if(payMethod.equals("VBANK")){		//가상계좌
	if(resultCode.equals("4100")) paySuccess = true;	// 결과코드 (정상 :4100 , 그 외 에러)
}

if(paySuccess){
   // 결제 성공시 DB처리 하세요.
}else{
   // 결제 실패시 DB처리 하세요.
}

%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>NICEPAY :: 결제 요청 결과</title>
<link rel="stylesheet" href="/css/basic.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/style.css?${resources.timestamp}" type="text/css" />
</head>
<body>
<br>
<table width="632" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
  	<td >
  	  <table width="632" border="0" cellspacing="0" cellpadding="0" class="title">
        <tr>
          <td width="35">&nbsp;</td>
          <td>결제 요청 결과</td>
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td align="left" valign="top" background="/images/payment/bodyMiddle.gif"><table width="632" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="35" height="10">&nbsp;</td> <!--상단여백 높이 10px -->
        <td width="562">&nbsp;</td>
        <td width="35">&nbsp;</td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td>
        <td>결제 요청이 완료되었습니다.
        </td> 
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="15">&nbsp;</td> <!--컨텐츠와 컨텐츠 사이 간격 15px-->
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td> 
        <td class="bold"><img src="/images/payment/bullet.gif" /> 결제 내역입니다.
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td >&nbsp;</td>
        <td ><table width="562" border="0" cellspacing="0" cellpadding="0" class="talbeBorder" >
          <tr>
            <!-- 테이블 일반의 높이는 30px // 홀수행셀의 경우 class="thead01" 사용 -->
            <td width="100" height="30" id="borderBottom" class="thead01">결과 내용</td> 
            <td id="borderBottom" >&nbsp;[<%=resultCode%>] <%=resultMsg%></td>
          </tr>
          <tr>
            <!-- 테이블 일반의 높이는 30px // 홀수행셀의 경우 class="thead02" 사용 -->
            <td width="100" height="30" id="borderBottom" class="thead02">결제 수단</td> 
            <td id="borderBottom" >&nbsp;<%=payMethod %></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">상품명</td> 
            <td id="borderBottom" >&nbsp;<%=goodsName %></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead02">금액</td> 
            <td id="borderBottom" >&nbsp;<%=amt %> 원</td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">거래아이디</td> 
            <td id="borderBottom" >&nbsp;<%=tid %></td>
          </tr>

			<%if(payMethod.equals("CARD")){%>
			  <tr>
				<td width="100" height="30" id="borderBottom" class="thead02">카드사명</td> 
				<td id="borderBottom" ><%= cardName %>&nbsp;</td>
			  </tr>
			  <tr>
				<td width="100" height="30" id="borderBottom" class="thead01">할부개월</td> 
				<td id="borderBottom" ><%= cardQuota %>&nbsp;</td>
			  </tr>
		   <%}else if(payMethod.equals("BANK")){%>
			  <tr>
				<td width="100" height="30" id="borderBottom" class="thead02">은행</td> 
				<td id="borderBottom" ><%= bankName %>&nbsp;</td>
			  </tr>
			   <tr>
				<td width="100" height="30" id="borderBottom" class="thead01">현금영수증 타입</td> 
				<td id="borderBottom" ><%= rcptType %>&nbsp;&nbsp;(0:발행안함,1:소득공제,2:지출증빙)</td>
			  </tr>
		  <%}else if(payMethod.equals("CELLPHONE")){%>
			  <tr>
				<td width="100" height="30" id="borderBottom" class="thead02">이통사 구분</td> 
				<td id="borderBottom" ><%= carrier %>&nbsp;</td>
			  </tr>
			   <tr>
				<td width="100" height="30" id="borderBottom" class="thead01">휴대폰 번호</td> 
				<td id="borderBottom" ><%= dstAddr %>&nbsp;</td>
			  </tr>
		  <%}else if(payMethod.equals("VBANK")){%>
			  <tr>
				<td width="100" height="30" id="borderBottom" class="thead02">입금 은행</td> 
				<td id="borderBottom" ><%= vbankBankName %>&nbsp;</td>
			  </tr>
			   <tr>
				<td width="100" height="30" id="borderBottom" class="thead01">입금 계좌</td> 
				<td id="borderBottom" ><%= vbankNum %>&nbsp;</td>
			  </tr>
			  <tr>
				<td width="100" height="30" id="borderBottom" class="thead02">입금 기한</td> 
				<td id="borderBottom" ><%= vbankExpDate %>&nbsp;</td>
			  </tr>
		  <%}%>


        </table></td>
        <td height="15">&nbsp;</td>
      </tr>
      <tr>
        <td height="15"></td>  <!--컨텐츠와 컨텐츠 사이 간격 15px-->
        <td >&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td></td>
        <td class="comment">테스트 아이디인경우 당일 오후 11시 30분에 취소됩니다.        
        </td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="10"></td>  <!--하단여백 높이 10px -->
        <td >&nbsp;</td>
        <td>&nbsp;</td>
      </tr>  
    </table></td>
  </tr>
  <tr>
    <td><img src="/images/payment/bodyBottom.gif" /></td>
  </tr>
</table>
</body>
</html>