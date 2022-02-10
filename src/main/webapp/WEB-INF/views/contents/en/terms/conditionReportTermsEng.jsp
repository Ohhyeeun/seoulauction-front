<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container">
			<div class="sub_menu_wrap menu02">
				<div class="sub_menu">
					<jsp:include page="../../include/termsSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents" style="height: auto;">
					<div class="tit_h2 border">
						<h2>Condition report reading regulation</h2>

					</div>
					
					<div class="law_cont type02">
						<h4 style="color: rgb(0, 0, 0);"></h4>
						<p>
							The contents of the Lot Description page you are viewing may change, so you should not reliably trust Lot.<br />
							If you are considering a bid, you must inspect the goods either directly before the auction or through your agent.<br />
							All the conditions related to the auction and information on how to bid are listed in the auction catalog provided. The proposed auction catalog replaces everything presented here.<br /> 
							It is your responsibility to check the catalog prior to sale and read the terms applicable to the sale.<br />
							In addition, we will notify you in the first paragraph of the Terms of Sale or Business Conditions printed on your appropriate catalog that the content of the catalog (including but not limited to the description and terms of sale) 
							It may be modified by oral presentation during sale.
							Such publication or oral notice supersedes any online description set forth on the Website and controls whether it has been forwarded to you. It is your responsibility to take such steps to obtain information about such publications or oral notices.<br />
						</p>
						<p><br /></p>
						
					</div>
					
				</div>	
			</div>

			<div class="sub_banner" style="position: static;">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/img/img_sitemap.jpg" alt="" class="img_master">
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	maxH();
	$(window).resize(function(){
		$('.both_cont.tri > div .inner').css('height', 'auto');
		maxH();
	});		
	function maxH(){
		if($(window).width() > 767){	
			$('.both_cont.tri > div .inner').each(function(){
				var maxHeight = Math.max($(this).parent().parent().height());
				$(this).css('height', maxHeight + 'px');
			});
		} else {
			$('.both_cont.tri > div .inner').css('height','auto');
		}
	}
</script>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />