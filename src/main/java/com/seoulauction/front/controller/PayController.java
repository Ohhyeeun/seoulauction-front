package com.seoulauction.front.controller;

import com.seoulauction.common.auth.SAUserDetails;
import com.seoulauction.common.util.Config;
import com.seoulauction.ws.service.CommonService;
import kr.co.nicevan.nicepay.adapter.web.NicePayHttpServletRequestWrapper;
import kr.co.nicevan.nicepay.adapter.web.NicePayWEB;
import kr.co.nicevan.nicepay.adapter.web.dto.WebMessageDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller("payController")
public class PayController {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	CommonService commonService;
	
	@Autowired
	Config config;

    @RequestMapping(value = "/customer/payRegularRequest")
	public String payRegularRequest(HttpServletRequest request, Model model, HttpSession session) {
		
    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
    	SAUserDetails user = (SAUserDetails) userToken.getDetails();

    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	paramMap.put("action_user_no", user.getUserNo());
    	Map<String, Object> custMap = commonService.getData("get_customer_by_cust_no", paramMap);
    	
    	
		model.addAttribute("name", custMap.get("CUST_NAME"));
		model.addAttribute("email", custMap.get("EMAIL"));
		model.addAttribute("phone", custMap.get("HP"));

		if(request.getParameterMap().containsKey("from")) {
			model.addAttribute("fromMore", "Y");
		}
		
		//model.addAttribute("krw_price", commonProcess.selectPaymentNationPrice("K"));
		//model.addAttribute("usd_price", commonProcess.selectPaymentNationPrice("F"));
		
		model.addAttribute("uuid", UUID.randomUUID().toString().replace("-", "") );

		return "payment/nicepayRegularRequest";
	}
    
    @RequestMapping(value = "/customer/niceRegularResult")
	public String niceRegularResult(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		request.setCharacterEncoding("euc-kr");
		/** 1. Request Wrapper ???????????? ????????????.  */ 
		NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);

		/** 2. ?????? ???????????? ???????????? Web ??????????????? ????????? ????????????.*/
		NicePayWEB nicepayWEB = new NicePayWEB();

		/** 2-1. ?????? ???????????? ?????? */
		nicepayWEB.setParam("NICEPAY_LOG_HOME","/wwwroot/ipg_adaptor_log/log");

		/** 2-2. ???????????????????????? ?????? ??????(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("APP_LOG","1");

		/** 2-3. ??????????????? ?????? ??????(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("EVENT_LOG","1");

		/** 2-4. ?????????????????? ??????(N: ??????, S:?????????) */
		nicepayWEB.setParam("EncFlag","S");

		/** 2-5. ??????????????? ??????(?????? ????????? : PY0 , ?????? ????????? : CL0) */
		nicepayWEB.setParam("SERVICE_MODE", "PY0");

		/** 2-6. ???????????? ??????(?????? KRW(??????) ??????)  */
		nicepayWEB.setParam("Currency", "KRW");

		/** 2-7. ???????????? ?????? (?????????????????? : CARD, ????????????: BANK, ?????????????????? : VBANK, ??????????????? : CELLPHONE ) */
		String payMethod = request.getParameter("PayMethod");
		nicepayWEB.setParam("PayMethod",payMethod);
		logger.info("niceRegularResult : {}", payMethod);

		nicepayWEB.setParam("EncodeKey", config.getNicepayEncodeKey());

		/** 3. ?????? ?????? */
		WebMessageDTO responseDTO = nicepayWEB.doService(httpRequestWrapper,response);

		/** 4. ?????? ?????? */
		String resultCode = responseDTO.getParameter("ResultCode"); // ???????????? (?????? :3001 , ??? ??? ??????)
		String resultMsg = responseDTO.getParameter("ResultMsg");   // ???????????????
		String authDate = responseDTO.getParameter("AuthDate");   // ???????????? YYMMDDHH24mmss
		String authCode = responseDTO.getParameter("AuthCode");   // ????????????

		String buyerName = responseDTO.getParameter("BuyerName");   // ????????????
		String mallUserID = responseDTO.getParameter("MallUserID");   // ???????????????ID
		String goodsName = responseDTO.getParameter("GoodsName");   // ?????????
		String mid = responseDTO.getParameter("MID");  // ??????ID
		String tid = responseDTO.getParameter("TID");  // ??????ID
		String moid = responseDTO.getParameter("Moid");  // ????????????
		String amt = responseDTO.getParameter("Amt");  // ??????

