var nSelectedPopBtn = null;
var m_bIsBenefitPopup = false;

var m_objNum = 0;

var src960 = '../images/img/img_banner_960.png';
var src768 = '../images/img/img_banner_768.png';
var src320 = '../images/img/img_banner_320.png';

$(document).ready(function(){

	var winWidth = $(window).innerWidth();
	var winHeight = $(window).height();
	var contentsWidth = $('.contents').width() + 80; //contents width
	var contHeight = $('.contents').height();
	var gapWidth = winWidth - contentsWidth;
	var gapWidthHalf = gapWidth/2;
	var gapwinHeight = winHeight - 141;//window 높이 - header 높이
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

	//20150621
	var isTablet = {
		iOS: function() {
			return navigator.userAgent.match(/iPad/i);
		}
	};

	//모달팝업
	//blockWheel();//스크롤 막기
	//팝업로드
	/*$('.btn_modal').click(function(){
		$('body').append('<div class="modal">'+'</div>');
		if($(this).hasClass('pop01')){
			$('.modal').load('/auction/bidRequest .pop_wrap', function(){

				modalpop();

				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});

				setBasicRequestInfo();
			});
		} else if($(this).hasClass('pop02')){
			if(m_bIsLogged == true) {
				$('.modal').load('/auction/bid .pop_wrap', function(){
					modalpop();
					if( isMobile.any() ){
						loaded();
						//응찰하기 팝업 모바일 cover
						$('.pop_wrap .cover .btn_style01').click(function(){
							$(this).parent().parent().parent().removeClass('m_only').hide();
						});
					} else {
						scrollAble();//응찰하기
					}
					$('.btn_pop_close').click(function() {
						if(m_bIsAutoBidding == true) {
							m_bIsAutoBidding = false;
							playWheel();
							modalClose();
							//location.reload(true);
							m_bInitBidPrice = true;
							stopBidListTimer();
							getCurrentList();
							startCurrentListTimer();
						}
						else {
							playWheel();
							modalClose();
							//location.reload(true);
							m_bInitBidPrice = true;
							stopBidListTimer();
							getCurrentList();
							startCurrentListTimer();
						}
					});

					stopCurrentListTimer();
					setBasicBidInfo();
				});
				$('.modal').addClass('modal02');
			}
			else {
				alert("로그인 후 이용하실 수 있습니다.");
				return;
			}
		} else if($(this).hasClass('pop03')){
			$('.modal').load('/auction/auctionHistory .pop_wrap', function(){
				modalpop();
				if( isMobile.any() ){
					loaded();
				} else{
					scrollAble();//경매기록보기
				}
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});

				// 경매기록보기 기본 정보 설정
				setBasicHistoryInfo();
			});
			$('.modal').addClass('modal02');

		} else if($(this).hasClass('pop04')){
			nSelectedPopBtn = $(this);
			$('.modal').load('/pop/searchAddr .pop_wrap' , function(){
				modalpop();
				if( isMobile.any() ){
					loaded();
				} else{
					scrollAble();//주소검색
					$(".selectbox").selectbox();
				}
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
				//tab
				$('.tab_wrap.type01 .tab').click(function(){
					tabClick($(this));
					return false;
				});
				// 주소검색 팝업 Enter키 관련 이벤트
				$("#holder_old").keypress(function(event) {
				    if (event.which == 13) {
				        event.preventDefault();
				        submitOldForm();
				    }
				});
				$("#holder_new_second").keypress(function(event) {
				    if (event.which == 13) {
				        event.preventDefault();
				        submitNewForm();
				    }
				});
			});
		} else if($(this).hasClass('pop05')){
			$('.modal').load('/pop/searchArtist .pop_wrap', function(){
				modalpop();
				if( isMobile.any() ){
					loaded();
				} else{
					scrollAble();//작가검색
				}
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
		} else if($(this).hasClass('pop06')){
			$('.modal').load('/myPage/paymentHistory .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
				});
				// 결제 이력 조회
				searchPaymentHistory();
			});
			$('.modal').addClass('modal02');
		} else if($(this).hasClass('pop07')){
			$('.modal').load('/myPage/changePwd .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});

				$("#newPassword").bind("input", function() {setTimeout("checkPassword()", 500)});
				$("#newPasswordCheck").bind("input", function() {setTimeout("checkPassword()", 500)});
			});
		} else if($(this).hasClass('pop08')){
			$('.modal').load('/myPage/leaveClient .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
				});
			});
		} else if($(this).hasClass('pop09')){
			$('.modal').load('/myPage/benefitPop .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
		} else if($(this).hasClass('pop10')){
			$('.modal').load('/common/auctionLive .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
			$('.modal').addClass('modal03');
		} else if($(this).hasClass('pop11')){
			$('.modal').load('/common/videoPopup .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});

				setVideoInfo();
			});
			$('.modal').addClass('modal02');
		} else if($(this).hasClass('pop12')){
			$('.modal').load('/pop/searchAccount .pop_wrap', function(){
				var bIsPassword = false;
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
					$('.btn_modal').removeClass('sele');
				});
				//tab
				$('.tab_wrap.type01 .tab').click(function(){
					tabClick($(this));
					if($(this).hasClass("tab01")) {
						$("#personName").focus();
					}
					else {
						$("#personId").focus();
					}
					return false;
				});
				//팝업의 비밀번호 찾기 버튼 클릭시 탭 sele
				$('.btn_findpw').click(function(){
					tabSele();
					return false;
				});
				//본창 비밀번호 찾기 버튼 클릭시
				if($('.btn_modal').hasClass('sele')){
					tabSele();
					bIsPassword = true;
					$("#personId").focus();
				}
				if( !isMobile.any() ){
					$(".selectbox").selectbox();
				}
				if(bIsPassword == false) {
					$("#personName").focus();
				}
			});
			$('.modal').addClass('modal02');

		} else if($(this).hasClass('pop13')){
			$('.modal').load('/auction/corporAuth .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
				if( !isMobile.any() ){
					$(".selectbox").selectbox();
				}
			});
		} else if($(this).hasClass('pop16')){  // 동영상 VOD 보기( 2015.11.16. YDH). pop14, 15번은 eng/ui.js에서 사용중임.
			$('.modal').load('/common/auctionVOD .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
			$('.modal').addClass('modal03');
		} else if($(this).hasClass('pop17')){  // 동영상 VOD 보기( 2015.11.16. YDH). pop14, 15번은 eng/ui.js에서 사용중임.
			$('.modal').load('/common/auctionVOD1 .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
			$('.modal').addClass('modal03');
		} else if($(this).hasClass('pop18')){  // 동영상 VOD 보기( 2015.11.19. YDH).
			$('.modal').load('/common/auctionVOD2 .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
			$('.modal').addClass('modal03');
		} else if($(this).hasClass('pop19')){  // 동영상 VOD 보기( 2015.11.19. YDH). 
			$('.modal').load('/common/auctionVOD3 .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
			$('.modal').addClass('modal03');
		} else if($(this).hasClass('pop20')){  // 동영상 VOD 보기( 2015.11.19. YDH).
			$('.modal').load('/common/auctionVOD4 .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
			$('.modal').addClass('modal03');
		} else if($(this).hasClass('pop21')){  // 동영상 VOD 보기( 2015.11.19. YDH). 
			$('.modal').load('/common/auctionVOD5 .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
			$('.modal').addClass('modal03');
		} else if($(this).hasClass('pop22')){  // 동영상 VOD 보기( 2015.11.19. YDH). 
			$('.modal').load('/common/auctionVOD6 .pop_wrap', function(){
				modalpop();
				$('.btn_pop_close').click(function() {
					modalClose();
					playWheel();
				});
			});
			$('.modal').addClass('modal03');
		} 

		return false;
	});*/

	//z008
	$('.btn_zoom').click(function(){
		// $('body').append("<div class='wrap_zoom' oncontextmenu='return false' ondragstart='return false'>" + "</div>");
		$('body').append("<div class='wrap_zoom'>" + "</div>");
		$('.wrap_zoom').load('/zoomImage .masterview', function(){
			$('#wrap').hide();
			//blockWheel();
			$('.btn_pop_close').click(function(){
				$(this).parent().parent().remove();
				$('#wrap').show();
			});

			$("#workDetailImage").attr("src", m_sImagePath);

//			zoomResize();
			imgZoom();
		});
	});

	//z037 비밀번호 찾기 클릭시 클릭한 곳 찾기 위함
	$('.btn_modal.bar').click(function(){
		$(this).addClass('sele');
	});


	curtainImg();//커튼배너 이미지 변경
	historyWidth();//연혁 탭 width
	scrollAble();//웹에서 iscroll 미적용
	funcContHeight();//컨텐츠 짧은 화면
	submenuWidth();//submenu width
	gnbLayerPos();
	fullImg();//리스트 이미지 전체보이기20150724

	$(window).resize(function(){
		submenuWidth();//submenu width
		subBannerTxt();//sub banner 텍스트 위치
		curtainImg();//커튼배너 이미지 변경
		historyWidth();//연혁 탭 width
		//imgResize();//이미지 리사이즈
		subBannerOverflow();//sub_banner(배경) 이미지 넘칠 경우
		gnbLayer();//gnb layer height
		funcContHeight();//컨텐츠 짧은 화면
		if( !isMobile.any() ){
			gnbLayerPos();//리사이즈시 메뉴 레이어 width 사이즈 체크
			gnbLayerClose();//gnb메뉴 레이어 닫는 동작
		}
		fullImg();//리스트 이미지 전체보이기 20150724*/
	});

	//이미지 사이즈 조절 20150521
	$(window).load(function(){
		
		//imgResize();
		subBannerTxt();
		historyWidth();//연혁 탭 width
		
		funcContHeight();//컨텐츠 짧은 화면 --> footer 이동 
		fullImg(); 
    });

	//gnb메뉴 레이어 닫는 동작
	$('.btn_gnbmenu_close').click(function(){
		gnbLayerClose();//gnb메뉴 레이어 닫는 동작
		playWheel();
	});

	//placeholder ie7, ie8
	$(function() {
		$('input, textarea').placeholder({customClass:'my-placeholder'});
	});

	//selectbox
	//$(function () {
		//$(".selectbox").selectbox();
	//});

   	/*$(window).load(function(){
   		$(".selectbox").selectbox();
   	});*/

	//input:file 20150627
	if( !isMobile.any() ) {
		$("input[type=file].nicefileinput").nicefileinput();
	}
	$("#download-link").click(function(){
		$('html, body').animate({scrollTop: $("#download").offset().top},'slow');
		return false;
	});

	//tab
	$('.tab_wrap.type01 .tab').click(function(){
		tabClick($(this));
		return false;
	});

	//radio, checkbox label disalbed
	$('input[type="checkbox"]:disabled, input[type="radio"]:disabled').parent().find('label').addClass('disabled');

	//위로, 아래로 버튼
	$('.btn_scrolltop').click(function(){
		$("html, body").stop().animate({ scrollTop: 0 }, 300);
	});

	$('.btn_scrollbot').click(function(){
		$("html, body").stop().animate({scrollTop:$(document).height()}, 500);
	});

	//리스트페이지 float top/bottom버튼
	$('.flbtn_scrollTop').click(function(){
		$("html, body").stop().animate({scrollTop: 0 }, 500);
	});

	$('.flbtn_scrollBtm').click(function(){
		$("html, body").stop().animate({scrollTop: $(".lastlot").offset().top }, 500);
	});

	//z005 중앙 위로, 아래로 버튼 클릭시 동작
	$('.btn_up').click(function(){
		btnUpDown();
	});

	//z011 경매리스트 간격
	$('.auction_list02 > ul > li:first-child, .auction_list02 > ul > li:nth-child(2)').addClass('first');
	$('.auction_list02 li:nth-child(even)').addClass('even');


	//공지사항 테이블 a hover시 tr bg z034
	$('.tbl_style02.type02 td a').not('.tbl_style02.type02 .notice td a').hover(function(){
		$(this).parent().parent().addClass('bg');
	}, function(){
		$(this).parent().parent().removeClass('bg');
	});

	//faq show/hide z036
	$('.faq_list .question a').click(function(){
		if($(this).parent().hasClass('sele')){
			$(this).parent().removeClass('sele');
			$(this).parent().parent().find('.answer').hide();
		} else {
			$('.faq_list .question').removeClass('sele');
			$('.faq_list .answer').hide();
			$(this).parent().addClass('sele');
			$(this).parent().parent().find('.answer').show();
		}
		return false;
	});

	//z007 전체펼쳐보기
	$('.btn_view_all').click(function(){
		if($(this).hasClass('close')){
			$(this).removeClass('close');
			$('.hidden_area').hide();
			$(this).find('span').html('전체펼쳐보기');
		} else {
			$(this).addClass('close');
			$('.hidden_area').show();
			$(this).find('span').html('펼침닫기');
			fullImg();
		}
	});

	//z066 비디오 리스트 6n+1번째 왼쪽 여백
	$(function(){
		var exSearchList = $('.ex_list_area.search ul li');
		if(winWidth > 1039){
			exSearchList.removeClass('left_space');
			$('.ex_list_area.search ul li:nth-child(6n+1)').addClass('left_space');
		} else if(winWidth > 767 && winWidth < 1038){
			exSearchList.removeClass('left_space');
			$('.ex_list_area.search ul li:nth-child(3n+1)').addClass('left_space');
		} else {
			exSearchList.removeClass('left_space');
		}
	});

	//커튼배너 닫기
	$('.btn_curtain_close').click(function(){
		$('.curtain_wrapper').animate({
			marginTop : -102 + "px"
		}, 200, function(){
			$('.curtain_wrapper').hide();
		});

		setTimeout(function(){
			var winWidth = $(window).width();
			submenuWidth();
			$('.slidesjs-container, .slidesjs-control').css('width', winWidth + 'px');

		}, 500);
	});

	//서브메뉴 그림자 부분 추가
	$('.sub_menu_wrap').before('<div class="submenu_shadow">'+'</div>');

	$('.sub_menu_wrap.menu04 .sub_menu ul li:last-child').addClass('full');//20150627

	//모바일 기기
	if( isMobile.any() ) {
		loaded();//iscroll 작동
		investHide();//20150621
		//$('select').removeClass('selectbox');//모바일에서 셀렉트박스 디자인 클래스 삭제
		$('.map_area .btn_wrap').hide();
		$('table').css('table-layout', 'auto');
		if($('body').hasClass('main')){
			$(document).bind('touchmove', function(e) {
				e.preventDefault();
			});
		}

		$('.sub_menu_wrap.menu04 .sub_menu ul li:last-child').removeClass('full');//20150627

		//sub_menu_layer 열려있을 때 배경클릭시 닫기
		/*$(document).bind('touchend', function(e){
			var gnbMenuLayer = $('.gnb_menu_layer');
			if(gnbMenuLayer.has(e.target).length === 0){
				gnbLayerClose();
			}
		});*/
		$('.bg_modal02').click(function(){
			gnbLayerClose();
		});

		//20150621
		if( !isTablet.iOS() ){
			//모바일에서 메뉴 iscroll
			var mScrollableHeight = winHeight - 55;
			$('.m_scrollable').css('height', mScrollableHeight + 'px');

			//gnb iscroll 적용 클래스 부여
			$(function(){
				$('.m_scrollable').addClass('scrollable').children().addClass('scroller');
				loaded();
			});
		}
	}

	//반응형 script
	//767 이하 사이즈
	$(function() {
		if(winWidth <= 767){

			//////////gnb 관련 시작!//////////
			//gnb 클릭시 submenu show
			gnbLayer();//gnb layer height
			$('#header > .gnb_menu > ul > li').click(function(){
				if($(this).parent().hasClass('open')){

				} else {
					//검색영역 열려있으면 닫기
					mSearch.animate({
						marginTop : -50 + "px"
					}, 200, function(){
						mSearch.removeClass('on');
					});
					$(this).parent().addClass('open');
					$('.gnb_menu_layer').css({'overflow':'visible', 'display':'block'});
					$('.gnb_menu_layer').animate({
						left: "0px"/*,
						width: "80%"*/
					}, 200, function(){
						$('.container_wrap').append('<div class="bg_modal02">'+'</div>');
						$('	.gnb_menu > ul').removeClass('open');
					});
					if( isMobile.any() ) {
						blockWheel();
						loaded();
					}
				}
				return false;
			});

			//sub_menu_layer 열려있을 때 배경클릭시 닫기
			$(document).bind('click', function(e){
				var gnbMenuLayer = $('.gnb_menu_layer');
				if(gnbMenuLayer.has(e.target).length === 0){
					gnbLayerClose();
				}
			});

			//gnb 레이어 클릭시 스타일
			var gnbLayerMenu = $('.gnb_menu_layer .gnb_menu > ul > li > ul > li');
			gnbLayerMenu.click(function(){
				gnbLayerMenu.removeClass('sele');
				$(this).addClass('sele');
			});
			//////////gnb 관련 끝!//////////

			//모바일 헤더
			var mSearch = $('.m_search');
			$('.top_search .m_btn_search').click(function(){//20150623
				if($(this).hasClass('on')){
					mSearch.animate({
						marginTop : -50 + "px"
					}, 200, function(){
						mSearch.removeClass('on');
					});
					$(this).removeClass('on');
				} else {
					$(this).addClass('on');
					mSearch.animate({
						marginTop : 0
					}, 200, function(){
						mSearch.addClass('on');
					});
				}
			});

			$(document).click(function(e){
				if(mSearch.hasClass('on') && mSearch.has(e.target).length === 0){
					mSearch.animate({
						marginTop : -50 + "px"
					}, 200, function(){
						mSearch.removeClass('on');
					});
					mSearch.removeClass('on');
				}
			});


		} else {//web 768 이상

			//서브메뉴 bg
			submenuWidth();

			//gnb 클릭시 submenu show
			$('#header > .gnb_menu > ul > li').click(function(){
				if($(this).parent().hasClass('open')){

				} else {
					$(this).parent().addClass('open');
					$('.gnb_menu_layer').css({'overflow':'visible', 'display':'block'});
					$('.gnb_menu_layer').animate({
						left: "0px"
					}, 200, function(){
						$('.container_wrap').append('<div class="bg_modal02">'+'</div>');
					});
					//blockWheel();
				}
				return false;
			});

			//sub_menu_layer 열려있을 때 배경클릭시 닫기
			$(document).click(function(e){
				var gnbMenuLayer = $('.gnb_menu_layer');
				if(gnbMenuLayer.has(e.target).length === 0){
					gnbLayerClose();
				}
			});

			//gnb 메뉴 hover시 동작
			$('.gnb_menu_layer .gnb_menu > ul > li > ul > li').hover(function(){
				$(this).addClass('sele');
			}, function(){
				$(this).removeClass('sele');
			});

			$(document).scroll(function(){
				//gnbLayerClose();//gnb메뉴 레이어 닫는 동작
				btnDownFunc();//btn_up 클릭 동작
				gnbLayer();//gnb layer height
				submenuWidth();//20150701
				subBannerOverflow();//20150709
				fullImg();
			});

			//연혁 sticky
			sGnbScroll();

			//sub_banner(배경) 이미지 넘칠 경우
			subBannerOverflow();

			//gnb layer height
			gnbLayer();

		}//웹

	});

	//tablet 사이즈
	$(function() {
		if(winWidth <= 1024 && winWidth >= 768){//tablet 20150518 767->768 로 바꿈

			//서브메뉴 그림자 부분 추가
			//$('.sub_menu_wrap').before('<div class="submenu_shadow">'+'</div>');

			$(document).scroll(function(){
				btnDownFunc();//btn_up 클릭 동작
				fullImg(); 
			});

			//$('.scrollable').removeClass('web');

			//태블릿 검색영역 
			/*var mSearch = $('.m_search');
			$('.top_search .m_btn_search, .btn_search_close').click(function(){//20150623
				if(mSearch.hasClass('on')){
					mSearch.animate({
						marginTop : -100 + "px"
					}, 200, function(){
						mSearch.removeClass('on');
					});
					mSearch.removeClass('on');
				} else {
					mSearch.animate({
						marginTop : 0
					}, 200, function(){
						mSearch.addClass('on');
					});
				}
			});

			$(document).click(function(e){
				if(mSearch.hasClass('on') && mSearch.has(e.target).length === 0){
					mSearch.animate({
						marginTop : -100 + "px"
					}, 200, function(){
						mSearch.removeClass('on');
					});
					mSearch.removeClass('on');
				}
			});*/
		}
	});
	
	//모바일 메뉴 1200px 시작으로  1024->1200으로 변경  
	$(function() {  
		if(winWidth <= 1200 && winWidth >= 768){

			//$('.scrollable').removeClass('web');

			//태블릿 검색영역  
			var mSearch = $('.m_search');
			$('.top_search .m_btn_search, .btn_search_close').click(function(){//20150623
				if(mSearch.hasClass('on')){
					mSearch.animate({
						marginTop : -100 + "px"
					}, 200, function(){
						mSearch.removeClass('on');  
					});
					mSearch.removeClass('on');
				} else {
					mSearch.animate({
						marginTop : 0
					}, 200, function(){
						mSearch.addClass('on');
					});
				}
			});

			$(document).click(function(e){
				if(mSearch.hasClass('on') && mSearch.has(e.target).length === 0){
					mSearch.animate({
						marginTop : -100 + "px"
					}, 200, function(){
						mSearch.removeClass('on');
					});
					mSearch.removeClass('on');
				}
			});
		}
	});

	//767 이하에서만 필요
	//모바일 서브메뉴
	var subMenuSele = $('.sub_menu > ul > li.sele');

	$(function(){
		if(subMenuSele.has('.sub_menu02')){
			if($(this).children('.sub_menu02').hasClass('m_hide')){
				subMenuSele.parent().parent().removeClass('open');
			} else {
				subMenuSele.parent().parent().addClass('open');
			}
		} else {
			subMenuSele.parent().parent().removeClass('open');
		}
	});

	//서브메뉴 버튼 클릭
	$('.btn_submenu').click(function(){
		if($(this).hasClass('open')){
			$(this).removeClass('open');
			$(this).prev().slideUp();
			$('.slidesjs-container, .slidesjs-control').css('width', winWidth + 'px');

		} else {
			$(this).addClass('open');
			var subMenu02 = $(this).prev().find('li').has('.sub_menu02');
			var subMenuHide = $(this).prev().find('li').has('.m_hide');
			//alert(subMenuHide.length);
			if(subMenuHide.hasClass('sele')){
				$(this).prev().css('padding-bottom', '0');
			} else if(winWidth < 420 && subMenu02.hasClass('past')){
				$(this).prev().css('padding-bottom', '78px');
			} else if(subMenu02.hasClass('sele')){
				$(this).prev().css('padding-bottom', '38px');
			} else {
				$(this).prev().css('padding-bottom', '0');
			}
			$(this).prev().slideDown();
			$('.slidesjs-container, .slidesjs-control').css('width', winWidth + 'px');

		}
	});

	if($(window).width() < 590){
		var nLengthOfList = 0;
		$(".img_represent").each(function() {
			if($(this).parent().parent().parent().css("display") != "none") {
				nLengthOfList++;
			}
		});
		var ulLength = nLengthOfList - 1;
		var liPercent = 100/ulLength;
		$('.img_represent .hidden_box ul li').css('width',  + liPercent + '%');
	}

});//jquery 끝


