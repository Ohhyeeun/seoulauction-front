<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

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
						<h2>SNS Channels</h2>
						<p>Another method to meet SeoulAuction.<br>You can contact recent auction news and useful information faster through a varied social media channel.</p>
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
											<div class="tit"><a href="https://www.facebook.com/seoulauction" target="_blank" title="새창">Seoul Auction Facebook</a></div>
											<div class="txt">SeoulAuction Facebook relays varied art circle news besides SeoulAuction news. <br>SeoulAuction Facebook welcomes your request for friends.</div>
										</div>
									</div>
								</div>
								<!--
								<div>
									<div class="inner">
										<div class="bg_img bg15">
											<div class="tit"><a href="https://twitter.com/seoulauctionkr" target="_blank" title="새창">Seoul Auction Twitter</a></div>
											<div class="txt">SeoulAuction twitter reports SeoulAuction news and news brief of art circles composed of 140 letters. <br>SeoulAuction twitter welcomes your following.</div>
										</div>
									</div>
								</div>
								-->
								<div>
									<div class="inner">
										<div class="bg_img bg35">
											<div class="tit"><a href="https://www.instagram.com/seoulauction/" target="_blank" title="새창">Seoul Auction Instagram</a></div>
											<div class="txt">SeoulAuction instagram welcomes your following.</div>
										</div>
									</div>
								</div>
								<div>
									<div class="inner">
										<div class="bg_img bg16">
											<div class="tit"><a href="http://blog.naver.com/PostList.nhn?blogId=s_auction" target="_blank" title="새창">Seoul Auction blog</a></div>
											<div class="txt">SeoulAuction Blog provides art news easily and comfortably. </div>
										</div>
									</div>
								</div>
								<!--  <div>
									<div class="inner">
										<div class="bg_img bg17">
											<div class="tit"><a href="https://www.youtube.com/user/SeoulAuction" target="_blank" title="새창">Seoul Auction youtube</a></div>
											<div class="txt">SeoulAuction Youtube provides various issues over overall auction such as auction explanation, work description, auction proceeding videos, preview video etc. together with animation.</div>
										</div>
									</div>
								</div> -->
								<div>
									<div class="inner">
										<div class="bg_img bg36">
											<div class="tit"><a href="https://pf.kakao.com/_yxiUyxl" target="_blank" title="새창">Seoul Auction TALK PLUS</a></div>
											<div class="txt">SeoulAuction TALK PLUS.</div>
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
										<!--
										<div class="txt">
											<a href="http://www.facebook.com/seoulauction/posts/475619899271103" target="_blank">
											 조선백자호 최고가 10억 5천만원···서울옥션 136회 경매 낙찰률 85% · 낙찰총액 66억 (CNB저널=왕진오 기자) 16일 오후 서울 평...
											<br>
											조선백자호 최고가 10억 5천만원···서울옥션 136회 경매 낙찰률 85% · 낙찰총액 66억<br> <br> (CNB저널=왕진오 기자) 16일 오후 서울 평창동 서울옥션에서 진행된 제136회 미술품 경매 결과 낙찰률 85%, 낙찰총액 약 66억 원을 기록했다. <br> <br> 이번 경매 결과는 지난 3월에 개최한 '제136회 미술품 경매' 낙찰률 87%에 이어 80%대 이상을 기록하면서 국내 미술시장이 호전되는 분위기를 반영했다. <br> <br> 이날 경매에서 근현대 미술품 가운데 최고가는 2억 7000만 원에 낙찰된 김환기의 '새'가 차지했다. 8호 크기의 세로 화폭에 학의 모습을 단순화해 표현한 작품이다.<br> <br> 고미술품은 낙찰률 87%, 낙찰총액 24억 원을 기록하며 좋은 결과를 보였다. 도자기, 목기, 서예, 작자미상의 작품 등 다양한 품목이 출품되어 희소가치 높은 작품들에 대한 경합이 많았다.<br> <br> 이번 경매 최고가를 기록한 조선시대 '백자호'는 경합 끝에 10억 5000만 원에 서면 응찰자에게 낙찰됐다. 눈에 띄게 큰 사이즈의 이 도자기는 균형 있고 꾸밈없는 형태가 조형적으로 안정감을 주며, 광택이 그윽해 순백자의 격조미를 잘 나타내는 작품으로 평가받고 있다.<br> <br> 이외에도 '고종황제, 순종황제 사진첩'은 6000만 원에, '비변사문무낭관계회도'는 1억 4000만 원에 팔리며 자료적 가치가 높은 고미술품에 대한 인기를 반증했다. <br> <br> ▲ CNB저널, CNBJOURNAL, 씨앤비저널<br>   </a><a href="http://l.facebook.com/l.php?u=http%3A%2F%2Fweekly.cnbnews.com%2Fnews%2Farticle.html%3Fno%3D116201&amp;h=GAQHvWl4K&amp;s=1" rel="nofollow nofollow" target="_blank" onmouseover="LinkshimAsyncLink.swap(this, &quot;http:\/\/weekly.cnbnews.com\/news\/article.html?no=116201&quot;);" onclick="LinkshimAsyncLink.swap(this, &quot;http:\/\/l.facebook.com\/l.php?u=http\u00253A\u00252F\u00252Fweekly.cnbnews.com\u00252Fnews\u00252Farticle.html\u00253Fno\u00253D116201&amp;h=GAQHvWl4K&amp;s=1&quot;);">http://weekly.cnbnews.com/news/article.html?no=116201</a><br><br><a href="/seoulauction/photos/pcb.475619899271103/475619745937785/?type=1&amp;relevant_count=2" id="" title="" target="" onclick="" style=""><img class="img" src="https://scontent.xx.fbcdn.net/hphotos-xaf1/v/t1.0-9/s130x130/10277729_475619745937785_8359380197772435639_n.jpg?oh=1bd4cfb9b44a9a645fda31d9f5e91ec4&amp;oe=56335284" alt=""></a><a href="/seoulauction/photos/pcb.475619899271103/475619742604452/?type=1&amp;relevant_count=1" id="" title="" target="" onclick="" style=""><img class="img" src="https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xft1/v/t1.0-9/s130x130/11428482_475619742604452_1215748701447349329_n.jpg?oh=72a7bf9f50eb70bf3db28876151ecbce&amp;oe=562E5DC5&amp;__gda__=1445899735_c640f351ebe50647e3e5b4de23879039" alt=""></a><br>
										</div>
										-->
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
											<a class="twitter-timeline" href="https://twitter.com/SeoulAuctionKR" data-widget-id="423622593304735744">@SeoulAuctionKR 님의 트윗</a>
											<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
										</div>
									</div>
								</div>
								-->
								<div>
									<div class="inner">
										<div class="sp_icon icon_instagram"><span class="hidden">Instagram</span></div>
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
								<!-- <div>
									<div class="inner">
										<div class="sp_icon icon_youtube"><span class="hidden">유투브</span></div>
										<div class="tit">Seoul Auction Youtube</div>
										<div class="txt">
											<a href="https://www.youtube.com/user/SeoulAuction" target="_blank">
												<img src="/images/eng/temp/temp_youtube.jpg" alt="">
											</a>
										</div>
									</div>
								</div> -->
								<div>
									<div class="inner">
										<div class="sp_icon icon_talk"><span class="hidden">TALK PLUS</span></div>
										<div class="tit">Seoul Auction TALK PLUS</div>
										<div class="txt">
											<a href="https://pf.kakao.com/_yxiUyxl" target="_blank">
												Seoul Auction TALK PLUS
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

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
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />