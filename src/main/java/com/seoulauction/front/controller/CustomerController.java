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
}