//gnb layer height
function gnbLayer(){
	var winWidth = $(window).width();
	var containerH = $(window).height();//$('.container_wrap').height();
	var containerHeight = containerH - 110;//- 55;
	var containerHeight02 = containerH + 110; //+ 55;
	if(winWidth > 768){
		$('.gnb_menu_layer').css('height', containerHeight + 'px');
	} else {
		$('.gnb_menu_layer').css('height', containerHeight02 + 'px');
	}
}

function gnbLayerPos(){
	var gnbLayerW = $('.gnb_menu_layer').width();
	var gnbLayerWidth = gnbLayerW + 42;
	$('.gnb_menu_layer').css('left', '-' + gnbLayerWidth + 'px');
	$('.gnb_menu_layer').css('display', 'none');
}

//gnb메뉴 레이어 닫는 동작
function gnbLayerClose(){
	var gnbLayerWid = $('.gnb_menu_layer').width();
	var gnbLayerWidth = gnbLayerWid + 42;
	$('.gnb_menu_layer').animate({
		left: '-' + gnbLayerWidth + 'px'
	}, 200, function(){
		$('.gnb_menu_layer').css({'overflow':'hidden', 'display':'none'});
		$('.bg_modal02').remove();
		$('.gnb_menu > ul').removeClass('open');
	});
}

