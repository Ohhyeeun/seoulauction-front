<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- head.jsp Begin --> 
<!DOCTYPE html>
<html lang="ko" ng-app="myApp">   
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale = 1, maximum-scale = 1, user-scalable=no" http-equiv="X-UA-Compatible" content="IE=Edge">     
	<meta charset="UTF-8">
	<title>서울옥션</title>
	
	<link rel="apple-touch-icon-precomposed" sizes="57x57" href="/images/icon/favic/apple-touch-icon-57x57.png" />
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/icon/favic/apple-touch-icon-72x72.png" />
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/icon/favic/apple-touch-icon-114x114.png" />
	<link rel="apple-touch-icon-precomposed" sizes="120x120" href="/images/icon/favic/apple-touch-icon-120x120.png" />
	<link rel="apple-touch-icon-precomposed" sizes="152x152" href="/images/icon/favic/apple-touch-icon-152x152.png" />
	<link rel="icon" type="image/png" href="/images/icon/favic/favicon-32x32.png" sizes="32x32"/>
	<link rel="icon" type="image/png" href="/images/icon/favic/favicon-16x16.png" sizes="16x16"/>
	<meta name="application-name" content="SeoulAuction" />
	
	<link href="<c:url value="/resources/css/old/common.css?${resources.timestamp}" />" rel="stylesheet">  
	<link href="<c:url value="/css/old/onepcssgrid_live.css" />" rel="stylesheet"> 
	<link href="<c:url value="/resources/css/sa.common.2.0.css?${resources.timestamp}" />" rel="stylesheet">  
	<link href="<c:url value="/resources/css/bidLivepop.css?${resources.timestamp}" />" rel="stylesheet">     
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	
	<script type="text/javascript" src="/resources/js/angular/angular.min.js"></script>
	<script src="/resources/js/angular/angular-sanitize.js"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/angular/angular-bind-html-compile.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/angular/app.js?${resources.timestamp}" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/common.js?${resources.timestamp}" />"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.js" ></script>
	<script type="text/javascript" src="/resources/js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.panzoom.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.slides.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.placeholder.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.nicefileinput.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.mousewheel.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.mobile-events.js"></script>
	<script type="text/javascript" src="/resources/js/iscroll.js"></script>
	<script type="text/javascript" src="/resources/js/old/ui.js?${resources.timestamp}"></script>
	<script type="text/javascript" src="/resources/js/old/frontCommon.js"></script>  
</head> 

<%-- YDH 추가 시작--%>
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<!-- Expose 'llnwrtssdk' on the window global to reference in your 'subscribe' script -->
<script type="text/javascript" src="https://llrtsprod.s.llnwi.net/v1/sdk/html/current/llnwrtssdk.min.js"></script>
<!-- Recommended shim for cross-browser WebRTC support. -->
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>

<%
	String sale_no = request.getParameter("sale_no");
%>

<script>
	app.value('locale', 'ko');
	app.value('is_login', 'false');
	app.value('_csrf', '${_csrf.token}');
	app.value('_csrf_header', '${_csrf.headerName}');	// default header name is X-CSRF-TOKEN

	$(document).ready(function(){
		$("#cancelBtn").click(function(){ 
			self.opener = self;
			window.close();
		});  
	}); 
	
	app.controller('liveAuctionCtl', function($scope, consts, common, $interval) {
		$scope.sale_no = <%=sale_no%>;
		
		$scope.loadLiveAuction = function(){
			$d = {"baseParms":{"sale_no":$scope.sale_no, "lot_no":$scope.lot_no, "mid_lot_no":$scope.mid_lot_no},
					"actionList":[
					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
				]};	 	   	
			common.callActionSet($d, $s);
		}
	 		
		var $s = function(data, status) { 
			$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
		}
		
		$scope.goLoginPage = function(){
			alert('로그인 해주시기 바랍니다.');
			location.href = "/login";
		}
	});
</script> 

