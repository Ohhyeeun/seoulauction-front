package com.seoulauction.common.auth;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private String loginFormUrl;

    public String getLoginFormUrl() {
        return loginFormUrl;
    }

    public void setLoginFormUrl(String loginFormUrl) {
        this.loginFormUrl = loginFormUrl;
    }

    public RestAuthenticationEntryPoint() {

    }

    public RestAuthenticationEntryPoint(String loginFormUrl) {
        this.loginFormUrl = loginFormUrl;
    }
    
	//@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {

		logger.info("************ {} : {}", request.getRemoteAddr(), request.getRequestURI());
		
		String accept = request.getHeader("accept");

		logger.info("===> header accept : {}", accept);
		if(StringUtils.indexOf(accept, "html") > -1 ) {
			logger.info("===> redirect : {}", this.loginFormUrl);
			response.sendRedirect(this.loginFormUrl);
        }
		else{
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
		}
	}

}
