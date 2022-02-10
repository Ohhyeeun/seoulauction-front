package com.seoulauction.front.controller;

import java.io.File;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.seoulauction.common.util.Config;

@Controller
public class FileDownloadController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = LoggerFactory.getLogger(FileDownloadController.class);
	
	@Autowired
	public Config config;

	@RequestMapping("/fileDownload")
	public void download(String fileName, String path, String orgName, HttpServletResponse response) throws Exception {
		try {
			//String orgFile = URLEncoder.encode(orgName.replace(" ", "_"),"UTF-8");
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.setHeader("Content-Disposition", "attachment;filename=" + orgName + ";");
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Expires", "-1;");
			File file = new File(config.getFileRootPath() + path + fileName);
			if(file.isFile()){
				FileCopyUtils.copy(FileCopyUtils.copyToByteArray(file), response.getOutputStream());
			}
			else{
				throw new Exception("no File");
			}
		} catch(Exception e) {
			throw e;
		}
	}
}
