<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="incMerchant.jsp" %>
<%
	// 서버 IP 가져오기
	InetAddress inet = InetAddress.getLocalHost();
		
	// 가상계좌 입금만료일
	Timestamp toDay = new Timestamp((new Date()).getTime());
	Timestamp nxDay = getTimestampWithSpan(toDay, 1);
	String VbankExpDate = nxDay.toString();
	VbankExpDate = VbankExpDate.substring(0, 10); 
	VbankExpDate = VbankExpDate.replaceAll("-", "");

	String ediDate = getyyyyMMddHHmmss(); // 전문생성일시
	
	// 상점 MID
	String merchantID = "${maven.nicepay.merchant01.merchantID}";
	// 상점서명키 (꼭 해당 상점키로 바꿔주세요)
	String merchantKey = "${maven.nicepay.merchant01.merchantKey}";
	
	// 하단 form값의 Amt와 동일해야 합니다.
	String price = "1004";
	//위변조 처리 
	String md_src = ediDate + merchantID + price + merchantKey;
	DataEncrypt md5_enc =  new DataEncrypt();
	String hash_String  = md5_enc.encrypt(md_src);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>NICEPAY :: 결제 요청</title>
<link rel="stylesheet" href="/css/basic.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/style.css?${resources.timestamp}" type="text/css" />

<!-- NicePay 플러그인용 JS 
	 head 태그 안에 넣어주십시요. -->
<script src="https://web.nicepay.co.kr/flex/js/nicepay_tr.js" language="javascript"></script>

<script language="javascript">
NicePayUpdate();	//Active-x Control 초기화 함수로 head 태그 안에 선언합니다.

/**
	nicepay	를 통해 결제를 시작합니다.
*/
function nicepay() {
	var payForm		= document.payForm;
		
	// 필수 사항들을 체크하는 로직을 삽입해주세요.
	goPay(payForm);
}

/**
	결제를 취소 할때 호출됩니다.
*/
function nicepayClose()
{
	alert("결제가 취소 되었습니다");
}

/**
	사용자가 결제요청을 누를때 실행됩니다.
	form 명을 확인하여 주십시요.

*/
function nicepaySubmit(){
	
	document.payForm.submit();
}

function chkTransType(value)
{
	document.payForm.TransType.value = value;
}

