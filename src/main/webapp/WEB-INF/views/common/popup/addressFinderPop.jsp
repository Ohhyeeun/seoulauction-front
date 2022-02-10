<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="custom-modal" class="modal" style="top:50px; display: block; padding:0px;">
    <div id="overlay" class="pop_wrap">
	<button type="button" ng-click="closeThisDialog(this);" class="sp_btn btn_pop_close">
		<span class="hidden">닫기</span>
	</button>
	<div class="title">
		<h2>주소 검색</h2>
	</div>
	<div class="cont">
		<div class="tab_wrap type01 wide">
			
<!--  			<div  id="tab_cont02" class="tab_cont"> -->
				<div class="inner">
					<legend>도로명 주소 검색</legend>
					<!-- 도로명+건물번호 -->
					<p class="txt_small02">예) "도로명주소  건물번호" 입력</p>
					<div class="wrap_search address">
						<div class="search_box">
							
							<div class="row m_row">
								<dl>
									<dt>
										<label for="">검색어</label>
									</dt>
									<dd>
										<!-- 도로명+건물번호 -->
										<div class="fl_wrap">
											<div class="input_road">
												<input type="text" ng-model="find_word1" name="find_word1" id="find_word1" placeholder="도로명 입력" autofocus="autofocus" />
												<!--  <span class="tbl_label">+</span>
												<input type="text" ng-model="find_word2" name="find_word2" id="find_word2" placeholder="건물번호 입력" /> -->
											</div>
										</div>
									</dd>
								</dl>
							</div>
						</div>
						<div class="btn_wrap">
							<span class="btn_style01 mid gray02"><button
									type="button" ng-click="findAddrNewForm();">검색</button></span>
						</div>
					</div>
					<div class="tbl_top">
						<div class="left">
							<div class="txt">
								<p>
									검색 결과 중 <span class="txt_green">해당 주소를 선택</span>해주세요.
								</p>
							</div>
						</div>
					</div>
					<div class="scrollable web">
						<div class="scroller">
							<div class="tbl_style02">
								<table id="tbl_result_new">
									<caption>주소 선택</caption>
									<colgroup>
										<col style="width: 18%">
										<col>
									</colgroup>
									<thead>
										<tr>
											<th scope="col">우편번호</th>
											<th scope="col">주소</th>
										</tr>
									</thead>
									<tbody id="tbl_body_new">
										<tr>
											<td colspan="2" class="nodata" ng-show="addrList.length == 0"><p>
													검색된 주소가 없습니다.<br>다시 검색해주세요.
											</p></td>
										</tr>
										<tr ng-repeat="addr in addrListNew" ng-click="returnFunction(addr, this);">
											<td>{{addr.postcd}}</td>
											<td class='tal'><span>{{addr.address}}<br>{{addr.addrjibun}}</span></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="btn_wrap">
						<span class="btn_style01 gray mid btn_pop_close">
							<button	type="reset" ng-click="closeThisDialog();">닫기</button>
						</span>
					</div>
				</div>
<!--  			</div> -->
		</div>
	</div>
  </div>
</div>