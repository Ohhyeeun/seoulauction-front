package com.seoulauction.ws.dto;

import java.util.Map;

//import org.codehaus.jackson.annotate.JsonProperty;
//import org.codehaus.jackson.annotate.JsonPropertyOrder;

public class ResultDataSet {
	private int resultCode = 0;
	private String resultMessage = null;
	private String resultDescription = null;
	
	private Map<String, Object> tables;
	
	//@JsonProperty("ResultCode")
	public int getResultCode() {
		return resultCode;
	}
	public void setResultCode(int resultCode) {
		this.resultCode = resultCode;
	}
	
	//@JsonProperty("ResultMessage")
	public String getResultMessage() {
		return resultMessage;
	}
	public void setResultMessage(String resultMessage) {
		this.resultMessage = resultMessage;
	}
	
	//@JsonProperty("ResultDescription")
	public String getResultDescription() {
		return resultDescription;
	}
	public void setResultDescription(String resultDescription) {
		this.resultDescription = resultDescription;
	}
	
	//@JsonProperty("tables")
	public Map<String, Object> getTables() {
		return tables;
	}
	public void setTables(Map<String, Object> tables) {
		this.tables = tables;
	}
	
}