function chkPayType()
{
	document.payForm.PayMethod.value = checkedButtonValue('selectType');
}
</script>
</head>
<body>
<br>
<br>
<form name="payForm" method="post" action="nicePayResult.jsp">
<table width="632" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
  	<td >
  	  <table width="632" border="0" cellspacing="0" cellpadding="0" class="title">
        <tr>
          <td width="35">&nbsp;</td>
          <td>결제 요청</td>
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td align="left" valign="top" background="/images/payment/bodyMiddle.gif">
    <table width="632" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="35" height="10">&nbsp;</td> 
        <td width="562">&nbsp;</td>
        <td width="35">&nbsp;</td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td>
        <td>결제 요청페이지 샘플입니다. <br> </td> 
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="15">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td> 
        <td class="bold"><img src="/images/payment/bullet.gif" /> 정보를 기입하신 후 확인버튼을 눌러주십시오.
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td >&nbsp;</td>
        <td ><table width="562" border="0" cellspacing="0" cellpadding="0" class="talbeBorder" >
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">결제 수단</td> 
            <td id="borderBottom" >
              <input type="checkbox" name="selectType" value="CARD" onClick="javascript:chkPayType();">[신용카드]
			  <input type="checkbox" name="selectType" value="BANK" onClick="javascript:chkPayType();">[계좌이체]
			  <input type="checkbox" name="selectType" value="VBANK" onClick="javascript:chkPayType();">[가상계좌]
			  <input type="checkbox" name="selectType" value="CELLPHONE" onClick="javascript:chkPayType();">[휴대폰결제]
			</td>
          </tr>
          <tr>
			<td width="100" height="30" id="borderBottom" class="thead02" >결제타입</td>
			<td id="borderBottom" >
			  <input type="radio" name="TransTypeRadio" value="0" onClick="javascript:chkTransType('0')" checked>일반</input>
			  <input type="radio" name="TransTypeRadio" value="1" onClick="javascript:chkTransType('1')" >에스크로</input>
			</td>
		  </tr>
		  <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">* 상품명</td> 
            <td id="borderBottom" ><input name="GoodsName" type="text" value="곰인형"/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead02">* 상품가격</td> 
            <td id="borderBottom" ><input name="Amt" type="text" value="<%=price%>"/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">상품주문번호</td> 
            <td id="borderBottom" ><input name="Moid" type="text" value="mnoid1234567890"/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead02">* 구매자명</td> 
            <td id="borderBottom" ><input name="BuyerName" type="text" value="홍길동"/></td>
          </tr> 
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">* 구매자 이메일</td> 
            <td id="borderBottom" ><input name="BuyerEmail" type="text" value="test@abc.com"/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead02">* 구매자 전화번호</td> 
            <td id="borderBottom" ><input name="BuyerTel" type="text" value="12345678"/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">* 상점아이디</td> 
            <td id="borderBottom" ><input name="MID" type="text" value="nictest00m"/></td>
          </tr>


          <tr>
            <td width="100" height="30" id="borderBottom" class="thead02">스킨 타입</td> 
            <td id="borderBottom" >
				<select name="SkinType">
					<option value="blue">BLUE</option>
					<option value="purple">PURPLE</option>
					<option value="red">RED</option>
					<option value="green">GREEN</option>
				</select></td>
          </tr>
         
        </table></td>
        <td height="15">&nbsp;</td>
      </tr>
      <tr>
      	<td height="60"></td>
        <td class="btnCenter"><input type="button" value="요청하기" onClick="javascript:nicepay();"></td> 
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="15"></td>  
        <td >&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td></td>
        <td class="comment">* 표 항목은 반드시 기입해주시기 바랍니다.<br><br/>
        <span class="bold">테스트 아이디로 결제된 건에대해서는 당일 오후 11:30분에 일괄 취소됩니다.</span><br/>
        실제아이디 적용시 테스트아이디가 적용되지 않도록 각별한 주의를 부탁드립니다.
        </td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="10"></td>  
        <td >&nbsp;</td>
        <td>&nbsp;</td>
      </tr>  
    </table></td>
  </tr>
  <tr>
    <td><img src="/images/payment/bodyBottom.gif" /></td>
  </tr>
</table>

<!-- Mall Parameters --> 
<input type="hidden" name="PayMethod" value="">
<!-- 상품 갯수 -->
<input type="hidden" name="GoodsCnt" value="1">
<!-- 주소 -->
<input type="hidden" name="BuyerAddr" value="서울시 강남구 역삼동 9-11">

<input type="hidden" name="UserIP" value="<%=request.getRemoteAddr()%>">
<input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>">

<!-- 결제 타입 0:일반, 1:에스크로 -->
<input type="hidden" name="TransType" value="0">

<!-- 결제 옵션  -->
<input type="hidden" name="OptionList" value="">

<!-- 가상계좌 입금예정 만료일  -->
<input type="hidden" name="VbankExpDate" value="<%=VbankExpDate%>"> 

<!-- 구매자 고객 ID -->
<input type="hidden" name="MallUserID" value=""> 
<!-- 서브몰 아이디 -->
<input type="hidden" name="SUB_ID" value="">
<!-- 휴대폰 실물/컨텐츠 구분 -->
<input type="hidden" name="GoodsCl" value="">
<!-- 암호화 항목 -->
<input name="EncodeParameters" type="hidden" value="CardNo,CardExpire,CardPwd"/>
<!-- 변경 불가 -->
<input type="hidden" name="EdiDate" value="<%=ediDate%>">
<input type="hidden" name="EncryptData" value="<%=hash_String%>" >
<input type="hidden" name="SocketYN" value="Y">
<input type="hidden" name="TrKey" value="">

</form>
</body>
</html>