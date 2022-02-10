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
											<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
												<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
											</a>
											<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
												<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" />
											</a>
											<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
												<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
											</a>
										</span>	
										<span ng-if="!is_login">
											<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
												<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
											</a>
											<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
												<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
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
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" />
												</a>
											</span>
											
											<span ng_if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
												<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
											</span>
											<span ng_if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
												<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" />
											</span>
											
											<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
												<img ng-src="/images/bg/no_image.jpg" />
											</span>
										</span>
										<span ng-if="!is_login">
											<span ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
												<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" />
											</span>
											<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
												<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
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
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</a>
												<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
											</span>	
											<span ng-if="!is_login">
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
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
													<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
													</a>
													<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
													</a>
												</span>
												
												<span ng_if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
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
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> -->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="width:auto; height: auto; max-width: 100px; max-height: 100px;"/>
												</span>
												<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> -->
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
									<!-- 관심추가, 제거 -->
									<!--  <button ng-if="lot.STAT_CD != 'reentry' && sale_status == 'ING'" id="interestBtn" type="button" class="btn_interest sele" onclick="interestRemove()"></button>
									<button ng-if="lot.STAT_CD != 'reentry' && sale_status == 'ING'" id="interestBtn" type="button" class="btn_interest" onclick="interestAdd();"></button>->		
									<div class="img" oncontextmenu="return false" ondragstart="return false">
										<span ng-if="sale_status == 'ING'">
											<span ng-if="is_login">
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> ->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN == 'Y' || custInfo.EMP_GB == 'Y')" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> ->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
												<a ng-if="lot.STAT_CD != 'reentry' && (lot.IMG_DISP_YN != 'Y' && custInfo.EMP_GB != 'Y')" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
													<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
											</span>	
											<span ng-if="!is_login">
												<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> ->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</a>
												<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'" ng-href="#" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> ->
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
													<a ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> ->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
													</a>
													<a ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry'" ng-href="{{ is_login ? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=' + sale_status + '&view_type=LIST' : '#'}}">
														<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> ->
														<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
													</a>
												</span>
												
												<span ng_if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> ->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</span>
												<span ng_if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN == 'Y'">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> ->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</span>
												
												<span ng_if="custInfo.EMP_GB != 'Y' && lot.IMG_DISP_YN != 'Y'">
													<img ng-src="/images/bg/no_image.jpg" style="height: 100%; width: auto; margin-top: 0px;"/>
												</span>
											</span>
											<span ng-if="!is_login">
												<span ng-if="sale.SALE_NO <= '408' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}})'}" style="margin-top: 0px;"/> ->
													<img ng-src="<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath : lot.LOT_IMG_PATH : true) : ''}}" style="height: 100%; width: auto; margin-top: 0px;"/>
												</span>
												<span ng-if="sale.SALE_NO >= '409' && lot.STAT_CD != 'reentry' && lot.IMG_DISP_YN == 'Y'">
													<!-- <img class="bg-contain" ng-style="{'background': 'url(<spring:eval expression="@configure['img.root.path']" />{{lot.LOT_IMG_NAME ? (lot.LOT_IMG_NAME | imagePath1 : lot.LOT_IMG_PATH : 'list') : ''}})'}" style="margin-top: 0px;"/> ->
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
									
									<!-- // lot 번호 
									<div class="lot">
										<span ng-bind="'Lot. '"></span>
										<strong>
											<span ng-if="sale.SALE_NO == '410'">
												<span ng-if="lot.LOT_NO != '91' && lot.LOT_NO != '92'" ng-bind="lot.LOT_NO"></span>
												<span ng-if="lot.LOT_NO == '91'" ng-init="SLOT01='S01';SLOT02='S02'" ng-bind="SLOT01"></span>
												<span ng-if="lot.LOT_NO == '92'" ng-init="SLOT01='S01';SLOT02='S02'" ng-bind="SLOT02"></span>
											</span>
											<span ng-if="sale.SALE_NO != '410'" ng-bind="lot.LOT_NO"></span>
										</strong>  
									</div> --> 
		
									<%-- 출품 취소 여부 확인 --%> 
									<div class="cancel auction_list_cancel" ng-show='lot.STAT_CD == "reentry"'>
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
										
										<!-- a태그 블록처리 -->    
										<a ng-if="lot.STAT_CD != 'reentry'" ng-href="{{(sale_status == 'ING' && is_login) || custInfo.EMP_GB == 'Y'? '/lotDetail?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO : alert('로그인 후 확인할 수 있습니다.\n Please login for use.')}}">
											<div class="name auction_workartist">     
												<span ng-bind="lot.ARTIST_NAME_JSON[locale]" title="{{lot.ARTIST_NAME_JSON[locale]}}"></span>   
												<!-- <span class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh" style="font-weight:normal; font-family:none;"></span> --> 
												<span class="txt_pale" ng-if="lot.BORN_YEAR!=null" ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')" title="{{(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')}}"></span> 
												<!-- // 아티스트 
													 <div class="lang web_only"> 
													<!-- <span ng-if="locale != 'en'" ng-bind="lot.ARTIST_NAME_JSON.en"></span> //2018.08.30 캡션간소화처리(YDH) ->
													<span class="txt_cn" ng-bind="lot.ARTIST_NAME_JSON.zh"></span>
													<span class="txt_pale" ng-if="lot.BORN_YEAR!=null" ng-bind="(lot.BORN_YEAR)+(lot.DIE_YEAR != null && lot.DIE_YEAR != '' ? '~' + lot.DIE_YEAR : '')"></span> 
												</div> -->  
											</div>
											<div class="title auction_worktitle" style="border: none;">  
												<div class="tit"><span ng-bind="lot.TITLE_JSON[locale]" title="{{lot.TITLE_JSON[locale]}} {{lot.TITLE_JSON.zh}}"></span></div>   
												<div class="lang web_only"> 
													<!-- <span ng-bind="lot.TITLE_JSON.en | trimSameCheck : lot.TITLE_JSON[locale]"></span> //2018.08.30 캡션간소화처리(YDH) -->
													<p ng-if="lot.TITLE_JSON.zh != lot.TITLE_JSON.en"><span ng-if="lot.TITLE_JSON.zh != null" ng-bind="lot.TITLE_JSON.zh | trimSameCheck : lot.TITLE_JSON[locale]"></span></p>
													<!--  <span style="color:#666" ng-bind="(lot.STITLE_JSON.en | trimSameCheck : lot.STITLE_JSON[locale])"></span> -->
													<span ng-bind="lot.STITLE_JSON[locale]"></span>
													<!-- <p ng-if="locale == 'en'"><span ng-if="lot.STITLE_JSON.ko != null && lot.STITLE_JSON.ko != lot.STITLE_JSON.en" ng-bind="lot.STITLE_JSON.ko"></span></p>
													<p ng-if="locale != 'en'"><span ng-if="lot.STITLE_JSON.en != null && lot.STITLE_JSON.ko != lot.STITLE_JSON.en" ng-bind="lot.STITLE_JSON.en"></span></p>  //2018.08.30 캡션간소화처리(YDH) -->
													<p ng-if="lot.STITLE_JSON.zh != lot.STITLE_JSON.en"><span ng-if="lot.STITLE_JSON.zh != null" ng-bind="lot.STITLE_JSON.zh | trimSameCheck : lot.STITLE_JSON[locale]"></span></p>
												</div>
											</div> 
	
											<div class="explain auction_list_explain" ng-show='lot.STAT_CD != "reentry"'> 
												<!-- <span ng-if="lot.MATE_NM" ng-bind="'MATE_NM' | localeValue : lot"></span> -->
												<!-- <p ng-if="locale == 'ko' && lot.MATE_NM_EN != lot.MATE_NM"><span ng-bind="lot.MATE_NM_EN"></span></p>  //2018.08.30 캡션간소화처리(YDH) -->
												<p ng-if='lot.MAKE_YEAR_JSON[locale]'>
													<span ng-bind="lot.MAKE_YEAR_JSON['ko']" title="{{lot.MAKE_YEAR_JSON['ko']}}"></span> 
												<!--	{{lot.MAKE_YEAR_JSON[locale]}}
												  	{{lot.MAKE_YEAR_JSON["en"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}
													<span ng-if="lot.MAKE_YEAR_JSON.zh != null">{{lot.MAKE_YEAR_JSON["zh"] | trimSameCheck : lot.MAKE_YEAR_JSON[locale] }}</span> -->
												</p>
												<p>
													<span ng-bind="lot.MATE_NM_EN" title="{{lot.MATE_NM_EN}}"></span> 
												</p>  
												<p ng-repeat="size in lot.LOT_SIZE_JSON">
													<span ng-if="locale!='ko'" ng-bind="size | size_text" title="{{size | size_text}}"></span>
													<span ng-if="locale=='ko'" ng-bind="size | size_text_cm" title="{{size | size_text_cm}}"></span>  
													<!-- <span ng-if="locale!='ko'" ng-bind="size | size_text_in"></span> -->
												</p> 
												<p ng-if='lot.EDITION'><span ng-bind="lot.EDITION" title="{{lot.EDITION}}"></span></p>  
												
												<!-- <p ng-if='lot.SIGN_INFO_JSON[locale]'> 
													<span bind-html-compile="lot.SIGN_INFO_JSON['ko']"></span> 
													<span bind-html-compile="lot.SIGN_INFO_JSON[locale]"></span>
												  	{{lot.SIGN_INFO_JSON["en"] | trimSameCheck : lot.SIGN_INFO_JSON[locale] }}
													<span ng-if="lot.SIGN_INFO_JSON.zh != null">{{lot.SIGN_INFO_JSON["zh"] | trimSameCheck : lot.SIGN_INFO_JSON[locale] }}</span>
												</p> --> 
											</div> 
										</a> 
									</div>
									
									<div class="estimate auction_list_estimate" ng-show='lot.STAT_CD != "reentry"'>
										<div class="es_price">
	                                        <p class="krw Price_inqury" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></p>   
                                       		<!-- 추정가 -->  
                                      		<ul ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null">
                                      			<li class="es_price_left"> 
                                      				<spring:message code="label.expense.price" />  
                                      			</li>   
                                      			<li class="es_price_right" style="font-size: 12px; line-height: 20px;">      
                                      				<p class="krw Price_inqury" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></p>
	                                      				<!-- 온라인인 경우 -->
	                                      			<div ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1) && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" >
	                                                	<p>
	                                                		<span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0}}</span>
	                                                		<span class="Price_block">~ {{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}}</span>
	                                                	</p>
		                                                <p ng-if="(locale=='en' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
		                                                    <span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}</span> 
		                                                    <span class="Price_block">~{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}</span> 
		                                                </p>  
		                                                <p ng-if="(locale=='en' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null && (lot.EXPE_PRICE_TO_JSON[sub_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[sub_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[sub_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[sub_currency]) != null" >  
		                                                    <span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0}}</span>  
		                                                    <span class="Price_block"> ~ {{lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0}}</span>  
		                                                </p>     
                                                 	</div>  
                                                 
	                                                <!-- 오프라인인 경우 -->
	                                                <div ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (['online','online_zb'].indexOf(sale.SALE_KIND_CD) < 0) && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" >
			                                            <span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0}}</span> 
		                                            	<span class="Price_block">~ {{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}}</span> 
		                                                <%--임시 <span ng-if="(locale=='en' && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) < 0) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
		                                                    </br>{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}<br/>
		                                                     ~{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}
		                                                </span> --%>
		                                                <p ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) < 0 && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
		                                                    <span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}</span>
		                                                    <span class="Price_block">~{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}</span>  
		                                                </p> 
		                                                <p ng-if="(locale!='en' && ['online','online_zb','main','plan'].indexOf(sale.SALE_KIND_CD) < 0) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null && lot.EXPE_PRICE_FROM_JSON != 0 && lot.EXPE_PRICE_FROM_JSON != null" >
		                                                    <span class="Price_block">{{lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0}}</span> 
		                                                    <span class="Price_block">~ {{lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0}}</span> 
		                                                </p>     
	                                                </div> 
                                       			</li>  
                                     		</ul> 
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
										<div class="es_price" > 
                                           	<ul>
											 	<li class="es_price_left text_hide" style="color:#ff0000;">
											 		<span ng-if="lot.LAST_PRICE >= 0 && (['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1) && lot.END_YN == 'N'"><spring:message code="label.bid.price" /></span>
											 		<span ng-if="custInfo.CUST_NO > 0 && is_login && lot.LAST_PRICE >= 0 && lot.BID_CNT > 0 && lot.END_YN == 'Y'"><spring:message code="label.bid.price.sold" /> </span>
											 		<span ng-if="lot.LAST_PRICE >= 0 && lot.BID_CNT > 0 && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
		                                            <span style="color:#ff0000; font-size:11px;">({{lot.BID_CNT | number:0}}<span ng-if="locale=='ko'">회</span><span ng-if="locale!='ko'">bid</span>)</span>
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
										</div>	 
										<!-- 홍콩경매 sale.SALE_KIND_CD == 'hongkong'는 HKD를 맨위로 표시한다. -->
										<%-- <span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
										<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null">
											<!-- KRW -->
											<p>
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span>
												<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)" ng-bind="' ~ '"></span>	
												<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
											</p>
											<!-- USD -->
											<p ng-if="lot.EXPE_PRICE_FROM_JSON.USD != null && sale.SALE_KIND_CD != 'hongkong'">
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
												<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)" ng-bind="' ~ '"></span>	
												<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
											</p>
											<!-- HKD -->
											<p>
												<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
												<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)" ng-bind="' ~ '"></span>	
												<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
											</p> 
										</span> --%> 
										
										<!-- 응찰하기 btn & 경매기록 btn -->
										<div class="ect auction_ect"> 
											<!-- 온라인 진행중 -->
											<div class="time_count aulist_time_count"> 
												<div class="" ng-class="{double:viewId == 'CURRENT_AUCTION'}">
													<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
													<div class="state auction_list_state" ng-class="{end:lot.END_YN == 'Y'}">
														<span ng-if="lot.END_YN == 'Y'"><spring:message code="label.auction.finish" /></span><!-- 온라인 경매 종료시 -->
														<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N'"><!-- 온라인 경매 진행중 -->
															<spring:message code="label.auction.ongoing" /></span>  
													</div></span>  
												</div>
												<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N'">
													<p class="time" style="font-size:12px;"><span ng-bind="(getDurationTime(lot.TO_DT))"></span>
														<!-- (<spring:message code="label.bid.mybidding" /> : <span ng-bind="lot.MY_BID_CNT"></span><span ng-if="lot.IS_WIN=='Y'"> - <spring:message code="label.bid.mybidding2" /></span>)  -->
													</p> 
												</span>
											</div> 
											
											<!-- 응찰하기 btn & 경매기록 btn -->
											<div class="btn bidding_btn" ng-if="sale.SALE_NO != '555' && sale.SALE_NO != '594'">
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
		                                        
		    									<!-- 응찰하기 버튼 와인 조건 추가 NY인경우 --> 	
		                                        <span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry" && (lot.WINE_YN == "N" || custInfo.EMP_GB == "Y")' class="btn_style01 xlarge green02 full bidding_btn02 bidding_btn02_en"
		                                            ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N' && sale.AUTO_BID_REQ_CLOSE_DT <= sale.DB_NOW"><!-- sale_status == 'END' 대체. lot.END_YN-->
		                                            <button type="button" ng-if="custInfo.BID_FORBID == 'N' && custInfo.CUST_NO && ((custInfo.LOCAL_KIND_CD == 'foreigner' && custInfo.FORE_BID_YN == 'Y') || (custInfo.LOCAL_KIND_CD != 'foreigner'))" ng-click="showBidPopup({'parent':this, 'sale':sale, 'lot':lot});" >
		                                                <spring:message code="label.go.bid.now" />
		                                            </button> 
		                                        </span> 
		                                        
		                                        <!-- 응찰하기 버튼 와인 조건 추가 Y인경우 --> 	
		                                        <span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry" && lot.WINE_YN == "Y" && custInfo.EMP_GB == "N"' class="btn_style01 xlarge green02 full bidding_btn02 bidding_btn02_en"
		                                            ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N' && sale.AUTO_BID_REQ_CLOSE_DT <= sale.DB_NOW"><!-- sale_status == 'END' 대체. lot.END_YN-->
		                                            <button type="button" ng-if="custInfo.BID_FORBID == 'N' && custInfo.CUST_NO && ((custInfo.LOCAL_KIND_CD == 'foreigner' && custInfo.FORE_BID_YN == 'Y') || (custInfo.LOCAL_KIND_CD != 'foreigner'))" onClick="alert('와인 응찰은 서울옥션 담당자 또는 \n02-2075-4326으로 문의주시기 바랍니다. \nPlease contact ejlee@seoulauction.com for wine.')" >
		                                                <spring:message code="label.go.bid.now" />
		                                            </button>
		                                        </span>
		                                        
		                                        <span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry"' class="btn_style01 xlarge green02 full bidding_btn02"   
		                                            ng-if="sale.SALE_NO != '555' && sale.SALE_NO != '594' &&['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && is_login && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
		                                            <button ng-if="(custInfo.MEMBERSHIP_YN == 'Y' || custInfo.FORE_BID_YN == 'Y') && sale.SALE_NO != '563' && sale.SALE_NO != '594'" type="button" ng-click="showBidRequestPopup({'parent':this, 'sale':sale, 'lot':lot});" >
		                                                <spring:message code="label.go.bid.request" />
		                                            </button><!-- 정회원 --> 
		                                        </span>  
		                                        
		                                        <span class="btn_style01 xlarge green02 full bidding_btn02" ng-if="sale.SALE_NO != '563' && sale.SALE_NO != '594' &&  ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && is_login == 'false' && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')" onClick="alert('정회원 등록 후 재로그인하시면 응찰하실 수 있습니다.\n The website bidding is open to bidding members only. After Register on the website, try log in again.')"> 
		                                            <button type="button" >
		                                                <spring:message code="label.go.bid.request" />
		                                            </button> 
		                                        </span>  
		                                                 
		                                        <!-- 온라인 / 국내 -->
		                                        <span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry"' class="btn_style01 xlarge green02 btn_bid"
		                                            ng-if="['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && is_login && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
		                                            <button ng-if="custInfo.FORE_BID_YN == 'Y'" type="button" ng-click="showBidRequestPopup({'parent':this, 'sale':sale, 'lot':lot});" >
		                                                <spring:message code="label.go.bid.request" />
		                                            </button> 
		                                        </span>
		                                        <!-- 정회원. 국외 회원 응찰 여부 체크된 고객 --><!-- 온라인 / 국외-->
		                                        <span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge white full" ng-if="['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) >= 0 && !is_login && sale_status == 'ING'">
		                                            <button type="button" onclick="loginAlert();"><spring:message code="label.go.bid.request" /></button>	
		                                        </span><!-- 오프라인 / 로그아웃 -->
		                                    </div>
										</div> <!-- // auction_list_estimate --> 
									</div><!-- //estimate -->   
									
									<!-- 기존 소스들 (추정가 낙찰가 시작가 / 버튼 / 라인 / 관심작품 등)
									 <span class="txt_dark web_only" ng-if="(lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null"><spring:message code="label.expense.price" /></span>
									
									<span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
                                			  <span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null" >
                                              {{lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0}}<br/> 
                                              ~ {{lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0}}
                                               <span ng-if="(locale=='en' || ['online','online_zb'].indexOf(sale.SALE_KIND_CD) < 0) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
                                                   </br>{{lot.EXPE_PRICE_FROM_JSON.USD | currency : "USD " : 0}}<br/>
                                                    ~{{lot.EXPE_PRICE_TO_JSON.USD | number : 0}}
                                               </span>
                                               <span ng-if="( ['online','online_zb'].indexOf(sale.SALE_KIND_CD) < 0) && lot.EXPE_PRICE_INQ_YN != 'Y' && lot.EXPE_PRICE_FROM_JSON.USD != 0 && lot.EXPE_PRICE_FROM_JSON.USD != null" >
                                                   </br>{{lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0}}<br/>
                                                    ~ {{lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0}}
                                               </span>
                                              </span>
									
									<!-- 홍콩경매 sale.SALE_KIND_CD == 'hongkong'는 HKD를 맨위로 표시한다. -->
									<%-- <span class="krw" ng-if="lot.EXPE_PRICE_INQ_YN == 'Y'"><spring:message code="label.auction.detail.Request" /></span>
									<span ng-if="lot.EXPE_PRICE_INQ_YN != 'Y' && (lot.EXPE_PRICE_TO_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != 0 && (lot.EXPE_PRICE_TO_JSON[base_currency]) != null && (lot.EXPE_PRICE_FROM_JSON[base_currency]) != null">
										<!-- KRW -->
										<p>
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON[base_currency] | currency : base_currency + ' ' : 0"></span>
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON[base_currency] != null) || (lot.EXPE_PRICE_TO_JSON[base_currency] != null)" ng-bind="' ~ '"></span>	
											<span ng-bind="lot.EXPE_PRICE_TO_JSON[base_currency] | number : 0"></span> 
										</p>
										<!-- USD -->
										<p ng-if="lot.EXPE_PRICE_FROM_JSON.USD != null && sale.SALE_KIND_CD != 'hongkong'">
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON.USD | currency : 'USD ' : 0"></span>
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON.USD != null) || (lot.EXPE_PRICE_TO_JSON.USD != null)" ng-bind="' ~ '"></span>	
											<span ng-bind="lot.EXPE_PRICE_TO_JSON.USD | number : 0"></span>
										</p>
										<!-- HKD -->
										<p>
											<span ng-bind="lot.EXPE_PRICE_FROM_JSON[sub_currency] | currency : sub_currency + ' ' : 0"></span>
											<span ng-if="(lot.EXPE_PRICE_FROM_JSON[sub_currency] != null) || (lot.EXPE_PRICE_TO_JSON[sub_currency] != null)" ng-bind="' ~ '"></span>	
											<span ng-bind="lot.EXPE_PRICE_TO_JSON[sub_currency] | number : 0"></span>
										</p>
									</span> --%>
									<!--시작가->
									<div>
										<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.STAT_CD != 'reentry' && lot.START_PRICE > 0">
											<br/><br/>
											<span class="txt_dark"><spring:message code="label.expense.start_price" /></span>
											<p>KRW <span ng-bind="lot.START_PRICE | number : 0"></span></p>
										</span>	
									</div>
									<!--시작가끝->
								</div>

								<div class="state_wrap" ng-show='lot.STAT_CD != "reentry"'>
									<div class="state_area" ng-class="{double:viewId == 'CURRENT_AUCTION'}">
										<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1">
										<div class="state" ng-class="{end:lot.END_YN == 'Y'}">
											<span ng-if="lot.END_YN == 'Y'"><spring:message code="label.auction.finish" /></span><!-- 온라인 경매 종료시 ->
											<span ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N'"><!-- 온라인 경매 진행중 ->
												<spring:message code="label.auction.ongoing" /></span>
										</div></span>
										<div class="info">  
											<%-- <ul ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'READY'">
												<li class="time">
													{{auctionBidStartTime | dateFormat}} KST <spring:message code="label.auction.start" />
													~
													{{sellToDate | dateFormat}} KST <spring:message code="label.finish.by.lot.number" />
												</li>
											</ul>--%><!-- //온라인 준비 ->
											
											<ul ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N'">
												<li class="time"><span ng-bind="(getDurationTime(lot.TO_DT))+' ('+(lot.TO_DT | date : 'yyyy.M.d h:mm:ss' | lowercase)+')'"></span></li>
												<li><spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" /></li>
												<li><strong class="txt_impo"><spring:message code="label.bid.price" /><span ng-if="lot.LAST_PRICE != null" ng-bind="sale.CURR_CD+' '+(lot.LAST_PRICE | number:0)"></span></strong>
													(<spring:message code="label.bid.mybidding" /> : <span ng-bind="lot.MY_BID_CNT"></span><spring:message code="label.bid.mybidding1" /><span ng-if="lot.IS_WIN=='Y'"> - <spring:message code="label.bid.mybidding2" /></span>)</li>
											</ul><!-- 온라인 진행중 ->
											
											<ul ng-if="custInfo.CUST_NO > 0 && is_login && ['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'Y'">
												<li class="time" ng-if="viewId == 'CURRENT_AUCTION'"><span ng-bind="(lot.TO_DT | dateFormat)+' KST'"></span> <spring:message code="label.auction.finish" /></li>
												<li ng-if="lot.LAST_PRICE >= 0 && lot.BID_CNT > 0"><spring:message code="label.bid.count" arguments="{{lot.BID_CNT | number:0}}" /></li>
												<li ng-if="(!lot.LAST_PRICE || lot.LAST_PRICE <= 0) && lot.BID_CNT < 1"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></li>
												<li ng-if="lot.LAST_PRICE >= 0 && lot.BID_CNT > 0"><spring:message code="label.bid.price.sold" />
													<strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION', txt_green02:viewId != 'CURRENT_AUCTION'}"> <span ng-bind="'KRW '+(lot.LAST_PRICE | number:0)"></span></strong>
												</li>
											</ul><!-- 온라인 종료 ->
											<!--  is_login 기능이 안되어서 임시로 custInfo.CUST_NO 체크 기능 추가(YDH. 2017.09.20) ->
											<ul ng-if="custInfo.CUST_NO > 0 && is_login && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) >= 0 && lot.LAST_PRICE > 0">
												<li><strong class="txt_impo"><spring:message code="label.bid.price.sold" /> <span ng-bind="(base_currency)+ ' '+(lot.LAST_PRICE | number:0)"></span></strong></li>
												<!--  <li ng-if="!lot.LAST_PRICE || lot.LAST_PRICE <= 0"><strong ng-class="{txt_impo:viewId == 'CURRENT_AUCTION'}"><spring:message code="label.auction.unsold" /></strong></li> ->
											</ul><!-- 오프라인 경매 && 금액 0 -->
											<!--  <span ng-if="!is_login && sale_status == 'END'">  ->
											<!--  is_login 기능이 안되어서 임시로 custInfo.CUST_NO 체크 기능 추가(YDH. 2017.09.20). 변경전 : !is_login && lot.END_YN == 'Y' ->
											<ul ng-if="!custInfo.CUST_NO && lot.END_YN == 'Y'" >
												<li><spring:message code="label.auction.soldpricelog" /></li>
											</ul>
											<!-- <span ng-if="!is_login && sale_status == 'ING' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1">  ->
											<ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
												<li><spring:message code="label.auction.loginlog" /></li>
                                                   <li><spring:message code="label.auction.loginlog_1" /></li>
											</ul>
											<ul ng-if="!custInfo.CUST_NO && lot.END_YN != 'Y' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && (lot.DB_NOW | date:'yyyyMMdd') >= (lot.SALE_TO_DT | date:'yyyyMMdd')">
												<li><spring:message code="label.auction.loginlog1" /></li>
											</ul>
											<ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD != 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
												<li ng-if="custInfo.MEMBERSHIP_YN != 'Y'">
													<spring:message code="label.auction.membershipchk" />
												</li>
											</ul>	
											<ul ng-if="custInfo.CUST_NO > 0 && is_login && custInfo.LOCAL_KIND_CD == 'foreigner' && ['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
												<li ng-if="custInfo.FORE_BID_YN != 'Y'">
													<spring:message code="label.auction.membershipchk" />
												</li>
											</ul>
										</div>
									</div>
								</div>
								<!-- YBK.20170407 컨디션리포트 추가 ->
								<span ng-if="sale_status == 'ING'">									
									<button ng-if="!custInfo.CUST_NO" type="button" class="btn_interest web_only" onClick="alert('로그인 해주세요.\n Please login for use.')">
										<span ng-if="locale=='ko'">관심작품</span>
										<span ng-if="locale!='ko'">FAVORITE WORK</span>
									</button>
								</span>										
							<!--	<span ng-if="!is_login && sale.SALE_KIND_CD == 'hongkong' && sale_status == 'ING'">
									<button type="button" class="btn_print" onClick="alert('로그인 해주세요.\n Please login for use.')">
										<span ng-if="locale=='ko'">Condition 요청</span>
										<span ng-if="locale!='ko'">Condition Req.</span>
									</button>
								</span> ->
								<span ng-if="custInfo.CUST_NO > 0 && sale_status == 'ING' && lot.STAT_CD != 'reentry'">
									<span ng-if="lot.INTE_LOT_DEL == 'N'" class="btn_interest sele web_only" >
										<button ng-if="custInfo.CUST_NO" type="button" ng-click="inteDel({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});">
											<span ng-if="locale=='ko'">관심작품 삭제</span>
											<span ng-if="locale!='ko'">FAVORITE WORK Del.</span>
										</button>
									</span>
									<span ng-if="custInfo.CUST_NO > 0 && lot.INTE_LOT_DEL != 'N' && lot.STAT_CD != 'reentry'" class="btn_interest web_only" >
										<button ng-if="custInfo.CUST_NO" type="button" ng-click="inteSave({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});">
											<span ng-if="locale=='ko'">관심작품</span>
											<span ng-if="locale!='ko'">FAVORITE WORK</span>
										</button>
									</span>
									<!--<span ng-if="custInfo.CUST_NO > 0 && is_login && sale.SALE_KIND_CD == 'hongkong'" class="btn_print" >
									    <span ng-if="lot.CR_INTE_LOT == 'N'"> 
										    <button type="button" ng-click="showConditionReportPopup({'parent':this, 'sale_no':lot.SALE_NO, 'lot_no':lot.LOT_NO});">
												<span ng-if="locale=='ko'">Condition 요청</span>
												<span ng-if="locale!='ko'">Condition Req.</span>
											</button>
										</span>
										<span ng-if="lot.CR_INTE_LOT != 'N'">
											<a ng-href="{{'/conditionPrt?sale_no=' + sale_no + '&lot_no=' + lot.LOT_NO + '&sale_status=END&view_type=LIST'}}" target="_blank">
												<button type="button">
													<span ng-if="locale=='ko'">Condition 출력</span>
													<span ng-if="locale!='ko'">Condition PRT</span>
												</button>
											</a>
										</span>
									</span>->
								</span>
								<!-- YBK.20170407 컨디션리포트 추가 -->
                                   
								<!-- 버튼 -->
								<!-- test ->
								
								<span ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry"' class="btn_style01 xlarge dark btn_bid" 
									ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'Y'">
									<button ng-if="custInfo.BID_FORBID == 'N' && custInfo.CUST_NO && ((custInfo.LOCAL_KIND_CD == 'foreigner' && custInfo.FORE_BID_YN == 'Y') || (custInfo.LOCAL_KIND_CD != 'foreigner'))" type="button" ng-click="showBidHistoryPopup({'parent':this, 'sale':sale, 'lot':lot});" >
										<spring:message code="label.go.bid.history" /><!-- 온라인응찰기록 ->
									</button>
                                       <button ng-if="!custInfo.CUST_NO" type="button" onClick="location.href='/login'" >
										<spring:message code="label.go.bid.loginlog" /><!-- 온라인응찰기록 ->
									</button>
								</span><!-- 온라인 / 종료 ->
								
								
								<span ng-if="is_login == 'false' && lot.END_YN != 'Y'" class="btn_style01 xlarge green02 btn_bid" onClick="alert('로그인 후 확인할 수 있습니다.\n Please login for use.')">
									<button type="button">
		                                <spring:message code="label.go.bid.now" />
		                            </button>
                                       <%-- <button ng-if="!custInfo.CUST_NO" type="button" onClick="location.href='/login'" >
										<spring:message code="label.go.bid.loginlog" />
									</button> --%>
								</span><!-- 온라인 / 진행중 ->
								
								
								<span ng-if="is_login == 'true' && lot.END_YN != 'Y'" ng-show='custInfo.CUST_NO > 0 && lot.STAT_CD != "reentry"' class="btn_style01 xlarge green02 btn_bid"
									ng-if="['online','online_zb'].indexOf(sale.SALE_KIND_CD) > -1 && lot.END_YN == 'N' && sale.AUTO_BID_REQ_CLOSE_DT <= sale.DB_NOW ">
									<button ng-if="custInfo.BID_FORBID == 'N' && custInfo.CUST_NO && ((custInfo.LOCAL_KIND_CD == 'foreigner' && custInfo.FORE_BID_YN == 'Y') || (custInfo.LOCAL_KIND_CD != 'foreigner'))" type="button" ng-click="showBidPopup({'parent':this, 'sale':sale, 'lot':lot});" >
										<spring:message code="label.go.bid.now" />
									</button>
                                       <%-- <button ng-if="!custInfo.CUST_NO" type="button" onClick="location.href='/login'" >
										<spring:message code="label.go.bid.loginlog" />
									</button> --%>
								</span><!-- 온라인 / 진행중 ->

								
								<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge green02 btn_bid"
									ng-if="['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && is_login && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
									<button ng-if="custInfo.MEMBERSHIP_YN == 'Y'" type="button" ng-click="showBidRequestPopup({'parent':this, 'sale':sale, 'lot':lot});" >
										<spring:message code="label.go.bid.request" />
									</button><!-- 정회원 -->
									<!--  <button ng-if="custInfo.MEMBERSHIP_YN == 'N' && sale_status == 'ING'" type="button" onclick="memberAlert();">
										<spring:message code="label.go.bid.request" />
									</button>--><!-- 준회원 ->
								</span><!-- 온라인 / 국내 ->
								<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge green02 btn_bid"
									ng-if="['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) > -1 && is_login && sale_status == 'ING' && (lot.DB_NOW | date:'yyyyMMdd') < (lot.SALE_TO_DT | date:'yyyyMMdd')">
									<button ng-if="custInfo.FORE_BID_YN == 'Y'" type="button" ng-click="showBidRequestPopup({'parent':this, 'sale':sale, 'lot':lot});" >
										<spring:message code="label.go.bid.request" />
									</button><!-- 정회원. 국외 회원 응찰 여부 체크된 고객 ->
								</span><!-- 온라인 / 국외--> 
								<!--<span ng-show='lot.STAT_CD != "reentry"' class="btn_style01 xlarge white btn_bid" ng-if="['main','hongkong','plan'].indexOf(sale.SALE_KIND_CD) >= 0 && !is_login && sale_status == 'ING'">
									<button type="button" onclick="loginAlert();"><spring:message code="label.go.bid.request" /></button>	
								</span>--><!-- 오프라인 / 로그아웃 -->
								
								<span ng-show='lot.STAT_CD != "reentry"' ng-if="['private','exhibit'].indexOf(sale.SALE_KIND_CD) >= 0 && sale_status == 'ING'" class="btn_style01 xlarge white btn_bid">
									<button type="button" onclick="goInquiryWrite();"><spring:message code="label.go.inquery" /></button>
								</span><!-- 전시 --> 
							</div> <!--hidden_box end--> 