//서브메뉴 bg
function submenuWidth(){
	var winWidth = $(window).innerWidth();
	// var submenuWidth = winWidth - 84;
	var submenuWidth = winWidth; 
	if(winWidth >= 768){
		$('.submenu_shadow, .sub_menu_wrap').css('width', submenuWidth + 'px');
	} else {
		$('.sub_menu_wrap').css('width','auto');
	}
}

function subBannerImg(){
	var winWidth = $(window).innerWidth();
	//alert(winWidth);

	if(winWidth < 1040){
		$('.sub_banner').find('img').css('width', 1040 + 'px');
	} else {
		$('.sub_banner').find('img').css('width', winWidth + 'px');
	}
}

function subBannerTxt(){

	var winWidth = $(window).innerWidth();
	var contentsWidth = $('.contents').width() + 80;
	var leftWidth = (winWidth - contentsWidth)/2;
	$('.sub_banner .slidesjs-slide .txt').css('right', leftWidth + 'px');

}

//iscroll
function loaded() {
	var myScroll = new Array();
	var _num = 0
	$('.scrollable').each(function(){
		_num	= _num+1;
		//console.log(_num);
		$(this).attr('id', 'wrapper'+_num);
		id = "#"+$(this).attr('id');
		//console.log(id);
		myScroll.push(new IScroll(id,{
			scrollbars: true,
			mouseWheel: true,
			interactiveScrollbars: true,
			shrinkScrollbars: 'scale',
			fadeScrollbars: false,
			click:true
		}));
	});
}

