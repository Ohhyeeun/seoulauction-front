<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>     
<style>
	.bx-viewport {
		height: auto !important; 
	}
	
	.txt .btn_main_more{
		width:80px;
		margin-top:5px;
	}
	
	.title span{ /* 기존 title p */
		font-size:12px;
		padding-bottom: 10px;
		display:inline-block;
	}
	
	.info dl dd span{ /* 기존 main_ask */
		padding-top: 10px;
		display:inline-block;
	}
</style>
<script>
	 app.controller("mSlideCtl", function($scope, common){
	 	
	 	$scope.init = function(){
	 		$d = {"baseParms":{"locale" : "${locale}"},
	  				"actionList":[
	 					{"actionID":"get_home_slide_info", "actionType":"select" , "tableName": "BANN_MAIN" ,"parmsList":[]},
	  				]
	  		};
	
	  	   	common.callActionSet($d, function(data, status){
	  	   		$scope.mSlideList = data["tables"]["BANN_MAIN"]["rows"];
	  	   		
	  	   		$.each($scope.mSlideList, function(idx, item){
	 	 	   		$d = {"baseParms":{"bann_main_no" : item.BANN_MAIN_NO },
	 		 				"actionList":[
	 							{"actionID":"get_slide_img_list", "actionType":"select" , "tableName": "BANN_MAIN_IMG" ,"parmsList":[]},
	 		 				]
	 	 			};
	 	 	   		
	 		 	   	common.callActionSet($d, function(data, status){
	 		 	   		$scope.mSlideList[idx].imgList = data["tables"]["BANN_MAIN_IMG"]["rows"];
	 		 	   		$scope.mSlideList[idx].tgblank = "_blank";
	 		 	   	});//img callActionSet
	  	   		});// each
	 		});//sec callActionSet
	 	}// init()
		
		/* 안드로이드 / ios 구분 */     
	 	var DeviceBtn = navigator.userAgent.toLowerCase();
	 	if(DeviceBtn.indexOf("android")!== -1){ //android 일때
	 	 	$scope.isAndroid = true;
	 		//$("#DeviceBtn").append("<a href='/'>'App 바로가기'</a>");                       
	 	}else if(DeviceBtn.indexOf("iphone")!== -1 || DeviceBtn.indexOf("ipad")!== -1){ //iphone 일때 
	 		$scope.isIphone = true;   
	 	};
	 	
	 		
	 	$scope.$on('ngRepeatFinished', function (ngRepeatFinishedEvent) { 
	 		$(".m_ver_sliderwrap .bxslider").bxSlider({      
				auto:true,   
				controls: true, 
				autoControls: true,
				infiniteLoop: true,
// 				autoControlsCombine:true,     
				pause: 3500,    
				adaptiveHeight:true, 
				onSlideBefore: function(){
	            	if ( !$('.bx-clone').is(":visible") ) {
		                $('.bx-clone').show();
		            }
	        	}
		
			}); 
	 		
	 		$(".loading").fadeOut("1000"); 
	 		
	 	}); //ngRepeatFinished
	 	
	
	 });
</script>
    
<div class="m_ver_sliderwrap">         
	<div class="bxslider"  ng-controller="mSlideCtl" data-ng-init="init()">    
	  	<div class="main_sd"  ng-repeat="slide in mSlideList" on-finish-render-filters>     
	  		<div class="img" ng-repeat="img in slide.imgList" ng-show="$first">
				<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{img.FILE_PATH}}/{{img.FILE_NAME}}" alt="AUCTION"  style="width:100%; height:auto;" /> 
			</div>    
			<div class="txt">     
				<div class="title txt_han">
	                <p ng-bind-html="slide.SLIDE_TITLE_JSON[locale] | unsafe" ></p>    
				</div>
				<!-- button -->
                 <a ng-if="slide.BTN1_DISP_YN == 'Y' && slide.BTN1_URL != null" href="{{slide.BTN1_URL}}" target="{{slide.BTN1_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN1_COLOR_YN]">{{slide.BTN1_JSON[locale]}}</a>
	             <a ng-if="slide.BTN2_DISP_YN == 'Y' && slide.BTN2_URL != null" href="{{slide.BTN2_URL}}" target="{{slide.BTN2_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN2_COLOR_YN]">{{slide.BTN2_JSON[locale]}}</a>
	             <a ng-if="slide.BTN3_DISP_YN == 'Y' && slide.BTN3_URL != null" href="{{slide.BTN3_URL}}" target="{{slide.BTN3_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN3_COLOR_YN]">{{slide.BTN3_JSON[locale]}}</a>
	             <a ng-if="slide.BTN4_DISP_YN == 'Y' && slide.BTN4_URL != null" href="{{slide.BTN4_URL}}" target="{{slide.BTN4_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN4_COLOR_YN]">{{slide.BTN4_JSON[locale]}}</a>
	             <a ng-if="slide.BTN5_DISP_YN == 'Y' && slide.BTN5_URL != null" href="{{slide.BTN5_URL}}" target="{{slide.BTN5_TARGET_YN == 'Y' ? '_blank' : '_self'}}" class="btn_main_more green" ng-class="{'Y':'yellow', 'N':'green'}[slide.BTN5_COLOR_YN]">{{slide.BTN5_JSON[locale]}}</a>
                 
                <!-- 임시버튼 추가 1 (title == 오피스 슬라이드관리명으로 넣기)-->     
	            <span id="DeviceBtn" ng-if="isAndroid && slide.TITLE == 'ZEROBASE_The Painters'">  
	       			<a class="btn_main_more green" href='https://play.google.com/store/apps/details?id=com.Birdletter.SeoulAuctionAR' target="_blank">
	       				<span ng-if="locale=='ko'">AR앱다운로드</span>
	       				<span ng-if="locale!='ko'">AR App</span> 
	       			</a>   
	            </span>
                
	             <!-- contents -->
	             <div class="info">
	             	<span>
						<dl style="padding-bottom: 10px;"> 
	                     	<dt><strong  ng-bind-html="slide.TEXT_TITLE_JSON[locale] | unsafe"></strong></dt>
	                        <dd ng-bind-html="slide.TEXT_JSON[locale] | unsafe"></dd>     
	                    </dl>   
	                    <dl>   
	                        <dt><strong ng-bind-html="slide.SUB_TEXT_TITLE_JSON[locale] | unsafe"></strong></dt>
	                        <dd ng-bind-html="slide.SUB_TEXT_JSON[locale] | unsafe"></dd>
	                    </dl>  
					</span>  
	             </div>
			</div> 
	    </div>  
    </div><!-- //bxslider --> 
</div><!-- //m_ver_sliderwrap --> 
