<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="footer_wrap clearfix"> 
	<div id="footer">  
		<div class="util_menu address">
			<div class="fl_menu">
				<ul>
					<spring:message code="text.footer.info" />
				</ul>
			</div>
		</div>  
		<div class="util_menu menu">  
			<ul class="fl_menu">
				<li><a href="/about/page?view=location"><spring:message code="label.seoulauction.location" /></a></li>
				<li><a href="/terms/page?view=auctionTerms"><spring:message code="label.terms.auction" /></a></li>
				<li><a href="/terms/page?view=privateInfo" class="footerHb"><spring:message code="label.terms.privacy.policy" /></a></li> 
                <li><a href="/terms/page?view=cookiePolicy">Cookie Policy</a></li>
				<li><a href="/terms/page?view=infoManage"><spring:message code="label.terms.infor.rules" /></a></li>
               <!--<li><a target="_blank" href="http://www.auctionblue.com ">Auction Blue</a></li>
				<li><a target="_blank" href="http://www.printbakery.co.kr"><spring:message code="label.printbakery" /></a></li>-->
				<li><a href="/service/page?view=sitemap"><spring:message code="label.sitemap" /></a></li>
			</ul>
			<div class="sns_menu"> 
				<ul class="fl_menu">
					<%-- <li><a href="https://twitter.com/seoulauctionkr" target="_balnk" class="sp_btn sns01"><span class="hidden"><spring:message code="label.sns.twitter" /></span></a></li> --%>
					<li><a href="https://www.facebook.com/seoulauction" target="_balnk" class="sp_btn sns02"><span class="hidden"><spring:message code="label.sns.facebook" /></span></a></li>
					<li><a href="http://blog.naver.com/PostList.nhn?blogId=s_auction" target="_balnk" class="sp_btn sns03"><span class="hidden"><spring:message code="label.sns.blog" /></span></a></li>
                    <li><a href="https://www.instagram.com/seoulauction/" target="_balnk" class="sp_btn sns04"><span class="hidden"><spring:message code="label.sns.blog" /></span></a></li>   
                    <li class="last"><a href="https://pf.kakao.com/_yxiUyxl" target="_balnk" class="sp_btn sns05"><span class="hidden"><spring:message code="label.sns.blog" /></span></a></li>            
				</ul>    
			</div> 
		</div>   
		<div class="footer_info web_only">      
			<p> 
				㈜서울옥션이 매도인인 경우를 제외한 모든 온라인 경매 출품 물품들에 대하여 ㈜서울옥션은 통신판매중개자이며 거래 당사자가 아닙니다.<br>  
				따라서 경매 물품에 대한 매매계약은 위탁자와 낙찰자 사이에 성립하며, ㈜서울옥션은 온라인 경매 약관이 정하는 범위 내에서만 책임을 부담합니다.<br />
                서울옥션 웹사이트의 콘텐츠(이미지/문자/영상/화면 등)에 대한 무단 복제, 배포, 전송, 게시, 크롤링/스크래핑 등 행위는 저작권법, 부정경쟁방지 및 영업비밀보호에 관한 법률 등 관련 법령에 의하여 금지됩니다.  
			</p> 
		</div>   
		<div class="inquiry tooltip web_only" style="padding: 30px; margin: 0 10px;">          
			<a ng-if="locale == 'ko'" href="/customer/inquiryForm" class="fix" style="color:#CCC; padding:20px 40px 20px 40px; border:solid 5px #666; font-size:18px; font-wieght:800;">1대1 위탁문의</a>
            <a ng-if="locale != 'ko'" href="/customer/inquiryForm" class="fix" style="color:#CCC; padding:20px 40px 20px 40px; border:solid 5px #666; font-size:18px; font-wieght:800;">1:1 Inquiry</a>
        </div>  
	</div>
</div>
<!-- //footer_wrap -->
<script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script> <script type="text/javascript"> if(!wcs_add) var wcs_add = {}; wcs_add["wa"] = "19656f7bcf4c5c"; wcs_do(); </script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-F337VLGGXB"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-F337VLGGXB');
</script>
</body>
</html>
