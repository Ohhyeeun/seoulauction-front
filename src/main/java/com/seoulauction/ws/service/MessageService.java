package com.seoulauction.ws.service;

import javax.mail.MessagingException;
import java.util.Map;

public interface MessageService {

	public void AsyncSendMail(String to, String subject, String template, Map<String, Object> model)  throws MessagingException;
	public void sendMail(String to, String subject, String template, Map<String, Object> model)  throws MessagingException ;
	public void AsyncSendSMS(String to, String template, Map<String, Object> model);
	public void sendSMS(String to, String template, Map<String, Object> model);
	public void AsyncSendMMS(String to, String subject, String template, Map<String, Object> model);
	public void sendMMS(String to, String subject, String template, Map<String, Object> model);
}