//모달 function

/*function modalpop(){
	var winHeight = $(window).height();
	var modalHeight = $('.modal').height();
	var modalPos = winHeight - modalHeight;
	var modalPosHalf = modalPos/2;
	$('body').append('<div class="bg_modal">'+'</div>');
	var res_height;
	if(winHeight < modalHeight){
		res_height = 0;
	} else {
		res_height = Math.floor((winHeight-modalHeight)/2);
	}
	var top = res_height + $(document).scrollTop();
	$('.modal').css("top",top);
	$('.modal').show();
	return false;
}

function modalClose(){
	$('.modal, .bg_modal').remove();
}*/

//iscroll 미적용 클래스
function scrollAble(){
	$('.scrollable').addClass('web');
}

//tab
function tabClick(obj){
	if(obj.hasClass('sele')){

	} else {
		$('.tab_wrap.type01 .tab').removeClass('sele');
		$('.tab_wrap.type01 .tab_cont').removeClass('sele');
		obj.addClass('sele');
		obj.next().addClass('sele');
	}

	// 위치안내 관련 스크립트
	if(obj.find(".location")) {
		var nFrameWidth = 0;
		var winWidth = $(window).innerWidth();
		if(winWidth > 1024) {
			nFrameWidth = 960;
		}
		else {
			// 모바일인 경우 (?)
			nFrameWidth = winWidth - 40;
		}
		// YDH. 중국 구글맵스 사용관련 추가
		var pc_language = navigator.language || navigator.userLanguage;
		if(obj.hasClass("tab01")) {
			if(pc_language=='zh'){
				var mapCenterIframe = "<iframe src='http://www.google.cn/maps/embed?pb=!1m18!1m12!1m3!1d1580.3032689191741!2d126.97498450060979!3d37.611418198213656!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357cbd3f81484fa5%3A0xcdaccdc4d2e8f1f5!2zKOyjvCnshJzsmrjsmKXshZg!5e0!3m2!1sko!2scn!4v1521449647690' width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>";
			}else{
				var mapCenterIframe = "<iframe src='https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3160.606546262178!2d126.97563500000001!3d37.61141800000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357cbd3f81484fa5%3A0xcdaccdc4d2e8f1f5!2zKOyjvCnshJzsmrjsmKXshZg!5e0!3m2!1sko!2s!4v1431436261224' width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>";
			}
			$("#mapCenter").html(mapCenterIframe);
			$("#mapBusan").html("");
			$("#mapGangnam").html("");
			$("#mapHongkong").html("");
		}
		else if(obj.hasClass("tab02")) {
			if(pc_language=='zh'){
				var mapGangnamNewIframe = "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12656.279856229452!2d127.034386!3d37.529848!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x20893aab0caffe0c!2zKOyjvCnshJzsmrjsmKXshZgg6rCV64Ko7IKs7JilIFNlb3VsIEF1Y3Rpb24gR2FuZ25hbSBCcmFuY2g!5e0!3m2!1sko!2skr!4v1547529951666'  width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>";
			}else{
				var mapGangnamNewIframe = "<iframe src='https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12656.279856229452!2d127.034386!3d37.529848!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x20893aab0caffe0c!2zKOyjvCnshJzsmrjsmKXshZgg6rCV64Ko7IKs7JilIFNlb3VsIEF1Y3Rpb24gR2FuZ25hbSBCcmFuY2g!5e0!3m2!1sko!2skr!4v1547529951666'  width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>";
			}
			$("#mapHongkong").html("");
			$("#mapCenter").html("");
			$("#mapBusan").html("");
			$("#mapGangnam4").html("");
			$("#mapGangnam1").html(mapGangnamNewIframe);
		}  
		else if(obj.hasClass("tab03")) {
			if(pc_language=='zh'){  
				var mapHongkongIframe = "<iframe src='https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3691.786504492016!2d114.15230611534561!3d22.286075749041935!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34040064cdfdd003%3A0xf562f5cab77b7669!2sCompass%20Offices%20-%20Nan%20Fung%20Tower%20Business%20Centre!5e0!3m2!1sko!2skr!4v1606895882830!5m2!1sko!2skr' width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>"; 
			}else{
				var mapHongkongIframe = "<iframe src='https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3691.786504492016!2d114.15230611534561!3d22.286075749041935!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x34040064cdfdd003%3A0xf562f5cab77b7669!2sCompass%20Offices%20-%20Nan%20Fung%20Tower%20Business%20Centre!5e0!3m2!1sko!2skr!4v1606895882830!5m2!1sko!2skr' width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>"; 
			} 
			$("#mapHongkong").html(mapHongkongIframe);
			$("#mapCenter").html("");   
			$("#mapBusan").html("");
			$("#mapGangnam4").html("");
		}
		else if(obj.hasClass("tab04")) {
			if(pc_language=='zh'){
				var mapBusanIframe = "<iframe src='https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3261.8636757459644!2d129.1608617156171!3d35.16002046598623!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35688d5d1bb45f6f%3A0x9c6be703064cd34b!2z67aA7IKw6rSR7Jet7IucIO2VtOyatOuMgOq1rCDspJHrj5kg7ZW07Jq064yA7ZW067OA66GcIDI5Mg!5e0!3m2!1sko!2skr!4v1601268639914!5m2!1sko!2skr' width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>";
			} else  {
				var mapBusanIframe = "<iframe src='https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3261.8636757459644!2d129.1608617156171!3d35.16002046598623!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35688d5d1bb45f6f%3A0x9c6be703064cd34b!2z67aA7IKw6rSR7Jet7IucIO2VtOyatOuMgOq1rCDspJHrj5kg7ZW07Jq064yA7ZW067OA66GcIDI5Mg!5e0!3m2!1sko!2skr!4v1601268639914!5m2!1sko!2skr' width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>"; 
			}
			$("#mapBusan").html(mapBusanIframe);
			$("#mapCenter").html("");
			$("#mapGangnam").html("");
			$("#mapHongkong").html("");
		}
		else if(obj.hasClass("tab05")) {
			if(pc_language=='zh'){
				var mapGangnamIframe = "<iframe src='http://www.google.cn/maps/embed?pb=!1m18!1m12!1m3!1d3164.377480931229!2d127.0347639492509!3d37.52259809326109!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca3896760d3c7%3A0x2591c9fdbba52e9e!2z7ISc7Jq47Jil7IWY67iU66Oo!5e0!3m2!1sko!2scn!4v1521449254327' width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>";
			}else{
				var mapGangnamIframe = "<iframe src='https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3164.377527299899!2d127.03624299999998!3d37.522597!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca38966676653%3A0xa13e5d124dfdf36d!2z7ISc7Jq47Jil7IWY6rCV64Ko7KCQ!5e0!3m2!1sko!2s!4v1431436304127' width='" + nFrameWidth + "' height='500' frameborder='0' style='border:0'></iframe>";
			}
			$("#mapGangnam").html(mapGangnamIframe);
			$("#mapCenter").html("");
			$("#mapBusan").html("");
			$("#mapHongkong").html("");
		}
	}
}

