<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>   
<style>

.cont_tit span { /* 기존 slide_span */
  font-size: 15px;
  font-weight:600;
  min-height: 60px;
}

.cont_text dl dd span{ /* 기존 main_ask */
	padding-top: 10px;
	display:inline-block;
}

</style>
<script>

app.controller("slideCtl", function($scope, common){

	$scope.init = function(){
		//슬라이드 호출
		$d = {"baseParms":{"locale" : "${locale}"},
 				"actionList":[
					{"actionID":"get_home_slide_info", "actionType":"select" , "tableName": "BANN_MAIN" ,"parmsList":[]},
 				]
 		};

 	   	common.callActionSet($d, function(data, status){
 	   		$scope.slideList = data["tables"]["BANN_MAIN"]["rows"];
			
 	   		//슬라이드 별 이미지 호출
 	   		$.each($scope.slideList, function(idx, item){
	 	   		$d = {"baseParms":{"bann_main_no" : item.BANN_MAIN_NO},
		 				"actionList":[
							{"actionID":"get_slide_img_list", "actionType":"select" , "tableName": "BANN_MAIN_IMG" ,"parmsList":[]},
		 				]
	 			};
	 	   		
		 	   	common.callActionSet($d, function(data, status){
		 	   		$scope.slideList[idx].imgList = data["tables"]["BANN_MAIN_IMG"]["rows"];
		 	   	});//img callActionSet
 	   		});// each
		});//slide callActionSet
	}// init()
	
	$scope.$on('ngRepeatEnd', function (ngRepeatEndEvent) { 
		var secLength = $(".sec").length;
		
		// 이미지 사이즈 조절을 위해 display:block으로 설정
		$(".sec, .pop").css("display", "block");	
		
		for(var i=1; i<=secLength; i++){
			$(".sec"+i).css("visibility", "hidden");
		}
		$(".pop").css("visibility", "hidden");
		$(".loading").fadeOut("slow");
		$(".sec1, .main_frame_top, .main_frame_middle, .main_frame_bottom, .sec1_cont, .scroll_dn").css('visibility','visible').hide().fadeIn('fast');
		init();
	}); //ngRepeatEnd
	

	$scope.imgMResize = function(img, parent){
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
		
		var divAspect = $(parent).height() / $(parent).width();
		parent.style.overflow = 'hidden';

		if(img) {
			var imgAspect = img.naturalHeight / img.naturalWidth ;
			
			if (imgAspect <= divAspect) {
			  // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
			  var offsetHeight = parent.offsetHeight == 0 ? $(parent).height()-4 : parent.offsetHeight; //간헐적으로 offsetHeight값이 0 발생할때 처리
			  var imgWidthActual = offsetHeight / imgAspect;
			  var imgWidthToBe = offsetHeight / divAspect;
			  var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
			  	
			  img.style.cssText = 'width: auto; height: 100%; margin-left: ' + marginLeft + 'px;'
			} else if(imgAspect > divAspect) {
			  // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
			  img.style.cssText = 'width: 100%; height: auto; margin-left: 0;';
			}
		}
		
	}
	
	$scope.thumli_click = function($event){
		var _slideWidth = $(window).width(); 
		var elem = $event.currentTarget || $event.srcElement; //이벤트가 발생한 엘리먼트 가져오기 //thum li
		var par_obj = $(elem)[0].parentElement.parentElement.parentElement; //rollbox

		var liNum   = $(elem).index();
		_objNum     = $(elem).index();
		slideMove(liNum);
		
		function slideMove(num){
			_slideLeft  = _slideWidth * num * -1;
			$(par_obj).find(".roll ul").stop().animate({'left':_slideLeft}, {duration:500, easing:"easeInOutQuint"});
			$(par_obj).find(".thum li").removeClass("selected");
			$(par_obj).find(".thum li").eq(num).addClass("selected");
		}
	}
	
	$scope.slideFunc = function(params){
		var _objNum = 0;
		var _obj    = $(params);
		var _leng = (_obj.find(".roll ul li").length);
		var _rollWidth = (_obj.find(".roll ul li").length) * $(window).width();
		_obj.find(".roll ul").css("width", _rollWidth)
	};
	
});

</script>   

 <div ng-controller="slideCtl" data-ng-init="init()">
    <div ng-repeat="slide in slideList | orderBy:'-'" oncontextmenu="return false" class="sec sec{{slideList.length - $index}}" >
    	<div class="roll_box{{slideList.length - $index}}">    <!-- slidefunc -->      
    		<div class="roll"  style="width: 1463px; height: 955px; overflow: hidden;">   
    			<ul style="width: 1463px;">  
					<li ng-repeat="img in slide.imgList" style="width: 1463px; height: 955px; overflow: hidden;" bind-slide-func > 
						<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_PATH}}/{{img.FILE_NAME}}" alt="SEOUL AUCTION SALE" style="width: 100%; height: auto; margin-left: -120px;"  imageonload  ondragstart="return false" >
					</li> 
				</ul>   
    		</div><!-- roll -->
    		<div class="thum" style="bottom: 100px;" >  
    			<ul>
    				<li ng-repeat="img in slide.imgList" ng-class="{'selected': $first}" ng-click="thumli_click($event)" style="width: 60px; height:60px; overflow: hidden;" ng-repeat-end-check > 
						<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_PATH}}/thum/{{img.FILE_NAME}}" alt="SEOUL AUCTION SALE" style="width: auto; height: 100%; margin-left: -13px;" imageonload  ondragstart="return false" >
					</li> 
				</ul>     
    		</div><!-- thum -->
    	</div><!-- rollbox -->
    	<div class="cont_mask">
	   		<div class="">  
	   			<div class="cont_tit txt_han" style="cursor: default; margin-top: 300px;"> 
	                <p ng-bind-html="slide.SLIDE_TITLE_JSON[locale] | unsafe" ></p> <!-- 슬라이드 제목 -->
	   			</div>
	   			<div class="cont_text" style="margin-top: -100px;cursor:default"> <!-- 슬라이드 내용 -->
	   				<dl>
						<dt ng-bind-html="slide.TEXT_TITLE_JSON[locale] | unsafe"></dt> <!-- 단락1 제목 -->
						<dd ng-bind-html="slide.TEXT_JSON[locale] | unsafe"></dd> <!-- 단락1 내용 -->
					</dl>
					<dl ng-if="slide.SUB_TEXT_TITLE_JSON[locale] != null || slide.SUB_TEXT_JSON[locale] != null" >
						<dt ng-bind-html="slide.SUB_TEXT_TITLE_JSON[locale] | unsafe"></dt> <!-- 단락2 제목 -->
						<dd ng-bind-html="slide.SUB_TEXT_JSON[locale] | unsafe"></dd> <!-- 단락2 내용 -->
					</dl> 
	            </div>
	   			<!-- button -->
	   			  <!-- //green orange yellow sky deepblue deeppink deepred  -->
	              <a ng-if="slide.BTN1_DISP_YN == 'Y' && slide.BTN1_URL != null" href="{{slide.BTN1_URL}}" target="{{slide.BTN1_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN1_COLOR_YN]">{{slide.BTN1_JSON[locale]}}</a>
	              <a ng-if="slide.BTN2_DISP_YN == 'Y' && slide.BTN2_URL != null" href="{{slide.BTN2_URL}}" target="{{slide.BTN2_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN2_COLOR_YN]">{{slide.BTN2_JSON[locale]}}</a>
	              <a ng-if="slide.BTN3_DISP_YN == 'Y' && slide.BTN3_URL != null" href="{{slide.BTN3_URL}}" target="{{slide.BTN3_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN3_COLOR_YN]">{{slide.BTN3_JSON[locale]}}</a>
	              <a ng-if="slide.BTN4_DISP_YN == 'Y' && slide.BTN4_URL != null" href="{{slide.BTN4_URL}}" target="{{slide.BTN4_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN4_COLOR_YN]">{{slide.BTN4_JSON[locale]}}</a>
	              <a ng-if="slide.BTN5_DISP_YN == 'Y' && slide.BTN5_URL != null" href="{{slide.BTN5_URL}}" target="{{slide.BTN5_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN5_COLOR_YN]">{{slide.BTN5_JSON[locale]}}</a>
	   		</div><!-- sec3_cont -->
   		</div> <!-- cont_mask -->
    </div><!-- sec -->
 </div><!-- controller -->
        
