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
											<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
											</a>
											<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" />
											</a>
											<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
												<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
											</a>
										</span>	
										<span ng-if="!is_login">
											<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
											</a>
											<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" />
											</a>												
											<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'" ng-href="#}" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
												<img ng-src="/images/bg/no_image.jpg" />
											</a>
										</span>																					
										<span ng_if="lot.STAT_CD == 'reentry'">
											<img ng-src="/images/bg/no_image.jpg" />
										</span>	
									</span>
									
									<span ng-if="sale_status != 'ING'">
										<span ng-if="is_login">
											<span ng_if="custInfo.EMP_GB == 'Y'">
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" />
												</a>
											</span>
											
											<span ng_if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
											</span>
											<span ng_if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" />
											</span>
											
											<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
												<img ng-src="/images/bg/no_image.jpg" />
											</span>
										</span>
										<span ng-if="!is_login">
											<span ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
											</span>
											<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" />
											</span>
											
											<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
												<img ng-src="/images/bg/no_image.jpg" />
											</span>
										</span>										
										<span ng_if="lot.STAT_CD == 'reentry'"> 
											<img ng-src="/images/bg/no_image.jpg" />
										</span>  
									</span>
								</div>
								
								<!-- 경매 결과 이미지 3*3 사이즈 -->  
								<div class="result_auction_img_wrap" ng-if="sale_status=='END'">    
									<div class="result_auction_img" oncontextmenu="return false" ondragstart="return false">
										<span ng-if="sale_status == 'ING'"> 
											<span ng-if="is_login">
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</a>
												<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
											</span>	
											<span ng-if="!is_login">
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</a>												
												<a ng-if="lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN != 'Y'" ng-href="#}" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</a>
											</span>																					
											<span ng_if="lot.STAT_CD == 'reentry'">
												<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
											</span>	
										</span>
										
										<span ng-if="sale_status != 'ING'">
											<span ng-if="is_login">
												<span ng_if="custInfo.EMP_GB == 'Y'">
													<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
													</a>
													<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
													</a>
												</span>
												
												<span ng_if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</span>
												<span ng_if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</span>
												
												<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
													<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</span>
											</span>
											<span ng-if="!is_login">
												<span ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</span>
												<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</span>
												
												<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
													<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</span>
											</span>										
											<span ng_if="lot.STAT_CD == 'reentry'">
												<img ng-src="/images/bg/no_image.jpg" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
											</span>
										</span>
									</div> 
								</div> 
								<!-- // 경매 종료 후 이미지 3*3 사이즈 -->  	
								
								<div class="hidden_box auction_list_hidden_box">
									<%-- 출품 취소 여부 확인 --%> 
									<div class="cancel" ng-show='lot.STAT_CD == "reentry"'>
										<p class="notice_style03 tac"><spring:message code="message.lot.status.reentry" /></p>
									</div>    
									
									<!-- 홍콩경매 여부에 따른 화면표시 확인 -->  
									<div class="author auction_list_author" ng-show='lot.STAT_CD != "reentry"'>
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
										
										<a ng-if="lot.STAT_CD != 'reentry'" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotOutsideDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : alert('로그인 후 확인할 수 있습니다.\n Please login for use.')}}"> 
											<div class="name auction_workartist">    
												<span ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}"></span> 
												<!-- <span class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh" style="font-weight:normal; font-family:none;"></span> -->  
												<span class="txt_pale" ng-if="lot.BORN_YEAR!=null" ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')" title="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')"></span>   
											</div>  
											<div class="title auction_worktitle" style="border: none;">  
												<div class="tit"><span ng-bind="lot.TITLE_JSON[locale]" title="{{lot.TITLE_JSON[locale]}}"></span></div>  
												<div class="lang web_only">
													<!-- <span ng-bind="lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale]"></span> //2018.08.30 캡션간소화처리(YDH) -->
													<p ng-if="lot.TITLE_JSON.zh != lot.TITLE_JSON.en"><span ng-if="lot.TITLE_JSON.zh != null" ng-bind="lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale]"></span></p>
													<span ng-bind="lot.STITLE_JSON[locale]" title="{{lot.STITLE_JSON[locale]}}"></span>  
													<p ng-if="locale != 'en'"><span ng-if="lot.STITLE_JSON.en != null && lot.STITLE_JSON.ko != lot.STITLE_JSON.en" ng-bind="lot.STITLE_JSON.en"></span></p> 
													<p ng-if="lot.STITLE_JSON.zh != lot.STITLE_JSON.en"><span ng-if="lot.STITLE_JSON.zh != null" ng-bind="lot.STITLE_JSON.zh | trimSameCheck : lot.STITLE_JSON[locale]"></span></p>
												</div>  
											</div>
		
											<div class="explain auction_list_explain" ng-show='lot.STAT_CD != "reentry"'>
												<p ng-if='lot.MAKE_YEAR_JSON[locale]'>
													<span ng-bind="lot.MAKE_YEAR_JSON['ko']" title="{{lot.MAKE_YEAR_JSON['ko']}}"></span> 
												</p>  
												<p>
													<span ng-bind="lot.MATE_NM_EN" title="{{lot.MATE_NM_EN}}"></span>  
												</p> 
												<p ng-repeat="size in lot.LOT_SIZE_JSON">
													<span ng-bind="size | size_text" title="{{size | size_text}}"></span>    
												</p>   
												<p ng-if='lot.EDITION'><span ng-bind="lot.EDITION" title="{{lot.EDITION}}"></span></p>  
											</div>
										</a>	  
									</div> <!-- //auction_list_author -->   
									
									<div class="estimate auction_list_estimate" ng-show='lot.STAT_CD != "reentry"'>
										<div class="es_price">    
                                       		<!-- 추정가 -->   
                                       		<ul ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null">
                                       			<li class="es_price_left"> 
                                       				<spring:message code="label.expense.price" />
                                       			</li> 
                                       			<li class="es_price_right" style="font-size: 12px; line-height: 20px;">      
                                            		<p class="krw Price_inqury" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></p>
                                            		<!-- 온라인인 경우 -->
                                            		<div ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" >
			                                            <p>
				                                            <span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0}}</span>
				                                            <span class="Price_block">~ {{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}}</span> 
			                                            </p>
			                                            <!-- <p> 
			                                            	<span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON.KRW | currency : "KRW " : 0}}</span>
			                                                <span class="Price_block">~ {{lot.EXPE_PRICE_TO_JSON.KRW | number : 0}}</span>
				                                            <span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
			                                                </br>{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}<br/>
			                                                ~{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}
				                                            </span> 
				                                        </p> -->
			                                        </div>          
                                            	</li>
                                      		</ul>  
										</div>   
										<div class="ect auction_ect">
											<span class="btn_style01 xlarge green02 full bidding_btn02 bidding_btn02_en">
	                                            <button type="button" ng-click="blacklotGo('${blacklot}', sale.SALE_NO, lot.LOT_NO)">
													<span ng-if="locale=='ko'">블랙랏</span><span ng-if="locale!='ko'">BLACKLOT</span> <spring:message code="label.go.bid.now" />
	                                            </button>
	                                        </span>
										</div> <!-- // auction_list_estimate -->
									</div><!-- //auction_list_estimate -->  
									 
									<span ng-show='lot.STAT_CD != "reentry"' ng-if="['private','exhibit'].indexOf(sale.SALE_KIND_CD) >= 0 && sale_status == 'ING'" class="btn_style01 xlarge white btn_bid">
										<button type="button" onclick="goInquiryWrite();"><spring:message code="label.go.inquery" /></button>
									</span><!-- 전시 --> 
								</div> <!--hidden_box end--> 
