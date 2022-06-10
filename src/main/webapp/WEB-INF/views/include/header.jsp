<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- head.jsp Begin -->
<!DOCTYPE html>
<html lang="ko" ng-app="myApp">
<head>
<meta name="naver-site-verification" content="e43736eddfc3d46038024a9d2132da077391aadf"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="UTF-8">
<title>서울옥션</title>
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1">    
    <meta name="description" content="미술품 경매를 통해 많은 사람들과 일상 속 예술의 경험과 기쁨을 나누고자 합니다.">
    <meta name="keywords" content="미술품,경매,작품,미술,근현대,고미술,와인,보석,구매,판매,위탁,경매회사,갤러리,케이옥션,K옥션,seoulauction,auction">
    <meta name="author" content="SeoulAuction">
    <meta name="Copyright" content="SeoulAuction" /> 
    <meta name="Claasification" content="회사소개, 미술품소개, 경매, 구매, 위탁" />       
    <meta property="og:type" content="website"> 
    <meta property="og:url" content="https://www.seoulauction.com">
    <meta property="og:title" content="SeoulAuction">
    <meta property="og:description" content="미술품 경매를 통해 많은 사람들과 일상 속 예술의 경험과 기쁨을 나누고자 합니다.">
    <meta property="og:image" content="https://www.seoulauction.com/nas_img/front/homepage/201508122329463497773394954126.jpg"/>        
    <meta property="al:web:url" content="https://www.seoulauction.com">

    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="/images/icon/favic/apple-touch-icon-57x57.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/icon/favic/apple-touch-icon-72x72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/icon/favic/apple-touch-icon-114x114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="120x120" href="/images/icon/favic/apple-touch-icon-120x120.png" />
    <link rel="apple-touch-icon-precomposed" sizes="152x152" href="/images/icon/favic/apple-touch-icon-152x152.png" />
    <link rel="icon" type="image/png" href="/images/icon/favic/favicon-32x32.png" sizes="32x32"/>
    <link rel="icon" type="image/png" href="/images/icon/favic/favicon-16x16.png" sizes="16x16"/> 
    <meta name="application-name" content="SeoulAuction" />
 
    <link href="<c:url value="/css/old/common.css?ver=20220610" />" rel="stylesheet">      
    <link href="<c:url value="/css/sa.common.2.0.css?ver=20210901" />" rel="stylesheet">    
    <link href="<c:url value="/css/sa.common.2.1.css?ver=20220318" />" rel="stylesheet">            
    <link type="text/css" href="/css/imgzoom/magnific-popup.css" rel="stylesheet"> 
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"><!-- 아트컨실팅 및 후원 기증 페이지 웹아이콘 -->
    
    <!-- <link href="<c:url value="/css/custom.css" />" rel="stylesheet"> -->
    <!--[if lt IE 9]>
        <link href="/css/ie8-and-down.css" rel="stylesheet">
    <![endif]-->
<!--     <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-sanitize.js"></script> -->
	<script type="text/javascript" src="/js/angular/angular.min.js"></script>
	<script src="/js/angular/angular-sanitize.js"></script>
    <!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/angular-i18n/1.4.9/angular-locale_ko-kr.min.js"></script> -->
    <script type="text/javascript" src="<c:url value="/js/angular/angular-bind-html-compile.js" />"></script>
    <script type="text/javascript" src="<c:url value="/js/angular/app.js?ver=20220415" />"></script>
    <script type="text/javascript" src="<c:url value="/js/common.js" />"></script>

<!--      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.js" ></script> -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.js" ></script> 
	<script type="text/javascript" src="/js/jquery.easing.1.3.js"></script> 
	<script type="text/javascript" src="/js/jquery.panzoom.min.js"></script>
	<script type="text/javascript" src="/js/jquery.slides.min.js"></script>
	<script type="text/javascript" src="/js/jquery.placeholder.min.js"></script>
	<!-- <script type="text/javascript" src="/js/old/jquery.selectbox-0.2.js"></script>-->
	<script type="text/javascript" src="/js/jquery.nicefileinput.min.js"></script>
	<script type="text/javascript" src="/js/jquery.mousewheel.min.js"></script>
	<script type="text/javascript" src="/js/jquery.mobile-events.js"></script> 
	<script type="text/javascript" src="/js/iscroll.js"></script>
	<script type="text/javascript" src="/js/old/ui.js"></script>
	<script type="text/javascript" src="/js/old/frontCommon.js"></script>
    <script type="text/javascript" src="/js/rightClick.js"></script> 
	<script type="text/javascript" src="/js/imgzoom/jquery.magnific-popup.min.js"></script> 
	<script type="application/ld+json">
	 {
		"@context": "http://schema.org",
		"@type": "Person",
		"name": "Seoul Auction",
		"url": "https://www.seoulauction.com",
		"sameAs": [
		    "https://www.facebook.com/seoulauction",
		    "https://www.instagram.com/seoulauction",
		    "https://blog.naver.com/s_auction",
		    "https://www.youtube.com/user/SeoulAuction"
		]
	 }
	 </script>
	<script>
	
    function setCookie(cName, cValue, cDay){
        var expire = new Date();
        expire.setDate(expire.getDate() + cDay);
        cookies = cName + '=' + escape(cValue) + '; path=/ ';
        if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
        document.cookie = cookies;
    }
    
    function getCookie(cName) {
        cName = cName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cName);
        var cValue = '';
        if(start != -1){
            start += cName.length;
            var end = cookieData.indexOf(';', start);
            if(end == -1)end = cookieData.length;
            cValue = cookieData.substring(start, end);
        }
        return unescape(cValue);
    }
    
    function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}

    $(".contents_wrap").hide();
	setCookie("prev_url", getCookie("curr_url"), 1);
	//console.log(" ===> prev_url " + getCookie("prev_url"));

    
	$(document).ready(function(){
	});

	window.onload = function(){
		$(".contents_wrap").show();
		setCookie("curr_url", "${pageContext.request.requestURI}", 1);
		//console.log(" ===> curr_url " + getCookie("curr_url"));
	}
	</script>
	
</head>