		String cardCode = responseDTO.getParameter("CardCode");   // ?????????????????????
		String cardName = responseDTO.getParameter("CardName");   // ??????????????????
		String cardQuota = responseDTO.getParameter("CardQuota");  // ?????? ???????????? (00:?????????,02:2??????)

		String bankCode = responseDTO.getParameter("BankCode");   // ????????????
		String bankName = responseDTO.getParameter("BankName");   // ?????????
		String rcptType = responseDTO.getParameter("RcptType"); //?????? ????????? ?????? (0:??????????????????,1:????????????,2:????????????)
		String rcptAuthCode = responseDTO.getParameter("RcptAuthCode"); //??????????????? ?????? ??????
		String rcptTID = responseDTO.getParameter("RcptTID"); //?????? ????????? TID   

		String carrier = responseDTO.getParameter("Carrier");       // ???????????????
		String dstAddr = responseDTO.getParameter("DstAddr");       // ???????????????

		String vbankBankCode = responseDTO.getParameter("VbankBankCode");   // ????????????????????????
		String vbankBankName = responseDTO.getParameter("VbankBankName");   // ?????????????????????
		String vbankNum = responseDTO.getParameter("VbankNum");   // ??????????????????
		String vbankExpDate = responseDTO.getParameter("VbankExpDate");   // ???????????????????????????

		String no_vat_price = request.getParameter("no_vat_price");
		String vat_price = request.getParameter("vat_price");
		String vat = request.getParameter("vat");
		
		String mall_reserved = request.getParameter("MallReserved");

		boolean paySuccess = false;		// ?????? ?????? ??????
		logger.info("niceRegularResult result : {} / {} / {}", payMethod, resultCode, mall_reserved);

