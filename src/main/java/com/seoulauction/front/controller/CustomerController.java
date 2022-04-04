package com.seoulauction.front.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nicevan.nicepay.adapter.web.NicePayHttpServletRequestWrapper;
import kr.co.nicevan.nicepay.adapter.web.NicePayWEB;
import kr.co.nicevan.nicepay.adapter.web.dto.WebMessageDTO;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.seoulauction.common.auth.PasswordEncoderAESforSA;
import com.seoulauction.common.auth.SAUserDetails;
import com.seoulauction.common.exception.DataSetException;
import com.seoulauction.common.util.Config;
import com.seoulauction.ws.dao.CommonDao;
import com.seoulauction.ws.dto.Action;
import com.seoulauction.ws.dto.ActionSet;
import com.seoulauction.ws.dto.ResultDataSet;
import com.seoulauction.ws.service.CommonService;
import com.seoulauction.ws.service.MessageService;

@Controller("customerController")
public class CustomerController {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	CommonService commonService;
	
	@Autowired
	private MessageService messageService;

	@Autowired
	Config config;
	
    @RequestMapping(value="/join/agree")
    public String join(ModelMap model, HttpServletRequest request){
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	if(!auth.getAuthorities().isEmpty() && request.isUserInRole("ROLE_FRONT_USER")){
			return "redirect:/";
		}
    	
		model.addAttribute("VIEW_ID", "JOIN");

		return "/customer/joinAgree";
    }

    @RequestMapping(value="/join/form/{cust_kind_cd}")
    public String joinForm(@PathVariable(value = "cust_kind_cd") String cust_kind_cd, ModelMap model, HttpServletRequest request){
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	if(!auth.getAuthorities().isEmpty() && request.isUserInRole("ROLE_FRONT_USER")){
			return "redirect:/";
		}
		model.addAttribute("VIEW_ID", "JOIN");
		model.addAttribute("CUST_KIND_CD", cust_kind_cd);
		
		return "/customer/joinForm";
    }
    
    @RequestMapping(value="/customer/myPage")
    public String showMyPage(ModelMap model){
		return "/customer/myPage";
    }

    @RequestMapping(value="/customer/modifyForm")
    public String showModifyForm(ModelMap model, HttpServletRequest request){
    	
    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
    	SAUserDetails user = (SAUserDetails) userToken.getDetails();
    	
        //Map<String, Object> paramMap = new HashMap<String, Object>();
                
        //paramMap.put("login_id", request.getUserPrincipal().getName());
        //Map<String, Object> resultMap = commonService.getData("mapper.front.public.customer.get_customer_by_login_id", paramMap);

		return "/customer/modifyForm";
    }
    
    @RequestMapping(value="/customer/memHisPop")
    public String showMembershipHistory(ModelMap model, HttpServletRequest request){
		return "/customer/popup/membershipHistoryPop";
    }
    
    @RequestMapping(value="/customer/onlineBidList")
    public String showOnlineBidList(ModelMap model, HttpServletRequest request){
		return "/customer/onlineBidList";
    }
    
    @RequestMapping(value="/customer/onlineAutoBidList")
    public String showOnlineAutoBidList(ModelMap model, HttpServletRequest request){
		return "/customer/onlineAutoBidList";
    }
    
    @RequestMapping(value="/customer/offlineBidReqList")
    public String showOfflineBidReqList(@RequestParam Map<String, String> params, ModelMap model, HttpServletRequest request){
    	model.addAttribute("SALE_NO", params.get("sale_no"));
		return "/customer/offlineBidReqList";
    }
    
    @RequestMapping(value="/customer/offlineBidHistory")   
    public String showofflineBidHistory(ModelMap model, HttpServletRequest request){   
		return "/customer/offlineBidHistory";     
    } 
    
    @RequestMapping(value="/customer/offlineCRInteList")
    public String showOfflineCRInteList(ModelMap model, HttpServletRequest request){
		return "/customer/offlineCRInteList";
    }
    
    @RequestMapping(value="/customer/offlineInteList/{sale_kind}")
    public String showOfflineInteList(@PathVariable(value = "sale_kind") String sale_kind, ModelMap model, HttpServletRequest request){
    	model.addAttribute("SALE_KIND", sale_kind);
		return "/customer/offlineInteList";
    }
    
    @RequestMapping(value="/customer/onlineInteList/{sale_kind}")
    public String showonlineInteList(@PathVariable(value = "sale_kind") String sale_kind, ModelMap model, HttpServletRequest request){
    	model.addAttribute("SALE_KIND", sale_kind);
		return "/customer/onlineInteList";
    }
    
    @RequestMapping(value="/customer/conditionList")
    public String showConditonList(ModelMap model, HttpServletRequest request){
		return "/customer/conditionList";
    }    
    
