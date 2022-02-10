<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 상점에서 사용하는 include 파일
*	@ PROGRAM NAME		: incMerchant.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2010.10.10
*	@ PROGRAM CONTENTS	: 상점에서 사용하는 include 파일
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*	1	NICEPAY		2010.10.10			상점에서 사용하는 include 파일
*-----  --------    ----------------    ----------------------------------------
*******************************************************************************/
%>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%!
/**
 * 기준날짜에서 몇일 전,후의 날짜를 구한다.
 * @param	sourceTS	기준날짜
 * @param	day			변경할 일수
 * @return	기준날짜에서 입력한 일수를 계산한 날짜
 */
public static Timestamp getTimestampWithSpan(Timestamp sourceTS, long day) throws Exception {
	Timestamp targetTS = null;
	
	if (sourceTS != null) {
		targetTS = new Timestamp(sourceTS.getTime() + (day * 1000 * 60 * 60 * 24));
	}

	return targetTS;
}

/**
 * 현재날짜를 YYYYMMDDHHMMSS로 리턴
 */
public final synchronized String getyyyyMMddHHmmss(){
	/** yyyyMMddHHmmss Date Format */
	SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
	
	return yyyyMMddHHmmss.format(new Date());
}


public class DataEncrypt {
 MessageDigest md;
 String strSRCData = "";
 String strENCData = "";
 String strOUTData = "";
 

 public DataEncrypt() {}

 

public String encrypt(String strData) { // 암호화 시킬 데이터
  try {
   MessageDigest md = MessageDigest.getInstance("MD5"); // "MD5 형식으로 암호화"
   md.reset();
   //byte[] bytData = strData.getBytes();  
   //md.update(bytData);
   md.update(strData.getBytes());
    byte[] digest = md.digest();

  StringBuffer hashedpasswd = new StringBuffer();
    String hx;
    
    for (int i=0;i<digest.length;i++){
    	hx =  Integer.toHexString(0xFF & digest[i]);
    	//0x03 is equal to 0x3, but we need 0x03 for our md5sum
    	if(hx.length() == 1){hx = "0" + hx;}
    	hashedpasswd.append(hx);
    	
    }
    strOUTData = hashedpasswd.toString();
    byte[] raw = strOUTData.getBytes(); 
    byte[] encodedBytes = Base64.encodeBase64(raw);
    strOUTData = new String(encodedBytes);
   }
   catch (NoSuchAlgorithmException e) {
   System.out.print("암호화 에러" + e.toString());
  }
  
  
  return strOUTData;  // 암호화된 데이터를 리턴...
 }
} // end class


%>