<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- head.jsp Begin --> 
<!doctype html>
	<html>
	<head>
	<title>Limelight RTSv2 Simple Subscriber Example</title>
	<!-- Expose 'llnwrtssdk' on the window global to reference in your 'subscribe' script -->
	<script type="text/javascript" src="https://llrtsprod.s.llnwi.net/v1/sdk/html/current/llnwrtssdk.min.js"></script>
	<!-- Recommended shim for cross-browser WebRTC support. -->
	<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>

	</head>
	<body>
	<video id="llnw-rts-subscriber" width="640" height="480" autoplay controls muted>
	</video>
	
	<!-- Example script below. -->
	<script src="/js/simple.js"></script>

	
	</body>
	</html>
