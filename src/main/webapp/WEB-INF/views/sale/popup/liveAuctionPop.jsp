<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="custom-modal" class="modal modal02" style="top:100px; display: block; padding:0px;">
  <div id="overlay" class="pop_wrap">
	<button type="button" ng-click="close();" class="sp_btn btn_pop_close">
		<span class="hidden"><spring:message code="label.close" /></span>
	</button>
	<div class="title">
		<h2>온라인 실시간 응찰</h2>
	</div>
	<div class="cont">
		<div class="list_style01">
			<ul>
				<span style="line-height:24px;">
				온라인 경매 회차당 한번 번호 인증 후 경매에 참여하실 수 있습니다.<br/>
                사용하시는 휴대폰 번호를 입력 후 인증번호요청 버튼을 클릭하시면 휴대폰 번호에 인증 번호가 발송됩니다.
                그 번호를 휴대폰 인증번호에 넣고 인증 버튼을 누르면 완료됩니다.
				</span>
			</ul>
		</div>
		<form name="certForm">
			<fieldset>
				<div class="tbl_style01 m_tbl_z003 mt15">
					<table>
						<tbody>
						<tr>
							<th scope="row" style="width:100px;"><label for=""><spring:message code="label.mem.mobile" /></label><span class="ico_essen"><span class="hidden">필수입력</span></span></th>
							<td>
								<div class="fl_wrap type02">
									<div class="input_phone">
										<select ng-model="form_data.hp1" name="hp1" tabindex="13" style="width:70px; height:31px; text-align:center; padding: 4px 0;">
											<option value="" selected >선택</option>
											<option ng-repeat="hp in hp1s" value="{{hp}}">{{hp}}</option>
										</select>
										<span class="tbl_label number_bar">-</span>
										<input type="text" style="ime-mode:disabled;" ng-model="form_data.hp2" onkeypress="return onlyNumber(event);" 
											name="hp2" class="tac phone_number phone_number01" placeholder="앞자리" maxlength=4 tabindex="14"/>
										<span class="tbl_label number_bar01">-</span>
										<input type="text" style="ime-mode:disabled;" ng-model="form_data.hp3" onkeypress="return onlyNumber(event);" 
											name="hp3" class="tac phone_number" placeholder="뒷자리" maxlength=4 tabindex="15"/>
										<span>
											<span class="btn_style01 gray02"><button type="button" ng-click="authNumRequest()">{{auth_req_btn_txt}}</button></span>
										</span>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row" style="width:100px;"><label for="">휴대폰 인증</label><span class="ico_essen"><span class="hidden">필수입력</span></span></th>
							<td>
								<div class="fl_wrap type02">
									<div class="input_phone_auh">
										<input type="text" ng-model="form_data.auth_num" onkeypress="return onlyNumber(event);" class="tac" placeholder="인증번호" maxlength=6 ng-disabled="!form_data.can_auth" style="ime-mode:disabled; min-height:26px;"/>
										<span class="btn_style01 gray02"><button type="button" ng-click="authNumConfirm()" ng-disabled="!form_data.can_auth">인증</button></span>
										<p class="tbl_txt" ng-style="{'color': 'red', 'font-weight': 'bold'}">{{getHpAuthMsg()}}</p>
									</div>
								</div>
							</td>
						</tr>
						</tbody>
					</table>
				</div>
				<div class="list_style02 mt10" ><!-- 20150521 -->
			<div class="wrap_check opp">
				<div style="padding:15px;">
					<form> 
						<input class="number_popup_checkbox" type="checkbox" ng-model="chkAgree" name="chkAgree" id="chkAgree">   
						<span id="sp-click"></span>
						<label for="chbAgree" class="number_popup">
							<span ng-if="locale=='ko'" style="font-size:16px; color:#F60; font-weight:700; line-height:22px;">※ 아래 내용과 온라인 경매 약관을 잘 확인 했으며, 동의합니다.&nbsp;</span><span ng-if="locale!='ko'">I have read and consented to the content and the terms and conditions below.&nbsp;</span>
						</label>
					</form>     
				</div>
			</div>
            
            <ul style="font-size:12px;" ng-if="locale == 'ko'">
                <li ng-if="lot.SALE_NO != 510">낙찰 시, 낙찰금의 18%(부가세별도)의 구매수수료가 발생합니다.</li>
                <li ng-if="lot.SALE_NO == 510">낙찰 후 최종 결제금액은 낙찰금액+구매수수료(10%+VAT)입니다. Lot 41-64 번은 구매수수료가 없습니다.</li>
				<li>응찰 및 낙찰 후 취소가 불가능 하오니, 반드시 작품정보를 응찰 전에 확인하고 신중히 응찰해주십시오.</li>
                <li>응찰은 작품 컨디션 확인 후 진행 되는 것을 전제로 하며, 작품 컨디션에 액자 상태는 포함되지 않습니다.</li>			   
				<li>마감시간 30초 내에 응찰이 있을 경우, 자동으로 30초 연장됩니다.</li>
                <li>접속자의 컴퓨터, 인터넷 환경에 따라 반영 속도 차이가 있을 수 있으니 비딩시 유의해 주시기 바랍니다.</li>
                <li><strong class="txt_impo02">[1회 응찰] 또는 [자동 응찰] 버튼을 누르시면 '확인안내 없이' 바로 응찰이 되어 취소가 불가능합니다.</strong></li>
				<li><strong class="txt_impo02">남은 시간 1초 미만 시 응찰은 서버 반영 전 종료 될 수 있으니, 주의가 필요합니다.</strong></li>
				<li>[자동 응찰 중지하기]는 자동 응찰 '취소가 아닙니다'. 응찰자가 자동응찰을 중지하는 경우 중지 전까지의 응찰 및 낙찰은 유효합니다. 또한 자동응찰의 중지는 서버에 반영이 되는 시점에 효력이 발생하므로, <strong class="txt_impo02">응찰자가 중지버튼을 클릭한 시점보다 더 높은 금액에 중지되고 이 금액에 낙찰 될 수 있습니다.</strong></li>
                <li>서울옥션 경매 약관 <a href="/terms/page?view=auctionTerms" target="new" style="color:#00F">바로가기</a></li>
			</ul>
			
			<ul style="font-size:12px;" ng-if="locale != 'ko'">
                <li ng-if="lot.SALE_NO != 510">The final price after making the winning bid is the sum of the winning bid and the buyer’s commission (18% + VAT).</li>
                <li ng-if="lot.SALE_NO == 510">The final price after making the winning bid is the sum of the winning bid and the buyer’s commission (10% + VAT). There is no buyer’s commission for Lot 41-64.</li>
				<li>After a bid is made, it cannot be cancelled during the duration of the auction (regardless of whether it is the winning bid). Cancellation due to a change of mind or mis-pressing of the bid button is also not permitted. Therefore, please make sure to verify all details on the artwork before making your bid and make your bidding decision with great care.</li>
                <li>On principle, bidding is done after confirming the condition of the artwork. Depending on the condition of the artwork, the condition of the frame may not be included.</li>			   
				<li>If a bid is made within 30 seconds of the closing time, the bidding time will be automatically extended by 30 seconds.</li>
                <li>The speed differences reflect differently depending on the user's computer and internet environment. Please keep this in mind when you bid.</li>
                <li><strong class="txt_impo02">If you click on the “Single Bid” or “Automatic Bid” button, your bid will be made “without confirmation” and thus cannot be cancelled.</strong></li>
				<li><strong class="txt_impo02">If there is less than one second left before the closing time, access to the auction server may be terminated before a bid can be reflected. Please take this into account and exercise caution when making a last-minute bid.</strong></li>
				<li>Clicking on the “Cease Automatic Bid” button does not mean to cancel an automatic bid. Even though the bidder ceases his or her automatic bid, any (successful) bid will remain valid before it reflects. The cessation of an automatic bid goes into effect the moment it is registered on the server. Therefore, <strong class="txt_impo02">automatic bidding may stop at a bid price that is higher than the bid price at the moment the “Cease Automatic Bid” button was clicked by the user, and the bid made at this higher bid price could end up being the successful bid.</strong></li>
                <li> <a href="/terms/page?view=auctionTerms" target="new" style="color:#00F">Go to</a> Seoul Auction’s Terms</li>
			</ul>

		</div>
				<div class="btn_wrap">
					<span class="btn_style01 mid gray03">
						<button type="button" ng-click="close();"><span>취소</span></button>
					</span>
				</div>
			</fieldset>
		</form>
	</div>
  </div>
</div>
