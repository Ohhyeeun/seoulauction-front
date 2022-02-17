<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="locale" scope="session" value="${pageContext.response.locale}" />
<!DOCTYPE html>
<html lang="ko" ng-app="myApp">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="UTF-8">
<title>서울옥션</title>
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">
<link href="<c:url value="/css/common.css" />" rel="stylesheet">
<link href="<c:url value="/css/custom.css" />" rel="stylesheet">
<link href="<c:url value="/css/ng-animation.css" />" rel="stylesheet">
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular.min.js"></script>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-animate.min.js"></script>
<script type="text/javascript" src="<c:url value="/js/angular/angular-bind-html-compile.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/angular/angularSlideables.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common.js" />"></script>
</head>
<body class="main">
<script type="text/javascript">
var app = angular.module("myApp", ["ngAnimate"]);

app.controller('bannerListCtl', function($scope, $http) {
	$scope.getOrdinal = localeOrdinal;
	$scope.localeValue = localeValue;

	$scope.loadBannerList = function(){
		data ={"tables":{"LIST":{"columns":{"BANN_ID":"string","ITEM_NO":"long","SALE_NO":"long","TITLE":"string","TITLE_EN":"string","TITLE_CN":"string","CONTENT":"string","CONTENT_EN":"string","CONTENT_CN":"string","LINK":"string","DISP_ORD":"long","REG_DT":"datetime","REG_EMP_NO":"long","MOD_DT":"datetime","MOD_EMP_NO":"long","SALE_TH":"long","SALE_TITLE":"string","SALE_TITLE_EN":"string","SALE_TITLE_CN":"string"},"rows":[{"CONTENT_EN":"<strong>{{item.SALE_TITLE_EN}}</strong>\r\n<div>테스트</div>\r\n","REG_EMP_NO":null,"MOD_EMP_NO":null,"MOD_DT":null,"SALE_NO":1,"TITLE_CN":"{{item.SALE_TITLE_CN}}","TITLE_EN":"{{item.SALE_TITLE_EN}}","SALE_TH":1,"SALE_TITLE_EN":"main1","SALE_TITLE_CN":null,"DISP_ORD":1,"CONTENT":"<strong>{{item.SALE_TITLE}}</strong>\r\n<div>테스트</div>\r\n","LINK":null,"REG_DT":null,"BANN_ID":"main","SALE_TITLE":"메인테스트1","ITEM_NO":1,"TITLE":"{{item.SALE_TITLE}}","CONTENT_CN":"<strong>{{item.SALE_TITLE_CN}}</strong>\r\n<div>테스트</div>\r\n"},{"CONTENT_EN":"<strong>{{item.SALE_TITLE_EN}}</strong>\r\n<div>테스트</div>\r\n","REG_EMP_NO":null,"MOD_EMP_NO":null,"MOD_DT":null,"SALE_NO":1,"TITLE_CN":"{{item.SALE_TITLE_CN}}","TITLE_EN":"{{item.SALE_TITLE_EN}}","SALE_TH":2,"SALE_TITLE_EN":"main1","SALE_TITLE_CN":null,"DISP_ORD":2,"CONTENT":"<strong>{{item.SALE_TITLE}}</strong>\r\n<div>테스트</div>\r\n","LINK":null,"REG_DT":null,"BANN_ID":"main","SALE_TITLE":"메인테스트1","ITEM_NO":2,"TITLE":"{{item.SALE_TITLE}}","CONTENT_CN":"<strong>{{item.SALE_TITLE_CN}}</strong>\r\n<div>테스트</div>\r\n"}]},"IMAGE":{"columns":{"BANN_ID":"string","ITEM_NO":"long","LANG_CD":"string","IMG_NO":"long","TITLE":"string","FILE_NAME":"string","FILE_PATH":"string","REG_DT":"datetime","REG_EMP_NO":"long"},"rows":[{"FILE_NAME":"","REG_EMP_NO":null,"REG_DT":null,"BANN_ID":"main","LANG_CD":"ko","ITEM_NO":1,"FILE_PATH":"http://savm-filesvr.seoulauction.com/main/2016/01/15/201601150933103864073994156052.jpg","IMG_NO":1,"TITLE":"아카데미 - 특강"},{"FILE_NAME":"","REG_EMP_NO":null,"REG_DT":null,"BANN_ID":"main","LANG_CD":"ko","ITEM_NO":2,"FILE_PATH":"http://savm-filesvr.seoulauction.com/main/2016/01/19/201601191035334213416546549380.jpg","IMG_NO":1,"TITLE":null},{"FILE_NAME":"","REG_EMP_NO":null,"REG_DT":null,"BANN_ID":"main","LANG_CD":"ko","ITEM_NO":1,"FILE_PATH":"http://savm-filesvr.seoulauction.com/main/2016/01/18/201601181928244158987694452711.jpg","IMG_NO":2,"TITLE":"테스트"}]}},"ResultCode":0,"ResultMessage":null,"ResultDescription":null}
		$scope.bannerList = data["tables"]["LIST"]["rows"];
		$scope.imageList = data["tables"]["IMAGE"]["rows"];
		$scope.article = 1;			
		$scope.article_sub = 1;
	}
		
	$scope.setBannerArticle = function($n){
		if($n < 1){
				
		}else if($n > $scope.bannerList.length){
				
		}else{
			$scope.article = $n
			$scope.article_sub = 1;
		}
	}
		$scope.setBannerArticleSub = function($n){
			$scope.article_sub = $n;
  		}
});
</script>
<div >
	<div class="well" ng-controller="bannerListCtl" data-ng-init="loadBannerList();">
		<div  style="position:relative;" class="switch"  ng-switch on="article" ng-animate="'animate'"  ng-repeat="item in bannerList">
			<!-- ng-switch-when="($index + 1)== article" ng-switch-when 안에 문법사용이 안되므로 ng-if로 처리 -->
			<div ng-if="article==($index + 1)" class="slide-up" >
				<div>
					<div>
						<div style="position:relative;" ng-switch on="article_sub" ng-animate="'animate'" ng-repeat="image in imageList | filter:{ITEM_NO:item.ITEM_NO, LANG_CD:'${locale}'}">
							<div ng-if="article_sub==($index + 1)" class="slide-left" ng-show="article_sub==($index + 1)" style="width:500px;height:200px;background-image:url({{image.FILE_PATH}}); background-size:contain; background-repeat: no-repeat;">
								<div class="cont_artist">
									<span style="font-size:10px;">
									</span>
									<span style="font-size:10px;">{{image.TITLE}}</span>
								</div>
							</div>
						</div>
					</div>
					<div>
						<div class="cont_tit txt_han">
							<span>{{getOrdinal(item.SALE_TH, ${locale})}}</span>
							<br />
							<div bind-html-compile="localeValue(item, 'TITLE', '${locale}')"></div>
						</div>
						<div class="cont_text">
							<div bind-html-compile="localeValue(item, 'CONTENT', '${locale}')"></div>
							<a href="/sale/pastLotList?salesPlanningId={{item.SALE_NO}}" class="btn_main_more yellow">SEE MORE</a>
					   </div>
					</div>
					<div>
						<ul ng-repeat="image in imageList | filter:{ITEM_NO:item.ITEM_NO, LANG_CD:'${locale}'}" style="overflow: auto;">
							<li style="float:left; display: inline;">
								<img style="width:50px;height:20px;" ng-click="setBannerArticleSub($index + 1);" ng-src="{{image.FILE_PATH}}" alt="{{image.TITLE}}"/>
							</li>
						</ul>
					</div><!-- //thum -->
				</div><!-- //roll_box -->
			</div>
		</div>
		<div style="position:relative;" >
			<button class="scroll_up" ng-click="setBannerArticle(article - 1);" ng-hide="article <= 1"><span>위로</span></button>
			<button class="scroll_dn" ng-click="setBannerArticle(article + 1);" ng-hide="article >= bannerList.length"><span>아래로</span></button>
		</div>
	</div>
</div>
</body>
</html>

