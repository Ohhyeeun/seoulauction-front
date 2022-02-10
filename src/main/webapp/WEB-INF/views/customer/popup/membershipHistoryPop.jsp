<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="custom-modal" class="modal modal02" style="top: 50px; display: block;" data-ng-init="init();">
<div id="overlay" class="pop_wrap">
		<button type="button" ng-click="closeThisDialog(this);" class="sp_btn btn_pop_close"><span class="hidden">닫기</span></button>
		<div class="title">
			<h2>정회원 결제 이력보기</h2>
		</div>
		<div class="cont">
			<div class="cont_title">
				<p class="txt_dot">정회원 결제 이력을 확인합니다.</p>
			</div>
			<div class="tbl_style02">
				<table>
					<caption>정회원 결제 이력</caption>
					<colgroup>
						<col style="width:40%;">
						<col style="width:15%;">
						<col style="width:30%;">
						<col style="width:15%;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">정회원 기간</th>
							<th scope="col">상태</th>
							<th scope="col">결제일</th>
							<th scope="col">결제방법</th>
						</tr>
					</thead>
					<tbody id="tblPaymentHistory">
						<tr ng-repeat="pay in custPayList">
							<td class="noselect">{{pay.VALID_FROM_DT | date:'yyyy-MM-dd'}} ~ {{pay.VALID_TO_DT | date:'yyyy-MM-dd'}} </td>
							<td class="noselect">{{pay.VALID}}</td>
							<td class="noselect">{{pay.PAY_DT | dateFormat}}</td>
							<td class="noselect">{{pay.PAY_METHOD_NM}}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btn_wrap">
				<span class="btn_style01 gray mid"><button type="button" ng-click="closeThisDialog(this);">닫기</button></span>
			</div>
		</div>
	</div></div>