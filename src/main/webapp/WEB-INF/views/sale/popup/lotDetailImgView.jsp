<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title>서울옥션 통합관리자시스템 pinchzoomer</title>
	<meta name="viewport" content="width=device-width, user-scalable=no">
	
	<link href="/css/pinchzoomer.min.css" rel="stylesheet"><!--***-->

	<script src="/js/pinchzoomer/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script src="/js/pinchzoomer/hammer.min.js" type="text/javascript"></script>
	<script src="/js/pinchzoomer/TweenMax.min.js" type="text/javascript"></script>
	<script src="/js/pinchzoomer/jquery.pinchzoomer.min.js" type="text/javascript"></script>
<script>
	
		function getParameter(strParamName) {
		    var strURL = location.search;
		    var tmpParam = strURL.substring(1).split("&");
		    if(strURL.substring(1).length > 0){
		        var Params = new Array;
		        for(var i=0;i<tmpParam.length;i++){
		            Params = tmpParam[i].split("=");
		            if(strParamName == Params[0]){
		                return Params[1];
		            }
		        }
		     }
		     return "";
		};
	
	
		var img_src = getParameter("url");
				
		console.log(img_src);
	</script>
</head>
<body>	
	<div class="container" style="padding-top: 2rem;">
		<div class="row">
			<div class="col-xs-12">
				<div class="zoomHolder">
					<img id="img1" src="" data-elem="pinchzoomer" data-options="scaleMode:proportionalInside"/>
					<script type="text/javascript">
		            	document.getElementById("img1").src = img_src;
		            </script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
