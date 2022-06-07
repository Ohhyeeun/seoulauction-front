<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
.paper_bid_btn{
    color: white;
    background-color: #00acac;
    width: 20px;
    height: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 15px;
    margin: 0px 3px 2px 3px;
}
.paper_bid_input{
	height:26px !important;
	font-size: 14px;
    font-weight: 600;
    letter-spacing: 0.5px;
}
</style>

<div id="custom-modal" class="modal" style="top:10px; display: block; padding:0px; width:700px" data-ng-init="loadBidRequest();">
  <div id="overlay" class="pop_wrap"> 
	<button type="button" ng-click="closeThisDialog();" class="sp_btn btn_pop_close">
		<span class="hidden"><spring:message code="label.close" /></span>
	</button>
	<div class="title">
		<h2><spring:message code="label.go.bid.request" /></h2>
	</div>
	<div class="cont">
		<!-- <div class="list_style01">
			<ul>
				<span ng-if="locale=='ko'">
					<li>응찰하시고자 하는 <strong class="txt_impo">내용이 맞는지 확인 하신 뒤, 응찰방법 선택 후 저장</strong>해주세요.</li>
					<li>현장 신청 시, 자동으로 예약되며 내정보에서 확인하실 수 있습니다.</li>
					<li><strong>서면 또는 전화 신청 건은 서울옥션 담당자 확인 후 상담을 통하여 다음 절차가 진행됩니다.</strong></li>
				</span>
				<span ng-if="locale!='ko'">
					<li>Please, check all the details below before choosing your bidding method. Also, do not forget to save.</li>
					<li>If you are applying on site, it will automatically be reserved and one can check your reservations status under ‘My Information’ menu.</li>
					<li><strong>Customers who are making absentee bid or bid over the phone will be contacted by the respective representatives.</strong></li>
				</span>
			</ul>
		</div> -->
		<form name="frmBidRequest" id="frmBidRequest">
			<fieldset>
				<legend><span ng-if="locale=='ko'">작품응찰신청</span><span ng-if="locale!='ko'">Application for Artwork</span></legend>
				<div class="tbl_style01 m_tbl_z003 mt15">
					<table class="offline_bidtable">    
						<caption><span ng-if="locale=='ko'">작품응찰신청</span><span ng-if="locale!='ko'">Application for Artwork</span></caption>
						<%-- <colgroup>
							<col width="25%">   
							<col width="75%">      
						</colgroup> --%>    
						<tbody>
							<tr>
								<th scope="row"><span ng-if="locale=='ko'">경매명</span><span ng-if="locale!='ko'">Sale Title</span></th>
								<td><strong id="reqTitle"><span ng-if="sale.SALE_NO != '408'">{{sale.SALE_TH | localeOrdinal}}</span> {{sale.TITLE_JSON[locale]}}</strong></td>
							</tr>
							<tr>
								<th scope="row"><label for=""><span ng-if="locale=='ko'">Lot번호</span><span ng-if="locale!='ko'">Lot No.</span></label></th>
								<td>
									<div class="fl_wrap">
										{{lot.LOT_NO}}
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for=""><span ng-if="locale=='ko'">작가명</span><span ng-if="locale!='ko'">Name</span></label></th>
								<td><strong id="artistInfo">{{lot.ARTIST_NAME_JSON[locale]}}<strong></td>
							</tr>
							<tr>
								<th scope="row"><label for=""><span ng-if="locale=='ko'">작품명</span><span ng-if="locale!='ko'">Title</span></label></th>
								<td><strong id="WorkInfo">{{lot.TITLE_JSON[locale]}}<strong></td>
							</tr>
							<tr>
								<th scope="row"><span ng-if="locale=='ko'">추정가</span><span ng-if="locale!='ko'">Estimated Price</span></th>
								<td ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'">
