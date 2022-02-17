package com.seoulauction.common.mybatis;

import org.apache.ibatis.executor.resultset.ResultSetHandler;
import org.apache.ibatis.plugin.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.Types;
import java.util.*;

@Intercepts({@Signature(type = ResultSetHandler.class, method = "handleResultSets", args = {Statement.class})})
public class AddMetaDataPlugin implements Interceptor {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public static final Map<Integer, String> ColumnTypeMap = new HashMap<Integer, String>(){{
        put(Types.VARCHAR, "string");
        put(Types.CHAR, "string");
        put(Types.LONGVARCHAR, "string");
        put(Types.TINYINT, "long");
        put(Types.INTEGER, "long");
        put(Types.SMALLINT, "long");
        put(Types.BIGINT, "long");
        put(Types.DOUBLE, "double");
        put(Types.DECIMAL, "double");
        put(Types.FLOAT, "double");
        put(Types.NUMERIC, "double");
        put(Types.REAL, "double");
        put(Types.DATE, "datetime");
        put(Types.TIME, "datetime");
        put(Types.TIMESTAMP, "datetime");
        put(Types.CLOB, "string");
        put(Types.BLOB, "byte[]");
    }};
    
	//@Override
	public Object intercept(Invocation invocation) throws Throwable {
        Object[] args = invocation.getArgs();
		Map<String, Object> tableMap = new HashMap<String, Object>();

		Statement statement = (Statement) args[0];

        ResultSet rs = statement.getResultSet();
        while (rs == null) {
            if (statement.getMoreResults()) {
                rs = statement.getResultSet();
            } else {
                if (statement.getUpdateCount() == -1) {
                    break;
                }
            }
        }
        
        if (rs != null) {
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            Map<String, String> columnMap = new LinkedHashMap<String, String>();
            for (int i = 1; i <= columnCount; i++) {
                String columnName = rsmd.getColumnName(i);
                String columnLabel = rsmd.getColumnLabel(i);
                int columnType = rsmd.getColumnType(i);
                if(columnLabel != "" && !columnName.equals(columnLabel)){
                	columnMap.put(columnLabel, ColumnTypeMap.get(columnType));
                }
                else{
                	columnMap.put(columnName, ColumnTypeMap.get(columnType));
                }
            }
            tableMap.put("columns", columnMap);
        }
        
		Object proceed = invocation.proceed();
		tableMap.put("rows", proceed);
		List<Object> resultList = new ArrayList<Object>();
		resultList.add(tableMap);

		return resultList;
	}

	//@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	//@Override
	public void setProperties(Properties prop) {
		

	}

}
