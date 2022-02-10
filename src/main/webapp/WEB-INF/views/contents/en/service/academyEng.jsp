<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>
<link href="<c:url value="/resources/css/sa.common.2.1.css?${resources.timestamp}" />" rel="stylesheet">
<link href="/resources/css/jquery.bxslider.min.css" rel="stylesheet">           
<link href="/resources/css/main_bxslider.css" rel="stylesheet">
<%-- YDH 추가 시작--%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="/resources/js/angular/paging.js?${resources.timestamp}"></script>
<script type="text/javascript" src="/resources/js/jquery.bxslider.js"></script> 

<!------------- 아카데미 메뉴 js ----------->
    <script>

    (function($) {
        $.fn.barMenu = function() {
        this.each(function(index) {
        var barMenu = new BarMenu(this);
        $(this).data('barMenu', barMenu);
    });
    return this;
    };


    $.fn.selectBarMenuAt = function(selectedIndex, animation) {
        this.each(function(index) {
        var barMenu = $(this).data('barMenu');
        if (barMenu) {
        barMenu.setSelectMenuItemAt(selectedIndex, animation);
    }
    });
        return this;
    };

    }(jQuery));


    $(function() {
        var $barMenu = $('.bar-menu').barMenu();
        $barMenu.on('', function(e) {
        var oldIndex = -1;
        if (e.$oldItem) {
        oldIndex = e.$oldItem.index();
    }

    console.log('old = ' + oldIndex + ', new = ' + e.$newItem.index());
    });

    // #barMenu1의 1번째 메뉴 아이템 선택 처리
    $barMenu.eq(0).selectBarMenuAt(0, false);

    // #barMenu1의 4번째 메뉴 아이템 선택 처리
    $barMenu.eq(1).selectBarMenuAt(4, false);

    });

    /**
    * --------------------------
    * 생성자(클래스) 정의
    * --------------------------
    **/

    function BarMenu(selector) {
    // 프로퍼티 생성
        this.$barMenu = null;
        this._$menuBody = null;
        this._$menuItems = null;
        this._$overItem = null;
        this._$bar = null;

    // 선택 메뉴 아이템
        this.$selectItem = null;

        this._init(selector);
        this._initEvent();
        }

        BarMenu.prototype = {
        "_init": function(selector) {
        this.$barMenu = $(selector);
        this._$menuBody = this.$barMenu.find('.menu-body');
        this._$menuItems = this._$menuBody.find('li');
        this._$bar = this.$barMenu.find('.bar');
    },

    "_initEvent": function() {
        var _self = this;
        this._$menuItems.on('mouseenter click', function(e) {
        var $this = $(this);
        if (e.type == 'mouseenter') {
        _self._setOverMenuItem($this);
        } else if (e.type == 'click') {
        _self.setSelectMenuItem($this);
    }
    });

    this.$barMenu.on('mouseleave', function() {
        var $this = $(this);
        _self._removeOverItem($this);
        _self._reSelectMenuItem();
    });
    },

    "_setOverMenuItem": function($item) {
        if (this._$overItem) {
        this._$overItem.removeClass('over');
    }
        var selectIndex = -1;
        if (this.$selectItem != null) {
        selectIndex = this.$selectItem.index();
    }
    if ($item.index() != selectIndex) {
        this._$overItem = $item;
        this._$overItem.addClass('over');
    } else {
        this._$overItem = null;
    }
        this._moveBar($item);
    },

    "_removeOverItem": function() {
        if (this._$overItem) {
        this._$overItem.removeClass('over');
    }
        this._$overItem = null;
        this._moveBar(null);
    },

    // 이동 메뉴 효과
    "_moveBar": function($item, animation) {
        var left = -100,
        width = 0;

        if ($item != null) {
        left = $item.position(true).left + parseInt($item.css('margin-left'));
        width = $item.outerWidth();
    }

    if (animation == false) {
    // 애니메이션 없이 바로 이동
        this._$bar.css({
        'left': left,
        'width': width
    })
    } else {
    // 애니메이션 이동
        this._$bar
        .stop()
        .animate({
        'left': left,
        'width': width
    }, 300)
    }
    },

    // 선택(클릭) 메뉴 아이템 처리
    'setSelectMenuItem': function($item, aniamtion) {
        var $oldItem = this.$selectItem;

    // 기존에 선택한 메뉴가 있는 경우 처리
    if (this.$selectItem) {
        this.$selectItem.removeClass('select');
    }

        this.$selectItem = $item;
        this.$selectItem.addClass('select');

    // 메뉴바 이동
        this._moveBar($item, aniamtion);


        this._dispatchSelectEvent($oldItem, $item);
    },

    // 기존 선택한 메뉴아이템이 있는 경우 선택 처리
    "_reSelectMenuItem": function() {
    if (this.$selectItem) {
        this._moveBar(this.$selectItem);
    }
    },

    // 메뉴아이템이 선택된 상태에서 시작하도록 설정하는 경우
    'setSelectMenuItemAt': function(index, animation) {
        var target = this._$menuItems.eq(index);
        this.setSelectMenuItem(target, animation);
    },

    "_dispatchSelectEvent": function($oldItem, $newItem) {
        var customEvent = jQuery.Event('');
        customEvent.$oldItem = $oldItem;
        customEvent.$newItem = $newItem;
        this.$barMenu.trigger(customEvent);
    }

    };
    </script>
    
    <script>