<!-- 									<span ng-if="sale.CURR_CD != 'HKD'"><strong id="reqTitle">{{lot.EXPE_PRICE_FROM_JSON.KRW | number : 0}} ~ {{lot.EXPE_PRICE_TO_JSON.KRW | number : 0}} (KRW) </strong></span> -->
									<span ng-if="sale.SALE_KIND_CD != 'hongkong'"><strong id="reqTitle">{{lot.EXPE_PRICE_FROM_JSON[sale.CURR_CD] | number : 0}} ~ {{lot.EXPE_PRICE_TO_JSON[sale.CURR_CD] | number : 0}} ({{sale.CURR_CD}}) </strong></span>
									<span ng-if="sale.SALE_KIND_CD == 'hongkong'"><strong id="reqTitle">{{lot.EXPE_PRICE_FROM_JSON.HKD | number : 0}} ~ {{lot.EXPE_PRICE_TO_JSON.HKD | number : 0}} (HKD) </strong></span>
								</td>
								<td ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'">
									<span><strong id="reqTitle"><spring:message code="label.auction.detail.Request" /></span>
<!-- 									<span ng-if="sale.SALE_KIND_CD == 'hongkong'"><strong id="reqTitle">{{lot.EXPE_PRICE_FROM_JSON.HKD | number : 0}} ~ {{lot.EXPE_PRICE_TO_JSON.HKD | number : 0}} (HKD) </strong></span> -->
								</td>
							</tr>

							<tr>
								<th scope="row "><span ng-if="locale=='ko'">응찰방법</span><span ng-if="locale!='ko'">Bidding Type</span></th>
								<td>
									<div class="wrap_check">
										<!--
										<div>
											<input type="radio" ng-model="save_data.bid_kind_cd" value="place" ng-change="changeBidKind()"/>
											<label for="paddleSite">현장</label>
										</div>
										-->
										<div>
											<input type="radio" ng-model="save_data.bid_kind_cd" id="paddlePaper" value="paper_online" ng-change="changeBidKind()" />
											<label for="paddlePaper"><span ng-if="locale=='ko'">서면</span><span ng-if="locale!='ko'">Absentee Bid</span></label>
										</div>
										<div>
											<input type="radio" ng-model="save_data.bid_kind_cd" id="paddlePhone" value="phone" ng-change="changeBidKind()" />
											<label for="paddlePhone"><span ng-if="locale=='ko'">전화</span><span ng-if="locale!='ko'">Telephone Bid</span></label>
										</div>
										<div>
											<input type="radio" ng-model="save_data.bid_kind_cd" id="paddlePaperPhone" value="paper_phone" ng-change="changeBidKind()" />
											<label for="paddlePaperPhone"><span ng-if="locale=='ko'">서면 + 전화</span><span ng-if="locale!='ko'">Absentee+Telephone Bid</span></label>
										</div>
									</div>
									<div class="wrap" ng-if="save_data.bid_kind_cd == 'paper_online' && (lot.EXPE_PRICE_INQ_YN == 'Y' || sale.CURR_CD == 'USD')">
										<div class="offline_bidpricebox"> 
											<input ng-init="save_data.bid_price=bid_auto_price" ng-model="save_data.bid_price" type="text" name="" id="" maxlength="16" class="tar paper_bid_input" onkeyup="moneyFormat(event, this);" />
										</div>
										<span style="font-size:16px; align-self:flex-end; margin-left:7px;">{{sale.CURR_CD}} ( {{viewKorean(save_data.bid_price.toString())}} )</span>
									</div>
									<div class="wrap offline_priceguide" ng-if="save_data.bid_kind_cd == 'paper_online' || save_data.bid_kind_cd == 'paper_phone' && lot.EXPE_PRICE_INQ_YN != 'Y' && sale.CURR_CD != 'USD'">
										<div class="offline_bidpricebox clearfix">  
											<input ng-model="bid_auto_price" type="text" name="" id="" maxlength="16" class="tar paper_bid_input" onkeyup="moneyFormat(event, this);" readonly/>
										</div>  
										<div class="offline_pl_mibtn clearfix">  
											<button type="button" id="btnAutoLimitUp" class="paper_bid_btn" ng-click="setBidAutoPriceAuto('up');">
												<span>+</span>
												<span class="hidden">상향</span>
											</button>
											<button type="button" id="btnAutoLimitDown" class="paper_bid_btn" ng-click="setBidAutoPriceAuto('down'); ">
												<span>-</span>
												<span class="hidden">하향</span>  
											</button>
										</div>
										<span class="offline_bidprice_crt clearfix" style="margin-left:5px;">{{sale.CURR_CD}} ( {{viewKorean(bid_auto_price.toString())}} )</span>
									</div>   
									
								</td>
							</tr>
							<!-- <tr>
								<th scope="row"><label for=""><span ng-if="locale=='ko'">응찰금액</span><span ng-if="locale!='ko'">Maximum Price</span></label></th>
								<td>
									<div class="fl_wrap">
										<input type="text" ng-model="save_data.bid_price" onkeyup="moneyFormat(event, this);" ng-disabled="save_data.bid_kind_cd != 'paper_online'" style="text-align:right; height:22px;" />
									</div>
								</td>
							</tr> -->
							<tr>
								<th scope="row"><span ng-if="locale=='ko'">연락처 정보 확인</span><span ng-if="locale!='ko'">Contact</br>Information</span></th>
								<td style="padding-bottom: 0;">  
									<div>
										<div class="fl_wrap">											
											<strong class="tbl_label"><span ng-if="locale=='ko'">· 본인의 연락처 정보가 맞습니다.</span><span ng-if="locale!='ko'">· Please, confirm your contact information</span></strong>
											<div class="wrap_check">
												<div>
													<input type="checkbox" ng-model="chkCustInfo" name="" id="chkCustInfo" class="auctionagree_checkinput"/>  
													<label for="chkCustInfo" class="auctionagree_check" style="cursor:pointer;">     
														<span ng-if="locale=='ko'" class="auctionagree_check_contents" style="width: auto;">예. 맞습니다.</span>  
														<span ng-if="locale!='ko'" class="auctionagree_check_contents auctionagree_check_contents_en">Please, tick the box if information below is correct.</span>   
													</label>  
												</div> 
											</div> 
										</div>
										<p><span ng-if="locale=='ko'">연락처가 다르시면 회원정보수정 후 다시 신청해주세요.</span><span ng-if="locale!='ko'">If below contact information is incorrect, please change.</span></p>
										<span class="btn_style01 gray03 mt15">
											<a href="/customer/modifyForm" target="_blank"><span ng-if="locale=='ko'">회원정보수정 바로보기</span><span ng-if="locale!='ko'">Contact Info</span></a>
										</span>
										<div class="box_style09 mt15"> 
											<div class="list_style01 none">
												<ul>
													<li>
														<strong><span ng-if="locale=='ko'">주소 : </span><span ng-if="locale!='ko'">Address: </span></strong>
														<span id="reqAddress">{{custInfo.ADDR}} {{custInfo.ADDR_DTL}}</span>
													</li>
													<li>
														<strong><span ng-if="locale=='ko'">전화번호 : </span><span ng-if="locale!='ko'">Tel.: </span></strong>
														<span id="reqPhone">{{custInfo.TEL}}</span>
													</li>
													<li>
														<strong><span ng-if="locale=='ko'">휴대폰 : </span><span ng-if="locale!='ko'">Mobile: </span></strong>
														<span id="reqMobile">{{custInfo.HP}}</span>
													</li>
													<li>
														<strong><span ng-if="locale=='ko'">이메일 : </span><span ng-if="locale!='ko'">Email: </span></strong>
														<span id="reqEmail">{{custInfo.EMAIL}}</span>
													</li>
												</ul>
											</div>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="agree_checkboxwrap"> 
					<p class="agree_checkbox_tit">     
						<span ng-if="locale=='ko'"><span class="agree_checkbox_img"></span>약관 동의 안내 (필수체크)</span>    
						<span ng-if="locale!='ko'"><span class="agree_checkbox_img"></span>AGREEMENT ON AUCTION TERMS and IMPORTANT NOTICE(REQUIRED)</span>     
					</p>
					     
					<ul style="font-size:12px;">    
						<li class="agree_checkbox_li">     
							<input type="checkbox"  name="agreePop_checkbox" id="agree_ex01" class="auctionagree_checkinput" />            
							<label for="agree_ex01" class="auctionagree_check" style="cursor:pointer;">         
								<span ng-if="locale=='ko'" class="auctionagree_check_contents">본인은 서울옥션 경매약관 <a href="/terms/page?view=auctionTerms" target="_blank">[약관 <span style="color:#00f;" class="txt_under">바로보기</span>]</a>를 모두 읽고 이해하였으며, 그 적용에 동의합니다.</span> 
								<span ng-if="locale!='ko'" class="auctionagree_check_contents">I have read and understood “Auction Terms”<a href="/terms/page?view=auctionTerms" target="_blank">[<span style="color:#00f;" class="txt_under">View Terms and Conditions</span>]</a> and “Important Notices” and agreed to be bound by them.</span> 
							</label>      
							<!-- <p class="">     
								<span ng-if="locale=='ko'">- 본인은 응찰 작품/물품의 실물상태를 확인하였습니다.</span>
								<span ng-if="locale!='ko'">- Please, tick the box if you have checked the art work you are bidding.</span>
								<div class="wrap_check">
									<div>
										<input type="checkbox" ng-model="chkConfirm" name="" id="chkConfirm" >
										<label for="chbWorkChecked">
											<strong><span ng-if="locale=='ko'">예. 확인하였습니다.</span><span ng-if="locale!='ko'">Yes, I have checked the art work.</span></strong>
										</label>
									</div>
								</div>
							</p> --> 
