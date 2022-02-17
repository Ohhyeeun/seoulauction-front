package com.seoulauction.common.mybatis;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@MappedTypes(value = String.class)
@MappedJdbcTypes(JdbcType.VARCHAR)
public class VarcharTypeHandler extends org.apache.ibatis.type.BaseTypeHandler<String> {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, String param, JdbcType jdbcType) throws SQLException {
		ps.setString(i, param);
	}

	@Override
	public String getNullableResult(ResultSet rs, String columnName)
			throws SQLException {
		return rs.getString(columnName);
	}

	@Override
	public String getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		return rs.getString(columnIndex);
	}

	@Override
	public String getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		return cs.getString(columnIndex);
	}

}
