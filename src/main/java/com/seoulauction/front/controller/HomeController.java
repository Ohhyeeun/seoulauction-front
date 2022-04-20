package com.seoulauction.front.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpRequest;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.seoulauction.common.util.FileManager;
import com.seoulauction.ws.dto.Action;
import com.seoulauction.ws.dto.ActionSet;
import com.seoulauction.ws.dto.ResultDataSet;
import com.seoulauction.ws.service.CommonService;


@Controller("homeController")
public class HomeController {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	//@Autowired
	//private SessionRegistryImpl sessionRegistry;
	@Autowired
	CommonService commonService;

	@RequestMapping(value={"/"})
	public String home(@RequestParam(value = "screenType", required = false) String screenType, ModelMap model, String lang) 
	{
		
       /* logger.info("===========>Total logged-in users: {}", sessionRegistry.getAllPrincipals().size());
        logger.info("===========>List of logged-in users: ");
        for (Object username: sessionRegistry.getAllPrincipals()) {
        	logger.info("{}",username);
        }*/

		if(screenType != null && screenType.equals("M")){
			return "m_home";
		}
		else{
			return "home";
		}
	}

	@RequestMapping(value = "/{category}/page", method = RequestMethod.GET)
	public String viewPage(@PathVariable String category, @RequestParam(value = "view", required = true) String view) {
		String locale = "";
		if(LocaleContextHolder.getLocale().equals(Locale.ENGLISH)){
			locale = Locale.ENGLISH.getLanguage() + "/";
		}

		//chinaArtwork 을 타고 올경우 home 으로 보내도록 수정.
		if("chinaArtwork".equals(view)){
			return "home";
		}


		return "contents/" + locale + category + "/" + view + (!locale.equals("")?"Eng":"");
	}
	
	@RequestMapping(value = "noticeList", method = RequestMethod.GET)
	public String showNoticeList() {
		return "notice/noticeList";
	}
	
	@RequestMapping(value = "noticeView", method = RequestMethod.GET)
	public String showNoticeView(ModelMap model, @RequestParam(value = "write_no", required = true) String write_no) {
		model.addAttribute("write_no", write_no);
		return "notice/noticeView";
	}

}