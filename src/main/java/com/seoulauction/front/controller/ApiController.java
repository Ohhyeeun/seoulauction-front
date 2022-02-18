package com.seoulauction.front.controller;

import com.seoulauction.ws.service.CommonService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("apiController")
public class ApiController {

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = "/lots", method = RequestMethod.POST, produces = "application/json;charset=utf8")
    @ResponseBody
    public JSONObject lots(@RequestBody Map<String, Object> paramMap) {
        JSONObject result = new JSONObject();

        JSONArray lotsData = new JSONArray();
        List<Map<String,Object>> lotsMap = new ArrayList<Map<String,Object>>();
        lotsMap = commonService.getDataList("select_lots", paramMap);

        for(Map<String, Object> obj : lotsMap){
            JSONObject lot = new JSONObject();

            String lotStatus = "READY";
            if(obj.get("stat_cd").equals("reentry")){
                lotStatus = "CANCLE";
            }else{
                lotStatus = obj.get("lotStatus").toString();
            }

            JSONObject estimatePrice = new JSONObject();
            estimatePrice.put("from",obj.get("estimatePrice_from"));
            estimatePrice.put("to",obj.get("estimatePrice_to"));

            lot.put("lotNumber", obj.get("lotNumber"));
            lot.put("lotPrice", obj.get("lotPrice"));
            lot.put("lotTotalPrice", Math.round(Float.parseFloat(obj.get("lotTotalPrice").toString())));
            lot.put("lotBidCount", obj.get("lotBidCount"));
            lot.put("lotStatus", lotStatus);
            lot.put("estimatePirce", estimatePrice);

            lotsData.add(lot);
        }
        result.put("lotData", lotsData);
        result.put("saleNo", paramMap.get("saleNumber"));

        return result;
    }


    @RequestMapping(value = "/lots", method = RequestMethod.GET, produces = "application/json;charset=utf8")
    @ResponseBody
    public JSONObject lotsget(@RequestBody String sale_no) {
        System.out.println("Get lotsjson");
        JSONObject result = new JSONObject();

        HashMap<String,Object> paramMap = new HashMap<>();
        int[] lotNumbers = {1,2,3,4,5,6};

        paramMap.put("lotNumbers", lotNumbers);
        paramMap.put("saleNumber", 659);

        JSONArray lotsData = new JSONArray();
        List<Map<String,Object>> lotsMap = new ArrayList<Map<String,Object>>();
        lotsMap = commonService.getDataList("select_lots", paramMap);

        for(Map<String, Object> obj : lotsMap){
            JSONObject lot = new JSONObject();

            String lotStatus = "READY";
            if(obj.get("stat_cd").equals("reentry")){
                lotStatus = "CANCLE";
            }else{
                lotStatus = obj.get("lotStatus").toString();
            }

            JSONObject estimatePrice = new JSONObject();
            estimatePrice.put("from",obj.get("estimatePrice_from"));
            estimatePrice.put("to",obj.get("estimatePrice_to"));

            lot.put("lotNumber", obj.get("lotNumber"));
            lot.put("lotPrice", obj.get("lotPrice"));
            lot.put("lotTotalPrice", Math.round(Float.parseFloat(obj.get("lotTotalPrice").toString())));
            lot.put("lotBidCount", obj.get("lotBidCount"));
            lot.put("lotStatus", lotStatus);
            lot.put("estimatePirce", estimatePrice);

            lotsData.add(lot);
        }
        result.put("lotData", lotsData);
        result.put("saleNo", 659);

        return result;
    }

}
