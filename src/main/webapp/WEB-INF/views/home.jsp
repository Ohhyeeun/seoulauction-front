<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="include/header.jsp" flush="false"/>
<!-- PC용 커튼 배너 호출. YDH  
>--> 
<!-- PC용 커튼 배너 호출 . YDH -->   
<link href="/resources/css/angular/ng-animation.css" rel="stylesheet">

<!--  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-animate.min.js"></script>-->
<script type="text/javascript" src="/resources/js/angular/angular-animate.min.js"></script>

<script>
var screenType = "P";
$(document).ready(function() {
	sessionStorage.removeItem("scroll_loc");
	
	var winWidth = $(window).innerWidth();
	if(winWidth < 768) {
		location.href = "/?screenType=M";
	}
});

$(window).resize(function() {
	var winWidth = $(window).innerWidth();
	if(winWidth > 768) {
		location.href = "/?screenType=M";
	}
});
  

var m_aPopImages = new Array();


app.requires.push.apply(app.requires, ["ngAnimate"]);

app.controller('bannerListCtl', function($scope, consts, common) {
	$scope.ani_effect = "slide-down";
	
	$scope.loadBannerList = function(){
 		$d = {"baseParms":{"bann_id":"main"}, 
 			  "actionList":[
 				{"actionID":"banner_list", "actionType":"select" , "tableName": "BANNERS"},
 				{"actionID":"banner_image_list", "actionType":"select" , "tableName": "IMAGES"}
 			 ]};

 	   	common.callActionSet($d, $s);
	}
 		
 	var $s = function(data, status) {
 		$scope.bannerList = data["tables"]["BANNERS"]["rows"];
 		$scope.imageList = data["tables"]["IMAGES"]["rows"];
		$scope.banner = 1;			
		$scope.banner_sub = 1;
	};

 	$scope.setBannerArticle = function($n){
 		if($n < 1){
 			
 		}else if($n > $scope.bannerList.length){
 			
 		}else{
 			if($scope.banner < $n){
 				$scope.ani_effect = "slide-up"
 			}else{
 				$scope.ani_effect = "slide-down"
 			}

			$scope.banner = $n
			$scope.banner_sub = 1;
		}
 	}
 		
	$scope.setBannerArticleSub = function($n){
		if($scope.banner_sub < $n){
			$scope.ani_effect = "slide-left"
		}else{
			$scope.ani_effect = "slide-right"
		}

		$scope.banner_sub = $n;
 	}
});

/*$(window).on('load', function(){
	if(screenType == "M"){
		$("body").removeClass("main");
	}
	else{
		$("body").addClass("main");
	}
});
*/

</script>

 
<body class="main">   <!--onLoad="on();"-->
<jsp:include page="include/topSearch.jsp" flush="false"/>
<div class="loading"><div></div></div>

<div id="wrap" style="overflow:hidden;">
<jsp:include page="include/topMenu.jsp" flush="false"/>
<div class="container_wrap">
	<!--<div class="shadow left"><span class="corner"></span></div>
	<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
	<div class="main_bot left"></div>
	<div class="main_bot right"></div>-->
	

<%-- 	<c:if test="${locale == 'ko'}"> --%>
		<jsp:include page="./inc_home_slide.jsp" flush="false" />
<%-- 	</c:if> --%>
<%-- 	<c:if test="${locale == 'en'}"> --%>
<%-- 		<jsp:include page="./inc_home_slide_en.jsp" flush="false" /> --%>
<%-- 	</c:if> --%>

	
	<div class="main_btn_updown">
		<button class="scroll_up" style="display: inline-block;"><span class="hidden">위로</span></button>
		<button class="scroll_dn" style="display: inline-block;"><span class="hidden">아래로</span></button>
        <button class="scroll_stop" onClick="clearInterval(pageTimer)" style="display: inline-block;"><span class="hidden">일시정지</span></button>
        <button class="scroll_play" onClick="setInterval(setTimeout('mainBanner()',1000))" style="display: inline-block;"><span class="hidden">롤링</span></button> 
	</div>   
	<div class="blockUi"></div>
	<script type="text/javascript">
		var secNum = 1;
		var winW    = $(window).width();
		var winH    = $(window).height();
	
		var isMobile = {
			Android: function() {
				return navigator.userAgent.match(/Android/i);
			},
			BlackBerry: function() {
				return navigator.userAgent.match(/BlackBerry/i);
			},
			iOS: function() {
				return navigator.userAgent.match(/iPhone|iPad|iPod/i);
			},
			Opera: function() {
				return navigator.userAgent.match(/Opera Mini/i);
			},
			Windows: function() {
				return navigator.userAgent.match(/IEMobile/i);
			},
			any: function() {
				return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
			}
		};
		
		function showPopup(nIndex) {
			$("#pop" + nIndex).css("z-index", 1);
			$("#pop" + nIndex).fadeIn("fast");
			clearInterval(pageTimer);//20150721
		}
		function closePopup(nIndex) {
			$("#pop" + nIndex).fadeOut();
			$("#pop" + nIndex).css("z-index", 0);
			setInterval(setTimeout('mainBanner()',5000));//20150721
		}
		
