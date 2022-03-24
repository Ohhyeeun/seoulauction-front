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
		}

		table{table-layout: fixed;}
		.tdcenter {text-align:center; vertical-align:bottom; font-size:14px; font-weight:bold; color:#787878; font-family:"microsoft sans serif"}
		.tdborder {text-align:center; vertical-align:bottom; border-bottom:1px solid #CCCCCC; color:#333333; border-width:1px; font-size:14px; font-weight:bold;}
		.tdcolor {background:#000000; text-align:center; vertical-align:bottom;}
		.input_text{font-family:'microsoft sans serif'; FONT-SIZE: 10pt;background: #FFFFFF;border-width:0pt;text-align:center;font-weight=bold;}
		.input_text_small{font-family:'microsoft sans serif'; FONT-SIZE: 8pt;background: #FFFFFF;border-width:0pt;text-align:center;font-weight=bold;}
		</style>
	</head>
	<body>
		<div class="display_none"><button onClick="javascript:window.print()">print</button></div>
		<table border="0" width="650">
			<tr>
				<td colspan="9" height="20"></td>
			</tr>
			<tr>
				<td align="right" style="font-size:10px; color:#787878; font-family:microsoft sans serif;" colspan="9">
					<u>R<fmt:formatDate value="${now}" type="both" pattern="yyyyMMdd"/>-${fn:trim(saleInfo.SALE_TH)}-<fmt:formatNumber value="${lotInfo.LOT_NO}" pattern="#000"/></u></td>
			</tr>
			<tr>
				<td colspan="9" height="50"></td>
			</tr>
			<tr>
				<td align="center" colspan="9" style="font-size:26px;" height="70">
				<font style="font-size:26px; font-weight:bold; font-family:microsoft sans serif; letter-spacing:1px;">CERTIFICATE OF AUTHENTICITY</font></td>
			</tr>
			<tr>
				<td colspan="3" class="tdcenter" height="32">
					Artist Name
				</td>
				<td colspan="6" class="tdborder"><input class="input_text" type=text value="${lotInfo.ARTIST_NAME_KO_TXT}  ${lotInfo.ARTIST_NAME_EN_TXT}" size="58"><!-- ${artwork.a_name }&nbsp;&nbsp;&nbsp;<font color="#777777">${artwork.a_name_en}</font> -->
			</tr>
			<tr>
				<td colspan="3" class="tdcenter" height="32">
					Title of Work
				</td>
				<td colspan="6" class="tdborder"><input class="input_text" type=text value="${lotInfo.TITLE_KO_TXT}  ${lotInfo.TITLE_EN_TXT}" size="58"><!-- &nbsp;&nbsp;&nbsp;<font color="#777777"></font> --></td>
			</tr>
			<tr>
				<td colspan="3" class="tdcenter" height="32">
					Medium / Technique
				</td>
				<td colspan="6" class="tdborder">
					<input class="input_text" type=text value="${lotInfo.MATE_NM_EN}" size="58">
				</td>
			</tr>
			<tr>
				<td colspan="3" class="tdcenter" height="32">
					Image Size
				</td>
				<td colspan="6" class="tdborder">
					<!-- <c:set var="size" value="${udf:getSizeString2(artwork.width, artwork.length, artwork.height, artwork.size_nxt, artwork.ho, artwork.ho_mod_chk, 'Y', artwork.diameter, artwork.size_pre)}"/> -->
					<input class="input_text" type=text value="${lotInfo.LOT_SIZE_STRING}" size="60" align='center'>
				</td>						
			</tr>
			<tr>
				<c:choose>
					<c:when test="${lotInfo.MAKE_YEAR_KO != '' && lotInfo.MAKE_YEAR_KO != null}">
						<td colspan="3" class="tdcenter"  height="32">
						Year of Work
						</td>
						<td colspan="6" class="tdborder"><input class="input_text" type=text value="${lotInfo.MAKE_YEAR_KO}" size="58">
						</td>
					</c:when>
					<c:otherwise>
						<td class="tdcenter" colspan="9">&nbsp;</td>
					</c:otherwise>
				</c:choose>
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
					<!--  <iframe src="https://old-office.seoulauction.com/Report/WorkReport_Warranty_Img.asp?strImg=${url}" width=500 height=400 scrolling="no" frameborder=0 z-index="-20" align="center" valign="middle"></iframe> -->
					 <!--  <img src="https://www.seoulauction.com/nas_img${lotInfo.LOT_IMG_PATH}/${lotInfo.LOT_IMG_NAME}" width=500 height=400 scope="request"/> -->
					 <!--  <iframe src="https://www.seoulauction.com/nas_img${lotInfo.LOT_IMG_PATH}/${lotInfo.LOT_IMG_NAME}" width=500 height=400 scrolling="no" frameborder=0 z-index="-20" align="center" valign="middle"></iframe> -->
					 
					 <c:set var="url" value="https://www.seoulauction.com/nas_img${lotInfo.LOT_IMG_PATH}/${lotInfo.LOT_IMG_NAME}" scope="request"/>
					 <iframe src="http://old-office.seoulauction.com/Report/WorkReport_Warranty_Img.asp?strImg=${url}" width=500 height=400 scrolling="no" frameborder=0 z-index="-20" align="center" valign="middle"></iframe>

				</td>
			</tr>
			<tr>
				<td colspan="9" height="5"></td>
			</tr>
			<tr>
				<%
					SimpleDateFormat dateEn = new SimpleDateFormat("EEE d MMM yyyy", Locale.ENGLISH);
					
				%>
				<td colspan="9" align="center" style="font-size:12px; font-family:바탕;" height="20" ><span style="color:#333333;">
				(주)서울옥션은 <fmt:formatDate type="both" pattern="yyyy년 M월 dd일"  value="${saleInfo.TO_DT}" />자 경매에 거래된 상기작품의 기술된 내용을 서울옥션의 약관에 따라 保證합니다.<br>
					</span>
				</td>
			</tr>
			<tr>
				<td colspan="9" align="center" style="font-size:12px;" height="25">
				<fmt:setLocale value="en_US" scope="session"/>
				<fmt:parseDate value="${saleInfo.TO_DT}" var="dateFmt" pattern="yyyy-MM-dd"/>
				We guarantee the authenticity of this work sold on <fmt:formatDate value="${dateFmt}" pattern="EEE, d MMM yyyy"  timeZone="${zn}"/> in Art Auction<!-- ${auction.title_en} -->
				</td>
			</tr>
			<tr>
				<td colspan="9"></td>
			</tr>
			<tr>
				<td colspan="9" align="right" height="30" valign="middle">
					<span style="font-size:12px; font-weight:bold;">Date <fmt:formatDate type="both" pattern="yyyy.MM.dd"  value="${now}" /></span>
				</td>
			</tr>
			
			<tr>
				<td colspan="3"></td>
				<td colspan="6" height="110" align="right" valign="middle">
					<img src="http://old-office.seoulauction.com/images/logo_stamp.jpg" style="align:center" height="100"/>
				</td>
			</tr>
			<tr>
				<td colspan="3"><img src="http://old-office.seoulauction.com/images/report_logo.jpg" style="align:center" width="150"/></td>
				<td colspan="6" align ="right" valign="bottom" style="font-style:italic; font-size:9px; font-family:microsoft sans serif; word-spacing:2px;">
					<span style="color:#787878;">24, Pyeongchang 30-gil, Jongno-gu, Seoul, Korea, 110-846<br/>  Tel.+82-2-395-0330  Fax.+82-2-395-0338</span>
				</td>
			</tr>
		</table>
	</body>
</html>
