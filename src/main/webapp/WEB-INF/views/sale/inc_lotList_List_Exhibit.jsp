<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
								
								<!-- 경매 진행중 이미지 사이즈 --> 
								<div class="auction_list_img" oncontextmenu="return false" ondragstart="return false" ng-if="sale_status!='END'">
									<span ng-if="sale_status == 'ING'">
										<span ng-if="is_login">
											<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</a>
											<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</a>
											<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
												<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
											</a>
										</span>	
										<span ng-if="!is_login">
											<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</a>
											<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</a>												
											<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'" ng-href="#}" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
												<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
											</a>
										</span>										
										<span ng_if="lot.STAT_CD == 'reentry'">
											<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
										</span>
									</span>
									
									<span ng-if="sale_status != 'ING'">
										<span ng-if="is_login">
											<span ng_if="custInfo.EMP_GB == 'Y'">
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
											</span>
											
											<span ng_if="sale.SALE_NO <= '408' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</span>
											<span ng_if="sale.SALE_NO >= '409' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</span>												
											<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
												<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
											</span>
										</span>
										<span ng-if="!is_login">
											<span ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</span>
											<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
											</span>												
											<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
												<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
											</span>
										</span>										
										<span ng_if="lot.STAT_CD == 'reentry'">
											<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
										</span>
									</span>
								</div>
								
								<!-- 경매 결과 이미지 3*3 사이즈 -->
								<div class="result_auction_img_wrap" ng-if="sale_status=='END'"> 
									<div class="result_auction_img" oncontextmenu="return false" ondragstart="return false">   
										<span ng-if="sale_status == 'ING'">
											<span ng-if="is_login">
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
												<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="/images/bg/no_image.jpg" style="max-width: 100px; max-height: 100px;"/>
												</a>
											</span>	
											<span ng-if="!is_login">
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>												
												<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'" ng-href="#}" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<img ng-src="/images/bg/no_image.jpg" style="max-width: 100px; max-height: 100px;"/>
												</a>
											</span>										
											<span ng_if="lot.STAT_CD == 'reentry'">
												<img ng-src="/images/bg/no_image.jpg" style="max-width: 100px; max-height: 100px;"/>
											</span>
										</span>
										
										<span ng-if="sale_status != 'ING'">
											<span ng-if="is_login">
												<span ng_if="custInfo.EMP_GB == 'Y'">
													<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
													</a>
													<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetailExhibit?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
													</a>
												</span>
												
												<span ng_if="sale.SALE_NO <= '408' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</span>
												<span ng_if="sale.SALE_NO >= '409' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</span>												
												<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
													<img ng-src="/images/bg/no_image.jpg" style="max-width: 100px; max-height: 100px;"/>
												</span>
											</span>
											<span ng-if="!is_login">
												<span ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</span>
												<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</span>												
												<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
													<img ng-src="/images/bg/no_image.jpg" style="max-width: 100px; max-height: 100px;"/>
												</span>
											</span>										
											<span ng_if="lot.STAT_CD == 'reentry'">
												<img ng-src="/images/bg/no_image.jpg" style="max-width: 100px; max-height: 100px;"/>
											</span>
										</span>
									</div>
								</div> 
								
								<div class="hidden_box auction_list_hidden_box">
									<!-- 관심추가, 제거 -->
									<!--  <button ng-if="lot.STAT_CD != 'reentry' && sale_status == 'ING'" id="interestBtn" type="button" class="btn_interest sele" onclick="interestRemove()"></button>
									<button ng-if="lot.STAT_CD != 'reentry' && sale_status == 'ING'" id="interestBtn" type="button" class="btn_interest" onclick="interestAdd();"></button>-->
									<!--  lot 번호 
									<div class="lot">
										<span ng-bind="'NO. '"></span>
										<strong>
											<span ng-bind="lot.LOT_NO"></span>
										</strong>
									</div> -->  
		
									<%-- 출품 취소 여부 확인 --%>
									<div class="cancel auction_list_cancel" ng-show='lot.STAT_CD == "reentry"'>
										<p class="notice_style03 tac"><spring:message code="message.lot.status.reentry" /></p>
									</div> 
									<!-- 홍콩경매 여부에 따른 화면표시 확인 -->
									<div class="author auction_list_author exhibition_list_author" ng-show='lot.STAT_CD != "reentry"'>
										<div class="lot_wish">	 						
											<div class="lotnum auction_lotnum">
												<strong>
													<span ng-if="sale.SALE_NO == '410'">
														<span ng-if="lot.LOT_NO != '91' && lot.LOT_NO != '92'" ng-bind="lot.LOT_NO" title="{{lot.LOT_NO}}"></span>
														<span ng-if="lot.LOT_NO == '91'" ng-init="SLOT01='S01';SLOT02='S02'" ng-bind="SLOT01"></span>
														<span ng-if="lot.LOT_NO == '92'" ng-init="SLOT01='S01';SLOT02='S02'" ng-bind="SLOT02"></span>
													</span>
													<span ng-if="sale.SALE_NO != '410'" ng-bind="lot.LOT_NO" title="{{lot.LOT_NO}}"></span> 
												</strong>
											</div>
											<div class="wish_btn">
												<button type="button">  
													<span ng-if="lot.STAT_CD != 'reentry'"> 
													<!-- <span ng-if="sale_status == 'ING' && lot.STAT_CD != 'reentry'"> -->  
											            <span ng-if="!custInfo.CUST_NO" class="grid_wish_btn" onClick="alert('로그인 해주세요.\n Please login for use.')" title="관심작품 보기 / WishList"> </span>  
												        <span ng-if="custInfo.CUST_NO && lot.INTE_LOT_DEL == 'N'" class="grid_wish_btn grid_wish_btn_sele" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishList"></span>
												        <span ng-if="custInfo.CUST_NO  && lot.INTE_LOT_DEL != 'N' && lot.STAT_CD != 'reentry'" class="grid_wish_btn" ng-click="inteSave({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishList"></span> 
										            </span>    
										        </button>  
											</div> 
										</div> 
										
										<!-- a태그 블록처리  --> 
										<a ng-if="lot.STAT_CD != 'reentry'" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO : alert('로그인 후 확인할 수 있습니다.\n Please login for use.')}}">
											<div class="name auction_workartist">
												<span ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}"></span>      
												<!-- <span class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh" style="font-weight:normal; font-family:none;"></span> -->
												<span class="txt_pale" ng-if="lot.BORN_YEAR!=null" ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')" title="{{(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')}}"></span> 
											<!-- <div class="lang web_only">  
												<!-- <span ng-if="locale != 'en'" ng-bind="lot.ARTIST_NAME_JSON.en"></span> //2018.08.30 캡션간소화처리(YDH) ->
												<span class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh"></span>
												<span class="txt_pale" ng-if="lot.BORN_YEAR!=null" ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')"></span>
											</div> -->
											</div>
											
											<div class="title auction_worktitle" style="border: none;">  
												<div class="tit"><span ng-bind="lot.TITLE_JSON[locale]" title="{{lot.TITLE_JSON[locale]}}"></span></div>  
												<div class="lang web_only">
													<!-- <span ng-bind="lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale]"></span> //2018.08.30 캡션간소화처리(YDH) -->
													<p ng-if="lot.TITLE_JSON.zh != lot.TITLE_JSON.en"><span ng-if="lot.TITLE_JSON.zh != null" ng-bind="lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale]"></span></p>
													<!--  <span style="color:#666" ng-bind="(lot.STITLE_JSON.en | trimSameCheck : lot.STITLE_JSON[locale])"></span> -->
													<span ng-bind="lot.STITLE_JSON[locale]" title="{{lot.STITLE_JSON[locale]}}"></span> 
													<!-- <p ng-if="locale == 'en'"><span ng-if="lot.STITLE_JSON.ko != null && lot.STITLE_JSON.ko != lot.STITLE_JSON.en" ng-bind="lot.STITLE_JSON.ko"></span></p>
													<p ng-if="locale != 'en'"><span ng-if="lot.STITLE_JSON.en != null && lot.STITLE_JSON.ko != lot.STITLE_JSON.en" ng-bind="lot.STITLE_JSON.en"></span></p>  //2018.08.30 캡션간소화처리(YDH) -->
													<p ng-if="lot.STITLE_JSON.zh != lot.STITLE_JSON.en"><span ng-if="lot.STITLE_JSON.zh != null" ng-bind="lot.STITLE_JSON.zh | trimSameCheck : lot.STITLE_JSON[locale]"></span></p>
												</div>   
											</div>
											
											<div class="explain auction_list_explain" ng-show='lot.STAT_CD != "reentry"'> 
												<!-- <span ng-if="lot.MATE_NM" ng-bind="'MATE_NM' | localeValue : lot"></span>
												<!-- <p ng-if="locale == 'ko' && lot.MATE_NM_EN != lot.MATE_NM"><span ng-bind="lot.MATE_NM_EN"></span></p>  //2018.08.30 캡션간소화처리(YDH) -->
												<p ng-if='lot.MAKE_YEAR_JSON[locale]'>
													<span ng-bind="lot.MAKE_YEAR_JSON['ko']" title="{{lot.MAKE_YEAR_JSON['ko']}}"></span>   
												<!--	{{lot.MAKE_YEAR_JSON[locale]}}
												  	{{lot.MAKE_YEAR_JSON["en"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}
													<span ng-if="lot.MAKE_YEAR_JSON.zh != null">{{lot.MAKE_YEAR_JSON["zh"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}</span> -->
												</p>
												<p ng-if="locale == 'ko' && lot.MATE_NM_EN != lot.MATE_NM">
													<span ng-bind="lot.MATE_NM_EN" title="{{lot.MATE_NM_EN}}"></span>  
												</p> 
												<p ng-repeat="size in lot.LOT_SIZE_JSON" data-ng-show="$index <1"> <!-- 첫번째 사이즈만 보여준다(YDH.2020.02.01) -->
			                                            <span ng-if="locale=='ko'" ng-bind="size | size_text_cm" title="{{size | size_text_cm}}"></span> 
			                                            <span ng-if="locale!='ko'" ng-bind="size | size_text" title="{{size | size_text}}"></span>
			                                           <!--<span ng-bind="size | size_text_cm"></span><br/>
														<span ng-bind="size | size_text_in"></span>-->
										             </p> 
												<!-- //기존 사이즈 
												<p ng-repeat="size in lot.LOT_SIZE_JSON">
													<!-- <span ng-bind="size | size_text"></span> ->
													<span ng-if="locale=='ko'"  ng-bind="size | size_text_cm"></span>
													<span ng-if="locale!='ko'"  ng-bind="size | size_text_in"></span>
												</p> -->
												<p ng-if='lot.EDITION'><span ng-bind="lot.EDITION" title="{{lot.EDITION}}"></span></p> 
												
												<p ng-if='lot.SIGN_INFO_JSON[locale]'> 
													<span bind-html-compile="lot.SIGN_INFO_JSON['ko']" title="{{lot.SIGN_INFO_JSON['ko']}}"></span> 
												<!--	<span bind-html-compile="lot.SIGN_INFO_JSON[locale]"></span>
												  	{{lot.SIGN_INFO_JSON["en"] | trimSameCheck : lot.SIGN_INFO_JSON[locale] }}
													<span ng-if="lot.SIGN_INFO_JSON.zh != null">{{lot.SIGN_INFO_JSON["zh"] | trimSameCheck : lot.SIGN_INFO_JSON[locale] }}</span> -->
												</p>
											</div>  
										</a>
									</div> 
									
									<!-- // 추정가, 버튼
										<div class="estimate" ng-show='lot.STAT_CD != "reentry"'>
										<!--<span class="txt_dark web_only"><spring:message code="label.expense.price" /></span>-->
										<!-- 홍콩경매 sale.SALE_KIND_CD == 'hongkong'는 HKD를 맨위로 표시한다. -->
										<!-- <span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span> 
										<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y'">
											<!-- KRW ->
											<p ng-if="lot.EXPE_PRICE_FROM_JSON[base_currency] != null && lot.EXPE_PRICE_FROM_JSON[base_currency] != 0 && lot.EXPE_PRICE_TO_JSON[base_currency] != null && lot.EXPE_PRICE_TO_JSON[base_currency] != 0">
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span>
												<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)" ng-bind="' ~ '"></span>	
												<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
											</p>
											<!-- USD ->
											<p ng-if="lot.EXPE_PRICE_FROM_JSON.USD != null && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_TO_JSON.USD != null && lot.EXPE_PRICE_TO_JSON.USD != 0">
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
												<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)" ng-bind="' ~ '"></span>	
												<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
											</p>
											<!-- HKD ->
											<p ng-if="lot.EXPE_PRICE_FROM_JSON[sub_currency] != null && lot.EXPE_PRICE_FROM_JSON[sub_currency] != 0 && lot.EXPE_PRICE_TO_JSON[sub_currency] != null && lot.EXPE_PRICE_TO_JSON[sub_currency] != 0">
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
												<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)" ng-bind="' ~ '"></span>	
												<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
											</p>
										</span>
									</div>
	
									<div class="state_wrap" ng-show='lot.STAT_CD != "reentry"'>
										<div class="state_area" ng-class="{double:viewId == 'CURRENT_EXHIBIT'}">											
											<div class="info">
											<!-- 리스트의 회색바 메시지를 표시하는 부분 ->
											</div>
										</div>
									</div>
									<!-- YBK.20170407 컨디션리포트 추가
									<span ng-if="sale_status == 'ING'">									
										<button ng-if="!custInfo.CUST_NO" type="button" class="btn_interest web_only" onClick="alert('로그인 해주세요.\n Please login for use.')">
											<span ng-if="locale=='ko'">관심작품</span>
											<span ng-if="locale!='ko'">FAVORITE WORK</span>
										</button>
									</span>

									<span ng-if="custInfo.CUST_NO > 0 && sale_status == 'ING'">
										<span ng-if="lot.INTE_LOT_DEL == 'N'" class="btn_interest sele web_only" >
											<button ng-if="custInfo.CUST_NO" type="button" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});">
												<span ng-if="locale=='ko'">관심작품 삭제</span>
												<span ng-if="locale!='ko'">FAVORITE WORK Del.</span>
											</button>
										</span>
										<span ng-if="custInfo.CUST_NO > 0 && lot.INTE_LOT_DEL != 'N'" class="btn_interest web_only" >
											<button ng-if="custInfo.CUST_NO" type="button" ng-click="inteSave({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});">
												<span ng-if="locale=='ko'">관심작품</span>
												<span ng-if="locale!='ko'">FAVORITE WORK</span>
											</button>
										</span>
									</span> --> 
									<!-- YBK.20170407 컨디션리포트 추가 -->
                                    
									<!-- 버튼 -->
									<!-- 1:1문의 또는 서면/전화 방식 결정 후 진행 필요함.
									<span ng-show='lot.STAT_CD != "reentry"' ng-if="custInfo.CUST_NO && ['private','exhibit','exhibit_sa'].indexOf(sale.SALE_KIND_CD) >= 0 && sale_status == 'ING'" class="btn_style01 xlarge green02 btn_bid">
										<button type="button" onclick="location.href='/customer/inquiryForm'"><spring:message code="label.go.inquery" /></button>
									</span>
								</div> --> <!--hidden_box end-->
								   
								<!-- 1:1 문의 버튼 임시 주석 처리 -->
								<%-- <div class="ect exhibit_ect"><!-- 7.7sh추가 --> 
                                    <div class="btn exhibit_ect_btn">  
                                       <span ng-show='lot.STAT_CD != "reentry"' ng-if="custInfo.CUST_NO && ['private','exhibit','exhibit_sa'].indexOf(sale.SALE_KIND_CD) >= 0 && sale_status == 'ING'" class="btn_style01 xlarge green02 full exhibition_btn"> 
                                            <button type="button" onclick="location.href='/customer/inquiryForm'"><spring:message code="label.go.inquery" /></button>
                                       </span>  
                                    </div> 
								</div> --%><!-- 7.7sh추가 끝-->  
							</div> <!--hidden_box end--> 
								
