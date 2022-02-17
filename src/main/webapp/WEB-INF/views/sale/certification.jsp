<%@page import="com.sun.xml.bind.CycleRecoverable.Context"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tld/user_defined_functions.tld" prefix="udf" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<c:set var="now" value="<%=new java.util.Date()%>" scope="request"/>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		
		<link href=href='http://fonts.googleapis.com/earlyaccess/nanumgothic.css' rel='stylesheet' type='text/css' />
		<link href=href='http://fonts.googleapis.com/earlyaccess/nanummyeongjo.css' rel='stylesheet' type='text/css' />

		<style type="text/css">
		@media all {
			header{margin: 0px 0px 0px 0px;}
			body {margin: 0px; padding: 0px 0px 0px 0px; text-align: center; size: 21.0cm 29.7cm;}		
		}
		@media print {
			.display_none{display: none;}
		}
		@page {
			size: 21.0cm 29.7cm;
			margin-top: 10mm;
			margin-left: 15mm;
			margin-right: 15mm;
		}
		
		table{table-layout: fixed;}
		.tdcenter {text-align:center; vertical-align:bottom; font-size:14px; font-weight:bold; color:#787878; font-family:"Nanum Gothic"}
		.tdborder {text-align:center; vertical-align:bottom; border-bottom:1px solid #CCCCCC; color:#333333; border-width:1px; font-size:14px; font-weight:bold;}
		.tdcolor {background:#000000; text-align:center; vertical-align:bottom;}
		.input_text{font-family:'Nanum Gothic'; FONT-SIZE: 10pt;background: #FFFFFF;border-width:0pt;text-align:center;font-weight=bold;}
		.input_text_small{font-family:'Nanum Gothic'; FONT-SIZE: 8pt;background: #FFFFFF;border-width:0pt;text-align:center;font-weight=bold;}
		</style>
	</head>
	<body>
		<div class="display_none"><button onClick="javascript:window.print()">print</button></div>
		<table border="0" width="700">
			<tr>
				<td colspan="9" height="5"></td>
			</tr>
			<tr>
				<td align="right" style="font-size:10px; color:#939393; font-family:Nanum Gothic;" colspan="9">
					
					<c:choose>
						<c:when test="${saleInfo.SALE_KIND_CD == 'main'}">${lotInfo.ARTWORK_NOS}-<fmt:formatDate value="${now}" type="both" pattern="yyyyMMdd"/>-M${fn:trim(saleInfo.SALE_TH)}-<fmt:formatNumber value="${lotInfo.LOT_NO}" pattern="#000"/></c:when>
						<c:when test="${saleInfo.SALE_KIND_CD == 'hongkong'}">${lotInfo.ARTWORK_NOS}-<fmt:formatDate value="${now}" type="both" pattern="yyyyMMdd"/>-HK${fn:trim(saleInfo.SALE_TH)}-<fmt:formatNumber value="${lotInfo.LOT_NO}" pattern="#000"/></c:when>
						<c:when test="${saleInfo.SALE_KIND_CD == 'online'}">${lotInfo.ARTWORK_NOS}-<fmt:formatDate value="${now}" type="both" pattern="yyyyMMdd"/>-O${fn:trim(saleInfo.SALE_TH)}-<fmt:formatNumber value="${lotInfo.LOT_NO}" pattern="#000"/></c:when>
						<c:when test="${saleInfo.SALE_KIND_CD == 'online_zb'}">${lotInfo.ARTWORK_NOS}-<fmt:formatDate value="${now}" type="both" pattern="yyyyMMdd"/>-OZ${fn:trim(saleInfo.SALE_TH)}-<fmt:formatNumber value="${lotInfo.LOT_NO}" pattern="#000"/></c:when>
						<c:when test="${saleInfo.SALE_KIND_CD == 'plan'}">${lotInfo.ARTWORK_NOS}-<fmt:formatDate value="${now}" type="both" pattern="yyyyMMdd"/>-P${fn:trim(saleInfo.SALE_TH)}-<fmt:formatNumber value="${lotInfo.LOT_NO}" pattern="#000"/></c:when>
						<c:when test="${saleInfo.SALE_KIND_CD == 'exhibit'}">${lotInfo.ARTWORK_NOS}-<fmt:formatDate value="${now}" type="both" pattern="yyyyMMdd"/>-EX${fn:trim(saleInfo.SALE_TH)}-<fmt:formatNumber value="${lotInfo.LOT_NO}" pattern="#000"/></c:when>
						<c:when test="${saleInfo.SALE_KIND_CD == 'private'}">${lotInfo.ARTWORK_NOS}-<fmt:formatDate value="${now}" type="both" pattern="yyyyMMdd"/>-PS${fn:trim(saleInfo.SALE_TH)}-<fmt:formatNumber value="${lotInfo.LOT_NO}" pattern="#000"/></c:when>
						<c:otherwise>E</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td colspan="9" height="20"></td>
			</tr>
			<tr>
				<td align="center" colspan="9" style="font-size:26px;" height="70">
				<font style="font-size:30px; font-family:Nanum Gothic; letter-spacing:6px;">CERTIFICATE</font></td>
			</tr>
			
			<tr>
				<td colspan="9" height="430" align="center" valign="middle">
					<!-- <c:choose>
						<c:when test="${fn:substring(artwork.acode, 0, 2) == 'MA'}">
							<c:set var="url" value="https://www.seoulauction.com/auction_works_images/auction/${artwork.acode}/${artwork.img_filename}" scope="request"/>
						</c:when>
						<c:otherwise>
							<c:set var="url" value="https://www.seoulauction.com/auction_works_images/artmarket/${artwork.acode}/${artwork.img_filename}" scope="request"/>
						</c:otherwise>
					</c:choose> -->
					<!-- <img src="https://www.seoulauction.com/nas_img/${artwork.img_filename}?url=${url}&maxWidth=500&maxHeight=350" align="center" valign="middle"> -->
					<!--  <iframe src="http://old-office.seoulauction.com/Report/WorkReport_Warranty_Img.asp?strImg=${url}" width=500 height=400 scrolling="no" frameborder=0 z-index="-20" align="center" valign="middle"></iframe> -->
					 <!--  <img src="https://www.seoulauction.com/nas_img${lotInfo.LOT_IMG_PATH}/${lotInfo.LOT_IMG_NAME}" width=500 height=400 scope="request"/> -->
					 <!--  <iframe src="https://www.seoulauction.com/nas_img${lotInfo.LOT_IMG_PATH}/${lotInfo.LOT_IMG_NAME}" width=500 height=400 scrolling="no" frameborder=0 z-index="-20" align="center" valign="middle"></iframe> -->
					 
					 <c:set var="url" value="https://www.seoulauction.com/nas_img${lotInfo.LOT_IMG_PATH}/${lotInfo.LOT_IMG_NAME}" scope="request"/>
					 <!-- <c:set var="url" value="http://14.63.174.11:8080/nas_img${lotInfo.LOT_IMG_PATH}/${lotInfo.LOT_IMG_NAME}" scope="request"/> -->
					 <iframe src="http://old-office.seoulauction.com/Report/WorkReport_Warranty_Img.asp?strImg=${url}" width=500 height=400 scrolling="no" frameborder=0 z-index="-20" align="center" valign="middle"></iframe>

				</td>
			</tr>
			<tr>
				<td colspan="9" height="25"></td>
			</tr>
			
			<tr><td colspan="9" height="5"><hr size="1" color="#d6d7d8" noshade></td></tr>
			<tr>
				<td colspan="9" class="tdcenter" height="28">
					<!-- <input class="input_text" type=text value="${lotInfo.ARTIST_NAME_KO_TXT}  ${lotInfo.ARTIST_NAME_EN_TXT}" size="58" style="font-size:12px; font-weight:bold; font-family:Nanum Gothic; letter-spacing:1px;"> -->
					<input class="input_text" type=text value="${lotInfo.ARTIST_NAME_KO_TXT}" size="50" style="text-align:right; font-size:13px; font-family:Nanum Gothic; font-color:#050505; letter-spacing:1px;">
					<input class="input_text" type=text value="${lotInfo.ARTIST_NAME_EN_TXT}" size="50" style="text-align:left; font-size:13px; font-family:Nanum Gothic; letter-spacing:1px; color:#A4A4A4;">
				</td>
			</tr>
			<tr>
				<td colspan="9" class="tdcenter" height="28">
					<c:choose>
						<c:when test="${lotInfo.TITLE_KO_TXT == lotInfo.TITLE_EN_TXT}">
							<input class="input_text" type=text value="${lotInfo.TITLE_KO_TXT}" size="110" style="font-size:12px; font-family:Nanum Gothic; letter-spacing:1px;">
						</c:when>
						<c:otherwise>
							<!--  <input class="input_text" type=text value="${lotInfo.TITLE_KO_TXT}  ${lotInfo.TITLE_EN_TXT}" size="58" style="font-size:12px; font-weight:bold; font-family:Nanum Gothic; letter-spacing:1px;"> -->
							<input class="input_text" type=text value="${lotInfo.TITLE_KO_TXT}" size="50" style="text-align:right; font-size:12px; font-family:Nanum Gothic; font-color:#050505; letter-spacing:1px;">
							<input class="input_text" type=text value="${lotInfo.TITLE_EN_TXT}" size="50" style="text-align:left; font-size:12px; font-family:Nanum Gothic; letter-spacing:1px; color:#A4A4A4;">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td colspan="9" class="tdcenter" height="28">
					<c:choose>
						<c:when test="${lotInfo.EDITION == null && lotInfo.MAKE_YEAR_KO != null}">
							<input class="input_text" type=text value="${lotInfo.MATE_NM_EN}   ${lotInfo.LOT_SIZE_STRING}   ${lotInfo.MAKE_YEAR_KO}" size="110" align="center" style="font-size:12px; font-family:Nanum Gothic; font-color:#050505; letter-spacing:1px;">
						</c:when>
						<c:when test="${lotInfo.EDITION == null && lotInfo.MAKE_YEAR_KO == null}">
							<input class="input_text" type=text value="${lotInfo.MATE_NM_EN}   ${lotInfo.LOT_SIZE_STRING}" size="110" align="center" style="font-size:12px; font-family:Nanum Gothic; font-color:#050505; letter-spacing:1px;">
						</c:when>
						<c:when test="${lotInfo.EDITION != null && lotInfo.MAKE_YEAR_KO == null}">
							<input class="input_text" type=text value="${lotInfo.MATE_NM_EN}   ${lotInfo.LOT_SIZE_STRING}   ${lotInfo.EDITION}" size="110" align="center" style="font-size:12px; font-family:Nanum Gothic; font-color:#050505; letter-spacing:1px;">
						</c:when>
						<c:when test="${lotInfo.EDITION != null && lotInfo.MAKE_YEAR_KO != null}">
							<input class="input_text" type=text value="${lotInfo.MATE_NM_EN}   ${lotInfo.LOT_SIZE_STRING}   ${lotInfo.EDITION}   ${lotInfo.MAKE_YEAR_KO}" size="110" align="center" style="font-size:12px; font-family:Nanum Gothic; font-color:#050505; letter-spacing:1px;">
						</c:when>
						<c:otherwise>
							<input class="input_text" type=text value="${lotInfo.MATE_NM_EN}   ${lotInfo.LOT_SIZE_STRING}   ${lotInfo.EDITION}   ${lotInfo.MAKE_YEAR_KO}" size="110" align="center" style="font-size:12px; font-family:Nanum Gothic; font-color:#050505; letter-spacing:1px;">
						</c:otherwise>
					</c:choose>					
				</td>
			</tr>
			<tr><td colspan="9" height="10"></tr>
			<tr><td colspan="9" height="5"><hr size="1" color="#d6d7d8" noshade></td></tr>
			
			<tr><td colspan="9" height="45"></tr>
			<tr>
				<%
					SimpleDateFormat dateEn = new SimpleDateFormat("EEE d MMM yyyy", Locale.ENGLISH);
					
				%>
				<c:if test="${saleInfo.SALE_NO == 408}">
					<td colspan="9" align="center" style="font-size:12px; font-family:'Nanum Myeongjo', serif; " height="20" ><span style="color:#050505;">
					(주)서울옥션은 2017년 부산세일(<fmt:formatDate type="both" pattern="yyyy년 M월 dd일"  value="${saleInfo.TO_DT}" />)에서 거래된 상기작품의 기술된 내용을 약관에 따라 보증합니다.<br></span>
					</td>
				</c:if>
				<c:if test="${saleInfo.SALE_NO == 418}">
					<td colspan="9" align="center" style="font-size:12px; font-family:'Nanum Myeongjo', serif; " height="20" ><span style="color:#050505;">
					(주)서울옥션은 2018년 부산세일(<fmt:formatDate type="both" pattern="yyyy년 M월 dd일"  value="${saleInfo.TO_DT}" />)에서 거래된 상기작품의 기술된 내용을 약관에 따라 보증합니다.<br></span>
					</td>
				</c:if>
				<c:if test="${saleInfo.SALE_NO != 408 && saleInfo.SALE_NO != 418}">
					<td colspan="9" align="center" style="font-size:12px; font-family:'Nanum Myeongjo', serif; " height="20" ><span style="color:#050505;">
					(주)서울옥션은 <c:if test="${saleInfo.SALE_TH != ''}">제${fn:trim(saleInfo.SALE_TH)}회  <c:if test="${saleInfo.SALE_KIND_CD == 'hongkong'}">홍콩</c:if> 경매</c:if><c:if test="${saleInfo.SALE_TH == ''}">${saleInfo.SALE_TITLE_KO}</c:if>(<fmt:formatDate type="both" pattern="yyyy년 M월 dd일"  value="${saleInfo.TO_DT}" />)에서 거래된 상기작품의 기술된 내용을 약관에 따라 보증합니다.<br></span>
					</td>
				</c:if>
			</tr>
			<tr>
				<c:if test="${saleInfo.SALE_NO == 418}">
					<td colspan="9" align="center" style="font-size:11px; font-family:'Nanum Myeongjo', serif;" height="25">
					<fmt:setLocale value="en_US" scope="session"/>
					<fmt:parseDate value="${saleInfo.TO_DT}" var="dateFmt" pattern="yyyy-MM-dd"/><span style="color:#939393;">
					We guarantee the described contents of artwork sold on the 2018 Busan Sale(<fmt:formatDate value="${dateFmt}" pattern="MMM d, yyyy"  timeZone="${zn}"/>) according to the terms and conditions.</span></td>
				</c:if>
				<c:if test="${saleInfo.SALE_NO != 408 && saleInfo.SALE_NO != 418}">
					<td colspan="9" align="center" style="font-size:11px; font-family:'Nanum Myeongjo', serif;" height="25">
					<fmt:setLocale value="en_US" scope="session"/>
					<fmt:parseDate value="${saleInfo.TO_DT}" var="dateFmt" pattern="yyyy-MM-dd"/><span style="color:#939393;">
					We guarantee the described contents of artwork sold on the <c:if test="${saleInfo.SALE_TH != ''}">${fn:trim(saleInfo.SALE_TH)}${fn:trim(saleInfo.SALE_TH_DSP)} <c:if test="${saleInfo.SALE_KIND_CD == 'hongkong'}">Hong Kong</c:if> Auction</c:if><c:if test="${saleInfo.SALE_TH == ''}">${saleInfo.SALE_TITLE_EN}</c:if>(<fmt:formatDate value="${dateFmt}" pattern="MMM d, yyyy"  timeZone="${zn}"/>) according to the terms and conditions.</span></td>
				</c:if>
			</tr>
			
			<tr><td colspan="9" height="40"></tr>
			<tr>
				<td colspan="9" align="right" height="30" valign="middle">
					<span style="font-size:12px; font-family:Nanum Gothic;"><fmt:formatDate type="both" pattern="yyyy.MM.dd"  value="${now}" />&nbsp;&nbsp;&nbsp;</span>
				</td>
			</tr>
			
			<tr>
			<!-- 	<td colspan="3" align="right" valign="middle"></td>
				<td colspan="4" align="right" valign="right">
					<font style="font-size:12px; font-weight:bold; font-family:'Nanum Myeongjo', serif; letter-spacing:1px; font-weight:bold;"><span style="color:#050505;">
						              (주)서울옥션  대표이사  이옥경
						</span><br/><br/>
					</font>
					<font style="font-size:11px; font-family:'Nanum Myeongjo', serif; letter-spacing:1px;"><span style="color:#696666;">	
						SEOUL AUCTION Co., Ltd. President
						<br/>			     Ok-kyung Lee </span>
					</font>
				</td>
				<td colspan="2" height="110" align="right" valign="middle">
					<img src="http://www.seoulauction.com/images/img/sa_stamp.png" style="align:center" height="82"/>
				</td> -->
				<!--  <td colspan="9" height="100" align="right" valign="middle">
					<img src="https://www.seoulauction.com/images/img/sa_stamp_allinone.png" style="align:center" height="87"/>
				</td> -->
				<td colspan="9" height="100" align="right" valign="middle">
					<img src="https://www.seoulauction.com/images/img/sa_stamp_allinone2.jpg" style="align:center" height="92"/>
				</td>
			</tr>
			
			<tr><td colspan="9" height="13"></tr>
			<tr><td colspan="9" ><hr size="2" noshade></td></tr>
			<tr>
				<td colspan="3"><img src="https://www.seoulauction.com/images/img/sa_logo_grey2.jpg" style="align:center" width="190"/></td>
				<td colspan="6" align ="right" valign="middle" style="font-size:9px; font-family:Nanum Gothic; word-spacing:2px;">
					<span style="color:#939393;">24, Pyeongchang 30-gil, Jongno-gu, Seoul, Korea, 03004<br/>  Tel.+82-2-395-0330  Fax.+82-2-395-0338</span>
				</td>
			</tr>
		</table>
	</body>
</html>
