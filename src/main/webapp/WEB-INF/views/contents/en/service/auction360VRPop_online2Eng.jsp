<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seoul Auction</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- <link rel="stylesheet" href="/images/3DVR_Online2/style.css"> --> 
    <link rel="stylesheet" href="/css/sa.common.2.1.css" type="text/css"/>    
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" /> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
</head>
<body style="margin: 0; padding: 0;">  
    <!-- <div class="player_container">
        <div class="cover-outer" style="background-image: url('/images/3DVR_Online2/bg06.jpg');">
            <div class="cover">
                <div class="cover-inner">
                    <img src="/images/3DVR_Online2/logo.png" class="img-logo">

                    <div class="btn-play">
                        <img src="/images/3DVR_Online2/play.png" class="img-play">

                        <p class="text-play">
                            아트시 X 서울옥션 온라인 경매: Summer Breeze, Seoul Auction, Seoul 
                        </p>

                        <p class="text-notice">
                            360VR은 사용자의 브라우저 환경에 따라 사용이 제한 될 수 있습니다. <br class="hidden-mobile">최신 인터넷 브라우저(Microsoft Edge, Chrome, Firefox)로 업데이트하여 사용하는 것을 권장합니다.
                        </p>
                    </div>

                    <img src="/images/3DVR_Online2/provide.png" class="img-provided">
                </div> 
            </div>
        </div>

        <div class="iframe_container"> 
            <iframe src="https://eazel.net/show_vr/1543aa822da8?autoplay=1"
                id="webvr" width="100%" height="100%" frameborder="0" allow-fullscreen>
            </iframe>
        </div>

        <div class="instruction_container">
            <div class="instruction">
                <div class="desktop"> 
                    <img src="/images/3DVR_Online2/desktop_instruction.svg" alt="desktop"/>
                </div>
                <div class="mobile">  
                    <img src="/images/3DVR_Online2/mobile_instruction_1.svg" alt="mobile"/>
                    <img src="/images/3DVR_Online2/mobile_instruction_2.svg" alt="mobile"/>
                </div>
                <div class="skip_btn">
                    <img src="/images/3DVR_Online2/skip_btn.svg" alt="skip"/>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
          var ISMOBILE = /Android|webOS|iPhone|iPad|iPod|BlackBerry|BB|PlayBook|IEMobile|Windows Phone|Kindle|Silk|Opera Mini/i.test(
                navigator.userAgent
            )
            var step = 0
            var instructionContainer = $('.instruction_container')

            if (ISMOBILE) {
                $('.instruction, .player_container').addClass('touch');
            }

            $('.cover-outer').on('click', function(){
                if(ISMOBILE){
                    $('body').attr('style', 'overflow:hidden;');
                }
                $(this).fadeOut(1000);
            });

            $('.skip_btn').click(function() {
                instructionContainer.fadeOut(1000)
            })
        })
    </script>  --> 
    
    <div class="readybox_wrap">       
    	<div class="readybox_position">     
    		<div class="readybox_back">    
    			<div class="readybox_txt">
    				<i class="material-icons"> 
						error_outline   
					</i>    
			    	<p >This page will be updated soon!</p>
			    	<p ng-if="locale!='ko'">Sorry! Thank you!</p>     
			    	<p>  
			    		<a href="/" alt="Home">Home</a>              
			    	</p> 
    			</div>    
    		</div>
    	</div> 
    </div> <!-- //"readybox_wrap" -->  

</body>
</html> 