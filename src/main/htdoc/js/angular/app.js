var app = angular.module("myApp", ["ngSanitize", "angular-bind-html-compile"]);

app.constant("consts",{
	"FILE_SERVER":"",
	"THUMB_PATH":"thum/",
	"LIST_PATH":"list/",
	"DETAIL_PATH":"detail/",
    "NOTICE_RECENT_ROWS": 5,
    "SALE_LIST_ROWS": 10,
    "LOT_LIST_ROWS": 10,
    "FEATUREDS_ROWS": 6,
    "DEF_DATETIME_FMT": "yyyy-MM-dd HH:mm:ss"
});

app.run(function ($rootScope, consts, locale, common, $filter) {
	
	$rootScope.consts = consts;
	$rootScope.locale = locale;
	$rootScope.getJsonObj = function(jsonText){
		var jsonObj = angular.fromJson(jsonText); 
		return jsonObj;
	}
	
	$rootScope.setJsonObj = function(rows, cols){
		for(ri in rows){
			for(ci in cols){
	 			rows[ri][cols[ci]] = angular.fromJson(rows[ri][cols[ci]]);
			}
 		}
	}
	
	$rootScope.getWeek = function(date){
		var enWeek = $filter('date')(date, 'EEE');
		if(locale != 'ko') return enWeek;
		switch(enWeek){
		case "Mon":
			return "월";
		case "Tue":
			return "화";
		case "Wed":
			return "수";
		case "Thu":
			return "목";
		case "Fri":
			return "금";
		case "Sat":
			return "토";
		case "Sun":
			return "일";
		default:
			return enWeek;
		}
	}
	$rootScope.getPayTotal = function(price, lot_fee) {
		
		console.log("############");
		console.log(price);
		console.log(lot_fee);
		
		var subFee = 0.0;
		var totalFee = 0.0;
		var sub_price = 0;
		for(i in lot_fee){
			
			if(lot_fee[i]["PRICE_FROM"] == 0 && lot_fee[i]["PRICE_TO"] == 0){
				sub_price = price;
			}
			else if(lot_fee[i]["PRICE_FROM"] == 0 && lot_fee[i]["PRICE_TO"] > 0){
				if(price > lot_fee[i]["PRICE_TO"]){
					sub_price = lot_fee[i]["PRICE_TO"];
				}
				else{
					sub_price = price;
				}
			}
			else if(lot_fee[i]["PRICE_FROM"] > 0 && lot_fee[i]["PRICE_TO"] > 0){
				sub_price = price - (lot_fee[i]["PRICE_TO"] - (lot_fee[i]["PRICE_FROM"] - 1));
				
				if(sub_price > (lot_fee[i]["PRICE_TO"] - (lot_fee[i]["PRICE_FROM"] - 1))){
					sub_price = (lot_fee[i]["PRICE_TO"] - (lot_fee[i]["PRICE_FROM"] - 1));
				}
			}
			else if(lot_fee[i]["PRICE_FROM"] > 0 && lot_fee[i]["PRICE_TO"] == 0){
				sub_price = price - (lot_fee[i]["PRICE_FROM"] - 1);
			}
			
			if(sub_price > 0 ){
				subFee = sub_price * (lot_fee[i]["RATE"]/100);
			}
	
			console.log("=======>");
			console.log(subFee);
			totalFee += subFee;
			subFee = 0.0;
		}
		
		return {"price" : price + totalFee, "fee" : totalFee};
	}
	
	$rootScope.isValidString = function (str){
		return (str != undefined && str != null && str != "" ? true : false); 
	}

	$rootScope.compareString = function(l, s1, s2){
		console.log("========compare " + l + " || " + s1 + " : " + s2 + "============");
		var cnt = 0;
		for(var i=0 ; s1.length > i ; i++){
			if(s1.substring(i, i+1) != s2.substring(i, i+1)){
				console.log("============================");
				console.log("======> s1 : [" + s1);
				console.log("======> s2 : [" + s2);
				console.log("======> XX : [" + s1.substring(i, i+1)  + "] ** [" + s2.substring(i, i+1) + "]");
				console.log("============================");
			}
			cnt = i;
		}
		console.log("=====================" + cnt +"========================");
		console.log("=");
	}
});

