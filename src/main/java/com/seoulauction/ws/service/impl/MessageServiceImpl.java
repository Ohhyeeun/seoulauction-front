package com.seoulauction.ws.service.impl;

import com.seoulauction.common.util.Config;
import com.seoulauction.ws.dao.CommonDao;
import com.seoulauction.ws.service.MessageService;
import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Map;

@Service("messageService")
public class MessageServiceImpl implements MessageService{

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private VelocityEngine velocityEngine;
	
	@Autowired
	private Config config;
	
	@Async
	public void AsyncSendMail(String to, String subject, String template, Map<String, Object> model) throws MessagingException{
		this.sendMail(to, subject, template, model);
	}
	
	public void sendMail(String to, String subject, String template, Map<String, Object> model) throws MessagingException{
		String mailFrom=config.getEmailFrom();  

		MimeMessage message = mailSender.createMimeMessage();
    	try{
        	MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
        	logger.info("====>from {} : to {}: subject {}", mailFrom, to, subject);
        	messageHelper.setSubject(subject);
    		messageHelper.setTo(to);
    		messageHelper.setFrom(mailFrom);
            String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, template, "UTF-8", model);
        	messageHelper.setText(text, true);
            //messageHelper.setText("간다고 한다.");
            /*FileSystemResource file = new FileSystemResource(new File("c:/Sample.jpg"));
            helper.addAttachment("CoolImage.jpg", file);*/

    		/*JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
    		mailSender.setHost("smtp.gmail.com");
    		mailSender.setPort(587);
    		mailSender.setUsername("debugger0101@gmail.com");
    		mailSender.setPassword("ybjung12");
    		Properties props = new Properties();
    		props.put("mail.transport.protocol", "smtp");
    		props.put("mail.smtp.auth", "true");
    		props.put("mail.smtp.starttls.enable", "true");
    		props.put("mail.debug", "true");
    		mailSender.setJavaMailProperties(props);*/
    		
            /*message.setSubject("간다고 해라.");
            message.setFrom(new InternetAddress(mailFrom));
            message.addRecipient(RecipientType.TO, new InternetAddress(to));
            message.setText("간다고 한다.");*/
                        
    		mailSender.send(message);
    		
    		/*MimeMessagePreparator preparator = new MimeMessagePreparator() {
                public void prepare(MimeMessage mimeMessage) throws Exception {
                    MimeMessageHelper message = new  MimeMessageHelper(mimeMessage, false, "UTF-8");
                    message.setSubject("welcome");
                    message.setTo(to);
                    message.setFrom(mailFrom); // could be parameterized...
                    String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, template, "UTF-8", model);
                    message.setText(text);
                }
            };
            mailSender.send(preparator);*/

    	}
    	catch(MessagingException ex){
    		throw ex;
    	}
	}

	@Async
	public void AsyncSendSMS(String to, String template, Map<String, Object> model){
		this.sendSMS(to, template, model);
	}

	public void sendSMS(String to, String template, Map<String, Object> model) {
		model.put("to_phone", to);
		model.put("from_phone", config.getMobileMsgCallback());
		int result = commonDao.insert("add_sms_msg", model);
	}
	
	@Async
	public void AsyncSendMMS(String to, String subject, String template, Map<String, Object> model){
		logger.debug("AsyncSendMMS");
		this.sendMMS(to, subject, template, model);
	}
	
	public void sendMMS(String to, String subject, String template, Map<String, Object> model) {
        String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, template, "UTF-8", model);

        model.put("to_phone", to);
        model.put("subject", subject);
		model.put("from_phone", config.getMobileMsgCallback());
		model.put("msg", text);

		int result = commonDao.insert("add_mms_msg", model);
	}
}
