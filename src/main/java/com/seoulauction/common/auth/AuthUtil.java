package com.seoulauction.common.auth;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class AuthUtil {
	protected final static Logger logger = LoggerFactory.getLogger(AuthUtil.class);
	public static String encodeBCrypt(String passwd){
		logger.debug("=======>>>>>> {} ", passwd);
		if(passwd == null || passwd.equals("")) return null;
		
		BCryptPasswordEncoder bCript = new BCryptPasswordEncoder(12);
		
		return bCript.encode(passwd);
	}
}
