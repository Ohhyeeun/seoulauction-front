<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../include/header.jsp" flush="false"/>
<link href="<c:url value="/css/sa.common.2.1.css" />" rel="stylesheet">
<link href="/css/jquery.bxslider.min.css" rel="stylesheet">           
<link href="/css/main_bxslider.css" rel="stylesheet">
<%-- YDH 추가 시작--%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript" src="/js/angular/paging.js"></script>
<script type="text/javascript" src="/js/jquery.bxslider.js"></script> 

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
					{"actionID":"get_academy_now_count", "actionType":"select" , "tableName": "ACADEMY_LIST_NOW_CNT" ,"parmsList":[{"for_count":true}]}
              	
 			 ]};

 	   	$d["actionList"][1]["parmsList"][0]["from"] = (($scope.currentPage - 1) * $scope.pageRows); 

 	   common.callActionSet($d, $s);
 	   
 	   
	}
 		
 	var $s = function(data, status) { 
 		$scope.academyCnt = data["tables"]["ACADEMY_LIST_NOW_CNT"]["rows"][0]["CNT"];
 		$scope.academyList = data["tables"]["ACADEMY_LIST"]["rows"];
 		$scope.academyListRow = data["tables"]["ACADEMY_LIST"]["rows"][0];
 		$scope.academyNewCnt = data["tables"]["ACADEMY_LIST_NOW_CNT"]["rows"][0];
 		
 		$scope.db_now = $scope.academyListRow.DB_NOW;
 		$scope.pageRows = parseInt($scope.reqRowCnt);
 		
	};
	
	
});




</script>
    
