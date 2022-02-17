<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title>서울옥션 통합관리자시스템</title>
	<meta name="viewport" content="width=device-width, user-scalable=no">
	<link rel="stylesheet" href="/css/common.css" />
<!-- 	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script type="text/javascript" src="/js/jquery.panzoom.min.js"></script>
	<script type="text/javascript" src="/js/jquery.placeholder.min.js"></script>
	<script type="text/javascript" src="/js/jquery.selectbox-0.2.min.js"></script>
	<script type="text/javascript" src="/js/jquery.nicefileinput.min.js"></script>
	<script type="text/javascript" src="/js/jquery.modal.min.js"></script>
	<script type="text/javascript" src="/js/iscroll.js"></script>
	<script type="text/javascript" src="/js/ui.js"></script>
    <script type="text/javascript" src="/js/jquery.mousewheel.min.js"></script>
    
    <div class="pop_wrap masterview">
		<style type="text/css">
			.masterview, 
			.section, 
			.parent,
			.panzoom{position:absolute; left:0; top:0; width:100%; height:100%; text-align:center;}
			.zoom_buttons{position:absolute; bottom:30px; left:50%; height:28px; padding:0 40px; background:#000; border-radius:14px;}
			.zoom_buttons button{position:absolute; top:1px; width:24px; height:26px; background-repeat:no-repeat; background-position:0 0;}
			.zoom_buttons .zoom-in{right:10px; background-image:url(/images/btn/btn_zoom_in.gif);}
			.zoom_buttons .zoom-out{left:10px; background-image:url(/images/btn/btn_zoom_out.gif);}			
			input[type=range]{-webkit-appearance:none; background:none !important; margin-top:9px;}
			input[type=range]::-webkit-slider-runnable-track{width:300px; height:10px; background:#00c4c4; border:none; border-radius:5px;}
			input[type=range]::-webkit-slider-thumb{-webkit-appearance:none; border:none; height:16px; width:16px; border-radius:50%; background:#fff; margin-top:-3px;}
			input[type=range]:focus{outline:none;}
			input[type=range]:focus::-webkit-slider-runnable-track{background:#00c4c4;}
			input[type=range]{/* fix for FF unable to apply focus style bug  */  /*required for proper track sizing in FF*/width:300px;}
			input[type=range]::-moz-range-track{width:300px; height:10px; background:#00c4c4; border:none; border-radius:3px;}
			input[type=range]::-moz-range-thumb{border:none; height:16px; width:16px; border-radius:50%; background:#fff;}
			/*hide the outline behind the border*/
			input[type=range]:-moz-focusring{outline:1px solid white; outline-offset:-1px;}
			input[type=range]:focus::-moz-range-track{background:#00c4c4;}
			input[type=range]::-ms-track{width:300px; height:10px; /*remove bg colour from the track, we'll use ms-fill-lower and ms-fill-upper instead */background:transparent; /*leave room for the larger thumb to overflow with a transparent border */border-color:transparent; border-width:6px 0;
			/*remove default tick marks*/color:transparent; margin-top:0;}
			input[type=range]::-ms-fill-lower{background:#00c4c4; border-radius:10px;}
			input[type=range]::-ms-fill-upper{background:#00c4c4; border-radius:10px;}
			input[type=range]::-ms-thumb{border:none; height:16px; width:16px; border-radius:50%; background:#fff;}
			input[type=range]:focus::-ms-fill-lower{background:#00c4c4;}
			input[type=range]:focus::-ms-fill-upper{background:#00c4c4;}
			@media screen and (min-width:0\0) and (min-resolution:+72dpi){
				input[type=range]{margin-top:-15px;}
			 }
		</style>
		<div class="section">
			<div class="parent">
				<div class="panzoom">
					<img oncontextmenu="return false" id="workDetailImage" src="" />
				</div>
			</div>
			<div class="zoom_buttons"><button class="zoom-out"><span class="hidden">Zoom Out</span></button><button class="zoom-in"><span class="hidden">Zoom In</span></button><input type="range" class="zoom-range"><!-- <button class="reset">Reset</button> -->
			</div>
		</div>
		<button type="button" class="sp_btn btn_pop_close"><span class="hidden">닫기</span></button>
	</div>
</body>
</html>