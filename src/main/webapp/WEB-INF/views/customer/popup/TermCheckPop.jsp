<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<head>
<script type="text/javascript" src="/js/angular/angular.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.js" ></script>
<link rel="stylesheet" href="/css/old/common.css?ver=20210902" type="text/css" />
<link rel="stylesheet" href="/css/sa.common.2.1.css?ver=20210902" type="text/css" />
</head>
<script>
$(function() {
	$("#termcheckForm").submit(function(){
		var checkboxLen = $("input:checkbox[name=agree_checkbox]").length; //체크박스 전체 개수
		var checkedLen = $("input:checkbox[name=agree_checkbox]:checked").length; //체크된 개수

		if(checkboxLen != checkedLen){
			alert(${locale == 'ko'}? "약관에 모두 동의해주세요." : "Please agree to all the terms and conditions." );
			return false;
		}
	});

});

function checkboxAll(){
	if($("#agree_checkbox_all").prop("checked")){
		$("input:checkbox[name=agree_checkbox]").prop("checked", true);
	}else{
		$("input:checkbox[name=agree_checkbox]").prop("checked", false);
	}
 }
</script>
<body>
	<div style="background: #fcfcfc;">
		<div class="membership_boxwrap">
			<div class="agree_checkboxwrap">
				<c:if test="${locale == 'ko'}">
				<h2 class="agree_checkboxwrap_tit">서울옥션 정회원</h2>
				<div class="list_style01 type02 agree_checkbox01">
					<ul>
						<li><strong>연회비</strong> 국내 20만원, 해외 500USD</li>
						<li><strong>혜택</strong><br />
							오프라인 경매(메이저, 기획) 참여 자격 부여<br />
							오프라인 경매 도록 발송<br />
							서울옥션 달력 발송
						</li>
						<li><strong>환불안내</strong><br />
							가입직후 - 1개월 미만: 전액환불<br />
							1개월 이상 - 3개월 미만: 80% 환불<br />
							3개월 이상 - 6개월 미만: 60% 환불<br />
							가입 후 6개월 이상: 환불 미 진행
						</li>
					</ul>
				</div>
				</c:if>

				<p class="agree_checkbox_tit">
					<c:if test="${locale == 'ko'}"><span class="agree_checkbox_img"></span>약관 동의 안내 (필수체크)</c:if>
					<c:if test="${locale != 'ko'}"><span class="agree_checkbox_img"></span>AGREEMENT ON AUCTION TERMS and IMPORTANT NOTICE(REQUIRED)</c:if>
				</p>

				<ul style="font-size:12px;">
					<li class="agree_checkbox_li">
						<input type="checkbox" name="agree_checkbox" id="chk01" class="auctionagree_checkinput" />
						<label for="chk01" class="auctionagree_check" style="cursor:pointer;">
							<c:if test="${locale == 'ko'}"><span class="auctionagree_check_contents">본인은 서울옥션 경매약관 <a href="/terms/page?view=auctionTerms" target="_blank">[약관 <span style="color:#00f;" class="txt_under">바로보기</span>]</a>를 모두 읽고 이해하였으며, 그 적용에 동의합니다.</span></c:if>
							<c:if test="${locale != 'ko'}"><span class="auctionagree_check_contents">I have read and understood “Auction Terms”<a href="/terms/page?view=auctionTerms" target="_blank">[<span style="color:#00f;" class="txt_under">View Terms and Conditions</span>]</a> and “Important Notices” and agreed to be bound by them.</span></c:if>
						</label>
					</li>
					<li>
						<input type="checkbox" name="agree_checkbox" id="chk02" class="auctionagree_checkinput" />
						<label for="chk02" class="auctionagree_check" style="cursor:pointer;">
							<c:if test="${locale == 'ko'}"><span class="auctionagree_check_contents">응찰은 작품 실물 및 컨디션을 확인하셨음을 전제로 합니다.</span></c:if>
							<c:if test="${locale != 'ko'}"><span class="auctionagree_check_contents">The Bidder shall be responsible for conducting his/her own research and satisfying himself/herself of the condition of the lots, including, but not limited to, damage and/or restoration of the lots and in respect of any entries provided in the Auction Catalogue or elsewhere.</span></c:if>
						</label>
					</li>
					<li>
						<input type="checkbox" name="agree_checkbox" id="chk03" class="auctionagree_checkinput" />
						<label for="chk03" class="auctionagree_check" style="cursor:pointer;">
							<c:if test="${locale == 'ko'}"><span class="auctionagree_check_contents">낙찰자는 후 7일 이내(낙찰가 3억원 이상인 경우 21일 이내)에 구매수수료를 포함한 금액을 입금하여야 합니다. 구매수수료는 낙찰금액의 18%(부가세 별도)입니다.</span></c:if>
							<c:if test="${locale != 'ko'}"><span class="auctionagree_check_contents">A Successful Bidder shall make full payments, including the amount of the Hammer Price, Buyer’s Premium and any applicable taxes within 7 days after the sale.(within 21 days if the Hammer Price is higher than or equal to KRW300,000,000)</span></c:if>
						</label>
					</li>
					<li>
						<input type="checkbox" name="agree_checkbox" id="chk04" class="auctionagree_checkinput" />
						<label for="chk04" class="auctionagree_check" style="cursor:pointer;">
							<c:if test="${locale == 'ko'}"><span class="auctionagree_check_contents">낙찰자가 ①지정된 기일에 낙찰대금을 납부하지 않거나,②부득이 낙찰을 철회하는 경우,낙찰가의 30%에해당하는 금액을 낙찰철회비(위약금)로 납부하여야 합니다.</span></c:if>
							<c:if test="${locale != 'ko'}"><span class="auctionagree_check_contents">A successful bidder must immediately pay a buyer withdrawal fee, corresponding to 30% of the hammer price, ①when the successful bidder fail to make a full payment, including the buyer’s premium, by the payment deadline or ②when withdrawing the successful bid for unavoidable reasons.</span></c:if>
						</label>
					</li>
					<li>
						<input type="checkbox" name="agree_checkbox_all" id="agree_checkbox_all" onClick="checkboxAll()" class="auctionagree_checkinput" />
						<label for="agree_checkbox_all" class="auctionagree_check" style="cursor:pointer;">
							<c:if test="${locale == 'ko'}"><span ng-if="locale=='ko'" class="auctionagree_check_contents"><strong>정회원 혜택 및 안내사항, 경매약관에 모두 동의합니다.</strong></span> </c:if>
							<c:if test="${locale != 'ko'}"><span ng-if="locale!='ko'" class="auctionagree_check_contents"><strong>All agree.</strong></span></c:if>
						</label>
					</li>
				</ul>
				<form id="termcheckForm" name="termcheck" action="/customer/payRegularRequest" method="POST">
					<div class="btn_wrap">
						<span class="btn_style01 mid green02">   
							<button type="submit"><c:if test="${locale == 'ko'}">동의</c:if><c:if test="${locale != 'ko'}"> Agree</c:if></button>
						</span>

						<span class="btn_style01 mid gray03">
							<button type="button" onClick="window.close();"><c:if test="${locale == 'ko'}">취소</c:if><c:if test="${locale != 'ko'}">Cancel</c:if></button>
						</span>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
		</div><!-- //membership_boxwrap -->
	</div>
</body>
   

