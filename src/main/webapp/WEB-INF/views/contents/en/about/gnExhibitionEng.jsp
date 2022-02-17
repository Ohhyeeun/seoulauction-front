<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../../../include/header.jsp" flush="false"/>

<body>
<jsp:include page="../../../include/topSearch.jsp" flush="false"/>

<div id="wrap">
	<jsp:include page="../../../include/topMenu.jsp" flush="false"/>
	<div class="container_wrap">

		<div id="container"> 
			<div class="sub_menu_wrap menu03">
				<div class="sub_menu">
					<jsp:include page="../../include/gangSubMenu.jsp" flush="false"/>
				</div> 
				<button type="button" class="m_only btn_submenu"><span class="hidden">메뉴보기</span></button>
			</div> 
			<!-- //sub_menu_wrap --> 

			<div class="contents_wrap">   
				<div class="contents">  
                    <div class="tit_h2"> 
						<h2>SA Gangnam Center Exhibition</h2>   
					</div> 
 					<!-- 전시썸네일 이미지 슬라이드 -->       
					<div class="sub_banner02" id="slides">     
						<a href="" class="sp_btn slidesjs-previous slidesjs-navigation"><span class="hidden">이전</span></a> 
						<a href="" class="sp_btn slidesjs-next slidesjs-navigation"><span class="hidden">다음</span></a>  
						<!-- 세로이미지 일 때 -->  
						<div><img class="verticalimg_slide" src="/images/img/gnag/img_banner31.jpg" alt="gangnam" /></div> 
						<div><img class="verticalimg_slide" src="/images/img/gnag/img_banner32.jpg" alt="gangnam" /></div>  
						<!-- 가로이미지  일 때 -->    
						<!-- <div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div>
                        <div><img src="/images/img/gnag/img_banner11.jpg" alt="gangnam" /></div> -->   
					</div> 
					  
					<!-- 전시썸네일 이미지 단일 -->   
                    <!-- <div class="exhibition_img_box">     
                     	<img src="/images/img/gnag/img_banner29.jpg" alt="강남전시 배너" style="margin-bottom: 10px;"/>                
                    </div>   
                    <div class="exhibition_img_box">     
                     	<img src="/images/img/gnag/img_banner30.jpg" alt="강남전시 배너" />                           
                    </div> -->        
                    
                    <div class="storage_cont title_area">   
                    	<div class="exhibition_firstbox"> 
							<div class="title" style="margin-bottom: 10px;">
								<p>Seoul Auction Gangnam Center Exhibition</p>    
								<h3 style="margin-top:10px; font-weight: 800;">Seung H-Sang, Choi DukJoo<br> Landscape Woven, Connected The woven and the connected</h3>        
							</div>  
							<p style="line-height:30px; font-size:16px;">      
	                            (Tue)29 June - (Sun)18 July, 2021<br>
                                10am - 7pm<br>
                                Seoul Auction Gangnam Center 6F
							</p>         
	                        <!--<a href="/currentExhibit?sale_kind=exhibit_only&sale_no=637" class="btn_main_more green exhibiton_listbtn" >LIST</a> 
							<a href="https://www.seoulauction.com/nas_img/front/homepage/e-book/mariKim/index.html" class="btn_main_more green exhibiton_listbtn" target="_blank" >CATALOGUE</a>      
	                        <a href="https://www.seoulauction.com/service/page?view=auction360VRPop_ex"  class="btn_main_more green" style="margin-top:15px;margin-bottom:15px; padding: 15px 45px 17px;font-size: 18px; font-weight:700; color:#FFF; width:120px;" target="new" >EXHIBITION</a> -->
                       	</div>  
                        <div style="border-top: #CCC solid 1px; padding-top: 20px;">               
							<div style="line-height:27px; text-align: justify;">           
                            	<p style="margin-bottom: 15px;">                                                                      
									There are several similarities that unite the jogakbo, a traditional style of Korean patchwork that is created by sewing together pieces of fabric, and furniture that is made according to pre-determined structures/frameworks. The first is a conviction about the resulting shape. The second is the fact that this conviction is based on exhaustive planning and calculations. The final similarity is that a tremendous amount of hard work must be applied. When makers of furniture or patchwork wrapping cloths adhere devotedly to these procedural principles, such veracity alone is sufficient to see the project through. No other inputs are necessary. In other words, keeping faithful to the framework and staying focused on the hand-weaving bring impressive results in themselves.</p>
                                <p style="margin-bottom: 15px;">                                   
	                               Of course, elaborate hand-embroidery and ornamentation can be eye-catching at times. All of the furniture and patchwork wrapping cloth displayed in this exhibition, however, have little to do with hand-embellishment and decoration. The furniture in particular looks simple and calm at first glance, but this impression belies the intense battle in play among the interlocked parts of the framework. This strong presence of conflict allows the furniture to emanate a tension and explains why this exhibition is subtitled “A Monastery for the Self-exiled.” The jogakbo is, from dying to weaving, the outcome of painstaking effort. The dedication to making one stitch after another is the key to success. The thin sheets of fabric in ephemeral colors are packed with an invisible intensity and tenacity.
                                </p>
                                <p style="margin-bottom: 15px;">                                 
    	                            Furniture and jogakbo are rarely displayed side-by-side at the same exhibition. In a sense, things that are woven or connected are part of a world that is beyond the reach of cutting-edge technologies. This exhibition hopes to create a beautiful scene through the unexpected harmony of things that are woven and things that are interlocked. 
                                </p>
                                <p>                                    
	                                May the woven and interlocked presentations on display grant us much-needed rest and solace during these chaotic times.
								</p> 
							</div> 
                            <!-- <p style="font-size:12px; margin-top: 20px;">       
                               <strong>Artists</strong><br/>   
                                David Hockney, George Condo, Julian Opie, Mel Bochner, Yayoi Kusama,<br/> 
                                Ha ChongHyun, Kim TschangYeul, Kwon YoungWoo, Lee Bae, Lee UFan, Park SeoBo, Yee SooKyung, Yoo YoungKuk, etc...<br/> 
                                x<br/> 
                                Børge Mogensen, Charles & Ray Eames, Charlotte Perriand, Hans J.wegner, Johannes Andersen,<br/> 
                                Peter Hvidt & Orla Mølgaard-Nielsen, Kai Kristiansen, Niels Otto Møller, etc...
                            </p> -->  
                        </div>    
                        
						
						<!--<div class="btns mt10">  
							<span class="btn_style01">
								<a href="/about/page?view=location" target="_blank" title="Location">Seoul Auction Location</a>
							</span>
						</div>-->  

						<div class="box_gray type01">
							<div class="contact">  
								<div class="title">Contact</div>     
								<div class="info"> 
									<div class="highlight">Seoul Auction Gangnam Center <strong>Karam Yoon</strong></div>    
									<div class="tel"><strong class="tit">Tel</strong> <span>+82 (0)2-2075-4422</span></div>    
                                    <div class="email"><strong class="tit">E-mail</strong> <a href="mailto:kyoon@seoulauction.com">kyoon@seoulauction.com</a></div>        
								</div>     
							</div>  
							<!-- <div class="right">  
								<span class="btn_style01 icon02"><a href="/customer/inquiryForm" class="fix">Inquiry</a><span class="ico next02"></span></span>
							</div> -->
						</div>
					</div>
                     
                     <div class="storage_cont">	
						<div class="tit_h3 through">
							<h3>Location</h3>
						</div>
						
						<div class="map_area">
							<div class="left">
								<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12655.621508400407!2d127.03040534787746!3d37.533727752054204!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x20893aab0caffe0c!2zKOyjvCnshJzsmrjsmKXshZgg6rCV64Ko7IKs7JilIFNlb3VsIEF1Y3Rpb24gR2FuZ25hbSBCcmFuY2g!5e0!3m2!1sko!2skr!4v1547529016843" width="500" height="350" frameborder="0" style="border:0"></iframe>
							</div>
							<div class="right">
								<div class="title">Seoul Auction Gangnam Center</div>
								<!-- 20150608 -->
								<div class="cont">
									<dl>
										<dt>Road name</dt>
										<dd>864, Eonju-ro, Gangnam-gu, Seoul, Republic of Korea</dd>
									</dl>
									<dl class="bus">
										<dt><img src="/images/icon/bus.jpg" style="width:60px; height:auto;"/></dt>
										<dd>										
											<div>
												<div class="tit"><strong>Shingu Middle school</strong></div>
												<div class="txt"></div>
											</div>
											<div>
												<div class="tit"><strong>Hyundai APT</strong></div>
												<div class="txt"></div>
											</div>
										</dd>
									</dl>
									<dl class="subway">
										<dt><img src="/images/icon/subway.jpg" style="width:60px; height:auto;"/></dt>
										<dd>
											<div class="metro3"><span>Line 3</span> <strong>Apgujeong Station</strong></div> 
										</dd>
									</dl>
								</div>
								<!-- //20150608 -->
							</div>
						</div>
               		</div>
				</div>  
			</div>
		</div>
	</div>
  
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
	</script>
</div>
<!-- //#wrap -->
<jsp:include page="../../../include/footer_in.jsp" flush="false" />
<jsp:include page="../../../include/footer.jsp" flush="false" />  