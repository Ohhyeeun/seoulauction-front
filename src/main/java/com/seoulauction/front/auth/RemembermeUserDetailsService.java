package com.seoulauction.front.auth;

import com.seoulauction.common.auth.SAUserDetails;
import com.seoulauction.ws.dao.CommonDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class RemembermeUserDetailsService implements UserDetailsService {

    @Autowired
    private CommonDao commonDao;

    @Override
    public UserDetails loadUserByUsername(String loginId) throws UsernameNotFoundException {
        log.info("loadUserByUsername");

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("login_id", loginId);
        paramMap.put("stat_cd", "normal");
        Map<String, Object> resultMap = commonDao.selectOne("get_customer_by_login_id", paramMap);
        if (resultMap == null) {
            throw new UsernameNotFoundException("No user found with loginId: " + loginId);
        }

        List<GrantedAuthority> roles = new ArrayList<>();
        roles.add(new SimpleGrantedAuthority("ROLE_FRONT_USER"));

        UserDetails user =  new SAUserDetails(loginId, resultMap.get("PASSWD").toString(), Integer.parseInt(resultMap.get("CUST_NO").toString()), roles, resultMap.get("CUST_KIND_CD").toString());
        return user;
    }
}
