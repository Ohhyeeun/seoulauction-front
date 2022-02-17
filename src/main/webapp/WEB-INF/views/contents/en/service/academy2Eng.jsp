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
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
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
					<div class="tit_h2">
						<h2>아카데미 - 가나문화포럼</h2>						
					</div>

					<div class="cont_culture">
						<img src="/images/eng/img/img_culture01.jpg" alt="문화예찬 이미지" />
					</div>

				</div>
			</div>

			<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/eng/img/img_menu03.jpg" alt="" class="img_master">
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	funcContHeight();
</script>
<!-- //#wrap -->
<tiles:insertDefinition name="footer" />
</body>
</html>