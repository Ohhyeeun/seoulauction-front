package com.seoulauction.ws.dto;

import java.util.List;
import java.util.Map;

public class Action {
	public enum ACTION_TYPE{
		select, insert,	update,	delete;
	}
	
	private String actionID;
	private ACTION_TYPE actionType; 
	private List<Map<String, Object>> parmsList;
	private String tableName;
	
	//blueerr auto_increment 값 처리
	private String uidKey;
	
	public String getActionID() {
		return actionID;
	}
	public void setActionID(String actionID) {
		this.actionID = actionID;
	}
	public String getActionType() {
		return actionType.name();
	}
	public void setActionType(String actionType) {
		this.actionType = ACTION_TYPE.valueOf(actionType);
	}
	public List<Map<String, Object>> getParmsList() {
		return parmsList;
	}
	public void setParmsList(List<Map<String, Object>> parmsList) {
		this.parmsList = parmsList;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getUidKey() {
		return uidKey;
	}
	public void setUidKey(String uidKey) {
		this.uidKey = uidKey;
	}   	
}
