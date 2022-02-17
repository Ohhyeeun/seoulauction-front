package com.seoulauction.ws.service.impl;

import com.seoulauction.common.util.Config;
import com.seoulauction.ws.dao.CommonDao;
import com.seoulauction.ws.service.ScheduleService;
import org.quartz.JobDataMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.CronTriggerBean;
import org.springframework.scheduling.quartz.JobDetailBean;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.text.ParseException;
import java.util.Date;


@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private SchedulerFactoryBean scheduler;
	
	@Autowired
	private CommonDao commonDao;
	
	@Autowired
	private Config config;
	
	@Override
	@PostConstruct
	public void initSchedule(){
		if(!config.getUseScheduler()) return;
		try{
			createSchedule("1");
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	private void createSchedule(String name) throws ParseException, Exception{
		CronTriggerBean ct = new CronTriggerBean();
		//ct.setGroup(Constants.JOB_GROUP);
		ct.setName("t"+name);
		Date sdate = new Date();
		Date edate = new Date();
		//ct.setStartTime(sdate);
		//ct.setEndTime(edate);
		ct.setCronExpression(config.getSTIME());
		
		JobDetailBean jd = new JobDetailBean();
		//jd.setJobClass(com.seoulauction.common.quartz.JobLauncherDetails.class);
		jd.setJobClass(Class.forName("com.seoulauction.common.quartz.TestJob"));

		//jd.setGroup();
		jd.setName(name);
		
		JobDataMap jobDataMap = new JobDataMap();
		jobDataMap.put("name", name);
		jobDataMap.put("dao", commonDao);
		jd.setJobDataMap(jobDataMap);
		/*JobDataMap jobDataMap = new JobDataMap();
		jobDataMap.put("SCHED_NO", "1");
		jobDataMap.put("SCHED_NAME", "test1");
		jobDataMap.put("JOB_RUNNER", this.jobRunner);
		jobDataMap.put("CONFIG", config);
		jd.setJobDataMap(jobDataMap);*/
		
		jd.afterPropertiesSet();
		
		ct.setJobDetail(jd);
        ct.afterPropertiesSet();

        this.scheduler.getScheduler().scheduleJob(jd, ct);
	}

	/*
	private CronTriggerBean getTrigger() throws Exception{
		Map<String, Date> dates = this.checkDate();
		
		if(dates == null) return null;

		Date sdate = dates.get("START_DT");
		Date edate = dates.get("END_DT");
		String ce =  this.generateCronExpression(row);
		CronTriggerBean ct = null;
		if(ce != null){
			ct = new CronTriggerBean();
			ct.setGroup(Constants.JOB_GROUP);
			ct.setName(Constants.JOB_TRIGGER_PREFIX + row.get("SCHED_NO"));
			
			ct.setStartTime(sdate);
			ct.setEndTime(edate);
			ct.setCronExpression(ce);
		}
		
		return ct;
	}*/
	
}
