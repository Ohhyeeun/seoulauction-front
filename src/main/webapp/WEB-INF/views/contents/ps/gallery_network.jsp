<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<link href="/css/angular/rzslider.css" rel="stylesheet">
<link href="/css/angular/ngDialog.css" rel="stylesheet">
<link href="/css/angular/popup.css" rel="stylesheet">
<script type="text/javascript" src="/js/angular/paging.js"></script>
<script type="text/javascript" src="/js/angular/rzslider.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-duration-format/1.3.0/moment-duration-format.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ng-dialog/0.5.6/js/ngDialog.min.js"></script>



<script>

	app.value('locale', 'ko');
	app.requires.push("bw.paging");
	app.controller('glListCtl', function($scope, consts, common) {

		$scope.loadGaList = function($page) {
			$scope.currentPage = $page;
		$d = {
				"baseParms" : {	"AS_SALE_NO" : $scope.artist },
				"actionList" : [ 
					{"actionID" : "galleray_network","actionType" : "select","tableName" : "GALLERY_NT","parmsList":[]}, 
					{"actionID":"get_customer_by_cust_no", "actionType":"select" , "tableName": "CUST_INFO" ,"parmsList":[]}
			]};

			common.callActionSet($d, $s);
		}

		var $s = function(data, status) {
			$scope.gaList = data["tables"]["GALLERY_NT"]["rows"];
			$scope.custInfo = data["tables"]["CUST_INFO"]["rows"][0];
			console.log($scope.asList);
		};
	});
</script>



<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container" ng-controller="glListCtl" data-ng-init="loadGaList(1)">
			<div class="sub_menu_wrap menu02">
				<div class="sub_menu">
					<jsp:include page="../include/PS_Submenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="gn_tit_box">   
						<h2>SA 갤러리 네트워크</h2>       
					</div> 
					<div class="storage_cont title_area artcon_wrapbox">
						<div class="line line_mar" style="border:none;"></div> 
					<!-- <div class="storage_cont title_area">
						<div class="line"></div> --> 
						<div class="storage_cont corp storage_cont_marnon">      
							<!-- <div class="title">
								<h3><span class="txt_green">당신의 작품</span>을 가장 글로벌하고 가치 있게 보여 드립니다. </h3>
							</div>
							<div class="title">
								<h3>서울옥션 <span class="txt_green">프라이빗 세일</span>의 전문성</h3>
							</div> --> 
							<div class="contents_box_wrap">    
								<p>
									<span class="txt_green"><span class="font-big">서</span>울옥션</span>은 위기의 순간에 우리가 함께 모이면 어떨까 하는 생각에서 ＜갤러리 네트워크＞ 온라인 비즈니스를 제안합니다. 신뢰할 수 있는 파트너들에게 플랫폼과 회원수를 확보하고 있는 서울옥션 홈페이지를 활용한 협업을 제안합니다.
								</p>  
	                        </div>  
	                        <div class="ps_gallery_sumimg_wrap">     
	                        	<div class="ps_gallery_sumimg_tit"> 
		                        	<h2>Galleries</h2>   
		                        	<div class="ps_gallery_sumimg_titbar"></div>   
	                        	</div>
		                        	<!-- <div class="ps_gallery_sumimg_wrap"> 
		                        		<ul>  
		                        			<li class="ps_gallery_sumimg_box">   
			                        			<a href="#"> 
			                        				<img src="https://www.seoulauction.com/nas_img/front/plan0563/list/85f98956-8cd9-4ada-a383-e5f8df7a73fc.jpg">
			                        				<div class="ps_gallery_sumimg">The Gallery Staff 3</div>      
			                        			</a> 
		                        			</li>
		                        		</ul>  
	                        		</div> --> 
	                        		<div class="ps_gallery_sumimg_wrap"> 
		                        		<div class="ps_gallery_sumimg_box" ng-repeat="gaList in gaList">    
		                        			<div class="ps_gallery_sumimg_resize" >   
			                        			<a href="{{gaList.GALLERY_URL_BLOB_EN}}"> 
			                        				<img src="https://www.seoulauction.com/nas_img/{{gaList.FILE_PATH}}/{{gaList.FILE_NAME}}">
			                        				<div class="ps_gallery_sumimg">{{gaList.GALLERY_NAME_BLOB_EN}}</div>
			                        			</a> 
		                        			</div>
		                        		</div>
	                        		</div><!-- //ps_gallery_sumimgwrap -->
		                        </div> 
							</div>
						</div>
                    <!-- <div><img src="/images/img/img_pri_banner01.jpg" alt="PRIVATE"  style="width:100%; height:auto;"/></div> -->
					<!-- 20150521 
					<div class="sub_banner02" id="slides">
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
						<div><img src="/images/img/img_corp_banner01.jpg" alt="기업미술품" /></div>
						<div><img src="/images/img/img_corp_banner01.jpg" alt="기업미술품" /></div>
						<div><img src="/images/img/img_corp_banner01.jpg" alt="기업미술품" /></div>
					</div>-->
					<!-- //20150521 -->

					
					<!-- <div class="box_gray type01">
						<div class="contact">
							<div class="title">문의 Contact</div>
							<div class="info">  
								<div class="highlight">서울옥션 파트너그룹 <strong>정선정 선임</strong></div>  
								<div class="tel"><strong class="tit">Tel</strong> <span>02-2075-4423</span></div>
                                   <div class="tel"><strong class="tit">H.P</strong> <span>010-4787-1601</span></div>
								<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:rinda@seoulauction.com">jsj@seoulauction.com</a></div>
							</div>
						</div>  
						<div class="right">
							<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1문의</a><span class="ico next02"></span></span>
						</div>
					</div><!-- //box_gray type01 -->    
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