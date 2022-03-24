<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

						<div class="wrap_search search mt0">
							<div class="search_box">
								<div class="row">
										<dl>
											<dt><label for="">기간</label></dt>
											<dd>
												<div class="fl_wrap">
													<div class="input_period">
														<input id="fromDate" name="fromDate" class="tac" onkeyup="this.value=numberOnly(this.value);" placeholder="ex) 20150101" type="text" value="" maxlength="8">
														<span class="tbl_label">~</span>
														<input id="toDate" name="toDate" class="tac" onkeyup="this.value=numberOnly(this.value);" placeholder="ex) 20150101" type="text" value="" maxlength="8">
														<span class="tbl_label">※ 년월일 숫자만 입력</span>
													</div>
												</div>
											</dd>
										</dl>
										<dl>
											<dt>경매/판매</dt>
											<dd>
												<div class="wrap_check">
													<div>
														<input id="chbSalesTypeAll" name="salesType" onclick="chbSalesTypeClick(this);" type="checkbox" value="all" checked="checked"><input type="hidden" name="_salesType" value="on">
														<label for="chbSalesTypeAll">전체</label>
													</div>
													<div>
														<input id="chbSalesTypeOnline" name="salesType" onclick="chbSalesTypeClick(this);" type="checkbox" value="SALEUA000004" checked="checked"><input type="hidden" name="_salesType" value="on">
														<label for="chbSalesTypeOnline">온라인</label>
													</div>
													<div>
														<input id="chbSalesTypeOffline" name="salesType" onclick="chbSalesTypeClick(this);" type="checkbox" value="SALEUA000001" checked="checked"><input type="hidden" name="_salesType" value="on">
														<label for="chbSalesTypeOffline">오프라인</label>
													</div>
													<div>
														<input id="chbSalesTypeHongkong" name="salesType" onclick="chbSalesTypeClick(this);" type="checkbox" value="SALEUA000003" checked="checked"><input type="hidden" name="_salesType" value="on">
														<label for="chbSalesTypeHongkong">오프라인 홍콩</label>
													</div>
													<div>
														<input id="chbSalesTypeDisplay" name="salesType" onclick="chbSalesTypeClick(this);" type="checkbox" value="SALEUB000001" checked="checked"><input type="hidden" name="_salesType" value="on">
														<label for="chbSalesTypeDisplay">전시판매</label>
													</div>
												</div>
											</dd>
										</dl>
									</div>
								<div class="row">
										<dl>
											<dt>진행여부</dt>
											<dd>
												<div class="wrap_check">
													<div>
														<input id="rbOngoingAll" name="ongoing" type="radio" value="all" checked="checked">
														<label for="rbOngoingAll">전체</label>
													</div>
													<div>
														<input id="rbOngoing" name="ongoing" type="radio" value="ongoing">
														<label for="rbOngoing">진행</label>
													</div>
													<div>
														<input id="rbOngoingFinished" name="ongoing" type="radio" value="finished">
														<label for="rbOngoingFinished">종료</label>
													</div>
												</div>
											</dd>
										</dl>
										<dl>
											<dt><label for="">재료종류</label></dt>
											<dd>
												<div class="fl_wrap type02 choice">
													<div class="fl">
														<select id="workMaterialId1" name="workMaterialId1" class="selectbox material" onchange="changedMaterial(this);" sb="78079723" style="display: none;">
															<option value="">재료1 선택</option>
														
															<option value="1">캔버스</option>
														
															<option value="2">종이</option>
														
															<option value="3">유채</option>
														
															<option value="4">장지</option>
														
															<option value="5">연필</option>
														
															<option value="6">과슈</option>
														
															<option value="7">마대</option>
														
															<option value="8">모래</option>
														
															<option value="9">보드</option>
														
															<option value="10">비단</option>
														
															<option value="11">잉크</option>
														
															<option value="12">나무</option>
														
															<option value="13">알루미늄</option>
														
															<option value="14">철</option>
														
															<option value="15">동</option>
														
															<option value="16">면</option>
														
															<option value="17">재료상세테스트2</option>
														
															<option value="18">한지종이</option>
														
															<option value="19">합성수지</option>
														
														</select><div id="sbHolder_78079723" class="sbHolder"><a id="sbToggle_78079723" href="#" class="sbToggle"></a><a id="sbSelector_78079723" href="#" class="sbSelector">재료1 선택</a><ul id="sbOptions_78079723" class="sbOptions" style="display: none;"><li><a href="#" rel="" class="sbFocus">재료1 선택</a></li><li><a href="#1" rel="1">캔버스</a></li><li><a href="#2" rel="2">종이</a></li><li><a href="#3" rel="3">유채</a></li><li><a href="#4" rel="4">장지</a></li><li><a href="#5" rel="5">연필</a></li><li><a href="#6" rel="6">과슈</a></li><li><a href="#7" rel="7">마대</a></li><li><a href="#8" rel="8">모래</a></li><li><a href="#9" rel="9">보드</a></li><li><a href="#10" rel="10">비단</a></li><li><a href="#11" rel="11">잉크</a></li><li><a href="#12" rel="12">나무</a></li><li><a href="#13" rel="13">알루미늄</a></li><li><a href="#14" rel="14">철</a></li><li><a href="#15" rel="15">동</a></li><li><a href="#16" rel="16">면</a></li><li><a href="#17" rel="17">재료상세테스트2</a></li><li><a href="#18" rel="18">한지종이</a></li><li><a href="#19" rel="19">합성수지</a></li></ul></div>
													</div>
													<div class="fl">
														<select id="workMaterialId2" name="workMaterialId2" class="selectbox material" onchange="changedMaterial(this);" sb="26223629" style="display: none;">
															<option value="">재료2 선택</option>
														
															<option value="1">캔버스</option>
														
															<option value="2">종이</option>
														
															<option value="3">유채</option>
														
															<option value="4">장지</option>
														
															<option value="5">연필</option>
														
															<option value="6">과슈</option>
														
															<option value="7">마대</option>
														
															<option value="8">모래</option>
														
															<option value="9">보드</option>
														
															<option value="10">비단</option>
														
															<option value="11">잉크</option>
														
															<option value="12">나무</option>
														
															<option value="13">알루미늄</option>
														
															<option value="14">철</option>
														
															<option value="15">동</option>
														
															<option value="16">면</option>
														
															<option value="17">재료상세테스트2</option>
														
															<option value="18">한지종이</option>
														
															<option value="19">합성수지</option>
														
														</select><div id="sbHolder_26223629" class="sbHolder"><a id="sbToggle_26223629" href="#" class="sbToggle"></a><a id="sbSelector_26223629" href="#" class="sbSelector">재료2 선택</a><ul id="sbOptions_26223629" class="sbOptions" style="display: none;"><li><a href="#" rel="" class="sbFocus">재료2 선택</a></li><li><a href="#1" rel="1">캔버스</a></li><li><a href="#2" rel="2">종이</a></li><li><a href="#3" rel="3">유채</a></li><li><a href="#4" rel="4">장지</a></li><li><a href="#5" rel="5">연필</a></li><li><a href="#6" rel="6">과슈</a></li><li><a href="#7" rel="7">마대</a></li><li><a href="#8" rel="8">모래</a></li><li><a href="#9" rel="9">보드</a></li><li><a href="#10" rel="10">비단</a></li><li><a href="#11" rel="11">잉크</a></li><li><a href="#12" rel="12">나무</a></li><li><a href="#13" rel="13">알루미늄</a></li><li><a href="#14" rel="14">철</a></li><li><a href="#15" rel="15">동</a></li><li><a href="#16" rel="16">면</a></li><li><a href="#17" rel="17">재료상세테스트2</a></li><li><a href="#18" rel="18">한지종이</a></li><li><a href="#19" rel="19">합성수지</a></li></ul></div>
													</div>
													<div class="fl">
														<select id="workMaterialId3" name="workMaterialId3" class="selectbox material" onchange="changedMaterial(this);" sb="95201318" style="display: none;">
															<option value="">재료3 선택</option>
														
															<option value="1">캔버스</option>
														
															<option value="2">종이</option>
														
															<option value="3">유채</option>
														
															<option value="4">장지</option>
														
															<option value="5">연필</option>
														
															<option value="6">과슈</option>
														
															<option value="7">마대</option>
														
															<option value="8">모래</option>
														
															<option value="9">보드</option>
														
															<option value="10">비단</option>
														
															<option value="11">잉크</option>
														
															<option value="12">나무</option>
														
															<option value="13">알루미늄</option>
														
															<option value="14">철</option>
														
															<option value="15">동</option>
														
															<option value="16">면</option>
														
															<option value="17">재료상세테스트2</option>
														
															<option value="18">한지종이</option>
														
															<option value="19">합성수지</option>
														
														</select><div id="sbHolder_95201318" class="sbHolder"><a id="sbToggle_95201318" href="#" class="sbToggle"></a><a id="sbSelector_95201318" href="#" class="sbSelector">재료3 선택</a><ul id="sbOptions_95201318" class="sbOptions" style="display: none;"><li><a href="#" rel="" class="sbFocus">재료3 선택</a></li><li><a href="#1" rel="1">캔버스</a></li><li><a href="#2" rel="2">종이</a></li><li><a href="#3" rel="3">유채</a></li><li><a href="#4" rel="4">장지</a></li><li><a href="#5" rel="5">연필</a></li><li><a href="#6" rel="6">과슈</a></li><li><a href="#7" rel="7">마대</a></li><li><a href="#8" rel="8">모래</a></li><li><a href="#9" rel="9">보드</a></li><li><a href="#10" rel="10">비단</a></li><li><a href="#11" rel="11">잉크</a></li><li><a href="#12" rel="12">나무</a></li><li><a href="#13" rel="13">알루미늄</a></li><li><a href="#14" rel="14">철</a></li><li><a href="#15" rel="15">동</a></li><li><a href="#16" rel="16">면</a></li><li><a href="#17" rel="17">재료상세테스트2</a></li><li><a href="#18" rel="18">한지종이</a></li><li><a href="#19" rel="19">합성수지</a></li></ul></div>
													</div>
												</div>
											</dd>
										</dl>
									</div>
								<div class="row">
									<dl>
										<dt><label for="">검색어</label></dt>
										<dd>
											<input id="searchContent" name="searchContent" class="input_search" onkeypress="searchContentKeyPress(event);" placeholder="작가명, 작품명 또는 작품재료 입력 예) 박수근, Picasso" type="text" value="">
										</dd>
									</dl>
								</div>		
							</div>
							<div class="btn_wrap">
								<span class="btn_style01 gray">
									<button type="button" onclick="clearSearchCondition();">조건초기화</button>
								</span>
								<span class="btn_style01 gray02">
									<button type="button" onclick="frmSubmit();">검색</button>
								</span>
							</div>
						</div>