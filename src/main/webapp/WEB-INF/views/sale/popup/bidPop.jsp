<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>



<div id="custom-modal" class="modal modal04" style="display: block; padding:0px;" data-ng-init="init();">
  <div id="overlay" class="pop_wrap">
	<button type="button" ng-click="close(this);" class="sp_btn btn_pop_close">
		<span class="hidden"><spring:message code="label.close" /></span>
	</button>
	<div class="title">
		<h2><spring:message code="label.go.bid.now" />
			[<span id="planningTitle">{{sale.SALE_TH | localeOrdinal}} {{sale.TITLE_JSON[locale]}}</span>]</h2>
	</div>
	<div class="cont">
		<!-- <div class="bid_data">
			<div class="lot">Lot.<strong id="lotNumberPop">{{lot.LOT_NO}}</strong></div>
			<div class="price" ng-if="locale == 'ko'">
				<div class="txt" >현재가</div>
				<div class="unit">호가 단위 <strong id="bidPriceUnit">{{base_currency}} {{lot.GROW_PRICE | number:0}}</strong></div>
				<div class="box" id="initialPrice"><span>{{base_currency}}</span>{{lot.LAST_PRICE | number:0}}</div>
			</div>
			<div class="price" ng-if="locale != 'ko'">
				<div class="txt">Current price</div>
				<div class="unit">Asking price <strong id="bidPriceUnit">{{base_currency}} {{lot.GROW_PRICE | number:0}}</strong></div>
				<div class="box" id="initialPrice"><span>{{base_currency}}</span>{{lot.LAST_PRICE | number:0}}</div>
			</div>
			<div class="time" ng-if="locale == 'ko'">
				<div class="remain">
					<dl>
						<dt>남은시간</dt>
						<dd>
							<span id="bidLeftTime">{{getDuration()}}</span>
						</dd>
					</dl>
				</div>
				<div class="start">
					<dl>
						<dt>시작시간</dt>
						<dd>
							<span id="bidStartDate" style="font-size:12px;">{{lot.FROM_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidStartTime" style="font-size:12px;">{{lot.FROM_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
				<div class="end">
					<dl>
						<dt id="bidEndText">마감예정시간</dt>
						<dd>
							<span id="bidEndDate" style="font-size:12px;">{{lot.TO_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidEndTime" style="font-size:12px;">{{lot.TO_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
			</div>
			<div class="time" ng-if="locale != 'ko'">
				<div class="remain">
					<dl>
						<dt>Remaining time</dt>
						<dd>
							<span id="bidLeftTime">{{getDuration()}}</span>
						</dd>
					</dl>
				</div>
				<div class="start">
					<dl>
						<dt>Starting time</dt>
						<dd>
							<span id="bidStartDate" style="font-size:12px;">{{lot.FROM_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidStartTime" style="font-size:12px;">{{lot.FROM_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
				<div class="end">
					<dl>
						<dt id="bidEndText">closing time</dt>
						<dd>
							<span id="bidEndDate" style="font-size:12px;">{{lot.TO_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidEndTime" style="font-size:12px;">{{lot.TO_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
			</div>
		</div>
        <div style="clear: both; padding:15px 0;"></div> -->
        
         <!-- <div class="web_only" style=" width:200px; display:inline; position:relative; float:left; padding-top:8px;"> -->
        <div class="web_only bid_web_only" style="/* width:290px; */ display:inline; position:relative; float:left; padding-top:8px; padding:10px 20px 10px 0;">
          <!-- <div style="text-align: center; width:180px; height:180px; margin:auto; display:inline-table;"> --> 
            <div style="text-align: center; max-width:280px; max-height: 300px; margin:auto; display: table; line-height:300px;">  
               <!-- <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="max-width:170px; max-height:170px; overflow:hidden;"/> -->
                <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="width: 100%; height: auto; overflow:hidden; vertical-align:middle;"/>  
            </div>
             <!-- <div style=" width:180px;line-height:25px; font-size:14px; font-weight:600; padding-top:10px; margin-top:10px; border-top:solid #CCC 1px;"> -->
            <div style=" width:auto; font-size:14px; font-weight:600; padding-top:10px; margin-top:10px; border-top:solid #CCC 1px;"> 
				<div class="lotnum auction_lotnum bid_lotnum">  
					<strong>{{lot.LOT_NO}}</strong>
					<!-- <span ng-if="sale_status == 'ING' && lot.STAT_CD != 'reentry'">
						<span ng-if="sale_status == 'ING' && !custInfo.CUST_NO" class="btn_interest web_only" onClick="alert('로그인 해주세요.\n Please login for use.')">	</span>	
						<span ng-if="custInfo.CUST_NO && lot.INTE_LOT_DEL == 'N'" class="btn_interest sele web_only" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" ></span>
					</span> -->
				</div> 
                <div class="name auction_workartist" style="line-height: 40px;">
               		<span ng-bind="lot.ARTIST_NAME_JSON[locale]"></span>
               	</div> 
                <div class="tit auction_worktitle" style="border:none; font-weight:normal;">
               	 <span ng-bind="lot.TITLE_JSON[locale]"></span>
                </div> 
                <div class="workmaterial02" style="border:none; padding-top: 5px; font-weight: normal; line-height: 20px;">
	                <span ng-bind="'MATE_NM_EN' | localeValue : lot"></span> 
	                <p ng-repeat="size in lot.LOT_SIZE_JSON"><span ng-bind="size | size_text"></span></p> 
	                <p ng-if='lot.MAKE_YEAR_JSON[locale]'><span ng-bind="lot.MAKE_YEAR_JSON['ko']"></span></p> 
	                <!--<p ng-if='lot.SIGN_INFO_JSON[locale]'><span bind-html-compile="lot.SIGN_INFO_JSON['ko']"></span></p>-->
          	 	</div>
          	 </div>
       	 </div>
         
            <!-- <div style=" width:180px;line-height:25px; font-size:14px; font-weight:600; padding-top:10px; margin-top:10px; border-top:solid #CCC 1px;">
                <div class="name"><span ng-bind="lot.ARTIST_NAME_JSON[locale]"></span></div> 
                <div class="tit"><span ng-bind="lot.TITLE_JSON[locale]"></span></div> 
                <span ng-if="lot.MATE_NM" ng-bind="'MATE_NM' | localeValue : lot"></span> 
                <p ng-repeat="size in lot.LOT_SIZE_JSON"><span ng-bind="size | size_text"></span></p> 
                <p ng-if='lot.MAKE_YEAR_JSON[locale]'><span ng-bind="lot.MAKE_YEAR_JSON['ko']"></span></p> 
                <!--<p ng-if='lot.SIGN_INFO_JSON[locale]'><span bind-html-compile="lot.SIGN_INFO_JSON['ko']"></span></p>->
            </div> -->
            
            <!-- <div class="web_only" style="padding-top:25px;" ng-if="locale == 'ko'">
                <p style="text-align:center; font-size:16px; font-weight:700;">[변경 호가 테이블]</p>
                <table class="bidtable">
                    <tr style="text-align:right;">
                        <td><p style="font-weight:700;">이상</p></td>
                        <td><p style="font-weight:700;">미만</p></td>
                        <td><p style="font-weight:700;">호가</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>~</p></td>
                        <td><p>100 <font>만원</font></p></td>
                        <td><p>5 <font>만원</font></p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>50 <font>만원</font></p></td>
                        <td><p>100 <font>만원</font></p></td>
                        <td><p>5 <font>만원</font></p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>100 <font>만원</font></p></td>
                        <td><p>300 <font>만원</font></p></td>
                        <td><p>10 <font>만원</font></p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>300 <font>만원</font></p></td>
                        <td><p>500 <font>만원</font></p></td>
                        <td><p>20 <font>만원</font></p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>500 <font>만원</font></p></td>
                        <td><p>1,000 <font>만원</font></p></td>
                        <td><p>30 <font>만원</font></p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>1,000 <font>만원</font></p></td>
                        <td><p>3,000 <font>만원</font></p></td>
                        <td><p>50 <font>만원</font></p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>3,000 <font>만원</font></p></td>
                        <td><p>5,000 <font>만원</font></p></td>
                        <td><p>100 <font>만원</font></p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>5,000 <font>만원</font></p></td>
                        <td><p>1 <font>억원</font></p></td>
                        <td><p>200 <font>만원</font></p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>1 <font>억원</font></p></td>
                        <td><p>2 <font>억원</font></p></td>
                        <td><p>300 <font>만원</font></p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>2 <font>억원</font></p></td>
                        <td><p>~</p></td>
                        <td><p>500 <font>만원</font></p></td>
                    </tr>
                </table>
            </div> -->
            
            <!-- <div class="web_only" style="padding-top:25px;" ng-if="locale != 'ko'">
                <p style="text-align:center; font-size:16px; font-weight:700;">BIDDING INCREMENTS</p>
                <table class="bidtable">
                	<tr style="text-align:right;">
                		<td>from(￦)</td>
                		<td>to(￦)</td>
                		<td>by(￦)</td>
                	</tr>
                    <tr style="text-align:right;">
                        <td><p>~</p></td>
                        <td><p>1M</p></td>
                        <td><p>50K</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>500K</td>
                        <td><p>1M</p></td>
                        <td><p>50K</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>1M</td>
                        <td><p>3M</p></td>
                        <td><p>100K</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>3M</td>
                        <td><p>5M</p></td>
                        <td><p>200K</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>5M</td>
                        <td><p>10M</p></td>
                        <td><p>300K</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>10M</td>
                        <td><p>30M</p></td>
                        <td><p>500K</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>30M</td>
                        <td><p>50M</p></td>
                        <td><p>1M</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>50M</td>
                        <td><p>100M</p></td>
                        <td><p>2M</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>100M</td>
                        <td><p>200M</p></td>
                        <td><p>3M</p></td>
                    </tr>
                    <tr style="text-align:right;">
                        <td><p>200M</td>
                        <td><p>~</p></td>
                        <td><p>5M</p></td>
                    </tr>
                </table>
                <span  style="text-align:left; color:blue;"><strong>※ 1K = 1,000<br/> &nbsp;&nbsp;&nbsp;&nbsp;1M = 1,000,000<br/>&nbsp;&nbsp;&nbsp;&nbsp;￦ = KRW</strong></span>
            </div>   -->    
         
         <div style="width:720px; display:inline; position:relative;">
         	<div class="bid_data"> 
			<!--<div class="lot bid_lot"> Lot. <strong id="lotNumberPop">{{lot.LOT_NO}}</strong></div> --> 
			<div class="price bid_now_price" ng-if="locale == 'ko'">
				<div class="txt" >현재가</div>
				<div class="unit">호가 단위 <strong id="bidPriceUnit">{{base_currency}} {{lot.GROW_PRICE | number:0}}</strong></div>
				<div class="box" id="initialPrice"><span>{{base_currency}}</span>{{lot.LAST_PRICE | number:0}}</div>
			</div>
			<div class="price bid_now_price bid_now_price_en" ng-if="locale != 'ko'">
				<div class="txt">Current price</div>
				<div class="unit">Asking price <strong id="bidPriceUnit">{{base_currency}} {{lot.GROW_PRICE | number:0}}</strong></div>
				<div class="box" id="initialPrice"><span>{{base_currency}}</span>{{lot.LAST_PRICE | number:0}}</div>
			</div>
			<div class="time" ng-if="locale == 'ko'">
				<div class="remain">
					<dl>
						<dt>남은시간</dt>
						<dd>
							<span id="bidLeftTime">{{getDuration()}}</span>
						</dd>
					</dl>
				</div>
				<div class="start">
					<dl>
						<dt>시작시간</dt>
						<dd>
							<span id="bidStartDate" style="font-size:12px;">{{lot.FROM_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidStartTime" style="font-size:12px;">{{lot.FROM_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
				<!-- <div class="end">
					<dl>
						<dt id="bidEndText">마감예정시간</dt>
						<dd>
							<span id="bidEndDate" style="font-size:12px;">{{lot.TO_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidEndTime" style="font-size:12px;">{{lot.TO_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div> -->
			</div>
			<div class="time" ng-if="locale != 'ko'">
				<div class="remain">
					<dl>
						<dt>Remaining time</dt>
						<dd>
							<span id="bidLeftTime">{{getDuration()}}</span>
						</dd>
					</dl>
				</div>
				<div class="start">
					<dl>
						<dt>Starting time</dt>
						<dd>
							<span id="bidStartDate" style="font-size:12px;">{{lot.FROM_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidStartTime" style="font-size:12px;">{{lot.FROM_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div>
				<!-- <div class="end"> 
					<dl>
						<dt id="bidEndText">closing time</dt>
						<dd>
							<span id="bidEndDate" style="font-size:12px;">{{lot.TO_DT | date:'yyyy-MM-dd'}}</span>
							<span id="bidEndTime" style="font-size:12px;">{{lot.TO_DT | date:'HH:mm:ss'}}</span>
						</dd>
					</dl>
				</div> -->
			</div>
		</div> 
         
         	<div class="m_only">
              <!-- <div style="text-align: center; width:60px; height:60px; display: inline-block; float:left"> -->
               <div class="m_bidpop_img">
                  <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="max-width:100px; max-height:100px; overflow:hidden;/*max-width:55px; max-height:55px;*/"/>
              </div>
              <div class="bid_caption" style="display: inline-block;/* line-height:18px; */ font-size:14px; font-weight:600; max-width:260px;">
                  <div class="lotnum auction_lotnum" style="float:none;">
				 	<strong>{{lot.LOT_NO}}</strong>
				 </div>
                  <div class="name"><span ng-bind="lot.ARTIST_NAME_JSON[locale]"></span></div> 
                  <div class="tit" style="border:none; font-weight: normal;"><span ng-bind="lot.TITLE_JSON[locale]"></span></div> 
              </div>
              <div style="clear:both"></div>
          </div>
         
			<fieldset>
				<legend>응찰하기</legend>
				<div class="both_cont bid_form" ng-if="lot.END_YN == 'N'">
					<div ng-if="locale == 'ko'">
						<div class="box_style05 bid_box_style mb_bid_box_style">
							<div class="tit">1회 응찰가</div>
							<span class="unit">{{base_currency}}</span>
							<div class="wrap" style="height: 40px;">
								<div class="input_wrap">
									<input ng-model="$parent.bid_price" type="text" name="" id="biddingOncePrice" class="tar input_green bid_input_green" maxlength="16" onkeypress="biddingOnceKeyPress(event);" onkeyup="moneyFormat(event, this);" readOnly/>
								</div>
								<!--  <div class="btns">
									<button type="button" id="btnAutoOnceUp" class="sp_btn btn_bid_up" ng-click="setBidPrice('up');">
										<span class="hidden">상향</span>
									</button>
									<button type="button" id="btnAutoOnceDown" class="sp_btn btn_bid_down" ng-click="setBidPrice('down');">
										<span class="hidden">하향</span>
									</button>
								</div> -->
							</div>
							<div class="btn_wrap">
								<span class="btn_style01 xlarge" ng-class="{gray02: lot.IS_WIN == 'Y', green02: lot.IS_WIN == 'N'}">
									<button type="button" id="btnBiddingOnce" ng-click="bidOnce();" ng-disabled="lot.IS_WIN == 'Y'" title="※응찰전 주의사항&#13;응찰 및 낙찰 후 취소가 불가능합니다.&#13; 반드시 응찰전에 작품정보를 확인하고 신중히 응찰해주십시오">
									<span ng-if="lot.IS_WIN == 'N'"><spring:message code="message.Bid" /></span><span ng-if="lot.IS_WIN == 'Y'">최고가 응찰 중</span></button>
								</span>
							</div>
							<ul class="list_style01">
								<li><strong class="txt_impo02">응찰버튼을 누르시면 바로 응찰되어 취소가 불가능합니다.</strong></li>
                                <li>다음 응찰가격이 자동으로 조정됩니다.</li>
							</ul>
						</div>
					</div>
					<div ng-if="locale != 'ko'">
						<div class="box_style05 bid_box_style_en">
							<div class="tit">Single bid price</div>
							<span class="unit">{{base_currency}}</span>
							<div class="wrap" style="height:40px;">
								<div class="input_wrap">
									<input ng-model="$parent.bid_price" type="text" name="" id="biddingOncePrice" class="tar input_green bid_input_green" maxlength="16" onkeypress="biddingOnceKeyPress(event);" onkeyup="moneyFormat(event, this);" readOnly/>
								</div>
								<!--  <div class="btns">
									<button type="button" id="btnAutoOnceUp" class="sp_btn btn_bid_up" ng-click="setBidPrice('up');">
										<span class="hidden">상향</span>
									</button>
									<button type="button" id="btnAutoOnceDown" class="sp_btn btn_bid_down" ng-click="setBidPrice('down');">
										<span class="hidden">하향</span>
									</button>
								</div> -->
							</div>
							<div class="btn_wrap">
								<span class="btn_style01 xlarge" ng-class="{gray02: lot.IS_WIN == 'Y', green02: lot.IS_WIN == 'N'}">
									<button type="button" id="btnBiddingOnce" ng-click="bidOnce();" ng-disabled="lot.IS_WIN == 'Y'" title="※The pressing of this button cannot be cancelled.">
									<span ng-if="lot.IS_WIN == 'N'"><spring:message code="message.Bid" /></span><span ng-if="lot.IS_WIN == 'Y'">Currently bidding at highest price</span></button>
								</span>
							</div>
							<ul class="list_style01">
								<li><strong class="txt_impo02">Once you press the “Bid” button, your bid will be placed immediately. The pressing of this button cannot be cancelled.</strong></li>
                                <li>The next bid price will be adjusted automatically.</li>
							</ul>
						</div>
					</div>
					<div ng-if="locale == 'ko'">
						<div class="box_style05 bid_box_style">
							<div class="tit">자동응찰 한도가</div>
							<span class="unit">KRW</span>
							<div class="wrap">
								<div class="input_wrap">
									<input ng-model="$parent.bid_auto_price" type="text" name="" id="biddingAutoLimit" maxlength="16" class="tar input_green bid_input_green bid_input_green02" onkeyup="moneyFormat(event, this);" readonly/>
								</div>
								<div class="btns">
									<button type="button" id="btnAutoLimitUp" class="sp_btn btn_bid_up" ng-click="setBidAutoPriceAuto('up');">
										<span class="hidden">상향</span>
									</button>
									<button type="button" id="btnAutoLimitDown" class="sp_btn btn_bid_down" ng-click="setBidAutoPriceAuto('down');">
										<span class="hidden">하향</span>
									</button>
								</div>
							</div>
							<div class="btn_wrap">
								<span class="btn_style01 xlarge green02" ng-class="{gray02: auto_req_price &lt;= lot.LAST_PRICE, white02: auto_req_price > lot.LAST_PRICE}">
									<button type="button" id="btnAutoBidding"  ng-click="bidAuto();" title="※응찰전 주의사항&#13;응찰 및 낙찰 후 취소가 불가능합니다.&#13; 반드시 응찰전에 작품정보를 확인하고 신중히 응찰해주십시오">
										<span ng-if="auto_req_price &lt;= lot.LAST_PRICE"><spring:message code="message.Automatic bid" /></span>
										<span ng-if="auto_req_price > lot.LAST_PRICE">중지({{auto_req_price | number : 0}} 자동응찰 중)</span>
									</button>
								</span>
							</div>
							<ul class="list_style01">
								<li><strong class="txt_impo02">응찰버튼을 누르시면 바로 응찰되어 금액변경이나 취소가 불가능합니다.</strong></li>
                                <li> +/- 버튼으로 금액 조정 후, <strong>자동응찰</strong>누르면 응찰됩니다.</li>
							</ul>
						</div>
					</div>
					<div ng-if="locale != 'ko'">
						<div class="box_style05 bid_box_style_en bid_box_style_en02">
							<div class="tit">Automatic bid limit</div>
							<span class="unit">KRW</span>
							<div class="wrap">  
								<div class="input_wrap">
									<input ng-model="$parent.bid_auto_price" type="text" name="" id="biddingAutoLimit" maxlength="16" class="tar input_green bid_input_green02" onkeyup="moneyFormat(event, this);" readonly/>
								</div>
								<div class="btns">
									<button type="button" id="btnAutoLimitUp" class="sp_btn btn_bid_up" ng-click="setBidAutoPriceAuto('up');">
										<span class="hidden">+</span>
									</button>
									<button type="button" id="btnAutoLimitDown" class="sp_btn btn_bid_down" ng-click="setBidAutoPriceAuto('down');">
										<span class="hidden">-</span>
									</button>
								</div>
							</div>
							<div class="btn_wrap">
								<span class="btn_style01 xlarge green02" ng-class="{gray02: auto_req_price &lt;= lot.LAST_PRICE, white02: auto_req_price > lot.LAST_PRICE}">
									<button type="button" id="btnAutoBidding"  ng-click="bidAuto();" title="※The pressing of this button cannot be cancelled.">
										<span ng-if="auto_req_price &lt;= lot.LAST_PRICE"><spring:message code="message.Automatic bid" /></span>
										<span ng-if="auto_req_price > lot.LAST_PRICE">Stop({{auto_req_price | number : 0}} Automatic bid)</span>
									</button>
								</span>
							</div>
							<ul class="list_style01">
								<li><strong class="txt_impo02">Your bid will be placed as soon as you press the “Bid” button and cannot be changed or cancelled.</strong></li>
                                <li> Your bid will be placed after you adjust the price using the “+” and “-” buttons and press<strong>Automatic Bid</strong></li>
							</ul>
						</div>
					</div>
				</div>
				<!-- 종료 -->
				<div ng-if="lot.END_YN == 'Y'">
					<div class="box_style02 bid_result" ng-if="locale == 'ko'">
						<div class="border02"><p class="txt_style02">현재 Lot의 <strong class="txt_impo">경매가 종료</strong>되었습니다.</p></div>
						<div id="resultImage" class="bg_img bg10">
							<div class="txt_style03" ng-if="lot.LAST_PRICE >= 0 && lot.BID_CNT > 0">
								<span><span class="txt_green" id="winnerId">{{lot.LAST_CUST_ID}}</span>님의</span> 낙찰을 축하드립니다.
							</div>
						</div>
					</div>
                    <div class="box_style02 bid_result" ng-if="locale != 'ko'">
                        <div class="border02"><p class="txt_style02"><strong class="txt_impo">Closed</strong></p></div>
                        <div id="resultImage" class="bg_img bg10">
                            <div class="txt_style03" ng-if="lot.LAST_PRICE > 0">
                                <span><span class="txt_green" id="winnerId">{{lot.LAST_CUST_ID}}</span>&nbsp;Congratulations!</span> 
                            </div>
                            <div class="txt_style03" ng-if="!lot.LAST_PRICE || lot.LAST_PRICE == 0">
                                 Unsold 
                            </div>
                        </div>
                    </div>
					
					 <div class="btn_wrap" ng-if="locale == 'ko'">
						<span class="btn_style01 gray">
							<button type="button" onclick="$('#goonlinebidGuide')[0].click();">온라인 경매 안내</button>
						</span>
					</div>
					<div class="btn_wrap" ng-if="locale != 'ko'">
						<span class="btn_style01 gray">
							<button type="button" onclick="$('#goonlinebidGuide')[0].click();">Online auction announcement</button>
						</span>
					</div>
					<div style="display:none;">
						<a id="goonlinebidGuide" href="/auctionGuide/page?view=onlinebidGuide" target="_blank"></a>
						<a id="goPurchaseHisotry" href="/myPage/biddingHistory" target="_blank"></a>
					</div>
				</div>
				
                <!-- <div class="list_style02 mt10" ng-if="lot.END_YN == 'N'">20150521
			<div class="wrap_check opp">
				<div style="padding:15px;">
					<label for="chbAgree">
						<span ng-if="locale=='ko'" style="font-size:16px; color:#F60; font-weight:700; line-height:22px;">※ 아래 내용과 약관을 잘 확인 했으며, 동의합니다.&nbsp;</span><span ng-if="locale!='ko'">I have read and consented to the content and the terms and conditions below.&nbsp;</span>
					</label>
					<input type="checkbox" ng-model="chkAgree" name="" id="chkAgree" ng-checked="lot.MY_BID_SALE_CNT > 0" ng-change="setChkAgree(chkAgree);" style="width:21px; height:21px; line-height:21px; top:-4px;   vertical-align: middle;">
					<span id="sp-click"></span>
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

		</div> -->
                
				<div class="bid_table">
					<div class="count"><span>Bid.</span> <strong id="bidCount">{{lot.BID_CNT}}</strong></div>
					<!-- scroll -->
					<div class="scrollable web">
						<div class="scroller">
							<div class="tbl_style02">
								<table>
									<caption></caption>
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
										<!-- <th scope="col">호가</th> -->
										</tr>
										<tr ng-if="locale != 'ko'">
										<th scope="col">Bidder</th>
										<th scope="col">Bid price</th>
										<th scope="col">Bid time</th>
										<th scope="col">Status</th>
										<!-- <th scope="col">Grow price</th> -->
										</tr>
									</thead>
									<tbody id="tblBidListBody">
										<tr ng-show="bidList.length == 0" ng-if="locale == 'ko'">
											<td colspan="4" class="nodata">응찰자가 없습니다.</td>
										</tr>
										<tr ng-show="bidList.length == 0" ng-if="locale != 'ko'">
											<td colspan="4" class="nodata">There are no bidders.</td>
										</tr>
										<!-- ng-init 을 사용하면 팝업에서 refresh시 작동하지 않는다. 직업 last_bid_no 값을 직접 넣어도 작동하지 않는다. 그래서 함수 사용 -->
										<tr ng-repeat="bid in bidList" ng-class="bid.SOLD_YN == 'Y' ? 'bg' : ''" bind-html-compile="setLastBidNo(bid.BID_NO);">
											<td style="font-size:13px;"><span ng-if="bid.SELF_YN == 'Y'"><font color="red" style="font-weight:bolder">▶ {{bid.CUST_ID}}</font></span><span ng-if="bid.SELF_YN == 'N'">{{bid.CUST_ID}}</span></td>
											<td class="tar" style="font-size:13px;"><span ng-if="$first"><font color="blue" style="font-weight:bolder">{{bid.BID_PRICE | number:0}}</font></span><span ng-if="!$first">{{bid.BID_PRICE | number:0}}</span></td>
											<td style="font-size:13px;"><span ng-if="$first"><font color="blue" style="font-weight:bolder">{{bid.BID_DT | dateFormat}}</font></span><span ng-if="!$first">{{bid.BID_DT | dateFormat}}</span></td>
											<td class="tac" style="font-size:13px;" ng-if="locale == 'ko'">
												<span class="state_box"><span class="state02" ng-if="bid.SOLD_YN == 'Y'">낙찰</span></span>
												<span ng-if="bid.BID_KIND_CD == 'online_auto'">(자동)</span>
											</td>
											<td class="tac" style="font-size:13px;" ng-if="locale != 'ko'">
												<span class="state_box"><span class="state02" ng-if="bid.SOLD_YN == 'Y'">winning bid</span></span>
												<span ng-if="bid.BID_KIND_CD == 'online_auto'">(auto)</span>
											</td>
											<!-- BID_GROW_PRICE 주석처리(2019.10.24 YDH). 자동경합시 최종 last_price로 호가변동폭  update로 혼선을 줄 수 있어서 주석 처리함. -->
											<!-- <td class="tar" style="font-size:13px;"><span ng-if="$first"><font color="blue" style="font-weight:bolder">{{bid.BID_GROW_PRICE | number:0}}</font></span><span ng-if="!$first">{{bid.BID_GROW_PRICE | number:0}}</span></td>  -->
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- //scroll -->
				</div>
				<p style="font-size:12px; color:#666; padding-top:5px;" ng-if="locale == 'ko'">* 경매진행시에는 원활한 진행을 위해 상위20번의 비딩이 보입니다.</p> 
                <p style="font-size:12px;" ng-if="locale == 'ko'">* 동시 응찰자 경우, <strong>서버시각 기준 응찰에 먼저 응해준 응찰자에게 우선순위</strong>가 부여됩니다. </p>
                <p style="font-size:12px; color:#666; padding-top:5px;" ng-if="locale != 'ko'">* Only the top 20 bids are displayed to ensure the smooth progress in the auction.</p> 
                <p style="font-size:12px;" ng-if="locale != 'ko'">* When more than two bids are made simultaneously, priority will be given to the <strong>bidder who placed his or her bid first, based on the bid time indicated by the server.</strong></p>
				
				<!-- <div class="m_only" style="padding-top:30px; padding-bottom:15px;" ng-if="locale == 'ko'">
                    <p style="text-align:center; font-size:16px; font-weight:700;">[변경 호가 테이블]</p>
                    <table class="bidtable">
                        <tr style="text-align:right;">
                            <td><p style="font-weight:700;">이상</p></td>
                            <td><p style="font-weight:700;">미만</p></td>
                            <td><p style="font-weight:700;">호가</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>~</p></td>
                            <td><p>100 <font>만원</font></p></td>
                            <td><p>5 <font>만원</font></p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>50 <font>만원</font></p></td>
                            <td><p>100 <font>만원</font></p></td>
                            <td><p>5 <font>만원</font></p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>100 <font>만원</font></p></td>
                            <td><p>300 <font>만원</font></p></td>
                            <td><p>10 <font>만원</font></p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>300 <font>만원</font></p></td>
                            <td><p>500 <font>만원</font></p></td>
                            <td><p>20 <font>만원</font></p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>500 <font>만원</font></p></td>
                            <td><p>1,000 <font>만원</font></p></td>
                            <td><p>30 <font>만원</font></p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>1,000 <font>만원</font></p></td>
                            <td><p>3,000 <font>만원</font></p></td>
                            <td><p>50 <font>만원</font></p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>3,000 <font>만원</font></p></td>
                            <td><p>5,000 <font>만원</font></p></td>
                            <td><p>100 <font>만원</font></p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>5,000 <font>만원</font></p></td>
                            <td><p>1 <font>억원</font></p></td>
                            <td><p>200 <font>만원</font></p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>1 <font>억원</font></p></td>
                            <td><p>2 <font>억원</font></p></td>
                            <td><p>300 <font>만원</font></p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>2 <font>억원</font></p></td>
                            <td><p>~</p></td>
                            <td><p>500 <font>만원</font></p></td>
                        </tr>
                    </table>
                </div>  -->
                
                <!-- <div class="m_only" style="padding-top:25px;" ng-if="locale != 'ko'">
                    <p style="text-align:center; font-size:16px; font-weight:700;">BIDDING INCREMENTS</p>
                    <table class="bidtable">
                    	<tr style="text-align:right;">
                    		<td><p>from(￦)</p></td>
                    		<td><p>to(￦)</p></td>
                    		<td><p>by(￦)</p></td>
                    	</tr>
                        <tr style="text-align:right;">
                            <td><p>~</td>
                            <td><p>1M</p></td>
                            <td><p>50K</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>500K</td>
                            <td><p>1,000K</p></td>
                            <td><p>50K</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>1M</td>
                            <td><p>3M</p></td>
                            <td><p>100K</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>3M</td>
                            <td><p>5M</p></td>
                            <td><p>200K</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>5M</td>
                            <td><p>10M</p></td>
                            <td><p>300K</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>10M</td>
                            <td><p>30M</p></td>
                            <td><p>500K</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>30M</td>
                            <td><p>50M</p></td>
                            <td><p>1M</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>50M</td>
                            <td><p>100M</p></td>
                            <td><p>2M</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>100M</td>
                            <td><p>200M</p></td>
                            <td><p>3M</p></td>
                        </tr>
                        <tr style="text-align:right;">
                            <td><p>200M</td>
                            <td><p>~</p></td>
                            <td><p>5M</p></td>
                        </tr>
                    </table>
                	<span  style="text-align:left; color:blue;"><strong>※ 1K = 1,000<br/> &nbsp;&nbsp;&nbsp;&nbsp;1M = 1,000,000<br/>&nbsp;&nbsp;&nbsp;&nbsp;￦ = KRW</strong></span>
                </div> -->
                
				<div class="btn_wrap">
					<span class="btn_style01 gray mid btn_pop_close">
						<button type="button" ng-click="close(this);"><spring:message code="label.close" /></button>
					</span>
				</div>
			</fieldset>
            
            
         </div>
            
	</div>
  </div>
</div>
