package com.seoulauction.ws.service.impl;

import com.seoulauction.common.exception.DataSetException;
import com.seoulauction.common.exception.DataSetException.EXCEPTION_CODE;
import com.seoulauction.common.util.AddressFinder;
import com.seoulauction.common.util.FileManager;
import com.seoulauction.ws.dao.CommonDao;
import com.seoulauction.ws.dto.Action;
import com.seoulauction.ws.dto.Action.ACTION_TYPE;
import com.seoulauction.ws.dto.ActionSet;
import com.seoulauction.ws.dto.ResultDataSet;
import com.seoulauction.ws.service.CommonService;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service("commonService")
public class CommonServiceImpl implements CommonService {
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private CommonDao commonDao;
		
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor=DataSetException.class)
	public ResultDataSet actionSet(ActionSet actionSet) throws DataSetException{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Map<String, Long> uidMap = new HashMap<String, Long>();

		int resultCode = -99;
		String resultMsg = null;
		String resultDesc = null;
		try{
			if(actionSet == null || actionSet.getActionList().size() < 1){
				throw new DataSetException(EXCEPTION_CODE.ACTION_SET);
			}
			for(Action action : actionSet.getActionList()){
				
				if(action.getActionID() == null){
					throw new DataSetException(EXCEPTION_CODE.ACTION_ID);
				}

				if(action.getActionType() == null){
					throw new DataSetException(EXCEPTION_CODE.ACTION_TYPE);
				}

				if(actionSet.getBaseParms() == null){
					actionSet.setBaseParms(new HashMap<String, Object>());
				}
				
				if((action.getParmsList() == null || action.getParmsList().size() < 1)
						&& !ACTION_TYPE.valueOf(action.getActionType()).equals(ACTION_TYPE.select) ){
					break;
				}
				
				if(action.getParmsList() == null){
					action.setParmsList(new ArrayList<Map<String,Object>>());
				}
				
				if(action.getParmsList().size() < 1){
					action.getParmsList().add(actionSet.getBaseParms());
				}
				
				int index = 0;
				int result = 0;

				if(action.getUidKey() != null) uidMap.put(action.getUidKey(), (long) 0);
				Map<String, Object> tableMap = null;
				
				for(Map<String, Object> param : action.getParmsList()){
					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.putAll(actionSet.getBaseParms());
					paramMap.putAll(param);
					
					try{
						switch(ACTION_TYPE.valueOf(action.getActionType())){
						case select:
							paramMap.putAll(uidMap);
							tableMap = commonDao.selectForResultDataSet(action.getActionID(), paramMap);
							break;
						case insert:
							paramMap.putAll(uidMap);
							result += commonDao.insert(action.getActionID(), paramMap);
							
							if(action.getUidKey() != null){
								tableMap = getTableMap(result, action.getUidKey(), (Long) paramMap.get(action.getUidKey()));
							}else{
								tableMap = getTableMap(result);
							}
							break;
						case update:
							result += commonDao.update(action.getActionID(), paramMap);
							tableMap = getTableMap(result);
							break;
						case delete:
							result += commonDao.delete(action.getActionID(), paramMap);
							tableMap = getTableMap(result);
							break;
						}
						
						if(action.getUidKey() != null){
							logger.debug("uidMap => {}, param => {}",action.getUidKey(), paramMap.get(action.getUidKey()));
							if(paramMap.get(action.getUidKey()) instanceof HashMap){
								HashMap<String, Object> keyMap = (HashMap<String, Object>) paramMap.get(action.getUidKey());
								List<Object> rows = (List<Object>) keyMap.get("rows"); 
								uidMap.put(action.getUidKey(), (Long) rows.get(0));
							}
							else{
								uidMap.put(action.getUidKey(), (Long) paramMap.get(action.getUidKey()));
							}
						}
					}
					catch(Exception e){
						throw new DataSetException(EXCEPTION_CODE.SQL, e.getMessage());
					}
					
					if(logger.isDebugEnabled()){
						try{
							ObjectMapper map = new ObjectMapper();
							logger.debug("\n{} - ==> Columns: {}\n==> Rows: {}\n"
									, action.getActionID()
									, map.writeValueAsString(tableMap.get("columns"))
									, map.writer().withDefaultPrettyPrinter().writeValueAsString(tableMap.get("rows")));
						}catch(Exception ex){}
					}

				}
				if(tableMap != null){
					resultMap.put(action.getTableName() != null ? action.getTableName() : "TABLE" + index++, tableMap);
					tableMap = null;
				}
				else{
					throw new DataSetException(EXCEPTION_CODE.RESULT);
				}
			}
			resultCode = 0;
		}
		catch(DataSetException ex){
			//resultCode = ex.getExceptionCode().getValue();
			//resultMsg = ex.getMessage();
			//resultDesc = ex.toString();
			//TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw ex;
		}

		ResultDataSet resultDataSet = new ResultDataSet();
		resultDataSet.setResultCode(resultCode);
		resultDataSet.setResultMessage(resultMsg);
		resultDataSet.setResultDescription(resultDesc);
		resultDataSet.setTables(resultMap);

		return resultDataSet;
	}
	
	public ResultDataSet customAction(Action action) {
		Map<String, Object> r = null;
		
		switch(action.getActionID()){
		case "findAddr":	//주소검색
			try {
				r = new HashMap<String, Object>();
				r.put(action.getTableName(), AddressFinder.find(action.getParmsList().get(0)));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		case "upload_file":	//파일 업로드
			try {
				r = new HashMap<String, Object>();
				r.put(action.getTableName(), FileManager.uploadFile(action.getParmsList().get(0)));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		case "remove_file":	//파일 업로드
			try {
				r = new HashMap<String, Object>();
				boolean result = FileManager.removeFile(action.getParmsList().get(0).get("file_path").toString()
							, action.getParmsList().get(0).get("file_name").toString());
				if(result) r.put(action.getTableName() , getTableMap(1));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		default:
		}
		
		ResultDataSet resultDataSet = new ResultDataSet();
		//resultDataSet.setResultCode(resultCode);
		//resultDataSet.setResultMessage(resultMsg);
		//resultDataSet.setResultDescription(resultDesc);
		resultDataSet.setTables(r);
		
		return resultDataSet;
	}
	
	public Map<String, Object> getTableMap(Map<String, Object> rowMap){
		List<Map<String, Object>> rowList = new ArrayList<Map<String, Object>>();
		rowList.add(rowMap);

		Map<String, Object> colMap = new HashMap<String, Object>();
		for(String key : rowMap.keySet()){
			String colType = "";
			if(rowMap.get(key).getClass().getSimpleName().endsWith("String")){
				colType = "string";
			}
			else if(rowMap.get(key).getClass().getSimpleName().endsWith("Integer")){
				colType = "integer";
			}
			colMap.put(key, colType);
		}
		Map<String, Object> tableMap = new HashMap<String, Object>();
		tableMap.put("columns", colMap);
		tableMap.put("rows", rowList);
		return tableMap;
	}
	
	private Map<String, Object> getTableMap(int result){
		return getTableMap(result, null, 0);
	}

	private Map<String, Object> getTableMap(int result, String uidKey, long uid){
		Map<String, Object> columnMap = new HashMap<String, Object>();
		columnMap.put("AFFECTED_ROWS", "long");
		Map<String, Object> rowMap = new HashMap<String, Object>();
		rowMap.put("AFFECTED_ROWS", result);
		
		if(uidKey != null){
			columnMap.put(uidKey, "long");
			rowMap.put(uidKey, uid);
		}
		
		Map<String, Object> tableMap = new HashMap<String, Object>();
		tableMap.put("columns", columnMap);
		
		//blueerr rows 배열로 처리
		List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
		rows.add(rowMap);
		
		tableMap.put("rows", rows);
		return tableMap;
	}

	public Map<String, Object> getData(String sqlId, Map<String, Object> paramMap){
		return commonDao.selectOne(sqlId, paramMap);
	}
	
	public List<Map<String, Object>> getDataList(String sqlId, Map<String, Object> paramMap){
		return commonDao.selectList(sqlId, paramMap);
	}
	
	public int addData(String sqlId, Map<String, Object> paramMap){
		return commonDao.insert(sqlId, paramMap);
	}
	
	public int modifyData(String sqlId, Map<String, Object> paramMap){
		return commonDao.update(sqlId, paramMap);
	}

	public int removeData(String sqlId, Map<String, Object> paramMap){
		return commonDao.delete(sqlId, paramMap);
	}

}
