package com.seoulauction.front.auth;

import com.seoulauction.common.auth.PasswordEncoderAESforSA;
import com.seoulauction.common.auth.SAUserDetails;
import com.seoulauction.front.util.AuctionUtil;
import com.seoulauction.ws.dao.CommonDao;
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
import org.springframework.security.web.authentication.WebAuthenticationDetails;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SSGAuthenticationProvider  implements AuthenticationProvider {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    PasswordEncoderAESforSA encoder;

    @Autowired
    private CommonDao commonDao;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        logger.info("SSG authenticate");

        String custId = (String) authentication.getPrincipal();
        try {
            // AES256 복호화
            custId = AuctionUtil.aesDecryptSSG(custId);
        } catch (Exception e) {
            logger.error("aesDecryptSSG error");
            throw new BadCredentialsException("aesDecryptSSG error");
        }

        logger.info("custId : {}" , custId);

        // check CUST
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("login_id", custId);
        paramMap.put("stat_cd", "normal");
        Map<String, Object> resultMap = commonDao.selectOne("get_customer_by_login_id", paramMap);
        if (resultMap == null || resultMap.isEmpty()) {
            //insert CUST
            paramMap.put("local_kind_cd", "korean");
            paramMap.put("nation_cd", "KR");
            paramMap.put("join_kind_cd", "online");
            paramMap.put("cust_name", "SSG");
            paramMap.put("cust_kind_cd", "person");
            paramMap.put("login_id", custId);
            commonDao.insert("add_join", paramMap);

            resultMap = commonDao.selectOne("get_customer_by_login_id", paramMap);
        }

        // Get the IP address of the user tyring to use the site
        WebAuthenticationDetails wad = (WebAuthenticationDetails) authentication.getDetails();
        String userIPAddress = wad.getRemoteAddress();

        paramMap.put("ip", userIPAddress);
        paramMap.put("user_no", resultMap.get("CUST_NO"));
        paramMap.put("user_kind_cd", "customer");
        commonDao.insert("insert_conn_hist", paramMap);

        List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
        roles.add(new SimpleGrantedAuthority("ROLE_FRONT_USER"));

        int custNo = Integer.parseInt(resultMap.get("CUST_NO").toString());

        UsernamePasswordAuthenticationToken result
                = new UsernamePasswordAuthenticationToken(custNo, resultMap.get("PASSWD").toString(), roles);
        result.setDetails(new SAUserDetails(custId, resultMap.get("PASSWD").toString(), custNo, roles, resultMap.get("CUST_KIND_CD").toString()));

        return result;
    }

    @Override
    public boolean supports(Class<? extends Object> authentication) {
        return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
    }
}

