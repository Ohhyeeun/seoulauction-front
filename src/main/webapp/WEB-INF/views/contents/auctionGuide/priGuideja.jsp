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
					<jsp:include page="../include/howtosellSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">
						<h2 style="font:sans-serif">无与伦比的佳作 推荐给有识之士</h2>
					</div>
					

					<div class="storage_cont title_area">
						<div class="line"></div>
						<p style="line-height:30px; font-size:16px;">2018年正值首尔拍卖成立二十周年, 香港拍卖会十周年之际, 特别推出私人洽购展,诚邀有识之士前来欣赏作品。展览将呈现金焕基、李禹焕等韩国艺术家以及塞西莉·布朗、路易斯·布尔乔亚、张大千等中外艺术家的作品，同时还有《清乾隆紫檀透雕巴洛克风格宝座》《康熙帝临天马赋等精品》。
<br/>首尔拍卖成立于1998年，是韩国首家艺术品拍卖行，在首尔、釜山及香港设有办事处，举行各类特别展览与拍卖会，致力于为大众艺术爱好者提供优质、专业、便捷的交易平台。
</p>
                       
                        
						
						<div class="box_gray type01">
							<div class="contact">
								<div class="title">Contact</div>
								<div class="info">
									<div class="highlight"><strong>박지영 朴志英/PARK JI YOUNG</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>+82 10-2329-0131</span></div>
                                    <div class="tel"><strong class="tit">Wechat ID</strong> <span>shengridangao12</span></div>
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:rinda@seoulauction.com">pjy@seoulauction.com</a></div>
								</div>
							</div>
						</div>
					</div>
                    <div style="overflow:hidden;">
                      <div style="width:35%; display:inline-block; float:left;"><img src="/images/img/priv-jang.jpg" alt="PRIVATE"  style="width:100%; height:auto;"/></div>
                      <div style="width:52%; display:inline-block; float:left; padding-left:25px;"><p style="line-height:34px; font-size:18px;"><span style="font-weight:700;">AUCTION</span><br/>
11. 25 Sun 4:30pm Hong Kong Grand Hyatt, Mezzanine Level, Salon<br/><br/>

<span style="font-weight:700;">PREVIEW</span><br/>
HONG KONG 11. 22 Thu - 25 Sun 10am-7pm  SA+ & HART Hall (H Queen's)<br/>
HONG KONG 11. 23 Fri - 25 Sun 10am-9pm  Hong Kong Grand Hyatt, Mezzanine Level, Salon<br/>

</p></div>
</div>
					
				</div>
			</div>


		</div>
	</div>
	<!-- 20150521 -->
	<script>
		$(function() {
			$('#slides').slidesjs({
				height : 400,//??
				navigation : false,
				start : 1,
				play : {
					auto : true
				}
			});
		});
		maxH();
		$(window).resize(function(){
			$('.both_cont > div .inner').css('height', 'auto');
			maxH();
		});		
		function maxH(){
			if($(window).width() > 767){	
				$('.both_cont > div .inner').each(function(){
					var maxHeight = Math.max($(this).parent().parent().height());
					$(this).css('height', maxHeight + 'px');
				});
			} else {
				$('.both_cont > div .inner').css('height','auto');
			}
		}
	</script>
	<!-- //20150521 -->
</div>
<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />