package com.seoulauction.front.interceptor;

import com.seoulauction.front.util.AuctionUtil;
import com.seoulauction.ws.dao.CommonDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class SsgInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private CommonDao commonDao;

    @SuppressWarnings("rawtypes")
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String custId = request.getParameter("cust_id");
        // String custId = "rugEGAjQ3Z7ShRw1e+PjTA==";
        System.out.println("preHandle custId: "+custId);
        if(custId != null) {
            // AES256 복호화
            custId = AuctionUtil.aesDecryptSSG(custId);
            System.out.println("preHandle dec custId: "+custId);

            // check CUST
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("login_id", custId);
            paramMap.put("stat_cd", "normal");
            Map<String, Object> resultMap = commonDao.selectOne("get_customer_by_login_id", paramMap);
            System.out.println("preHandle resultMap: "+resultMap);
            if(resultMap == null || resultMap.isEmpty()){
                //insert CUST
                paramMap.put("local_kind_cd", "korean");
                paramMap.put("nation_cd", "KR");
                paramMap.put("join_kind_cd", "online");
                paramMap.put("cust_name", "SSG");
                paramMap.put("login_id", custId);
                commonDao.insert("add_join", paramMap);
            }

            // 로그인

            // 쿠키 설정
            AuctionUtil.setCookie(response, "provider_type", "ssg");
        }

        return super.preHandle(request, response, handler);
    }
}