<!-- 							<p class="txt"><span ng-if="locale=='ko'">※ 02)395-0330으로 연락주시어 미술경매팀에 문의하시면 작품상태를 유선으로 확인해드립니다.</span><span ng-if="locale!='ko'">※ Please, call our Auction department +82(2)-2075-4422 if you wish to check the condition of the art work(s). [E-mail: info@seoulauction.com.hk] </p> -->
						</li>
						<li>      
							<input type="checkbox" name="agreePop_checkbox" id="agree_ex02" class="auctionagree_checkinput" />            
							<label for="agree_ex02" class="auctionagree_check" style="cursor:pointer;">      
								<span ng-if="locale=='ko'" class="auctionagree_check_contents">응찰은 작품 실물 및 컨디션을 확인하셨음을 전제로 합니다.</span>
								<span ng-if="locale!='ko'" class="auctionagree_check_contents">The Bidder shall be responsible for conducting his/her own research and satisfying himself/herself of the condition of the lots, including, but not limited to, damage and/or restoration of the lots and in respect of any entries provided in the Auction Catalogue or elsewhere.</span>  
							</label>  
						</li>  
						<li>   
							<input type="checkbox" name="agreePop_checkbox" id="agree_ex03" class="auctionagree_checkinput" />            
							<label for="agree_ex03" class="auctionagree_check" style="cursor:pointer;">
								<span ng-if="locale=='ko'" class="auctionagree_check_contents">낙찰자는 후 7일 이내(낙찰가 3억원 이상인 경우 21일 이내)에 구매수수료를 포함한 금액을 입금하여야 합니다. 구매수수료는 낙찰금액의 18%(부가세 별도)입니다.</span>       
								<span ng-if="locale!='ko'" class="auctionagree_check_contents">A Successful Bidder shall make full payments, including the amount of the Hammer Price, Buyer’s Premium and any applicable taxes within 7 days after the sale.(within 21 days if the Hammer Price is higher than or equal to KRW300,000,000)</span>
							</label> 
						</li> 
						<li> 
							<input type="checkbox" name="agreePop_checkbox" id="agree_ex04" class="auctionagree_checkinput" />            
							<label for="agree_ex04" class="auctionagree_check" style="cursor:pointer;">    
								<span ng-if="locale=='ko'" class="auctionagree_check_contents">낙찰철회시 낙찰가의 30%에 해당하는 낙찰철회비가 부과됩니다.</span>
								<span ng-if="locale!='ko'" class="auctionagree_check_contents">When withdrawing the successful bid, a successful bidder must immediately pay a buyer withdrawal fee, corresponding to 30% of the hammer price.</span>
							</label>   
						</li> 
						<li>    
							<input type="checkbox" name="agreePop_checkbox_all" id="agreePop_checkbox_all" ng-click="checkboxAll()" class="auctionagree_checkinput" />            
							<label for="agreePop_checkbox_all" class="auctionagree_check" style="cursor:pointer;">    
								<span ng-if="locale=='ko'" class="auctionagree_check_contents"><strong>모두 동의합니다.</strong></span>       
								<span ng-if="locale!='ko'" class="auctionagree_check_contents"><strong>All agree.</strong></span>    
							</label>      
							<!-- <p class=""> 
								<span ng-if="locale=='ko'">- 본인은 ㈜서울옥션의 경매약관<a href="/terms/page?view=auctionTerms" target="_blank" class="txt_under">[약관 바로보기]</a>을 잘 읽었고 동의합니다.</span>
								<span ng-if="locale!='ko'">- I hereby acknowledge that I have read and understood the terms and conditions as provided by SeoulAuction co.,ltd.<a href="/terms/page?view=auctionTerms" target="_blank" class="txt_under">[Click here for Terms and Conditions]</a></span>
								&nbsp;<input type="checkbox" ng-model="chkAgree" name="" id="chkAgree" class="opp">
							</p> --> 