<body>    
	<div class="pop_wrap" ng-controller="liveAuctionCtl" data-ng-init="init()">    
		<div class="title bidlive_header">      
			<div class="client_onepcssgrid-1200 clearfix" style="padding: 0; height: 45px;">     
				<div class="bidlive_titbox">   
					<h2><a href="/" style="color: #fff;" title="홈으로" target="_blank">Seoul Auction LIVE</a></h2>      
				</div>
				<!-- //언어 메뉴 language --> 
				<div class="bidlive_utilitybox">       
					<ul>
						<!-- 로그아웃 버튼 -->   
						<c:if test="${is_login}">
							<li>
								<c:if test="${is_login}"> 
									<form action="/processLogout" method="post" id="logoutForm">
									  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>     
								</c:if>   
								<a href="javascript:document.getElementById('logoutForm').submit();">LOGOUT</a> 
							</li>
						</c:if>
						<!-- 로그인 버튼 -->    
						<c:if test="${!is_login}">   
							<li><a href="/login">LOGIN</a></li>     
						</c:if>       
						<c:set var="queryString" value="${pageContext.request.queryString}" />
						<c:if test="${not empty param.lang}"> 
		           		 	<c:set var="langParam" value="&lang=${param.lang}" />
		           		 	<c:set var="queryString" value="${fn:replace(queryString,langParam, '')}" />
		           		 	<c:set var="langParam" value="lang=${param.lang}" /> 
		            		<c:set var="queryString" value="${fn:replace(queryString,langParam, '')}" />
		           		</c:if> 
		           		<c:if test="${not empty queryString}"> 
		           			<c:set var="queryString" value="?${queryString}&" />
		           		</c:if> 
		           		<c:if test="${ empty queryString}"> 
		           			<c:set var="queryString" value="?" />
		           		</c:if>
		           		<c:choose>   
							<c:when test="${is_login}"> <!-- 로그인시 --> 
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${is_korean}"> --%>
										<li ng-if="locale == 'ko'" class="util_box_lang"><a href="${queryString}lang=en" style="color:#fff;">ENG</a></li>
<%-- 									</c:when> --%>
<%-- 									<c:otherwise>  --%> 
										<li ng-if="locale != 'ko'" class="util_box_lang"><a href="${queryString}lang=ko" style="color:#fff;">KOR</a></li>	
<%-- 									</c:otherwise>  --%>
<%-- 								</c:choose>   --%>
							</c:when>
							<c:otherwise>  
<%-- 								<c:choose>   --%>
<%-- 									<c:when test="${is_korean}"><!-- 비로그인시 -->  --%>
										<li ng-if="locale == 'ko'" class="util_box_lang"><a href="${queryString}lang=en" style="color:#fff;">ENG</a></li> 
<%-- 									</c:when> --%> 
<%-- 									<c:otherwise>    --%>
										<li ng-if="locale != 'ko'"class="util_box_lang"><a href="${queryString}lang=ko" style="color:#fff;">KOR</a></li> 	
