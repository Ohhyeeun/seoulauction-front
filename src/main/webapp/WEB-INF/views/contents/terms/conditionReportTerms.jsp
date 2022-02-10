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
			<div class="sub_menu_wrap menu02">
				<div class="sub_menu">
					<jsp:include page="../include/termsSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents" style="height: auto;">
					<div class="tit_h2 border">
						<h2>컨디션리포트열람규정</h2>

					</div>
					
					<div class="law_cont type02">
						<h4 style="color: rgb(0, 0, 0);"></h4>
						<p>
							귀하가 보고있는 랏 설명 페이지의 내용은 변경될 수 있으므로 랏을 확실하게 신뢰해서는 안됩니다.<br />
							입찰을 고려하고 있다면 경매 전 직접 또는 대리인을 통해 물품을 검사해야합니다.<br />
							경매와 관련된 모든 조건과 입찰 방법에 대한 정보는 제공되는 경매 카탈로그에 명시되어 있습니다. 제시된 경매 카탈로그는 여기 제시된 모든 것을 대체합니다.<br /> 
							판매에 앞서 카탈로그를 확인하여 판매에 적용되는 조항을 읽어보는 것은 귀하의 책임입니다.<br />
							또한, 우리는 귀하의 해당 카탈로그에 인쇄된 판매조건 또는 비즈니스조건의 첫 번째 단락에, 카탈로그의 내용(랏 설명 및 판매조건을 포함하되 이에 국한되지 않음) 조건은 실제 판매 장소에 공지사항을 게시하거나 판매 중 구두로 발표함으로써 수정될 수 있습니다. 
							그러한 게시 또는 구두 공지는 웹 사이트에 기시된 온라인 설명보다 우선하며, 귀하에게 전달되었는지 여부를 제어합니다. 이러한 게시 또는 구두 공지 사항에 대한 정보를 얻으려면 그러한 조치를 취하는 것이 귀하의 책임입니다.<br />
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
<jsp:include page="../../include/footer.jsp" flush="false" />