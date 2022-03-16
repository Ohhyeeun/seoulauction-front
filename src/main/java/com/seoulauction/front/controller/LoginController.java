package com.seoulauction.front.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.seoulauction.common.auth.SAUserDetails;
import com.seoulauction.front.auth.FrontAuthenticationProvider;
import com.seoulauction.front.auth.SSGAuthenticationProvider;
import com.seoulauction.front.util.AuctionUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("loginController")
public class LoginController {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	SSGAuthenticationProvider ssgAuthenticationProvider;

	/**
	 * 클라이언트의 IP 주소는 HttpServletRequest.getRemoteAddr() 메서드를 이용하여 알아낼 수 있다.
	 * 그러나 Proxy, Caching server, Load Balancer 등을 거쳐올 경우 getRemoteAddr()를 이용하여 IP 주소를 가지고 오지 못하게 된다.
	 * 이걸 위한 별도의 처리가 필요
	 */
	private String getIp(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null) {
			ip = request.getHeader("Proxy-Client-IP");
		}

		if (ip == null) {
			ip = request.getHeader("WL-Proxy-Client-IP"); // 웹로직
		}

		if (ip == null) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}

		if (ip == null) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}

		if (ip == null) {
			ip = request.getRemoteAddr();
		}

		return ip;
	}

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

	@RequestMapping(value = {"/api/login"})
	public String ssg_login(HttpServletRequest request, @RequestParam(value = "custId") String custId, @RequestParam(value = "userNm") String userNm, @RequestParam(value = "agreeYn") String agreeYn, @RequestParam(value="callbackUrl", required = false) String callbackUrl) {
		logger.info("/api/login");

		SAUserDetails parameterUserDetail = SAUserDetails.builder()
				.loginId(custId)
				.userNm(userNm)
				.agreeYn(agreeYn)
				.ip(getIp(request))
				.build();

		SecurityContext sc = SecurityContextHolder.getContext();
		UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(custId, null);
		auth.setDetails(parameterUserDetail);
		sc.setAuthentication(ssgAuthenticationProvider.authenticate(auth));

		HttpSession session = request.getSession(true);
		session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, sc);

		try {
			session.setAttribute("custId", custId);
			custId = AuctionUtil.aesDecryptSSG(custId);
			session.setAttribute("custId", custId);

			session.setAttribute("agreeYn", agreeYn);

			session.setAttribute("userNm", userNm);
			userNm = AuctionUtil.aesDecryptSSG(userNm);
			session.setAttribute("userNm", userNm);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}

		if(callbackUrl == null) {
			return "redirect:/";
		}
		logger.info("/api/login {}", callbackUrl);
		return "redirect:"+callbackUrl;
	}
}
