<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="en-US">
<head>
<tiles:insertDefinition name="head" />
</head>
<body>
<tiles:insertDefinition name="mobileSearch" />
<div id="wrap">
	<tiles:insertDefinition name="header" />
	<div class="container_wrap">
		
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
				<tiles:insertDefinition name="serviceSubMenu" />
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2" style="padding-top:30px;">
						<h2>아카데미 - 가나문화포럼</h2>						
					</div>

					<div class="cont_culture">
						<img src="/images/img/img_culture01.jpg" alt="문화예찬 이미지" />
					</div>

				</div>
			</div>

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/img/img_menu03.jpg" alt="" class="img_master">
						</li>
					</ul>
				</div>
			</div>-->
		</div>
	</div>
</div>
<script type="text/javascript">
	funcContHeight();
</script>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />