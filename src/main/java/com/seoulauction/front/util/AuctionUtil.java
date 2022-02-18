package com.seoulauction.front.util;

import org.apache.commons.codec.binary.Base64;

import java.nio.charset.StandardCharsets;
import java.security.spec.AlgorithmParameterSpec;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class AuctionUtil {
	public static int getBuyCommHK(String acode, double bid_price){
		double result = 0;
		
		double lowRate = 0.0;
		double midRate = 0.0;
		double highRate = 0.0;
		
		if(acode.equals("MA011200") || acode.equals("MA011301") || acode.equals("MA011500")){
			lowRate = 0.15;
			midRate = 0.12;
			highRate = 0.1;
		}
		else{
			lowRate = 0.18;
			midRate = 0.15;
			highRate = 0.12;
		}
		
		if(bid_price > 8000000){
			result = (400000 * lowRate) + (7600000 * midRate) + ((bid_price - 8000000) * highRate);
		}
		else if(bid_price <= 8000000 && bid_price > 400000){
			result = (400000 * lowRate) + ((bid_price - 400000) * midRate);
		}
		else{
			result = bid_price * lowRate;
		}
		
		return (int)result;
	}
	
	public static int getBuyCommKo(String acode, double bid_price){
		double result = 0;
		
		double lowRate = 0.0;
		double midRate = 0.0;
		double highRate = 0.0;
		
		lowRate = 0.165;
		midRate = 0.132;
		highRate = 0.11;
		
		if(bid_price > 100000000){
			result = (50000000 * lowRate) + (50000000 * midRate) + ((bid_price - 100000000) * highRate);
		}
		else if(bid_price <= 100000000 && bid_price > 50000000){
			result = (50000000 * lowRate) + ((bid_price - 50000000) * midRate);
		}
		else{
			result = bid_price * lowRate;
		}
		
		return (int)result;
	}
	
	public static String getSizeString(double width, double length, double height, String sizeNxt, int ho, String hoModeYn, String inchYn, String diameterYn, String preSize){
		String result = "";
		result = width > 0.0 ? MessageFormat.format("{0,number,#.0}", width) : "";
		result += length > 0.0 ? MessageFormat.format("×{0,number,#.0}", length) : "";
		result += height > 0.0 ? MessageFormat.format("×{0,number,#.0}(H)", height) : "";
		result += !result.equals("") ? "&nbsp;cm" : "";
		result += !sizeNxt.equals("") ? "&nbsp;" + sizeNxt : "";
		
		if(hoModeYn.equals("Y")){
			result += ho != 0 ? MessageFormat.format("&nbsp;(변형{0,number})", ho) : "";
		}
		else{
			result += ho != 0 ? MessageFormat.format("&nbsp;({0,number})", ho) : "";
		}
		
		if(inchYn.equals("Y")){
			result += width > 0.0 ? MessageFormat.format("&nbsp;({0,number,#.0}", width*0.393701) : "";
			result += length > 0.0 ? MessageFormat.format("×{0,number,#.0}", length*0.393701) : "";
			result += height > 0.0 ? MessageFormat.format("×{0,number,#.0}(H)", height*0.393701) : "";
			result += !result.equals("") ? "&nbsp;in)" : "";
		}
		
		result = (diameterYn.equals("Y") ? "직경(Diameter)&nbsp;" : "")  + result ;
		result += !preSize.equals("") ? preSize + result : "";
		
		return result;
	}
	
	public static String getSizeString2(double width, double length, double height, String sizeNxt, int ho, String hoModeYn, String inchYn, String diameterYn, String preSize){
		String result = "";
		result = width > 0.0 ? MessageFormat.format("{0,number,#.0}", width) : "";
		result += length > 0.0 ? MessageFormat.format("×{0,number,#.0}", length) : "";
		result += height > 0.0 ? MessageFormat.format("×{0,number,#.0}(H)", height) : "";
		result += !result.equals("") ? "cm" : "";
		result += !sizeNxt.equals("") ? "&nbsp;" + sizeNxt : "";
		
		if(hoModeYn.equals("Y")){
			result += ho != 0 ? MessageFormat.format("&nbsp;(변형{0,number})", ho) : "";
		}
		else{
			result += ho != 0 ? MessageFormat.format("&nbsp;({0,number})", ho) : "";
		}
		
		if(inchYn.equals("Y")){
			result += width > 0.0 ? MessageFormat.format(",&nbsp;{0,number,#.0}", width*0.393701) : "";
			result += length > 0.0 ? MessageFormat.format("×{0,number,#.0}", length*0.393701) : "";
			result += height > 0.0 ? MessageFormat.format("×{0,number,#.0}(H)", height*0.393701) : "";
			result += !result.equals("") ? "in" : "";
		}
		
		result = (diameterYn.equals("Y") ? "직경(Diameter)&nbsp;" : "")  + result ;
		result += !preSize.equals("") ? preSize + result : "";
		
		return result;
	}
	
	public static Date addYear(Date srcDate, int interval){
		Calendar cal = Calendar.getInstance();
		cal.setTime(srcDate);
		cal.add(Calendar.YEAR, interval);
		return cal.getTime();
	}
	
	public static Date addMonth(Date srcDate, int interval){
		Calendar cal = Calendar.getInstance();
		cal.setTime(srcDate);
		cal.add(Calendar.MONTH, interval);
		return cal.getTime();
	}
	
	public static Date addDate(Date srcDate, int interval){
		Calendar cal = Calendar.getInstance();
		cal.setTime(srcDate);
		cal.add(Calendar.DATE, interval);
		return cal.getTime();
	}
	
	public static Date addHour(Date srcDate, int interval){
		Calendar cal = Calendar.getInstance();
		cal.setTime(srcDate);
		cal.add(Calendar.HOUR, interval);
		return cal.getTime();
	}
	
	public static Date addMinute(Date srcDate, int interval){
		Calendar cal = Calendar.getInstance();
		cal.setTime(srcDate);
		cal.add(Calendar.MINUTE, interval);
		return cal.getTime();
	}
	
	public static Date addSecond(Date srcDate, int interval){
		Calendar cal = Calendar.getInstance();
		cal.setTime(srcDate);
		cal.add(Calendar.SECOND, interval);
		return cal.getTime();
	}
	
	public static String convertLocaleEnDate(Date date){
		SimpleDateFormat dateEn = new SimpleDateFormat("EEE d MMM yyyy", Locale.ENGLISH);
		return dateEn.format(date);
	}

	public static String SSG_AES_KEY = "696d697373796f7568616e6765656e61";

	public static String aesDecryptSSG(String text) throws Exception {
		String decValue = aesDecryptCore(text, SSG_AES_KEY);
		return decValue;
	}

	public static String aesDecryptCore(String text, String key) throws Exception {
		SecretKeySpec spec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "AES");
		Cipher cipher = Cipher.getInstance("AES");
		cipher.init(Cipher.DECRYPT_MODE, spec);
		return new String(cipher.doFinal(Base64.decodeBase64(text.getBytes(StandardCharsets.UTF_8))),"UTF-8");
	}

	public static void setCookie(HttpServletResponse response, String key, String value) {
		Cookie cookie = new Cookie(key, value);
		cookie.setMaxAge(60*60*24);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
}
