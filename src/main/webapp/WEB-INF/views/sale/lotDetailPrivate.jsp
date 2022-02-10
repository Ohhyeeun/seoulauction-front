<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/> 
<link href="/resources/css/angular/ng-animation.css" rel="stylesheet">
<link href="/css/angular/ngDialog.min.css" rel="stylesheet">
<link href="/resources/css/angular/popup.css" rel="stylesheet">
<link type="text/css" href="/css/imgzoom/jquery.magnify.css" rel="stylesheet">
<link type="text/css" href="/css/imgzoom/magnify-bezelless-theme.css" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script type="text/javascript" src="/js/angular/rzslider.min.js"></script>
<!--  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular-animate.min.js"></script> -->
<script type="text/javascript" src="/resources/js/angular/angular-animate.min.js"></script>  
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>
<script type="text/javascript" src="/js/imgzoom/jquery.magnify.js"></script> 

<!-- <script>   
//YDH 자세히 보기 
function OnloadImg(){
	var m_sImagePath ="";
	m_sImagePath = $("#thumb123").find("li.sele").find("img").attr("src");
	console.log(m_sImagePath);
	/* m_sImagePath = m_sImagePath.replace("thum/", "");		
	m_sImagePath = m_sImagePath.replace("list/", "");
	m_sImagePath = m_sImagePath.replace("detail/", ""); */
	
	console.log(m_sImagePath);
	console.log("##########");
	
	var img=new Image();
	img.src=m_sImagePath;
	var img_width=1200;
	var win_width=1200;
	var height=800;
	var OpenWindow=window.open('/lotDetailImgView?url='+img.src,'_blank', 'width='+img_width+', height='+height+', menubars=no, scrollbars=yes');
	  
	 }	 
</script> --> 

<script>

	app.value('locale', 'ko');
	app.requires.push("bw.paging");

	app.controller('asPsDetailCtl', function($scope, consts, common, is_login, locale, $filter) {
		
		$scope.is_login = is_login;
		$scope.locale = locale;
		var SALE_AS_NO = getParameter("SALE_AS_NO");
		console.log(SALE_AS_NO);

		$scope.loadAsDetail = function($page) {
			$scope.currentPage = $page;
		$d = {
				"baseParms" : {	"SALE_AS_NO" : SALE_AS_NO },
				"actionList" : [ 
					{"actionID" : "as_list_detail","actionType" : "select","tableName" : "AS_DETAIL","parmsList":[]}, 
					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]},
					{"actionID":"as_detail_img", "actionType":"select" , "tableName": "AS_IMG" ,"parmsList":[]}
			]};

			common.callActionSet($d, $s);
			
			
			
		}

		var $s = function(data, status) {
			$scope.asDetail = data["tables"]["AS_DETAIL"]["rows"][0];
			$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
			$scope.asImg = data["tables"]["AS_IMG"]["rows"];
			console.log($scope.asDetail);
		};
		
		
		$scope.RCnt = 0;
		$scope.$on('ngRepeatFinished', function (ngRepeatFinishedEvent) {
			$scope.RCnt++;
	        if($scope.RCnt == 2){
	            $("#rollingBox123").slideFunc("", "#rolling123", "#thumb123");
	        }
		});
		
	});
</script>
<body>

<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition"> 
<jsp:include page="../include/topMenu.jsp" flush="false"/>
	
