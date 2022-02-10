$(document).ready(function(){
	//마우스 호버시 메뉴 열림    
	$(".gnb_menu > .fl_menu > li").mouseenter(function(){ 
		$(".gnb_menu_layer").css({
			overflow: "visible",  
			display: "block" 
		});
		$(".gnb_menu_layer").stop().animate({  
			left: "0",
		},500, function(){
			$(".container_wrap").append('<div class="bg_modal02">'+'</div>');     
		});     
	}); 
	  
	//마우스 호버시 메뉴 닫힘  
	$(".gnb_menu_layer").stop().mouseleave(function(){   
		$(this).css({   
			overflow: "hidden"  
		}); 
		$(this).animate({       
			left: "-1902px", 
			display: "none"  
		},500, function(){       
			$(".bg_modal02").remove();   
		});  
	});     
});   

$(document).ready(function(){
	//모바일 햄버거 메뉴
    $('#line-wrapper').click(function(){
	  /* 추가된 부분 */
	  $('.line').removeClass('init');
	  $('.line').addClass('menu_close');  
	  $('#line-top').toggleClass('line-top').toggleClass('top-reverse');
	  $('#line-mid').toggleClass('line-mid').toggleClass('mid-reverse'); 
	  $('#line-bot').toggleClass('line-bot').toggleClass('bot-reverse');
	});
}); 

/*$(document).ready(function(){
	// top menu 전체 드롭다운 메뉴
	$("nav > ul > li > a").mouseenter(function(){ 
		$(".sub_back").stop().slideToggle("linear");   
	}); 
	$(".sub_back").mouseenter(function(){
		$(".sub_back").stop().slideToggle("linear");        
	}); 
	
	$("nav > ul > li > a").mouseleave(function(){
		$(".sub_back").stop().slideToggle("fast");    
	});  
	$(".sub_back").mouseleave(function(){      
		$(".sub_back").stop().slideToggle("fast");      
	});
	
	// 로케이션 메뉴 클릭시
	$(".location_submenu").click(function(){
		$(this).children("ul").toggleClass("hide");
		$(this).children("i").toggleClass("rotation_up"); 
	});  
});*/    


//모바일 메뉴 제이쿼리   
(function ($) {

	$.fn.mgaccordion = function (options) {

		var defaults = {
			theme: "flat",
			leaveOpen: false
		};

		var settings = $.extend({}, defaults, options);

		var openIcon, closeIcon;

		this.initialize = function () {
			/**
			 * silently exit if passed element is not a list
			 */
			if (!this.is('ul') && !this.is('ol')) {
				console.log('Element is not a list');
				return;
			}
			this.addClass('mg-accordion');
			var theme = settings.theme;
			var leaveOpen = settings.leaveOpen;
			if (theme === 'tree') {
				this.addClass('mg-tree');
			} else {
				this.addClass('mg-flat');
			}
			$.each(this.find('li'), function () {
				var $this = $(this);
				if ($this.children('ul').length) {
					$this.addClass('dropdown')
						.children('a')
						.bind('click', function (e) {
							e.preventDefault();
							if (leaveOpen === false) {
								closeOther($(this));
							}
							$(this).siblings('ul.submenu').stop().slideToggle(function () { 
								$(this).toggleClass('closed', $(this).is(':visible'));
							});
							updateIcons($(this));
						}
						);
					$this.find('ul').addClass('submenu');
					if (theme === 'tree') {
						$this.children('a').prepend('<span class="toggler"><i class="material-icons">arrow_drop_up</i> </span>');
					} else {
						$this.children('a').append('<span class="toggler"><i class="material-icons">arrow_drop_down</i></span>'); 
					}
				}
			});
			return this;
		};

		var setIcons = function () {
			if (settings.theme === 'tree') {
				openIcon = '<span class="toggler"><i class="material-icons">arrow_drop_down</i></span>';
				closeIcon = '<span class="toggler"><i class="material-icons">arrow_drop_up</i></span>';
			} else if (settings.theme === 'flat') { 
				openIcon = '<span class="toggler"><i class="material-icons">arrow_drop_down</i></span>';
				closeIcon = '<span class="toggler"><i class="material-icons">arrow_drop_up</i></i></span>';
			}
		}

		var closeOther = function (obj) {
			setIcons();
			var items = obj.parent().siblings().find('ul.submenu'); 
			var itemss = obj.parent().siblings().find('ul.submenu > li.dropdown'); 
			if (settings.theme === 'flat') {
				items.each(function () {
					if ($(this).hasClass('closed')) {
						$(this).stop().slideUp('slow')
							.parent()
							.find('a')
							.removeClass('openItem');  
					} 
				});
			} else {
				items.each(function () {
					if ($(this).hasClass('closed')) {
						$(this).stop().slideUp('slow') 
							.parent()
							.find('span.toggler') 
							.replaceWith(openIcon);
					}
				});
			}
		}

		var updateIcons = function (obj) {
			if (settings.theme === 'flat') {
				if (obj.siblings('.submenu').hasClass('closed')) {
					obj.removeClass('openItem');
					obj.addClass('closeItem'); 
				} else { 
					obj.addClass('openItem'); 
					obj.removeClass('closeItem'); 
				}  
			} else {
				if (obj.siblings('.submenu').hasClass('closed')) {
					obj.find('span.toggler').replaceWith(openIcon);
				} else {
					obj.find('span.toggler').replaceWith(closeIcon);
				}
			} 
		}

		return this.initialize();

	}; 

    $(".submenu > li.dropdown > a").click(function(){  
    	$(this).css("color","fff");   
    }); 
}(jQuery));


//모바일 아코디언 left 메뉴  
function openNav() {  
	/* 메뉴 리사이즈 조절 */  
	if (matchMedia("screen and (max-width: 374px)").matches) {     
		$("#mySidenav").css("width","250px");    
	}else{
		$("#mySidenav").css("width","300px");  
	}; 
	  /*document.getElementById("mySidenav").style.width = "280px"*/       
	  $(".overlay_back").css("left","0");  
	  $(".my-menu, .mo_util a").stop().show();                         
	};  
	    
function closeNav() {   
  document.getElementById("mySidenav").style.width = "0"; 
  $(".overlay_back").css("left","-3000px");  
  $(".my-menu, .mo_util a").stop().hide(); 
  $("ul.submenu").css("display","none");   
  $("li.dropdown > a").removeClass("openItem");  
  $("li.dropdown > a").addClass("closeItem");   
}; 

	




 