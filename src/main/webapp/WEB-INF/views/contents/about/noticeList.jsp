<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<script>
	function move_page(page){
		var f = document.pageForm;
		f.page.value = page;
		$(f).submit();
	}
	function submitForm() {
		var f = document.pageForm;
		$(f).submit();
	}
	function goDetailView(nViewId, sShowType) {
		var page = "${pageForm.page}";
		var searchType = "${map.searchType}";
		var searchContent = "${map.searchContent}";
		location.href = "/about/noticeView?noticeId=" + nViewId + "&showType=" + sShowType + "&page=" + page + "&search_type=" + searchType + "&search_content=" + searchContent;
	}
</script>
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
					<jsp:include page="../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">	
				<div class="contents">
					<div class="tit_h2">
						<h2>공지사항</h2>
					</div>
					<div class="tbl_top web_only">
						<div class="left">
							<div class="txt">전체 <span class="txt_green">${map.paging.totalCnt }</span>건</div>
						</div>
						<form:form commandName="pageForm" name="pageForm" method="get">
						<form:hidden path="page"/>
						<div class="right">
							<div class="fl_wrap">
								<select name="search_type" class="selectbox">
								<c:if test="${not empty map.searchType }">
									<c:choose>
										<c:when test="${map.searchType == 'S' }">
											<c:set var="subjectSelected" value="selected" />
										</c:when>
										<c:when test="${map.searchType == 'C' }">
											<c:set var="contentSelected" value="selected" />
										</c:when>
										<c:when test="${map.searchType == 'B' }">
											<c:set var="bothSelected" value="selected" />
										</c:when>
									</c:choose>
								</c:if>
									<option value="S" ${subjectSelected }>제목</option>
									<option value="C" ${contentSelected }>내용</option>
									<option value="B" ${bothSelected }>제목 + 내용</option>
								</select>
								<input type="text" name="search_content" id="searchContent" placeholder="검색어" value="${map.searchContent }" />
								<span class="btn_style01 gray02">
									<button type="button" onclick="submitForm();">검색</button>
								</span>
							</div>
						</div>
						</form:form>
					</div>
					<div class="tbl_style02 type02 m_tbl_z034">
						<table>
							<caption>공지사항</caption>
							<colgroup>
								<col style="width:8%;">
								<col style="width:10%;">
								<col>
								<col style="width:15%;"><!-- 수정 -->
								<col style="width:10%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">분류</th>
									<th scope="col">제목</th>
									<th scope="col">등록일</th>
									<th scope="col">조회</th>
								<tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty map.topNoticeList and empty map.normalNoticeList }">
								<tr>
									<td class="nodata" colspan="5">검색된 공지사항이 없습니다.</td>
								</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="topNotice" items="${map.topNoticeList }" varStatus="status">
								<tr class="notice" onclick="goDetailView('${topNotice.notice_id}', '${topNotice.show_type }');">
									<td>공지</td>
									<td class="sort">${topNotice.notice_type_name }</td>
									<td class="tal">
										<a href="javascript:goDetailView('${topNotice.notice_id}', '${topNotice.show_type }');">${topNotice.subject }</a>
										<c:if test="${topNotice.file_exist_yn == 'Y' }">
										<img src="/images/bg/bul_file02.png" alt="첨부파일" />
										</c:if>
									</td>
									<td>${topNotice.registration_time }</td>
									<td>${topNotice.show_count }</td>
								</tr>
								</c:forEach>
								<c:set var="normalCount" value="${map.totalCount - fn:length(map.topNoticeList) }" />
								<c:forEach var="normalNotice" items="${map.normalNoticeList }" varStatus="status">
								<tr onclick="goDetailView('${normalNotice.notice_id }','${normalNotice.show_type }');">
									<td>${normalCount - (status.index+(pageForm.page-1)*pageForm.pageSize)}</td>
									<td class="sort">${normalNotice.notice_type_name }</td>
									<td class="tal">
										<a href="javascript:goDetailView('${normalNotice.notice_id}','${normalNotice.show_type }');">${normalNotice.subject }</a>
										<c:if test="${normalNotice.file_exist_yn == 'Y' }">
										<img src="/images/bg/bul_file02.png" alt="첨부파일" />
										</c:if>
									</td>
									<td>${normalNotice.registration_time }</td>
									<td>${normalNotice.show_count }</td>
								</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								<!--
								<tr>
									<td>공지</td>
									<td class="sort">채용</td>
									<td class="tal"><a href="">응찰기록을 어디서 볼 수 있나요?</a></td>
									<td>2015-01-20</td>
									<td>888</td>
								</tr>
								-->
								<!--
								<tr>
									<td colspan="5" class="nodata"><span class="tac notice_style01">검색된 공지사항이 없습니다.</span></td>
								</tr>
								-->
							</tbody>
						</table>
					</div>
					<div class="wrap_paging">
						<!-- S : paging 영역 -->
						${map.paging.pagingHtml}
						<!-- E : paging 영역 -->
					</div>
				</div>
			</div>

			<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li><img src="/images/img/img_menu04.jpg" alt="작품1" class="img_master" /></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer.jsp" flush="false" />