		/** ?????? ?????? ????????? ????????? ?????? Header??? ????????? ????????? Get ?????? */
		if(payMethod.equals("CARD")){	//????????????
			if(resultCode.equals("3001")) paySuccess = true;	// ???????????? (?????? :3001 , ??? ??? ??????)
		}else if(payMethod.equals("BANK")){		//????????????
			if(resultCode.equals("4000")) paySuccess = true;	// ???????????? (?????? :4000 , ??? ??? ??????)
		}else if(payMethod.equals("CELLPHONE")){			//?????????
			if(resultCode.equals("A000")) paySuccess = true;	//???????????? (?????? : A000, ??? ??? ?????????)
		}else if(payMethod.equals("VBANK")){		//????????????
			if(resultCode.equals("4100")) paySuccess = true;	// ???????????? (?????? :4100 , ??? ??? ??????)

		}

		
		if(tid != null || tid.length() != 0){
			
		if(paySuccess){
	    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
	    	SAUserDetails user = (SAUserDetails) userToken.getDetails();

	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("action_user_no", user.getUserNo());
	    	paramMap.put("PAYER", buyerName);
	    	paramMap.put("PAY_PRICE", amt);
	    	paramMap.put("PG_TRANS_ID", tid); //paramMap.put("PG_TRANS_ID", moid);
	    	
	    	//???????????? PAY_ WAIT ????????? ????????? ?????????
	    	paramMap.put("KIND_CD", "membership");
	    	paramMap.put("REF_NO", user.getUserNo());
	    	paramMap.put("PAY_METHOD_CD", payMethod);

	    	paramMap.put("NO_VAT_PRICE", no_vat_price);
	    	paramMap.put("VAT_PRICE", vat_price);
	    	paramMap.put("VAT", vat);
	    	paramMap.put("UUID", mall_reserved);

	    	paramMap.put("VBANK_CD", vbankBankCode);
	    	paramMap.put("VBANK_NM", vbankBankName);
	    	paramMap.put("VBANK_NUM", vbankNum);
	    	paramMap.put("VBANK_EXP_DT", vbankExpDate);

	    	int result;
	    	
	    	if(payMethod.equals("VBANK"))	result = commonService.addData("add_pay_wait", paramMap);
	    	else	    					result = commonService.addData("add_cust_pay", paramMap);
	    	
		}else{
		   // ?????? ????????? DB?????? ?????????.
		}
		
		if(request.getParameterMap().containsKey("from")) {
			if(request.getParameter("from").equals("Y")) {
				model.addAttribute("fromMore", "Y");
			}
		}
		model.addAttribute("paySuccess", paySuccess);
		model.addAttribute("payMethod", payMethod);
		model.addAttribute("tid", tid);
		
		}
		return "payment/niceRegularPayResult";
	}
    
    @RequestMapping(value = "/customer/payPurchaseRequest")
	public String payPurchaseRequest(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model, HttpSession session) {
		
    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
    	SAUserDetails user = (SAUserDetails) userToken.getDetails();

    	paramMap.put("action_user_no", user.getUserNo());
    	
    	
    	Map<String, Object> custMap = commonService.getData("get_customer_by_cust_no", paramMap);
    	model.addAttribute("cust_no", custMap.get("CUST_NO")); //2021.12.14 csy ??????
		model.addAttribute("name", custMap.get("CUST_NAME"));
		model.addAttribute("email", custMap.get("EMAIL"));
		model.addAttribute("phone", custMap.get("HP"));


    	Map<String, Object> payMap = commonService.getData("get_pay_lot", paramMap);
    	paramMap.put("bid_price", payMap.get("BID_PRICE"));
    	Map<String, Object> feeMap = commonService.getData("get_lot_fee", paramMap);
    	Map<String, Object> saleFeeMap = commonService.getData("get_sale_fee", paramMap);
    	
    	int no_vat_price = Integer.parseInt(payMap.get("BID_PRICE").toString());
    	int vat_price = 0;
    	
    	if(feeMap.get("SUM_FEE") == null) vat_price = Integer.parseInt(saleFeeMap.get("SUM_FEE").toString());
    	else  vat_price = Integer.parseInt(feeMap.get("SUM_FEE").toString());
    	
    	int paid_price = (payMap.get("PAY_PRICE") == null ? 0 : Integer.parseInt(payMap.get("PAY_PRICE").toString()));
    	
    	if(paid_price > 0){
    		if(paid_price <= no_vat_price){
    			no_vat_price = no_vat_price - paid_price;
    		}else{
    			vat_price = vat_price - (paid_price - no_vat_price);
    			no_vat_price = 0;
    		}
    	}

    	int vat = vat_price / 11;
    	vat_price = vat_price - vat;
    	int pay_price = (no_vat_price + vat_price + vat);

    	//int pay_price = (Integer.parseInt(payMap.get("BID_PRICE").toString())
    	//		+ Integer.parseInt(feeMap.get("SUM_FEE").toString()))
    	//		- (payMap.get("PAY_PRICE") == null ? 0 : Integer.parseInt(payMap.get("PAY_PRICE").toString()));

		model.addAttribute("times", payMap.get("BID_DT").toString());
		model.addAttribute("salesName", payMap.get("SALE_TITLE_KR").toString() +" / LOT : "+ payMap.get("LOT_NO").toString());
		//model.addAttribute("salesName", payMap.get("SALE_TITLE_KR").toString());
		model.addAttribute("workTitle",  payMap.get("LOT_TITLE_KR").toString());
		model.addAttribute("artistName", payMap.get("ARTIST_NAME_KR").toString());
		model.addAttribute("price", pay_price);
		model.addAttribute("lotId", payMap.get("LOT_NO").toString());
		model.addAttribute("salesPlanningId", payMap.get("SALE_NO").toString());
		model.addAttribute("bid_price", payMap.get("BID_PRICE").toString());
		
		model.addAttribute("no_vat_price", no_vat_price);
		model.addAttribute("vat_price", vat_price);
		model.addAttribute("vat", vat);
		
		model.addAttribute("uuid", UUID.randomUUID().toString().replace("-", "") );

		return "payment/nicePurchaseRequest";
	}
    
    @RequestMapping(value = "/customer/nicePurchaseResult")
	public String nicePurchaseResult(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		request.setCharacterEncoding("euc-kr");
		
		/** 1. Request Wrapper ???????????? ????????????.  */ 
		NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);

		/** 2. ?????? ???????????? ???????????? Web ??????????????? ????????? ????????????.*/
		NicePayWEB nicepayWEB = new NicePayWEB();

		/** 2-1. ?????? ???????????? ?????? */
		nicepayWEB.setParam("NICEPAY_LOG_HOME","/wwwroot/ipg_adaptor_log/log");

		/** 2-2. ???????????????????????? ?????? ??????(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("APP_LOG","1");

		/** 2-3. ??????????????? ?????? ??????(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("EVENT_LOG","1");

		/** 2-4. ?????????????????? ??????(N: ??????, S:?????????) */
		nicepayWEB.setParam("EncFlag","S");

		/** 2-5. ??????????????? ??????(?????? ????????? : PY0 , ?????? ????????? : CL0) */
		nicepayWEB.setParam("SERVICE_MODE", "PY0");

		/** 2-6. ???????????? ??????(?????? KRW(??????) ??????)  */
		nicepayWEB.setParam("Currency", "KRW");

		/** 2-7. ???????????? ?????? (?????????????????? : CARD, ????????????: BANK, ?????????????????? : VBANK, ??????????????? : CELLPHONE ) */
		String payMethod = request.getParameter("PayMethod");
		nicepayWEB.setParam("PayMethod",payMethod);
		logger.info("nicePurchaseResult : {}", payMethod);

		nicepayWEB.setParam("EncodeKey", config.getNicepayEncodeKey());
    	
		/** 3. ?????? ?????? */
		WebMessageDTO responseDTO = nicepayWEB.doService(httpRequestWrapper,response);

		/** 4. ?????? ?????? */
		String resultCode = responseDTO.getParameter("ResultCode"); // ???????????? (?????? :3001 , ??? ??? ??????)
		String resultMsg = responseDTO.getParameter("ResultMsg");   // ???????????????
		String authDate = responseDTO.getParameter("AuthDate");   // ???????????? YYMMDDHH24mmss
		String authCode = responseDTO.getParameter("AuthCode");   // ????????????

		String buyerName = responseDTO.getParameter("BuyerName");   // ????????????
		String mallUserID = responseDTO.getParameter("MallUserID");   // ???????????????ID
		String goodsName = responseDTO.getParameter("GoodsName");   // ?????????
		String artistName = responseDTO.getParameter("artistName");   // ?????????
		String workName = responseDTO.getParameter("workName");   // ?????????
		String mid = responseDTO.getParameter("MID");  // ??????ID
		String tid = responseDTO.getParameter("TID");  // ??????ID
		String moid = responseDTO.getParameter("Moid");  // ????????????
		String amt = responseDTO.getParameter("Amt");  // ??????

		String cardCode = responseDTO.getParameter("CardCode");   // ?????????????????????
		String cardName = responseDTO.getParameter("CardName");   // ??????????????????
		String cardQuota = responseDTO.getParameter("CardQuota");  // ?????? ???????????? (00:?????????,02:2??????)

		String bankCode = responseDTO.getParameter("BankCode");   // ????????????
		String bankName = responseDTO.getParameter("BankName");   // ?????????
		String rcptType = responseDTO.getParameter("RcptType"); //?????? ????????? ?????? (0:??????????????????,1:????????????,2:????????????)
		String rcptAuthCode = responseDTO.getParameter("RcptAuthCode"); //??????????????? ?????? ??????
		String rcptTID = responseDTO.getParameter("RcptTID"); //?????? ????????? TID   

		String carrier = responseDTO.getParameter("Carrier");       // ???????????????
		String dstAddr = responseDTO.getParameter("DstAddr");       // ???????????????

		String vbankBankCode = responseDTO.getParameter("VbankBankCode");   // ????????????????????????
		String vbankBankName = responseDTO.getParameter("VbankBankName");   // ?????????????????????
		String vbankNum = responseDTO.getParameter("VbankNum");   // ??????????????????
		String vbankExpDate = responseDTO.getParameter("VbankExpDate");   // ???????????????????????????

		String salesPlanningId = request.getParameter("salesPlanningId");
		String lotId = request.getParameter("lotId");
		String bid_price = request.getParameter("bid_price");
		String no_vat_price = request.getParameter("no_vat_price");
		String vat_price = request.getParameter("vat_price");
		String vat = request.getParameter("vat");
		
		String mall_reserved = request.getParameter("MallReserved");

		boolean paySuccess = false;		// ?????? ?????? ??????
		logger.info("nicePurchaseResult result : {} / {}", payMethod, resultCode);

		/** ?????? ?????? ????????? ????????? ?????? Header??? ????????? ????????? Get ?????? */
		if(payMethod.equals("CARD")){	//????????????
			if(resultCode.equals("3001")) paySuccess = true;	// ???????????? (?????? :3001 , ??? ??? ??????)

		}else if(payMethod.equals("BANK")){		//????????????
			if(resultCode.equals("4000")) paySuccess = true;	// ???????????? (?????? :4000 , ??? ??? ??????)
		}else if(payMethod.equals("CELLPHONE")){			//?????????
			if(resultCode.equals("A000")) paySuccess = true;	//???????????? (?????? : A000, ??? ??? ?????????)
		}else if(payMethod.equals("VBANK")){		//????????????
			if(resultCode.equals("4100")) paySuccess = true;	// ???????????? (?????? :4100 , ??? ??? ??????)

		}
		
		if(tid != null || tid.length() != 0){			
			if(paySuccess){
		    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
		    	SAUserDetails user = (SAUserDetails) userToken.getDetails();

		    	Map<String, Object> paramMap = new HashMap<String, Object>();
		    	paramMap.put("action_user_no", user.getUserNo());
		    	paramMap.put("sale_no", salesPlanningId);
		    	paramMap.put("lot_no", lotId);
		    	paramMap.put("bid_price", bid_price);
		    	paramMap.put("PAYER", buyerName);
		    	paramMap.put("PAY_PRICE", amt);
		    	paramMap.put("PG_TRANS_ID", tid); //paramMap.put("PG_TRANS_ID", moid);
		    	
		    	//???????????? PAY_ WAIT ????????? ????????? ?????????
		    	paramMap.put("KIND_CD", "payment");
		    	paramMap.put("REF_NO", salesPlanningId);
		    	paramMap.put("REF_NO2", lotId);
		    	paramMap.put("PAY_METHOD_CD", payMethod);

		    	paramMap.put("NO_VAT_PRICE", no_vat_price);
		    	paramMap.put("VAT_PRICE", vat_price);
		    	paramMap.put("VAT", vat);
		    	paramMap.put("UUID", mall_reserved);

		    	paramMap.put("VBANK_CD", vbankBankCode);
		    	paramMap.put("VBANK_NM", vbankBankName);
		    	paramMap.put("VBANK_NUM", vbankNum);
		    	paramMap.put("VBANK_EXP_DT", vbankExpDate);
		    	paramMap.put("RCPT_TYPE", rcptType);
		    	

		    	int result;
		    	
		    	if(payMethod.equals("VBANK"))	result = commonService.addData("add_pay_wait", paramMap);
		    	else	    					result = commonService.addData("add_lot_pay", paramMap);
			}else{
			   // ?????? ????????? DB?????? ?????????.
			}
			
			model.addAttribute("paySuccess", paySuccess);
			model.addAttribute("payMethod", payMethod);
			model.addAttribute("lotId", lotId);
			model.addAttribute("salesPlanningId", salesPlanningId);
			model.addAttribute("transactionId", tid);
			model.addAttribute("price", amt);
			model.addAttribute("time", authDate);
			model.addAttribute("authCode", authCode);
			model.addAttribute("tid", tid);
		}

		return "payment/nicePurchasePayResult";
	}
    
    @RequestMapping(value = "/customer/niceVbankPaid", produces="text/plain")
    @ResponseBody
    public String niceVBankPaid(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		request.setCharacterEncoding("euc-kr");
		response.setContentType("text/html;charset=euc-kr");
		
		String PayMethod    = request.getParameter("PayMethod");        //????????????
		String MID          = request.getParameter("MID");              //??????ID
		String MallUserID   = request.getParameter("MallUserID");       //????????? ID
		String Amt          = request.getParameter("Amt");              //??????
		String name         = request.getParameter("name");             //????????????
		String GoodsName    = request.getParameter("GoodsName");        //?????????
		String TID          = request.getParameter("TID");              //????????????
		String MOID         = request.getParameter("MOID");             //????????????
		String AuthDate     = request.getParameter("AuthDate");         //???????????? (yyMMddHHmmss)
		String ResultCode   = request.getParameter("ResultCode");       //???????????? ('4110' ?????? ????????????)
		String ResultMsg    = request.getParameter("ResultMsg");        //???????????????
		String VbankNum     = request.getParameter("VbankNum");         //??????????????????
		String FnCd         = request.getParameter("FnCd");             //???????????? ????????????
		String VbankName    = request.getParameter("VbankName");        //???????????? ?????????
		String VbankInputName = request.getParameter("VbankInputName"); //????????? ???

		String RcptTID      = request.getParameter("RcptTID");          //??????????????? ????????????
		String RcptType     = request.getParameter("RcptType");         //?????? ????????? ??????(0:?????????, 1:???????????????, 2:???????????????)
		String RcptAuthCode = request.getParameter("RcptAuthCode");     //??????????????? ????????????
		
		String mall_reserved = request.getParameter("MallReserved");
		
		
		boolean paySuccess = false;		// ?????? ?????? ??????
		logger.debug("nice result : {} / {}", PayMethod, ResultCode);

		
		if(PayMethod.equals("VBANK")){		//????????????
			if(ResultCode.equals("4110")) paySuccess = true;
		}

		if(paySuccess){
	    	//UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
	    	//SAUserDetails user = (SAUserDetails) userToken.getDetails();

	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	
	    	paramMap.put("trans_id", TID);
	    	paramMap.put("pay_dt", AuthDate);
	    	paramMap.put("PAY_PRICE", Amt);
	    	paramMap.put("REAL_PAYER", VbankInputName);
	    	paramMap.put("UUID", mall_reserved);
	    	paramMap.put("RCPT_TYPE", RcptType);
	    	
	    	System.out.println("REAL_PAYER: "+ VbankInputName);
	    	
	    	int result = commonService.addData("add_wait2pay", paramMap);
		}
		
		return "payment/niceVbankPaidResult";
	}

    
    @RequestMapping(value = "/customer/payAcademyRequest")
	public String payAcademyRequest(HttpServletRequest request, Model model, HttpSession session) {
		
    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
    	SAUserDetails user = (SAUserDetails) userToken.getDetails();

    	int academy_pay = Integer.parseInt(request.getParameter("academy_pay"));
    	String academy_no = request.getParameter("academy_no");
    	
    	
    	int vat_price = (int) (academy_pay / 1.1);
    	int vat = academy_pay - vat_price;
    		
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	paramMap.put("action_user_no", user.getUserNo());
    	Map<String, Object> custMap = commonService.getData("get_customer_by_cust_no", paramMap);
    	
		model.addAttribute("name", custMap.get("CUST_NAME"));
		model.addAttribute("email", custMap.get("EMAIL"));
		model.addAttribute("phone", custMap.get("HP"));
		model.addAttribute("price", academy_pay);
		model.addAttribute("vat_price", vat_price);
		model.addAttribute("vat", vat);
		model.addAttribute("academy_no", academy_no);
						

		if(request.getParameterMap().containsKey("from")) {
			model.addAttribute("fromMore", "Y");
		}
		
		//model.addAttribute("krw_price", commonProcess.selectPaymentNationPrice("K"));
		//model.addAttribute("usd_price", commonProcess.selectPaymentNationPrice("F"));
		
		model.addAttribute("uuid", UUID.randomUUID().toString().replace("-", "") );

		return "payment/nicepayAcademyRequest";
	}
    
    @RequestMapping(value = "/customer/niceAcademyResult")
	public String niceAcademyResult(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		request.setCharacterEncoding("euc-kr");
		/** 1. Request Wrapper ???????????? ????????????.  */ 
		NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);

		/** 2. ?????? ???????????? ???????????? Web ??????????????? ????????? ????????????.*/
		NicePayWEB nicepayWEB = new NicePayWEB();

		/** 2-1. ?????? ???????????? ?????? */
		nicepayWEB.setParam("NICEPAY_LOG_HOME","/wwwroot/ipg_adaptor_log/log");

		/** 2-2. ???????????????????????? ?????? ??????(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("APP_LOG","1");

		/** 2-3. ??????????????? ?????? ??????(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("EVENT_LOG","1");

		/** 2-4. ?????????????????? ??????(N: ??????, S:?????????) */
		nicepayWEB.setParam("EncFlag","S");

		/** 2-5. ??????????????? ??????(?????? ????????? : PY0 , ?????? ????????? : CL0) */
		nicepayWEB.setParam("SERVICE_MODE", "PY0");

		/** 2-6. ???????????? ??????(?????? KRW(??????) ??????)  */
		nicepayWEB.setParam("Currency", "KRW");

		/** 2-7. ???????????? ?????? (?????????????????? : CARD, ????????????: BANK, ?????????????????? : VBANK, ??????????????? : CELLPHONE ) */
		String payMethod = request.getParameter("PayMethod");
		nicepayWEB.setParam("PayMethod",payMethod);
		logger.info("niceAcademyResult : {}", payMethod);

		nicepayWEB.setParam("EncodeKey", config.getNicepayEncodeKey());

		/** 3. ?????? ?????? */
		WebMessageDTO responseDTO = nicepayWEB.doService(httpRequestWrapper,response);

		/** 4. ?????? ?????? */
		String resultCode = responseDTO.getParameter("ResultCode"); // ???????????? (?????? :3001 , ??? ??? ??????)
		String resultMsg = responseDTO.getParameter("ResultMsg");   // ???????????????
		String authDate = responseDTO.getParameter("AuthDate");   // ???????????? YYMMDDHH24mmss
		String authCode = responseDTO.getParameter("AuthCode");   // ????????????

		String buyerName = responseDTO.getParameter("BuyerName");   // ????????????
		String mallUserID = responseDTO.getParameter("MallUserID");   // ???????????????ID
		String goodsName = responseDTO.getParameter("GoodsName");   // ?????????
		String mid = responseDTO.getParameter("MID");  // ??????ID
		String tid = responseDTO.getParameter("TID");  // ??????ID
		String moid = responseDTO.getParameter("Moid");  // ????????????
		String amt = responseDTO.getParameter("Amt");  // ??????

		String cardCode = responseDTO.getParameter("CardCode");   // ?????????????????????
		String cardName = responseDTO.getParameter("CardName");   // ??????????????????
		String cardQuota = responseDTO.getParameter("CardQuota");  // ?????? ???????????? (00:?????????,02:2??????)

		String bankCode = responseDTO.getParameter("BankCode");   // ????????????
		String bankName = responseDTO.getParameter("BankName");   // ?????????
		String rcptType = responseDTO.getParameter("RcptType"); //?????? ????????? ?????? (0:??????????????????,1:????????????,2:????????????)
		String rcptAuthCode = responseDTO.getParameter("RcptAuthCode"); //??????????????? ?????? ??????
		String rcptTID = responseDTO.getParameter("RcptTID"); //?????? ????????? TID   

		String carrier = responseDTO.getParameter("Carrier");       // ???????????????
		String dstAddr = responseDTO.getParameter("DstAddr");       // ???????????????

		String vbankBankCode = responseDTO.getParameter("VbankBankCode");   // ????????????????????????
		String vbankBankName = responseDTO.getParameter("VbankBankName");   // ?????????????????????
		String vbankNum = responseDTO.getParameter("VbankNum");   // ??????????????????
		String vbankExpDate = responseDTO.getParameter("VbankExpDate");   // ???????????????????????????

		String no_vat_price = request.getParameter("no_vat_price");
		String vat_price = request.getParameter("vat_price");
		String vat = request.getParameter("vat");
		
		String mall_reserved = request.getParameter("MallReserved");
		
    	String academy_no = request.getParameter("academy_no");

		boolean paySuccess = false;		// ?????? ?????? ??????
		logger.info("niceAcademyResult result : {} / {}", payMethod, resultCode);

		/** ?????? ?????? ????????? ????????? ?????? Header??? ????????? ????????? Get ?????? */
		if(payMethod.equals("CARD")){	//????????????
			if(resultCode.equals("3001")) paySuccess = true;	// ???????????? (?????? :3001 , ??? ??? ??????)
		}else if(payMethod.equals("BANK")){		//????????????
			if(resultCode.equals("4000")) paySuccess = true;	// ???????????? (?????? :4000 , ??? ??? ??????)
		}else if(payMethod.equals("CELLPHONE")){			//?????????
			if(resultCode.equals("A000")) paySuccess = true;	//???????????? (?????? : A000, ??? ??? ?????????)
		}else if(payMethod.equals("VBANK")){		//????????????
			if(resultCode.equals("4100")) paySuccess = true;	// ???????????? (?????? :4100 , ??? ??? ??????)

		}

		
		if(tid != null || tid.length() != 0){
			
		if(paySuccess){
	    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
	    	SAUserDetails user = (SAUserDetails) userToken.getDetails();

	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("action_user_no", user.getUserNo());
	    	paramMap.put("PAYER", buyerName);
	    	paramMap.put("PAY_PRICE", amt);
	    	paramMap.put("PG_TRANS_ID", tid); //paramMap.put("PG_TRANS_ID", moid);
	    	paramMap.put("REG_EMP_NO",  user.getUserNo());

	    	paramMap.put("ACADEMY_NO", academy_no);
	    	
	    	//???????????? PAY_ WAIT ????????? ????????? ?????????
	    	paramMap.put("KIND_CD", "academy");
	    	paramMap.put("REF_NO", academy_no);
	    	paramMap.put("PAY_METHOD_CD", payMethod);

	    	paramMap.put("NO_VAT_PRICE", no_vat_price);
	    	paramMap.put("VAT_PRICE", vat_price);
	    	paramMap.put("VAT", vat);
	    	paramMap.put("UUID", mall_reserved);

	    	paramMap.put("VBANK_CD", vbankBankCode);
	    	paramMap.put("VBANK_NM", vbankBankName);
	    	paramMap.put("VBANK_NUM", vbankNum);
	    	paramMap.put("VBANK_EXP_DT", vbankExpDate);

	    	int result;
	    	
				/*
				 * Map<String, Object> paramMap2 = new HashMap<String, Object>();
				 * paramMap2.put("ACADEMY_NO", academy_no); paramMap2.put("CUST_NO",
				 * user.getUserNo()); paramMap2.put("REG_EMP_NO", user.getUserNo());
				 * paramMap2.put("PAYER", buyerName);
				 */
	    	if(payMethod.equals("VBANK"))	result = commonService.addData("add_pay_wait", paramMap);
	    	else	    					result = commonService.addData("add_academy_pay", paramMap);
	    	
		}else{
		   // ?????? ????????? DB?????? ?????????.
		}
		
		if(request.getParameterMap().containsKey("from")) {
			if(request.getParameter("from").equals("Y")) {
				model.addAttribute("fromMore", "Y");
			}
		}
		model.addAttribute("paySuccess", paySuccess);
		model.addAttribute("payMethod", payMethod);
		model.addAttribute("tid", tid);
		
		}
		return "payment/niceAcademyPayResult";
	}
    
    
    
    @RequestMapping(value = "/customer/payPurchaseRequestTest")
	public String payPurchaseRequestTest(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model, HttpSession session) {
		
    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
    	SAUserDetails user = (SAUserDetails) userToken.getDetails();

    	paramMap.put("action_user_no", user.getUserNo());

    	Map<String, Object> custMap = commonService.getData("get_customer_by_cust_no", paramMap);
		model.addAttribute("name", custMap.get("CUST_NAME"));
		model.addAttribute("email", custMap.get("EMAIL"));
		model.addAttribute("phone", custMap.get("HP"));


    	Map<String, Object> payMap = commonService.getData("get_pay_lot", paramMap);
    	paramMap.put("bid_price", payMap.get("BID_PRICE"));
    	Map<String, Object> feeMap = commonService.getData("get_lot_fee", paramMap);
    	Map<String, Object> saleFeeMap = commonService.getData("get_sale_fee", paramMap);
    	
    	int no_vat_price = Integer.parseInt(payMap.get("BID_PRICE").toString());
    	int vat_price = 0;
    	
    	if(feeMap.get("SUM_FEE") == null) vat_price = Integer.parseInt(saleFeeMap.get("SUM_FEE").toString());
    	else  vat_price = Integer.parseInt(feeMap.get("SUM_FEE").toString());
    	
    	int paid_price = (payMap.get("PAY_PRICE") == null ? 0 : Integer.parseInt(payMap.get("PAY_PRICE").toString()));
    	
    	if(paid_price > 0){
    		if(paid_price <= no_vat_price){
    			no_vat_price = no_vat_price - paid_price;
    		}else{
    			vat_price = vat_price - (paid_price - no_vat_price);
    			no_vat_price = 0;
    		}
    	}

    	int vat = vat_price / 11;
    	vat_price = vat_price - vat;
    	int pay_price = (no_vat_price + vat_price + vat);

    	//int pay_price = (Integer.parseInt(payMap.get("BID_PRICE").toString())
    	//		+ Integer.parseInt(feeMap.get("SUM_FEE").toString()))
    	//		- (payMap.get("PAY_PRICE") == null ? 0 : Integer.parseInt(payMap.get("PAY_PRICE").toString()));

		model.addAttribute("times", payMap.get("BID_DT").toString());
		model.addAttribute("salesName", payMap.get("SALE_TITLE_KR").toString() +" / LOT : "+ payMap.get("LOT_NO").toString());
		model.addAttribute("workTitle",  payMap.get("LOT_TITLE_KR").toString());
		model.addAttribute("artistName", payMap.get("ARTIST_NAME_KR").toString());
		model.addAttribute("price", pay_price);
		model.addAttribute("lotId", payMap.get("LOT_NO").toString());
		model.addAttribute("salesPlanningId", payMap.get("SALE_NO").toString());
		model.addAttribute("bid_price", payMap.get("BID_PRICE").toString());
		
		model.addAttribute("no_vat_price", no_vat_price);
		model.addAttribute("vat_price", vat_price);
		model.addAttribute("vat", vat);
		
		model.addAttribute("uuid", UUID.randomUUID().toString().replace("-", "") );

		return "payment/nicePurchaseRequestTest";
	}
}
