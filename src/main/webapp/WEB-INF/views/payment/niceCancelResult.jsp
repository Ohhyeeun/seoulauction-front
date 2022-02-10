<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.nicevan.nicepay.adapter.web.NicePayHttpServletRequestWrapper"%>
<%@ page import="kr.co.nicevan.nicepay.adapter.web.NicePayWEB"%>
<%@ page import="kr.co.nicevan.nicepay.adapter.web.dto.WebMessageDTO"%>

<%

/** 1. Request Wrapper 클래스를 등록한다.  */ 
NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);
//httpRequestWrapper.addParameter("testFlag" ,"TRUE");


/** 2. 소켓 어댑터와 연동하는 Web 인터페이스 객체를 생성한다.*/
NicePayWEB nicepayWEB = new NicePayWEB();

/** 2-1. 로그 디렉토리 설정 */
nicepayWEB.setParam("NICEPAY_LOG_HOME","/wwwroot/ipg_adaptor_log/log");

/** 2-2. 이벤트로그 모드 설정(0: DISABLE, 1: ENABLE) */
nicepayWEB.setParam("APP_LOG","1");

/** 2-3. 어플리케이션로그 모드 설정(0: DISABLE, 1: ENABLE) */
nicepayWEB.setParam("EVENT_LOG","1");

/** 2-4. 암호화플래그 설정(N: 평문, S:암호화) */
nicepayWEB.setParam("EncFlag","S");

/** 2-5. 서비스모드 설정(결제 서비스 : PY0 , 취소 서비스 : CL0) */
nicepayWEB.setParam("SERVICE_MODE", "CL0");



/** 3. 결제취소 요청 */
WebMessageDTO responseDTO = nicepayWEB.doService(httpRequestWrapper,response);

/** 4. 취소결과 */
String resultCode = responseDTO.getParameter("ResultCode"); // 결과코드 (정상 :2001(취소성공), 2002(취소진행중), 그 외 에러)
String resultMsg = responseDTO.getParameter("ResultMsg");   // 결과메시지
String cancelAmt = responseDTO.getParameter("CancelAmt");   // 취소금액
String cancelDate = responseDTO.getParameter("CancelDate");     // 취소일
String cancelTime = responseDTO.getParameter("CancelTime");   // 취소시간
String cancelNum = responseDTO.getParameter("CancelNum");   // 취소번호
String payMethod = responseDTO.getParameter("PayMethod");   // 취소 결제수단
String mid = 	responseDTO.getParameter("MID");              // 상점 ID
String tid = responseDTO.getParameter("TID");               // TID

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>NICEPAY :: 결제취소 결과</title>
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
          <td>취소 결과</td>
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
        <td>취소 요청이 완료되었습니다.
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
        <td class="bold"><img src="/images/payment/bullet.gif" /> 취소내역을 확인하세요.
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td >&nbsp;</td>
        <td ><table width="562" border="0" cellspacing="0" cellpadding="0" class="talbeBorder" >
          <tr>
            <!-- 테이블 일반의 높이는 30px // 홀수행셀의 경우 class="thead01" 사용 -->
            <td width="100" height="30" id="borderBottom" class="thead01">거래 아이디</td> 
            <td id="borderBottom" >&nbsp;<%=tid %></td>
          </tr>
          <tr>
            <!-- 테이블 일반의 높이는 30px // 홀수행셀의 경우 class="thead01" 사용 -->
            <td width="100" height="30" id="borderBottom" class="thead02">결제 수단</td> 
            <td id="borderBottom" >&nbsp;<%=payMethod%></td>
          </tr>
          <tr>
            <!-- 테이블 일반의 높이는 30px // 짝수행셀의 경우 class="thead01" 사용 -->
            <td width="100" height="30" id="borderBottom" class="thead01">결과 내용</td> 
            <td id="borderBottom" >&nbsp;[<%=resultCode%>] <%=resultMsg%></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead02">취소 금액</td> 
            <td id="borderBottom" >&nbsp;<%=cancelAmt %></td>
          </tr>
		
		</table></td>
      <tr>
        <td height="15"></td>  <!--컨텐츠와 컨텐츠 사이 간격 15px-->
        <td >&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td></td>
        <td class="comment">취소가 성공한 경우에는 다시 승인상태로 복구 할 수 없습니다..        
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