<!-- 							<div class="wrap_check opp"> -->
<!-- 								<div> -->
<!-- 									<label for="chbAgree"> -->
<!-- 										<strong><span ng-if="locale=='ko'">이에 동의합니다.</span><span ng-if="locale!='ko'">Please, tick the box if you confirm.</span></strong> -->
<!-- 									</label> -->
<!-- 									<input type="checkbox" ng-model="chkAgree" name="" id="chkAgree"> -->
<!-- 								</div> -->
<!-- 							</div> -->
						</li>
					</ul>  
					<p class="agree_contact">   
					<!-- 	<span ng-if="locale=='ko'">응찰 관련 문의가 있으신 경우, 
							<span ng-if="cust_manager.DEPT_NAME != null && cust_manager.EMP_NAME != null">귀하의 담당자(<span class="txt_green02"> {{cust_manager.DEPT_NAME}} {{cust_manager.EMP_NAME}} </span>)에게 연락주시기 바랍니다.</span>
							<span ng-if="cust_manager.DEPT_NAME == null || cust_manager.EMP_NAME == null">02-2075-4324 로 연락주시기 바랍니다.</span>
						</span> 
						<span ng-if="locale!='ko'">If you have any questions about bidding,
							{{cust_manager.DEPT_NAME_EN}}
							<span ng-if="cust_manager.EMP_NAME_EN != null">please contact your manager (<span class="txt_green02"> {{cust_manager.EMP_NAME_EN}} </span>).</span> 
							<span ng-if="cust_manager.EMP_NAME_EN == null">please call (+82(2)02-2075-4324).</span>
						</span> -->
						<!-- 담당자 O -->
						<span ng-if="cust_manager.EMP_NAME != null">
							<span ng-if="locale =='ko'">
								응찰 관련 문의가 있으신 경우, 귀하의 담당자 (
								<span class="txt_green02" title="{{cust_manager.TEL}}">{{cust_manager.EMP_NAME}} {{cust_manager.TEL}}</span>
								)에게 연락주시기 바랍니다.
							</span>
							<span ng-if="locale!='ko'">
								If you have any questions about bidding, 
								<span ng-if="cust_manager.EMP_NAME_EN != null">please contact your manager ( <span class="txt_green02">{{cust_manager.EMP_NAME_EN}} +82 {{cust_manager.TEL}} </span>).</span> 
								<span ng-if="cust_manager.EMP_NAME_EN == null">please contact your manager ( <span class="txt_green02">{{cust_manager.EMP_NAME}}  +82 {{cust_manager.TEL}} </span>).</span> 
							</span>
						</span>
						<!-- 담당자 X -->
						<span ng-if="cust_manager.EMP_NAME == null">
							<span ng-if="locale=='ko'">응찰 관련 문의가 있으신 경우, 02-2075-4324 또는 02-395-0330으 로 연락주시기 바랍니다.</span>
							<span ng-if="locale!='ko'">If you have any questions about bidding, please call (+82(2) 2075-4324 or +82(2) 395-0330).</span>
						</span>
					</p> 
				</div>
				<div class="btn_wrap">
					<span class="btn_style01 mid gray03">
						<button type="button" ng-click="closeThisDialog();"><span ng-if="locale=='ko'">취소</span><span ng-if="locale!='ko'">Cancel</span></button>
					</span>
					<span class="btn_style01 mid green02" ng-if="(lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
						<button type="button" ng-click="saveBidRequest(this);"><span ng-if="locale=='ko'">작품응찰신청</span><span ng-if="locale!='ko'">Bidding</span></button>
					</span>
				</div>
			</fieldset>
		</form>
	</div>
  </div>
</div>
