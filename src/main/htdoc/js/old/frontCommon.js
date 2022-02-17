/*
	프론트 공통 스크립트
*/

var m_sSalesName = "";
var m_sVideoName = "";
var m_sVideoUrl = "";
var m_sVideoImagePath = "";

//function showPurchasePopup(salesPlanningId, lotId, purchasePrice) {
//	var sUrl = "/nicePurchaseRequest?salesPlanningId=" + salesPlanningId + "&lotId=" + lotId + "&price=" + purchasePrice;
//	window.open(sUrl,'popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0');
//}

// 회원 탈퇴 팝업 닫기
function closeLeavePopup() {
	if(bIsLeft == true) {
		location.href = "/left";
	}
	else {
		modalClose();
	}
}

// 탈퇴 사유 선택
function rbReasonClick(elRadioReason) {
	if(elRadioReason == document.getElementById("rbReasonEtc")) {
		// 탈퇴 사유 기타 선택 시
		if(elRadioReason.checked == true) {
			$("#leaveReasonText").attr("disabled", false);
			$("#leaveReasonText").focus();
		}
		else {
			$("#leaveReasonText").val("");
			$("#leaveReasonText").attr("disabled", true);
		}
	}
	else {
		// 그 외 사유 선택 시에는 Free Text Reason Disabled 처리
		$("#leaveReasonText").val("");
		$("#leaveReasonText").attr("disabled", true);
	}
}

// 회원 탈퇴
function leaveClient() {
	if($("#leavePassword").val() == "") {
		alert("비밀번호를 입력해주세요.");
		$("#leavePassword").focus();
		return;
	}
	
	// 탈퇴 사유 선택 여부 확인
	var bIsReasonChecked = false;
	$("input[name=leave_reason]").each(function() {
		if(this.checked == true) {
			bIsReasonChecked = true;
		}
	});
	if(bIsReasonChecked == false) {
		alert("탈퇴 사유를 선택 혹은 입력해주세요.");
		return;
	}

	// 기타 사유 선택 시 탈퇴 사유 기입 유도
	if($("#rbReasonEtc")[0].checked == true) {
		if($("#leaveReasonText").val() == "") {
			alert("기타 사유를 입력해주세요.");
			$("#leaveReasonText").focus();
			return;
		}
	}
	
	$.ajax({
		url : '/myPage/leaveClientProc',
		data : $("#frmLeaveClient").serialize(),
		type: "POST",
		success : function(data) {
			var sResultCode = data.result;
			switch(sResultCode) {
				case "N" : {
					// 로그인 정보가 없는 경우
					alert("로그인 정보가 존재하지 않습니다.");
					location.href = "/login";
					break;
				}
				case "W" : {
					// 현재 비밀번호가 틀린 경우
					alert("현재 비밀번호를 다시 확인해주세요.");
					break;
				}
				case "F" : {
					// 비밀번호 변경에 실패한 경우
					alert("회원 탈퇴에 실패하였습니다.\n다시 확인 후 시도해 주세요.");
					break;
				}
				case "S" : {
					bIsLeft = true;
					$(".hide_container").hide();
					$("#frmLeaveClient").hide();
					$("#leaveResultContainer").show();
					break;
				}
			}
		},
		error : function(err){
			alert("Error!!\n" + err.responseText);
		}
	});
}

// Form 검색 조건들 초기화
function clearFormValues(frm) {
	var frm_elements = frm.elements;
	for (i = 0; i < frm_elements.length; i++)
	{
	    var field_type = frm_elements[i].type.toLowerCase();
	    var element_id = frm_elements[i].id;
	    if(element_id == "salesPlanningId") {
	    	continue;
	    }
	    switch (field_type)
	    {
		    case "text":
		    case "password":
		    case "textarea":
		    case "hidden":
		        frm_elements[i].value = "";
		        break;
		    case "radio":
		    case "checkbox":
		        if (frm_elements[i].checked)
		        {
		            frm_elements[i].checked = false;
		        }
		        break;
		    case "select-one":
		    case "select-multi":
		    	$("#" + element_id).selectbox("detach");
		        frm_elements[i].selectedIndex = 0;
		        $("#" + element_id).selectbox();
		        break;
		    default:
		        break;
	    }
	}
}

