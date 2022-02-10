<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<tr id="chbReceiveChk"><%-- push_way --%>
	<th scope="row"><span><spring:message code="label.mem.receive" /></span></th>
	<td>
		<div class="wrap_check" >
			<div ng-repeat="code in codeList | filter:{GRP_ID:'push_way'}:true" >
				<label><input type="checkbox" name="is_check" class="chbReceive" checklist-model="push_ways" checklist-value="code.CD_ID" checked />
					{{"CD_NM" | localeValue : code}}</label>
			</div>
		</div>
	</td>
</tr>
<tr><%-- interest_area --%>
	<th scope="row"><span><spring:message code="label.mem.interesting" /></span></th>
	<td>
		<div class="wrap_check">
			<div ng-repeat="code in codeList | filter:{GRP_ID:'interest_area'}:true" >
				<label><input type="checkbox" class="chbInterest" checklist-model="interest_areas" checklist-value="code.CD_ID" />
					{{"CD_NM" | localeValue : code}}</label>
			</div>
		</div>
	</td>
</tr>
<tr  > <!-- ng-controller="addInteArtistCtl" data-ng-init="bindArtistNameHtml()" -->
	<th scope="row"><label for=""><spring:message code="label.mem.interartist" /></label></th>
	<td>
		<div class="fl_wrap">
			<div class="Favorite_ArtistBox">
				<div id="inteArtistNames" class="Favorite_ArtistContent">
				</div>

				<input type="hidden" name="interestArtist" id="interestArtistReal" />
				<span class="btn_style01 gray02">
					<button type="button" ng-click="showArtistFinderPopup({'parent':this, 'return_function':addInterestArtist});"><spring:message code="label.mem.searchart" /></button>
				</span>
			</div>
		</div>
	</td>
</tr>

