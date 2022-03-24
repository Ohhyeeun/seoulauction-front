<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title>VIDEO</title>
	<meta name="viewport" content="width=device-width, user-scalable=no">
	<link rel="stylesheet" href="/css/old/common.css" />
	<!--  <link rel="stylesheet" href="/css/old/jquery.mCustomScrollbar.css" rel="stylesheet" /> -->
	<script type="text/javascript" src="/html/live/jquery/jquery-2.1.1.min.js"></script>
	<!--  <script type="text/javascript" src="/js/selectbox-min.js"></script> -->	
	<script type="text/javascript" src="/html/live/jquery/jquery.placeholder.min.js"></script>	
	<!--  <script type="text/javascript" src="/js/jquery.mCustomScrollbar.concat.min.js"></script> -->
	<script type="text/javascript" src="/html/live/jquery/ui.js"></script>	
	<style>
		video::-internal-media-controls-download-button {
		    display:none;
		}
		
		video::-webkit-media-controls-enclosure {
		    overflow:hidden;
		}
		
		video::-webkit-media-controls-panel {
		    width: calc(100% + 30px); /* Adjust as needed */
		}
	</style>
</head>
<body>
	<div class="pop_wrap">
		<!--<button type="button" class="sp_btn btn_pop_close"><span class="hidden">닫기</span></button>-->
		<div class="title">
			<h2>VIDEO</h2>
		</div> 
		<div class="cont">
			<div class="cont_title02"> 
				<h3>Seoul Auction VIDEO</h3>
			</div> 
	           <h4>23rd HONG KONG SALE</h4>
				<p>Auction : (Sun) 26 November 2017 4pm(HKT)<br/>Hong Kong Grand Hyatt, Mezzanine Level, Salon<br/><br/></p>
               <!--<p>(Sunday)27.11.2016 6PM HKT Hong Kong Grand Hyatt, Mezzanine Level (Salon)</p>-->
			<div class="video_area"  oncontextmenu="return false" ondragstart="return false"> 
				<!--<div class="web_only" align="center">
                <iframe src="https://www.seoulauction.com/html/live/vod_popup.html" scrolling="no" width="720" height="500"  frameborder="0"/> 
					<object data="https://www.seoulauction.com/html/live/vod_popup.html" width="710" height="510"><param name="movie" value="../../service/www.seoulauction.com/html/live/vod_popup.html" /></object>
				</div>
				<div class="m_only">
					<video id="youtube1" > -->
						<!--<source src="http://old-hp.seoulauction.com/html/vod_popup.html" type="video/youtube">-->
                       <!--	Live streaming is available on PC.
					</video>
				</div> -->
				
				<video src="https://www.seoulauction.com/nas_img/front/homepage/23rd_video.mp4" controls width="480" height="270" autoplay>
				<p><br/><br/>Some browsers do not support newer video formats or quality options. <br/>We recommend upgrading your browser or operating system for the best viewing experience.<br/>Below are some browser and operating system combinations that support video formats:<br/>•Google Chrome (all operating systems)<br/>
•MS Edge <br/>
•Safari on Mac OS X 10.10 or newer<br/>
•Firefox on Windows 7 or newer and on Mac OS X 10.10 or newer<br/>•with HTML5<br/><br/></p>
				</video>
			</div>
		</div>
	</div>
</body>
</html>