<%-- 									</c:otherwise>  --%>
<%-- 								</c:choose>   --%>
							</c:otherwise>
						</c:choose>     
					</ul>    
				</div>     
			</div> 
		</div> <!-- //title -->  
        
		<div ng-controller="liveAuctionCtl" data-ng-init="loadLiveAuction()" style="position: relative; top:50px;">    
			<div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 100%; height: 100%;"><!-- 경매 진행중인 경우 -->  
	            <!--main -->   
				<div class="client_onepcssgrid-1200 clearfix">
					<!--web_only-->       
					<div class="clearfix">
						<div class="bidlive_video_all_box">  
							<div style="text-align: right; padding: 10px 0; font-weight: bold; font-size:12px;">            
								<a onClick="window.location.reload()" style="cursor:pointer; color: #444; font-size: 12px;">              
									<i class="material-icons" style="vertical-align:middle; font-size: 16px; font-weight: bold; color: #444;">     
										refresh   
									</i>      
									동영상 새로고침     
								</a>
							</div>     
							      
							<div class="bidlive_video bidlive_video_all">      
								<video id="llnw-rts-subscriber" width="640" height="480" autoplay controls playsinline muted></video>
								<!-- 영상 준비 & 종료 이미지 문구-->      
								<!-- <div class="video_stopbox">         
									<img src="/images/img/img_video.jpg" alt="경매 시작&종료 이미지." width="100%" height="100%"/>    
									영상 준비 
									<div class="video_ready">        
										<div class="video_icon"></div>  
										<p style="padding-bottom: 7px;">경매 준비 중입니다. 경매가 곧 시작 됩니다.</p>       
										<p>The auction is starting soon.</p>            
									</div>
									영상 종료   
									<div class="video_stop" style="display: none;">     
										<div class="video_icon"></div>
										<p style="padding-bottom: 7px;">경매가 종료 되었습니다. 감사합니다.</p>    
										<p>Thank you!</p>      
									</div> 
								</div> -->    
							</div> <!-- //bidlive_video -->   
                            
							<div class="re-flash_all">        
                            	<div style="overflow: hidden; padding: 10px 0; text-align: center;">    
                                    <span class="notice_style01"></span>          
                                    <span style="font-weight: bold; vertical-align:top;">동영상 시청은 <span style="color: #f30;">크롬, 엣지</span>에서만 시청이 가능합니다. 익스플로러는 재생이 되지 않습니다.</span> 
                                </div>   
							</div> <!-- 새로고침 -->    
							
							<!-- 담당자 문의 번호 -->   
							<div style="padding: 5px;">    
								<p style="text-align:right; font-size: 12px;">문의 : IT팀 관리자 / T.010-2617-3265</p>
							</div> 
						</div> <!-- //video -->    
						
						<!-- 응찰 버튼 (고객용) --> 	 
						<div class="bidlive_all_btnbox clearfix">  
							<span class="bidlive_all_btn">   
								<span ng-if="!custInfo.CUST_NO" ng-Click="goLoginPage()">   
									<a>   
										응찰하기    
									</a>   	 
							  	</span>  
								<span ng-if="custInfo.MEMBERSHIP_YN == 'N'" onClick="alert('정회원만 응찰 가능합니다.')">   
									<a>   
										응찰하기    
									</a>   	
							  	</span>  
							  	<span ng-if="custInfo.MEMBERSHIP_YN == 'Y'">          
									<a href="/service/page?view=bidLive_memberNew&sale_no={{sale_no}}">                
										응찰하기    
									</a>   	
							  	</span>   
							</span>
						</div>
					</div>
				</div><!-- // 1200 -->
				
				<div class="btn_wrap" style="margin-bottom: 10px;"> 
					<span class="btn_style01 gray mid btn_pop_close" id="cancelBtn"> 
						<button type="button"><spring:message code="label.close" /></button>
					</span> 
				</div>  	   
				 
				<!--footer-->    
				<div style="background-color:#f1f1f1; padding:20px 10px;">    	 
					<div align="center">
						<!-- 담당자 문의 번호 -->       
						<div class="livebid_quirytelbox">                    
							<span>                  
								<a href="tel:010-2617-3265"><span class="manager_tit">기술문의</span> T. 010-2617-3265 (IT팀관리자)</a>       
							</span>           
							<span>     
								<a href="tel:010-3404-4565"><span class="manager_tit">응찰문의</span> T. 010-3404-4565 (고객관리자)</a>        
							</span> 
						</div>   
						<p style="color: #000; font-size:11px; line-height:18px;">      
		    				* LOT정보와 Current Bidding은 네트워크 속도에 따라 지연될 수 있습니다. 
						</p> 
					</div> 
				</div><!--footer-->      
			</div>
		</div>
	</div> <!--pop_wrap-->  
</body>  
<script src="/resources/js/simple_test.js?${resources.timestamp}"></script>
</html> 