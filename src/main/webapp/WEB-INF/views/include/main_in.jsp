<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link href="<c:url value="/css/old/onepcssgrid_new.css" />" rel="stylesheet">

<!-- 아이패드 버전 슬라이드 플러그인 -->
<link href="/css/jquery.bxslider.min.css" rel="stylesheet">
<link href="/css/main_bxslider.css" rel="stylesheet">
<script type="text/javascript" src="/js/jquery.bxslider.js"></script>

<script type="text/javascript">
app.controller("mainInfoCtl", function($scope, consts, common, locale, is_login) {
	$scope.locale = locale;
	$scope.is_login = is_login;

	/* 고객 정보 가져오기 */
  	$scope.mainInfo = function(){

  		/* 로그인 안한경우 실행 X */
  		if(is_login == "false"){return;}

  	   	$d = {"actionList":[
  	   	{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]}
  	   	     ]};
  	   	var $s = function(data, status) {

  	   		$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
  	   		if( $scope.custInfo.PASSWD_RESET_YN == 'Y'  ){
  	   			$("#pwResetLay").show();
  	   		} else {
  	   			$("#pwResetLay").hide();
  	   		}
  	   	};
  	   	common.callActionSet($d, $s);
	}


  	/* 비밀번호 초기화한 경우 패스워드 변경 */
  	$scope.pwdChange = function(){

  		var NewPw = $("#NewPw").val();
  		var NewPwConform = $("#NewPwConform").val();

  		if( NewPw != NewPwConform) {
  			alert("비밀번호 확인이 다릅니다.");
  			return;
  		}

  		$scope.passwd = NewPwConform;
  		var $d = {"baseParms":{"passwd":$scope.passwd},
				"actionList":[
				{"actionID":"modify_cust_pwd_reset", "actionType":"update", "tableName":"CUST_PWD_RESET", "parmsList":[{}]}
				]};
		common.callActionSet($d, function(data, status) {
			if(data.tables["CUST_PWD_RESET"]["rows"].length > 0) {
				if($scope.locale == 'ko') {
					document.getElementById('logoutForm').submit();
					alert("비밀번호가 변경되었습니다.");
				}else {
					document.getElementById('logoutForm').submit();
					alert("Password has been changed");
				}
				return true;
			}
		})

  	};
});
</script>

<style>
#overlay {
    position: fixed;
    display: none;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    /* background-color: rgba(255,255,255,0.8); */
    z-index: 999;
    cursor: pointer;
}

#text{
    position: absolute;
    top: 50%;
    left: 50%;
    font-size: 45px;
    color: #33333;
	background: #ffffff;
    transform: translate(-50%,-50%);
    -ms-transform: translate(-50%,-50%);
	-webkit-transform: translate(-50%,-50%);
}
#closebtn{
    position: absolute;
    top: 0px;
    right: 10px;
    font-size: 35px;
    color: #333333;
}
#textbg{
    position: absolute;
    /* top: 50%;
    left: 50%; */
	bottom: 0;
	right: 0;
    font-size: 43px;
    color: #333333;
    padding:20px;
    padding-bottom: 10px;
	background: #ffffff;
    /* transform: translate(-50%,-50%);
    -ms-transform: translate(-50%,-50%);  */
}
.layerbox_wrap {
	overflow: hidden;
	color: #fff;
}
.layerbox {
	font-size: 14px;
	line-height: 1.5;
}
.layer_tit {
	font-size: 20px;
	font-weight: bold;
	display:block;
	padding: 20px 0;
}
.layer_img img {
/* 	max-width: 500px; */
	max-height: 130px;
	margin: 0 auto;
	text-align: center;
}
@media screen and (max-width: 768px) {
#overlay {
    position: fixed;
    display: none;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    /* background-color: rgba(255,255,255,0.8); */
    z-index: 999;
    cursor: pointer;
}
#text{
    font-size: 25px;
}
#textbg {
	/* width: 100%;
	max-width: 300px; */
	padding: 10px;
}
#closebtn {
	font-size: 30px;
	font-weight: bold;
}
.layer_tit {
	font-size: 14px;
}
.layerbox {
	font-size: 12px;
}
.layer_img img {
	max-width: 100%;
	/* max-height: 550px; */
	max-height: 100px;
}
}


</style>
<style>
.alert {
    padding: 20px;
    background-color: #f44336;
    color: white;
    font-size: 14px;
}

.closebtn {
    margin-left: 20px;
    color: white;
    font-weight: bold;
    float: right;
    font-size: 40px;
    line-height: 15px;
    cursor: pointer;
    transition: 0.3s;
	margin-top: 10px;
}

.closebtn:hover {
    color: black;
}

/* YDH 추가. 2019.06.21 */
.video-popup.reveal {
  display: flex;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  justify-content: center;
  align-items: center;
  z-index:9
}

.video-popup .video-wrapper iframe,
.video-popup .video-wrapper object,
.video-popup .video-wrapper embed {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
}

.video-popup.reveal .video-popup-closer {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, .5);
  z-index: 9
}
</style>

