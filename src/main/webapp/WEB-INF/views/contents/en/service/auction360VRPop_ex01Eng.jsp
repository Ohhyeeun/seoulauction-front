<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Seoul Auction</title>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/images/3DVR/style.css" />

  <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>

<section id="container">
  <div class="section-inner">
    <div class="inner-inner">
      <img src="/images/3DVR/logo.png" class="img-logo">

       <iframe class="mpp" width="100%" height="100%" src="https://my.matterport.com/show/?m=Kh1ikTUyatM&brand=0&help=0&play=1&qs=1" frameborder="0" allow-fullscreen></iframe>

      <div class="cover-outer" style="background-image: url('/images/3DVR/bg05.jpg');">
        <div class="cover">
          <div class="cover-inner">
            <img src="/images/3DVR/logo.png" class="img-logo">

            <div class="btn-play">
              <img src="/images/3DVR/play.png" class="img-play">

              <p class="text-play">
                Seoul Auction Gangnam Center
              </p>
              <p style="color:#fff;">The 360VR experience could have a limited access due to user's device evironment<br/>
    				Using the most up-to-date Internet browsers for Internet Explorer, Crome, Firefox are recommended</p>
            </div>
          </div>
        </div>
      </div>

      <div class="tutorial" style="background-image: url('/images/3DVR/bg05.jpg');">
        <div class="tutorial-inner">
        	<div class="how-to-outer desktop">
            	<ul class="how-to">	             
	                <img src="/images/3DVR/plus.png.png" class="img-spec">
	             
	              <li class="spec-desktop">
	                <p class="txt-spec">
                  		W, A, S, D Use the key to move forward, left, back and right.
                	</p>

	                <div class="img-outer">
	                  <img src="/images/3DVR/key_wasd.png", class="img-spec-desktop">
	                </div>
	              </li>
	
	              <li class="spec-desktop">
	                <p class="txt-spec">
                  		Drag the left button to look around. Zoom in and out using the mouse wheel.
                	</p>

	                <div class="img-outer">
	                  <img src="/images/3DVR/mouse_drag.png", class="img-spec-desktop">
	                </div>
	
	                <p class="txt-or">
	                 	 or
	                </p>
	
	                <div class="img-outer">
	                  <img src="/images/3DVR/key_arrows.png", class="img-spec-desktop">
	                </div>
	              </li>
	            </ul>
          	</div>

          <button type="submit" class="tutorial-close"></button>
        </div>
      </div>
    </div>
  </div>
</section>

<div id="modal">
  <img src="/images/3DVR/logo.png" class="img-logo">

  <div class="tutorial" style="background-image: url('/images/3DVR/bg05.jpg');">
    <div class="tutorial-inner">
      <div class="how-to-outer">
        <ul class="how-to">
          <li class="spec">
            <img src="/images/3DVR/t1.png" class="img-spec">
          </li>

          <li class="spec">
            <img src="/images/3DVR/t2.png" class="img-spec">
          </li>

          <li class="spec">
            <img src="/images/3DVR/t3.png" class="img-spec">
          </li>

          <li class="spec">
            <img src="/images/3DVR/t4.png" class="img-spec">
          </li>
        </ul>
      </div>

      <button type="submit" class="tutorial-close"></button>
    </div>
  </div>

  <iframe class="mpp-modal" width="100%" src="https://my.matterport.com/show/?m=Kh1ikTUyatM&brand=0&help=0&play=1&qs=1" frameborder="0" allow-fullscreen></iframe>
</div>

<script>
  $(document).ready(function(){
    var ISMOBILE = /Android|webOS|iPhone|iPad|iPod|BlackBerry|BB|PlayBook|IEMobile|Windows Phone|Kindle|Silk|Opera Mini/i.test(navigator.userAgent);
    ISMOBILE ? $('.mpp').remove() : $('.mpp-modal').remove();

    function updateTutorial(){
      var t1 = $('.tutorial-inner').eq(0);
      var t2 = $('.tutorial-inner').eq(1);

      if(t1.width() > 500 && t1.height() > 540){
        t1.find('.how-to-outer').css('max-width', '700px');
        t1.find('.how-to-outer').css('max-height', '450px');
      } else{
        if(t1.width() > t1.height()){
          var max = t1.height() - 40;
        } else{
          var max = t1.width() - 50;
        }
        t1.find('.how-to-outer').css('max-width', max + 'px');
        t1.find('.how-to-outer').css('max-height', max + 'px');
      }

      if(t2.width() > 500 && t2.height() > 500){
        t2.find('.how-to-outer').css('max-width', '450px');
        t2.find('.how-to-outer').css('max-height', '450px');
      } else{
        if(t2.width() > t2.height()){
          var max = t2.height() - 50;
        } else{
          var max = t2.width() - 50;
        }
        t2.find('.how-to-outer').css('max-width', max + 'px');
        t2.find('.how-to-outer').css('max-height', max + 'px');
      }
    }

    $(window).on('resize', function(){
      updateTutorial();
    });

    $('.tutorial').css('display', 'block');
    updateTutorial();

    $('.cover-outer').on('click', function(){
      if(ISMOBILE){
        $('#modal').fadeIn(300);
        $('body').attr('style', 'overflow:hidden;');
        updateTutorial();
      } else{
        $(this).fadeOut('slow');
      }
    });

    $('.tutorial-close').on('click', function(){
      $('.tutorial').fadeOut(300);
      $('#modal .img-logo').fadeIn(300);
      $('#modal .modal-close').fadeIn(300);
    });

    $('.modal-close').on('click', function(){
      $('#modal').fadeOut(300);
    });
  });
</script>

</body>
</html>