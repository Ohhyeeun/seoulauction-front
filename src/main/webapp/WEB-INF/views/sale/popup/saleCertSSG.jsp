<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
  #custom-modal {
    display: block;
    top: 20px;
    padding: 0;
  }

  #custom-modal th.required::after {
    content: "*";
    color: #be4545;
  }

  #custom-modal .cont p {
    font-size: 13px;
    line-height: 1.5;
    word-break: keep-all;
  }

  #custom-modal .tbl_style01 {
    margin-top: 16px;
  }

  /* Inputs */
  #cust-name {
    height: 26px;
    width: 124px;
    border-radius: 2px;
  }

  /* Selectbox */
  #cert-hp1 {
    width: 70px;
    height: 31px; 
    text-align: center;
    padding: 4px 0;
  }

  #custom-modal .policy-wrap:not(:last-child) {
    margin-bottom: 16px;
  }

  #custom-modal .policy-checkbox-wrapper h3 {
    margin-bottom: 8px;
    font-weight: 600;
  }

  #custom-modal .policy-checkbox-wrapper .policy-content {
    border: 1px solid #d8d8d8;
    height: 72px;
    overflow: auto;
    padding: 8px 8px;
    margin-bottom: 8px;
    background-color: #fafafa;
  }

  #custom-modal .policy-checkbox-wrapper .policy-content p {
    font-size: 12px;
  }

  #custom-modal .policy-checkbox-wrapper .policy-content .strong {
    font-weight: 600;
    color: #f00;
  }

  #custom-modal .policy-checkbox-wrapper .policy-content-checkbox {
    font-size: 12px;
    /*word-break: keep-all;*/
    line-height: 1.6;
  }

  #custom-modal .policy-content-checkbox label {
    letter-spacing: -1px;
  }

  #custom-modal .policy-content-checkbox input[type="checkbox"].auctionagree_checkinput + label:before,
  #custom-modal .policy-content-checkbox input[type="checkbox"].auctionagree_checkinput:checked + label:before {
    margin-right: 4px;
  }  
</style>