// 		imgMResize();
	
		$(window).resize(function(){
			//$(".loading").fadeIn("fast");
			//location.reload();
			
			//var winWidth = $(window).innerWidth();
			//if(winWidth < 768) {
			//	location.href = "/"; 
			//} 
			
// 			imgMResize();
			
			$('.roll ul').css('left', '0');
			$(".roll ul").each(function(){
				var rollWidth = $(this).children('li').length * $(window).width();
				$(this).css('width', rollWidth);
			});
			$('.thum li').removeClass('selected');
			$('.thum li:first-child').addClass('selected');
			
			var nTotalCount = isNaN(8) ? 0 : 8;
			for(var i=0; i<nTotalCount; i++) {
				$(".roll_box" + (i+1)).slideFunc();
			}
			
			for(var i=0; i<m_aPopImages.length; i++) {
				$(".roll_boxp" + m_aPopImages[i]).slideFunc();
			}
			
			/*
			$(".roll_box").slideFunc();
			$(".roll_box2").slideFunc();
			$(".roll_box3").slideFunc();
			*/
			/*$('.sec').css({'display':'none', 'top':'0px'});
			$('.sec1').css('display','block');
			init();*/

		});
	
		$(window).load(function(){
		/* 	// 오피스 입력 연동 작업으로 slideCtl에서 처리
		
			// 이미지 사이즈 조절을 위해 display:block으로 설정
			$(".sec, .pop").css("display", "block");	

			imgMResize();

			$(".sec1, .sec2, .sec3, .sec4, .sec5, .pop").css("display", "none");
			$(".loading").fadeOut("slow");
			$(".sec1, .main_frame_top, .main_frame_middle, .main_frame_bottom, .sec1_cont, .scroll_dn").fadeIn("fast");  
		*/
		});
		
		/*//오피스 입력 연동 작업으로 slideCtl에서 처리
		function imgMResize(){
			var winW    = $(window).width();
			var winH    = $(window).height();
			var mainContH = winH - 0;

			$('.main .container_wrap').css('height', mainContH + 'px');
		
			// 이미지 사이즈 변경
			$(".roll, .roll li, .sec").css({
				"width":winW,
				"height":winH,
				"overflow":"hidden"
			});

			var divs = $('.sec, .roll li, .thum li');

			divs.each(function(){
				var divAspect = this.offsetHeight / this.offsetWidth;
				this.style.overflow = 'hidden';

				var img = this.querySelector('img');
				
				if(img) {
					var imgAspect = img.height / img.width ;
					
					if (imgAspect <= divAspect) {
					  // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
					  var imgWidthActual = this.offsetHeight / imgAspect;
					  var imgWidthToBe = this.offsetHeight / divAspect;
					  var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
					  img.style.cssText = 'width: auto; height: 100%; margin-left: '
									  + marginLeft + 'px;'
					} else if(imgAspect > divAspect) {
					  // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
					  img.style.cssText = 'width: 100%; height: auto; margin-left: 0;';
					}
				}
			});
		}
	 */
	
		$(window).ready(function(){
			var winHeight = $(window).height();
			var mainContH = winHeight - 0;
			$('.main .container_wrap').css('height', mainContH + 'px');
	
			// 위 아래로 이동
			$(".scroll_up").on("click", function(){
					secNum--;
					imgMove2(secNum);
					$('.cont_list li').removeClass('sele');
					$('.cont_list li:nth-child(' + secNum + ')').addClass('sele');
			});
			$(".scroll_dn").on("click", function(){
					imgMove(secNum);
					secNum++;
					$('.cont_list li').removeClass('sele');
					$('.cont_list li:nth-child(' + secNum + ')').addClass('sele');
			});
	
			$(".scroll_up, .scroll_dn, .scroll_stop, .scroll_play").hover(function(){
				$(this).addClass('hover');
			}, function(){
				$(this).removeClass('hover');
			}); 
	
			/* 20150625 */
			if( isMobile.any() ){
				$('.sec').bind('swipeup', function(){
					if(secNum == $(".sec").length){
						
					} else {
						imgMove(secNum);
						secNum++;
						$('.cont_list li').removeClass('sele');
						$('.cont_list li:nth-child(' + secNum + ')').addClass('sele');
					}
				});
				
				$('.sec').bind('swipedown', function(){
					if(secNum == 1){
						
					} else {
						secNum--;
						imgMove2(secNum);
						$('.cont_list li').removeClass('sele');
						$('.cont_list li:nth-child(' + secNum + ')').addClass('sele');
					}
				});
			}
			/* //20150625 */
			
			/* 오피스 입력 연동 작업으로 slideCtl에서 처리
			var nTotalCount = isNaN(8) ? 0 : 8;
			for(var i=0; i<nTotalCount; i++) {
				$(".roll_box" + (i+1)).slideFunc();
			}	
			*/
			
			for(var i=0; i<m_aPopImages.length; i++) {
				$(".roll_boxp" + m_aPopImages[i]).slideFunc();
			} 
			
			var wheelAmount = 0; 
			$(window).bind(function(event) /*('mousewheel', function(event)*/ {
				var secLength = $(".sec").length;
				if(event.deltaY < 0){
					wheelAmount--;
					if(wheelAmount < -secLength){
						wheelAmount = 0;
						
						if(secNum > secLength-1){
							secNum = secLength;
						}else{
							imgMove(secNum);
							secNum++;
						}
					}
					$('.cont_list li').removeClass('sele');
					$('.cont_list li:nth-child(' + secNum + ')').addClass('sele');
				}else{
					wheelAmount++;
					if(wheelAmount > secLength){
						wheelAmount = 0;
						if(secNum < 2){
							secNum = 1;
						}else{
							secNum--;
							imgMove2(secNum);
							
						}
					}
					$('.cont_list li').removeClass('sele');
					$('.cont_list li:nth-child(' + secNum + ')').addClass('sele');
				}
			});
	
			init();
		});
	
		$(document).keydown(function(e){
			switch(e.keyCode){
				case 38: {
					if(secNum == 1){
						secNum = 1;
					}else{
						secNum--;
						imgMove2(secNum);
					}
					break;
				}
				case 40 : {
					if(secNum == $(".sec").length){
						secNum = $(".sec").length;
					}else{
						imgMove(secNum);
						secNum++;
					}
					break;
				}
			}
		});
	
		function init(){
			$(".sec .cont_tit").css("margin-top", "100px");
			$(".sec .cont_text").css("margin-top", "100px");
			$(".sec .cont_artist").css("bottom", "100px");
			$(".sec .thum").css("bottom", "100px");
			$(".cont_list").css("bottom", "100px");
	
			$(".sec1 .cont_tit").stop().animate({'margin-top':'0'}, {duration:1000, easing:"easeInOutQuint"});
			$(".sec1 .cont_text").stop().animate({'margin-top':'0'}, {duration:1000, easing:"easeInOutQuint"});
			$(".sec1 .cont_artist").stop().animate({'bottom':'73px'}, {duration:1000, easing:"easeInOutQuint"});
			$(".sec1 .thum").stop().animate({'bottom':'67px'}, {duration:1000, easing:"easeInOutQuint"});
			$(".cont_list").stop().animate({'bottom':'100px'}, {duration:1000, easing:"easeInOutQuint"});// 20150621
		}
	
		//20150721
		function mainBanner(){
			var secLength = $(".sec").length;

			if(secNum >= secLength) {
				for(var i=2; i<=secLength; i++){
					$(".sec"+i).css("visibility", "hidden");
				}
				$(".pop").css("visibility", "hidden");
				$(".scroll_up").fadeOut();
				$(".scroll_dn").fadeIn();
				$(".sec").css('top', '0');
				$('.cont_list li').removeClass('sele');
				$('.cont_list li:first-child').addClass('sele');
				init();
				secNum = 1;
			} else {
				imgMove(secNum);
				secNum++;
				$('.cont_list li').removeClass('sele');
				$('.cont_list li:nth-child(' + secNum + ')').addClass('sele');
			}
			clearTimeout(pageTimer);
			pageTimer = setTimeout('mainBanner()',15000);  // 9000 => 15000 Delay Time 변경(YDH. 2015.11.14)
		} 
		pageTimer = setTimeout('mainBanner()',15000);      // 9000 => 15000 Delay Time 변경(YDH. 2015.11.14)
		

		$(".thum li").click(function(){
			clearInterval(pageTimer);
		});
		$('.scroll_up, .scroll_dn').click(function(){
			setTimeout('mainBanner()',15000);  //10000    // 9000 => 15000 Delay Time 변경(YDH. 2015.11.14)
		});
		//20150721
		
		function imgMove(secNum){
			//imgResize();
			var _secNum = secNum;
			var _secNum2 = _secNum +1;
	
			$(".sec"+_secNum2).css("visibility", "visible");
			$(".sec"+_secNum).stop().animate({'top':$(window).height()*-1}, {duration:1200, easing:"easeInOutQuint"});
	
			//내려오는 아이의 인터렉션
			$(".sec"+_secNum+" .cont_tit").stop().animate({'margin-top':'300px'}, {duration:1000, easing:"easeInOutQuint"});
			$(".sec"+_secNum+" .cont_text").stop().animate({'margin-top':'-100px'}, {duration:2000, easing:"easeInOutQuint"});
			$(".sec"+_secNum+" .cont_artist").stop().animate({'bottom':'200px'}, {duration:1000, easing:"easeInOutQuint"});
			$(".sec"+_secNum+" .thum").stop().animate({'bottom':'300px'}, {duration:1500, easing:"easeInOutQuint"});
	
			// 나타나는 아이의 인터렉션.
			$(".sec"+_secNum2+" .cont_tit").stop().animate({'margin-top':'0'}, {duration:1000, easing:"easeInOutQuint"});
			$(".sec"+_secNum2+" .cont_text").stop().animate({'margin-top':'0'}, {duration:1500, easing:"easeInOutQuint"});
			$(".sec"+_secNum2+" .cont_artist").stop().animate({'bottom':'73px'}, {duration:1500, easing:"easeInOutQuint"});
			$(".sec"+_secNum2+" .thum").stop().animate({'bottom':'67px'}, {duration:1500, easing:"easeInOutQuint"}); //20150623
	
			// 스크롤 버튼의 제어
			if(secNum == $(".sec").length-1){
				$(".scroll_dn").fadeOut();
			}
			$(".scroll_up").fadeIn("fast");
	
	
		}
		function imgMove2(secNum){
			var _secNum = secNum;
			var _secNum2 = _secNum +1;
			$(".sec"+_secNum).css("visibility", "visible");
			$(".sec"+_secNum).stop().animate({'top':0}, {duration:1200, easing:"easeInOutQuint"});
			$(".sec"+_secNum+" .cont_tit").stop().animate({'margin-top':'0'}, {duration:1500, easing:"easeInOutQuint"});
			$(".sec"+_secNum+" .cont_text").stop().animate({'margin-top':'0'}, {duration:1500, easing:"easeInOutQuint"});
			$(".sec"+_secNum+" .cont_list").stop().animate({'bottom':'100px'}, {duration:1500, easing:"easeInOutQuint"});// 20150621
			$(".sec"+_secNum+" .cont_artist").stop().animate({'bottom':'73px'}, {duration:1500, easing:"easeInOutQuint"});
			$(".sec"+_secNum+" .thum").stop().animate({'bottom':'67px'}, {duration:1500, easing:"easeInOutQuint"});//20150623
	
			// 나타나는 아이의 인터렉션.
			$(".sec"+_secNum2+" .cont_tit").stop().animate({'margin-top':'300px'}, {duration:1000, easing:"easeInOutQuint"});
			$(".sec"+_secNum2+" .cont_text").stop().animate({'margin-top':'-100px'}, {duration:2000, easing:"easeInOutQuint"});
			$(".sec"+_secNum2+" .cont_list").stop().animate({'bottom':'200px'}, {duration:1000, easing:"easeInOutQuint"});
			$(".sec"+_secNum2+" .cont_artist").stop().animate({'bottom':'200px'}, {duration:1000, easing:"easeInOutQuint"});
			$(".sec"+_secNum2+" .thum").stop().animate({'bottom':'300px'}, {duration:1000, easing:"easeInOutQuint"});//20150623
	
			// 스크롤 버튼의 제어
			$(".scroll_dn").fadeIn("fast");
			 if(secNum == 1){
				$(".scroll_up").fadeOut();
			}
	   }
		
		//오피스 입력 연동 작업으로 slideCtl에서 처리
		jQuery.fn.slideFunc = function(params){
			var _slideWidth;
			var _objNum = 0;
			var _obj    = $(this);
			var _leng = (_obj.find(".roll ul li").length);
			var _rollWidth = (_obj.find(".roll ul li").length) * $(window).width();
			console.log(_obj.find(".roll ul li"));
			console.log(_obj.find(".roll ul li").length);
			_obj.find(".roll ul").css("width", _rollWidth)
			_slideWidth = $(window).width(); 
			
			// 오피스 입력 연동 작업으로 slideCtl에서 처리
			/* _obj.find(".thum li").eq(0).addClass("selected")
			_obj.find(".thum li").bind("click keyup", function(){
				console.log("thum click");
				console.log($(this).index()); //init[li scope]
				var liNum   = $(this).index();
				_objNum     = $(this).index();
				slideMove(liNum);
				//btnShowHide();20150627
			}); */
			
			_obj.find(".btn_prev").bind("click keyup", function(){
				if(_objNum > 0){
					slideMove(_objNum - 1);
					_objNum--;
				} else if(_objNum = 0) {
				}
				//btnShowHide();20150627
			});
			_obj.find(".btn_next").bind("click keyup", function(){
				if(_objNum < (_obj.find(".roll ul li").length-1)){
					slideMove(_objNum +1 );
					_objNum++;
				}
				//btnShowHide();20150627
			});

			/* 20150627 */
			_obj.find(".btn_prev").hover(function(){
				$(this).addClass('hover');
			}, function(){
				$(this).removeClass('hover');
			});

			_obj.find(".btn_next").hover(function(){
				$(this).addClass('hover');
			}, function(){
				$(this).removeClass('hover');
			});
			/* //20150627 */
			
			/*
			if( isMobile.any() ){
				_obj.bind("swipeleft", function(){//next
					if(_objNum < (_obj.find(".roll ul li").length-1)){
						slideMove(_objNum + 1);
						_objNum++;
					}
				});
				_obj.bind("swiperight", function(){//prev
					if(_objNum > 0){
						slideMove(_objNum - 1);
						_objNum--;		
					}
				});
			}
			*/

			/*
			btnShowHide();

			function btnShowHide(){

				if(_objNum == 0){
					_obj.find(".btn_prev").addClass('off');
					_obj.find(".btn_next").removeClass('off');
				}
				if(_objNum >= _leng-1){
					_obj.find(".btn_prev").removeClass('off');
					_obj.find(".btn_next").addClass('off');
				}
				if(_objNum > 0 && _objNum < _leng-1){
					_obj.find(".btn_prev").removeClass('off');
					_obj.find(".btn_next").removeClass('off');
				}
			}
			*/
			
			function slideMove(num){
				_slideLeft  = _slideWidth * num * -1;
				_obj.find(".roll ul").stop().animate({'left':_slideLeft}, {duration:500, easing:"easeInOutQuint"});
				_obj.find(".thum li").removeClass("selected");
				_obj.find(".thum li").eq(num).addClass("selected");
			}
		};
	</script>
    


</div>
</div><!-- id wrap -->

<jsp:include page="include/main_in.jsp" flush="false" />
<jsp:include page="include/footer.jsp" flush="false" />
