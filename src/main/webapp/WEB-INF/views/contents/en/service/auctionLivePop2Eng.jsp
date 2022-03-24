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
			<h2>Auction LIVE</h2>
		</div> 
		<div class="cont">
			<div class="cont_title02"> 
				<h3>Seoul Auction LIVE</h3>
			</div> 
	           <h4>154th ART AUCTION</h4> 
				<p>AUCTION : (wed) 18 dec, 2019 4:00 pm KST</p>
                <br/><br/>
               <!--<p>(Sunday)27.11.2016 6PM HKT Hong Kong Grand Hyatt, Mezzanine Level (Salon)</p>-->
			<!--<div class="video_area"> 
				<div class="web_only" align="center">
                <iframe src="https://www.seoulauction.com/html/live/vod_popup.html" scrolling="no" width="720" height="500"  frameborder="0"/> 
					<object data="https://www.seoulauction.com/html/live/vod_popup.html" width="710" height="510"><param name="movie" value="../../service/www.seoulauction.com/html/live/vod_popup.html" /></object>
				</div>
				<div class="m_only">
					<video id="youtube1" >
                       	Live streaming is available on PC.
					</video>
				</div>-->
                
                <!-- 유투브 Live Streaming방식(2018.02.19. YDH)   
					src  뒤에 "?modestbranding=1&rel=0&autohide=0&showinfo=0&controls=1" 옵션줄것. 유투브표시 없애기/추천광고없애기등 표시 -->
				<div class="web_only" align="center">
					<iframe width="710" height="400" src="https://www.youtube.com/embed/4uEpp15KUTM?modestbranding=1&rel=0&autohide=0&showinfo=0&controls=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
				</div>
				<div class="m_only" align="center">
                  
					<iframe width="310" height="180" src="https://www.youtube.com/embed/4uEpp15KUTM?modestbranding=1&rel=0&autohide=0&showinfo=0&controls=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe> 
			</div>
		</div>
	</div>
</body>
</html>