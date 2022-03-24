<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<meta name="_csrf" content="${_csrf.token}"/>
	<!-- default header name is X-CSRF-TOKEN -->
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script>
	$(document).ready(function(e) {
		
		$("#doBtn").click(function(){
			//var formData = $("#ajaxForm").serialize();
			var formData = $("#params").val();
			JSON.stringify(formData);
			
			jQuery.ajaxSettings.traditional = true;
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				type : "POST",
				url : "/api/office/actionSet",
				//url : "//localhost:8080/testCtl",
				//contentType: "application/x-www-form-urlencoded",
				contentType: "application/json",
				//dataType: "JSON",
				cache : false,
				beforeSend: function(xhr) {xhr.setRequestHeader(header, token)},
				//headers: { "${_csrf.headerName}" : "${_csrf.token}"},
				//headers: { "X-CSRF-TOKEN" : token },
				data : JSON.stringify({
					//"baseParms":{"SHOP_NO":164,"USER_NO":223785},
					"actionList":
					[
						{"actionID":"mapper.commo.insertYbjung"
						 ,"actionType":"insert"
						 ,"parmsList":[
						               {"A":"3","B":"skjfsdkjf","C":"sfrwfw"}
						               , {"A":"4","B":"skvbskdvs","C":"effscscs"}
						               , {"A":"5","B":"ssjfsbfjsds","C":"scnsdck"}
						              ]
						 ,"tableName": "YBJUNG"
						},
						{"actionID":"mapper.commn.updateYbjung"
							 ,"actionType":"update"
							 ,"parmsList":[
							               {"A":"3","B":"zzzzz","C":"zzzzz"}
							              ]
							 ,"tableName": "YBJUNG-up"
						}
					]
					}),
				//data : {"baseParams":{"SHOP_NO":164,"GOODS_NO":23112,"LANG_CD":"default"}},
				success : onSuccess,
				error : onError
			});
		});
		function onSuccess(json, status){$("#result").html(JSON.stringify(json));}
		function onError(data, status, error){
			if(data.status == 403 || data.status == 401){
				//alert(JSON.stringify(data));
				//alert("code:"+data.status+"\n"+"message:"+data.responseText+"\n"+"error:"+error);
				location.href = "/login";
			}
		}
	});
	</script>
</head>
<body>
	<form method="post" name="ajaxForm" id="ajaxForm">
        <label>sql id: </label><input type="text" name="sqlId" placeholder="sql id" /><br>
        <textarea id="params" cols="50" rows="20"></textarea>
        <!-- <input type="text" name="sqlId" placeholder="sql id" />
        <input type="text" name="params" placeholder="name:value,..." /> -->
        <input type="button" value="do" id="doBtn"/>      
	</form>

 <span id="result"></span>

</body>
</html>


