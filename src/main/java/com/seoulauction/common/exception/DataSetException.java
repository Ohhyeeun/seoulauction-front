package com.seoulauction.common.exception;

public class DataSetException extends Exception {
	
	/**
	 * 
	 */
	public enum EXCEPTION_CODE{
		ACTION_SET {
			@Override
			public String getMessge() {
				return "Action Set 정의 없음.";
			}
			@Override
			public int getValue() {
				return -1;
			}
		},
		ACTION_ID{
			@Override
			public String getMessge() {
				return "Action ID 정의 없음.";
			}
			@Override
			public int getValue() {
				return -2;
			}
		},
		ACTION_TYPE{
			@Override
			public String getMessge() {
				return "Action Type 정의 없음.";
			}
			@Override
			public int getValue() {
				return -3;
			}
		},
		SQL{
			@Override
			public String getMessge() {
				return "SQL Exception";
			}
			@Override
			public int getValue() {
				return -4;
			}
		},
		RESULT{
			@Override
			public String getMessge() {
				return "Result 데이터 error.";
			}
			@Override
			public int getValue() {
				return -5;
			}
		},
		AUTH{
			@Override
			public String getMessge() {
				return "Result 데이터 error.";
			}
			@Override
			public int getValue() {
				return -99;
			}
		};
		
		public abstract String getMessge();
		public abstract int getValue();
	}
	
	private static final long serialVersionUID = 1L;
	
	private EXCEPTION_CODE exCode;
	private String exMessage;
	
	public DataSetException(EXCEPTION_CODE exCode) {
		this.exCode = exCode;
	}
	
	public DataSetException(EXCEPTION_CODE exCode, String exMessage) {
		this.exCode = exCode;
		this.exMessage = exMessage;
	}

	public EXCEPTION_CODE getExceptionCode(){
		return exCode;
	}

	@Override
	public String getMessage() {
		return this.exCode.getMessge() + (this.exMessage.isEmpty() ? "" : "\n\n" + this.exMessage);
	}
}