app.factory("common", function ($rootScope, $http, _csrf, _csrf_header) {
	var is_processing = false;
	var objs = {
		errCommon: function(data, status, headers, config) {
	    	console.log("Error Start===================");
	    	console.log("DATA==>" + data);
	    	console.log("STATUS==>" + status);
	    	console.log("HEADERS==>" + headers);
	    	console.log("CONFIG==>" + config);
	    	console.log("Error End===================");
	    },

	    finalCommon: function() {
	    	console.log("Finally common is_processing => " + is_processing + " > false");
	    	is_processing = false;
	    },

	    setFocus: function($n){
	    	 var e = document.getElementsByName($n);

	    	 if(e && e.length > 0) 	e = e[0];
	    	 else 					e = document.getElementById($n);
	    	 if(e) e.focus();
	    },

	    callAPI: function($url, $data, $success, $error, $final) {
	    	is_processing = true;

	    	var $s = function(){};
	    	if($success) $s = $success;

	    	var $f = objs.finalCommon;
	    	if($final) $f = $final;
	    	
	    	var $e = objs.errCommon;
	    	if($error) $e = $error;
	    	
	    	$http.defaults.headers.post['Content-Type'] = 'application/json; charset=utf-8';
	    	$http.defaults.headers.post[_csrf_header] = _csrf;
	    	$http.post($url, $data)//, {headers: {'Content-Type': 'application/json; charset=utf-8', 'X-CSRF-TOKEN' : _csrf}})
	        .success($s)
	        .error($e)
	        .finally($f);
	    },

	    callActionSet: function($data, $success, $error, $final) {
	    	objs.callAPI('/api/actionSet', $data, $success, $error, $final);
	    },

	    callCustomAction: function($actionID, $data, $success, $error, $final) {
	 		$d = {"actionID":$actionID, "tableName": "RESULT", "parmsList":$data};

	    	objs.callAPI('/api/customAction', $d, $success, $error, $final);
	    }
	};
	
	return objs;
});

app.directive('onFinishRenderFilters', function ($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element, attr) {
            if (scope.$last === true) {
                $timeout(function() {
                    scope.$emit('ngRepeatFinished');
                });
            }
        }
    };
});

//메인슬라이드 오피스 입력 연동 
//li ng-repeat end check and binding slideFunc
app.directive('bindSlideFunc', function ($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element, attr) {
        	if (scope.$last === true) {
	        	var rollbox = element[0].parentElement.parentElement.parentElement;
	    		scope.slideFunc(rollbox);
        	}
        }
    };
});

//메인슬라이드 오피스 입력 연동 
//nasted ng-repeat end check
app.directive('ngRepeatEndCheck', function ($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element, attr) {
            if (scope.$parent.$last === true) {
            	if (scope.$last === true) {
	                $timeout(function() {
	                    scope.$emit('ngRepeatEnd');
	                });
            	}
            }
        }
    };
});

app.directive('imageonload', function() {
	return {
	    restrict: 'A',
	    link: function(scope, element, attrs) {
	        element.bind('load', function(e) {
	        	var parent = element[0].parentElement; //이미지감싸는 li
	        	scope.imgMResize(element[0], parent);
	        });
	        element.bind('error', function(){
	        	console.log('image could not be loaded');
	        });
	    }
	};
});


app.directive('myFocus', function () {
	return {
	  restrict: 'A',
	  link: function postLink(scope, element, attrs) {
	    if (attrs.myFocus == "") {
	    	attrs.myFocus = "focusElement";
	    }
	    scope.$watch(attrs.myFocus, function(value) {
	    	if(value == attrs.id) {
	    		element[0].focus();
	    	}
	    });
	    element.on("blur", function() {
	    	scope[attrs.myFocus] = "";
	    	scope.$apply();
	    })        
	  }
	};
});

app.directive('focus', function($timeout, $parse) {
	return {
	    restrict: 'A',
	    link: function(scope, element, attrs) {
			scope.$watch(attrs.focus, function(newValue, oldValue) {
	            if (newValue) { element[0].focus(); }
	        });
	        element.bind("blur", function(e) {
	            $timeout(function() {
	                scope.$apply(attrs.focus + "=false"); 
	            }, 0);
	        });
	        element.bind("focus", function(e) {
	            $timeout(function() {
	                scope.$apply(attrs.focus + "=true");
	            }, 0);
	        });
	    }
	}
});

app.directive('onlyNumber', function(){
    return {
      require: 'ngModel',
      restrict: 'A',
      link: function (scope, element, attr, ctrl) {
        function inputValue(val) {
          if (val) {
            var digits = val.replace(/[^0-9]/g, '');

            if (digits !== val) {
              ctrl.$setViewValue(digits);
              ctrl.$render();
            }
            return parseInt(digits,10);
          }
          return undefined;
        }            

        ctrl.$parsers.push(inputValue);
      }
    }
});

app.directive('doEnter', function() {
    return function(scope, element, attrs) {
        element.bind("keydown keypress", function(event) {
            if(event.which === 13) {
                scope.$apply(function(){
                    scope.$eval(attrs.doEnter, {'event': event});
                });

                event.preventDefault();
            }
        });
    };
});

app.directive('customOnChange', ['$parse', function($parse) {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
          var onChangeHandler = scope.$eval(attrs.customOnChange);
          element.bind('change', onChangeHandler);
        }
      };
}]);

