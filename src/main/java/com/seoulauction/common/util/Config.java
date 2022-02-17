package com.seoulauction.common.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Config {
	@Value("#{configure['img.url']}")
	private String imageUrl;
	
	public String getImageUrl() {
		return imageUrl;
	}
	
	@Value("#{configure['file.temp.path']}")
	private String fileTempPath;
	
	public String getFileTempPath() {
		return fileTempPath;
	}

	@Value("#{configure['file.root.path']}")
	private String fileRootPath;
	
	public String getFileRootPath() {
		return fileRootPath;
	}

	@Value("#{configure['scheduler.use']}")
	private boolean useScheduler;
	
	public boolean getUseScheduler() {
		return useScheduler;
	}

	@Value("#{configure['scheduler.time']}")
	private String STIME;
	
	public String getSTIME() {
		return STIME;
	}
	
	@Value("#{configure['email.smtp.host']}")
	private String emailSMTPHost;
	
	public String getEmailSMTPHost() {
		return emailSMTPHost;
	}
	
	@Value("#{configure['email.smtp.port']}")
	private String emailSMTPPort;
	
	public String getEmailSMTPPort() {
		return emailSMTPPort;
	}


	@Value("#{configure['email.smtp.user']}")
	private String emailSMTPUser;
	
	public String getEmailSMTPUser() {
		return emailSMTPUser;
	}

	@Value("#{configure['email.smtp.passwd']}")
	private String emailSMTPPasswd;
	
	public String getEmailSMTPPasswd() {
		return emailSMTPPasswd;
	}

	@Value("#{configure['email.from']}")
	private String emailFrom;
	
	public String getEmailFrom() {
		return emailFrom;
	}
	
	@Value("#{configure['email.transport.protocol']}")
	private String emailTransportProtocol;
	
	public String getEmailTransportProtocol() {
		return emailTransportProtocol;
	}

	@Value("#{configure['email.smtp.auth']}")
	private String emailSMTPAuth;
	
	public String getEmailSMTPAuth() {
		return emailSMTPAuth;
	}
	
	@Value("#{configure['email.smtp.starttls']}")
	private String emailSMTPSTLS;
	
	public String getEmailSMTPSTLS() {
		return emailSMTPSTLS;
	}

	@Value("#{configure['mobile.msg.callback']}")
	private String mobileMsgCallback;
	
	public String getMobileMsgCallback() {
		return mobileMsgCallback;
	}
	
	@Value("#{configure['mobile.msg.auth']}")
	private String mobileMsgAuth;
	public String getMobileMsgAuth() {
		return mobileMsgAuth;
	}
}
