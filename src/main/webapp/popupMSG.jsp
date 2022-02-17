


<!DOCTYPE html>
<html lang="ko" ng-app="myApp">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="UTF-8">
<title>서울옥션</title>
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">
<style>
#text{
    position: absolute;
    top: 50%;
    left: 50%;
    font-size: 40px;
    color: white;
    transform: translate(-50%,-50%);
    -ms-transform: translate(-50%,-50%);
}
#closebtn{
    position: absolute;
    top: 0;
    right: 10px;
    font-size: 60px;
    color: white;

}

#textbg{
    position: absolute;
    top: 50%;
    left: 50%;
    font-size: 38px;
    color: white;
    background-color:#1e3054;
    padding:30px;
    transform: translate(-50%,-50%);
    -ms-transform: translate(-50%,-50%);
}

</style>


</head>
<body>

<c:if test="${locale == 'ko'}">
    <div>
        <div id="textbg">ONLINE AUCTION<br/>
           <span style="font-size:16px; line-height:20px;">
			1. 서울옥션 홈페이지(www.seoulauction.com)에서 온라인 경매에 참여하실 수 있습니다.<br/>
            2. 모바일 앱에서는 응찰하기가 원활하지 않을 수 있습니다. <br/>
                                        모바일에서 응찰하실때는 모바일 전용 웹브라우저에서 "서울옥션"을 검색해서 응찰 부탁합니다.<br/>
            <a href="https://www.seoulauction.com"><p style="color:white; text-align:right">계속</p></a>
           </span>
        </div>
    </div>
</c:if>
<c:if test="${locale != 'ko'}">

</c:if>


<script>
//창닫기  
function closeWin(winName, expiredays) {   
   setCookie( winName, "done" , expiredays);   
   var obj = eval( "window." + winName );  
   obj.style.display = "none";  
}
</script>
</body>
</html>

