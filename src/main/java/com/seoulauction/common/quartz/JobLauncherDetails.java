package com.seoulauction.common.quartz;

import com.seoulauction.ws.dao.CommonDao;
import org.apache.commons.io.FileUtils;
import org.quartz.JobExecutionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class JobLauncherDetails extends QuartzJobBean {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	static final String JOB_NAME = "jobName";
	
	@SuppressWarnings("unchecked")
	protected void executeInternal(JobExecutionContext context) {
		
		
		Map<String, Object> jobDataMap = context.getMergedJobDataMap();
		
		logger.debug("======ll=l=l=l=ll=l>> {} ", jobDataMap);
		logger.debug("======ll=l=l=l=ll=l>> {} ", (String) jobDataMap.get(JOB_NAME));
		String jobName = (String) jobDataMap.get(JOB_NAME);

		//JobParameters jobParameters = getJobParametersFromJobMap(jobDataMap);

		//logger.debug("======ll=l=l=l=ll=l>> {} ", jobParameters);
		

		/*try {
			jobLauncher.run(jobLocator.getJob(jobName), jobParameters);
		} catch (JobExecutionException e) {
			e.printStackTrace();
		}*/
		
		try{
    		String rootPath = "/data1/sanas01/data/images";
    		CommonDao commonDao = (CommonDao)jobDataMap.get("dao");
    		List<Map<String, Object>> resultList = commonDao.selectList("maigration_image", null);

    		int i = 0;
    		for(Map<String, Object> resultMap : resultList){
    			try{
        			logger.debug("[maigration_image]=========> file copy {} : {}", ++i, resultMap);
        			if(resultMap != null && resultMap.size() > 0){
        				if(resultMap.get("old_file_path") != null && resultMap.get("file_name") != null
        						&& resultMap.get("new_file_path") != null){
                			copyFile(rootPath + resultMap.get("old_file_path").toString() + "/" + resultMap.get("file_name").toString(),
                					rootPath + resultMap.get("new_file_path").toString() + "/" + resultMap.get("file_name").toString());
        					
        				}
        				else{
        					logger.debug("[maigration_image]=========> image null skip");
        				}
        				if(resultMap.get("old_thum_file_path") != null && resultMap.get("file_name") != null
        						&& resultMap.get("new_thum_file_path") != null){
                			copyFile(
                    				rootPath + resultMap.get("old_thum_file_path").toString() + "/" + resultMap.get("file_name").toString()
                    				, rootPath + resultMap.get("new_thum_file_path").toString() + "/" + resultMap.get("file_name").toString());
        				}
        				else{
        					logger.debug("[maigration_image]=========> thumb null skip");
        				}
        			}
    			}
    			catch(Exception ex){
    				logger.debug("[maigration_image]=========> exception {}", ex.getMessage());
    			}
    		}
    	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
	}


	private void copyFile(String src, String dst){
		File sf = new File(src);
		File tf = new File(dst);
		
		if(!sf.exists()){
			logger.debug("[maigration_image]====> src not exist {}", sf.getName());
			return;
		}
		if(tf.exists()){
			if(sf.length() == tf.length()) {
				logger.debug("[maigration_image]====> target exist, size= skip {}", tf.getName());
				return;
			}
			if(!tf.delete()){
				logger.debug("[maigration_image]====> target exist, delete error {}", tf.getName());
				return;
			}
			else{
				logger.debug("[maigration_image]====> target exist, delete {}", tf.getName());
			}
		}
		
		try {
			FileUtils.copyFile(sf, tf);
		} catch (IOException e) {
			logger.error("[maigration_image]=============> {} ", e.getMessage());
			e.printStackTrace();
		}
    }
}