function showVideoPopup(sSalesName, sVideoName, sVideoUrl, sImageFilePath) {
	m_sSalesName = sSalesName;
	m_sVideoName = sVideoName;
	m_sVideoUrl = sVideoUrl;
	m_sVideoImagePath = sImageFilePath;
	$(".pop11").click();
}

function setVideoInfo() {
	$("#salesName").html(m_sSalesName);
	
	var winWidth = $(window).innerWidth();
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
	if(winWidth <= 767) {
		if(isMobile.any()) {
			var videoWidth = $("#mobVideoPlayer").parent().parent().css("width");
			jwplayer("mobVideoPlayer").setup({
				flashplayer: "/swf/player.swf",
				file: m_sVideoUrl,
				image: m_sVideoImagePath,
				width: videoWidth,
				height: "180"
			});
		}
		else {
			var videoWidth = $("#webVideoPlayer").parent().parent().css("width");
			jwplayer("webVideoPlayer").setup({
				flashplayer: "/swf/player.swf",
				file: m_sVideoUrl,
				image: m_sVideoImagePath,
				width: videoWidth,
				height: "180"
			});
		}
	}
	else {
		jwplayer("webVideoPlayer").setup({
			flashplayer: "/swf/player.swf",
			file: m_sVideoUrl,
			image: m_sVideoImagePath,
			width: "640",
			height: "390"
		});
	}
}

function searchKeyPress(event, bIsKorean) {
	if (event.which == 13) {
		event.preventDefault();
		goSearch("headerSearchContent", bIsKorean);
	}
}

function goSearch(elementId, bIsKorean) {
	var sSearchContent = $("#" + elementId).val().trim();

	if(sSearchContent) {
		//location.href = bIsKorean ? "/search?searchContent=" + sSearchContent : "/eng/search?searchContent=" + sSearchContent;
		setCookie('page', 1, 1);
		setCookie('keyword', sSearchContent, 1);
 		setCookie('keyword1', '', 1);
		$("#topSearchContent").val(sSearchContent);
		$("#frmTopSearch").submit();
	}
	else {
		alert(bIsKorean ? "검색어를 입력해주세요." : "Please write search keyword.");
	}
}

// 결제 팝업 호출
function showRegularPayPopup(bIsMoreInfo) {
	if(bIsMoreInfo) {
		window.open('/payRegularRequest?from=M','popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0');
	}
	else {
		window.open('/payRegularRequest','popup','width=720,height=750,toobar=0,resizable=yes,status=0,scrollbars=0');
	}
}

//사업자 등록번호 체크 함수
function checkBizID(bizID)
{
	// 사업자등록번호 체크
    // bizID는 숫자만 10자리로 해서 문자열로 넘긴다.
	var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
	var tmpBizID, i, chkSum = 0, c2, remander;
	bizID = bizID.replace(/-/gi, '');

	for(i = 0; i <= 7; i++) {
		chkSum += checkID[i] * bizID.charAt(i);
	}
	c2 = "0" + (checkID[8] * bizID.charAt(8));
	c2 = c2.substring(c2.length - 2, c2.length);
	chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1));
	remander = (10 - (chkSum % 10)) % 10;

	if (Math.floor(bizID.charAt(9)) == remander)
		return true; // OK!
	return false;
}

//input - 숫자만 입력
function numberOnly(value) {
	return value.replace(/[^0-9]/gi, ""); 
}

// 날짜 유효성 체크
function isValidDate(dateStr) {
	var year = Number(dateStr.substr(0, 4));
	var month = Number(dateStr.substr(4, 2));
	var day = Number(dateStr.substr(6, 2));

	if (month < 1 || month > 12) { // check month range
		return false;
	}

	if (day < 1 || day > 31) {
		return false;
	}

	if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31) {
		return false
	}

	if (month == 2) { // check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day > 29 || (day == 29 && !isleap)) {
			return false;
		}
	}
	return true;
}
