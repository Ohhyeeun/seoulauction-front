package com.seoulauction.ws.dto;

import java.util.List;
import java.util.Map;

public class ActionSet {
    private Map<String, Object> baseParms;
    private List<Action> actionList = null;
    
	public Map<String, Object> getBaseParms() {
		return baseParms;
	}
	public void setBaseParms(Map<String, Object> baseParms) {
		this.baseParms = baseParms;
	}
	public List<Action> getActionList() {
		return actionList;
	}
	public void setActionList(List<Action> actionList) {
		this.actionList = actionList;
	}
  }
