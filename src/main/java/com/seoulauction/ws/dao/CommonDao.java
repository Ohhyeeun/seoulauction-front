package com.seoulauction.ws.dao;

import java.util.List;
import java.util.Map;

public interface CommonDao {

	public abstract int insert(String query, Map<String, Object> param);

	public abstract int update(String query, Map<String, Object> param);

	public abstract int delete(String query, Map<String, Object> param);

	public abstract List<Map<String, Object>> selectList(String query,
                                                         Map<String, Object> param);

	public abstract Map<String, Object> selectOne(String query,
                                                  Map<String, Object> param);

	public abstract Map<String, Object> selectForResultDataSet(String query,
                                                               Map<String, Object> param);

}