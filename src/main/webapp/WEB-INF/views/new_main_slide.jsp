<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>   

<meta name="viewport" content="width=device-width, initial-scale=1.0">  

<!-- main-slide.css 추가 -->   
<link rel="stylesheet" href="/css/jquery.bxslider.css">   
<link rel="stylesheet" href="/css/slide_style.css"><!-- slide 소스 변경시 slide_style.css로 하기-->    

<!-- main-slide.js 추가 -->     
<script src="/js/prefixfree.js" type="text/javascript"></script>  
<script src="/resources/js/jquery.bxslider.js" type="text/javascript"></script>
<script src="/js/main.js" type="text/javascript"></script>   


<!-- main-slide layout  --> 
<div class="mainslide_wrap">
		
	<div class="slider"> 
	    <!-- 슬라이드 한장  (썸네일 실행 안됨)-->  
        <div class="slide_box">     
            <div class="slide_box_back clearfix"> 
            	<img src="/nas_img/front/homepage/2020080501_gang.jpg" alt="메인슬라이드 이미지 예시">
            	<!-- <ul>  
            		<li><img src="/nas_img/front/homepage/2020080501_gang.jpg" alt="메인슬라이드 이미지 예시"></li>  
            		<li><img src="/nas_img/front/homepage/2020080501.jpg" alt="메인슬라이드 이미지 예시"></li>
            		<li><img src="/nas_img/front/homepage/2020080504.jpg" alt="메인슬라이드 이미지 예시"></li>
            	</ul>   -->   
            </div> 
           
            <div class="slide_box_info_txt clearfix">   
                <div class="web_slide_txt_wrap"> 
                    <div class="head_tit01">  
                        <h3>제 32회</h3> 
                        <h1>HONG KONG SALE </h1>
                        <h4 style="font-size: 14px;">[Auction]</h4>
                        <p class="web_slide_txt">
                            2020.7.16(木) 5pm (KST)<br/>
                     		서울옥션 강남센터   
                        </p> 
                    </div>
                    <div class="head_tit01"> 
                        <h4 style="font-size: 14px;">[Preview]</h4> 
                        <p> 단락 나눌때 사용 클래스  
                            <strong>서울:</strong> 2020.6.20 - 2020.6.28<br/>  
                            10am - 7pm (KST)<br/>  
                            2020.7.10(金) - 2020.7.16(木) 10am - 7pm (KST)<br/> 
                        	서울옥션 강남센터 5, 6층 02-545-0330   
                        </p>  
                        <p> 단락 나눌때 사용 클래스 
                            <strong>부산:</strong> 2020.7.3(金) - 2020.7.8(水) (10am - 7pm KST)<br/>
                        	서울옥션 부산 051-744-2020 
                        </p>
                        <p>    
                           <strong>홍콩:</strong> 2020.7.6(月) - 2020.7.11(土) (10am - 9pm HKT)<br/>
                            SA+ (11F, H Queen's) 
                        </p> 
                    </div>
                    <div class="slid-btn-wrap">      
                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn green_hover" target="new">작품 보기</a>
                        <a href="/service/page?view=auction360VRPop_hk" class="slid_btn green_hover" target="new">전시장 보기</a>   
                        <a href="/nas_img/front/homepage/e-book/202006_04/index.html" class="slid_btn green_hover" target="new">도록보기</a>
                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">상세 보기</a>    
                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn yellow_hover">Live응찰</a>   
                        <a href="/upcomingAuction?sale_kind=offline_only" class="btn_main_more green" style="width:80px;margin-top:5px;" >안내 보기</a>
                        	<button onclick="changeIMG();">adfasdf</button> 
                        	<script>
		function changeIMG(){
			alert(1111);
		}
		</script>
                    </div> 
                    
                </div> 
            </div> 
            
             
            <div class="sld-thum clearfix">     
				<ul> 
					<li>
						<a href="/nas_img/front/homepage/main_banner_sm/2020080501_gang.jpg">
							<img src="/nas_img/front/homepage/main_banner_sm/2020080501_gang.jpg" al
							t="2019 경매 위탁" style="vertical-align:middle;">
						</a> 
					</li> 
					<li>
						<a href="/nas_img/front/homepage/main_banner_sm/2020080501.jpg">  
							<img src="/nas_img/front/homepage/main_banner_sm/2020080501.jpg" alt="2019 경매 위탁" style="vertical-align:middle;">
						</a> 
					</li>    
					<li>  
						<a href="/nas_img/front/homepage/main_banner_sm/2020080504.jpg"> 
							<img src="/nas_img/front/homepage/main_banner_sm/2020080504.jpg" alt="2019 경매 위탁" style="vertical-align:middle;"> 
						</a>
					</li> 
				</ul>   
			</div> 
    	</div> 
    	
	    
	    <!-- 슬라이드 한장 --> 
	    <div class="slide_wrap_height"> 
	        <div class="slide_box">  
	            <div class="slide_box_back">   
	            
	                <img src="/nas_img/front/homepage/2020080501_kaws.jpg" alt="메인슬라이드 이미지 예시">
	            </div>
	            <div class="slide_box_info_txt">    
	                <div class="web_slide_txt_wrap">
	                    <div class="head_tit01"> 
	                        <h3>문화예찬</h3>
	                        <h1>&#60;마에스트로와 나의 건축&#62; 시즌 2</h1>
	                        <h4 style="font-size: 14px;">[Auction]</h4>
	                        <p class="web_slide_txt">
	                            2020.7.16(木) 5pm (KST)<br/>
                        		서울옥션 강남센터  
	                        </p> 
	                    </div>
	                    <div class="head_tit01"> 
	                        <h4 style="font-size: 14px;">[Preview]</h4>  
	                        <p><!--단락 나눌때 사용 클래스 -->  
	                            2020.9.22 - 2020.12.29 (격주 화요일)<br /> 
	                            7pm - 9pm<br />
	                        	서울옥션 강남센터 3층 아카데미홀<br /> 
	                        </p> 
	                        <p> <!--단락 나눌때 사용 클래스 --> 
	                            02-2075-4425 <br />
	                            kdy@seoulauction.com
	                        </p>  
	                        <!--<p>     
	                            <strong>Hongkong:</strong> (Mon)6 - (Sat)11 July, 2020 (10am - 9pm HKT)<br />
	                            SA+ (11F, H Queen's) 
	                        </p> -->
	                    </div>
	                    <div class="slid-btn-wrap">     
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn green_hover" target="new">작품 보기</a>
	                        <a href="/service/page?view=auction360VRPop_hk" class="slid_btn green_hover" target="new">전시장 보기</a>   
	                        <a href="/nas_img/front/homepage/e-book/202006_04/index.html" class="slid_btn green_hover" target="new">도록보기</a>
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">상세 보기</a>    
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn yellow_hover">Live응찰</a>   
	                        <!--<a href="/upcomingAuction?sale_kind=offline_only" class="btn_main_more green" style="width:80px;margin-top:5px;" >안내 보기</a> -->
	                    </div> 
	                </div> 
	            </div> 
	        </div>
	    </div> <!-- //슬라이드 한장 --> 
	    
	    <!-- 슬라이드 한장 --> 
	    <div class="slide_wrap_height"> 
	        <div class="slide_box">  
	            <div class="slide_box_back">  
	                <img src="/nas_img/front/homepage/2020080501.jpg" alt="메인슬라이드 이미지 예시">
	            </div>
	            <div class="slide_box_info_txt">    
	                <div class="web_slide_txt_wrap">
	                    <div class="head_tit01"> 
	                        <h3>제 32회</h3>
	                        <h1>HONG KONG SALE </h1>
	                        <h4 style="font-size: 14px;">[Auction]</h4>
	                        <p class="web_slide_txt">
	                            2020.7.16(木) 5pm (KST)<br/>
	                        	서울옥션 강남센터  
	                        </p> 
	                    </div>
	                    <div class="head_tit01"> 
	                        <h4 style="font-size: 14px;">[Preview]</h4>  
	                        <p><!--단락 나눌때 사용 클래스 -->  
	                            <strong>Seoul:</strong> (Sat)20 - (Sun)28 June, 2020 10am - 7pm (KST)<br />
	                            (Fri)10 - (Thu)16 July, 2020 10am - 7pm (KST)<br />
	                            Seoul Auction Gangnam Center 5, 6F <br /> 
	                            (864, Eonju-ro, Gangnam-gu, Seoul, Korea) 
	                        </p> 
	                        <p> <!--단락 나눌때 사용 클래스 --> 
	                            <strong>Busan:</strong> (Fri)3 - (Wed)8 July, 2020 (10am - 7pm KST)<br />
	                            Seoul Auction Busan <br /> 
	                            (14-3, Jwasuyeong-ro 125beon-gil, Suyeong-gu, Busan, Korea)
	                        </p>
	                        <p>    
	                            <strong>Hongkong:</strong> (Mon)6 - (Sat)11 July, 2020 (10am - 9pm HKT)<br />
	                            SA+ (11F, H Queen's) 
	                        </p> 
	                    </div>
	                    <div class="slid-btn-wrap">     
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn green_hover" target="new">작품 보기</a>
	                        <a href="/service/page?view=auction360VRPop_hk" class="slid_btn green_hover" target="new">전시장 보기</a>   
	                        <a href="/nas_img/front/homepage/e-book/202006_04/index.html" class="slid_btn green_hover" target="new">도록보기</a>
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">상세 보기</a>    
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn yellow_hover">Live응찰</a>   
	                        <!--<a href="/upcomingAuction?sale_kind=offline_only" class="btn_main_more green" style="width:80px;margin-top:5px;" >안내 보기</a> -->
	                    </div> 
	                </div> 
	            </div> 
	        </div>
	    </div> <!-- //슬라이드 한장 --> 
	    
	    <!-- 슬라이드 한장 -->
	    <div class="slide_wrap_height"> 
	        <div class="slide_box">   
	            <div class="slide_box_back">  
	                <img src="/nas_img/front/homepage/2020080505.jpg" alt="메인슬라이드 이미지 예시"> 
	            </div>
	            <div class="slide_box_info_txt">    
	                <div class="web_slide_txt_wrap">
	                    <div class="head_tit01"> 
	                        <h3>제 32회</h3>
	                        <h1>HONG KONG SALE </h1>
	                        <h4 style="font-size: 14px;">[Auction]</h4>
	                        <p class="web_slide_txt">
	                            2020.7.16(木) 5pm (KST)<br/>
	                        	서울옥션 강남센터 
	                        </p> 
	                    </div>
	                    <div class="head_tit01"> 
	                        <h4 style="font-size: 14px;">[Preview]</h4>  
	                        <p><!--단락 나눌때 사용 클래스 -->  
	                            <strong>서울:</strong> 2020.6.20 - 2020.6.28<br/>  
	                            10am - 7pm (KST)<br/> 
	                            2020.7.10(金) - 2020.7.16(木) 10am - 7pm (KST)<br/> 
	                        	서울옥션 강남센터 5, 6층 02-545-0330  
	                        </p> 
	                        <p> <!--단락 나눌때 사용 클래스 --> 
	                            <strong>부산:</strong> 2020.7.3(金) - 2020.7.8(水) (10am - 7pm KST)<br/>
	                        	서울옥션 부산 051-744-2020
	                        </p>
	                        <p>    
	                           <strong>홍콩:</strong> 2020.7.6(月) - 2020.7.11(土) (10am - 9pm HKT)<br/>
	                            SA+ (11F, H Queen's)
	                        </p> 
	                    </div>
	                    <div class="slid-btn-wrap">     
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn green_hover" target="new">작품 보기</a>
	                        <a href="/service/page?view=auction360VRPop_hk" class="slid_btn green_hover" target="new">전시장 보기</a>   
	                        <a href="/nas_img/front/homepage/e-book/202006_04/index.html" class="slid_btn green_hover" target="new">도록보기</a>
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">상세 보기</a>    
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn yellow_hover">Live응찰</a>   
	                        <!--<a href="/upcomingAuction?sale_kind=offline_only" class="btn_main_more green" style="width:80px;margin-top:5px;" >안내 보기</a> -->
	                    </div> 
	                </div>  
	            </div> 
	        </div>
	    </div> <!-- //슬라이드 한장 --> 
	    
	    <!-- 슬라이드 한장 --> 
	    <div class="slide_wrap_height">  
	        <div class="slide_box">   
	            <div class="slide_box_back">   
	                <img src="/nas_img/front/homepage/2020080502.jpg" alt="메인슬라이드 이미지 예시">
	            </div>
	            <div class="slide_box_info_txt">     
	                <div class="web_slide_txt_wrap">
	                    <div class="head_tit01"> 
	                        <h3>제 32회</h3>
	                        <h1>HONG KONG SALE </h1>
	                        <h4 style="font-size: 14px;">[Auction]</h4>
	                        <p class="web_slide_txt">
	                            2020.7.16(木) 5pm (KST)<br/>
	                        	서울옥션 강남센터  
	                        </p> 
	                    </div>
	                    <div class="head_tit01"> 
	                        <h4 style="font-size: 14px;">[Preview]</h4>  
	                        <p><!--단락 나눌때 사용 클래스 -->  
	                            <strong>Seoul:</strong> (Sat)20 - (Sun)28 June, 2020 10am - 7pm (KST)<br />
	                            (Fri)10 - (Thu)16 July, 2020 10am - 7pm (KST)<br />
	                            Seoul Auction Gangnam Center 5, 6F <br /> 
	                            (864, Eonju-ro, Gangnam-gu, Seoul, Korea) 
	                        </p> 
	                        <p> <!--단락 나눌때 사용 클래스 --> 
	                            <strong>Busan:</strong> (Fri)3 - (Wed)8 July, 2020 (10am - 7pm KST)<br />
	                            Seoul Auction Busan <br /> 
	                            (14-3, Jwasuyeong-ro 125beon-gil, Suyeong-gu, Busan, Korea)
	                        </p>
	                        <p>    
	                            <strong>Hongkong:</strong> (Mon)6 - (Sat)11 July, 2020 (10am - 9pm HKT)<br />
	                            SA+ (11F, H Queen's) 
	                        </p> 
	                    </div>
	                    <div class="slid-btn-wrap">     
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn green_hover" target="new">작품 보기</a>
	                        <a href="/service/page?view=auction360VRPop_hk" class="slid_btn green_hover" target="new">전시장 보기</a>   
	                        <a href="/nas_img/front/homepage/e-book/202006_04/index.html" class="slid_btn green_hover" target="new">도록보기</a>
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">상세 보기</a>    
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn yellow_hover">Live응찰</a>   
	                        <!--<a href="/upcomingAuction?sale_kind=offline_only" class="btn_main_more green" style="width:80px;margin-top:5px;" >안내 보기</a> --> 
	                    </div> 
	                </div> 
	            </div> 
	        </div>
	    </div> <!-- //슬라이드 한장 --> 
	    
	    <!-- 슬라이드 한장 --> 
	    <div class="slide_wrap_height"> 
	        <div class="slide_box">  
	            <div class="slide_box_back">  
	                <img src="/nas_img/front/homepage/2020080501.jpg" alt="메인슬라이드 이미지 예시">
	            </div>
	            <div class="slide_box_info_txt">    
	                <div class="web_slide_txt_wrap">
	                    <div class="head_tit01"> 
	                        <h3>제 32회</h3>
	                        <h1>HONG KONG SALE </h1>
	                        <h4 style="font-size: 14px;">[Auction]</h4>
	                        <p class="web_slide_txt">
	                            2020.7.16(木) 5pm (KST)<br/>
	                        	서울옥션 강남센터  
	                        </p> 
	                    </div>
	                    <div class="head_tit01"> 
	                        <h4 style="font-size: 14px;">[Preview]</h4>  
	                        <p><!--단락 나눌때 사용 클래스 -->   
	                            <strong>Seoul:</strong> (Sat)20 - (Sun)28 June, 2020 10am - 7pm (KST)<br />
	                            (Fri)10 - (Thu)16 July, 2020 10am - 7pm (KST)<br />
	                            Seoul Auction Gangnam Center 5, 6F <br /> 
	                            (864, Eonju-ro, Gangnam-gu, Seoul, Korea) 
	                        </p> 
	                        <p> <!--단락 나눌때 사용 클래스 --> 
	                            <strong>Busan:</strong> (Fri)3 - (Wed)8 July, 2020 (10am - 7pm KST)<br />
	                            Seoul Auction Busan <br /> 
	                            (14-3, Jwasuyeong-ro 125beon-gil, Suyeong-gu, Busan, Korea)
	                        </p>
	                        <p>     
	                            <strong>Hongkong:</strong> (Mon)6 - (Sat)11 July, 2020 (10am - 9pm HKT)<br />
	                            SA+ (11F, H Queen's) 
	                        </p> 
	                    </div>
	                    <div class="slid-btn-wrap">      
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn green_hover" target="new">작품 보기</a>
	                        <a href="/service/page?view=auction360VRPop_hk" class="slid_btn green_hover" target="new">전시장 보기</a>   
	                        <a href="/nas_img/front/homepage/e-book/202006_04/index.html" class="slid_btn green_hover" target="new">도록보기</a>
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">상세 보기</a>    
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn yellow_hover">Live응찰</a>   
	                        <!--<a href="/upcomingAuction?sale_kind=offline_only" class="btn_main_more green" style="width:80px;margin-top:5px;" >안내 보기</a> -->
	                    </div> 
	                </div> 
	            </div> 
	        </div>
	    </div> <!-- //슬라이드 한장 --> 
	    
	    <!-- 슬라이드 한장 --> 
	    <div class="slide_wrap_height"> 
	        <div class="slide_box">   
	            <div class="slide_box_back">  
	                <img src="/nas_img/front/homepage/2020080501.jpg" alt="메인슬라이드 이미지 예시">
	            </div>
	            <div class="slide_box_info_txt">    
	                <div class="web_slide_txt_wrap">
	                    <div class="head_tit01"> 
	                        <h3>제 32회</h3>
	                        <h1>HONG KONG SALE </h1>
	                        <h4 style="font-size: 14px;">[Auction]</h4>
	                        <p class="web_slide_txt">
	                            2020.7.16(木) 5pm (KST)<br/>
	                        	서울옥션 강남센터  
	                        </p> 
	                    </div>
	                    <div class="head_tit01"> 
	                        <h4 style="font-size: 14px;">[Preview]</h4>  
	                        <p><!--단락 나눌때 사용 클래스 -->  
	                            <strong>Seoul:</strong> (Sat)20 - (Sun)28 June, 2020 10am - 7pm (KST)<br />
	                            (Fri)10 - (Thu)16 July, 2020 10am - 7pm (KST)<br />
	                            Seoul Auction Gangnam Center 5, 6F <br /> 
	                            (864, Eonju-ro, Gangnam-gu, Seoul, Korea) 
	                        </p> 
	                        <p> <!--단락 나눌때 사용 클래스 --> 
	                            <strong>Busan:</strong> (Fri)3 - (Wed)8 July, 2020 (10am - 7pm KST)<br />
	                            Seoul Auction Busan <br /> 
	                            (14-3, Jwasuyeong-ro 125beon-gil, Suyeong-gu, Busan, Korea)
	                        </p>
	                        <p> 
	                            <strong>Hongkong:</strong> (Mon)6 - (Sat)11 July, 2020 (10am - 9pm HKT)<br />
	                            SA+ (11F, H Queen's) 
	                        </p> 
	                    </div>
	                    <div class="slid-btn-wrap">     
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn green_hover" target="new">작품 보기</a>
	                        <a href="/service/page?view=auction360VRPop_hk" class="slid_btn green_hover" target="new">전시장 보기</a>   
	                        <a href="/nas_img/front/homepage/e-book/202006_04/index.html" class="slid_btn green_hover" target="new">도록보기</a>
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">상세 보기</a>    
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/about/page?view=gnExhibition" class="slid_btn green_hover">작가 보기</a> 
	                        <a href="/currentAuction?sale_kind=offline_only&sale_no=566" class="slid_btn yellow_hover">Live응찰</a>   
	                        <!--<a href="/upcomingAuction?sale_kind=offline_only" class="btn_main_more green" style="width:80px;margin-top:5px;" >안내 보기</a> -->
	                    </div> 
	                </div>  
	            </div> 
	        </div>
	    </div> <!-- //슬라이드 한장 -->   
	    
	    
    
	</div> <!-- //slider -->
	
</div> <!-- //mainslide_wrap -->

