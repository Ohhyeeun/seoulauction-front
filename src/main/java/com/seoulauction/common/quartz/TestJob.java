package com.seoulauction.common.quartz;

import com.seoulauction.ws.dao.CommonDao;
import org.quartz.JobExecutionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import java.util.List;
import java.util.Map;

public class TestJob extends QuartzJobBean {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@SuppressWarnings("unchecked")
	protected void executeInternal(JobExecutionContext context) {
		
		
		Map<String, Object> jobDataMap = context.getMergedJobDataMap();
		
		CommonDao commonDao = (CommonDao)jobDataMap.get("dao");
		List<Map<String, Object>> resultList = commonDao.selectList("get_auth_number", null);
		logger.debug("======ll=l=l=l=ll=l>> {} ", resultList);
		//logger.debug("======ll=l=l=l=ll=l>> {} ", jobDataMap);
		//logger.debug("======ll=l=l=l=ll=l>> {} ", (String) jobDataMap.get("name"));

		/*for(int i=0; i< 10; i++){
			try{
				logger.debug("======ll=l=l=l=ll=l>> {} : {} ", (String) jobDataMap.get("name"), i);
				Thread.sleep(2000);
			}
			catch(Exception ex){
				ex.printStackTrace();
			}
		}*/
		
		//JobParameters jobParameters = getJobParametersFromJobMap(jobDataMap);

		//logger.debug("======ll=l=l=l=ll=l>> {} ", jobParameters);
		

		/*try {
			jobLauncher.run(jobLocator.getJob(jobName), jobParameters);
		} catch (JobExecutionException e) {
			e.printStackTrace();
		}*/
		

	}

}