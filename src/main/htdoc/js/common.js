function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}
function moneyFormat(event, elInput) {
	// 방향키, PageUp, PageDown 키는 허용
	switch(event.keyCode) {
		case 16:
		case 35:
		case 36:
		case 37:
		case 38:
		case 39:
		case 40: {
			return true;
		}
	}
	// 금액 입력 시 콤마 처리
	elInput.value = comma(uncomma(elInput.value));
}
function onlyNumber(event){
	return event.charCode >= 48 && event.charCode <= 57;
}

function fileToBase64 (evt) {
    var files = evt.target.files;
    var file = files[0];
    
    if (files && file) {
        var reader = new FileReader();
        reader.onload = function(readerEvt) {
            var binaryString = readerEvt.target.result;
            return btoa(binaryString);
        };
        return reader.readAsBinaryString(file);
    }
};

var convertKeysToCamelCase = function(obj) {
    if (!obj || typeof obj !== "object") return null;

    if (obj instanceof Array) {
        return $.map(obj, function(value) {
            return convertKeysToCamelCase(value);
        });
    }

    // manipulates the object being passed in
    $.each(obj, function(key, value) {
        // delete existing key
        delete obj[key];
        key = key.toLowerCase();
        obj[key] = value;
        convertKeysToCamelCase(value);
    });

    return obj;
};

function getParameter(strParamName) {
	var strURL = location.search;
	var tmpParam = strURL.substring(1).split("&");
	if (strURL.substring(1).length > 0) {
		var Params = new Array;
		for (var i = 0; i < tmpParam.length; i++) {
			Params = tmpParam[i].split("=");
			if (strParamName == Params[0]) {
				return Params[1];
			}
		}
	}
	return "";
};

function characterCheck(obj) {
	  var regExp = /[@ ]/gim; //@, 공백

	  if( regExp.test(obj.value) ){
//	     console.log("특수문자는 입력하실수 없습니다. : " + obj.value);
	     obj.value = obj.value.replace(regExp, ''); // 입력한 특수문자 한자리 지움
	  }else{
//		  console.log("입력한 값 : " + obj.value);
	  }
}

function history_back(){
	if ( document.referrer ) { 
		history.back();
	}
	// 히스토리가 없으면,
	else { 
		// 메인 페이지로
		location.href = "/";
	}
}

function removeHtml(text){
	//html 태그 제거, br -> 띄어쓰기 변환
	text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
	return text;
}