<div class="mainContents_wrap" ng-controller="mainInfoCtl" data-ng-init="mainInfo()">
	<div class="onepcssgrid-1200">
        <!-- // 상단 이미지 배너 1개 (웹,모바일 둘 다) -->
        <div class="col12 last" style="padding-top:10px; overflow:hidden">
             <a href="https://blog.naver.com/s_auction/221510924761" target="_blank">
                <img src="/images/img/main/ad/main_banner.jpg" alt="banner" alt="banner" style="width:100%;"/>
             </a>
        </div>

      	<!-- 상단 슬라이드 배너 (웹,모바일)-->
      	<%-- <div class="col12 last">
        	<div class="web_only">
                <div class="sub_banner02" id="top_slide_banner" style="margin-top:50px;">
                    <a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
                    <a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
                    <div><a href="https://www.royalsaluteart.kr" target="new"><img src="/images/img/main/ad/20200104_banner02.jpg" alt="banner" /></a></div>
                    <div><a href="https://blog.naver.com/s_auction/221510924761" target="new"><img src="/images/img/main/ad/main_banner.jpg" alt="banner" alt="banner" /></a></div>
                </div>
            </div><!-- //web_only -->

            <div class="m_only">
            	<div class="sub_slide">
					<div class="bxslider">
	            		<div class="sub_banner02">
			                <div><a href="https://www.royalsaluteart.kr" target="new"><img src="/images/img/main/ad/20200104_banner02.jpg" alt="banner" /></a></div>
			            </div>
			            <div class="sub_banner02">
			            	<div><a href="https://blog.naver.com/s_auction/221510924761" target="new"><img src="/images/img/main/ad/main_banner.jpg" alt="banner" alt="banner" /></a></div>			            			</div>
	            	</div>
                </div>
			</div><!--//m_only -->
      	</div> --%>
        <!-- //상단 슬라이드 배너 -->
        <div class="onerow"></div>
        <h2 class="mainContents_tit">AUCTION</h2>

        <!-- 온라인 경매 -->
        <div class="col4">
            <!-- <a href="/currentAuction?sale_kind=online_only&sale_no=698&page=1">-->
                 <img ng-if="locale =='ko'" src="/images/img/main/auction_sum/20220401_ko.gif" style="width:100%;"/>
                 <img ng-if="locale !='ko'" src="/images/img/main/auction_sum/20220401_en.gif" style="width:100%;"/>
            <!-- </a> -->
            <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
            <p class="mainContents_txt" ng-if="locale=='ko'">4월 e BID 퍼블릭 온라인 경매 Ⅰ</p>
            <p class="mainContents_txt" ng-if="locale!='ko'">e BID Public Online Auction Ⅰ in April</p>
            <div style="clear:both;"></div>
        </div>

				<!-- 커밍순 썸네일-->
	        <div class="col4">
						<img src="/images/img/main/auction_sum/20190613.jpg" style="width:100%;"/>
	            <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
	            <p class="mainContents_txt"></p>
	            <div style="clear:both;"></div>
	        </div>

				<!-- 커밍순 썸네일-->
	        <div class="col4 last">
						<img src="/images/img/main/auction_sum/20190613.jpg" style="width:100%;"/>
	            <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
	            <p class="mainContents_txt"></p>
	            <div style="clear:both;"></div>
	        </div>
				<!-- 온라인 경매 -->
        <!-- <div class="col4">
            <a href="/currentAuction?sale_kind=online_only&sale_no=698&page=1">
                 <img ng-if="locale =='ko'" src="/images/img/main/auction_sum/20220324_ko.gif" style="width:100%;"/>
                 <img ng-if="locale !='ko'" src="/images/img/main/auction_sum/20220324_en.gif" style="width:100%;"/>
            </a>
            <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
            <p class="mainContents_txt" ng-if="locale=='ko'">4월 e BID 프리미엄 온라인 경매</p>
            <p class="mainContents_txt" ng-if="locale!='ko'">e BID Premium Online Auction in April</p>
            <div style="clear:both;"></div>
        </div> -->

				<!-- 제로베이스
        <div class="col4">
            <a href="/currentAuction?sale_kind=zerobase_only&page=1">
            	 <img src="/images/img/main/auction_sum/20220317.jpg" style="width:100%;"/>
						 </a>
            <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
            <p class="mainContents_txt" ng-if="locale=='ko'">ZEROBASE</p>
            <p class="mainContents_txt" ng-if="locale!='ko'">ZEROBASE</p>
            <div style="clear:both;"></div>
        </div> -->

        <!-- 오프라인 경매
        <div class="col4">
			<a href="/currentAuction?sale_kind=offline_only&sale_no=696&page=1">
                 <img ng-if="locale =='ko'" src="/images/img/main/auction_sum/20220307.gif" style="width:100%;"/>
                 <img ng-if="locale !='ko'" src="/images/img/main/auction_sum/20220307.gif" style="width:100%;"/>
			</a>
            <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
            <p class="mainContents_txt" ng-if="locale=='ko'">Contemporary Art Sale</p>
            <p class="mainContents_txt" ng-if="locale!='ko'">Contemporary Art Sale</p>
            <div style="clear:both;"></div>
        </div> -->

        <!-- 온라인 경매
        <div class="col4">
 			<a href="/currentAuction?sale_kind=online_only&sale_no=692&page=1">
                 <img ng-if="locale =='ko'" src="/images/img/main/auction_sum/20220223_ko.gif" style="width:100%;"/>
				 <img ng-if="locale !='ko'" src="/images/img/main/auction_sum/20220223_en.gif" style="width:100%;"/>
 			</a>
            <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
            <p class="mainContents_txt" ng-if="locale=='ko'">3월 e BID 프리미엄 온라인 경매</p>
            <p class="mainContents_txt" ng-if="locale!='ko'">e BID Premium Online Auction in March</p>
            <div style="clear:both;"></div>
        </div>  -->

        <!-- 블랙랏 전시
        <div class="col4">
 			<a href="/currentExhibit?sale_kind=exhibit_only&sale_no=673&page=1">
                 <img src="/images/img/main/auction_sum/20211026.jpg" style="width:100%;"/>
 			</a>
            <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
            <p class="mainContents_txt" ng-if="locale=='ko'">블랙랏 런칭 전시</p>
            <p class="mainContents_txt" ng-if="locale!='ko'">BLACKLOT Launching Exhibition</p>
            <div style="clear:both;"></div>
        </div> -->

        <!-- 아트시 경매
      	<div class="col4">
            <a href="/currentAuction?sale_kind=offline_only&sale_outside_yn=Y&sale_no=669#page1">
                <img src="/images/img/main/auction_sum/20211018.jpg" style="width:100%;"/>
            </a>
            <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
            <p class="mainContents_txt" ng-if="locale=='ko'">SEOUL AUCTION X ARTSY</p>
            <p class="mainContents_txt" ng-if="locale!='ko'">SEOUL AUCTION X ARTSY</p>
            <div style="clear:both;"></div>
      	</div> -->

      	<!-- 부산 세일 -->
      	<!--<div class="col4">
             <a href="/currentAuction?sale_kind=offline_only&page=1">
             <a href="/currentAuction?sale_kind=offline_only&sale_no=582&page=1">
             	<img src="/images/img/main/auction_sum/auction_thumb20201013.jpg" style="width:100%;"/>
             </a>
             <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
             <p class="mainContents_txt" ng-if="locale=='ko'">서울옥션 부산경매</p>
             <p class="mainContents_txt" ng-if="locale!='ko'">Seoul Auction Busan Sale</p>
             <div style="clear:both;"></div>
      	</div>  -->

       	<!-- 홍콩 세일 ->
      	<div class="col4">
              <a href="/currentAuction?sale_kind=offline_only&sale_no=566&page=1">
                <img src="/images/img/main/auction_sum/20200624_sum.jpg" style="width:100%;"/>
              </a>
              <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
              <p class="mainContents_txt" ng-if="locale=='ko'">제 32회 HONG KONG SALE</p>
              <p class="mainContents_txt" ng-if="locale!='ko'">32nd HONG KONG SALE</p>
              <div style="clear:both;"></div>
       	</div> -->

      	<!-- 이벤트 썸네일 ->
      	<div class="col4">
              <!-- <a href="/noticeView?write_no=3041"> ->
              <a href="https://www.artsy.net/auction/seoul-auction-spring-online-auction-goat">
              	<img src="/images/img/main/auction_sum/2020033101.png" style="width:100%;"/>
              </a>
              <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
              <p class="mainContents_txt" ng-if="locale=='ko'">아트시 X 서울옥션 온라인 경매</p>
              <p class="mainContents_txt" ng-if="locale!='ko'">Artsy X Seoul Auction</p>
              <div style="clear:both;"></div>
      	</div>

       	<!-- 위탁 안내 -->
       	<!-- <div class="col4 last">
              <a href="/auctionGuide/page?view=commissionGuide">
              <!-- <a href="/currentAuction?sale_kind=online_only&sale_no=483&page=1">  ->
              	 <img src="/images/img/main/auction_sum/20191217.jpg" style="width:100%;"/>
              </a>
              <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
              <p class="mainContents_txt" ng-if="locale=='ko'">위탁 안내</p>
              <p class="mainContents_txt" ng-if="locale!='ko'">Introduction to Consignment</p>
              <div style="clear:both;"></div>
       	</div> -->

     	<!--<div class="col4">
         	<a href="/currentAuction?sale_kind=offline_only">
          		<img src="/images/img/main/auction_sum/20190304.jpg" style="width:100%;"/>
          	</a>
          	<p style="padding-top:30px; padding-bottom:5px; font-size:12px;">Auction</p>
          	<p class="mainContents_txt">28th HONG KONG SALE </p>
            <div class="alert">
              	<span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
              	<strong>NOTICE! </strong><strong>Auction Blue</strong> 홈페이지에서 경매가 진행됩니다.
            </div>
            <div style="clear:both;"></div>
      	</div>  -->

      	<div class="onerow"></div>
				<h2 class="mainContents_tit">VIDEO</h2>
				<div class="col8" style="overflow:hidden">
	          	<div class="popupVideo">
	                  <a data-video="B_iGOoOR1SY">
	                      <img src="/images/img/main/video/20220401_01.jpg" style="width:100%; cursor:pointer;" alt="video1"/>
	                  </a>
	                  <div class="video-popup">
	                      <div class="video-popup-closer"></div>
	                  </div>
	                  <p class="web_only mainContents_txt" style="padding-top: 20px; font-size:14px;" ng-if="locale=='ko'">FOCUS ON: eBID Premium Online Auction in April 2022_해외작가편</p>
	                  <p class="web_only mainContents_txt" style="padding-top: 20px; font-size:14px;" ng-if="locale!='ko'">FOCUS ON: eBID Premium Online Auction in April 2022_해외작가편</p>
	          	</div>
	     	</div>
	      	<div class="col4 last" style="overflow:hidden">
	          	<div class="popupVideo">
	                  <a data-video="HyOD1CMbc5I">
	                      <img src="/images/img/main/video/20220401_02.jpg" style="width:100%; cursor:pointer;" alt="video2"/>
	                  </a>
	                  <div class="video-popup">
	                      <div class="video-popup-closer"></div>
	                  </div>
	                  <p class="web_only mainContents_txt" style="padding-top: 20px; font-size:14px;" ng-if="locale=='ko'">FOCUS ON: eBID Premium Online Auction in April 2022_국내작가편</p>
	                  <p class="web_only mainContents_txt" style="padding-top: 20px; font-size:14px;" ng-if="locale!='ko'">FOCUS ON: eBID Premium Online Auction in April 2022_국내작가편</p>
	            </div>

	         	<span class="m_only"><img src="/images/img/main/video/00.jpg" style="width:100%;" alt="높이용"/></span>

	          	<div class="popupVideo">
	                  <a data-video="oSp2Hn9Eq7o">
	                      <img src="/images/img/main/video/20220328_02.jpg" style="width:100%; cursor:pointer;" alt="video2"/>
	                  </a>
	                  <div class="video-popup">
	                      <div class="video-popup-closer"></div>
	                  </div>
	                  <p class="web_only mainContents_txt" style="padding-top: 20px; font-size:14px;" ng-if="locale=='ko'">AUCTION DAY REVIEW | Contemporary Art Sale</p>
	                  <p class="web_only mainContents_txt" style="padding-top: 20px; font-size:14px;" ng-if="locale!='ko'">AUCTION DAY REVIEW | Contemporary Art Sale</p>
	          	</div>
	      	</div>

     	<div class="onerow"></div>

        <!-- 전시장 vr
        <div class="col6" style="overflow:hidden">
           	<h2 class="mainContents_tit mainContents_tit_mver">
           		<p ng-if="locale=='ko'">VR 전시장 보기</p><p ng-if="locale!='ko'">VR Exhibition</p>
           	</h2>
           	<a href="/nas_img/front/homepage/VR/164th/index.html" target="_blank" title="60VRPop">
                <img src="/nas_img/front/homepage/VR/164th/resource/bg01.jpg" style="width:100%; hight:auto; verflow:hidden;"/>
           	</a>
        </div> -->

         <!-- 서울옥션빈칸
        <div class="col6 last" style="overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
             	<p ng-if="locale=='ko'">서울옥션</p><p ng-if="locale!='ko'">SeoulAuction</p>
            </h2>
            <a href="/about/page?view=introduction">
                <img src="/images/img/main/ex/sa01.jpg" style="width:100%; hight:auto;"/>
            </a>
        </div> -->

       <!-- 서울옥션 블루 썸네일(추후 생성시 밑에 썸네일 엘리먼트스타일 padding-top:50px; 넣기)
     	<h2 class="mainContents_tit">SEOUL AUCTION BLUE</h2>

      	<div class="col4">
              <a href="https://www.auctionblue.com/auctions/AUCID0000001168/" target="_blank">
             	 <img src="/images/img/main/bluenow/BLUENOW_128.jpg" style="width:100%;"/>
              </a>
              <p style="padding-top:30px; padding-bottom:5px; font-size:12px;"> ONLINE AUCTION : 2021.3.18 (Thu) 1pm</p>
              <p class="mainContents_txt">128th BLUENOW</p>
              <div style="clear:both;"></div>
      	</div>

      	<div class="col4">
              <a href="https://www.auctionblue.com/auctions/AUCID0000001169/" target="_blank">
              	<img src="/images/img/main/bluenow/BLUENOW_129.jpg" style="width:100%;"/>
              </a>
              <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">ONLINE AUCTION : 2021.3.25 (Thu) 1pm</p>
              <p class="mainContents_txt">129th BLUENOW</p>
              <div style="clear:both;"></div>
      	</div>

     	<div class="col4 last">
              <a href="https://www.auctionblue.com/auctions/AUCID0000001172/" target="_blank">
              	<img src="/images/img/main/bluenow/BLUENOW_130.jpg" style="width:100%;"/>
              </a>
              <p style="padding-top:30px; padding-bottom:5px; font-size:12px;">ONLINE AUCTION : 2021.4.1 (Thu) 1pm</p>
              <p class="mainContents_txt">130th BLUENOW</p>
              <div style="clear:both;"></div>
      	</div> -->

        <!-- 강남센터 전시
        <div class="col6" style="overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
             	<p ng-if="locale=='ko'">서울옥션 강남센터</p><p ng-if="locale!='ko'">Gangnam Center</p>
            </h2>
            <a href="/about/page?view=gnExhibition">
            	<img src="/images/img/main/gang/sa21.jpg" style="width:100%; hight:auto;"/>
            </a>
        </div>  -->

		<!-- 강남센터 전시
        <div class="col6 last" style="overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
             	<p ng-if="locale=='ko'">서울옥션 강남센터</p><p ng-if="locale!='ko'">Gangnam Center</p>
            </h2>
            <a href="/about/page?view=gnExhibition">
            	<img src="/images/img/main/gang/sa22.jpg" style="width:100%; hight:auto;"/>
            </a>
        </div> -->

        <!-- 로얄살루트
        <div class="col6" style="padding-top:50px; overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
            	<p ng-if="locale=='ko'">로얄살루트</p><p ng-if="locale!='ko'">Royal Salute</p>
            </h2>
            <a href="/about/page?view=EventExhibition">
                <img src="/images/img/main/ad/20211004.jpg" style="width:100%; hight:auto;"/>
            </a>
        </div> -->

        <!-- 아카데미
        <div class="col6 last" style="padding-top:50px; overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
            	<spring:message code="label.academy" />
            </h2>
            <a href="/academyArtauctionView?academy_no=104">
                <img src="/images/img/main/aca/aca38.jpg" style="width:100%; hight:auto;"/>
            </a>
        </div> -->

        <!-- 아트시 전시장 vr
        <div class="col6 last" style="padding-top:50px; overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
            	<p ng-if="locale=='ko'">VR 전시장 보기</p><p ng-if="locale!='ko'">VR Exhibition</p>
            </h2>
            <a href="/service/page?view=auction360VRPop_online2" target="new" title="60VRPop">
            	<img src="/images/img/main/ex/vr43.jpg" style="width:100%; hight:auto; verflow:hidden;"/>
            </a>
        </div> -->

        <!-- 경매 건물 vr
        <div class="col6" style="padding-top:50px; overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
            	<p ng-if="locale=='ko'">VR 영상</p><p ng-if="locale!='ko'">VR Video</p>
            </h2>
            <a href="/service/page?view=auction360VRPop_online2" target="new" title="60VRPop">
                <img src="/images/img/main/ex/vr41.jpg" style="width:100%; hight:auto; verflow:hidden;"/>
            </a>
        </div> -->

        <!-- 홍콩 리미티드
        <div class="col6 " style="padding-top:50px; overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
            	<p ng-if="locale=='ko'">서울옥션 홍콩 리미티드</p><p ng-if="locale!='ko'">SEOUL AUCTION HONG KONG LIMITED</p>
            </h2>
            <a href="/about/page?view=saplus">
            	<img src="/images/img/main/SA/sa17.jpg" style="width:100%; hight:auto;"/>
            </a>
        </div> -->

        <!--부산 전시
        <div class="col6 last" style="padding-top:50px; overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
            	<p ng-if="locale=='ko'">서울옥션 부산</p><p ng-if="locale!='ko'">Seoul Auction BUSAN</p>
            </h2>
            <!-- <a href="/about/page?view=gnExhibition02"> ->
            	<img src="/images/img/main/gang/sa07.jpg" style="width:100%; hight:auto;"/>
            <!-- </a>
        </div> -->

        <!--서울옥션 X 삼성카드
        <div class="col6 last" style="padding-top:50px; overflow:hidden">
            <h2 class="mainContents_tit mainContents_tit_mver">
               	<p ng-if="locale=='ko'">서울옥션 X 삼성카드</p><p ng-if="locale!='ko'">SeoulAuction X Samsung Card</p>
            </h2>
            <a href="/noticeView?write_no=2629">
         	   <img src="/images/img/main/samsung.jpg" style="width:100%; hight:auto;"/>
            </a>
        </div> -->

        <div class="onerow"></div>
        <div class="col6 web_only">
            <h2 class="mainContents_tit" style="border-bottom: 2px solid #000;">
            	<a href="/noticeList"><spring:message code="label.notice" /></a>
            </h2>
            <div id="recentNoticeContainer" ng-controller="recentNoticeCtl" data-ng-init="loadRecentNotice();">
                <ul>
                    <span ng-if="locale=='ko'"><li ng-repeat="row in recentList" class="mainContent_notice"><a href="/noticeView?write_no={{row.WRITE_NO}}">{{row.TITLE}}</a></li></span>
                    <span ng-if="locale!='ko'"><li ng-repeat="row in recentList" class="mainContent_notice"><p ng-if="row.TITLE_EN != null || row.TITLE_EN != ''"><a href="/noticeView?write_no={{row.WRITE_NO}}">{{row.TITLE_EN}}</a></p></li></span>

                </ul>
            </div>
      </div>
      <div class="col6 last web_only">
          <h2 class="mainContents_tit" style="border-bottom: 2px solid #000;"><a href="/about/page?view=pressList"><spring:message code="label.press" /></a></h2>
            <div id="recentPressContainer" ng-controller="recentPressCtl" data-ng-init="loadRecentPress();">
                <ul>
                    <span ng-if="locale=='ko'"><li ng-repeat="row in recentPressList" class="mainContent_notice"><a href="{{row.PRESS_URL}}" target="new">{{row.PRESS_TITLE}}</a></li></span>
                    <span ng-if="locale!='ko'"><li ng-repeat="row in recentPressList" class="mainContent_notice"><a href="{{row.PRESS_URL_EN}}" target="new">{{row.PRESS_TITLE_EN}}</a></p></li></span>

                </ul>
            </div>
      </div>

      <div class="onerow"></div>
      <div class="col12 last">
          <h2 class="mainContents_tit">HOW TO</h2>
          <div class="col3">
          <a href="/auctionGuide/page?view=biddingGuide"><img src="/images/img/main/howto/02.jpg" style="width:100%;"/></a>
          <p class="mainContents_txt" style="padding-top: 20px;"><spring:message code="label.howto.auction" /></p>
          </div>
          <div class="col3">
          <a href="/auctionGuide/page?view=commissionGuide"><img src="/images/img/main/howto/05.jpg" style="width:100%;"/></a>
          <p class="mainContents_txt" style="padding-top: 20px;"><spring:message code="label.howto.contract" /></p>
          </div>
          <div class="col3">
          <a href="/auctionGuide/page?view=priGuide"><img src="/images/img/main/howto/07.jpg" style="width:100%;"/> </a>
          <p class="mainContents_txt" style="padding-top: 20px;"><spring:message code="label.howto.PRIVATE" /></p>
          </div>
          <div class="col3 last">
          <a href="/join/agree"><img src="/images/img/main/howto/06.jpg" style="width:100%;"/></a>
          <p class="mainContents_txt" style="padding-top: 20px;"><spring:message code="label.agree" /></p>
          </div>
      </div>

      <div class="onerow"></div>
      <h2 class="mainContents_tit">FAMILY SITE</h2>
      <div class="col4">
          <a href="https://www.auctionblue.com" target="_blank"><img src="/images/img/main/ect/blue.jpg" style="width:100%;"/></a>
          <p class="mainContents_txt" style="padding-top: 20px;"><spring:message code="label.AuctionBlueonline" /></p>
      </div>
      <div class="col4">
          <a href="https://printbakery.com/" target="_blank"><img src="/images/img/main/ect/20220225_01.png" style="width:100%;"/></a>
          <p class="mainContents_txt" style="padding-top: 20px;"><spring:message code="label.printbakery" /></p>
      </div>
      <div class="col4 last">
          <a href="https://www.youtube.com/channel/UCITsbs0m_QpXwZSZ-jc3ORA" target="_blank">
          	<img src="/images/img/main/ect/20220331.png" style="width:100%;"/>
          </a>

          <!-- <p style="padding-top:30px; padding-bottom:30px; font-size:18px; font-weight:600;" ng-if="locale=='ko'"><Bon Voyage : Kim Sun woo></p> -->

          <p class="mainContents_txt" style="padding-top: 20px;" ng-if="locale=='ko'">PRINT BAKERY YOUTUBE</p>
          <p class="mainContents_txt" style="padding-top: 20px;" ng-if="locale!='ko'">PRINT BAKERY YOUTUBE</p>
      </div>


      <div class="onerow"></div>

        <div class="col12 last">
            <div class="web_only">
            	<!-- 배너 1개 일 때 -->
                <a href="https://sotwo.com/" target="_blank">
                    <img src="/images/img/main/ad/2021040501.jpg" alt="banner" style="width:100%; vertical-align: auto;"/>
                </a>
                <!-- <div class="sub_banner02" id="slides01" style="margin-top:50px;">
                    <a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a>
                    <a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
                    <div class="sub_banner02">
                        <div>
                            <a href="https://xxblue.com/so2/sales/list/">
                                <img src="/images/img/main/ad/2021040501.jpg" alt="banner" target="_blank"/>
                            </a>
                        </div>
                    </div>
                    <div><a href="http://www.rarebyblue.com/" target="new"><img src="/images/img/main/ad/03.jpg" alt="banner" /></a></div>
                    <div><a href="http://www.rarebyblue.com/" target="new"><img src="/images/img/main/ad/04.jpg" alt="banner" /></a></div>
                </div> -->
            </div> <!-- //web_only -->

            <div class="m_only">
            	<!-- 배너 1개 일 때 -->
                <a href="https://sotwo.com/" target="_blank">
                    <img src="/images/img/main/ad/2021040501.jpg" alt="banner" style="width:100%; vertical-align: auto;"/>
                </a>
            	<!-- <div class="sub_slide">
					<div class="bxslider">
                    	<div class="sub_banner02">
			            	<div>
                            	<a href="https://xxblue.com/so2/sales/list/">
                                	<img src="/images/img/main/ad/2021040501.jpg" alt="banner" target="_blank"/>
                                </a>
                            </div>
			            </div>
                        <div class="sub_banner02">
			                <div><a href="http://www.rarebyblue.com/" target="new"><img src="/images/img/main/ad/03.jpg" alt="banner" /></a></div>
			            </div>
			            <div class="sub_banner02">
			            	<div><a href="http://www.rarebyblue.com/" target="new"><img src="/images/img/main/ad/04.jpg" alt="banner" /></a></div>
			            </div>
	            	</div>
                </div> -->
                <!--// sub_slide -->
			</div><!--//m_only -->
        </div><!-- //col12 last (슬라이드)-->
      <div class="onerow"></div>
	</div><!-- //onepcssgrid-1200 -->