app.filter('urlEncode', [function() {
	  return window.encodeURIComponent;
}]);

app.filter('imagePath', function(consts) {
    return function(name, path, isThumbnail) {
    	isThumbnail = (typeof isThumbnail == 'undefined' ? false : isThumbnail);
    	
    	var p = null;
    	
    	if(path && name) p = consts.FILE_SERVER + path + (path.slice(-1) != "/" ? "/" : "")  + (isThumbnail ? consts.THUMB_PATH : '') + name;
    
    	return p;
    };
});

app.filter('imagePath1', function(consts) {
    return function(name, path, isImgType) {
    	
    	var p = null;
    	
    	if(isImgType == 'undefined' || isImgType == null) {
    		if(path && name) p = consts.FILE_SERVER + path + (path.slice(-1) != "/" ? "/" : "")  + (isThumbnail ? consts.THUMB_PATH : '') + name;
    	}else if(isImgType == 'list' || isImgType == 'detail') {
    		if(path && name) p = consts.FILE_SERVER + path + (path.slice(-1) != "/" ? "/" : "")  + (isImgType == 'list' ? consts.LIST_PATH : consts.DETAIL_PATH) + name;
    	}
    	return p;
    };
});

app.filter('localeValue', function(locale) {
    return function(columnName, row, useDefault, l) {
    	useDefault = (typeof useDefault == 'undefined' ? true : useDefault);
    	if(!l) l = locale;
    	
    	var s = null;
    	var n = columnName + "_" + l.toUpperCase();
    	
    	if(row != null){
    		if(row[n]) s = row[n];
    		if(!s && useDefault) s = row[columnName];
    	}
    	
    	return s;
    };
});

app.filter('localeOrdinal', function(locale) {
    return function(n, l) {
    	if(!l) l = locale;
    	if (n != "") 
    	{
    		if(l == "ko" ) return "제" + n + "회";
        	
        	var s = ["th","st","nd","rd"],
        	v = n % 100;
           
        	return n+(s[(v-20)%10]||s[v]||s[0]);	
    	}
    	
    };
});

app.filter('trimSameCheck', function() {
    return function(v1, v2) {
    	if(v1 == undefined && v2 == undefined) return null;
    	if(v1 == undefined) return v2;
    	if(v2 == undefined) return v1;
    	if(v1.replace(/ /gi, "") == v2.replace(/ /gi, "")) return null;
    	else return v1;
    };
});

app.filter('trimValueCheck', function() {
    return function(v1, v2) {
    	if(v2) return null;
    	else   return v1;
    };
});

app.filter('exchPrice', function($filter) {
    return function(p, baseCurrCD, exchCurrCD, exchRates) {
    	var p2 = 0;
    	
    	if(baseCurrCD == exchCurrCD){
    		p2 = p;
    	}else{
        	var rows = $filter('filter')(exchRates, {'BASE_CURR_CD':baseCurrCD, 'EXCH_CURR_CD':exchCurrCD}, true);
        	
        	if(rows && rows.length > 0 && rows[0]["RATE"] > 0){
        		p2 = p * rows[0]["BASE_PRICE"] / rows[0]["RATE"];
        	}
    	}
    	return p2 == 0 ? "" : $filter('number')(p2, 0);
    };
});

app.filter('dateFormat', function($filter, consts) {
    return function(d, format) {
    	format = (typeof format == 'undefined' ? consts.DEF_DATETIME_FMT : format);

    	return $filter('date')(d, format);
    };
});

app.filter('year', function($filter) {
    return function(d, format) {
    	format = (typeof format == 'undefined' ? 'yyyy' : format);

    	return $filter('date')(d, format);
    };
});

app.filter('timeDuration', function(locale) {
    return function(fromDT, toDT, f) {
    	if(!f) f = (locale == 'ko' ? 'd일 h시간 m분 s초' : 'd[Days] h[Hours] m[Minutes] s[Seconds]');
    	
    	var s = moment(toDT).diff(moment(fromDT), 'seconds'); //$filter('amDifference')(toDT, fromDT, 'seconds');
    	var d = moment.duration(s, "seconds").format(f);
    	return d;
    };
});

app.filter('timeDurationShort', function(locale) {
    return function(fromDT, toDT, f) {
    	if(!f) f = (locale == 'ko' ? 'd일 h:m:s' : 'd[Days] h:m:s');
    	
    	var s = moment(toDT).diff(moment(fromDT), 'seconds'); //$filter('amDifference')(toDT, fromDT, 'seconds');
    	var d = moment.duration(s, "seconds").format(f);
    	return d;
    };
});

app.filter('addHours', function() {
    return function(dt, v) {
    	var d = moment(dt).add(v, 'hours')
    	return d.toDate();
    };
});

app.filter('joinWith', function(consts) {
    return function(a, seperator) {
    	if(!seperator) seperator = ", ";
    	
    	return a.join(seperator);
    };
});

