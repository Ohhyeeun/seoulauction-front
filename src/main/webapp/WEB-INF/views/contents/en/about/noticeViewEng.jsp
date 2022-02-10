<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">

		<div id="container">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
					<jsp:include page="../../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2>NOTICE</h2>
						  
					</div>

					<div class="board_read type02">
						<div class="title">Corrections for 21st Hong Kong Sale</div>
						<!--<div class="info">
							<dl>
								<dt>첨부파일</dt>
								<dd class="bar_space02">
									<a href="/fileDownload?fileName={{file.FILE_NAME}}&path={{file.FILE_PATH}}/&orgName={{file.FILE_NAME_ORG}}">{{file.FILE_NAME_ORG}}</a>
								</dd> 
							</dl>
						</div>-->
						<div class="cont" style="line-height:28px;">
                        1) Lot 34. Neil Jenney<br/>
                        The medium of work should be changed to 'acrylic on wood'.<br/><br/>
                        
                        2) Lot 52. Joel Shapiro<br/>
						The catalogue image should be rotated 180 degrees.<br/><br/>
						
						3) Lot 57. Canceled entry<br/>                
						</div> 
					</div>
					<!-- <div class="board_move">
						<dl>
							<dt><span>이전</span></dt>
							<dd>
								<a href="/about/noticeView?noticeId=${map.notice.prev_notice_id}&showType=${map.notice.show_type }&page=${map.page}&search_type=${map.searchType}&search_content=${map.searchContent}">
								${map.notice.prev_notice_subject }
								</a>
							</dd>
						</dl>
						<dl>
							<dt><span class="next">다음</span></dt>
							<dd>
								<a href="/about/noticeView?noticeId=${map.notice.next_notice_id}&showType=${map.notice.show_type }&page=${map.page}&search_type=${map.searchType}&search_content=${map.searchContent}">
								${map.notice.next_notice_subject }
								</a>
							</dd>
						</dl>
					</div> 

					<div class="btn_wrap">
						<div class="right">
							<span class="btn_style01 white02 icon btn_list mbtn">
								<span class="ico list"></span>
								<a href="/noticeList">
									<span>목록</span>
								</a>
							</span>
						</div>
					</div>-->
				</div>
			</div>

		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer.jsp" flush="false" />