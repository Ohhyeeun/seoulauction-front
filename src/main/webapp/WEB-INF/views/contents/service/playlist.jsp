<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../../include/header.jsp" flush="false"/>
 <link rel="stylesheet" type="text/css" href="https://www.seoulauction.com/js/playlist/jquery.mCustomScrollbar.css" media="all" /><!-- scroll -->
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"><!-- icons -->
        <link rel="stylesheet" type="text/css" href="https://www.seoulauction.com/js/playlist/ivag_dark3.css" /> 
          
  
        <script type="text/javascript" src="https://www.seoulauction.com/js/playlist/captionator.js"></script><!-- captions -->
        <script type="text/javascript" src="https://www.seoulauction.com/js/playlist/jquery.address.js"></script><!-- deeplink -->
        <script type="text/javascript" src="https://www.seoulauction.com/js/playlist/jquery.mCustomScrollbar.concat.min.js"></script><!-- scroll -->
        <script type="text/javascript" src="https://www.seoulauction.com/js/playlist/id3-minimized.js"></script><!-- id3 tags -->
        <script type="text/javascript" src="https://www.seoulauction.com/js/playlist/jquery.dotdotdot.min.js"></script><!-- text overflow ellipsis -->
        <script type="text/javascript" src="https://www.seoulauction.com/js/playlist/new.js"></script>

       <script type="text/javascript">
        var ivag_player;  
            jQuery(document).ready(function($) {
                
                var settings = {
                    instanceName:"dark3",
                    sourcePath:"",
                    playlistHolder:"#ivag-bottom .ivag-playlist-holder",
                    playlistList:"#ivag-playlist-list",
                    useDeeplink:false,
                    activePlaylist:"playlist-youtube-5",
                    activeItem:0,
                    autoHideInterface:false,
                    fullscreenInterfaceTimeout:3000,
                    volume:0.5,
                    autoPlay:false,
                    preload:"auto",
                    randomPlay:false,
                    loopingOn:true,
                    autoAdvanceToNextMedia:true,
                    mediaEndAction:"rewind",
                    useLivePreview:false,
                    playlistOrientation:"hb",
                    aspectRatio:2,
                    youtube:{
                        appId:"AIzaSyDHdyqr0Th0M2Mojq6bq0Ush5zAnFIik_E",
                        theme:"dark",
                        chromeless:true
                    },
                    vimeo:{
                        color:"00adef",
                        badge:false,
                        byline:false,
                        portrait:false,
                        title:false,
                        chromeless:false
                    },
                    soundCloudAppId:"",
                    usePlaylistScroll:false,
                    useInfoScroll:true,
                    scrollTheme:"dark",
                    playlistOpened:true,
                    useTooltips:true,
                    showQualityMenuOnSingleQuality:false,
                    useKeyboardNavigationForPlayback:true,
                    useKeyboardNavigationForPlaylist:true,
                    truncatePlaylistInfo:true,
                    disableRightClick:false, 
                    useCaptions:true,
                    usePlaybackRate:true,
                    useDownload:true,
                    autoReuseDownloadMail:true,
                    useShare:true,
                    facebookAppId:"",
                    useFullscreen:true,
                    useRange:true,
                    playerSizing:"restrict",
                    playerWidth:1000,
                    playerHeight:563
                };
                
                ivag_player = $("#ivag-main").ivag(settings);

            });

 

        </script>