</div>


<!-- 비번 초기화 변경 팝업 -->
<div class="new_passwordbox" style="display: none;" id="pwResetLay" ng-controller="mainInfoCtl">
	<div class="new_pwbox">
		<h1 class="new_pwh1">
			<span></span><!-- //logo css 지우면 안됨 -->
			초기화 비밀번호 변경 안내
		</h1>

		<div class="pw_info">
			<p>
				<span style="font-weight:bold; display: inline-block; margin-bottom: 10px;">[초기화 비밀번호 : sareset]</span><br>
				현재 비밀번호 초기화 되어 안전한 회원정보 유지를 위해
				반드시 비밀번호를 변경해 주시기 바랍니다.<br>
				<span style="color: #f00; font-size: 12px; font-weight: bold;">(비밀번호는 영문자, 숫자, 특수문자의 조합으로 4~14자로 입력해주세요.)</span>
			</p>

			<div class="new_pw_form">
				<form>
					<label for="NewPw">새 비밀번호</label>
					<input type="password" id="NewPw" name="NewPw" />
				</form>
				<form>
					<label for="NewPwConform">새 비밀번호 확인</label>
					<input type="password" id="NewPwConform" name="NewPwConform" />
				</form>
			</div>

			<div class="new_pw_closebtn">
				<button class="new_pw_change" ng-click="pwdChange()">변경</button>
			</div>
		</div>
	</div>
</div>


<!-- 국문 레이어팝업 -->
<%-- <c:if test="${locale == 'ko'}">
    <div id="overlay" onclick="off()">
        <div id="textbg">
        	<span id="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
        	<div class="layerbox_wrap">
    	    	<div class="layer_img">
                    <!-- <p class="layer_tit" style="text-align:center;">
                        [제로베이스 더 페인터스 진행 오류 안내]

                    </p>
                    <p class="layerbox" style="padding: 10px 0 20px; text-align:center; font-weight: bold;">
                        현재 홈페이지 접속 오류로 인해 제로베이스 경매가 일시중시되었습니다. <br>
                        내부적으로 빠른 복구를 위해 확인 중에 있습니다.<br>
                        경매는 Lot.35 정지윤 작가님의 작품부터 15시10분에 재진행하도록 하겠습니다.<br><br>

                        고객 여러분들의 양해 부탁드립니다.



                         <span style="font-weight:bold; text-align: right; margin: 20px 0 0; display:block;">
                            -서울옥션 임직원 일동-
                        </span>
                    </p> -->

<!--                     <a href="/noticeView?write_no=5507" style="display:block; text-align:center;" target="_blank">  -->
<!--                         <img src="/images/img/main/overlay/20220127_ko.jpg" alt="layerpopup" style="text-align:center;">           -->
<!--                     </a>  -->

                    <!-- 이미지 두개 이상 -->
                    <a href="/noticeView?write_no=5507" style="display:block; text-align:center;">
                        <img src="/images/img/main/overlay/20220203-ko.jpg" alt="layerpopup" style="text-align:center; margin-bottom: 10px;">
                    </a>

                    <!-- <a href="" style="display:block;">
                        <img src="/images/img/main/overlay/20220127_2.jpeg" alt="layerpopup" style= "text-align:center; ">
                    </a> -->

                    <!-- <a href="/currentAuction?sale_kind=zerobase_only&page=1&lang=ko#page1" style="display:block;" target="_blank">
                        <img src="/images/img/main/overlay/2021052403.jpg" alt="layerpopup" style="max-height:245px; text-align:center;">
                    </a> -->

                    <!-- 버튼 -->
                    <!-- <a href="/currentAuction?sale_kind=online_only" class="btn_main_more green" style="width:80px;">상세 보기</a>
                    <a href="/noticeView?write_no=3518" class="btn_main_more green" style="width:80px;">자세히 보기</a> -->
    	    	</div>
	        </div> <!-- //layerbox_wrap -->
            <!-- 오늘하루 안보기 버튼 -->
            <input type="checkbox" name="close" value="OK" onclick="javascript:closeWin('overlay', 1);"/>
            <font style="font-size:12px; vertical-align: middle;" onclick="javascript:closeWin('overlay', 1);">하루동안 이 창을 열지 않음</font>
         </div>
    </div>
</c:if> --%>


<!-- 영문 레이어팝업 -->
<%-- <c:if test="${locale!= 'ko'}">
    <div id="overlay" onclick="off()">
        <div id="textbg">
        	<span id="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
        	<div class="layerbox_wrap">
        		<!-- <p class="layer_tit">
       				＜The unit price per onilne auction bid amount＞
       			</p>
        		<p class="layerbox">
			        February Online Auction Location of Exhibition –<br/>
			        Seoul Auction Space (Head Office, Pyeongchang Dong) <br/>
        			Dear Collectors, <br/>
					I wish you and your loved ones health, happiness, prosperity,<br/>
                    and peace this holiday season.<br/>
                    Merry Christmas and Happy new year!
		            <span style="font-weight:bold; text-align: right; margin: 20px 0 0; display:block;">
                    	Warm regards, SEOUL AUCTION Team
	                </span>
    	    	</p>
    	    	<!--<a href="/currentAuction?sale_kind=online_only" class="btn_main_more green" style="width:80px;">SEE MORE</a>
    	    	<a href="/noticeView?write_no=3518" class="btn_main_more green" style="width:80px;">NOTICE</a> -->


    	    	<!-- 이미지 레이어 팝업-->
    	    	<div class="layer_img">
<!--     	    		<a href="/noticeView?write_no=5507" style="display:block; text-align:center;" target="_blank">    -->
<!--                         <img src="/images/img/main/overlay/20220127_en.jpg" alt="layerpopup" style="text-align:center;">  -->
<!--                     </a>    -->

    	    		<!-- 이미지 두개 -->
    	    		<a href="/noticeView?write_no=5507" style="display:block; text-align:center;">
    	    			<img src="/images/img/main/overlay/20220203-en.jpg" alt="layerpopup" style="text-align:center; margin-bottom: 10px;">
    	    		</a>

                    <!-- <a href="" style="display:block;" target="_blank">
    	    			<img src="/images/img/main/overlay/20220127_2.jpeg" alt="layerpopup" style="text-align:center;">
    	    		</a> -->
    	    	</div><!-- //layer_img -->
        	</div> <!-- //layerbox_wrap -->
            <input type="checkbox" name="close" value="OK" onclick="javascript:closeWin('overlay', 1);"/>
            <font style="font-size:12px; vertical-align:middle;">&nbsp;&nbsp;Do not open this window for one day</font>
        </div>
    </div>
</c:if> --%>

<script>
	var isMobile = {
		Android: function() {
			return navigator.userAgent.match(/Android/i);
		},
		BlackBerry: function() {
			return navigator.userAgent.match(/BlackBerry/i);
		},
		iOS: function() {
			return navigator.userAgent.match(/iPhone|iPad|iPod/i);
		},
		Opera: function() {
			return navigator.userAgent.match(/Opera Mini/i);
		},
		Windows: function() {
			return navigator.userAgent.match(/IEMobile/i);
		},
		any: function() {
			return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
		}
	};
	if(isMobile.any()){
		/* m_only banner slider */
		$(".sub_slide .bxslider").bxSlider({
			auto:true,
			pause: 4000,
			pager: true,
		});
	} else {
		/* web_only banner slider */
		$(function() {
			$('#slides01,#top_slide_banner').slidesjs({
				height : 180,//??
				navigation : false,
				start : 1,
				play : {
					auto : true,
				}
			});
		});
	};
</script>



<script>
// overlay 사용 (국문만 사용시 사용)
/*$(window).ready(function(){
var blnCookie = getCookie("overlay");
if(!blnCookie == false){
    document.getElementById("overlay").style.display = "none";
} else {
	if( "${locale}" == "ko" ){
		document.getElementById("overlay").style.display = "block";
	}
}
});

// overlay 사용 (국문영문모두사용시 사용)
$(window).ready(function(){
var blnCookie = getCookie("overlay");
if(!blnCookie == false){
    document.getElementById("overlay").style.display = "none";
} else {
		document.getElementById("overlay").style.display = "block";
}
});


function off() {
    document.getElementById("overlay").style.display = "none";
}

//창닫기(overlay)
function closeWin(winName, expiredays) {
   setCookie( winName, "done" , expiredays);
   var obj = eval( "window." + winName );
   obj.style.display = "none";
}
*/

// 쿠키 가져오기
function getCookie( name ) {
   var nameOfCookie = name + "=";
   var x = 0;
   while ( x <= document.cookie.length )
   {
       var y = (x+nameOfCookie.length);
       if ( document.cookie.substring( x, y ) == nameOfCookie ) {
           if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
               endOfCookie = document.cookie.length;
           return unescape( document.cookie.substring( y, endOfCookie ) );
       }
       x = document.cookie.indexOf( " ", x ) + 1;
       if ( x == 0 )
           break;
   }
   return "";
}
</script>
<!-- overlay --><!-- sh -->


<!-- Video -->
<script>

	$(".popupVideo a").click(function() {
		  $(".video-popup").addClass("reveal"),
		  $(".video-popup .video-wrapper").remove(),
		  $(".video-popup").append("<div class='video-wrapper'><img class='videoclose_btn' src='/images/icon/close_white_24dp.svg'><div class='videoBox'><iframe width='1280' height='720' src='https://youtube.com/embed/" + $(this).data("video") + "' allow='autoplay; encrypted-media' allowfullscreen></iframe></div></div>"),
		  $(".video-popup").find("img.videoclose_btn").click(function(){// 닫기버튼 추가 (2021.11.30 em) ,
			  $(".video-popup .video-wrapper").remove(),
			  $(".video-popup").removeClass("reveal")
		  });
	}),
	$(".video-popup-closer").click(function() {
	  $(".video-popup .video-wrapper").remove(),
	  $(".video-popup").removeClass("reveal")
	});

</script>



<div style="clear:both;"></div>
