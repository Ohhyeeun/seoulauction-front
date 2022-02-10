$(document).ready(function(){	
	var LoginID = getCookie("LoginID");  
	var LoginPW = getCookie("LoginPW");   
	
	//console.log(LoginID);
	//console.log(LoginPW); 
		
	$("input[name='loginId']").val(LoginID);         
	$("input[name='password']").val(LoginPW);           

	if($("input[name='loginId']").val() != ""){
		$("#checkedID").attr("checked", true);
	}
	if($("input[name='password']").val() != ""){
		$("#checkedPW").attr("checked", true);  
	} 

	$("#checkedID").change(function(){
		if($("#checkedID").is(":checked")){
			var LoginID = $("input[name='loginId']").val();     
			setCookie("LoginID", LoginID, 365);
		}else{
			deleteCookie("LoginID");   
		}  
	});
	$("#checkedPW").change(function(){
		if($("#checkedPW").is(":checked")){
			var LoginPW = $("input[name='password']").val();     
			setCookie("LoginPW", LoginPW, 365); 
		}else{
			deleteCookie("LoginPW");   
		}  
	});

	$("input[name='loginId']").keyup(function(){
		if($("#checkedID").is(":checked")){
			var LoginID = $("input[name='loginId']").val();   
			setCookie("LoginID", LoginID, 365);       
		}   
	}); 
	
	$("input[name='password']").keyup(function(){
		if($("#checkedPW").is(":checked")){  
			var LoginPW = $("input[name='password']").val();   
			setCookie("LoginPW", LoginPW, 365);         
		}   
	});
	 

	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue); 
	}    
});  