//화살표 눌렀을때 위아래로 움직이는 동작
function btnUpDown(){
	if($('.btn_up').hasClass('down') != true){
		 btnDownFunc();
	} else {
		 btnUpFunc();
	}
}

function btnDownFunc(){
	$('.btn_up').children().text('아래로');
	$('.btn_up').parent().parent().addClass('up').animate({
		"padding-top" : "141px"
	}, 300);
	var obj2 = $('.btn_up');
	setTimeout(function(){
		obj2.addClass('down');
	}, 300);
}

function btnUpFunc(){
	$('.btn_up').children().text('위로');
	$('.btn_up').parent().parent().removeClass('up').animate({
		"padding-top" : "620px"
	}, 300);
	var obj = $('.btn_up');
	setTimeout(function(){
		obj.removeClass('down');
	}, 300);
}


//연혁 sticky
function sGnbScroll() {
	var jObj = $('.history_step');
	var jObjWidth = $('.contents').width();
	if (jObj.length == 0) {
		return;
	}
	$(window).scroll(function(e) {
		if ( $(document).scrollTop() > 180){
			jObj.addClass('sticky');
			$('.history_cont').css('margin-top','100px');
			jObj.css('width', jObjWidth + 'px');
		}else{
			jObj.removeClass('sticky');
			$('.history_cont').css('margin-top','30px');
		}
	});
}

