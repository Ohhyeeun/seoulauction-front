<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

								<div class="wraph" ng-if="asList.WWW_DISP_YN == 'Y'">
                                	<div class="wraph_bor private_wraph_bor">         
											<div class="img" align="center"> 
												<div class="img_w">
                                					<a ng-href="/lotDetailPrivate?SALE_AS_NO={{asList.SALE_AS_NO}}">  
														<img ng-src="https://www.seoulauction.com/nas_img/{{asList.AS_IMG_PATH}}/{{asList.AS_IMG_NAME}}" / style="max-width: 100%; max-height: 300px;">
													</a>
												</div>
											</div><!-- //img -->      
											<div class="info"> 
												<a ng-href="/lotDetailPrivate?SALE_AS_NO={{asList.SALE_AS_NO}}">
													<div class="lot_wish"> 
														<div class="lotnum auction_lotnum"> 
															<strong title="{{asList.AS_NO}}">{{asList.AS_NO}}</strong>  
														</div>
													</div>  
													<div class="workartist auction_workartist">
													<c:if test="${locale == 'ko'}"> 
														<span title="{{asList.ARTIST_NAME_BLOB_KO}}">{{asList.ARTIST_NAME_BLOB_KO}}</span> 
													</c:if> 
													<c:if test="${locale != 'ko'}">  
														<span title="{{asList.ARTIST_NAME_BLOB_EN}}">{{asList.ARTIST_NAME_BLOB_EN}}</span>   
													</c:if>
														<span class="txt_pale auction_txt_pale" title="{{asList.BORN_YEAR}}">{{asList.BORN_YEAR}}</span> 
													</div>
													<div class="worktitle auction_worktitle">
													<c:if test="${locale == 'ko'}"> 
														<span title="{{asList.TITLE_BLOB_KO}}">{{asList.TITLE_BLOB_KO}}</span>
													</c:if> 
													<c:if test="${locale != 'ko'}"> 
														<span title="{{asList.TITLE_BLOB_EN}}">{{asList.TITLE_BLOB_EN}}</span> 
													</c:if>  
													</div>	 		 
													<div class="workmaterial workmaterial02" style="line-height: 1.5;">    
														<span style="font-size:14px" class="ps_after_span" title="{{asList.MAKE_YEAR_BLOB}}">{{asList.MAKE_YEAR_BLOB}}</span>  
														<span style="font-size:14px" title="{{asList.CD_NM_EN}}">{{asList.CD_NM_EN}}</span>     
														<p class="edition_txt_p" ng-repeat="size in asList.AS_SIZE_JSON" data-ng-show="$index < 1"> <!-- 첫번째 사이즈만 보여준다(YDH.2020.02.01) -->
	                                                     <span ng-bind="size | size_text_cm" title="{{size | size_text_cm}}"></span>     
                                                         <span class="edition_txt" ng-if='lot.EDITION' title="{{lot.EDITION}}"><span ng-bind="lot.EDITION" title="{{lot.EDITION}}"></span></span>    
	                                                	</p>   
		                                            </div> 
			                                        <div class="ect">
					                                    <div class="btn"> 	
					                                       <!-- 1:1문의 또는 서면/전화 방식 결정 후 진행 필요함.--> 
					                                       <span class="btn_style01 xlarge green02 full"> 
					                                            <button type="button" onclick="location.href='/customer/inquiryForm'"><spring:message code="label.go.inquery" /></button>
					                                       </span>    
					                                    </div>
													</div><!--//ect-->
												</a> 
		                                    </div><!-- //info --> 
									</div><!-- //wraph_bor -->
								</div>
								
									
								