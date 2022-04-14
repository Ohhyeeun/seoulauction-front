package com.seoulauction.common.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Config {

	//@Value("${img.url}")
	private String imageUrl;
	
	public String getImageUrl() {
		return imageUrl;
	}
	
	@Value("${file.temp.path}")
	private String fileTempPath;
	
	public String getFileTempPath() {
		return fileTempPath;
	}

	@Value("${file.root.path}")
	private String fileRootPath;
	
	public String getFileRootPath() {
		return fileRootPath;
	}

	@Value("${scheduler.use}")
	private boolean useScheduler;
	
	public boolean getUseScheduler() {
		return useScheduler;
	}

	@Value("${scheduler.time}")
	private String STIME;
	
	public String getSTIME() {
		return STIME;
	}
	
	@Value("${email.smtp.host}")
	private String emailSMTPHost;
	
	public String getEmailSMTPHost() {
		return emailSMTPHost;
	}
	
	@Value("${email.smtp.port}")
	private String emailSMTPPort;
	
	public String getEmailSMTPPort() {
		return emailSMTPPort;
	}


	@Value("${email.smtp.user}")
	private String emailSMTPUser;
	
	public String getEmailSMTPUser() {
		return emailSMTPUser;
	}

	@Value("${email.smtp.passwd}")
	private String emailSMTPPasswd;
	
	public String getEmailSMTPPasswd() {
		return emailSMTPPasswd;
	}

	@Value("${email.from}")
	private String emailFrom;
	
	public String getEmailFrom() {
		return emailFrom;
	}
	
	@Value("${email.transport.protocol}")
	private String emailTransportProtocol;
	
	public String getEmailTransportProtocol() {
		return emailTransportProtocol;
	}

	@Value("${email.smtp.auth}")
	private String emailSMTPAuth;
	
	public String getEmailSMTPAuth() {
		return emailSMTPAuth;
	}
	
	@Value("${email.smtp.starttls}")
	private String emailSMTPSTLS;
	
	public String getEmailSMTPSTLS() {
		return emailSMTPSTLS;
	}

	@Value("${mobile.msg.callback}")
	private String mobileMsgCallback;
	
	public String getMobileMsgCallback() {
		return mobileMsgCallback;
	}
	
	@Value("${mobile.msg.auth}")
	private String mobileMsgAuth;
	public String getMobileMsgAuth() {
		return mobileMsgAuth;
	}

	@Value("${is.phone.auth}")
	private Boolean isPhoneAuth;
	public Boolean getIsPhoneAuth() {
		return isPhoneAuth;
	}
	
	@Value("${nicepay.encodeKey}")
	private String nicepayEncodeKey;
	public String getNicepayEncodeKey() {
		return nicepayEncodeKey;
	}
}
