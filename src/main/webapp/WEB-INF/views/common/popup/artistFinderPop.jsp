<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="custom-modal" class="modal" style="top:50px; display: block; padding:0px;">
  <div id="overlay" class="pop_wrap">
    <style>
		.loading_container {
			display: none;
		}
		.loading_container > img {
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
			margin: auto;
		}
	</style>
	<button type="button" ng-click="closeThisDialog();" class="sp_btn btn_pop_close">
		<span class="hidden">닫기</span></button>
	<div class="title">
		<h2>작가검색</h2>
	</div>
	<div class="cont">
		<div class="lh20">
			<p class="txt_dark">찾고자 하는 작가 이름의 국문명 또는 영문명을 입력하신 후 검색을 누르세요. </p>
			<p class="txt_pale">예) 이우환, Picasso</p>
		</div>
		<legend>작가명</legend>
		<div class="wrap_search m_type02">
			<div class="search_box">
				<div class="form">
					<label for="">작가명</label>
					<input type="text" ng-model="find_word" name="" id="artistName" placeholder="작가명을 입력하세요." do-enter="findArtist();" autofocus="autofocus" />
					<span class="btn_style01 gray02"><button type="button" ng-click="findArtist();">검색</button></span>
				</div>
			</div>
		</div>
		<div class="tbl_top">
			<div class="left">
				<div class="txt">검색 결과 중 <span class="txt_green">해당 작가를 선택</span>해주세요.</div>
			</div>
		</div>
		<div class="scrollable web">
			<div class="loading_container">
				<img alt="loading" src="/images/loading.gif">
			</div>
			<div class="scroller">
				<div class="tbl_style02 m_tbl_z044">
					<table>
						<caption>작가검색 목록</caption>
						<colgroup>
							<col style="width:10%;">
							<col style="width:22%;">
							<col style="width:22%;">
							<col style="width:22%;">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th scope="col">선택</th>
								<th scope="col">작가명</th>
								<th scope="col">작가영문명</th>
								<th scope="col">작가중문명</th>
								<th scope="col">출생/사망년도</th>
							</tr>
						</thead>
						<tbody id="tblResultBody">
							<tr>
								<td colspan="5" class="nodata" ng-show="artistList.length == 0">
									<div class="tac"><span class="notice_style01">검색된 작가가 없습니다.<br>다시 검색해주세요.</span></div>
								</td>
							</tr>
							<tr ng-repeat="artist in artistList">
								<td><input type="checkbox" checklist-model="checked_artists" checklist-value="artist"/></td>
								<td>{{artist.ARTIST_NAME_JSON.ko}}</td>
								<td>{{artist.ARTIST_NAME_JSON.en}}</td>
								<td><span class="txt_cn">{{artist.ARTIST_NAME_JSON.zh}}</span></td>
								<td>{{artist.BORN_YEAR}} ~ {{artist.DIE_YEAR}}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="btn_wrap">
			<span class="btn_style01 gray mid"><button type="button" ng-click="closeThisDialog();">취소</button></span>
			<span class="btn_style01 green mid"><button type="button" ng-click="returnFunction(checked_artists, this);">저장</button></span>
		</div>
	</div>
  </div>
</div>