app.filter('split', function() {
    return function(input, splitChar, splitIndex) {
    	if(input == undefined) return undefined;
        return input.split(splitChar)[splitIndex];
    }
});

app.filter("size_text", function($filter){
	return function(src){
		var returnValue = "";
		var cmSize = "";
		var inchSize = "";
		
		cmSize = src.SIZE1 != 0 ? $filter('number')(src.SIZE1, 1) : "";
		cmSize += src.SIZE2 != 0 ? "☓" + $filter('number')(src.SIZE2, 1) : "";
		cmSize += src.SIZE3 != 0 ? "☓" + $filter('number')(src.SIZE3, 1) + 
				"(" + (src.MIX_CD == "depth" ? "d" : "h")  + ")": "";
		cmSize += cmSize != "" ? src.UNIT_CD : "";
		cmSize += cmSize != "" &&  src.CANVAS != 0 ? " (" + (src.CANVAS_EXT_YN == "Y" ? "변형" : "") + src.CANVAS + ")" : "";

		inchSize = src.SIZE1 != 0 ? $filter('number')(src.SIZE1 * 0.393701, 1) : "";
		inchSize += src.SIZE2 != 0 ? "☓" + $filter('number')(src.SIZE2 * 0.393701, 1) : "";
		inchSize += src.SIZE3 != 0 ? "☓" + $filter('number')(src.SIZE3 * 0.393701, 1) + "(" + (src.MIX_CD == "depth" ? "d" : "h")  + ")": "";
		inchSize += inchSize != "" ? "in" : "";
		
		returnValue = src.PREFIX;
		returnValue += (src.DIAMETER_YN == "Y" ? "Φ " : "") + cmSize;  
		returnValue += (src.SUFFIX ? " (" + src.SUFFIX + ") " : "") + (inchSize != "" ?  ", " + inchSize : "");

    	return returnValue;
	}
});

app.filter("size_text_cm", function($filter){
	return function(src){
		var returnValue = "";
		var cmSize = "";
		
		cmSize = src.SIZE1 != 0 ? $filter('number')(src.SIZE1, 1) : "";
		cmSize += src.SIZE2 != 0 ? "☓" + $filter('number')(src.SIZE2, 1) : "";
		cmSize += src.SIZE3 != 0 ? "☓" + $filter('number')(src.SIZE3, 1) + 
				"(" + (src.MIX_CD == "depth" ? "d" : "h")  + ")": "";
		cmSize += cmSize != "" ? src.UNIT_CD : "";
		cmSize += cmSize != "" &&  src.CANVAS != 0 ? " (" + (src.CANVAS_EXT_YN == "Y" ? "변형" : "") + src.CANVAS + ")" : "";
		
		returnValue = src.PREFIX;
		returnValue += (src.DIAMETER_YN == "Y" ? "Φ " : "") + cmSize;  
		returnValue += (src.SUFFIX ? " (" + src.SUFFIX + ") " : "");

    	return returnValue;
	}
});

app.filter("size_text_in", function($filter){
	return function(src){
		var returnValue = "";
		var inchSize = "";		
		
		inchSize = src.SIZE1 != 0 ? $filter('number')(src.SIZE1 * 0.393701, 1) : "";
		inchSize += src.SIZE2 != 0 ? "☓" + $filter('number')(src.SIZE2 * 0.393701, 1) : "";
		inchSize += src.SIZE3 != 0 ? "☓" + $filter('number')(src.SIZE3 * 0.393701, 1) + "(" + (src.MIX_CD == "depth" ? "d" : "h")  + ")": "";
		inchSize += inchSize != "" ? "in" : "";
		
		returnValue = src.PREFIX;
		returnValue += (src.DIAMETER_YN == "Y" ? "Φ " : "") + inchSize;  
		returnValue += (src.SUFFIX ? " (" + src.SUFFIX + ") " : "");

    	return returnValue;
	}
});
// IE 한글입력 오류로 추가. (2byte 문자문제)
app.config(function ($provide) {
    $provide.decorator('inputDirective', function($delegate, $log) {
        //$log.debug('Hijacking input directive');
        var directive = $delegate[0];
        angular.extend(directive.link, {
            post: function(scope, element, attr, ctrls) {
                element.on('compositionupdate', function (event) {
                    element.triggerHandler('compositionend');
                })
            }
        });
        return $delegate;
    });
});	

//ng-bind-html에 스타일 속성 적용되게 함
app.filter('unsafe', ['$sce', function ($sce) {
    return function (input) {
        return $sce.trustAsHtml(input);
    }
}]);

//String replace
app.filter('replace', [function () {

    return function (input, from, to) {
      
      if(input === undefined) {
        return;
      }
  
      var regex = new RegExp(from, 'g');
      return input.replace(regex, to);
       
    };

}]);