function historyWidth(){
	var historyWidth = $('.contents').width();
	$('.history_step').css('width', historyWidth + 'px');
}

//비밀번호 찾기 tab 선택
function tabSele(){
	$('.tab_wrap').children().removeClass('sele');
	$('.tab_wrap').children('.tab:nth-child(3), .tab_cont:nth-child(4)').addClass('sele');
}

//스크롤 막기
function blockWheel()
{
	jQuery(window).on("mousewheel.disableScroll DOMMouseScroll.disableScroll touchmove.disableScroll", function(e) {
		e.preventDefault();
		return;
	});

	jQuery(window).on("keydown.disableScroll", function(e) {
		var eventKeyArray = [32, 33, 34, 35, 36, 37, 38, 39, 40];
		for (var i = 0; i < eventKeyArray.length; i++) {
			if (e.keyCode === eventKeyArray [i]) {
				e.preventDefault();
				return;
			}
		}
	});
}

//스크롤 막기 해제
function playWheel()
{
	jQuery(window).off(".disableScroll");
}

//rolling z004, z006, z005, z011 모바일 하단 20150521
jQuery.fn.rollingFunc = function(params){
	var p 	= params || {
		// type : "main"
	}

	var _obj 		= $(this)
	var _interval 	= p.interval;
	var	_prevBtn	= _obj.find("."+p.prevBtn);
	var	_nextBtn	= _obj.find("."+p.nextBtn);
	var	_playBtn	= _obj.find("."+p.playBtn);
	var	_stopBtn	= _obj.find("."+p.stopBtn);
	var _dulation	= p.dulation;
	var _auto 		= p.auto;
	var _stop 		= false;
	var _isMain 	= p.isMain;
	var _rollNum 	= 0;
	var _rollObj	= _obj.find("ul")
	var _rollWidth, _stop, _rollInterval;

	_rollWidth = _obj.find(".rolling li").width();

	var init			= function(){
		if(_auto) {
			_playBtn.css("display","none");
		}else{
			_stopBtn.css("display","none");
		}
	}

	/*var bgChange 		= function(){

		var liNum = _obj.find("li").eq(0).attr("data");
		if(liNum == "1"){
			$("#container").addClass("visu01")
			$("#container").removeClass("visu02")
		}else{
			$("#container").addClass("visu02")
			$("#container").removeClass("visu01")
		}
	}*/

	var prevPlay		= function(){
		var _cloneObj	= _rollObj.find("li:last").clone();
		_cloneObj.prependTo(_rollObj);
		_obj.find("ul").css("left", _rollWidth*-1);
		_obj.find("ul").stop().animate({'left':"0"}, {duration:_dulation, easing:"easeInOutQuint"});
		_rollObj.children("li:last").remove();
		if(_isMain){ bgChange(); }
	}

	var nextPlay		= function(){
		 var _cloneObj	= _rollObj.find("li:first").clone();
		 _obj.find("ul").stop().animate({'left':"-="+_rollWidth}, {duration:_dulation, easing:"easeInOutQuint"});
		setTimeout(function(){
			_obj.find("ul").stop().css("left", "0");
			_cloneObj.appendTo(_rollObj);
			_rollObj.children("li:first").remove();
		//	if(_isMain){ bgChange(); }
		 }, 500);

	}

	var autoPlay	= function(){
		_rollInterval	= setInterval(nextPlay, _interval);
	}

	var stopPlay	= function(){
		clearInterval(_rollInterval);
	}

	_prevBtn.bind("click keydown", function() {
		stopPlay();
		prevPlay();
		_playBtn.css("display","block");
		_stopBtn.css("display","none");
	})

	_nextBtn.bind("click keydown", function() {
		stopPlay();
		nextPlay();
		_playBtn.css("display","block");
		_stopBtn.css("display","none");
	})

	_playBtn.bind("click keydown", function() {
		_auto	= true;
		_stop 	= false;
		if(_auto) autoPlay();
		_playBtn.css("display","none");
		_stopBtn.css("display","block");
	})

	_stopBtn.bind("click keydown", function() {
		stopPlay();
		_auto	= false;
		_stop 	= true;
		_playBtn.css("display","block");
		_stopBtn.css("display","none");
		//console.log(_stop);
	})

	if(_auto && _stop == "false"){
		_obj.bind("mouseenter focusin", function(){
			stopPlay();
			_auto	= false;
		}).bind("mouseleave focusout", function(){
			_auto	= true;
			autoPlay();
		})
	}

	init();
	if(_auto) autoPlay();

};

//slideFunc z001, z007 20150521
jQuery.fn.slideFunc = function(params, elRollingId, elThumbId) {

	if(!elRollingId && !elThumbId) {
		elRollingId = ".rolling";
		elThumbId = ".thumb_list";
	}

	var _slideWidth;
	var _obj = $(this);
	var _rollWidth = (_obj.find(elRollingId + " ul li").length) * _obj.find(elRollingId + " ul li").width();
	var _mrollWidth = (_obj.find(elRollingId + " ul li").length) * 100;//20150714

	_obj.find(elRollingId + " ul").css("width", _rollWidth)
	//20150714
	if($(window).width() < 590){
		 _obj.find(elRollingId + " ul").css("width", _mrollWidth + '%');
	}
	//20150714

	_slideWidth = _obj.find(elRollingId + " ul li").width();
	_obj.find(elThumbId + " li").eq(0).addClass("sele")
	// console.log(_slideWidth);

	_obj.find(elThumbId + " li").bind("click keyup", function() {
		var liNum = $(this).index();
		m_objNum = $(this).index();
		slideMove(liNum, elRollingId, elThumbId);
//		console.log(m_objNum);
	});
	_obj.find(".btn_prev").bind("click keyup", function() {
		if (m_objNum > 0) {
			slideMove(m_objNum - 1, elRollingId, elThumbId);
			m_objNum--;
		}
	});
	_obj.find(".btn_next").bind("click keyup", function() {
		if (m_objNum < (_obj.find(elRollingId + " ul li").length - 1)) {
			slideMove(m_objNum + 1, elRollingId, elThumbId);
			m_objNum++;
		}
	});

	function slideMove(num, elRollingId, elThumbId) {
		// console.log(num);
		_slideWidth = _obj.find(elRollingId + " ul li").width();
		_slideLeft = _slideWidth * num * -1;
		// console.log(_slideWidth);
		_obj.find(elRollingId + " ul").stop().animate({
			'left' : _slideLeft
		}, {
			duration : 500,
			easing : "easeInOutQuint"
		});
		_obj.find(elThumbId + " li").removeClass("sele");
		_obj.find(elThumbId + " li").eq(num).addClass("sele");
	}
};

/*function imgResize(){
	var divs = $('.auction_list li .img,  .auction_list02 li .img, .thumb_list li, .rolling li, .auction_h_list li .img, .m_main_banner .slidesjs-slide .img');//, .sub_banner .slidesjs-slide .ex_list_area li,
	for (var i = 0; i < divs.length; ++i) {
		var div = divs[i];
		var divAspect = div.offsetHeight / div.offsetWidth;
		div.style.overflow = 'hidden';

		var img = div.querySelector('img');
		var imgAspect = img.height / img.width;

		if (imgAspect <= divAspect) {
		  // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
		  var imgWidthActual = div.offsetHeight / imgAspect;
		  var imgWidthToBe = div.offsetHeight / divAspect;
		  var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
		  img.style.cssText = 'width: auto; height: 100%; margin-left: '
						  + marginLeft + 'px;'
		} else {
		  // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
		  img.style.cssText = 'width: 100%; height: auto; margin-left: 0;';
		}
	}
}*/

function imgResize(){ 
	/* 
	var div = $('.auction_list li .img,  .auction_list02 li .img, .thumb_list li, .rolling li, .auction_h_list li .img, .m_main_banner .slidesjs-slide .img, .ex_list_area li a');  
	*/
	var div = $('.m_main_banner .slidesjs-slide .img, .ex_list_area li a, .auction_list02 li .img, .auction_list > ul > li .auction_list_img, .auction_list > ul > li .result_auction_img, .auction_h_list ul li .wraph .img, .auction_h_list ul li .wraph .result_auction_img, .newsletter_contentsbox .newsletter_gridbox_img');
	div.each(function(){ 
		var divAspect = this.offsetHeight / this.offsetWidth;
		this.style.overflow = 'hidden';

		var img = this.querySelector('img');
		if(img) {
			var imgAspect = img.height / img.width;
		}

		if (imgAspect <= divAspect) {
		  // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
		  var imgWidthActual = this.offsetHeight / imgAspect;
		  var imgWidthToBe = this.offsetHeight / divAspect;
		  var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
		  img.style.cssText = 'width: auto; height: 100%; margin-left: '
						  + marginLeft + 'px;'
		} else if(imgAspect > divAspect) {
		  // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
		  img.style.cssText = 'width: 100%; height: auto; margin-left: 0;';
		}
	});

	/*
	if($(window).width() < 590) {
		if($(".rolling")) {
			$(".rolling ul").css("left", "0");
			m_objNum = 0;
		}
	}
	*/ 
} 
  
//리스트 이미지 전체보이기 20150724
function fullImg(){      
	/*var imgs = $('.auction_list li .img, .thumb_list li, .img_represent .rolling li, .auction_list > ul > li .auction_list_img, .auction_list > ul > li .result_auction_img, .auction_h_list ul li .wraph .result_auction_img, .newsletter_contentsbox .newsletter_gridbox_img, .academy_list .academy_img');*/    
	var imgs = $('.auction_list li .img, .auction_list > ul > li .result_auction_img, .auction_h_list ul li .wraph .result_auction_img, .newsletter_contentsbox .newsletter_gridbox_img, .academy_list .academy_img');    
	imgs.each(function(){  
		var imgsWidth = $(this).find('img').width();
		var imgsHeight = $(this).find('img').height();			
		var thisW = $(this).width();
		var thisH = $(this).height();
		var imgsAspect = imgsHeight / imgsWidth;
		var thisAspect = thisH / thisW;
		var winW = $(window).width();  

		var img = this.querySelector('img');
		if(img) {
			if (imgsWidth <= imgsHeight) {
				$(this).css('text-align','center');
				$(this).find('img').css({'height':'100%', 'width':'auto', 'margin-top':'0'});
			} else if(imgsWidth > imgsHeight) {	
				$(this).find('img').css({'width':'100%', 'height':'auto'});
				var imgsHeight = $(this).find('img').height();
				var gapH = thisH - imgsHeight;
				var gapH02 = Math.floor(gapH/2);
				$(this).find('img').css({'margin-top':gapH02 + 'px'});
			}

			if (winW < 590){
				if (imgsAspect <= thisAspect) {
				  // 이미지가 div보다 납작한 경우
					$(this).find('img').css({'width':'100%', 'height':'auto'});
					var imgsHeight = $(this).find('img').height();
					var gapH = thisH - imgsHeight;
					var gapH02 = Math.floor(gapH/2);
					$(this).find('img').css({'margin-top':gapH02 + 'px'});	
				} else if(imgsAspect > thisAspect) {
				  // 이미지가 div보다 길쭉한 경우
					$(this).css('text-align','center');
					$(this).find('img').css({'height':'100%', 'width':'auto', 'margin-top':'0'});
				}
			}
		}
	});
}
//20150724

