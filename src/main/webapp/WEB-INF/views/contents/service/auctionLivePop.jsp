<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>



<link rel="stylesheet" href="/css/old/common.css" />
<script type="text/javascript" src="/js/live/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="/js/selectbox-min.js"></script>	
	<script type="text/javascript" src="/js/jquery.placeholder.min.js"></script>	
	<script type="text/javascript" src="/js/jquery.mCustomScrollbar.concat.min.js"></script>
	<script type="text/javascript" src="/js/ui.js"></script> 

<div class="pop_wrap pop11">
		<button type="button"><span class="hidden">닫기</span></button>
		<div class="title">
			<h2>생중계 보기</h2>
		</div>
		<div class="cont">
			<div class="cont_title02">
				<h3>Seoul Auction LIVE</h3>
			</div>
	
			<div class="video_area"> 
				<div class="web_only" align="center">
                <iframe src="https://www.seoulauction.com/html/live/vod_popup.html" scrolling="no" width="720" height="500"  frameborder="0"/> 
					<!--<object data="https://www.seoulauction.com/html/live/vod_popup.html" width="640" height="390"><param name="movie" value="https://www.seoulauction.com/html/live/vod_popup.html" /></object>-->
				</div>
				<div class="m_only">
                        생중계는 PC에서 보실 수 있습니다.
				</div>
			</div>
		</div>
	</div>