app.requires.push("bw.paging");

app.controller('academyNowListCtl', function($scope, consts, common, is_login ) {
	$scope.pageRows = 10; 
	$scope.reqRowCnt = 10;
	$scope.currentPage = 1;
	$scope.academyCnt = 0;
	$scope.is_login = is_login;
	$scope.db_now = null;
	
 	$scope.loadAcademyNowList = function($page){
 		$scope.currentPage = $page;
 		$scope.parmsList1 = [];

 		$d = {"baseParms":{},
 				"actionList":[
 					{"actionID":"get_academy_now_list", "actionType":"select" , "tableName": "ACADEMY_LIST" ,"parmsList":[{"from":0, "rows":parseInt($scope.reqRowCnt)}]},
					{"actionID":"get_academy_now_count", "actionType":"select" , "tableName": "ACADEMY_LIST_CNT" ,"parmsList":[{"for_count":true}]}              	
 			 ]};

 	   	$d["actionList"][1]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 

 	   common.callActionSet($d, $s);
 	   
 	   
	}
 		
 	var $s = function(data, status) { 
 		$scope.academyCnt = data["tables"]["ACADEMY_LIST_CNT"]["rows"][0]["CNT"];
 		$scope.academyList = data["tables"]["ACADEMY_LIST"]["rows"];
 		$scope.academyListRow = data["tables"]["ACADEMY_LIST"]["rows"][0];
 		$scope.academyNewCnt = data["tables"]["ACADEMY_LIST_NOW_CNT"]["rows"][0];
 		
 		
 		$scope.db_now = $scope.academyListRow.DB_NOW;
 		$scope.pageRows = parseInt($scope.reqRowCnt);
 		
	};
	
	
});




</script>
    
    
<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap" ng-controller="academyNowListCtl" data-ng-init="loadAcademyNowList(1)">
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../../include/serviceSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2">  
						<h2>Academy</h2> 
					</div>
					

					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="title">
							<p>Academy</p>
							<h3><span class="txt_green">서울옥션</span> 아카데미 함께 하십시오.</h3>
						</div>
						<p style="line-height:30px; font-size:16px;">Seoul Auction Academy offers the program with the best lectures in various fields such as culture, humanities, music and life style</p>
						<p style="line-height:30px; font-size:16px;"> as well as art. It will make you arouse imagination and passion by offering fresh and in depth programs.</p>
						
						<div class="box_gray type01">
							<div class="contact">
								<div class="title">Contact</div>
								<div class="info">
									<div class="highlight">Seoul Auction Academy <strong>Jung Eunji</strong></div> 
									<div class="tel"><strong class="tit">Tel</strong> <span>82+ (0)2-2075-4442</span></div> 
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:jej@seoulauction.com">jej@seoulauction.com</a></div>
								</div>
							</div>  
							<div class="right">
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1:1 Inquiry</a><span class="ico next02"></span></span>
							</div>
						</div>
					</div> 

					<!-- 20150521 -->
					<div class="web_only">
						<div class="sub_banner02" id="slides">
							<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
							<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
							<div><img src="/images/img/aca_banner01.jpg" alt="academy" /></div>
							<div><img src="/images/img/aca_banner02.jpg" alt="academy" /></div>
							<div><img src="/images/img/aca_banner03.jpg" alt="academy" /></div>
	                        <div><img src="/images/img/aca_banner04.jpg" alt="academy" /></div> 
	                        <div><img src="/images/img/aca_banner05.jpg" alt="academy" /></div>  
						</div>
					</div>
					<div class="m_only">
		            	<div class="sub_slide">
							<div class="bxslider">  
			            		<div class="sub_banner02">   
					                <div><img src="/images/img/aca_banner01.jpg" alt="academy" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/aca_banner02.jpg" alt="academy" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/aca_banner03.jpg" alt="academy" /></div>
					            </div>
					            <div class="sub_banner02">   
					                <div><img src="/images/img/aca_banner04.jpg" alt="academy" /></div>
					            </div>
					            <div class="sub_banner02">    
					                <div><img src="/images/img/aca_banner05.jpg" alt="academy" /></div>
					            </div>
			            	</div> 
		                </div>
		            </div><!--//m_only -->
					<!-- //20150521 -->



