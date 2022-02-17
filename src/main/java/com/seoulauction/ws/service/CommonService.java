package com.seoulauction.ws.service;


import com.seoulauction.common.exception.DataSetException;
import com.seoulauction.ws.dto.Action;
import com.seoulauction.ws.dto.ActionSet;
import com.seoulauction.ws.dto.ResultDataSet;

import java.util.List;
import java.util.Map;


//@Path("/commonService/")
//@WebService(serviceName = "WSCommon", name = "CommonService", targetNamespace = "")
//웹서비스 정의 시 List<Map<String, Object>> 와 같은 타입 정의 안
// http://localhost:8080/seoulauction/ws/commonService/encryptPasswd?arg0=xxx
//http://localhost:8080/seoulauction/ws/rest/commonService/getMemberList.json

public interface CommonService {
	
	ResultDataSet actionSet(ActionSet actionSet) throws DataSetException;
	ResultDataSet customAction(Action action);

	Map<String, Object> getData(String sqlId, Map<String, Object> paramMap);
	
	List<Map<String, Object>> getDataList(String sqlId, Map<String, Object> paramMap);
	
	int addData(String sqlId, Map<String, Object> paramMap);
	
	int modifyData(String sqlId, Map<String, Object> paramMap);

	int removeData(String sqlId, Map<String, Object> paramMap);

	Map<String, Object> getTableMap(Map<String, Object> rowMap);
}
