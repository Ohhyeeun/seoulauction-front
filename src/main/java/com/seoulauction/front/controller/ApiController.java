package com.seoulauction.front.controller;

import com.seoulauction.front.util.AuctionUtil;
import com.seoulauction.ws.service.CommonService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("apiController")
public class ApiController {

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = "/api/lots", method = RequestMethod.GET, produces = "application/json;charset=utf8")
    @ResponseBody
    @Cacheable(value="apiLots")
    public JSONObject lots(@RequestParam Integer saleNumber, @RequestParam(value = "lotNumbers") List<Integer> lotNumbers) {
        logger.info("/api/lots saleNumber: {}", saleNumber);

        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("saleNumber", saleNumber);
        paramMap.put("lotNumbers", lotNumbers);

        JSONArray lotsData = new JSONArray();
        List<Map<String,Object>> lotsMap = commonService.getDataList("select_lots", paramMap);

        for(Map<String, Object> obj : lotsMap){
            JSONObject lot = new JSONObject();

            String lotStatus = "READY";
            if(obj.get("stat_cd").equals("reentry")){
                lotStatus = "CANCEL";
            }else{
                lotStatus = obj.get("lotStatus").toString();
            }

            JSONObject estimatePrice = new JSONObject();
            estimatePrice.put("from", obj.get("estimatePrice_from"));
            estimatePrice.put("to", obj.get("estimatePrice_to"));

            lot.put("lotNumber", obj.get("lotNumber"));
            lot.put("lotPrice", obj.get("lotPrice"));
            lot.put("lotTotalPrice", Math.round(Float.parseFloat(obj.get("lotTotalPrice").toString())));
            lot.put("lotBidCount", obj.get("lotBidCount"));
            lot.put("lotStatus", lotStatus);
            lot.put("estimatePrice", estimatePrice);

            lotsData.add(lot);
        }

        JSONObject result = new JSONObject();
        result.put("saleNumber", saleNumber);
        result.put("lotData", lotsData);

        return result;
    }

    @RequestMapping(value = "/api/custs/leave/{custId}", method = RequestMethod.POST, produces = "application/json;charset=utf8")
    @ResponseBody
    public ResponseEntity<JSONObject> cust_leave(@PathVariable(value = "custId") String custId) {
        logger.info("/api/custs/leave/"+custId);

        try {
            JSONObject result = new JSONObject();

            // custId AES256 복호화
            custId = AuctionUtil.aesDecryptSSG(custId);
            logger.info("/api/custs/leave/" + custId);

            // check CUST
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("login_id", custId);
            paramMap.put("stat_cd", "normal");
            Map<String, Object> resultMap = commonService.getData("get_customer_by_login_id", paramMap);
            if (resultMap == null || resultMap.isEmpty()) {
                result.put("result", "fail");
                result.put("message", "NOT_FOUND");
                return new ResponseEntity<>(result, HttpStatus.NOT_FOUND);
            }

            // leave CUST
            paramMap.put("action_user_no", resultMap.get("CUST_NO"));
            commonService.modifyData("modify_cust_stat_cd_for_leave", paramMap);

            result.put("result", "success");
            result.put("message", "OK");
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            logger.error(e.getMessage());

            JSONObject result = new JSONObject();
            result.put("result", "fail");
            result.put("message", "INTERNAL_SERVER_ERROR");
            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
