package com.seoulauction.front.interceptor;

import com.seoulauction.common.auth.SAUserDetails;
import com.seoulauction.front.util.AuctionUtil;
import com.seoulauction.ws.dao.CommonDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;
import java.util.*;

public class SsgInterceptor extends HandlerInterceptorAdapter {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private CommonDao commonDao;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {
            String custId = request.getParameter("cust_id");
            if (custId != null && !request.isUserInRole("ROLE_FRONT_USER")) {
                // AES256 복호화
                custId = AuctionUtil.aesDecryptSSG(custId);

                // check CUST
                Map<String, Object> paramMap = new HashMap<String, Object>();
                paramMap.put("login_id", custId);
                paramMap.put("stat_cd", "normal");
                Map<String, Object> resultMap = commonDao.selectOne("get_customer_by_login_id", paramMap);
                System.out.println("preHandle resultMap: " + resultMap);
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

                // 로그인
                List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
                roles.add(new SimpleGrantedAuthority("ROLE_FRONT_USER"));

                int custNo = Integer.parseInt(resultMap.get("CUST_NO").toString());

                UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(custNo, resultMap.get("PASSWD").toString(), roles);
                result.setDetails(new SAUserDetails(custId, resultMap.get("PASSWD").toString(), custNo, roles, resultMap.get("CUST_KIND_CD").toString()));
                SecurityContextHolder.getContext().setAuthentication(result);

                // 쿠키 설정
                AuctionUtil.setCookie(response, "provider_type", "ssg");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }

        return super.preHandle(request, response, handler);
    }
}
