<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
	<title>Mobile Re-Direction</title>

	<script type="text/javascript">
	   function setCookie(cName, cValue, cDay){
	        var expire = new Date();
	        expire.setDate(expire.getDate() + cDay);
	        cookies = cName + '=' + escape(cValue) + '; path=/ ';
	        if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
	        document.cookie = cookies;
	   }
	   
		//모바일에서 결제막기 위해 쿠키생성 - blueerr
	   setCookie('mobileFlag', 'mobile', 1);
		 	 
	   window.onload = function(){
			
			// 모바일 앱에서 버전으로 링크거는 방법이 아닌 호출하는 url에서 Re-Direction 처리함.
			// 기본적으로 홈페이지 링크. 경매가 있을경우 경매 사이트로 바로 링크처리.		
			location.href = 'https://www.seoulauction.com';	
			//location.href = 'popupMSG.jsp';
			
			// 경매가 있을경우 경매 사이트로 바로 링크처리.
			//location.href = 'http://www.seoulauction.com/servlet/auction/upcomingArtworkList?acode=MA013536';
		}
	</script>
</head>
<body>
	
</body>
</html>
