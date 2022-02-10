<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>
</script>

<div id="custom-modal" class="modal" style="top:50px; display: block; padding:0px;">
  <div id="overlay" class="pop_wrap">
	<div class="title">
		<h2><span ng-if="locale=='ko'">컨디션리포트 열람규정</span>
			<span ng-if="locale!='ko'">View Condition Report</span></h2>
	</div>
	<div class="cont">
		<div class="list_style01">
			<ul>
				<span ng-if="locale=='ko'">
					컨디션리포트를 열람하시려면 <a href="/terms/page?view=conditionReportTerms" target="_blank"><strong class="txt_impo">여기</strong></a>를 눌러 규정을 확인해주세요.<br />
					(동의 버튼을 누를 경우 규정을 확인한 것으로 간주됩니다.)
				</span>
				<span ng-if="locale!='ko'">
					To view the condition report Please click <a href="/terms/page?view=conditionReportTerms" target="_blank"><strong class="txt_impo">here</strong></a> to check the regulations.
					<br />(If you click the Agree button, you are considered to have verified the policy.)
				</span>
			</ul>
		</div>
		<form name="frmConditionReport" id="frmConditionReport">
			<fieldset>
				<div class="btn_wrap">
					<span>
						<a ng-href="{{'/conditionPrt?sale_no=${SALE_NO}&lot_no=${LOT_NO}'}}" target="_blank" ng-click="closeThisDialog();" class="btn_style01 mid gray03">
							<button type="button">
							<!--  <a ng-click="crSave({'parent':this, 'sale_no':sale_no, 'lot_no':lot_no});"> -->
								<span ng-if="locale=='ko'">동의</span>
								<span ng-if="locale!='ko'">I Agree.</span>
							
							</button>
						</a>
						<a ng-click="closeThisDialog();" class="btn_style01 mid gray03">
							<button type="button">
								<span ng-if="locale=='ko'">취소</span>
								<span ng-if="locale!='ko'">Cancel</span>
							</button>
						</a>
					</span>
				</div>
			</fieldset>
		</form>
	</div>
  </div>
</div>
