package com.seoulauction.common.mybatis;

import org.apache.ibatis.type.JdbcType;

import java.io.Reader;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LongTypeHandler implements org.apache.ibatis.type.TypeHandler {

	//@Override
	public Object getResult(ResultSet rs, String columnName) throws SQLException {
		String result = "";
		try{
			Reader sr = rs.getCharacterStream(columnName);
			if( sr != null ){
				StringBuffer buf = new StringBuffer();
				char[]ch = new char[521];
				int len = -1;

				while( (len = sr.read(ch)) != -1 ) {
					buf.append(ch, 0, len);
				}
				// 저장한 버퍼를 String 로 변환
				result = buf.toString();
			}
		}
		catch(Exception ex){
		}
		return result;
	}

	//@Override
	public Object getResult(CallableStatement cs, int columnIndex)
			throws SQLException {

		// TODO Auto-generated method stub
		return cs.getString(columnIndex);
	}

	//@Override
	public void setParameter(PreparedStatement ps, int i, Object parameter,	JdbcType jdbcType) throws SQLException {
		ps.setString(i, (String) parameter);
	}
	/*public void setParameter(PreparedStatement ps, int i, Object parameter,
			JdbcType jdbcType) throws SQLException {
		StringReader sr = new StringReader((String)parameter);
		ps.setCharacterStream(1, sr, parameter.toString().length());
	}



	public Object getResult(CallableStatement cs, int columnIndex)
			throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
*/

	//@Override
	public Object getResult(ResultSet rs, int columnIndex) throws SQLException
	{
		String result = "";
		try{
			Reader sr = rs.getCharacterStream(columnIndex);
			if( sr != null ){
				StringBuffer buf = new StringBuffer();
				char[]ch = new char[521];
				int len = -1;

				while( (len = sr.read(ch)) != -1 ) {
					buf.append(ch, 0, len);
				}
				// 저장한 버퍼를 String 로 변환
				result = buf.toString();
			}
		}
		catch(Exception ex){
		}
		return result;

	}
}
