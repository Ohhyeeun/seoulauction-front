<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko"> 
<head>
    <meta charset="UTF-8">
    <title>서울옥션</title>  
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    
	<!-- <link rel="stylesheet" href="/images/3DVR_Online1/style.css"> --> 
	 
    <link rel="stylesheet" href="/css/sa.common.2.1.css" type="text/css"/>    
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" /> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script> 
</head>
<body style="padding: 0; margin: 0;">    
    <!-- <div class="player_container">  
        <div class="cover-outer" style="background-image: url('/images/3DVR_Online1/bg31.jpg');">  
            <div class="cover">
                <div class="cover-inner"> 
                    <img src="/images/3DVR_Online1/logo.png" class="img-logo">   

                    <div class="btn-play">  
                        <img src="/images/3DVR_Online1/play.png" class="img-play">

                        <p class="text-play">     
                            161st 서울옥션 미술품경매
                        </p>

                        <p class="text-notice">
                            360VR은 사용자의 브라우저 환경에 따라 사용이 제한 될 수 있습니다. <br class="hidden-mobile">최신 인터넷 브라우저(Microsoft Edge, Chrome, Safari)로 업데이트하여 사용하는 것을 권장합니다.
                        </p>
                    </div>  

                    <img src="/images/3DVR_Online1/provide.png" class="img-provided">
                </div>  
            </div>
        </div>

        <div class="iframe_container">
            <iframe src="https://eazel.net/show_vr/471a048a8e4d?autoplay=1"
                id="webvr" width="100%" height="100%" frameborder="0" allow-fullscreen>
            </iframe> 

            <img src="/images/3DVR_Online1/logo.png" class="img-logo">
        </div>

        <div class="instruction_container">
            <div class="instruction">  
                <div class="desktop"> 
                    <img src="/images/3DVR_Online1/desktop_instruction.svg" alt="desktop"/>
                </div>
                <div class="mobile">
                    <img src="/images/3DVR_Online1/mobile_instruction_1.svg" alt="mobile"/>
                    <img src="/images/3DVR_Online1/mobile_instruction_2.svg" alt="mobile"/>
                </div>
                <div class="skip_btn">
                    <img src="/images/3DVR_Online1/skip_btn.svg" alt="skip"/>
                </div>
            </div>
        </div> 
    </div>

	<script>
        $(document).ready(function () {
            var ISMOBILE = /Android|webOS|iPhone|iPad|iPod|BlackBerry|BB|PlayBook|IEMobile|Windows Phone|Kindle|Silk|Opera Mini/i.test(
                navigator.userAgent
            )

            if (ISMOBILE) {
                $('.instruction, .player_container').addClass('touch');
            }

            $('.cover-outer').on('click', function(){
                if(ISMOBILE){
                    $('body').attr('style', 'overflow:hidden;');
                }
                $(this).fadeOut(1000);
            })

            $('.skip_btn').click(function() {
                $('.instruction_container').fadeOut(1000)
            })
        }); 
    </script> --> 
     
    <div class="readybox_wrap">       
    	<div class="readybox_position">     
    		<div class="readybox_back">    
    			<div class="readybox_txt">
    				<i class="material-icons"> 
						error_outline 
					</i>   
			    	<p>페이지 준비 중입니다.</p>
			    	<p>이용에 불편을 드려 죄송합니다.</p>
			    	<p>  
			    		<a href="/" alt="홈으로">홈으로</a>           
			    		<!-- <a ng-if="locale=='en'" href="/" alt="홈으로">Home</a> -->            
			    	</p> 
    			</div>    
    		</div>
    	</div> 
    </div> <!-- //"readybox_wrap" --> 
        
    </body>
</html>  