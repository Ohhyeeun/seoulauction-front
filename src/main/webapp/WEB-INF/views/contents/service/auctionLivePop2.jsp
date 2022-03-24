<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Seoul Auction LIVE</title>
	<meta name="viewport" content="width=device-width, user-scalable=no">
	<link rel="stylesheet" href="/css/old/common.css" />
	<!--  <link rel="stylesheet" href="/css/old/jquery.mCustomScrollbar.css" rel="stylesheet" /> -->
	<script type="text/javascript" src="/html/live/jquery/jquery-2.1.1.min.js"></script>
	<!--  <script type="text/javascript" src="/js/selectbox-min.js"></script> -->	
	<script type="text/javascript" src="/html/live/jquery/jquery.placeholder.min.js"></script>	
	<!--  <script type="text/javascript" src="/js/jquery.mCustomScrollbar.concat.min.js"></script> -->
	<script type="text/javascript" src="/html/live/jquery/ui.js"></script>	
</head>
<body>
	<div class="pop_wrap">
		<!--<button type="button" class="sp_btn btn_pop_close"><span class="hidden">닫기</span></button>-->
		<div class="title">
			<h2>생중계 보기</h2> 
		</div>
		<div class="cont">
			<div class="cont_title02">
				<h3>Seoul Auction LIVE</h3>
			</div>
	           <h4>제154회 서울옥션 미술품경매</h4>
	           <!-- <p>※ 현재 접속자가 많아 연결이 지연되고 있습니다. 잠시 후 다시 시도해주세요.</p> -->
				<p>AUCTION : 2019.12.18(水) 4:00 PM KST</p>
                <br/><br/>
			<div class="video_area">
				<!-- 기존 RED5스트리밍 방식 소스(2018.02.19이전. YDH)  
				<div class="web_only" align="center">
                    <iframe src="https://www.seoulauction.com/html/live/vod_popup.html" scrolling="no" width="720" height="500"  frameborder="0"/> 
					<object data="https://www.seoulauction.com/html/live/vod_popup.html" width="710" height="510"><param name="movie" value="https://www.seoulauction.com/html/live/vod_popup.html" /></object>
				</div>
				<div class="m_only">
					<video id="youtube1" > -->
						<!--<source src="https://seoulauction.com/html/vod_popup.html" type="video/youtube">-->
						<!--  생중계는 PC에서 보실 수 있습니다.<br/>
                        Live streaming can be viewed on your PC.
					</video>
				</div>
				-->
				<!-- 유투브 Live Streaming방식(2018.02.19. YDH)  
					src  뒤에 "?modestbranding=1&rel=0&autohide=0&showinfo=0&controls=1" 옵션줄것. 유투브표시 없애기/추천광고없애기등 표시 -->
				<div class="web_only" align="center">
					<iframe width="710" height="400" src="https://www.youtube.com/embed/4uEpp15KUTM?modestbranding=1&rel=0&autohide=0&showinfo=0&controls=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                    <p style="color: #999; font-size:11px; padding-top:35px;">재생오류 해결방법:Chrome, Edge, firefox 등 HTML5 지원 브라우저 사용 또는 브라우저 업그레이드<br/>자바스크립트를 모든 사이트에서 항상 실행을 하도록 하거나 캐시와 쿠키 삭제, 스피커 입력장치 연결을 확인해 주세요.</p>
				</div>
				<div class="m_only" align="center">
					<iframe width="310" height="180" src="https://www.youtube.com/embed/4uEpp15KUTM?modestbranding=1&rel=0&autohide=0&showinfo=0&controls=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                    <p style="color:#C00; font-size:10px; padding-top:20px;">* 3G/LTE 등으로 재생 시 데이터 사용료가 발생할 수 있습니다.</p>
				</div>
                <br/><br/>
			</div>
		</div>
	</div>
</body>
</html>