<div id="custom-modal" class="modal modal02">
  <div id="overlay" class="pop_wrap">
    <button type="button" ng-click="close();" class="sp_btn btn_pop_close">
      <span class="hidden">{{locale === 'ko' ? '닫기' : 'Close'}}</span>
    </button>

    <div class="title">
      <h2>
        온라인 경매 번호인증 [<span id="planningTitle">{{sale.SALE_TH | localeOrdinal}} {{"TITLE" | localeValue : sale}}</span>]
      </h2>
    </div>

    <div class="cont">
      <p>
        온라인 경매 회차당 한번 번호 인증 후 경매에 참여하실 수 있습니다. <br />
        사용하시는 휴대폰 번호를 입력 후 인증번호요청 버튼을 클릭하시면 휴대폰 번호에 인증 번호가 발송됩니다.
        그 번호를 휴대폰 인증번호에 넣고 인증 버튼을 누르면 완료됩니다.
      </p>

      <form name="certForm">
        <fieldset>
          <div class="tbl_style01 m_tbl_z003">
            <table>
              <colgroup>
                <col width="*" />
                <col width="70%" />
              </colgroup>
              <tbody>
                <tr>
                  <th scope="row" class="required">{{locale === 'ko' ? '이름' : 'Name'}}</th>
                  <td>
                    <input type="text" name="name" id="cust-name" ng-model="form_data.name" tabindex="12" />
                  </td>
                </tr>

                <tr>
                  <th scope="row" class="required">{{locale === 'ko' ? '휴대폰' : 'Mobile Number'}}</th>
                  <td>
                    <div class="fl_wrap type02">
                      <div class="input_phone">
                        <select ng-model="form_data.hp1" name="hp1" id="cert-hp1" tabindex="13">
                          <option value="" selected>선택</option>
                          <option ng-repeat="hp in hp1s" value="{{hp}}">{{hp}}</option>
                        </select>

                        <span class="tbl_label number_bar">-</span>

                        <input type="text" ng-model="form_data.hp2" id="cert-hp2" name="hp2" onkeypress="return onlyNumber(event)" class="tac phone_number phone_number01" placeholder="앞자리" maxlength="4" tabindex="14" />

                        <span class="tbl_label number_bar01">-</span>

                        <input type="text" ng-model="form_data.hp3" id="cert-hp3" name="hp3" onkeypress="return onlyNumber(event)" class="tac phone_number" placeholder="뒷자리" maxlength="4" tabindex="15" />

                        <span>
                          <span class="btn_style01 gray02">
                            <button type="button" ng-click="authNumRequest()">
                              <span ng-if="locale=='ko'">{{auth_req_btn_txt}}</span>
                              <span ng-if="locale!='ko'">Certification Number</span>
                            </button>
                          </span>
                        </span>
                      </div>
                    </div>
                  </td>
                </tr>

                <tr>
                  <th scope="row" class="required">휴대폰 인증</th>
                  <td>
                    <div class="fl_wrap type02">
                      <div class="input_phone_auh">
                        <input type="text" ng-model="form_data.auth_num" onkeypress="return onlyNumber(event);" class="tac" placeholder="인증번호" maxlength="6" ng-disabled="!form_data.can_auth" style="ime-mode:disabled; min-height:26px;" />
                        <span class="btn_style01 gray02">
                            <!-- <button type="button" ng-click="authNumConfirmSSG()" ng-disabled="!form_data.can_auth"> -->
                            <button type="button" ng-click="authNumConfirmSSG()">
                              <span>{{locale !== 'ko' ? 'certification' : '인증' }}</span>
                            </button>
                          </span>
                        <p class="tbl_txt" ng-style="{'color': 'red', 'font-weight': 'bold'}">{{getHpAuthMsg()}}</p>
                      </div>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="mt10" ><!-- 20150521 -->
            <div class="agree_checkboxwrap">
              <p class="agree_checkbox_tit">
								<span>
									<span class="agree_checkbox_img"></span> {{locale === 'ko' ? '온라인 응찰 안내 (필독)' : 'Online Bidding Guide (must read)'}}
								</span>
              </p>
              <ul class="on_bidguide_list" ng-if="locale === 'ko'">
                <li ng-if="lot.SALE_NO != 510">낙찰 시, 낙찰금의 18%(부가세별도)의 구매수수료가 발생합니다.</li>
                <li ng-if="lot.SALE_NO == 510">낙찰 후 최종 결제금액은 낙찰금액+구매수수료(10%+VAT)입니다. Lot 41-64 번은 구매수수료가 없습니다.</li>
                <li><strong class="txt_impo02">응찰 및 낙찰은 취소가 불가능합니다.<br>낙찰 철회시 낙찰가의 30%에 해당하는 낙찰철회비가 부과되오니 신중히 응찰 바랍니다.</strong></li>
                <li>응찰은 작품 컨디션 확인 후 진행 되는 것을 전제로 하며, 작품 컨디션에 액자 상태는 포함되지 않습니다.</li>
                <li>마감시간 30초 내에 응찰이 있을 경우, 자동으로 30초 연장됩니다.</li>
                <li>접속자의 컴퓨터, 인터넷 환경에 따라 반영 속도 차이가 있을 수 있으니 비딩시 유의해 주시기 바랍니다.</li>
                <li><strong class="txt_impo02">[1회 응찰] 또는 [자동 응찰] 버튼을 누르시면 '확인안내 없이' 바로 응찰이 되어 취소가 불가능합니다.</strong></li>
                <li><strong class="txt_impo02">남은 시간 1초 미만 시 응찰은 서버 반영 전 종료 될 수 있으니, 주의가 필요합니다.</strong></li>
                <li>[자동 응찰 중지하기]는 자동 응찰 '취소가 아닙니다'. 응찰자가 자동응찰을 중지하는 경우 중지 전까지의 응찰 및 낙찰은 유효합니다. 또한 자동응찰의 중지는 서버에 반영이 되는 시점에 효력이 발생하므로, <strong class="txt_impo02">응찰자가 중지버튼을 클릭한 시점보다 더 높은 금액에 중지되고 이 금액에 낙찰 될 수 있습니다.</strong></li>
              </ul>

              <ul class="on_bidguide_list" ng-if="locale !== 'ko'">
                <li ng-if="lot.SALE_NO != 510">The final price after making the winning bid is the sum of the winning bid and the buyer’s commission (18% + VAT).</li>
                <li ng-if="lot.SALE_NO == 510">The final price after making the winning bid is the sum of the winning bid and the buyer’s commission (10% + VAT). There is no buyer’s commission for Lot 41-64.</li>
                <li><strong class="txt_impo02">After a bid is made, it cannot be cancelled during the duration of the auction (regardless of whether it is the winning bid).<br> Cancellation due to a change of mind or mis-pressing of the bid button is also not permitted. Therefore, please make sure to verify all details on the artwork before making your bid and make your bidding decision with great care.</strong></li>
                <li>On principle, bidding is done after confirming the condition of the artwork. Depending on the condition of the artwork, the condition of the frame may not be included.</li>
                <li>If a bid is made within 30 seconds of the closing time, the bidding time will be automatically extended by 30 seconds.</li>
                <li>The speed differences reflect differently depending on the user's computer and internet environment. Please keep this in mind when you bid.</li>
                <li><strong class="txt_impo02">If you click on the “Single Bid” or “Automatic Bid” button, your bid will be made “without confirmation” and thus cannot be cancelled.</strong></li>
                <li><strong class="txt_impo02">If there is less than one second left before the closing time, access to the auction server may be terminated before a bid can be reflected. Please take this into account and exercise caution when making a last-minute bid.</strong></li>
                <li>Clicking on the “Cease Automatic Bid” button does not mean to cancel an automatic bid. Even though the bidder ceases his or her automatic bid, any (successful) bid will remain valid before it reflects. The cessation of an automatic bid goes into effect the moment it is registered on the server. Therefore, <strong class="txt_impo02">automatic bidding may stop at a bid price that is higher than the bid price at the moment the “Cease Automatic Bid” button was clicked by the user, and the bid made at this higher bid price could end up being the successful bid.</strong></li>
              </ul>
            </div><!-- //agree_checkboxwrap -->
          </div><!-- //list_style02 -->

          <div class="policy-checkbox-wrapper">
            <h3><strong>[필수]</strong> 개인정보 수집 및 이용동의</h3>
            <div class="policy-wrap">
              <div class="policy-content">
                <p>㈜서울옥션은 정보주체의 동의에 따라 회원관리 및 양질의 서비스 제공을 위하여 다음과 같이 최소한의 개인 정보를 수집하고 있습니다.</p>
                <p>수집한 개인정보는 본 수집, 이용 목적 외의 다른 목적으로 사용되지 않습니다.</p>
                <br />
                <p>ο 수집항목</p>
                <p>-(필수) 성명, 전화번호, 경매 낙찰시 작품 배송지 주소, 신세계백화점 회원 아이디(ID)</p>
                <br />
                <p>ο 개인정보의 수집 및 이용목적</p>
                <p>회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.</p>
                <p>1.서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산</p>
                <p>경매를 통한 구매 및 요금 결제, 물품배송 또는 청구지 등 발송</p>
                <p>2.신세계백화점 어플을 통해 서울옥션 경매에 참여한 고객 관리</p>
                <p>경매 서비스 이용을 위한 본인확인 및 개인 식별, 중복 응찰 방지, 불량회원의 부정 이용 방지와 비인가 사용 방지, 불만처리 등 민원처리, 고지사항 전달</p>
                <br />
                <p>ο 개인정보의 보유 및 이용기간</p>
                <p>원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.</p>
                <br />
                <p>ο 동의를 거부할 권리가 있다는 사실과 동의 거부에 따른 불이익 내용</p>
                <br>
                <p class="strong">*위의 항목은 서비스 제공에 필수적으로 필요한 최소한의 개인정보이므로, 동의를 거부하실 경우 경매참여 서비스 이용이 불가능합니다.</p>
              </div>
              <div class="policy-content-checkbox">
                <input type="checkbox" id="checkAgreePrivacy" class="auctionagree_checkinput" ng-model="form_data.checkAgreePrivacy" />
                <label for="checkAgreePrivacy" class="auctionagree_check">개인정보 수집 및 이용동의를 읽었으며, 위 내용에 동의합니다.</label>
              </div>
            </div>

            <h3><strong>[선택]</strong> 홍보 및 마케팅 이용동의</h3>
            <div class="policy-wrap">
              <div class="policy-content">
                <p>ο 수집목적 : 회사의 경매 정보 제공, 경매 일정 안내, 전시 및 신규 사업 소개 등 홍보 및 마케팅 목적</p>
                <p>ο 수집항목 : 휴대전화번호</p>
                <br />
                <p class="strong">*귀하께서는 회사의 홍보 및 마케팅 목적 이용에 대한 동의를 거부할 수 있으나, 이 경우 경매 정보 및 경매 일정 안내 서비스 등이 제한 될 수 있습니다.</p>
              </div>
              <div class="policy-content-checkbox">
                <input type="checkbox" id="checkAgreeMarketing"  class="auctionagree_checkinput" ng-model="form_data.checkAgreeMarketing" />
                <label for="checkAgreeMarketing" class="auctionagree_check">홍보 및 마케팅을 위한 정보이용동의를 읽었으며, 위 내용에 동의합니다.</label>
              </div>
            </div>
          </div>

          <div class="mt10" ><!-- 20150521 -->
            <div class="agree_checkboxwrap">
              <p class="agree_checkbox_tit">
                <span ng-if="locale === 'ko'"><span class="agree_checkbox_img"></span>약관 동의 안내 (필수체크)</span>
                <span ng-if="locale !== 'ko'"><span class="agree_checkbox_img"></span>AGREEMENT ON AUCTION TERMS and IMPORTANT NOTICE (REQUIRED)</span>
              </p>
              <ul style="font-size: 12px;">
                <li class="agree_checkbox_li">
                  <input type="checkbox" name="agreeCert_checkbox" id="agex01" class="auctionagree_checkinput" ng-model="form_data.checkPolicy1" />
                  <label for="agex01" class="auctionagree_check">
                    <span ng-if="locale=='ko'" class="auctionagree_check_contents">본인은 서울옥션 경매약관 <a href="/terms/page?view=auctionTerms" target="_blank">[약관 <span style="color:#00f;" class="txt_under">바로보기</span>]</a>를 모두 읽고 이해하였으며, 그 적용에 동의합니다.</span>
                    <span ng-if="locale!='ko'" class="auctionagree_check_contents">I have read and understood “Auction Terms”<a href="/terms/page?view=auctionTerms" target="_blank">[<span style="color:#00f;" class="txt_under">View Terms and Conditions</span>]</a> and “Important Notices” and agreed to be bound by them.</span>
                  </label>
                </li>
                <li>
                  <input type="checkbox" name="agreeCert_checkbox" id="agex02" class="auctionagree_checkinput" ng-model="form_data.checkPolicy2" />
                  <label for="agex02" class="auctionagree_check">
                    <span ng-if="locale=='ko'" class="auctionagree_check_contents">응찰은 작품 실물 및 컨디션을 확인하셨음을 전제로 합니다.</span>
                    <span ng-if="locale!='ko'" class="auctionagree_check_contents">The Bidder shall be responsible for conducting his/her own research and satisfying himself/herself of the condition of the lots, including, but not limited to, damage and/or restoration of the lots and in respect of any entries provided in the Auction Catalogue or elsewhere.</span>
                  </label>
                </li>
                <li>
                  <input type="checkbox" name="agreeCert_checkbox" id="agex03" class="auctionagree_checkinput" ng-model="form_data.checkPolicy3" />
                  <label for="agex03" class="auctionagree_check">
                    <span ng-if="locale=='ko'" class="auctionagree_check_contents">낙찰자는 후 7일 이내(낙찰가 3억원 이상인 경우 21일 이내)에 구매수수료를 포함한 금액을 입금하여야 합니다. 구매수수료는 낙찰금액의 18%(부가세 별도)입니다.</span>
                    <span ng-if="locale!='ko'" class="auctionagree_check_contents">A Successful Bidder shall make full payments, including the amount of the Hammer Price, Buyer’s Premium and any applicable taxes within 7 days after the sale.(within 21 days if the Hammer Price is higher than or equal to KRW300,000,000)</span>
                  </label>
                </li>
                <li>
                  <input type="checkbox" name="agreeCert_checkbox" id="agex04" class="auctionagree_checkinput" ng-model="form_data.checkPolicy4" />
                  <label for="agex04" class="auctionagree_check">
                    <span ng-if="locale=='ko'" class="auctionagree_check_contents">낙찰자가 ①지정된 기일에 낙찰대금을 납부하지 않거나,②부득이 낙찰을 철회하는 경우,낙찰가의 30%에해당하는 금액을 낙찰철회비(위약금)로 납부하여야 합니다.</span>
                    <span ng-if="locale!='ko'" class="auctionagree_check_contents">A successful bidder must immediately pay a buyer withdrawal fee, corresponding to 30% of the hammer price, ①when the successful bidder fail to make a full payment, including the buyer’s premium, by the payment deadline or ②when withdrawing the successful bid for unavoidable reasons.</span>
                  </label>
                </li>
                <li>
                  <input type="checkbox" name="agree_checkbox_all" id="agreeCert_checkbox_all" ng-click="checkboxAll($event)" class="auctionagree_checkinput" />
                  <label for="agreeCert_checkbox_all" class="auctionagree_checkCert">
                    <span class="auctionagree_check_contents"><strong>{{locale === 'ko' ? '모두 동의합니다.' : 'All agree.'}}</strong></span>
                  </label>
                </li>
              </ul>
            </div>
          </div><!-- //list_style02 -->

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