<body>
<jsp:include page="../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
					<jsp:include page="../include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div>
			<!-- //sub_menu_wrap -->

			<div class="contents_wrap">
				<div class="contents" style="min-height:1200px;">
					<div class="tit_h2">
						<h2>VIDEOS</h2>
		   			</div>
	        	    <!-- player markup -->
         
         
        
                    <!-- play description -->
                    <div class="ivag-wra-div"> 
                        <div style="font-size:22px; color:#999;">Contact</div>  
                        <div style="border-bottom:1px #CCCCCC solid; padding-top:5px;"></div>
                        <div style="padding-top:5px;">
                            +82 (0)2-395-0330 <br/>
                            art@seoulauction.com<br/>
                            info@seoulauction.com<br/>
                            webmaster@seoulauction.com <br/><br/><br/>
                        </div>
                        <div style="font-size:22px; color:#999;">Connect with Us</div>  
                        <div style="border-bottom:1px #CCCCCC solid; padding-top:5px;"></div>
                        <div style="padding-top:0px;">
                            <a href="https://twitter.com/seoulauctionkr" target="_balnk"><!-- YBK. 상 우 하 좌 -->
                                <img src="https://www.seoulauction.com/nas_img/front/homepage/icon_twitter.jpg" style="margin:10px 5px 0px 0px; width:30px;" alt="Twitter" />
                            </a>  
                            <a href="https://www.facebook.com/seoulauction" target="_balnk">
                                <img src="https://www.seoulauction.com/nas_img/front/homepage/icon_facebook.jpg" style="margin:10px 5px 0px 0px; width:30px;" alt="Facebook" />
                            </a>
                            <a href="http://blog.naver.com/PostList.nhn?blogId=s_auction" target="_balnk">
                                <img src="https://www.seoulauction.com/nas_img/front/homepage/icon_blog.jpg" style="margin:10px 5px 0px 0px; width:30px;" alt="Blog" />
                            </a>
                            <a href="https://www.instagram.com/seoulauction" target="_balnk">
                                <img src="https://www.seoulauction.com/nas_img/front/homepage/icon_instagram.jpg" style="margin:10px 5px 0px 0px; width:30px;" alt="Instagram" />
                            </a>
                            <a href="https://appsto.re/kr/hAMKu.i" target="_balnk">
                                <img src="https://www.seoulauction.com/nas_img/front/homepage/icon_appstore.jpg" style="margin:10px 5px 0px 0px; width:30px;" alt="AppStore" />
                            </a> 
                            <a href="https://play.google.com/store/apps/details?id=seoulacution.seoulauction" target="_balnk">
                                <img src="https://www.seoulauction.com/nas_img/front/homepage/icon_playstore.jpg" style="margin:10px 5px 0px 0px; width:30px;" alt="PlayStore" /> 
                            </a>
                        </div>
                    </div><!-- play description -->
                         
                    <div id="ivag-main">
            
                        <div class="ivag-wrapper" tabindex="0">
             
                            <div class="ivag-player-holder">
            
                                <div class="ivag-media-holder">
                                    <div class="ivag-elem-holder"></div> 
                                </div>
            
                                <!-- player loader -->
                                <div class="ivag-player-loader"></div>
            
                                <div class="ivag-big-play"><i class="fa fa-play ivag-bplay-i ivag-icon-color"></i></div>
                                
                                <!-- logo 
                                <div class="ivag-logo ivag-hidden"><a href="http://www.google.com" target="_blank"><img src="" alt="logo"/></a></div>-->
                                 
                                <div class="ivag-player-addon">
            
                                    <!-- share
                                    <div class="ivag-share-toggle ivag-contr-vert ivag-tooltip-left" data-ivagtooltip="Share"><i class="fa fa-share-square-o ivag-contr-vert-i ivag-icon-color"></i>
                                                 
                                        <div class="ivag-share-holder">
                                            <div class="ivag-share-holder-bg"></div>
                                            <div class="ivag-share-btn ivag-googleplus ivag-tooltip-left" data-type="googleplus" data-ivagtooltip="Share on Google"><i class="fa fa-google-plus ivag-contr-share-i ivag-sh-icon-color"></i></div>
                                            <div class="ivag-share-btn ivag-twitter ivag-tooltip-left" data-type="twitter" data-ivagtooltip="Share on Twitter"><i class="fa fa-twitter ivag-contr-share-i ivag-sh-icon-color"></i></div>
                                            <div class="ivag-share-btn ivag-facebook ivag-tooltip-left" data-type="facebook" data-ivagtooltip="Share on Facebook"><i class="fa fa-facebook ivag-contr-share-i ivag-sh-icon-color"></i></div>
                                        </div>
            
                                    </div>-->
                                    
                                    <!-- embed -->
                                    <div class="ivag-embed-toggle ivag-contr-vert ivag-tooltip-left" data-ivagtooltip="Embed"><i class="fa fa-link ivag-contr-vert-i ivag-icon-color"></i></div> 
            
                                    <!-- info -->
                                    <div class="ivag-info-toggle ivag-contr-vert ivag-tooltip-left" data-ivagtooltip="Info"><i class="fa fa-info-circle ivag-contr-vert-i ivag-icon-color"></i></div>
            
                                    <!-- download -->
                                    <div class="ivag-download-toggle ivag-contr-vert ivag-tooltip-left" data-ivagtooltip="Download"><i class="fa fa-download ivag-contr-vert-i ivag-icon-color"></i></div>
            
                                </div><!-- end ivag-player-addon -->
                                 
                                <!-- skip -->   
                                <div class="ivag-ad-skip-btn">
                                    <div class="ivag-ad-skip-msg"><p>You can skip ad in</p></div>
                                    <div class="ivag-ad-skip-msg-end"><p>SKIP AD &gt;</p></div>
                                </div>
                                     
                                <div class="ivag-player-controls">
                                 
                                    <!-- seekbar -->
                                    <div class="ivag-seekbar">
            
                                        <div class="ivag-drag-hit"></div>
                                    
                                        <div class="ivag-seekbar-inner ivag-tooltip-top">
                                            <div class="ivag-progress-bg"></div>
                                            <div class="ivag-load-level"></div>
                                            <div class="ivag-progress-level"></div>
                                        </div>
            
                                        <!-- range -->
                                        <div class="ivag-range-a-point ivag-tooltip-top">
                                            <div class="ivag-range-handle-a-hit"></div>
                                            <div class="ivag-range-handle-a-pin"></div>
                                        </div>
                                        <div class="ivag-range-b-point ivag-tooltip-top">
                                            <div class="ivag-range-handle-b-hit"></div>
                                            <div class="ivag-range-handle-b-pin"></div>
                                        </div>
                                          
                                    </div><!-- end ivag-seekbar -->
                                 
                                    <div class="ivag-contr-right-wrap">
                                          
                                        <!-- fullscreen -->   
                                        <div class="ivag-fullscreen ivag-contr-right ivag-tooltip-top-left" data-ivagtooltip="Fullscreen"><i class="fa fa-expand ivag-contr-right-i ivag-icon-color"></i></div>
                                          
                                        <!-- quality -->  
                                        <div class="ivag-quality ivag-contr-right"> 
                                            <div class="ivag-quality-holder"></div>
                                            <div class="ivag-quality-toggle ivag-tooltip-top" data-ivagtooltip="Quality"><i class="fa fa-gear ivag-contr-right-i ivag-icon-color"></i></div>
                                        </div>
                                           
                                        <!-- playback rate -->    
                                        <div class="ivag-playback-rate ivag-contr-right"> 
                                            <div class="ivag-rate-holder">
                                            <div class="ivag-rate-minus ivag-rate-box"><i class="fa fa-minus ivag-contr-rate-i ivag-icon-color"></i></div>
                                                <div class="ivag-rate-value ivag-rate-box"><p>0</p></div>
                                                <div class="ivag-rate-plus ivag-rate-box"><i class="fa fa-plus ivag-contr-rate-i ivag-icon-color"></i></div>
                                                <div class="ivag-rate-select ivag-rate-box"><i class="fa fa-caret-up ivag-contr-rate-i ivag-icon-color"></i>
                                                    <div class="ivag-rate-select-holder"></div>
                                                </div>
                                            </div>
                                            <div class="ivag-rate-toggle ivag-tooltip-top" data-ivagtooltip="Speed"><i class="fa fa-crop ivag-contr-right-i ivag-icon-color"></i></div>
                                        </div> 
                                          
                                        <!-- captions -->    
                                        <div class="ivag-captions ivag-contr-right"> 
                                            <div class="ivag-caption-holder"></div>
                                            <div class="ivag-caption-toggle ivag-tooltip-top" data-ivagtooltip="Captions"><i class="fa fa-cc ivag-contr-right-i ivag-icon-color"></i></div>
                                        </div> 
                                          
                                    </div><!-- end ivag-contr-right-wrap -->
                                 
                                    <!-- toggle playback --> 
                                    <div class="ivag-playback-toggle ivag-contr-left ivag-tooltip-top-right" data-ivagtooltip="Play"><i class="fa fa-play ivag-contr-left-i ivag-icon-color"></i></div>
                                      
                                    <!-- range -->      
                                    <div class="ivag-range-toggle ivag-contr-left ivag-tooltip-top" data-ivagtooltip="Range"><i class="fa fa-repeat ivag-contr-left-i ivag-icon-color"></i></div>
                                     
                                    <!-- volume -->     
                                    <div class="ivag-volume-wrapper">
                                          <div class="ivag-player-volume ivag-contr-left ivag-tooltip-top" data-ivagtooltip="Volume"><i class="fa fa-volume-up ivag-vol ivag-contr-left-i ivag-icon-color"></i></div>
                                          <div class="ivag-volume-seekbar ivag-autohide ivag-tooltip-top">
                                             <div class="ivag-volume-bg"></div>
                                             <div class="ivag-volume-level"></div>
                                          </div>
                                    </div>
                                      
                                    <!-- playback time -->   
                                    <p class="ivag-media-time-current">0:00</p>
                                    <p class="ivag-media-time-separator">&#47;</p>
                                    <p class="ivag-media-time-total">0:00</p>
                                      
                                </div><!-- end ivag-player-controls -->
            
                                <!-- info -->   
                                <div class="ivag-info-holder">
                                    <div class="ivag-info-bg"></div>
                                    <div class="ivag-info-close ivag-tooltip-left" data-ivagtooltip="Close"><i class="fa fa-times ivag-info-close-i ivag-icon-color"></i></div>
                                    <div class="ivag-info-container"><div class="ivag-info-inner"></div></div>
                                </div>
                                 
                                <!-- embed -->    
                                <div class="ivag-embed-holder">
                                    <div class="ivag-embed-bg"></div>
                                    <div class="ivag-embed-close ivag-tooltip-left" data-ivagtooltip="Close"><i class="fa fa-times ivag-info-close-i ivag-icon-color"></i></div>
                                    <div class="ivag-embed-container">
                                 
                                        <div class="ivag-embed-player-title">EMBED THIS PLAYER</div>
                                        <div class="ivag-embed-player-cont"><div class="ivag-embed-player-copy-btn">COPY</div><div class="ivag-embed-player"></div></div>
                                         
                                        <div class="ivag-link-player-title">LINK THIS PLAYER</div>
                                        <div class="ivag-link-player-cont"><div class="ivag-link-player-copy-btn">COPY</div><div class="ivag-link-player"></div></div>
                                 
                                    </div>
                                </div><!-- end ivag-embed-holder -->
            
                                <div class="ivag-download-confirm"><p>DOWNLOAD STARTED!</p></DIV> 
                                
                            </div><!-- end ivag-player-holder -->
                             
                            <div class="ivag-context-menu">
                                <ul>
                                    <li class="ivag-context-play"><span>Play</span></li>
                                    <li class="ivag-context-mute"><span>Mute</span></li>
                                    <li class="ivag-context-fs"><span>Fullscreen</span></li>
                                    <li class="ivag-context-copyright"><span><a href="https://www.seoulauction.com" target="_blank">@SeoulAuction</a></span></li>
                                </ul>   
                            </div>    
            
                        </div><!-- end ivag-wrapper -->
            
                    </div><!-- end ivag-main -->
            
            
                    <div id="ivag-bottom">
            
                        <div class="ivag-playlist-holder">
            
                            <div class="ivag-playlist">
                                <div class="ivag-playlist-inner"><div class="ivag-playlist-content"></div></div>
                            </div>
                                 
                        </div><!-- end ivag-playlist-holder --> 
            
                    </div> 
                    
            
            
            
            
                     <!-- PLAYLIST -->
            
                     <div id="ivag-playlist-list">
                         <div class="ivag-playlist-item" data-id="video1" data-type="video" data-mp4="../media/video/1/main/01.mp4" data-poster="../media/video/1/main/01.jpg" data-thumb="../media/video/1/thumb/01.jpg" data-download="../media/video/1/main/01.mp4" data-video-preview="../media/video/1/thumb/01.mp4" data-aspect-ratio="1"> 
                            
                              <div class="ivag-title">This is a title</div>  
                            
                              <div class="ivag-short-desc">This is short description.</div>
                            
                              <div class="ivag-desc">
                                  This is long description. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in neque.
                              </div>
                           
                         </div>
                
                         <div class="ivag-playlist" id="playlist-youtube-5"> 
                             <!-- youtube channel
                             data-path: channel id  
                             data-limit: number of results to retrieve 
                             -->
                             <div class="ivag-playlist-item" data-id="youtube-channel" data-type="youtube_channel" data-path="UCzVwaQ3T0kDT-2EFBrvf03Q" data-limit="22"></div>
                        </div>
            
                    </div>
            
                    <!-- PLAYLIST -->
                </div>   
            </div> 

			<!--<div class="sub_banner web_only">
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

</div>

<!-- //#wrap -->
<jsp:include page="../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../include/footer.jsp" flush="false" />
