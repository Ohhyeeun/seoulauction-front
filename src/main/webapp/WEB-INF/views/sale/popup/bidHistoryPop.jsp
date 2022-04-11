<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="custom-modal" class="modal modal02" data-ng-init="loadBidHistory();" style="top:50px; display: block; padding:0px;">
  <div id="overlay" class="pop_wrap">
	<button type="button" ng-click="closeThisDialog();" class="sp_btn btn_pop_close">
		<span class="hidden"><spring:message code="label.close" /></span>
	</button>
	<div class="title">
		<h2><spring:message code="label.go.bid.history" />
			[<span id="planningTitle">{{sale.SALE_TH | localeOrdinal}} {{sale.TITLE_JSON[locale]}}</span>]</h2>
	</div>
	<div class="cont">
		<div class="bid_data">
			<div class="lot">Lot.<strong id="lotNumberPop">{{lot.LOT_NO}}</strong></div>
			<div class="price" ng-if="locale == 'ko'">
				<div class="txt">응찰가 </div>
				<div class="unit">호가 단위 <strong id="bidPriceUnit">{{base_currency}} {{lot.GROW_PRICE | number:0}}</strong></div>
				<div class="box" id="initialPrice"><span>{{base_currency}}</span>{{lot.LAST_PRICE | number:0}}</div>
			</div>
			<div class="price" ng-if="locale != 'ko'">
				<div class="txt">bid price </div>
				<div class="unit">Asking price <strong id="bidPriceUnit">{{base_currency}} {{lot.GROW_PRICE | number:0}}</strong></div>
				<div class="box" id="initialPrice"><span>{{base_currency}}</span>{{lot.LAST_PRICE | number:0}}</div>
			</div>
			<div class="time" ng-if="locale == 'ko'">
				<div class="start">
					<dl>
						<dt>시작시간</dt>
						<dd>
							<span id="bidStartDate">{{lot.FROM_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidStartTime">{{lot.FROM_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
				<div class="end">
					<dl>
						<dt>마감시간</dt>
						<dd>
							<span id="bidEndDate">{{lot.TO_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidEndTime">{{lot.TO_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
			</div>
			<div class="time" ng-if="locale != 'ko'">
				<div class="start">
					<dl>
						<dt>Starting time</dt>
						<dd>
							<span id="bidStartDate">{{lot.FROM_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidStartTime">{{lot.FROM_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
				<div class="end">
					<dl>
						<dt>Estimated closing time</dt>
						<dd>
							<span id="bidEndDate">{{lot.TO_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidEndTime">{{lot.TO_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
			</div>
		</div>

		<div class="box_style02 bid_result" ng-if="locale == 'ko'">
			<div class="border02"><p class="txt_style02">현재 Lot의 <strong class="txt_impo">경매가 종료</strong>되었습니다.</p></div>
			<div id="resultImage" class="bg_img bg10">
				<div class="txt_style03" ng-if="lot.LAST_PRICE >= 0 && lot.BID_CNT > 0">
					<span><span class="txt_green" id="winnerId">{{lot.LAST_CUST_ID}}</span>님의</span> 낙찰을 축하드립니다.
				</div>
				<div class="txt_style03" ng-if="(!lot.LAST_PRICE || lot.LAST_PRICE == 0) && lot.BID_CNT < 1">
					 유찰 되었습니다. 
				</div>
			</div>
		</div>
		<div class="box_style02 bid_result" ng-if="locale != 'ko'">
			<div class="border02"><p class="txt_style02"><strong class="txt_impo">Closed</strong></p></div>
			<div id="resultImage" class="bg_img bg10">
				<div class="txt_style03" ng-if="lot.LAST_PRICE >= 0 && lot.BID_CNT > 0">
					<span><span class="txt_green" id="winnerId">{{lot.LAST_CUST_ID}}</span>&nbsp;Congratulations!</span> 
				</div>
				<div class="txt_style03" ng-if="(!lot.LAST_PRICE || lot.LAST_PRICE == 0) && lot.BID_CNT < 1">
					 Unsold 
				</div>
			</div>
		</div>
		
		 <div class="btn_wrap">
			<span class="btn_style01 gray" ng-if="locale == 'ko'">
				<button type="button" onclick="$('#goonlinebidGuide')[0].click();">온라인 경매 안내</button>
			</span>
			<span class="btn_style01 gray" ng-if="locale != 'ko'">
				<button type="button" onclick="$('#goonlinebidGuide')[0].click();">Online auction announcement</button>
			</span>
		<!--	<span id="btnPurchaseHistory" class="btn_style01 dark">
				<button type="button" onclick="goPurchaseHistory();">내 낙찰내역 보기</button>
			</span>-->
		</div>
		<div style="display:none;">
			<a id="goonlinebidGuide" href="/auctionGuide/page?view=onlinebidGuide" target="_blank"></a>
			<a id="goPurchaseHisotry" href="/myPage/biddingHistory" target="_blank"></a>
		</div>
		<div class="bid_table">
			<div class="count"><span>Bid.</span> <strong id="bidCount">{{lot.BID_CNT}}</strong></div>
			<!-- scroll -->
			<div class="scrollable web">
				<div class="scroller">
					<div class="tbl_style02">
						<table>
							<caption>경매결과</caption><!-- 수정 -->
							<colgroup>
								<col style="width:20%;" />
								<col style="width:20%;" />
								<col />
								<col style="width:20%;" />
							</colgroup>
							<thead>
								<tr ng-if="locale == 'ko'">
									<th scope="col">응찰자</th>
									<th scope="col">응찰가</th>
									<th scope="col">응찰시각</th>
									<th scope="col">상태</th>
								</tr>
								<tr ng-if="locale != 'ko'">
									<th scope="col">Bidder</th>
									<th scope="col">Bid price</th>
									<th scope="col">Bid time</th>
									<th scope="col">Status</th>
								</tr>
							</thead>
							<tbody id="tblBidListBody">
								<tr ng-show="bidList.length == 0" ng-if="locale == 'ko'">
									<td colspan="4" class="nodata">응찰자가 없습니다.</td>
								</tr>
								<tr ng-show="bidList.length == 0" ng-if="locale != 'ko'">
									<td colspan="4" class="nodata">There are no bidders.</td>
								</tr>
								<!-- ng-init 을 사용하면 팝업에서 refresh시 작동하지 않는다. last_bid_no 값을 직접 넣어도 작동하지 않는다. 그래서 함수 사용 -->
								<tr ng-repeat="bid in bidList" ng-class="bid.SOLD_YN == 'Y' ? 'bg' : ''" bind-html-compile="setLastBidNo(bid.BID_NO);">
									<td><span ng-if="bid.SELF_YN == 'Y'"><font color="red" style="font-weight:bolder">▶ {{bid.CUST_ID}}</font></span><span ng-if="bid.SELF_YN == 'N'">{{bid.CUST_ID}}</span></td>
									<td class="tar">{{bid.BID_PRICE | number:0}}</td>
									<td>{{bid.BID_DT | dateFormat}}</td>
									<td class="tac" ng-if="locale == 'ko'">
										<span class="state_box"><span class="state02" ng-if="bid.SOLD_YN == 'Y'">낙찰</span></span>
										<span ng-if="bid.BID_KIND_CD == 'online_auto'">(자동)</span>
									</td>
									<td class="tac" ng-if="locale != 'ko'">
										<span class="state_box"><span class="state02" ng-if="bid.SOLD_YN == 'Y'">winning bid</span></span>
										<span ng-if="bid.BID_KIND_CD == 'online_auto'">(Auto)</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- //scroll -->
		</div>
		<div class="btn_wrap">
			<span class="btn_style01 gray mid btn_pop_close">
				<button type="button" ng-click="closeThisDialog();"><spring:message code="label.close" /></button>
			</span>
		</div>
	</div>
  </div>
</div>
