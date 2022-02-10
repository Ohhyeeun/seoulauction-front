package com.seoulauction.front.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("loginController")
public class LoginController {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = {"/login"}, method = RequestMethod.GET)
	public String login(ModelMap model, HttpServletRequest request,
		@RequestParam(value = "error", required = false) String error,
		@RequestParam(value = "joinSuccess", required = false) String joinSuccess,
		@RequestParam(value = "logout", required = false) String logout) {

		String serverName = "https://" + request.getServerName();
		String serverPort = ":" + request.getServerPort();
		String targetUrl = request.getHeader("referer") != null ? request.getHeader("referer").replace(serverName, "").replace(serverPort, "") : "";
		if(targetUrl.endsWith("login?logout") || targetUrl.endsWith("login?error") 
				|| targetUrl.endsWith("/join/form/person") || targetUrl.endsWith("/join/form/company")) {
			targetUrl = "/";
		}
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(error == null && logout == null 
				&& auth !=null 
				&& !auth.getAuthorities().isEmpty() && request.isUserInRole("ROLE_FRONT_USER")){
			return "redirect:/";
		}
		
		if (error != null) {
			if(request.getSession().getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION) != null 
				&& request.getSession().getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION)  instanceof BadCredentialsException){
				request.getSession().setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, null);
				model.addAttribute("error", "Bad credentials");
			}
		}

		if (logout != null) {
			model.addAttribute("logoutMsg", "You've been logged out successfully.");
		}
		
		if (joinSuccess != null) {
			model.addAttribute("joinSuccess", "ok");
		}
		
		model.addAttribute("targetUrl", targetUrl);
		return "customer/login";

	}
}
