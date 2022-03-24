<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<script>
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.3&appId=843837505708808";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
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
						<h2>SNS채널</h2>
						<p>서울옥션을 만나는 또 하나의 방법.<br>다양한 소셜 미디어 채널을 통해 최신 경매 소식과 유용한 정보를 보다 빠르게 접하실 수 있습니다.</p>
					</div>

					<div class="sns_cont">
						<div class="">
							<div class="tit_h3 through">
								<h3>Seoul Auction SNS</h3>
							</div>
							<div class="both_cont quad">
								<div>
									<div class="inner">
										<div class="bg_img bg14">
											<div class="tit">
												<a href="https://www.facebook.com/seoulauction" target="_blank" title="새창">Seoul Auction Facebook</a>
											</div>
											<div class="txt">SeoulAuction facebook에서는 서울옥션 소식이외에도 다양한 미술계의 소식을 전하고 있습니다.<br>SeoulAuction facebook은 여러분의 친구요청을 환영합니다. </div>
										</div>
									</div>
								</div>
								<div>
									<div class="inner">
										<div class="bg_img bg35">
											<div class="tit">
												<a href="https://www.instagram.com/seoulauction/" target="_blank" title="새창">Seoul Auction Instagram</a>
											</div>
											<div class="txt">SeoulAuction Instagram은 서울옥션 소식과 미술계 소식을 전하며 많은 분들과 소통하고 있습니다. SeoulAuction Instagram은 여러분의 팔로잉을 환영합니다.</div>
										</div>
									</div>
								</div>
								<div>
									<div class="inner">
										<div class="bg_img bg16">
											<div class="tit">
												<a href="http://blog.naver.com/PostList.nhn?blogId=s_auction" target="_blank" title="새창">Seoul Auction blog</a>
											</div>
											<div class="txt">서울옥션 blog는 쉽고 편하게 미술소식을 제공합니다.</div>
										</div>
									</div>
								</div>
								<!-- <div>
									<div class="inner">
										<div class="bg_img bg17">
											<div class="tit">
												<a href="https://www.youtube.com/user/SeoulAuction" target="_blank" title="새창">Seoul Auction youtube</a>
											</div>
											<div class="txt">서울옥션은 youtube를 통해 경매설명, 작품설명, 경매진행영상, 프리뷰 영상 등 경매 전반에 걸친 다양한 이슈들을 동영상과 함께 제공합니다.</div>
										</div>
									</div>
								</div>  -->
								<div>
									<div class="inner">
										<div class="bg_img bg36">
											<div class="tit">
												<a href="https://pf.kakao.com/_yxiUyxl" target="_blank" title="새창">Seoul Auction TALK 플러스친구</a>
											</div>
											<div class="txt">미래가치를 보는 눈! 한국 최초 미술품 경매회사, 서울옥션</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="box_style07">
							<h3>Seoul Auction <strong>Now</strong></h3>
							<div class="both_cont quad">
								<div>
									<div class="inner">
										<div class="sp_icon icon_facebook"><span class="hidden">페이스북</span></div>
										<div class="tit">Seoul Auction Facebook</div>
										<div class="fb-page" data-href="https://www.facebook.com/seoulauction?fref=ts" data-width="178" data-small-header="true" data-adapt-container-width="false" data-hide-cover="true" data-show-facepile="false" data-show-posts="true">
											<div class="fb-xfbml-parse-ignore">
												<blockquote cite="https://www.facebook.com/seoulauction?fref=ts">
													<a href="https://www.facebook.com/seoulauction?fref=ts">서울옥션 Seoul Auction</a>
												</blockquote>
											</div>
										</div>
										<!--
										<div class="info">
											<span class="name">@SeoulAuctionKR</span>
											<span class="time">1시간전</span>
										</div>
										-->
										<%-- <div class="txt">
											<a href="${facebookMap.link }" target="_blank">
												${facebookMap.title }
												<br />
												${facebookMap.content }
											</a>
										</div> --%>
									</div>
								</div>
								<!--
								<div>
									<div class="inner">
										<div class="sp_icon icon_twitter"><span class="hidden">트위터</span></div>
										<div class="tit">Seoul Auction Twitter</div>
										<div class="info">
											<span class="name">@SeoulAuctionKR</span>
											<span class="time">1시간전</span>
										</div>
										<div class="txt" style="overflow:hidden;">
											<a class="twitter-timeline" href="https://www.instagram.com/seoulauction/" data-widget-id="423622593304735744">@seoulauctionpr</a>
											<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
										</div>
									</div>
								</div>
								-->
								<div>
									<div class="inner">
										<div class="sp_icon icon_instagram"><span class="hidden">인스타그램</span></div>
										<div class="tit">Seoul Auction Instagram</div>
										<div id="instafeed"></div>
										<div class="txt" style="overflow:hidden;">
											<a class="instagram-timeline" href="https://www.instagram.com/seoulauction/" data-widget-id="423622593304735744">@seoulauctionpr</a>
											<script type="text/javascript" src="../js/instafeed.min.js"></script>
											<script>
												var userFeed = new Instafeed({
													get: 'user',
													userId: '1961306988',
													sortBy: "most-recent",
													limit: 1,
													template: '<a class="animation" href="https://www.instagram.com/seoulauction/" target="_blank"><img src="{{image}}"/></a>',
													accessToken: '1961306988.c4fd7d7.4ab56762e96749729b85823ec50bc9da'
												});
												userFeed.run()
											</script>
										</div>
									</div>
								</div>
								<div>
									<div class="inner">
										<div class="sp_icon icon_blog"><span class="hidden">블로그</span></div>
										<div class="tit">Seoul Auction blog</div>
										<div class="txt">
											<!--
											<a href="">단색화 인기 열풍, 서울옥션 홍콩경매 100억 어치 그림 판매 제프 쿤스의 '꽃의 언덕' 최고가 21… http://fb.me/3qgID9unP</a>
											-->
											<a href="${blogMap.link }" target="_blank">
												${blogMap.title }
												<br />
												${blogMap.content }
											</a>
										</div>
									</div>
								</div>
								<!--  <div>
									<div class="inner">
										<div class="sp_icon icon_youtube"><span class="hidden">유투브</span></div>
										<div class="tit">Seoul Auction Youtube</div>
										<div class="txt">
											<a href="https://www.youtube.com/user/SeoulAuction" target="_blank">
												<img src="/images/temp/temp_youtube.jpg" alt="" />
											</a>
										</div>
									</div>
								</div> -->
								<div>
									<div class="inner">
										<div class="sp_icon icon_talk"><span class="hidden">TALK 플러스친구</span></div>
										<div class="tit">Seoul Auction TALK 플러스친구</div>
										<div class="txt">
											<a href="https://pf.kakao.com/_yxiUyxl" target="_blank">
												Seoul Auction TALK
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>

			<!--<div class="sub_banner">
				<div class="hidden_box">
					<ul>
						<li>
							<img src="/images/img/img_menu04.jpg" alt="" class="img_master">
						</li>
					</ul>
				</div>
			</div>-->
		</div>
	</div>
</div>
<!-- 20150623 -->
<script type="text/javascript">
	maxH();
	$(window).resize(function(){
		$('.both_cont.tri > div .inner').css('height', 'auto');
		 maxH();
	});
	function maxH(){
		if($(window).width() > 1024){
			$('.both_cont > div .inner').each(function(){
				var maxHeight = Math.max($(this).parent().parent().height());
				$(this).css('height', maxHeight);
			});
		} else {
			$('.both_cont > div .inner').css('height','auto');
		}
	}
</script>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />