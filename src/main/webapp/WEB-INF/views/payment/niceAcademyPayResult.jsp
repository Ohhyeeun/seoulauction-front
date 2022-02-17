<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>NICEPAY :: 결제 요청 결과</title>
<link rel="stylesheet" href="/css/basic.css" type="text/css" />
<link rel="stylesheet" href="/css/style.css" type="text/css" />
</head>
<body>
<script>

var bIsSucceed = ${paySuccess};
var sPayMethod = "${payMethod}";
var tid = "${tid}"
if(bIsSucceed) {
	if(sPayMethod == "VBANK"){
		alert("결제에 성공했습니다.\n입금계좌정보는 문자로 발송됩니다.");
	}else{
		alert("결제에 성공했습니다.");	
		
		function printReceipt(tid) {
			 var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
			 var url = "https://pg.nicepay.co.kr/issue/IssueLoader.jsp?TID="+tid+"&type=0";
			 window.open(url,"popupIssue",status);
			}
			printReceipt(tid);
	}
	
	opener.location.href="../service/page?view=academyCulture";
	self.close();
}
else {
	alert("결제에 실패했습니다.\n관리자에게 문의하세요.");
	window.opener.location.reload(true);
	self.close();
}

</script>
</body>
</html>