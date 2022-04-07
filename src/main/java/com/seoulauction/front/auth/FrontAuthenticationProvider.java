package com.seoulauction.front.auth;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Component;

import com.seoulauction.common.auth.PasswordEncoderAESforSA;
import com.seoulauction.common.auth.SAUserDetails;
import com.seoulauction.ws.dao.CommonDao;

@Component
public class FrontAuthenticationProvider implements AuthenticationProvider {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	PasswordEncoderAESforSA encoder;
	
	@Autowired
	private CommonDao commonDao;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String loginId = (String)authentication.getPrincipal();
		String passwd = (String)authentication.getCredentials();
		
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("login_id", loginId);
        paramMap.put("stat_cd", "normal");
        Map<String, Object> resultMap = commonDao.selectOne("get_customer_by_login_id", paramMap);
        
        if(resultMap == null || resultMap.isEmpty()){
			throw new BadCredentialsException("Username not found.");
        }
		
		if(!encoder.matches(passwd, resultMap.get("PASSWD").toString())){
			throw new BadCredentialsException("Wrong password");
		}

		WebAuthenticationDetails wad = null;
        String userIPAddress         = null;

        // Get the IP address of the user tyring to use the site
        wad = (WebAuthenticationDetails) authentication.getDetails();
        userIPAddress = wad.getRemoteAddress();

        paramMap.put("ip", userIPAddress);
        paramMap.put("user_no", resultMap.get("CUST_NO"));
        paramMap.put("user_kind_cd", "customer");
        int insertResult = commonDao.insert("insert_conn_hist", paramMap);
        if(insertResult > 0){
        	logger.info("userIPAddress == " + userIPAddress);
        }

		List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
        roles.add(new SimpleGrantedAuthority("ROLE_FRONT_USER"));
        
        int custNo = Integer.parseInt(resultMap.get("CUST_NO").toString());
        
        UsernamePasswordAuthenticationToken result 
        	= new UsernamePasswordAuthenticationToken(custNo, resultMap.get("PASSWD").toString(), roles);
        result.setDetails(new SAUserDetails(loginId, resultMap.get("PASSWD").toString(), custNo, roles, resultMap.get("CUST_KIND_CD").toString()));
		return result;
	}

	@Override
	public boolean supports(Class<? extends Object> authentication) {
		return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
	}

}