//z008 이미지 뷰 팝업 이미지 리사이즈
function zoomResize(){
	var divs = $(".panzoom");
	for (var i = 0; i < divs.length; ++i) {
		var div = divs[i];

		var divAspect = div.offsetHeight / div.offsetWidth;
		$(div).css("overflow", "hidden");

		var img = $(div).find('img');
		var imgAspect = img.height() / img.width();

		if (imgAspect < divAspect) {
			// 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다

			var marginTop = 0;
			if(img.height() > div.offsetHeight) {
				marginTop = (img.height()/2 - div.offsetHeight/2) / 2;
			}
			else {
				marginTop = (div.offsetHeight/2 - img.height()/2) / 2;
			}
			$(img).css({
				"width": "100%",
				"height": "auto",
				"margin-top": marginTop
			});

			var nMarginTop = $(img).css("height");
			nMarginTop = parseInt(nMarginTop.replace("px", ""), 10) / 2;
			nMarginTop = (div.offsetHeight/2) - nMarginTop;
			$(img).css({"margin-top" : nMarginTop + "px"});
		} else if (imgAspect == divAspect) {
			$(img).css({
				"width": "100%",
				"height": "auto"
			});
		} else {
			// 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
			var marginLeft = div.offsetWidth/2 - img.width()/2;
			$(img).css({
				"width" : "auto",
				"height": "100%"
			});
		}
	}

}

//z008 이미지 뷰 팝업 이미지 zoom
function imgZoom() {
	var buttonW = $('.zoom_buttons').outerWidth();
	var buttonWH = buttonW / 2;
	$('.zoom_buttons').css('margin-left', '-' + buttonWH + 'px');

	(function() {
		//button control
		var $section = $('.section').first();
		$section.find('.panzoom').panzoom({
			$zoomIn: $section.find(".zoom-in"),
			$zoomOut: $section.find(".zoom-out"),
			$zoomRange: $section.find(".zoom-range"),
			$reset: $section.find(".reset")
		});

		//wheel control
		var $panzoom = $section.find('.panzoom').panzoom();
		$panzoom.parent().on('mousewheel.section', function(e) {
			e.preventDefault();
			var delta = e.delta || e.originalEvent.wheelDelta;
			var zoomOut = delta ? delta < 0 : e.originalEvent.deltaY > 0;
			$panzoom.panzoom('zoom', zoomOut, {
				increment: 0.1,
				animate: false,
				focal: e
			});
		});
	})();
}

//커튼배너 이미지 변경
function curtainImg(){
	var winWidth = $(window).width();
	if(winWidth > 1024){
		$('.curtain_wrap img').attr('src', src960);
		$('.curtain_wrap').removeClass('response01');
		$('.curtain_wrap').removeClass('response02');
	} else if(winWidth < 768){
		$('.curtain_wrap img').attr('src', src320);
		$('.curtain_wrap').removeClass('response02');
		$('.curtain_wrap').addClass('response01');
	} else {
		$('.curtain_wrap img').attr('src', src768);
		$('.curtain_wrap').removeClass('response01');
		$('.curtain_wrap').addClass('response02');
	}
}

//컨텐츠 짧은 화면//contents Height 20150625
function funcContHeight(){
	var winWidth = $(window).width();
	var winHeight = $(window).height();
	var restHeight = winHeight - 342;//web
	var restHeight02 = winHeight - 821;//web upcoming
	var restHeightM = winHeight - 262;//mobile
	var restHeightM02 = winHeight - 575;//mobile upcoming
	var contHeight = $('.contents').height();

	 /* -- 기존 contents 조건 (else 전까지) --
	    if(winWidth > 767){
		if(contHeight < restHeight){
			if($('#wrap').hasClass('upcoming')){
				$('.contents').css('height', restHeight02 + 'px');
			} else {
				$('.contents').css('height', restHeight + 'px');
			}
		} */
		if(winWidth > 767){
			if(contHeight < restHeight){
				if($('#wrap').hasClass('upcoming')){
					$('.contents').css('height', 'auto');
				} else {
					$('.contents').css('height', 'auto');
				} 
			} else {
			$('.contents').css('height', 'auto');
		}
	} else {
//		if(contHeight < restHeightM){  									//YDH 2018.09.02주석처리
//			if($('#wrap').hasClass('upcoming')){						//YDH 2018.09.02주석처리	
//				$('.contents').css('height', restHeightM02 + 'px');		//YDH 2018.09.02주석처리
//			} else {													//YDH 2018.09.02주석처리
//				$('.contents').css('height', restHeightM + 'px');		//YDH 2018.09.02주석처리	
//			}															//YDH 2018.09.02주석처리
//		} else {														//YDH 2018.09.02주석처리
			$('.contents').css('height', 'auto');
//		}																//YDH 2018.09.02주석처리	
	}

	/*if(contHeight >= restHeight){
		$('.contents').css('height', 'auto');
	} else {
		if($('#wrap').hasClass('upcoming')){
			$('.contents').css('height', restHeight02 + 'px');
			if(winWidth < 767){
				$('.contents').css('height', restHeightM02 + 'px');
			}
		} else {
			$('.contents').css('height', restHeight + 'px');
			if(winWidth < 767){
				$('.contents').css('height', restHeightM + 'px');
			}
		}
	}*/
}

//20150709
//sub_banner(배경) 이미지 넘칠 경우
function subBannerOverflow(){
	var winHeight = $(window).height();
	var subBannerHeight = $('.sub_banner').find('img').height();
	var gapSubBanner = Math.floor(subBannerHeight - winHeight);
	if(winHeight < subBannerHeight){
		$('#wrap .sub_banner').not('#wrap.upcoming .sub_banner').css({'position':'absolute', 'top': '-' + gapSubBanner + 'px', 'width':'100%'});
	} else {
		$('#wrap .sub_banner').not('#wrap.upcoming .sub_banner').css({'position':'static'});
	}
}
//20150709

//모바일에서 투자정보 메뉴 숨기기 20150621
function investHide(){
	$('.sub_menu_wrap.menu04 .sub_menu > ul > li:nth-child(3)').remove();
	$('.gnb_menu_layer .gnb_menu > ul > li:last-child ul li:nth-child(3)').remove();
	$('.cont_sitemap > div:nth-child(4) ul li:nth-child(3)').remove();
}