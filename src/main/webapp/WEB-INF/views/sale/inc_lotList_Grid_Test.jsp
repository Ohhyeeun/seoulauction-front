<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>   

								<div class="wraph">  
                                	<div class="wraph_bor wraph_bor_grid"> 
	                                    <!-- <div class="txt"><strong>LOT.&nbsp;{{lot.LOT_NO}}</strong></div> -->
										<!-- 경매 진행 중 이미지 사이즈 -->    
										<div class="img" ng-if="sale_status!='END'" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" onkeydown="return false" align="center">
											<div class="img_w"> 
												<span ng-if="is_login">
													<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<!-- 20170510
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}}" alt="{{lot.TITLE}}" />
														20170510 -->
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" alt="{{lot.TITLE}}"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE}}" />
													</a>
													<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{((sale_status == 'ING' || sale_status == 'READY') && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" alt="{{lot.TITLE}}"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE}}" />
													</a>
													<!-- YBK.출품.이미지게시X -->
													<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{((sale_status == 'ING' || sale_status == 'READY') && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<img ng-src="/images/bg/no_image.jpg" />
													</a>
												</span> 
												<span ng-if="!is_login">
													<span ng-if="sale_status=='ING'">
														<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" rel="gallery1">
															<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}})'}" alt="{{lot.TITLE}}"/> -->
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}}" alt="{{lot.TITLE}}" />
														</a>
														<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" rel="gallery1">
															<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" alt="{{lot.TITLE}}"/> -->
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE}}" />
														</a>
														<!-- YBK.출품.이미지게시X -->
														<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" rel="gallery1">
															<img ng-src="/images/bg/no_image.jpg" />
														</a>
													</span>
													<span ng-if="sale_status!='ING'">
														<span ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" rel="gallery1">
															<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}})'}" alt="{{lot.TITLE}}"/> -->
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}}" alt="{{lot.TITLE}}" />
														</span>
														<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" rel="gallery1">
															<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" alt="{{lot.TITLE}}"/> -->
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE}}" />
														</span>
														<!-- YBK.출품.이미지게시X -->
														<span ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'" rel="gallery1">
															<img ng-src="/images/bg/no_image.jpg" />
														</span>
													</span>	 
												</span> 

												<span ng_if="lot.STAT_CD == 'reentry'">
													<img ng-src="/images/bg/no_image.jpg" />
												</span> 
											</div>   
										</div>  
										   
										<!-- 경매 결과 3*3 사이즈 --> 
										<div class="grid_result_auction_img_wrap" ng-if="sale_status=='END'"> 
											<div class="result_auction_img grid_result_auction_img" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" onkeydown="return false" align="center">
												<span ng-if="is_login">
													<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<!-- 20170510
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}}" alt="{{lot.TITLE}}" />
														20170510 -->
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" alt="{{lot.TITLE}}"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;" />
													</a>
													<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{((sale_status == 'ING' || sale_status == 'READY') && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" alt="{{lot.TITLE}}"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE}}"  style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
													</a>
													<!-- YBK.출품.이미지게시X -->
													<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{((sale_status == 'ING' || sale_status == 'READY') && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;" /> 
													</a>
												</span>
												<span ng-if="!is_login">
													<span ng-if="sale_status=='ING'">
														<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" rel="gallery1">
															<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}})'}" alt="{{lot.TITLE}}"/> -->
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}}" alt="{{lot.TITLE}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
														</a>
														<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" rel="gallery1">
															<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" alt="{{lot.TITLE}}"/> -->
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
														</a>
														<!-- YBK.출품.이미지게시X -->
														<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" rel="gallery1" style="width:auto; height: auto; max-width: 100px; max-height: 100px;">
															<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;" />
														</a>
													</span>
													<span ng-if="sale_status!='ING'">
														<span ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" rel="gallery1">
															<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}})'}" alt="{{lot.TITLE}}"/> -->
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}}" alt="{{lot.TITLE}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;" />
														</span>
														<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" rel="gallery1">
															<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" alt="{{lot.TITLE}}"/> -->
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
														</span>
														<!-- YBK.출품.이미지게시X -->
														<span ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'" rel="gallery1">
															<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
														</span> 
													</span>	
												</span>  
																						
												<span ng_if="lot.STAT_CD == 'reentry'">
													<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</span>
											</div>   
										</div> 
										
	                                    <div class="cancel auction_grid_cancel" ng-show='lot.STAT_CD == "reentry"'>
											<p class="notice_style03 tac"><spring:message code="message.lot.status.reentry" /></p>
										</div> 
										<%-- <div class="info" ng-show='lot.STAT_CD == "reentry"'>
											<p class="notice_style03 tac"><spring:message code="message.lot.status.reentry" /></p>
										</div> --%>
										
										<div class="info grid_info" ng-show='lot.STAT_CD != "reentry"'>		
											<div class="lot_wish">	  								
												<div class="lotnum auction_lotnum">
													<strong title="{{lot.LOT_NO}}">{{lot.LOT_NO}}</strong> 
													<!-- <span ng-if="sale_status == 'ING' && lot.STAT_CD != 'reentry'">
														<span ng-if="sale_status == 'ING' && !custInfo.CUST_NO" class="btn_interest web_only" onClick="alert('로그인 해주세요.\n Please login for use.')">	</span>	
														<span ng-if="custInfo.CUST_NO && lot.INTE_LOT_DEL == 'N'" class="btn_interest sele web_only" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" ></span>
													</span> -->
												</div>
												<div class="wish_btn"> 
													<button type="button"> 
														<span ng-if="lot.STAT_CD != 'reentry'">  
												            <span ng-if="!custInfo.CUST_NO" class="grid_wish_btn" onClick="alert('로그인 해주세요.\n Please login for use.')" title="관심작품 보기 / WishList"> </span>  
												            <span ng-if="custInfo.CUST_NO && lot.INTE_LOT_DEL == 'N'" class="grid_wish_btn grid_wish_btn_sele" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishList"></span>
												            <span ng-if="custInfo.CUST_NO  && lot.INTE_LOT_DEL != 'N' && lot.STAT_CD != 'reentry'" class="grid_wish_btn" ng-click="inteSave({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishList"></span>    
											            </span> 
											        </button>  
												</div>  
											</div> 
											
											<a ng-if="lot.STAT_CD != 'reentry'" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO : alert('로그인 후 확인할 수 있습니다.\n Please login for use.')}}"> 
												<div class="workartist auction_workartist">
													<span ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}"></span>
													<span class="txt_pale auction_txt_pale" title="{{lot.BORN_YEAR}}{{lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : ''}}">{{lot.BORN_YEAR}}{{lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : ''}}</span>
												</div>   
											 			
												<div class="worktitle auction_worktitle">  
													<span ng-bind="lot.TITLE_JSON[locale]" title="{{lot.TITLE_JSON[locale]}}"></span>
												</div>			
												<div class="workmaterial workmaterial02">  
													<!--  <p ng-if='lot.EDITION'><span ng-bind="lot.EDITION"></span></p> --> 
													<span style="font-size:14px" ng-bind="(lot.MAKE_YEAR_JSON['en'])" title="{{(lot.MAKE_YEAR_JSON['en'])}}"></span>   
													<span ng-if="lot.MAKE_YEAR_JSON['en'] != null && lot.MAKE_YEAR_JSON['en'] != ''">&nbsp;｜&nbsp;</span>  
													<span style="font-size:14px" ng-if="lot.MATE_NM" ng-bind="lot.MATE_NM_EN" title="{{lot.MATE_NM_EN}}"></span>
	                                                <!-- <p ng-if='lot.MAKE_YEAR_JSON[locale]'>  --> 
	                                                <!--     <span ng-bind="(lot.MAKE_YEAR_JSON['ko'])"></span> -->
	                                                    <!-- <span ng-if="lot.MAKE_YEAR_JSON.zh != null" ng-bind="lot.MAKE_YEAR_JSON['zh'] | trimSameCheck : lot.MAKE_YEAR_JSON[locale]"></span>  -->
	                                                <!-- </p> -->   
	                                                <p class="edition_txt_p" ng-repeat="size in lot.LOT_SIZE_JSON" data-ng-show="$index <1"> <!-- 첫번째 사이즈만 보여준다(YDH.2020.02.01) -->
	                                                     <span ng-if="locale=='ko'" ng-bind="size | size_text_cm" title="{{size | size_text_cm}}"></span> 
	                                                     <span ng-if="locale!='ko'" ng-bind="size | size_text" title="{{size | size_text}}"></span>
	                                                    <!--<span ng-bind="size | size_text_cm"></span><br/>
														<span ng-bind="size | size_text_in"></span>-->
                                                        <!-- 에디션 추가 --> 
														<span class="edition_txt" ng-if='lot.EDITION' title="{{lot.EDITION}}"><span ng-bind="lot.EDITION" title="{{lot.EDITION}}"></span></span>      
	                                                </p>   
	                                                <!-- <p ng-if='lot.SIGN_INFO_JSON[locale]' style="white-space:normal;">
	                                                <span bind-html-compile="lot.SIGN_INFO_JSON['ko']"></span>
	                                                	<span bind-html-compile="lot.SIGN_INFO_JSON[locale]"></span>
	                                                    {{lot.SIGN_INFO_JSON["en"] | trimSameCheck : lot.SIGN_INFO_JSON[locale] }}
	                                                    <span ng-if="lot.SIGN_INFO_JSON.zh != null">{{lot.SIGN_INFO_JSON["zh"] | trimSameCheck : lot.SIGN_INFO_JSON[locale] }}</span>
	                                                </p> -->
												</div>
											
												<div class="estimate auction_estimate" ng-show='lot.STAT_CD != "reentry"'>
	                                            	<!-- // 오프라인 경매 공백 일 때 고정 값-> 
	                                            	<div ng-if="lot.EXPE_PRICE_INQ_YN == 'Y' || (lot.EXPE_PRICE_TO_JSON[base_currency]) == 0" class="es_price es_price_offline_empty">
	                                            	</div> -->
	                                            	<!-- <div class="es_price" ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null"> -->
	                                            	<!-- // 오프라인 경매 공백 일 때 고정 값-->  
	                                            	<div class="es_price">  
	                                            		<p class="krw Price_inqury" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></p> 
                                                        <ul ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null">
                                                            <li class="es_price_left"><spring:message code="label.expense.price" />
                                                            </li>  
                                                            <li class="es_price_right" style="font-size: 12px; line-height: 20px;"> 
                                                                <p class="krw Price_inqury" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></p>
                                                                <!-- 온라인인 경우 -->   
                                                                <div ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1) && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" >
                                                                	<p>
                                                                		<span class="Price_block">
                                                                			{{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0}}
	                                                                	</span> 
	                                                                	<span class="Price_block">
	                                                                		~ {{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}}
	                                                                	</span> 
                                                                	</p>  
                                                                	<p ng-if="(locale=='en' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
                                                                		<span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}</span>
                                                                    	<span class="Price_block">~{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}</span> 
                                                                	</p>
                                                                	<p ng-if="( ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
                                                                		<span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0}}</span>
                                                                		<span class="Price_block">~ {{lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0}}</span> 
                                                                	</p>   
                                                                </div>  
                                                                 
                                                                <!-- 오프라인인 경우 -->
                                                                <div ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (['online','online_zb'].indexOf(sale.SALE_KIND_CD) < 0) && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" >
                                                                	<p>
	                                                                	<span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0}}</span> 
	                                                                	<span class="Price_block">~ {{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}}</span>
	                                                                	<%--임시 <span ng-if="(locale=='en' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) < 0) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
	                                                                        </br>{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}<br/>
	                                                                         ~{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}
	                                                                    </span> --%> 
	                                                                </p>
                                                                    <p ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) < 0 && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
                                                                        <span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}</span>
                                                                        <span class="Price_block">~{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}</span>  
                                                                    </p> 
                                                                    <p ng-if="(locale!='en' && ['online','online_zb','main','plan'].indexOf(sale.SALE_KIND_CD) < 0) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null && lot.EXPE_PRICE_FROM_JSON != 0 && lot.EXPE_PRICE_FROM_JSON != null" >
                                                                        <span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0}}</span> 
                                                                        <span class="Price_block"> ~ {{lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0}}</span> 
                                                                    </p>    
                                                                </div>  
                                                            </li> 
                                                            <!-- <li class="es_price_right" style="font-size: 12px;">
                                                            </li> -->
                                                        </ul>
			                                            <!-- 홍콩경매 sale.SALE_KIND_CD == 'hongkong'는 HKD를 맨위로 표시한다. ->
			                                            <span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
			                                            <span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" >
			                                            	<p>
			                                                  	<span ng-bind="(lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0)+' ~ '+(lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0)"></span>
			                                                </p>
			                                                <p ng-if="lot.EXPE_PRICE_FROM_JSON.USD != null && sale.SALE_KIND_CD != 'hongkong'">
			                                                    {{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}} ~
			                                                    {{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}
			                                                </p>
			                                                <p ng-if="lot.EXPE_PRICE_FROM_JSON[sub_currency] != null">
			                                                    {{lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + " " : 0}} ~
			                                                    {{lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0}}
			                                                </p>  
			                                            </span> -->  
                                             	 	</div> 
	                                              
	                                             	<!--시작가-->  
	                                              	<div ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1" class="es_price"> 
	                                           			<ul>
	                                           				<li class="es_price_left"><spring:message code="label.expense.start_price" /></li>
                                             				<li class="es_price_right"> 
	                                              				<span ng-if="lot.START_PRICE > 0 && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.STAT_CD != 'reentry'">
				                                                <!-- <p><span class="txt_dark"><spring:message code="label.expense.start_price" /></span> -->
				                                                <span ng-bind="(sale.CURR_CD)+' '+(lot.START_PRICE | number : 0)"></span>
				                                                </span> 
				                                                <span ng-if="(lot.START_PRICE == null || lot.START_PRICE == '') && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.STAT_CD != 'reentry'">
				                                                <!-- <p><span class="txt_dark"><spring:message code="label.expense.start_price" /></span> -->
				                                                <span ng-bind="(sale.CURR_CD)+' '+(0)"></span>
				                                                </span>  
		                                              		</li>  
	                                           			</ul> 
		                                                <!-- <span ng-if="lot.START_PRICE > 0 && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.STAT_CD != 'reentry'">
		                                                <p><span class="txt_dark"><spring:message code="label.expense.start_price" /></span>
		                                                KRW <span ng-bind="lot.START_PRICE | number : 0"></span>
		                                                </span> --> 
	                                              	</div><!--시작가끝-->
												
													<!-- 현재가 --> 
													<div class="es_price">  
		                                              	<ul>
														 	<li class="es_price_left text_hide" style="color:#ff0000;">
														 		<span ng-if="lot.LAST_PRICE >= 0 && (['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1) && lot.END_YN == 'N'" title="현재가 {{lot.BID_CNT | number:0}}회"><spring:message code="label.bid.price" /></span>  
														 		<span ng-if="custInfo.CUST_NO > 0 && is_login && lot.LAST_PRICE >= 0 && lot.BID_CNT > 0 && lot.END_YN == 'Y'" title="낙찰가{{lot.BID_CNT | number:0}}회"><spring:message code="label.bid.price.sold" /></span>         
														 		<span ng-if="lot.LAST_PRICE >= 0 && lot.BID_CNT > 0 && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
		                                                       		<span style="color:#ff0000; font-size:11px;" title="{{lot.BID_CNT | number:0}}회">({{lot.BID_CNT | number:0}}<span ng-if="locale=='ko'">회</span><span ng-if="locale!='ko'">bid</span>)</span>
		                                                   		</span> 
														 	</li>
			                                                <li class="es_price_right">
																<span style="color:#ff0000; font-weight:600;" ng-if="lot.LAST_PRICE != null" ng-bind="(sale.CURR_CD)+' '+(lot.LAST_PRICE | number:0)"></span>
															</li>
															<!-- <p style="font-weight:600; font-size:18px;line-height:30px;">
				                                                 <strong class="txt_impo"><spring:message code="label.bid.price" /><br/>
				                                                 <span ng-if="lot.LAST_PRICE != null" ng-bind="(sale.CURR_CD)+' '+(lot.LAST_PRICE | number:0)">
				                                                 </span></strong>
															 </p> -->
		                                     			</ul> 
													</div><!-- //현재가 --> 	
												</div> 
                                   			</a> 
                                   			  
                                            <div class="ect auction_ect"><!-- 7.7sh추가 -->
                                                <span ng-if="custInfo.CUST_NO > 0 && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) >= 0 && lot.LAST_PRICE > 0">
                                                    <p><strong class="txt_impo"><spring:message code="label.bid.price.sold" /><span ng-bind="' '+(base_currency)+' '+(lot.LAST_PRICE | number:0)"></span></strong></p>
                                                    <!-- <p ng-if="!lot.LAST_PRICE || lot.LAST_PRICE <= 0"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></p> -->
                                                </span> 
                                                <!-- 오프라인 경매 && 금액 0 -->
                                                <span ng-if="!is_login && sale_status == 'END'">
                                                    <spring:message code="label.auction.soldpricelog" />
                                                </span>
                                                
                                                <!-- 온라인 진행중 --> 
                                                <div class="time_count">  
                                                    <span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N'">
                                                        <p class="time" style="font-size:12px;"><span ng-bind="(getDurationTime(lot.TO_DT))"></span>
                                                            <!-- (<spring:message code="label.bid.mybidding" /> : <span ng-bind="lot.MY_BID_CNT"></span><span ng-if="lot.IS_WIN=='Y'"> - <spring:message code="label.bid.mybidding2" /></span>)  -->
                                                        </p> 
                                                    </span> 
                                                </div>  
                                                <!-- 응찰하기 버튼 -->
                                                <div class="btn bidding_btn"> 
                                                    <span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry"' class="btn_style01 xlarge dark full bidding_btn02 dark_bidding_btn" 
                                                        ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'Y'"><!-- sale_status == 'END' 대체. lot.END_YN-->
                                                        <button ng-if="custInfo.BID_FORBID == 'N' && custInfo.CUST_NO && ((custInfo.LOCAL_KIND_CD == 'foreigner' && custInfo.FORE_BID_YN == 'Y') || (custInfo.LOCAL_KIND_CD != 'foreigner'))" ng-click="showBidHistoryPopup({'parent':this, 'sale':sale, 'lot':lot});" >
                                                            <spring:message code="label.go.bid.history" /><!-- 온라인응찰기록 -->
                                                        </button>
                                                    </span><!-- 온라인 / 종료 --> 			    									
                                                    
                                                    <span ng-if="is_login == 'false' && lot.END_YN != 'Y' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale.AUTO_BID_REQ_CLOSE_DT <= sale.DB_NOW" class="btn_style01 xlarge green02 full bidding_btn02" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')"><!-- sale_status == 'END' 대체. lot.END_YN-->
                                                        <button type="button">
                                                            <spring:message code="label.go.bid.now" />
                                                        </button>
                                                    </span>
                                                    
                                                    <!-- 응찰하기 버튼 와인 조건 추가 N인경우 --> 		
                                                    <span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry" && (lot.WINE_YN == "N" || custInfo.EMP_GB == "Y")' class="btn_style01 xlarge green02 full bidding_btn02 bidding_btn02_en" 
                                                        ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N' && sale.AUTO_BID_REQ_CLOSE_DT <= sale.DB_NOW"><!-- sale_status == 'END' 대체. lot.END_YN-->
                                                        <button type="button" ng-if="custInfo.BID_FORBID == 'N' && custInfo.CUST_NO && ((custInfo.LOCAL_KIND_CD == 'foreigner' && custInfo.FORE_BID_YN == 'Y') || (custInfo.LOCAL_KIND_CD != 'foreigner'))" ng-click="showBidPopup({'parent':this, 'sale':sale, 'lot':lot});" >
                                                            <spring:message code="label.go.bid.now" />
                                                        </button>
                                                    </span>
                                                    
                                                    <!-- 응찰하기 버튼 와인 조건 추가 Y인경우 --> 		
                                                    <span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry" && lot.WINE_YN == "Y" && custInfo.EMP_GB == "N"' class="btn_style01 xlarge green02 full bidding_btn02 bidding_btn02_en" 
                                                        ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N' && sale.AUTO_BID_REQ_CLOSE_DT <= sale.DB_NOW"><!-- sale_status == 'END' 대체. lot.END_YN-->
                                                        <button type="button" ng-if="custInfo.BID_FORBID == 'N' && custInfo.CUST_NO && ((custInfo.LOCAL_KIND_CD == 'foreigner' && custInfo.FORE_BID_YN == 'Y') || (custInfo.LOCAL_KIND_CD != 'foreigner'))" onClick="alert('와인 응찰은 서울옥션 담당자 또는 \n02-2075-4326으로 문의주시기 바랍니다. \n\nPlease contact ejlee@seoulauction.com for wine.')" >
                                                            <spring:message code="label.go.bid.now" />
                                                        </button>
                                                    </span>
                                                    
                                                    <span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry"' class="btn_style01 xlarge green02 full bidding_btn02"   
                                                        ng-if="sale.SALE_NO != '555' && sale.SALE_NO != '594' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && is_login && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                                        <button ng-if="(custInfo.MEMBERSHIP_YN == 'Y' || custInfo.FORE_BID_YN == 'Y') && sale.SALE_NO != '563' && sale.SALE_NO != '594'" type="button" ng-click="showBidRequestPopup({'parent':this, 'sale':sale, 'lot':lot});" >
                                                            <spring:message code="label.go.bid.request" /> 
                                                        </button><!-- 정회원 --> 
                                                    </span> 
                                                    
                                                    <span class="btn_style01 xlarge green02 full bidding_btn02" ng-if="sale.SALE_NO != '563' && sale.SALE_NO != '594' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && is_login == 'false' && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')" onClick="alert('정회원 등록 후 재로그인하시면 응찰하실 수 있습니다.\n The website bidding is open to bidding members only. After Register on the website, try log in again.')">  
                                                        <button type="button" >
                                                            <spring:message code="label.go.bid.request" />
                                                        </button> 
                                                    </span>
                                                    
                                                    <!-- 온라인 / 국내 -->
                                                    <%-- <span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry"' class="btn_style01 xlarge green02 btn_bid"
                                                        ng-if="['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && is_login && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
                                                        <button ng-if="custInfo.FORE_BID_YN == 'Y'" type="button" ng-click="showBidRequestPopup({'parent':this, 'sale':sale, 'lot':lot});" >
                                                            <spring:message code="label.go.bid.request" />
                                                        </button> 
                                                    </span> --%>
                                                    <!-- 정회원. 국외 회원 응찰 여부 체크된 고객 --><!-- 온라인 / 국외-->
                                                    <span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge white full" ng-if="['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) >= 0 && !is_login && sale_status == 'ING'">
                                                        <button type="button" onclick="loginAlert();"><spring:message code="label.go.bid.request" /></button>	
                                                    </span><!-- 오프라인 / 로그아웃 -->
                                                    
                                                    <span ng-show='lot.STAT_CD != "reentry"' ng-if="['private','exhibit'].indexOf(sale.SALE_KIND_CD) >= 0 && sale_status == 'ING'" class="btn_style01 xlarge white full">
                                                        <button type="button" onclick="goInquiryWrite();"><spring:message code="label.go.inquery" /></button>
                                                    </span>
												</div> 
											</div><!-- 7.7sh추가 끝-->
										</div> 
									</div> 
								</div> <!-- //wraph -->     
									
								<!-- 기존소스 주석처리  --> 
								<!-- <span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'READY'">
	                                    <p class="time">
	                                        <span ng-bind="(auctionBidStartTime | dateFormat}})+' KST '"></span><spring:message code="label.auction.start" />
	                                        <span ng-bind="' ~ '+ (sellToDate | dateFormat)+' KST '"></span><spring:message code="label.finish.by.lot.number" />
	                                    </p> 
                                    </span> --><!-- //온라인 준비 --> 
                                    <!-- 온라인 진행중/종료 카운트 시간 ->
                                    <span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N'">
                                        <p class="time"><span ng-bind="(getDurationTime(lot.TO_DT))+' ('+ (lot.TO_DT | date : 'yyyy.MM.dd HH:mm:ss')+')'"></span></p>
                                        <p style="font-weight:600; font-size:18px; line-height:30px;">
                                               <spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" /> 
                                               (<spring:message code="label.bid.mybidding" /> : <span ng-bind="lot.MY_BID_CNT"></span><span ng-if="lot.IS_WIN=='Y'"> - <spring:message code="label.bid.mybidding2" /></span>)
                                           </p>
                                        <p style="font-weight:600; font-size:18px;line-height:30px;">
                                            <strong class="txt_impo"><spring:message code="label.bid.price" /><br/>
                                            <span ng-if="lot.LAST_PRICE != null" ng-bind="(sale.CURR_CD)+' '+(lot.LAST_PRICE | number:0)">
                                            </span></strong> 
                                        </p>
                                    </span><!-- 온라인 진행중 ->  
                                    
                                    <span ng-if="custInfo.CUST_NO > 0 && is_login && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'Y'">
                                          <p class="time" ng-if="viewId == 'CURRENT_AUCTION'">{{lot.TO_DT | dateFormat}} KST <spring:message code="label.auction.finish" /></p>
                                          <p ng-if="lot.LAST_PRICE >= 0 && lot.BID_CNT > 0" style="font-weight:600; font-size:18px; line-height:30px;">
                                              <spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" />
                                          </p>
                                          <p ng-if="(!lot.LAST_PRICE || lot.LAST_PRICE <= 0) && lot.BID_CNT < 1" style="font-weight:600; font-size:18px; line-height:30px;">
                                             <strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}">
                                             <spring:message code="label.auction.unsold" />
                                             </strong>
                                         </p>
                                          <p ng-if="lot.LAST_PRICE >= 0 && lot.BID_CNT > 0" style="font-weight:600; font-size:18px; line-height:30px;">
                                              <spring:message code="label.bid.price.sold" /><br/>
                                              <strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION', txt_green02:viewId != 'CURRENT_AUCTION'}">
                                              <span ng-bind="' KRW '+(lot.LAST_PRICE | number:0)"></span></strong>
                                          </p>
                                    </span><!-- 온라인 종료 --> 