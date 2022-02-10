<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>

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
				<div class="contents" style="min-height:700px; overflow:visible;">	  
					<div class="tit_h2">
						<h2>공지사항</h2> 
					</div>
					<div class="board_read type02">
						<div class="title">21회 홍콩경매 정정사항</div>
						<div class="info" >
							
						</div>
						<div class="cont" style="line-height:28px;">
                        1) Lot. 34 닐 제니<br/>작품 재질 변경 <br/>
						acrylic on canvas with painted wood frame → acrylic on wood<br/><br/>

 						2) Lot. 52 조엘사피로<br/>도록 이미지 위 아래 180도 회전<br/><br/>
 						
 						3) Lot. 57 출품취소<br/>
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
					</div> -->

					<div class="btn_wrap">
						<div class="right">
							<span class="btn_style01 white02 icon btn_list mbtn">
								<span class="ico list"></span>
								<a href="/noticeList">
									<span>목록</span>
								</a>
							</span>
						</div>
					</div>
				</div>
			</div>

			<div class="sub_banner web_only"> 
				<div class="hidden_box web_only">
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
