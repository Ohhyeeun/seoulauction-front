<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<form id="frmTopSearch" action="/search" method="get">
		<input id="topSearchContent" type="hidden" name="searchContent" />
	</form>
	<!-- 모바일용 -->
	<div class="m_search">
		<dl>
			<dt><label for="">검색어</label></dt>
			<dd><div><input type="text" name="" id="searchContentMob" /></div></dd>
		</dl>
		<button type="button" class="sp_btn btn_search" onclick="goSearch('searchContentMob', true);">
			<span class="hidden">검색</span>
		</button>
		<button type="button" class="sp_btn btn_search_close">
			<span class="hidden">닫기</span>
		</button><!-- 20150615 -->
	</div>
	<!-- //모바일용 -->
	<!-- 커튼배너 -->
	<div id="kanggTopLayer" class="curtain_wrapper" style="display:none;"></div>
	<!-- //커튼배너 -->
