<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

				<ul>
                    <!--<li>
						<a href="/search"><spring:message code="label.artwork.search" /></a>
					</li>-->
                    <c:if test="${is_korean}"> 
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"academy\") > -1}'>sele</c:if>">
						<a href="/service/page?view=academy"><spring:message code="label.academy" /></a>
						<div class="sub_menu02">
							<ul>
                            	<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"academyArtculture\") > -1}'>sele</c:if>"><a href="/service/page?view=academyArtculture"><span ng-if="academyNewCnt.ARTCULTURE_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.artculture" /></a></li>
                                
                                <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"academyArtisttalk\") > -1}'>sele</c:if>"><a href="/service/page?view=academyArtisttalk"><span ng-if="academyNewCnt.ARTISTTALK_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.artisttalk" /></a></li> 
                                
                                <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"academyArtbrunch\") > -1}'>sele</c:if>"><a href="/service/page?view=academyArtbrunch"><span ng-if="academyNewCnt.ARTBRUNCH_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.artbrunch" /></a></li> 
                                
                                <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"academyArtauction\") > -1}'>sele</c:if>"><a href="/service/page?view=academyArtauction"><span ng-if="academyNewCnt.ARTAUCTION_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.artauction" /></a></li>
                                
								<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"academyCulture\") > -1}'>sele</c:if>"><a href="/service/page?view=academyCulture"><span ng-if="academyNewCnt.CULTURE_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.culture" /></a></li>  
                                
                                <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"academyLecture\") > -1}'>sele</c:if>"><a href="/service/page?view=academyLecture"><span ng-if="academyNewCnt.LECTURE_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.lecture" /></a></li> 
                                
								<!-- <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"academyArtBusan\") > -1}'>sele</c:if>"><a href="/service/page?view=academyArtBusan"><span ng-if="academyNewCnt.ARTBUSAN_NEW > 0"><font color="red">✔</font></span><spring:message code="label.academy.artbusan" /></a></li> --> 
                                
							</ul>
						</div> 
                    </li>  
					</c:if>
                    <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"corporationArtwork\") > -1}'>sele</c:if>">
						<a href="/service/page?view=corporationArtwork"><spring:message code="label.company.artwork" /></a>
					</li> 
                     
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"rentExhibitionCenter\") > -1}'>sele</c:if>">
						<a href="/service/page?view=rentExhibitionCenter"><spring:message code="label.space.rental" /></a> 
					</li>
					
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"securedLoan\") > -1}'>sele</c:if>">
						<a href="/service/page?view=securedLoan"><spring:message code="label.collateral.loan" /></a>
					</li> 
					
<%--					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"chinaArtwork\") > -1}'>sele</c:if>">--%>
<%--						<a href="/service/page?view=chinaArtwork"><spring:message code="label.china.artwork.auth" /></a>--%>
<%--					</li>--%>
					
					<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"storage\") > -1}'>sele</c:if>">
						<a href="/service/page?view=storageInsa"><spring:message code="label.artwork.keep" /></a>
						<div class="sub_menu02"> 
							<ul>
								<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"storageInsa\") > -1}'>sele</c:if>"><a href="/service/page?view=storageInsa"><spring:message code="label.artwork.keep.insa" /></a></li>
								<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"storageJangheung\") > -1}'>sele</c:if>"><a href="/service/page?view=storageJangheung"><spring:message code="label.artwork.keep.jangheung" /></a></li> 
								<li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"storagePyeongchang\") > -1}'>sele</c:if>"><a href="/service/page?view=storagePyeongchang"><spring:message code="label.artwork.keep.Pyeongchang" /></a></li>         
							</ul>       
						</div> 
					</li>  
					
					<!-- <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"ArtDonations\") > -1}'>sele</c:if>"> 
						<a href="/service/page?view=ArtDonations"><spring:message code="label.company.artwork-artdonation" /></a> 
					</li> --> 
					<c:if test="${is_korean}">
                        <li class="<c:if test='${fn:indexOf(pageContext.request.requestURI,\"Newsletter\") > -1}'>sele</c:if>">
                            <a href="/service/page?view=Newsletter"><spring:message code="label.newsletter" /></a>
                        </li>   
                    </c:if>    
				</ul>  