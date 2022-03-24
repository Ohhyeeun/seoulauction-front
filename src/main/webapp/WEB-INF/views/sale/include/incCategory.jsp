<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link href="/css/old/category.css" rel="stylesheet">

									<!-- ********************************************************************************************************************** -->
									<div class="side-option web_only">

									<a class="side-toggle" style="width:70px;"><img src="/images/bg/bg_img34_s.png" alt="CATEGORY" border="0"><p style="color:#ccc; font-size:11px; font-weight:600; padding-top:3px; padding-bottom:3px;">CATEGORY</p></a> 
                                    <div class="side-scroll">   
										<div class="side-toggle-menu"> 
	                                        <!-- 초기화 버튼 -->
	                                        <div class="btn_style01 gray02" style="float:right;">
	                                            <button type="button" ng-click="checkAcateAll()">
	                                                <span ng-if="locale == 'ko'">전체초기화</span>
	                                                <span ng-if="locale != 'ko'">Clear</span>
	                                            </button>
	                                        </div> 
	                                        
	                                        <!-- 1. 카테고리  -->
	                                        <a href="#">
	                                            <span style="font-weight:bold" ng-if="locale == 'ko'">카테고리</span>
	                                            <span style="font-weight:bold" ng-if="locale != 'ko'">Category</span>
	                                            <button type="button" ng-click="checkCateAll();">
	                                                <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">✓ 선택해제</font></span>
	                                                <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">✓ Unchecked</font></span>
	                                            </button>
	                                        </a>
	                                            
	                                        <ul class="hide">
	                                            <div ng-repeat="cate in category" class="standard" flex="50">
	                                                <li style="margin:0 0 0 10px">
	                                                <input type="checkbox" checklist-model="cate_cds" ng-checked="cate_exists(cate.CD_ID, cate_selected)" ng-click="cate_toggle(cate.CD_ID, cate_selected)" /> 
	                                                    <span ng-if="locale=='ko'">{{cate.CD_NM}}</span>
	                                                    <span ng-if="locale!='ko'">{{cate.CD_NM_EN}}</span>
	                                                </li>
	                                            </div>
	                                        </ul>
	                                        
	                                        <!-- 2. 서브카테고리  -->
	                                        <a href="#">
	                                            <span style="font-weight:bold" ng-if="locale == 'ko'">서브카테고리</span>
	                                            <span style="font-weight:bold" ng-if="locale != 'ko'">Sub Category</span>
	                                            <button type="button" ng-click="checkScateAll();">
	                                                <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">✓ 선택해제</font></span>
	                                                <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">✓ Unchecked</font></span>
	                                            </button>
	                                        </a>
	                                            
	                                        <ul class="hide">
	                                            <div ng-repeat="scate in subcategory" class="standard" flex="50">
	                                                <li style="margin:0 0 0 10px">
	                                                <input type="checkbox" checklist-model="scate_cds" ng-checked="scate_exists(scate.CD_ID, scate_selected)" ng-click="scate_toggle(scate.CD_ID, scate_selected)" />
	                                                    <span ng-if="locale=='ko'">{{scate.CD_NM}}</span>
	                                                    <span ng-if="locale!='ko'">{{scate.CD_NM_EN}}</span>
	                                                </li>
	                                            </div>
	                                        </ul>
	                                        
	                                        <!-- 3. 재질  -->
	                                        <a href="#">
	                                            <span style="font-weight:bold" ng-if="locale == 'ko'">재질</span>
	                                            <span style="font-weight:bold" ng-if="locale != 'ko'">Material</span>
	                                            <button type="button" ng-click="checkMateAll();">
	                                                <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">✓ 선택해제</font></span>
	                                                <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">✓ Unchecked</font></span>
	                                            </button>
	                                        </a>
	                                            
	                                        <ul class="hide">
	                                            <div ng-repeat="mate in material" class="standard" flex="50">
	                                                <li style="margin:0 0 0 10px">
	                                                <input type="checkbox" checklist-model="mate_cds" ng-checked="mate_exists(mate.CD_ID, mate_selected)" ng-click="mate_toggle(mate.CD_ID, mate_selected)" />
	                                                    <span ng-if="locale=='ko'"><!--{{mate.CD_NM}}-->{{mate.CD_NM_EN}}</span>
	                                                    <span ng-if="locale!='ko'">{{mate.CD_NM_EN}}</span>
	                                                </li>
	                                            </div>
	                                        </ul>						
	                                        
	                                        <!-- 4. 작가명  -->
	                                        <a href="#">
	                                            <span style="font-weight:bold" ng-if="locale == 'ko'">작가명</span>
	                                            <span style="font-weight:bold" ng-if="locale != 'ko'">Artist</span>
	                                            <button type="button" ng-click="checkArtistAll();">
	                                                <span ng-if="locale=='ko'"><font color="#00acac" style="font-weight:600; margin:0 0 0 10px">✓ 선택해제</font></span>
	                                                <span ng-if="locale!='ko'"><font color="#00acac" style="font-weight:600;">✓ Unchecked</font></span>
	                                            </button>
	                                        </a>
	                                            
	                                        <ul class="hide">
	                                            <div ng-repeat="art in artist" class="standard" flex="50">
	                                                <li style="margin:0 0 0 10px">
	                                                <input type="checkbox" checklist-model="artist_nos" ng-checked="art_exists(art.CD_ID, art_selected)" ng-click="art_toggle(art.CD_ID, art_selected)" />
	                                                    <span ng-if="locale=='ko'">{{art.CD_NM}}</span>
	                                                    <span ng-if="locale!='ko'">{{art.CD_NM_EN}}</span>
	                                                </li>
	                                            </div>
	                                        </ul>
	                                        </div>
                                    </div>
									</div>
									
									<script>
										$(document).ready(function(){
										    $(".side-toggle-menu>a").click(function(){
										        $(this).next("ul").toggleClass("hide");
										    });
										});

										$(".side-toggle").click(function() {
											if($(".side-option").css("margin-right") == "0px") { 
												$(".side-option").animate( {
													marginRight:"-322px"
												});
											}
											if($(".side-option").css("margin-right") == "-322px") {
												$(".side-option").animate( {
													marginRight:"0px"
												});
											}
										});
										/* 없어도 기능 이상 X
										if($(".side-option").css("margin-right") == "-292px") {
											$(".side-option").animate( {
												marginRight:"0px"
											});
										}
										*/
									</script>
