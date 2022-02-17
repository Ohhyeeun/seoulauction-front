package com.seoulauction.common.util;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class AddressFinder {
	protected final static Logger logger = LoggerFactory.getLogger(AddressFinder.class);
	
	public static final String SERVICE_URL_NEW_ADDR	= "http://biz.epost.go.kr/KpostPortal/openapi?regkey=";
	public static final String SERVICE_API_KEY		= "2b15754f7ace87fb41476172692605";
	public static final String SERVICE_TARGET		= "postNew";
	
	/**
	 * 공공데이터 포털 주소검색 API WebService 호출 (우체국  API)
	 * @param sSearchType = postNew  5자리 통합형 지정코드임.
	 * @param sSearchContent - 검색할 주소 내용
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> find(Map<String, Object> params) throws Exception {
		
		HttpURLConnection conn = null;
		List<AddressVo> aAddress = new ArrayList<AddressVo>();
		
		String sSearchType = "postNew";
		String sSearchContent = (String) params.get("find_word");
		
//		sSearchContent = URLEncoder.encode(sSearchContent, "EUC-KR");
//		sSearchContent = URLEncoder.encode(sSearchContent, "ISO-8859-1");
//		sSearchContent = URLEncoder.encode(sSearchContent, "UTF-8");
				
		String sApiUrl =SERVICE_URL_NEW_ADDR;
		String sServiceKey = SERVICE_API_KEY;
		String sCountPerPage = "20"; // 페이지당  Row 수 정의
		String sCurrentPage = "1";   // 현재 페이지
		
		String sQuery = URLEncoder.encode(sSearchContent, "EUC-KR");  //URLEncoder.encode(, "UTF-8")

		String parameter = "&target=" + sSearchType;

		parameter += "&query=" + sQuery;
		parameter += "&countPerPage=" + sCountPerPage;
		parameter += "&currentPage=" + sCurrentPage;

		sApiUrl = sApiUrl + sServiceKey + parameter;

		logger.debug("===========> {}", sApiUrl);
		
		URL url = new URL(sApiUrl);
		
		conn = (HttpURLConnection) url.openConnection();
		conn.setRequestProperty("accept-language","ko");
		SAXBuilder builder = new SAXBuilder();
		Document doc= builder.build(conn.getInputStream());
		Element itemlist = doc.getRootElement().getChild("itemlist");
		List list = itemlist.getChildren("item");

		for(int i=0; i<list.size();i++){
		   Element item = (Element)list.get(i);
		   String address = item.getChildText("address");
		   String postcd = item.getChildText("postcd");
		   String addrjibun = item.getChildText("addrjibun");
		   
//		   //하고자하는 작업
		   AddressVo oAddrVO = new AddressVo();
			oAddrVO.setPostcd(postcd);
			oAddrVO.setAddress(address);
			oAddrVO.setAddrJibun(addrjibun);
			
			aAddress.add(oAddrVO);
		 }
	  
		  Map<String, Object> tableMap = new HashMap<String, Object>();
			Map<String, Object> columnMap = new HashMap<String, Object>();
			columnMap.put("postcd", "string");
			columnMap.put("address", "string");
			columnMap.put("addrjibun", "string");

			tableMap.put("columns", columnMap);
			tableMap.put("rows", aAddress);
			logger.debug("=====>>>>> {}", tableMap);
			return tableMap;
		}

	public static class AddressVo {
		public AddressVo(){}		
		//Integer totalCount;		//  검색결과 전체 건수
		//Integer totalPage;		//  검색결과 전체 페이지수
		//Integer countPerPage;	//	페이지당 조회건수
		//Integer currentPage;	//	현재 조회 페이지
		String	postcd;			//	우편번호
		String	address;		//	주소(도로명)
		//String 	addressDetail;	//	상세주소
		String	addrjibun;		//	주소(지번)
		
		public String getPostcd() {
			return postcd;
		}
		public void setPostcd(String postcd) {
			this.postcd = postcd;
		}		
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		//public String getAddressDetail() {
		//	return addressDetail;
		//}
		//public void setAddressDetail(String addressDetail) {
		//	this.addressDetail = addressDetail;
		//}
		public String getAddrJibun() {
			return addrjibun;
		}
		public void setAddrJibun(String addrjibun) {
			this.addrjibun = addrjibun;
		}
	}
/* ************************************************************************************* */	
	/*
	 * 주소 검색 Util Class
	 */
/*	protected final static Logger logger = LoggerFactory.getLogger(AddressFinder.class);
	// 신주소 검색 Service URL
	public static final String SERVICE_URL_NEW_ADDR	= "http://openapi.epost.go.kr/postal/retrieveNewAdressService/retrieveNewAdressService/getNewAddressList?ServiceKey=";
	// 구주소 검색 Service URL
	public static final String SERVICE_URL_NEW_OLD	= "http://openapi.epost.go.kr/postal/retrieveLotNumberAdressService/retrieveLotNumberAdressService/getDetailList?ServiceKey=";
	// 검색 Service API Key
	public static final String SERVICE_API_KEY		= "CQCMUPOw10kn8nRuxWRoHoByQlZp55Q8MUMa4SGg7pgz5daW6wqvNGvxhiQbPJT58ct5hqPFnQV9dKsvTwW%2Btg%3D%3D";
	// 구주소 검색 타입 - 동(읍/면)
	public static final String OLD_SEARCH_TYPE_DONG	= "dong";
*/	
	/**
	 * 공공데이터 포털 주소검색 API WebService 호출
	 * @param sSearchType - road = 도로명+건물번호 or dong = 동(읍/면)+지번
	 * @param sSearchContent - 검색할 주소 내용
	 * @param bIsAddrNew - true = 신주소 검색, false = 구주소 검색
	 * @return
	 * @throws Exception
	 */
/*	public static Map<String, Object> find(Map<String, Object> params) throws Exception {
		String sSearchType = (String) params.get("find_type");
		String sSearchContent = (String) params.get("find_word");
		boolean bIsAddrNew = !sSearchType.equals(OLD_SEARCH_TYPE_DONG);

		String sApiUrl = bIsAddrNew ? SERVICE_URL_NEW_ADDR : SERVICE_URL_NEW_OLD;
		String sServiceKey = SERVICE_API_KEY;
		
		String sQuery = URLEncoder.encode(sSearchContent, "UTF-8");

		String parameter = "&searchSe=" + sSearchType;

		parameter += "&srchwrd=" + sQuery;
		parameter += "&encoding=UTF-8";

		sApiUrl = sApiUrl + sServiceKey + parameter;

		logger.debug("===========> {}", sApiUrl);
		
		URL url = new URL(sApiUrl);
		InputStream in = url.openStream();
		CachedOutputStream bos = new CachedOutputStream();
		IOUtils.copy(in, bos);
		in.close();
		bos.close();

		String sResult = new String(bos.getBytes(), "UTF-8");

		List<AddressVo> aAddress = new ArrayList<AddressVo>();
		SAXBuilder builder = new SAXBuilder();

		InputStream stream = new ByteArrayInputStream(sResult.getBytes("UTF-8"));
		Document document = (Document) builder.build(stream);
		Element rootNode = document.getRootElement();

		List<Element> commonList = rootNode.getChildren("cmmMsgHeader");
		boolean bSuccessYN = false;
		for (int i = 0; i < commonList.size(); i++) {
			Element node = (Element) commonList.get(i);
			bSuccessYN = node.getChildText("successYN").equals("Y") ? true : false;
		}

		if(bSuccessYN == true) {
			// 신주소 검색인 경우
			if (bIsAddrNew == true) {
				List<Element> list = rootNode.getChildren("newAddressList");

				for (int i = 0; i < list.size(); i++) {

					Element node = (Element) list.get(i);

					AddressVo oAddrVO = new AddressVo();
					String[] sPostCode = node.getChildText("zipNo").split("-");

					oAddrVO.setPostcode1(sPostCode[0]);
					oAddrVO.setPostcode2(sPostCode[1]);
					oAddrVO.setAddrBase(node.getChildText("lnmAdres"));
					oAddrVO.setAddrOld(node.getChildText("rnAdres"));
					
					aAddress.add(oAddrVO);
				}
			}
			// 구주소 검색인 경우
			else {
				List<Element> list = rootNode.getChildren("detailList");

				for (int i = 0; i < list.size(); i++) {

					Element node = (Element) list.get(i);

					AddressVo oAddrVO = new AddressVo();
					String[] sPostCode = node.getChildText("zipNo").split("-");

					oAddrVO.setPostcode1(sPostCode[0]);
					oAddrVO.setPostcode2(sPostCode[1]);
					oAddrVO.setAddrOld(node.getChildText("adres"));
					
					aAddress.add(oAddrVO);
				}
			}
		}

		Map<String, Object> tableMap = new HashMap<String, Object>();
		Map<String, Object> columnMap = new HashMap<String, Object>();
		columnMap.put("postcode1", "string");
		columnMap.put("postcode2", "string");
		columnMap.put("addrBase", "string");
		columnMap.put("addrDetail", "string");
		columnMap.put("postcode1", "string");
		columnMap.put("addrOld", "string");

		tableMap.put("columns", columnMap);
		tableMap.put("rows", aAddress);
		logger.debug("=====>>>>> {}", tableMap);
		return tableMap;
	}
	
	public static class AddressVo {
		public AddressVo(){}
		String postcode1;
		String postcode2;
		String addrBase;
		String addrDetail;
		String addrOld;
		
		public String getPostcode1() {
			return postcode1;
		}
		public void setPostcode1(String postcode1) {
			this.postcode1 = postcode1;
		}
		public String getPostcode2() {
			return postcode2;
		}
		public void setPostcode2(String postcode2) {
			this.postcode2 = postcode2;
		}
		public String getAddrBase() {
			return addrBase;
		}
		public void setAddrBase(String addrBase) {
			this.addrBase = addrBase;
		}
		public String getAddrDetail() {
			return addrDetail;
		}
		public void setAddrDetail(String addrDetail) {
			this.addrDetail = addrDetail;
		}
		public String getAddrOld() {
			return addrOld;
		}
		public void setAddrOld(String addrOld) {
			this.addrOld = addrOld;
		}
	}
*/	
}
