package com.seoulauction.front.controller;

import com.seoulauction.ws.service.CommonService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("apiController")
public class ApiController {

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = "/api/lots", method = RequestMethod.GET, produces = "application/json;charset=utf8")
    @ResponseBody
    public JSONObject lots(@RequestParam Integer saleNumber, @RequestParam(value = "lotNumbers") List<Integer> lotNumbers) {
        System.out.println("/api/lots");
        JSONObject result = new JSONObject();

        System.out.println("/api/lots saleNumber: "+saleNumber);
        for(int lot : lotNumbers) {
            System.out.println("/api/lots lot: "+lot);
        }

        HashMap<String,Object> paramMap = new HashMap<>();
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

        result.put("saleNumber", saleNumber);
        result.put("lotData", lotsData);

        return result;
    }

}