<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap" ng-controller="academyNowListCtl" data-ng-init="loadAcademyNowList(1)">
	
		<div id="container">
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../include/serviceSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents">
					<div class="tit_h2 pd-top"> 
						<h2>아카데미</h2>
					</div>
					
					<div class="storage_cont title_area">
						<div class="line"></div>
						<div class="title"> 
							<p><spring:message code="label.academy" /></p>
							<h3><span class="txt_green">서울옥션</span> 아카데미 함께 하십시오.</h3>
						</div>
						<p style="line-height:30px; font-size:16px;">서울옥션 아카데미는 미술 뿐 만 아니라 문화, 인문학, 예술, 음악, 라이프, 생활까지 다양한 분야의 최고의 강사진들을 모시고 진행하고 있습니다.</p>
						<p style="line-height:30px; font-size:16px;">신선하고 심도 있는 프로그램을 제공함으로써 여러분들의 상상력과 열정을 불러 일으킬 것입니다.</p>   
                         
                        <div style="margin-top: 20px;">        
							<a href="https://instagram.com/seoulauction_academy" target="_blank"><span><img src="/nas_img/front/homepage/instagram_logo.jpg"> @seoulauction_academy</img></span></a>    
                        </div>     
                           
						<div class="box_gray type01">
							<div class="contact">
								<div class="title">문의 Contact</div>
								<div class="info"> 
									<div class="highlight">서울옥션 브랜드기획팀 <strong>정은지 선임</strong></div>
									<div class="tel"><strong class="tit">Tel</strong> <span>02-2075-4442</span></div>    
									<div class="email"><strong class="tit">E-mail</strong> <a href="mailto:jej@seoulauction.com">jej@seoulauction.com</a></div> 
								</div>
							</div>
							<div class="right"> 
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">1대1 문의</a><span class="ico next02"></span></span>
							</div>
						</div>
					</div> 

					<!-- 20150521 -->
					<div class="web_only">
						<div class="sub_banner02" id="slides">
							<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
							<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>
							<div><img src="/images/img/aca_banner01.jpg" alt="아카데미" /></div>
							<div><img src="/images/img/aca_banner02.jpg" alt="아카데미" /></div> 
							<div><img src="/images/img/aca_banner03.jpg" alt="아카데미" /></div>
	                        <div><img src="/images/img/aca_banner04.jpg" alt="아카데미" /></div> 
	                        <div><img src="/images/img/aca_banner05.jpg" alt="아카데미" /></div>   
						</div>
					</div>
					
					<div class="m_only"> 
		            	<div class="sub_slide">
							<div class="bxslider">  
			            		<div class="sub_banner02">   
					                <div><img src="/images/img/aca_banner01.jpg" alt="아카데미" /></div>
					            </div>
					            <div class="sub_banner02"> 
					            	<div><img src="/images/img/aca_banner02.jpg" alt="아카데미" /></div>
					            </div>
					            <div class="sub_banner02"> 
					            	<div><img src="/images/img/aca_banner03.jpg" alt="아카데미" /></div>
					            </div>
					            <div class="sub_banner02"> 
					            	<div><img src="/images/img/aca_banner04.jpg" alt="아카데미" /></div>
					            </div>
					            <div class="sub_banner02"> 
					            	<div><img src="/images/img/aca_banner05.jpg" alt="아카데미" /></div>
					            </div>  
			            	</div> 
		                </div>
		            </div><!--//m_only --> 
					<!-- //20150521 -->
                     
					<!-- 아카데미 메뉴 -->
			        <div class="academy_menu box_width">
				        <div class="bar-menu" id="barMenu1">
				            <ul class="menu-body"> 
				                <li><a href="/service/page?view=academyArtculture"><span ng-if="academyNewCnt.ARTCULTURE_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.artculture" /></a></li> 
				                <li><a href="/service/page?view=academyArtisttalk"><span ng-if="academyNewCnt.ARTISTTALK_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.artisttalk" /></a></li>   
				                <li><a href="/service/page?view=academyArtbrunch"><span ng-if="academyNewCnt.ARTBRUNCH_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.artbrunch" /></a></li>
								<li><a href="/service/page?view=academyArtauction"><span ng-if="academyNewCnt.ARTAUCTION_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.artauction" /></a></li> 
				                <li><a href="/service/page?view=academyCulture"><span ng-if="academyNewCnt.CULTURE_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.culture" /></a></li>
				                <li><a href="/service/page?view=academyLecture"><span ng-if="academyNewCnt.LECTURE_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.lecture" /></a></li>
				                <!--<li><a href="/service/page?view=academyArtBusan"><span ng-if="academyNewCnt.ARTBUSAN_NEW > 0"><font color="red">✔</font></span>예술소요(부산)</a></li> -->
				            </ul>
				            <div class="bar"></div>
				        </div>
				    </div>            
                    
                    <!-- 진행중인 아카데미 -->
					<div class="academy_ing_box clearcontents">  
		      			<div class="ing_academy">
		      				<span>진행중인 아카데미</span>     
		      			</div>    
		      		</div>
		      		 
			      	<div class="culture_grid_wrap clearcontents"> 
			      		<!--//내용 반복-->  
			            <div class="culture_grid_box33 clearcontents" ng-repeat="academyList in academyList" ng-if = "academyList.TO_DT.substring(0,10) > db_now">    
			                <div class="culture_box" ng-if="academyList.ACADEMY_CD == 'artculture'"> 
			                	<a href="/academyArtcultureView?academy_no={{academyList.ACADEMY_NO}}" class="culture_grid_a">    
			                        <div class="culture_img resize-img"> 
			                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}" />   
			                            <div class="culture_img_hover"> 
			                            </div> 
			                            <div class="culture_img_icon">
			                                <i class="material-icons">
			                                    loupe 
			                                </i>
			                            </div>  
			                        </div> 
			                     
			                        <div class="culture_caption">
				                            <p>
				                                {{academyList.TITLE_JSON[locale]}}
				                            </p>
				                            <div class="culture_btn_box">
				                                <a class="culture_btn" href="/academyArtcultureView?academy_no={{academyList.ACADEMY_NO}}" target="_new">상세보기</a>
				                            </div> 
				                        </div><!--//cultuer_caption-->
			                    </a> 
							</div>
							<div class="culture_box" ng-if="academyList.ACADEMY_CD == 'artisttalk'"> 
			                	<a href="/academyArtisttalkView?academy_no={{academyList.ACADEMY_NO}}" class="culture_grid_a">    
			                        <div class="culture_img resize-img">  
			                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}" />   
			                            <div class="culture_img_hover">
			                            </div> 
			                            <div class="culture_img_icon">
			                                <i class="material-icons">
			                                    loupe 
			                                </i>
			                            </div>  
			                        </div> 
			                     
			                        <div class="culture_caption">
				                            <p>
				                                {{academyList.TITLE_JSON[locale]}}
				                            </p>
				                            <div class="culture_btn_box">
				                                <a class="culture_btn" href="/academyArtisttalkView?academy_no={{academyList.ACADEMY_NO}}" target="_new">상세보기</a>
				                            </div> 
				                        </div><!--//cultuer_caption-->
			                    </a> 
							</div> 
							
							<div class="culture_box" ng-if="academyList.ACADEMY_CD == 'artbrunch'"> 
			                	<a href="/academyArtbrunchView?academy_no={{academyList.ACADEMY_NO}}" class="culture_grid_a">    
			                        <div class="culture_img resize-img">  
			                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}" />   
			                            <div class="culture_img_hover">
			                            </div> 
			                            <div class="culture_img_icon">
			                                <i class="material-icons">
			                                    loupe 
			                                </i>
			                            </div>  
			                        </div> 
			                     
			                        <div class="culture_caption">
				                            <p>
				                                {{academyList.TITLE_JSON[locale]}}
				                            </p>
				                            <div class="culture_btn_box">
				                                <a class="culture_btn" href="/academyArtbrunchView?academy_no={{academyList.ACADEMY_NO}}" target="_new">상세보기</a>
				                            </div> 
				                        </div><!--//cultuer_caption-->
			                    </a> 
							</div> 
							
							<div class="culture_box" ng-if="academyList.ACADEMY_CD == 'artauction'"> 
			                	<a href="/academyArtauctionView?academy_no={{academyList.ACADEMY_NO}}" class="culture_grid_a">    
			                        <div class="culture_img resize-img">  
			                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}" />   
			                            <div class="culture_img_hover">
			                            </div> 
			                            <div class="culture_img_icon">
			                                <i class="material-icons">
			                                    loupe 
			                                </i>
			                            </div>  
			                        </div> 
			                     
			                        <div class="culture_caption">
				                            <p>
				                                {{academyList.TITLE_JSON[locale]}}
				                            </p>
				                            <div class="culture_btn_box">
				                                <a class="culture_btn" href="/academyArtauctionView?academy_no={{academyList.ACADEMY_NO}}" target="_new">상세보기</a>
				                            </div> 
				                        </div><!--//cultuer_caption-->
			                    </a> 
							</div> 
							
							<div class="culture_box" ng-if="academyList.ACADEMY_CD == 'culture'"> 
			                	<a href="/academyCultureView?academy_no={{academyList.ACADEMY_NO}}" class="culture_grid_a">    
			                        <div class="culture_img resize-img">  
			                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}" />   
			                            <div class="culture_img_hover">
			                            </div> 
			                            <div class="culture_img_icon">
			                                <i class="material-icons">
			                                    loupe 
			                                </i>
			                            </div>  
			                        </div> 
			                     
			                        <div class="culture_caption">
				                            <p>
				                                {{academyList.TITLE_JSON[locale]}}
				                            </p>
				                            <div class="culture_btn_box">
				                                <a class="culture_btn" href="/academyCultureView?academy_no={{academyList.ACADEMY_NO}}" target="_new">상세보기</a>
				                            </div> 
				                        </div><!--//cultuer_caption-->
			                    </a> 
							</div> 
							
							<div class="culture_box" ng-if="academyList.ACADEMY_CD == 'lecture'"> 
			                	<a href="/academyLectureView?academy_no={{academyList.ACADEMY_NO}}" class="culture_grid_a">    
			                        <div class="culture_img resize-img">  
			                            <img ng-src="<spring:eval expression="@configure['img.root.path']" />{{academyList.IMG_PATH}}/{{academyList.FILE_NAME}}" />   
			                            <div class="culture_img_hover">
			                            </div> 
			                            <div class="culture_img_icon">
			                                <i class="material-icons">
			                                    loupe 
			                                </i>
			                            </div>  
			                        </div> 
			                     
			                        <div class="culture_caption">
				                            <p>
				                                {{academyList.TITLE_JSON[locale]}}
				                            </p>
				                            <div class="culture_btn_box">
				                                <a class="culture_btn" href="/academyLectureView?academy_no={{academyList.ACADEMY_NO}}" target="_new">상세보기</a>
				                            </div> 
				                        </div><!--//cultuer_caption-->
			                    </a> 
							</div> 
			            </div><!--culture_grid_box--> 
			    	</div> <!-- //culture_grid_wrap -->    
			    	
				</div><!-- //contents -->
			</div><!-- //contents_wrap --> 
		</div>
	</div>
	<!-- 20150521 -->
	<script>  
		/* m_only banner slider */
		$(".sub_slide .bxslider").bxSlider({        
			auto:true,   
			autoControls: true,  
			pause: 4000,        
			/* stopAutoOnClick:true, */    
		});  
	</script>
	
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