<div class="container_wrap">
	<div id="container" ng-controller="asPsDetailCtl" data-ng-init="loadAsDetail(1)">
		<div class="sub_menu_wrap menu01">
			<div class="sub_menu"> 
				<jsp:include page="../contents/include/PS_Submenu.jsp" flush="false"/>
			</div>
		</div> 
		<!-- //sub_menu_wrap -->

		<div class="contents_wrap">
			<div class="contents m_top">
				<div class="btn_wrap top link mt0">
					<div class="left">  
						<div class="sns_area"> 
							<ul class="fl_menu">
								<li><a href="javascript:shareSns('T');" class="sp_btn sns01"><span class="hidden"><spring:message code="label.sns.twitter" /></span></a></li>
								<li><a href="javascript:shareSns('F');" class="sp_btn sns02"><span class="hidden"><spring:message code="label.sns.facebook" /></span></a></li>
								<li><a href="javascript:shareSns('G');" class="sp_btn sns03"><span class="hidden"><spring:message code="label.sns.google" /></span></a></li>
							</ul> 
						</div>      
					</div>
                    
					<div class="right">
						<span class="btn_style01 white02 icon btn_list mbtn">
							<span class="ico list"></span>
							<c:choose>
								<c:when test="${param.sale_status == 'ING'}">
									<a href="#"> 
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:when>
								<c:when test="${param.sale_status == 'END'}">
									<a href="#">
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:when>
								<c:otherwise>
									<a href="<%--뒤로가야함--%>">  
										<span ng-if="locale != 'en'" onclick = "history.go(-1); return false;">목록</span>
										<span ng-if="locale == 'en'" onclick = "history.go(-1); return false;">List</span>
									</a> 
								</c:otherwise> 
							</c:choose>  
						</span> 
						<c:if test="${param.view_type == 'LIST' or param.view_type == 'GRID'}">
							<span class="btn_style01 white02 icon btn_prev mbtn">
								<span class="ico prev"></span>
								<a href="#"> 
									<span ng-if="locale != 'en'">이전</span>
									<span ng-if="locale == 'en'">Prev</span>
								</a> 
							</span>
							<span class="btn_style01 white02 icon02 btn_next mbtn">  
								<span class="ico next"></span>
								<a href="#">
									<span ng-if="locale != 'en'">다음</span>
									<span ng-if="locale == 'en'">Next</span>
								</a>  
							</span>
						</c:if> 
						<span class="btn_style01 icon02 btn_scrollbot mbtn">
							<button type="button">  
								<span ng-if="locale != 'en'">아래로</span>
								<span ng-if="locale == 'en'">Down</span>
							</button>  
							<span class="ico down"></span>
						</span>  
					</div>
				</div>
				
				<div class="state_wrap">
					<div class="state_area_detail web_only" style="vertical-align: middle; line-height:50px;">
						<!-- background-color용 --> 
                        <div class="state" style="width:55px; height: 20px; margin-right:5px; font-size: 12px; line-height: 20px; text-align:center; color:#009999; background-image:url(/images/bg/sprite_bg.png); background-repeat:no-repeat; background-position:-229px -21px; display: inline-block; vertical-align:middle;"> 
                        	<span ng-if="locale != 'en'">진행중</span>
							<span ng-if="locale == 'en'">Ongoing</span>  
                        </div>  
                        <span style="color:#333; font-size:24px; font-weight: bold; vertical-align:middle; display:inline-block;">PRIVATE SALE</span>  
					</div> 
				</div>
				
				<div class="master_detail"> 
					<div class="detail"> 
						<div id="rollingBox123" class="left rolling_box3">
							<div class="img_represent">
								<div class="btns rolling_btn">
									<button type="button" class="sp_btn btn_prev"><span class="hidden"><spring:message code="label.move.prev" /></span></button>
									<button type="button" class="sp_btn btn_next"><span class="hidden"><spring:message code="label.move.next" /></span></button>
								</div>
								<!-- 디테일 이미지 -->
								<div id="rolling123" class="hidden_box rolling" >
									<ul style="width: 500px;">  
										<li ng-repeat="asImg in asImg" on-finish-render-filters>
											<a class="imgzoom_a" data-magnify="gallery" href="/nas_img/{{asImg.FILE_PATH}}/{{asImg.FILE_NAME}}" title="이미지 확대보기"> 
												<img ng-src="/nas_img/{{asImg.FILE_PATH}}/{{asImg.FILE_NAME}}" alt="프라이빗 이미지 디테일" style="max-width: 100%; max-height: 100%;"> 
											</a> 
										</li> 
									</ul>
								</div>
							</div>  
							<!-- 썸네일 이미지 -->
							<div id="thumb123" class="thumb_list"> 
								<ul>
									<li style="text-align: center;" class="sele" ng-repeat="asImg in asImg" on-finish-render-filters>  
										<span>
											<img ng-src="/nas_img/{{asImg.FILE_PATH}}/{{asImg.FILE_NAME}}" /> 
											<span class="masking"></span> 
										</span>
									</li> 
								</ul> 
							</div>  
                            <!-- <a onClick="OnloadImg();" class="btn_view" style="cursor:pointer;">
								<span ng-if="locale != 'en'">자세히보기</span> 
								<span ng-if="locale == 'en'">&nbsp;&nbsp;&nbsp;Details&nbsp;&nbsp;</span>
							</a> -->    
						</div>
						<!-- 오른쪽 캡션상세정보 -->
						<div class="right">
							<div class="author">
								<div class="lot">NO.
									<strong>
										<span>{{asDetail.AS_NO}}</span>
									</strong>
								</div>
								<div class="name" id="artist_name">
								<c:if test="${locale == 'ko'}"> 
									<span>{{asDetail.ARTIST_NAME_BLOB_KO}}</span>
								</c:if>
								<c:if test="${locale != 'ko'}"> 
									<span>{{asDetail.ARTIST_NAME_BLOB_EN}}</span>
								</c:if>
								</div>
								<div class="lang">
									<span class="txt_cn">{{asDetail.ARTIST_NAME_BLOB_CN}}</span>
								</div>
								<div class="year"><span>{{asDetail.BORN_YEAR}}</span></div>
							</div> 
							<div class="title">
								<div class="tit" id="workTitle">
								<c:if test="${locale == 'ko'}"> 
									<span>{{asDetail.TITLE_BLOB_KO}}</span>
								</c:if>
								<c:if test="${locale != 'ko'}"> 
									<span>{{asDetail.TITLE_BLOB_EN}}</span>
								</c:if>
								</div>
								<div class="mat">
									<span>{{asDetail.CD_NM_EN}}</span>
									<p ng-repeat="size in asDetail.LOT_SIZE_JSON">
										<!-- <span ng-bind="size | size_text"></span> -->
										<span ng-if="locale=='ko'"  ng-bind="size | size_text_cm"></span>
										<span ng-if="locale!='ko'"  ng-bind="size | size_text_in"></span>
									</p>
									<p><span>{{asDetail.EDITION}}</span></p> 
									<p>
										<span>{{asDetail.MAKE_YEAR_BLOB}}</span>
									</p> 
									<p>
										<span bind-html-compile="asDetail.SIGN_INFO_JSON[locale]"></span>
									</p>
									<p>
										<span bind-html-compile="asDetail.COND_RPT_JSON[locale]"></span>
									</p>
								</div>
							</div> 
							<div class="title">  
								<div class="mat"> 
									<p ng-if="locale == 'ko'" class="inquiry_no_email">
                                    	<span class="inquiry_no_email_lang"> 
                                            서울옥션 파트너 그룹  정선정 선임
                                            <span>
                                                작품문의: <a href="tel:02-2075-4423">02-2075-4423</a> / <a href="mailto:jsj@seoulauction.com">jsj@seoulauction.com</a>
                                            </span>
                                            또는, 로그인 뒤 1:1 문의를 하실 수 있습니다.
                                        <span>
									</p>
                                    <p ng-if="locale != 'ko'" class="inquiry_no_email">    
                                    	<span class="inquiry_no_email_lang">   
                                            <!--E-mail: (Hong Kong) saplus@seoulauction.com --> 
                                            Partner Group Jung sunjung
                                            <span>
                                                <a href="tel: +82 (0)2-2075-4423">Tel. +82 (0)2-2075-4423</a>
                                            </span>   
                                            <span>
                                                <a href="mailto:jsj@seoulauction.com">jsj@seoulauction.com</a> 
                                            </span> 
                                        </span>
                                    </p> 
								</div> 
							</div> 
							
							<div class="info"> 
								<!-- 1:1문의 --> 
								<span class="btn_style01 xlarge green02 btn_bid">
									<button type="button" onClick="location.href='/customer/inquiryForm'">
                                        <spring:message code="label.go.inquery" />
                                    </button> 
								</span>
								<!-- 출력하기 btn -->
                                <a href="#" target="_blank">  
									<span class="btn_style01 xlarge2 white">
										<button type="button"> 
											<spring:message code="label.go.print.now" />
										</button>
									</span>
								</a> 	
                             </div>                             
						</div> 
					</div> 
				</div>  
				<div class="m_block">
					<div class="master_info explain" ng-if="asDetail.PROV_INFO_JSON[locale]">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.provenance" /></div>
							<div class="txt" bind-html-compile="asDetail.PROV_INFO_JSON[locale]"></div>
						</div>
					</div>
					<div class="master_info explain" ng-if="asDetail.LITE_INFO_JSON[locale]">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.literature" /></div>
							<div class="txt" bind-html-compile="asDetail.LITE_INFO_JSON[locale]"></div>
						</div>
					</div>
					<div class="master_info explain" ng-if="asDetail.EXHI_INFO_JSON[locale]">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.exhibited" /></div>
							<div class="txt" bind-html-compile="asDetail.EXHI_INFO_JSON[locale]"></div>
						</div>
					</div>
					<div class="master_info explain" ng-if="asDetail.ETC_INFO_JSON[locale]">
						<div class="left" style="padding-right: 0px;">
							<!--  <div class="tit"><spring:message code="label.auction.detail.literature" /></div>  기타사항 용어 정의 필요 -->
							<div class="txt" bind-html-compile="asDetail.ETC_INFO_JSON[locale]"></div>
						</div>
					</div>
					<div class="master_info explain" ng-if="asDetail.CMMT_JSON[locale]">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.explain" /></div>
							<div class="txt" bind-html-compile="asDetail.CMMT_JSON[locale]"></div>
						</div>
					</div>
					<%-- <div class="master_info explain" ng-if="asDetail.CMMT_BLOB_EN && locale=='en'">
						<div class="left" style="padding-right: 0px;">
							<div class="tit"><spring:message code="label.auction.detail.explain" /></div>
							<div class="txt" bind-html-compile="asDetail.CMMT_BLOB_EN"></div>
						</div>
					</div> --%>
					
				</div>
				
				
				
				<div class="btn_wrap link">
					<div class="right">  
						<span class="btn_style01 white02 icon btn_list mbtn">
							<span class="ico list"></span> 
							<c:choose>
								<c:when test="${param.sale_status == 'ING'}">
									<a href="#">
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:when>
								<c:when test="${param.sale_status == 'END'}">
									<a href="#">
										<span ng-if="locale != 'en'">목록</span>
										<span ng-if="locale == 'en'">List</span>
									</a>
								</c:when>
								<c:otherwise>
									<a href="<%--뒤로가야함--%>"> 
										<span ng-if="locale != 'en'" onclick = "history.go(-1); return false;">목록</span>
										<span ng-if="locale == 'en'" onclick = "history.go(-1); return false;">List</span>
									</a>
								</c:otherwise> 
							</c:choose>					
						</span>
						<c:if test="${param.view_type == 'LIST' or param.view_type == 'GRID'}">			
							<span class="btn_style01 white02 icon btn_prev mbtn">
								<span class="ico prev"></span>
								<a href="#">
									<span ng-if="locale != 'en'">이전</span>
									<span ng-if="locale == 'en'">Prev</span>
								</a>
							</span>
							<span class="btn_style01 white02 icon02 btn_next mbtn"> 
								<span class="ico next"></span> 
								<a href="#"> 
									<span ng-if="locale != 'en'">다음</span>
									<span ng-if="locale == 'en'">Next</span>
								</a>
							</span>
						</c:if>
						<span class="btn_style01 icon02 btn_scrolltop mbtn">
							<button type="button"> 
								<span ng-if="locale != 'en'">위로</span> 
								<span ng-if="locale == 'en'">Up</span>
							</button> 
							<span class="ico up"></span>
						</span>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>  
</div>  
<!-- //#wrap -->
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />