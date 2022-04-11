package com.seoulauction.ws.controller;

import com.seoulauction.common.auth.SAUserDetails;
import com.seoulauction.common.exception.DataSetException;
import com.seoulauction.common.util.Config;
import com.seoulauction.ws.dto.Action;
import com.seoulauction.ws.dto.ActionSet;
import com.seoulauction.ws.dto.ResultDataSet;
import com.seoulauction.ws.service.CommonService;
import com.seoulauction.ws.service.MessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

@Controller("commonController")
public class CommonController {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private CommonService commonService;

	@Autowired
	private MessageService messageService;
	
	@Autowired
	private Config config;
	
	//domain -> spring security filter
    @RequestMapping(value="/api/actionSet", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public ResultDataSet execActionSet(String domain, @RequestBody ActionSet actionSet, HttpServletRequest request, HttpServletResponse response)
    throws IOException, DataSetException{
    	
    	for(Action action : actionSet.getActionList()){
			if(SecurityContextHolder.getContext().getAuthentication() == null){
				response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
			}
							
			if(request.isUserInRole("ROLE_ANONYMOUS") && !action.getActionID().matches("mapper\\.common\\.*|mapper\\.front\\.public\\.*") ){
				response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
			}
			
			if(request.isUserInRole("ROLE_FRONT_USER") && action.getActionID().matches("mapper\\.office\\.*")){
				response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
			}
    	}
    	
    	UsernamePasswordAuthenticationToken userToken = (UsernamePasswordAuthenticationToken) request.getUserPrincipal();
    	if(userToken != null){
        	SAUserDetails user = (SAUserDetails) userToken.getDetails();
        	
        	if(actionSet.getBaseParms() == null){
				actionSet.setBaseParms(new HashMap<String, Object>());
			}
        	
        	actionSet.getBaseParms().put("action_user_ip", request.getRemoteAddr());
        	actionSet.getBaseParms().put("action_user_no", user.getUserNo());
    	}
    	return commonService.actionSet(actionSet);
    }

    @RequestMapping(value="/api/customAction", method=RequestMethod.POST, headers = {"content-type=application/json"})
    @ResponseBody
    public ResultDataSet execCustomAction(@RequestBody Action action, HttpServletRequest request, HttpServletResponse response) throws IOException{
    	return commonService.customAction(action);
    }
    
    @RequestMapping(value="/addressFinder")
    public String addressFinder(){
    	return "/common/popup/addressFinderPop";
    }

    @RequestMapping(value="/artistFinder")
    public String artistFinder(){
    	return "/common/popup/artistFinderPop";
    }
        
    
    @RequestMapping(value="/mailTest")
    public String mailTest(){
    	try{
    		
    		//mailService.sendMail("debugger@aroute.co.kr", "한번 보내 봅다.");
        	return "redirect:/";
    	}
    	catch(Exception ex){
    		ex.printStackTrace();
    	}
    	return "";
    }
}
