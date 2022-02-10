<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
						<div class="wrap_search mt0 auction_wrap_search">
							<div class="search_box">
								<div class="row">   
									<dl class="searchname">
										<dt><label for="searchName"><spring:message code="label.artist.name" /></label></dt>
										<dd>
											<input type="text" ng-model="artistName" id="searchName" name="searchName" ng-keypress="$event.keyCode === 13 && searchList();"class="input_author" placeholder='<spring:message code="label.artist.name.search.placeholder" />' />
										</dd> 
									</dl>
									<dl class="searchtitle">  
										<dt><label for="searchTitle"><spring:message code="label.artwork.title" /></label></dt>
										<dd> 
											<input type="text" ng-model="worksTitle" id="searchTitle" name="searchTitle" ng-keypress="$event.keyCode === 13 && searchList();" class="input_master"  placeholder='<spring:message code="label.artwork.title.search.placeholder" />' />
										</dd>  
									</dl>
                                    
                                    <dl class="unit web_only" ng-if="sale.SALE_KIND_CD == 'exhibit'">
										<dt></dt> 
										<dd>
										</dd>
									</dl> 
									
									<dl class="lotnumber">   
										<dt><label for="lotNumber"><spring:message code="label.lot.no" /></label></dt>
										<dd>
											<input type="text" ng-model="lot_no" id="lotNumber" name="lotNumber" ng-keypress="$event.keyCode === 13 && searchList();" class="tac input_lot"  />
										</dd>
                                        <div class="filterBtn">   
											<span class="btn_style01 gray">
												<button type="button" ng-click="searchList();"><spring:message code="label.query" /></button>
											</span>
										</div>
									</dl>
								</div><!-- row -->
								
								<div class="row filterSearch">      
									<dl class="unit web_only" ng-if="sale.SALE_KIND_CD != 'exhibit'">     
										<dt style="width:auto; margin-right: 15px; margin-top:5px;"><label for=""><spring:message code="label.expense.price" /></label></dt>
										<dd> 
											<div class="rangeContainer">  
												<div id="estimateRange"></div>
												<div id="rangeText"></div> 
											</div> 

											<select id="estimatePriceCode" name="estimatePriceCode" ng-model="s_expe_currency" ng-change="setExpeSlide(s_expe_currency)">
												<option value="KRW">KRW</option>
												<option value="HKD">HKD</option>
												<option value="USD">USD</option>
											</select>
										</dd>
									</dl> 
								</div>	
								
								<div class="btn_wrap">
									<span class="btn_style01 gray">
										<button type="button" ng-click="initSerachFilter();"><spring:message code="label.search.reset" /></button>
									</span>
									<span class="btn_style01 gray02">
										<button type="button" ng-click="searchList();"><spring:message code="label.search" /></button>
									</span>
									<!--
									<span class="btn_style01 gray02 web_only">
										<button type="button">
											<span ng-if="locale == 'ko'" onclick="openNav()">&#9776; 카테고리검색</span>
											<span ng-if="locale != 'ko'" onclick="openNav()">&#9776; Category Search</span>
										</button>
									</span>
									-->
								</div>
							</div>
						</div>