<!------------------------------- 아카데미 메뉴 -------------------------------->

					
          <div class="academy_menu box_width">
        <div class="bar-menu" id="barMenu1">
            <ul class="menu-body">
                <li><a href="/service/page?view=academyCulture">AMOUR CULTURE</a></li>
                <li><a href="/service/page?view=academyArtauction">ART & AUCTION</a></li>
                <li><a href="/service/page?view=academyLecture">Special Lecture</a></li>
                <li><a href="/service/page?view=academyArtbrunch">ART & Brunch</a></li>
                <li><a href="/service/page?view=academyArtculture">ART & CULTURE</a></li>
                <li><a href="/service/page?view=academyArtBusan">Art Busan</a></li>
                <li><a href="/service/page?view=academyArtisttalk">Artist Talk</a></li>
            </ul>
            <div class="bar"></div>
        </div>
    </div>  
    
    

	<!------------------------------- 진행중인 아카데미 -------------------------------->
                 
                   <div class="academy_wrap box_width">
                      <div class="ing_academy">현재 진행중인 아카데미</div>
                          <div class="academy_topbar box_width"></div>
                              <div class="academy_box box_width" ng-if = "academyList.TO_DT.substring(0,10) > db_now" ng-repeat="academyList in academyList"> 
                                  <ul class="academy_list" >
                                      <li class="academy_img">
                                      <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}" />
											</li>
                                      <li><span class="hh1" ng-if="academyList.ACADEMY_CD == 'culture'">문화예찬</span>
                                      <span class="hh1" ng-if="academyList.ACADEMY_CD == 'artauction'">대학생 아카데미</span>
                                      <span class="hh1" ng-if="academyList.ACADEMY_CD == 'lecture'">특강</span>
                                      <span class="hh1" ng-if="academyList.ACADEMY_CD == 'artbrunch'">아트앤브런치</span>
                                      <span class="hh1" ng-if="academyList.ACADEMY_CD == 'artculture'">가나 문화 포럼</span>
                                      <span class="hh1" ng-if="academyList.ACADEMY_CD == 'artbusan'">예술소요(부산)</span>
                                      <span class="hh1" ng-if="academyList.ACADEMY_CD == 'artisttalk'">작가와의 대화</span><br />
                                      {{academyList.TITLE_JSON[locale]}}<br> 
                                      {{academyList.FROM_DT}} ~ {{academyList.TO_DT}}<br>	
                                      {{academyList.ACADEMY_TIME}} <br>
                                      </li>
                                  <li class="detail_box" ng-if="academyList.ACADEMY_CD == 'culture'"><a href="/academyCultureView?academy_no={{academyList.ACADEMY_NO}}">상세보기</a></li>
                                  <li class="detail_box" ng-if="academyList.ACADEMY_CD == 'artauction'"><a href="/academyArtauction?academy_no={{academyList.ACADEMY_NO}}">상세보기</a></li>
                                  <li class="detail_box" ng-if="academyList.ACADEMY_CD == 'lecture'"><a href="/academyLecture?academy_no={{academyList.ACADEMY_NO}}">상세보기</a></li>
                                  <li class="detail_box" ng-if="academyList.ACADEMY_CD == 'artbrunch'"><a href="/academyArtbrunch?academy_no={{academyList.ACADEMY_NO}}">상세보기</a></li>
                                  <li class="detail_box" ng-if="academyList.ACADEMY_CD == 'artculture'"><a href="/academyArtcultureView?academy_no={{academyList.ACADEMY_NO}}">상세보기</a></li>
                                  <li class="detail_box" ng-if="academyList.ACADEMY_CD == 'artbusan'"><a href="/academyArtBusan?academy_no={{academyList.ACADEMY_NO}}">상세보기</a></li>
                                  <li class="detail_box" ng-if="academyList.ACADEMY_CD == 'artisttalk'"><a href="/academyArtisttalk?academy_no={{academyList.ACADEMY_NO}}">상세보기</a></li>
                                  </ul>
                              </div>
              
                   <!-- <div class="clear"></div>
                     
                           <div class="academy_box box_width">
                              <ul class="academy_list">
                                  <li class="academy_img"></li>
                                  <li><span class="hh1">대학생 아카데미</span><br />
                                  2019 ART＆AUCTION (Intensive Course) 10기<br /> 
                                  2019-07-29 ~ 2019-08-09	<br />
                                  오전 10시 - 12시 / 오후 1시 - 3시 <br>
                                  </li>
                              <li class="detail_box"><a href="#">상세보기</a></li>
                              </ul>
                          </div>
                     
                  <div class="clear"></div>
                     
                          <div class="academy_box box_width bar_none">리스트 추가시 bar_none 지우고 추가한 맨 마지막 리스트에 bar_none 추가하기-
                              <ul class="academy_list">
                                  <li class="academy_img"></li>
                                  <li><span class="hh1">가나문화포럼</span><br />
                                          가나문화포럼 29기 <br>
                                          2019-09-19 ~ 2019-11-28	<br>
                                          매주 목요일 오전 7~9시
                                  </li>
                                  <li class="detail_box"><a href="#">상세보기</a></li>
                              </ul>
                          </div>   -->
                      </div><!-- //academy_wrap ---->
        
					
				</div><!-- //contents -->
			</div><!-- //contents_wrap -->

		</div>
	</div>
	<!-- 20150521 --> 
	<script>
		$(".sub_slide .bxslider").bxSlider({        
			auto:true,   
			autoControls: true,  
			pause: 4000,        
			/* stopAutoOnClick:true, */    
		});  
	</script>
	<script>
		/* web banner slider */
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
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />