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


@Controller("contentsController")
public class ContentsController {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	//@Autowired
	//private SessionRegistryImpl sessionRegistry;
	@Autowired
	CommonService commonService;

	/* YDH 추가. academy 관련 */
	@RequestMapping(value = "academyArtauctionView", method = RequestMethod.GET)
	public String showAcademyArtauctionView(ModelMap model, @RequestParam(value = "academy_no", required = true) String academy_no) {
		model.addAttribute("academy_no", academy_no);
		if(LocaleContextHolder.getLocale().equals(Locale.ENGLISH)){
			return "contents/en/service/academyArtauctionViewEng";
		} else {
			return "contents/service/academyArtauctionView";
		}
	}
	
	@RequestMapping(value = "academyArtcultureView", method = RequestMethod.GET)
	public String showAcademyArtcultureView(ModelMap model, @RequestParam(value = "academy_no", required = true) String academy_no) {
		model.addAttribute("academy_no", academy_no);
		if(LocaleContextHolder.getLocale().equals(Locale.ENGLISH)){
			return "contents/en/service/academyArtcultureViewEng";
		} else {
			return "contents/service/academyArtcultureView";
		}
	}
	
	@RequestMapping(value = "academyArtisttalkView", method = RequestMethod.GET)
	public String showAcademyArtisttalkView(ModelMap model, @RequestParam(value = "academy_no", required = true) String academy_no) {
		model.addAttribute("academy_no", academy_no);
		if(LocaleContextHolder.getLocale().equals(Locale.ENGLISH)){
			return "contents/en/service/academyArtisttalkViewEng";
		} else {
			return "contents/service/academyArtisttalkView";
		}
	}
	
	@RequestMapping(value = "academyCultureView", method = RequestMethod.GET)
	public String showAcademyCultureView(ModelMap model, @RequestParam(value = "academy_no", required = true) String academy_no) {
		model.addAttribute("academy_no", academy_no);
		if(LocaleContextHolder.getLocale().equals(Locale.ENGLISH)){
			return "contents/en/service/academyCultureViewEng";
		} else {
			return "contents/service/academyCultureView";
		}
	}
	
	@RequestMapping(value = "academyLectureView", method = RequestMethod.GET)
	public String showAcademyLectureView(ModelMap model, @RequestParam(value = "academy_no", required = true) String academy_no) {
		model.addAttribute("academy_no", academy_no);
		if(LocaleContextHolder.getLocale().equals(Locale.ENGLISH)){
			return "contents/en/service/academyLectureViewEng";
		} else {
			return "contents/service/academyLectureView";
		}
	}
	
	@RequestMapping(value = "academyArtbrunchView", method = RequestMethod.GET)
	public String showAcademyArtbrunchView(ModelMap model, @RequestParam(value = "academy_no", required = true) String academy_no) {
		model.addAttribute("academy_no", academy_no);
		if(LocaleContextHolder.getLocale().equals(Locale.ENGLISH)){
			return "contents/en/service/academyArtbrunchViewEng";
		} else {
			return "contents/service/academyArtbrunchView";
		}
	}
	
	@RequestMapping(value = "academyArtBusanView", method = RequestMethod.GET)
	public String showAcademyArtBusanView(ModelMap model, @RequestParam(value = "academy_no", required = true) String academy_no) {
		model.addAttribute("academy_no", academy_no);
		if(LocaleContextHolder.getLocale().equals(Locale.ENGLISH)){
			return "contents/en/service/academyArtBusanViewEng";
		} else {
			return "contents/service/academyArtBusanView";
		}
	}
}