    @RequestMapping(value="/customer/onlinePayList")
    public String showOnlinePayList(ModelMap model, HttpServletRequest request){
		return "/customer/onlinePayList";
    }
    
    @RequestMapping(value="/customer/Customer_admin")
    public String CustomerAdmin(ModelMap model, HttpServletRequest request){
		return "/customer/Customer_admin";
    }


    @RequestMapping(value="/customer/inquiryList")
    public String showInquiryList(ModelMap model){
		return "/customer/inquiryList";
    }
    
    @RequestMapping(value="/customer/inquiryView")
    public String showInquiryView(ModelMap model){
		return "/customer/inquiryView";
    }

    @RequestMapping(value="/customer/inquiryForm")
    public String showInquiryForm(ModelMap model){
		return "/customer/inquiryWrite";
    }
    
    @RequestMapping(value="/customer/academyList")
    public String showAcademyList(HttpServletRequest request, ModelMap model , HttpSession session){
    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
    	SAUserDetails user = (SAUserDetails) userToken.getDetails();
    	model.addAttribute("CUST_NO", user.getUserNo());
		return "/customer/academyList";
    }
    
    @RequestMapping(value="/customer/get_decode_passwd", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public Map<String, Object> getDecodePasswd(@RequestBody Map<String, Object> paramMap){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try{
			resultMap.put("passwd", PasswordEncoderAESforSA.saPasswdDecoding(paramMap.get("passwd").toString()));
		}
		catch(Exception ex){
		}
		return resultMap;
   	}
    
   	@RequestMapping(value="/join/send_auth_num", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public Map<String, Object> sendAuthNumber(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response){


		Map<String, Object> custHpParamMap = new HashMap<>();
		custHpParamMap.put("hp",paramMap.get("to_phone"));
		custHpParamMap.put("sale_no", paramMap.get("sale_no"));
		Map<String, Object> existMap = commonService.getData("selSaleCertByCustHp",custHpParamMap);
		Boolean bid = paramMap.get("bid_auth") != null && (Boolean) paramMap.get("bid_auth"); // 경매용 폰번호 인증시
		Map<String, Object> resultMap = new HashMap<>();

		// 경매전용 인증이 아니고 현재 폰인증한 내역이 없으면 무시.
		if(!bid || MapUtils.isEmpty(existMap)) {

			paramMap.put("from_phone", config.getMobileMsgCallback()); //02-395-0330
			//paramMap.put("msg", "서울옥션 인증번호는 [##rand_num##] 입니다.");
			paramMap.put("msg", config.getMobileMsgAuth());

			resultMap = commonService.getData("get_auth_number", paramMap);

			if (resultMap.containsKey("AUTH_NUM")) {
				BCryptPasswordEncoder encode = new BCryptPasswordEncoder();
				request.getSession().setAttribute("AUTH_NUM", encode.encode(resultMap.get("AUTH_NUM").toString()));
			}
			resultMap.put("AUTH_NUM", "");
			resultMap.put("SEND_STATUS", true);
			resultMap.put("AUTH_EXISTS", false);
		} else {  //둘다 해당할경우 폰인증을 막음.
			resultMap.put("AUTH_EXISTS", true);
		}
		return resultMap;
   	}
   	
   	//문자발송 
	@RequestMapping(value="/join/send_passwd_sms", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public Map<String, Object> sendPasswdSms(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try{
			int result = commonService.modifyData("modify_passwd_issued", paramMap); //비밀번호 수정 후 업데이트
			if(result > 0) {
				Map map = (Map)paramMap.get("passwd"); 
		        List list = (List) map.get("rows"); 
	        	paramMap.put("stat_cd", "normal");
//	        	Map<String, Object> custMap = commonService.getData("get_customer_by_login_id", paramMap);
	        	
	        	resultMap = new HashMap<String, Object>();
				
	        	String locale = paramMap.get("locale").toString();
	        	String msg = locale.equals("ko") ? 
	        			"[서울옥션 문자발송] 임시 비밀번호 발급 알림\n 임시비밀번호 : "+ list.get(0).toString()
	        			: "[SeoulAuction SMS] Issued a temporary password reminder\n temporary password : " + list.get(0).toString(); 
	        	
	        	//최종 문자 발송 데이터
	        	paramMap.put("from_phone", config.getMobileMsgCallback()); //02-395-0330
	        	paramMap.put("msg", msg); 
		   		resultMap = commonService.getData("get_auth_number", paramMap);
				
				resultMap.put("SEND_STATUS", true);
			}else{
				resultMap.put("SEND_STATUS", false);
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		return resultMap;
   	}

   	@RequestMapping(value="/join/confirm_auth_num", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public boolean confirmAuthNumber(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response){
   		if(paramMap == null || paramMap.get("auth_num") == null || paramMap.get("auth_num").toString().equals("")) return false;  
		BCryptPasswordEncoder encode = new BCryptPasswordEncoder();
		try{
			boolean result = encode.matches(paramMap.get("auth_num").toString(), request.getSession().getAttribute("AUTH_NUM").toString());
			request.getSession().setAttribute("AUTH_NUM", null);
			return result;
		}
		catch(Exception ex){
			try{request.getSession().setAttribute("AUTH_NUM", null);}catch(Exception e){}
			return false;
		}
   	}
   	
   	@RequestMapping(value="/join/confirm_auth_num4sale", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public ResultDataSet confirmAuthNumber4Sale(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) throws DataSetException{
   		boolean b = this.confirmAuthNumber(paramMap, request, response);
   		if (b) {
	   	   	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
	    	SAUserDetails user = (SAUserDetails) userToken.getDetails();
	
	    	paramMap.put("action_user_no", user.getUserNo());
	    	
	    	ActionSet as = new ActionSet();
	    	List<Action> actionList = new ArrayList<Action>();
	    	as.setActionList(actionList);
	    	
	    	Action ac = new Action();
			actionList.add(ac);
	    	List<Map<String,Object>> paramList = new ArrayList<Map<String,Object>>();
			ac.setParmsList(paramList);
	   		
	    	ac.setActionType("insert");
	    	ac.setActionID("sale_cert_add");
	    	ac.setTableName("CERT");
	    	ac.setUidKey("sale_cert_no");

	    	paramList.add(paramMap);
	    	
	    	return commonService.actionSet(as);
   		}else{
   			ResultDataSet rs = new ResultDataSet();
   			rs.setResultCode(-1);
   			
   			return rs;
   		}
   	}

	// 이름 저장
	@RequestMapping(value = "/auth/update/info", method = RequestMethod.POST, headers = {"content-type=application/json"})
	@ResponseBody
	public boolean modifyCustInfo(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) {
		try {
			// 세션에 저장된 회원 ID 가져오기
			UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
			SAUserDetails user = (SAUserDetails) userToken.getDetails();
			int userId = user.getUserNo();

			// 비밀번호 업데이트
			Map<String, Object> updateNameParams = new HashMap<>();
			updateNameParams.put("name", paramMap.get("name").toString());
			updateNameParams.put("id", userId);

			int updateNameResult = commonService.modifyData("updateCustName", updateNameParams); // 이름 업데이트

			if (updateNameResult == 0) {
				return false;
			}

			Map<String, Object> updateMArketingParams = new HashMap<>();
			updateMArketingParams.put("marketing_agree", paramMap.get("marketing_agree").toString());
			updateMArketingParams.put("id", userId);

			int updateMarketingResult = commonService.modifyData("updateMarketingAgree", updateMArketingParams); // 이름 업데이트
			return updateMarketingResult != 0;
		} catch (Exception e) {
			return false;
		}
	}

   	@RequestMapping(value="/join/clear_auth_num", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public boolean clearAuthNumber(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response){
		try{
			request.getSession().setAttribute("AUTH_NUM", null);
			return true;
		}
		catch(Exception ex){
			return false;
		}
   	}
   	   	
   	@RequestMapping(value="/join/send_join_mail", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public boolean sendJoinMail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response){
		try{
			paramMap.put("stat_cd", "not_certify");
	        Map<String, Object> resultMap = commonService.getData("get_customer_by_login_id", paramMap);
	        if(resultMap != null && resultMap.size() > 0){
	        	String port = request.getServerPort() != 80 ? ":" + String.format("%d", request.getServerPort()) : "";
		        resultMap.put("authURL", "https://" + request.getServerName() + port + "/join/" + resultMap.get("FORE_CERT_CODE").toString());
		        messageService.AsyncSendMail(resultMap.get("EMAIL").toString(), "Please, complete your registration.", "foreign_auth.html", resultMap);
		        return true;
	        }
	        else{
	        	return false;
	        }
		}
		catch(Exception ex){
			return false;
		}
   	}

    @RequestMapping(value="/join/{uuid}")
    public String joinAuthCode(@PathVariable(value = "uuid") String uuid, HttpServletResponse response) throws IOException{
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	paramMap.put("fore_cert_code", uuid);
        int result = commonService.modifyData("modify_cust_for_fore_auth", paramMap);
    	
        if(result == 1){
        	return "redirect:/login";
        }
        else{
        	response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
    		return "";
        }
    }
    
    @RequestMapping(value="/join/searchAccountPop")
    public String searchAccountPop() throws IOException{
    	return "/customer/popup/searchAccountPop";
    }
    
    @RequestMapping(value="/join/send_passwd_mail", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public boolean sendPasswdMail(@RequestBody Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response){
		try{
	        int result = commonService.modifyData("modify_passwd_issued", paramMap);
	        if(result > 0){
		        Map map = (Map)paramMap.get("passwd"); 
		        List list = (List) map.get("rows"); 
	        	paramMap.put("stat_cd", "normal");
	        	Map<String, Object> custMap = commonService.getData("get_customer_by_login_id", paramMap);
	        	
	        	Map<String, Object> resultMap = new HashMap<String, Object>();
	        	resultMap.put("PASSWD", list.get(0).toString());
	        	resultMap.put("LOGIN_ID", paramMap.get("login_id").toString());
	        	resultMap.put("CUST_NAME", custMap.get("CUST_NAME").toString());
	        	String locale = paramMap.get("locale").toString();
	        	String subject = locale.equals("ko") ? "[서울옥션] 임시 비밀번호 발급 알림" : "[SeoulAuction] Issued a temporary password reminder";
	        	String template = locale.equals("ko") ? "passwd.html" : "passwd_en.html";
		        messageService.sendMail(paramMap.get("email").toString(), subject, template, resultMap);
		        return true;
	        }
	        else{
	        	return false;
	        }
		}
		catch(Exception ex){
			ex.printStackTrace();
			return false;
		}
   	}

    @RequestMapping(value = "/customer/payRegularRequest")
	public String payRegularRequest(HttpServletRequest request, Model model, HttpSession session) {
		
    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
    	SAUserDetails user = (SAUserDetails) userToken.getDetails();

    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	paramMap.put("action_user_no", user.getUserNo());
    	Map<String, Object> custMap = commonService.getData("get_customer_by_cust_no", paramMap);
    	
    	
		model.addAttribute("name", custMap.get("CUST_NAME").toString());
		model.addAttribute("email", custMap.get("EMAIL").toString());
		model.addAttribute("phone", custMap.get("HP"));

		if(request.getParameterMap().containsKey("from")) {
			model.addAttribute("fromMore", "Y");
		}
		
		//model.addAttribute("krw_price", commonProcess.selectPaymentNationPrice("K"));
		//model.addAttribute("usd_price", commonProcess.selectPaymentNationPrice("F"));
		
		model.addAttribute("uuid", UUID.randomUUID().toString().replace("-", "") );

		return "payment/nicepayRegularRequest";
	}
    
    @RequestMapping(value = "/customer/TermCheckPop")
   	public String termCheckPop(HttpServletRequest request, Model model, HttpSession session) {
   		
       	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
       	SAUserDetails user = (SAUserDetails) userToken.getDetails();

       	Map<String, Object> paramMap = new HashMap<String, Object>();
       	paramMap.put("action_user_no", user.getUserNo());
       	Map<String, Object> custMap = commonService.getData("get_customer_by_cust_no", paramMap);
       	
       	
   		model.addAttribute("name", custMap.get("CUST_NAME").toString());
   		model.addAttribute("email", custMap.get("EMAIL").toString());
   		model.addAttribute("phone", custMap.get("HP"));

   		if(request.getParameterMap().containsKey("from")) {
   			model.addAttribute("fromMore", "Y");
   		}
   		
   		//model.addAttribute("krw_price", commonProcess.selectPaymentNationPrice("K"));
   		//model.addAttribute("usd_price", commonProcess.selectPaymentNationPrice("F"));
   		
   		model.addAttribute("uuid", UUID.randomUUID().toString().replace("-", "") );

   		return "customer/popup/TermCheckPop";
   	}
    
    @RequestMapping(value = "/customer/niceRegularResult")
	public String niceRegularResult(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		request.setCharacterEncoding("euc-kr");
		/** 1. Request Wrapper 클래스를 등록한다.  */ 
		NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);

		/** 2. 소켓 어댑터와 연동하는 Web 인터페이스 객체를 생성한다.*/
		NicePayWEB nicepayWEB = new NicePayWEB();

		/** 2-1. 로그 디렉토리 설정 */
		nicepayWEB.setParam("NICEPAY_LOG_HOME","/wwwroot/ipg_adaptor_log/log");

		/** 2-2. 어플리케이션로그 모드 설정(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("APP_LOG","1");

		/** 2-3. 이벤트로그 모드 설정(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("EVENT_LOG","1");

		/** 2-4. 암호화플래그 설정(N: 평문, S:암호화) */
		nicepayWEB.setParam("EncFlag","S");

		/** 2-5. 서비스모드 설정(결제 서비스 : PY0 , 취소 서비스 : CL0) */
		nicepayWEB.setParam("SERVICE_MODE", "PY0");

		/** 2-6. 통화구분 설정(현재 KRW(원화) 가능)  */
		nicepayWEB.setParam("Currency", "KRW");

		/** 2-7. 결제수단 설정 (신용카드결제 : CARD, 계좌이체: BANK, 가상계좌이체 : VBANK, 휴대폰결제 : CELLPHONE ) */
		String payMethod = StringUtils.defaultIfEmpty(request.getParameter("PayMethod"), "CARD");
		nicepayWEB.setParam("PayMethod",payMethod);

		logger.info("niceRegularResult : {}", payMethod);

		//nicepayWEB.setParam("EncodeKey","33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A==");
		nicepayWEB.setParam("EncodeKey","9s7oFNUdG03jLMJ0nIYs4qwRldWVS7YUvVzNXeodXOCw/hWTsLQW64hDE7eJQ4Dui8aGGqFnqvlWSPYdlnLeBg==");

		/** 3. 결제 요청 */
		WebMessageDTO responseDTO = nicepayWEB.doService(httpRequestWrapper,response);

		/** 4. 결제 결과 */
		String resultCode = responseDTO.getParameter("ResultCode"); // 결과코드 (정상 :3001 , 그 외 에러)
		String resultMsg = responseDTO.getParameter("ResultMsg");   // 결과메시지
		String authDate = responseDTO.getParameter("AuthDate");   // 승인일시 YYMMDDHH24mmss
		String authCode = responseDTO.getParameter("AuthCode");   // 승인번호

		String buyerName = responseDTO.getParameter("BuyerName");   // 구매자명
		String mallUserID = responseDTO.getParameter("MallUserID");   // 회원사고객ID
		String goodsName = responseDTO.getParameter("GoodsName");   // 상품명
		String mid = responseDTO.getParameter("MID");  // 상점ID
		String tid = responseDTO.getParameter("TID");  // 거래ID
		String moid = responseDTO.getParameter("Moid");  // 주문번호
		String amt = responseDTO.getParameter("Amt");  // 금액

		String cardCode = responseDTO.getParameter("CardCode");   // 결제카드사코드
		String cardName = responseDTO.getParameter("CardName");   // 결제카드사명
		String cardQuota = responseDTO.getParameter("CardQuota");  // 카드 할부개월 (00:일시불,02:2개월)

		String bankCode = responseDTO.getParameter("BankCode");   // 은행코드
		String bankName = responseDTO.getParameter("BankName");   // 은행명
		String rcptType = responseDTO.getParameter("RcptType"); //현금 영수증 타입 (0:발행되지않음,1:소득공제,2:지출증빙)
		String rcptAuthCode = responseDTO.getParameter("RcptAuthCode"); //현금영수증 승인 번호
		String rcptTID = responseDTO.getParameter("RcptTID"); //현금 영수증 TID   

		String carrier = responseDTO.getParameter("Carrier");       // 이통사구분
		String dstAddr = responseDTO.getParameter("DstAddr");       // 휴대폰번호

		String vbankBankCode = responseDTO.getParameter("VbankBankCode");   // 가상계좌은행코드
		String vbankBankName = responseDTO.getParameter("VbankBankName");   // 가상계좌은행명
		String vbankNum = responseDTO.getParameter("VbankNum");   // 가상계좌번호
		String vbankExpDate = responseDTO.getParameter("VbankExpDate");   // 가상계좌입금예정일

		String no_vat_price = request.getParameter("no_vat_price");
		String vat_price = request.getParameter("vat_price");
		String vat = request.getParameter("vat");
		
		String mall_reserved = request.getParameter("MallReserved");

		boolean paySuccess = false;		// 결제 성공 여부
		logger.info("niceRegularResult result : {} / {} / {}", payMethod, resultCode, mall_reserved);

		/** 위의 응답 데이터 외에도 전문 Header와 개별부 데이터 Get 가능 */
		if(payMethod.equals("CARD")){	//신용카드
			if(resultCode.equals("3001")) paySuccess = true;	// 결과코드 (정상 :3001 , 그 외 에러)
		}else if(payMethod.equals("BANK")){		//계좌이체
			if(resultCode.equals("4000")) paySuccess = true;	// 결과코드 (정상 :4000 , 그 외 에러)
		}else if(payMethod.equals("CELLPHONE")){			//휴대폰
			if(resultCode.equals("A000")) paySuccess = true;	//결과코드 (정상 : A000, 그 외 비정상)
		}else if(payMethod.equals("VBANK")){		//가상계좌
			if(resultCode.equals("4100")) paySuccess = true;	// 결과코드 (정상 :4100 , 그 외 에러)

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
	    	
	    	//가상결제 PAY_ WAIT 테이블 입력을 위해서
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
		   // 결제 실패시 DB처리 하세요.
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
    	model.addAttribute("cust_no", custMap.get("CUST_NO").toString()); //2021.12.14 csy 추가
		model.addAttribute("name", custMap.get("CUST_NAME").toString());
		model.addAttribute("email", custMap.get("EMAIL").toString());
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
		
		/** 1. Request Wrapper 클래스를 등록한다.  */ 
		NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);

		/** 2. 소켓 어댑터와 연동하는 Web 인터페이스 객체를 생성한다.*/
		NicePayWEB nicepayWEB = new NicePayWEB();

		/** 2-1. 로그 디렉토리 설정 */
		nicepayWEB.setParam("NICEPAY_LOG_HOME","/wwwroot/ipg_adaptor_log/log");

		/** 2-2. 어플리케이션로그 모드 설정(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("APP_LOG","1");

		/** 2-3. 이벤트로그 모드 설정(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("EVENT_LOG","1");

		/** 2-4. 암호화플래그 설정(N: 평문, S:암호화) */
		nicepayWEB.setParam("EncFlag","S");

		/** 2-5. 서비스모드 설정(결제 서비스 : PY0 , 취소 서비스 : CL0) */
		nicepayWEB.setParam("SERVICE_MODE", "PY0");

		/** 2-6. 통화구분 설정(현재 KRW(원화) 가능)  */
		nicepayWEB.setParam("Currency", "KRW");

		/** 2-7. 결제수단 설정 (신용카드결제 : CARD, 계좌이체: BANK, 가상계좌이체 : VBANK, 휴대폰결제 : CELLPHONE ) */
		String payMethod = StringUtils.defaultIfEmpty(request.getParameter("PayMethod"), "CARD");
		nicepayWEB.setParam("PayMethod",payMethod);
		logger.info("nicePurchaseResult : {}", payMethod);

//		nicepayWEB.setParam("EncodeKey","33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A==");
		nicepayWEB.setParam("EncodeKey","9s7oFNUdG03jLMJ0nIYs4qwRldWVS7YUvVzNXeodXOCw/hWTsLQW64hDE7eJQ4Dui8aGGqFnqvlWSPYdlnLeBg==");
    	
    	
		/** 3. 결제 요청 */
		WebMessageDTO responseDTO = nicepayWEB.doService(httpRequestWrapper,response);

		/** 4. 결제 결과 */
		String resultCode = responseDTO.getParameter("ResultCode"); // 결과코드 (정상 :3001 , 그 외 에러)
		String resultMsg = responseDTO.getParameter("ResultMsg");   // 결과메시지
		String authDate = responseDTO.getParameter("AuthDate");   // 승인일시 YYMMDDHH24mmss
		String authCode = responseDTO.getParameter("AuthCode");   // 승인번호

		String buyerName = responseDTO.getParameter("BuyerName");   // 구매자명
		String mallUserID = responseDTO.getParameter("MallUserID");   // 회원사고객ID
		String goodsName = responseDTO.getParameter("GoodsName");   // 경매명
		String artistName = responseDTO.getParameter("artistName");   // 작가명
		String workName = responseDTO.getParameter("workName");   // 작품명
		String mid = responseDTO.getParameter("MID");  // 상점ID
		String tid = responseDTO.getParameter("TID");  // 거래ID
		String moid = responseDTO.getParameter("Moid");  // 주문번호
		String amt = responseDTO.getParameter("Amt");  // 금액

		String cardCode = responseDTO.getParameter("CardCode");   // 결제카드사코드
		String cardName = responseDTO.getParameter("CardName");   // 결제카드사명
		String cardQuota = responseDTO.getParameter("CardQuota");  // 카드 할부개월 (00:일시불,02:2개월)

		String bankCode = responseDTO.getParameter("BankCode");   // 은행코드
		String bankName = responseDTO.getParameter("BankName");   // 은행명
		String rcptType = responseDTO.getParameter("RcptType"); //현금 영수증 타입 (0:발행되지않음,1:소득공제,2:지출증빙)
		String rcptAuthCode = responseDTO.getParameter("RcptAuthCode"); //현금영수증 승인 번호
		String rcptTID = responseDTO.getParameter("RcptTID"); //현금 영수증 TID   

		String carrier = responseDTO.getParameter("Carrier");       // 이통사구분
		String dstAddr = responseDTO.getParameter("DstAddr");       // 휴대폰번호

		String vbankBankCode = responseDTO.getParameter("VbankBankCode");   // 가상계좌은행코드
		String vbankBankName = responseDTO.getParameter("VbankBankName");   // 가상계좌은행명
		String vbankNum = responseDTO.getParameter("VbankNum");   // 가상계좌번호
		String vbankExpDate = responseDTO.getParameter("VbankExpDate");   // 가상계좌입금예정일

		String salesPlanningId = request.getParameter("salesPlanningId");
		String lotId = request.getParameter("lotId");
		String bid_price = request.getParameter("bid_price");
		String no_vat_price = request.getParameter("no_vat_price");
		String vat_price = request.getParameter("vat_price");
		String vat = request.getParameter("vat");
		
		String mall_reserved = request.getParameter("MallReserved");

		boolean paySuccess = false;		// 결제 성공 여부
		logger.info("nicePurchaseResult result : {} / {}", payMethod, resultCode);

		/** 위의 응답 데이터 외에도 전문 Header와 개별부 데이터 Get 가능 */
		if(payMethod.equals("CARD")){	//신용카드
			if(resultCode.equals("3001")) paySuccess = true;	// 결과코드 (정상 :3001 , 그 외 에러)

		}else if(payMethod.equals("BANK")){		//계좌이체
			if(resultCode.equals("4000")) paySuccess = true;	// 결과코드 (정상 :4000 , 그 외 에러)
		}else if(payMethod.equals("CELLPHONE")){			//휴대폰
			if(resultCode.equals("A000")) paySuccess = true;	//결과코드 (정상 : A000, 그 외 비정상)
		}else if(payMethod.equals("VBANK")){		//가상계좌
			if(resultCode.equals("4100")) paySuccess = true;	// 결과코드 (정상 :4100 , 그 외 에러)

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
		    	
		    	//가상결제 PAY_ WAIT 테이블 입력을 위해서
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
			   // 결제 실패시 DB처리 하세요.
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
		
		String PayMethod    = request.getParameter("PayMethod");        //지불수단
		String MID          = request.getParameter("MID");              //상점ID
		String MallUserID   = request.getParameter("MallUserID");       //회원사 ID
		String Amt          = request.getParameter("Amt");              //금액
		String name         = request.getParameter("name");             //구매자명
		String GoodsName    = request.getParameter("GoodsName");        //상품명
		String TID          = request.getParameter("TID");              //거래번호
		String MOID         = request.getParameter("MOID");             //주문번호
		String AuthDate     = request.getParameter("AuthDate");         //입금일시 (yyMMddHHmmss)
		String ResultCode   = request.getParameter("ResultCode");       //결과코드 ('4110' 경우 입금통보)
		String ResultMsg    = request.getParameter("ResultMsg");        //결과메시지
		String VbankNum     = request.getParameter("VbankNum");         //가상계좌번호
		String FnCd         = request.getParameter("FnCd");             //가상계좌 은행코드
		String VbankName    = request.getParameter("VbankName");        //가상계좌 은행명
		String VbankInputName = request.getParameter("VbankInputName"); //입금자 명

		String RcptTID      = request.getParameter("RcptTID");          //현금영수증 거래번호
		String RcptType     = request.getParameter("RcptType");         //현금 영수증 구분(0:미발행, 1:소득공제용, 2:지출증빙용)
		String RcptAuthCode = request.getParameter("RcptAuthCode");     //현금영수증 승인번호
		
		String mall_reserved = request.getParameter("MallReserved");
		
		
		boolean paySuccess = false;		// 결제 성공 여부
		logger.debug("nice result : {} / {}", PayMethod, ResultCode);

		if(PayMethod.equals("VBANK")){		//가상계좌
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
    	
		model.addAttribute("name", custMap.get("CUST_NAME").toString());
		model.addAttribute("email", custMap.get("EMAIL").toString());
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
		/** 1. Request Wrapper 클래스를 등록한다.  */ 
		NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);

		/** 2. 소켓 어댑터와 연동하는 Web 인터페이스 객체를 생성한다.*/
		NicePayWEB nicepayWEB = new NicePayWEB();

		/** 2-1. 로그 디렉토리 설정 */
		nicepayWEB.setParam("NICEPAY_LOG_HOME","/wwwroot/ipg_adaptor_log/log");

		/** 2-2. 어플리케이션로그 모드 설정(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("APP_LOG","1");

		/** 2-3. 이벤트로그 모드 설정(0: DISABLE, 1: ENABLE) */
		nicepayWEB.setParam("EVENT_LOG","1");

		/** 2-4. 암호화플래그 설정(N: 평문, S:암호화) */
		nicepayWEB.setParam("EncFlag","S");

		/** 2-5. 서비스모드 설정(결제 서비스 : PY0 , 취소 서비스 : CL0) */
		nicepayWEB.setParam("SERVICE_MODE", "PY0");

		/** 2-6. 통화구분 설정(현재 KRW(원화) 가능)  */
		nicepayWEB.setParam("Currency", "KRW");

		/** 2-7. 결제수단 설정 (신용카드결제 : CARD, 계좌이체: BANK, 가상계좌이체 : VBANK, 휴대폰결제 : CELLPHONE ) */
		String payMethod = StringUtils.defaultIfEmpty(request.getParameter("PayMethod"), "CARD");
		nicepayWEB.setParam("PayMethod",payMethod);
		logger.info("niceAcademyResult : {}", payMethod);

		//nicepayWEB.setParam("EncodeKey","33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A==");
		nicepayWEB.setParam("EncodeKey","9s7oFNUdG03jLMJ0nIYs4qwRldWVS7YUvVzNXeodXOCw/hWTsLQW64hDE7eJQ4Dui8aGGqFnqvlWSPYdlnLeBg==");

		/** 3. 결제 요청 */
		WebMessageDTO responseDTO = nicepayWEB.doService(httpRequestWrapper,response);

		/** 4. 결제 결과 */
		String resultCode = responseDTO.getParameter("ResultCode"); // 결과코드 (정상 :3001 , 그 외 에러)
		String resultMsg = responseDTO.getParameter("ResultMsg");   // 결과메시지
		String authDate = responseDTO.getParameter("AuthDate");   // 승인일시 YYMMDDHH24mmss
		String authCode = responseDTO.getParameter("AuthCode");   // 승인번호

		String buyerName = responseDTO.getParameter("BuyerName");   // 구매자명
		String mallUserID = responseDTO.getParameter("MallUserID");   // 회원사고객ID
		String goodsName = responseDTO.getParameter("GoodsName");   // 상품명
		String mid = responseDTO.getParameter("MID");  // 상점ID
		String tid = responseDTO.getParameter("TID");  // 거래ID
		String moid = responseDTO.getParameter("Moid");  // 주문번호
		String amt = responseDTO.getParameter("Amt");  // 금액

		String cardCode = responseDTO.getParameter("CardCode");   // 결제카드사코드
		String cardName = responseDTO.getParameter("CardName");   // 결제카드사명
		String cardQuota = responseDTO.getParameter("CardQuota");  // 카드 할부개월 (00:일시불,02:2개월)

		String bankCode = responseDTO.getParameter("BankCode");   // 은행코드
		String bankName = responseDTO.getParameter("BankName");   // 은행명
		String rcptType = responseDTO.getParameter("RcptType"); //현금 영수증 타입 (0:발행되지않음,1:소득공제,2:지출증빙)
		String rcptAuthCode = responseDTO.getParameter("RcptAuthCode"); //현금영수증 승인 번호
		String rcptTID = responseDTO.getParameter("RcptTID"); //현금 영수증 TID   

		String carrier = responseDTO.getParameter("Carrier");       // 이통사구분
		String dstAddr = responseDTO.getParameter("DstAddr");       // 휴대폰번호

		String vbankBankCode = responseDTO.getParameter("VbankBankCode");   // 가상계좌은행코드
		String vbankBankName = responseDTO.getParameter("VbankBankName");   // 가상계좌은행명
		String vbankNum = responseDTO.getParameter("VbankNum");   // 가상계좌번호
		String vbankExpDate = responseDTO.getParameter("VbankExpDate");   // 가상계좌입금예정일

		String no_vat_price = request.getParameter("no_vat_price");
		String vat_price = request.getParameter("vat_price");
		String vat = request.getParameter("vat");
		
		String mall_reserved = request.getParameter("MallReserved");
		
    	String academy_no = request.getParameter("academy_no");

		boolean paySuccess = false;		// 결제 성공 여부
		logger.info("niceAcademyResult result : {} / {}", payMethod, resultCode);

		/** 위의 응답 데이터 외에도 전문 Header와 개별부 데이터 Get 가능 */
		if(payMethod.equals("CARD")){	//신용카드
			if(resultCode.equals("3001")) paySuccess = true;	// 결과코드 (정상 :3001 , 그 외 에러)
		}else if(payMethod.equals("BANK")){		//계좌이체
			if(resultCode.equals("4000")) paySuccess = true;	// 결과코드 (정상 :4000 , 그 외 에러)
		}else if(payMethod.equals("CELLPHONE")){			//휴대폰
			if(resultCode.equals("A000")) paySuccess = true;	//결과코드 (정상 : A000, 그 외 비정상)
		}else if(payMethod.equals("VBANK")){		//가상계좌
			if(resultCode.equals("4100")) paySuccess = true;	// 결과코드 (정상 :4100 , 그 외 에러)

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
	    	
	    	//가상결제 PAY_ WAIT 테이블 입력을 위해서
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
		   // 결제 실패시 DB처리 하세요.
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
		model.addAttribute("name", custMap.get("CUST_NAME").toString());
		model.addAttribute("email", custMap.get("EMAIL").toString());
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
