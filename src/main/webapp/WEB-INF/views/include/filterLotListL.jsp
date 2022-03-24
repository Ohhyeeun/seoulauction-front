<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
						<div class="wrap_search web_only mt0">
							<div class="search_box">
								<div class="row">
									<dl>
										<dt><label for="searchName"><spring:message code="label.artist.name" /></label></dt>
										<dd>
											<input type="text" ng-model="artistName" id="searchName" name="searchName" class="input_author" placeholder='<spring:message code="label.artist.name.search.placeholder" />' />
										</dd>
									</dl>
									<dl>
										<dt><label for="searchTitle"><spring:message code="label.artwork.title" /></label></dt>
										<dd>
											<input type="text" ng-model="worksTitle" id="searchTitle" name="searchTitle" class="input_master" placeholder='<spring:message code="label.artwork.title.search.placeholder" />' />
										</dd>
									</dl>
                                    
                                    <dl class="unit" ng-if="sale.SALE_KIND_CD == 'exhibit'">
										<dt></dt>
										<dd>
										</dd>
									</dl>
									<dl class="unit" ng-if="sale.SALE_KIND_CD != 'exhibit'">
										<dt><label for=""><spring:message code="label.expense.price" /></label></dt>
										<dd>
											<div class="rangeContainer">
												<div id="estimateRange"></div>
												<div id="rangeText"></div>
											</div>

											<select id="estimatePriceCode" name="estimatePriceCode" class="selectbox" onchange="priceCodeChanged(this.value);">
												<option value="K">KRW</option>
												<option value="H">HKD</option>
												<option value="U">USD</option>
											</select>
										</dd>
									</dl>

									<dl>
										<dt><label for="lotNumber"><spring:message code="label.lot.no" /></label></dt>
										<dd>
											<input type="text" ng-model="lot_no" id="lotNumber" name="lotNumber" class="tac input_lot" />
										</dd>
									</dl>
									<div class="btns">
										<span class="btn_style01 gray">
											<button type="button" ng-click="loadLotList(1);"><spring:message code="label.query" /></button>
										</span>
									</div>
								</div><!-- row -->	
								<div class="btn_wrap">
									<span class="btn_style01 gray">
										<button type="button" onclick="currentFormReset();"><spring:message code="label.search.reset" /></button>
									</span>
									<span class="btn_style01 gray02">
										<button type="button" ng-click="loadLotList(1);"><spring:message code="label.search" /></button>
									</span>
								</div>
							</div>
						</div>


