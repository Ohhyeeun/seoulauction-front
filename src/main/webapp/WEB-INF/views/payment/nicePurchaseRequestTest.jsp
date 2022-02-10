<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="price" value="${price}" scope="page"/>
<%@ include file="incMerchant.jsp" %>
<%
//서버 IP 가져오기
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
	// 상점서명키 (꼭 해당 상점키로 바꿔주세요). 낙찰대는 면세 아이디 입력.
	String merchantKey = "${maven.nicepay.merchant01.merchantKey}";
	
	// 상품 가격을 기입하십시요.
	// 하단 form값의 Amt와 동일해야 합니다.
// 	String price = "500";
	String price = "" + pageContext.getAttribute("price");

	//위변조 처리
	String md_src = ediDate + merchantID + price + merchantKey;
	DataEncrypt md5_enc =  new DataEncrypt();
	String hash_String  = md5_enc.encrypt(md_src);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" /><!-- blueerr 2018.09.04 모바일에서 글씨가 너무 작게 나와서 추가 -->
<title>NICEPAY :: 결제 요청</title>
<link rel="stylesheet" href="/css/basic.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/style.css?${resources.timestamp}" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.js" ></script>

<!-- NicePay 플러그인용 JS 
	 head 태그 안에 넣어주십시요. -->
<script src="https://web.nicepay.co.kr/flex/js/nicepay_tr_utf.js" language="javascript"></script>

<script language="javascript">
/** 모바일 여부 체크 (2018.01.31)*/
var filter = "win16|win32|win64|mac";
var bIsMobile = false;
if(navigator.platform){
	if(0 > filter.indexOf(navigator.platform.toLowerCase())){
		bIsMobile = true;
	}else{
		bIsMobile = false;
	}
}
/***************************/
NicePayUpdate();	//Active-x Control 초기화 함수로 head 태그 안에 선언합니다.

/**
	nicepay	를 통해 결제를 시작합니다.
*/
function nicepay() {
	var payForm		= document.payForm;
	// 필수 사항들을 체크하는 로직을 삽입해주세요.
	
	var bIsTypeSelected = false;
	
	// 정보수신방법 체크 여부 확인
	//$("input[name=selectType]:checkbox").each(function () {
	//	if($(this)[0].checked == true) {
	//		bIsTypeSelected = true;
	//	}
	//});
	
	$("input[name=selectType]:radio").each(function () {
		if($(this)[0].checked == true) {
			bIsTypeSelected = true;
		}
	});
	
	if(bIsTypeSelected) {
		if(bIsMobile){
			goPayMobile(payForm);
		}else{
			goPay(payForm);
		}
	}
	else {
		alert("결제 수단을 선택해주세요.");
		return;
	}
}

