<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

								<div class="wraph">
                                	<div class="wraph_bor wraph_bor_artsy_g">        
										<!-- 경매 진행 중 이미지 사이즈 -->     
										<div class="img" ng-if="sale_status!='END'" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" onkeydown="return false" align="center">
											<div class="img_w">
												<span ng-if="is_login">
													<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE}}" />
													</a>
													<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{((sale_status == 'ING' || sale_status == 'READY') && is_login) || custInfo.EMP_GB == 'Y'? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" alt="{{lot.TITLE}}"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE}}" />
													</a>
													<!-- YBK.출품.이미지게시X -->
													<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{((sale_status == 'ING' || sale_status == 'READY') && is_login) || custInfo.EMP_GB == 'Y'? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<img ng-src="/images/bg/no_image.jpg" />
													</a>
												</span> 
												<span ng-if="!is_login">
													<span ng-if="sale_status=='ING'">
														<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" rel="gallery1">
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}}" alt="{{lot.TITLE}}" />
														</a>
														<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" rel="gallery1">
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE}}" />
														</a>
														<!-- YBK.출품.이미지게시X -->
														<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')" rel="gallery1">
															<img ng-src="/images/bg/no_image.jpg" />
														</a>
													</span>
													<span ng-if="sale_status!='ING'">
														<span ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" rel="gallery1">
															<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : (lot.ARTWORK_IMG_NAME | imagePath : lot.ARTWORK_IMG_PATH : true)}}" alt="{{lot.TITLE}}" />
														</span>
														<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" rel="gallery1">
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
													<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" alt="{{lot.TITLE}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;" />
													</a>
													<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{((sale_status == 'ING' || sale_status == 'READY') && is_login) || custInfo.EMP_GB == 'Y'? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" alt="{{lot.TITLE}}"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" alt="{{lot.TITLE}}"  style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
													</a>
													<!-- YBK.출품.이미지게시X -->
													<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{((sale_status == 'ING' || sale_status == 'READY') && is_login) || custInfo.EMP_GB == 'Y'? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&view_type=GRID' : null}}" rel="gallery1">
														<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
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
															<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
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
													<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;" />
												</span>
											</div>  
										</div>
										
	                                    <div class="cancel" ng-show='lot.STAT_CD == "reentry"'> 
											<p class="notice_style03 tac"><spring:message code="message.lot.status.reentry" /></p> 
										</div> 
										
										<div class="info" ng-show='lot.STAT_CD != "reentry"'>  		
											<div class="lot_wish">	 				 				
												<div class="lotnum auction_lotnum">
													<strong title="{{lot.LOT_NO}}">{{lot.LOT_NO}}</strong>  
												</div>
												<div class="wish_btn">
													<button style="width:30px; height:30px;" type="button">
														<span ng-if="lot.STAT_CD != 'reentry'">     
												            <span ng-if="!custInfo.CUST_NO" class="grid_wish_btn" onClick="alert('로그인 해주세요.\n Please login for use.')" title="관심작품 보기 / WishList"> </span>  
												            <span ng-if="custInfo.CUST_NO && lot.INTE_LOT_DEL == 'N'" class="grid_wish_btn grid_wish_btn_sele" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishList"></span>
												            <span ng-if="custInfo.CUST_NO  && lot.INTE_LOT_DEL != 'N' && lot.STAT_CD != 'reentry'" class="grid_wish_btn" ng-click="inteSave({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});" title="관심작품 보기 / WishList"></span>
											            </span>   
											        </button>   
												</div>  
											</div> 
											
											<a ng-if="lot.STAT_CD != 'reentry'" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO : alert('로그인 후 확인할 수 있습니다.\n Please login for use.')}}">
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
	                                                <p class="edition_txt_p" ng-repeat="size in lot.LOT_SIZE_JSON" data-ng-show="$index <1"> <!-- 첫번째 사이즈만 보여준다(YDH.2020.02.01) -->
	                                                    <span ng-if="locale=='ko'" ng-bind="size | size_text_cm" title="{{size | size_text_cm}}"></span>  
	                                                    <span ng-if="locale!='ko'" ng-bind="size | size_text" title="{{size | size_text}}"></span>
                                                        <span class="edition_txt" ng-if='lot.EDITION' title="{{lot.EDITION}}"><span ng-bind="lot.EDITION" title="{{lot.EDITION}}"></span></span>           
	                                                </p>     
												</div> 
											
												<div class="estimate auction_estimate" ng-show='lot.STAT_CD != "reentry"'>
	                                            	<div class="es_price">    
	                                            		<p class="krw Price_inqury" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></p>   
                                                        <ul ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null">
                                                            <li class="es_price_left"><spring:message code="label.expense.price" />   
                                                            </li> 
                                                            <li class="es_price_right" style="font-size: 12px; line-height: 20px;"> 
                                                                <p class="krw Price_inqury" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></p> 
                                                                <div ng-if="(lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" >
	                                                                <p>
	                                                                	<span class="Price_block"> 
	                                                                		{{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0}} 
		                                                                </span>
		                                                                <span class="Price_block">
	                                                                 		~ {{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}} 
	                                                                 	</span>
	                                                                </p> 
	                                                                <!-- <p>
	                                                                	<span class="Price_block"> 
                                                                 			{{lot.EXPE_PRICE_FROM_JSON.KRW | currency : "KRW " : 0}}
	                                                                 	</span>
	                                                                 	<span class="Price_block">
				                                                 			~ {{lot.EXPE_PRICE_TO_JSON.KRW | number : 0}} 
				                                                 		</span>
	                                                                </p>   -->
	                                                                 <!-- <span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
	                                                                  </br>{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}<br/>
	                                                                   ~{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}
	                                                                 </span> -->
                                                                 </div> 
                                                            </li>
                                                        </ul>
                                             	 	</div>
												</div> 
                                   			</a>
                                   			  
                                            <div class="ect auction_ect"><!-- 7.7sh추가 --> 
                                                <%-- <span ng-if="custInfo.CUST_NO > 0 && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) >= 0 && lot.LAST_PRICE > 0">
                                                    <p><strong class="txt_impo"><spring:message code="label.bid.price.sold" /><span ng-bind="' '+(base_currency)+' '+(lot.LAST_PRICE | number:0)"></span></strong></p>
                                                    <!-- <p ng-if="!lot.LAST_PRICE || lot.LAST_PRICE <= 0"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></p> -->
                                                </span> --%> 
                                                <!-- 오프라인 경매 && 금액 0 -->
                                                <span ng-if="!is_login && sale_status == 'END'">
                                                    <spring:message code="label.auction.soldpricelog" />
                                                </span>
												<span class="btn_style01 xlarge green02 full bidding_btn02 bidding_btn02_en" >
													<button type="button" ng-click="blacklotGo('${blacklot}', sale.SALE_NO, lot.LOT_NO)">
														<span ng-if="locale=='ko'">블랙랏</span><span ng-if="locale!='ko'">BLACKLOT</span> <spring:message code="label.go.bid.now" />
													</button>
												</span>
											</div><!-- 7.7sh추가 끝-->
											</div>
										</div> 
									</div> 
