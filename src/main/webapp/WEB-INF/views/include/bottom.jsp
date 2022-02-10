<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">
app.controller("bottomCtl", function($scope, consts, common, locale) {
	$scope.locale = locale;
	$scope.sale_no = '${SALE_NO}';  
	$scope.sale_outside_yn = (getParameter("sale_outside_yn"));
	if ($scope.sale_no == '' ) {
		 $scope.sale_no = null; 
	 } 

  	$scope.loadFeaturedList = function(){
  		
  		if(!$scope.sale_outside_yn){
 			$scope.sale_outside_yn = "N";
 		}
  		
  	   	$d = {"actionList":[
  	   	   		{"actionID":"sale_featured_lots", "actionType":"select" , "tableName": "FEATUREDS", "parmsList":[{"sale_kind_cd":$scope.sale_kind_cd, "sale_outside_yn": $scope.sale_outside_yn, "sale_no":$scope.sale_no, "rows":consts.FEATUREDS_ROWS}]}
  	   	     ]};
  	       		
  	   	var $s = function(data, status) { 
  	   		$scope.featuredList = data["tables"]["FEATUREDS"]["rows"];
  	   		console.log(	$scope.featuredList);
  	   	};
  		
  	   	common.callActionSet($d, $s);
	}
});	
</script>
<div ng-if="sale_status == 'ING'" id="contentContainer" class="ex_list_area nobanner rolling_box" ng-controller="bottomCtl" data-ng-init="loadFeaturedList();">
	<div class="title">Featured</div>
	<div class="m_hidden_box rolling"> 
		<ul>
			<li ng-repeat="featured in featuredList" ng-if="featured.STAT_CD == 'entry'">
				<a ng-href="{{is_login ? '/lotDetail?sale_no=' + featured.SALE_NO + '&lot_no=' + featured.LOT_NO : '#'}}">
					<!-- <img ng-if="featured.LOT_NO == 139" ng-src="/nas_img/front/main0460/thum/no_image.jpg" alt="{{featured.TITLE_JSON[locale]}}" style="height: 100%; width:100%; overflow:hidden;"/> -->
					<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{featured.LOT_IMG_NAME | imagePath : featured.LOT_IMG_PATH : true}}" alt="{{featured.TITLE_JSON[locale]}}" />    
				</a> 
				<div> 
					<span>Lot {{featured.LOT_NO}}. {{TITLE_JSON[locale]}}</span> 
				</div>
			</li>
		</ul>
	</div>
</div>