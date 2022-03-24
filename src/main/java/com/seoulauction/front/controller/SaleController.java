package com.seoulauction.front.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.seoulauction.ws.service.CommonService;

@Controller("saleController")
public class SaleController {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	CommonService commonService;


    @RequestMapping(value="/currentAuction")
    public String currentAuction(@RequestParam Map<String, String> params,  ModelMap model){
    	
		model.addAttribute("VIEW_ID", "CURRENT_AUCTION");
		model.addAttribute("STATUS", "current");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));

		String viewType = params.get("view_type") == null ? "GRID" : params.get("view_type").toString();
		model.addAttribute("VIEW_TYPE", viewType);

		if(params.containsKey("sale_kind")) model.addAttribute("SALE_KIND_CD", params.get("sale_kind"));
		
		return "/sale/lotList";
    }

    @RequestMapping(value="/saleLot_Result")
    public String saleLot_Result(@RequestParam Map<String, String> params,  ModelMap model){
    	
    	model.addAttribute("VIEW_ID", "RESULT_AUCTION");
		model.addAttribute("STATUS", "finish");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));

		String viewType = params.get("view_type") == null ? "GRID" : params.get("view_type").toString();
		model.addAttribute("VIEW_TYPE", viewType);
		
		if(params.containsKey("sale_kind")) model.addAttribute("SALE_KIND_CD", params.get("sale_kind"));
		
		return "/sale/saleLot_Result";
    }
    
    /* YDH 추가. START */
    @RequestMapping(value="/currentAuctionTest")
    public String currentAuctionTest(@RequestParam Map<String, String> params,  ModelMap model){
    	
		model.addAttribute("VIEW_ID", "CURRENT_AUCTION");
		model.addAttribute("STATUS", "current");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));

		String viewType = params.get("view_type") == null ? "GRID" : params.get("view_type").toString();
		model.addAttribute("VIEW_TYPE", viewType);

		if(params.containsKey("sale_kind")) model.addAttribute("SALE_KIND_CD", params.get("sale_kind"));
		
				
		return "/sale/lotList_test";
    }
    @RequestMapping(value="/lotDetailTest")
    public String lotDetailTest(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "LOT_DETAIL");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/lotDetailTest";
    }

    @RequestMapping(value="/saleDetailTest")
    public String saleDetailTest(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "LOT_LIST");
		if(params.containsKey("view_id")){
			model.addAttribute("VIEW_ID", params.get("view_id"));
			if(model.get("VIEW_ID").equals("RESULT_AUCTION")) model.put("VIEW_ID", "RESULT_LOT_LIST");

		}
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));

		String viewType = params.get("view_type") == null ? "GRID" : params.get("view_type").toString();
		model.addAttribute("VIEW_TYPE", viewType);

    	return "/sale/lotList_test";
    }    
    /* YDH 추가. END */
    @RequestMapping(value="/upcomingAuction")
    public String upcomingAuction(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "UPCOMING_AUCTION");
		model.addAttribute("STATUS", "upcoming");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		String viewType = params.get("view_type") == null ? "GRID" : params.get("view_type").toString();
		model.addAttribute("VIEW_TYPE", viewType);

		if(params.containsKey("sale_kind")) model.addAttribute("SALE_KIND_CD", params.get("sale_kind"));

		return "/sale/upcoming";
    }

    @RequestMapping(value="/resultAuction")
    public String resultAuction(@RequestParam Map<String, String> params, ModelMap model){
		model.addAttribute("VIEW_ID", "RESULT_AUCTION");
		model.addAttribute("STATUS", "finish");
		if(params.containsKey("sale_kind")) model.addAttribute("SALE_KIND_CD", params.get("sale_kind"));
    	return "/sale/saleList";
    }

    /*@RequestMapping(value="/otherSales")
    public String otherSales(@RequestParam Map<String, String> params, ModelMap model){
		model.addAttribute("VIEW_ID", "OTHER_SALES");
    	return "/sale/saleList";
    }*/

    @RequestMapping(value="/search")
    public String search(@RequestParam Map<String, String> params, ModelMap model, HttpServletRequest request){
    	
    	return "/sale/lotSearchList";
    }

    @RequestMapping(value="/saleDetail")
    public String saleDetail(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "LOT_LIST");
		if(params.containsKey("view_id")){
			model.addAttribute("VIEW_ID", params.get("view_id"));
			if(model.get("VIEW_ID").equals("RESULT_AUCTION")) model.put("VIEW_ID", "RESULT_LOT_LIST");

		}
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));

		String viewType = params.get("view_type") == null ? "GRID" : params.get("view_type").toString();
		model.addAttribute("VIEW_TYPE", viewType);

		if(params.containsKey("sale_kind")) model.addAttribute("SALE_KIND_CD", params.get("sale_kind"));
		
    	return "/sale/lotList";
    }

    @RequestMapping(value="/lotOutsideDetail")
    public String lotOutsideDetail(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "LOT_DETAIL");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/lotOutsideDetail";
    }
    
    @RequestMapping(value="/lotDetail")
    public String lotDetail(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "LOT_DETAIL");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/lotDetail";
    }
    
    @RequestMapping(value="/lotDetailPrt") 
    public String lotDetailPrt(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "LOT_DETAIL");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/lotDetailPrt";
    }
    
    @RequestMapping(value="/conditionPrt") 
    public String conditionPrt(@RequestParam Map<String, String> params,  ModelMap model){
		//model.addAttribute("VIEW_ID", "LOT_DETAIL");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/conditionPrt";
    }

    @RequestMapping(value="/bidHistory")
    public String bidHistory(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "BID_HISTORY");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/popup/bidHistoryPop";
    }

    @RequestMapping(value="/bidRequest")
    public String bidRequest(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "BID_REQUEST");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/popup/bidRequestPop";
    }

    @RequestMapping(value="/conditionReport")
    public String conditionReport(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "CONDITION_REPORT");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/popup/conditionReportPop";
    }
    
    @RequestMapping(value="/liveAuctionPop")
    public String liveAuctionPop(@RequestParam Map<String, String> params,  ModelMap model){
		if(params.containsKey("padd_no")) model.addAttribute("PADD_NO", params.get("padd_no"));
    	return "/sale/popup/liveAuctionPop";
    }

    @RequestMapping(value="/bid")
    public String bid(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "BID");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/popup/bidPop";
    }
    
    @RequestMapping(value="/zoomImage")
    public String zoomImage(){

    	return "/sale/popup/zoomImagePop";
    }
    
	@RequestMapping(value="/sale/certification")
	public String showCertification(ModelMap model, String sale_no, String lot_no, HttpServletRequest request){
		//String[] lots = lotnum.split(":");
		//List<Map<String, Object>> artworkList = auctionService.getArtworkListByLots(acode, lots);
		//model.put("artworkList", artworkList);
		//Map<String, Object> auction = auctionService.getAuction(acode, null);
		//model.put("auction", auction);
		Map<String, Object> paramMap = new HashMap<String, Object>();
    	paramMap.put("sale_no", sale_no); 
    	paramMap.put("lot_no", lot_no);
    	Map<String, Object> saleInfo = commonService.getData("sale_info", paramMap);
    	Map<String, Object> lotInfo = commonService.getData("lot_info", paramMap); 
    	logger.info("====== >> {}", saleInfo);
    	model.addAttribute("saleInfo", saleInfo);
    	model.addAttribute("lotInfo", lotInfo);
    	
		return "/sale/certification";
	}

    @RequestMapping(value="/saleCert")
    public String saleCert(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "SALE_CERT");

		if (params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		return "/sale/popup/saleCert";
    }

    @RequestMapping(value="/soldInvoiceReport")
    public String soldInvoiceReport(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "SOLD_INVOICE");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("cust_no")) model.addAttribute("CUST_NO", params.get("cust_no"));
		if(params.containsKey("invoice_dt")) model.addAttribute("INVOICE_DT", params.get("invoice_dt"));

		return "/sale/soldInvoiceReport";
    }
    /* 전시페이지 추가. 2018.09.20 YDH 추가. START*/
    @RequestMapping(value="/currentExhibit") 
    public String currentExhibit(@RequestParam Map<String, String> params,  ModelMap model){
    	
		model.addAttribute("VIEW_ID", "CURRENT_EXHIBIT");
		model.addAttribute("STATUS", "current");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));

		String viewType = params.get("view_type") == null ? "GRID" : params.get("view_type").toString();
		model.addAttribute("VIEW_TYPE", viewType);

		if(params.containsKey("sale_kind")) model.addAttribute("SALE_KIND_CD", params.get("sale_kind"));
		
				
		return "/sale/lotListExhibit";
    }
    @RequestMapping(value="/lotDetailExhibit")
    public String lotDetailExhibit(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "LOT_DETAIL");
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));
		if(params.containsKey("lot_no")) model.addAttribute("LOT_NO", params.get("lot_no"));

    	return "/sale/lotDetailExhibit";
    }

    @RequestMapping(value="/exhibitDetail")
    public String exhibitDetail(@RequestParam Map<String, String> params,  ModelMap model){
		model.addAttribute("VIEW_ID", "LOT_LIST");
		if(params.containsKey("view_id")){
			model.addAttribute("VIEW_ID", params.get("view_id"));
			if(model.get("VIEW_ID").equals("RESULT_EXHIBIT")) model.put("VIEW_ID", "RESULT_LOT_LIST");

		}
		if(params.containsKey("sale_no")) model.addAttribute("SALE_NO", params.get("sale_no"));

		String viewType = params.get("view_type") == null ? "GRID" : params.get("view_type").toString();
		model.addAttribute("VIEW_TYPE", viewType);
		
		if(params.containsKey("sale_kind")) model.addAttribute("SALE_KIND_CD", params.get("sale_kind"));
		
    	return "/sale/lotListExhibit";
    }    
    @RequestMapping(value="/resultExhibit")
    public String resultExhibit(@RequestParam Map<String, String> params, ModelMap model){
		model.addAttribute("VIEW_ID", "RESULT_EXHIBIT");
		model.addAttribute("STATUS", "finish");
		if(params.containsKey("sale_kind")) model.addAttribute("SALE_KIND_CD", params.get("sale_kind"));
    	return "/sale/exhibitList";
    }
    /* YDH 추가. END */
    /* ZeroBase 온라인 경매 작가정보 페이지(2019.10.28 YDH)*/
    @RequestMapping(value="/zerobaseArtist")
    public String zerobaseArtist(@RequestParam Map<String, String> params, ModelMap model, HttpServletRequest request){
    	return "/sale/zerobase_Artist";
    }
    
    @RequestMapping(value="/zerobaseList")
    public String zerobaseList(@RequestParam Map<String, String> params, ModelMap model, HttpServletRequest request){
    	return "/sale/zerobase_list";
    } 
    
    /* YDH 추가. 이미지 자세히 보기 페이지 */
    @RequestMapping(value="/lotDetailImgView")
    public String lotDetailImgView(@RequestParam Map<String, String> params,  ModelMap model){
		
    	return "/sale/popup/lotDetailImgView";
    }
    
    /* ps/as 프라이빗 세일 전시페이지 추가 */ 
    @RequestMapping(value="/currentPrivate") 
    public String currentPrivate(@RequestParam Map<String, String> params, ModelMap model, HttpServletRequest request){
		return "/sale/lotListPrivate";    
    }
    
    
    @RequestMapping(value="/lotDetailPrivate") 
    public String lotDetailPrivate(@RequestParam Map<String, String> params, ModelMap model, HttpServletRequest request){
    	return "/sale/lotDetailPrivate";
    } 
    
}