/** 모바일 결제모듈 추가.(2018.01.30)*/
function goPayMobile(form) {
	document.charset = "utf-8";
	form.target = "_self";	/*<!-- blueerr 2018.09.04 모바일에서 마지막에 결제요청창이 닫히지 않아 _blank에서 _self로 수정 -->*/
	form.acceptCharset = "euc-kr"; /*<!-- blueerr 2018.09.04 모바일에서 acceptCharset euck-kr로 해야 결제화면에  한글상품명이 깨지지 않음 -->*/
	form.method = "post";
	form.action = "https://web.nicepay.co.kr/smart/paySmart.jsp";
	form.submit();
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
<form name="payForm" method="post" action="/customer/nicePurchaseResult" accept-charset="utf-8">
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
        <td height="15">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td> 
        <td class="bold"><img src="/images/payment/bullet.gif" /> 정보를 기입하신 후 확인버튼을 눌러주십시오.
        <td>&nbsp;</td>
      </tr>
      <!-- <tr>
      	<td height="30">&nbsp;</td> 
        <td class="bold"><img src="/images/payment/bullet.gif" /><font color="red"> 낙찰 작품을 삼성카드로 결제하시면 결제금액의 1% 캐시백(일시불) <br/>&nbsp;&nbsp;&nbsp;&nbsp;또는 2-6개월 무이자 할부 혜택을 받으실 수 있습니다.</font>&nbsp;&nbsp;
        <a href="/noticeView?write_no=2629" target="_blank"><상세보기></a>
        <br/>&nbsp;&nbsp;&nbsp;&nbsp;8월에도 동일하게 적용됩니다.</td>
      </tr> -->
      <tr>
        <td >&nbsp;</td>
        <td ><table width="562" border="0" cellspacing="0" cellpadding="0" class="talbeBorder" >
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">결제 수단</td> 
            <td id="borderBottom" >
           		<input type="radio" name="selectType" value="CARD" onClick="javascript:chkPayType();" checked>[신용카드]
           		<!-- <input type="radio" name="selectType" value="VBANK" onClick="javascript:chkPayType();" >[가상계좌] -->
			</td>
          </tr>
          <tr>
			<td width="100" height="30" id="borderBottom" class="thead02" >결제타입</td>
			<td id="borderBottom" >
			  <input type="radio" name="TransTypeRadio" value="0" onClick="javascript:chkTransType('0')" checked>일반</input>
			</td>
		  </tr>
		  <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">* 경매명</td> 
            <td id="borderBottom" ><input name="GoodsName" type="text" value="${salesName }" style="width: 250px;" readonly/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">* 작가명</td> 
            <td id="borderBottom" ><input name="artistName" type="text" value="${artistName }" style="width: 200px;" readonly/></td>
          </tr>
		  <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">* 작품명</td> 
            <td id="borderBottom" ><input name="workName" type="text" value="${workTitle }" style="width: 200px;" readonly/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead02">* 상품가격</td> 
            <td id="borderBottom"><input name="Amt" type="text" value="<%=price%>" readonly="readonly"/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead02">* 구매자명</td> 
            <td id="borderBottom" ><input name="BuyerName" type="text" value="${name }"/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead01">* 구매자 이메일</td> 
            <td id="borderBottom" ><input name="BuyerEmail" type="text" value="${email }"/></td>
          </tr>
          <tr>
            <td width="100" height="30" id="borderBottom" class="thead02">* 구매자 전화번호</td> 
            <td id="borderBottom" ><input name="BuyerTel" type="text" value="${phone }"/></td>
          </tr>
          <tr style="display:none;">
            <td width="100" height="30" id="borderBottom" class="thead01">* 상점아이디</td> 
            <td id="borderBottom" ><input name="MID" type="text" value="<%=merchantID%>"/></td>
          </tr>
          <tr style="display:none;">
            <td width="100" height="30" id="borderBottom" class="thead01">*</td> 
            <td id="borderBottom" ><input name="lotId" type="text" value="${lotId }"/></td>
          </tr>
          <tr style="display:none;">
            <td width="100" height="30" id="borderBottom" class="thead01">*</td> 
            <td id="borderBottom" ><input name="salesPlanningId" type="text" value="${salesPlanningId }"/></td>
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
<!--       <tr> -->
<!--         <td></td> -->
<!--         <td class="comment">* 표 항목은 반드시 기입해주시기 바랍니다.<br><br/> -->
<!--         <span class="bold">테스트 아이디로 결제된 건에대해서는 당일 오후 11:30분에 일괄 취소됩니다.</span><br/> -->
<!--         실제아이디 적용시 테스트아이디가 적용되지 않도록 각별한 주의를 부탁드립니다. -->
<!--         </td> -->
<!--         <td>&nbsp;</td> -->
<!--       </tr> -->
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

<input type="hidden" name="from" value="${fromMore}" />
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" name="bid_price" value="${bid_price}" />

<input type="hidden" name="no_vat_price" value="${no_vat_price}" />
<input type="hidden" name="vat_price" value="${vat_price}" />
<input type="hidden" name="vat" value="${vat}" />


<input type="hidden" name="CharSet" value="utf-8"/>
<input type="hidden" name="ReturnURL" value="<%=request.getRequestURL().toString().replace(request.getRequestURI(),"")%>/customer/nicePurchaseResult"><!-- blueerr 2018.09.04 모바일에서 절대경로로 처리하여야 합니다. -->

<!-- 과세/면세 결제 처리 Amt(결제총액)은 입력박스에서 처리 -->
<input type="hidden" name="SupplyAmt" value="${vat_price}" /><!-- 공급가액(수수료에서 부가세뺀 금액 10/11) -->
<input type="hidden" name="GoodsVat" value="${vat}" /><!-- 부가가치세(수수료에서 부가세 1/11) -->
<input type="hidden" name="ServiceAmt" value="0" /><!-- 봉사료 -->
<input type="hidden" name="TaxFreeAmt" value="${no_vat_price}" /><!-- 낙찰금액(면세) -->
<input type="hidden" name="Moid" value=""/>
<input type="hidden" name="MallReserved" value="${uuid}"/>
</form>
</body>
</html>