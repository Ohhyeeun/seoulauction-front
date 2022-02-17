package com.seoulauction.ws.dao.impl;

import com.seoulauction.ws.dao.CommonDao;
import org.codehaus.jackson.map.ObjectMapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public class CommonDaoImpl implements CommonDao
{
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired 
	//@Resource(name="sqlSession")
	private SqlSessionTemplate sqlSession; 
		
	/* (non-Javadoc)
	 * @see com.seoulauction.ws.dao.CommonDao#insert(java.lang.String, java.util.Map)
	 */
	@Override
	public int insert(String query, Map<String,Object> param)
	{
		return sqlSession.insert(query, param);
	}

	/* (non-Javadoc)
	 * @see com.seoulauction.ws.dao.CommonDao#update(java.lang.String, java.util.Map)
	 */
	@Override
	public int update(String query, Map<String,Object> param)
	{
		return sqlSession.update(query, param);
	}

	/* (non-Javadoc)
	 * @see com.seoulauction.ws.dao.CommonDao#delete(java.lang.String, java.util.Map)
	 */
	@Override
	public int delete(String query, Map<String,Object> param)
	{
		return sqlSession.update(query, param);
	}
	
	private Map<String,Object> copyMap(Map<?,?> map){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Iterator<?> keys = map.keySet().iterator();
		while(keys.hasNext()){
			Object key = keys.next();
			resultMap.put(key.toString(), map.get(key));
		}
		return resultMap;
	}
	
	/* (non-Javadoc)
	 * @see com.seoulauction.ws.dao.CommonDao#selectList(java.lang.String, java.util.Map)
	 */
	@Override
	public List<Map<String,Object>> selectList(String query, Map<String,Object> param)
	{
		List<Map<String,Object>> list = sqlSession.selectList(query, param);
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		if(!list.isEmpty()) {
			if(list.get(0).get("rows") instanceof ArrayList<?>){
				ArrayList<?> al = (ArrayList<?>)list.get(0).get("rows");
				for(Object obj : al){
					resultList.add(copyMap((Map<?,?>)obj));
				}
			}
		}
		return resultList;
	}

	/* (non-Javadoc)
	 * @see com.seoulauction.ws.dao.CommonDao#selectOne(java.lang.String, java.util.Map)
	 */
	@Override
	public Map<String,Object> selectOne(String query, Map<String,Object> param)
	{
		Map<String,Object> map = sqlSession.selectOne(query, param);
		Map<String,Object> resultMap = null;
		if (map != null && !map.isEmpty())
		{
			if(map.get("rows") instanceof ArrayList<?>){
				ArrayList<?> al = (ArrayList<?>)map.get("rows");
				if(!al.isEmpty()){
					resultMap = copyMap((Map<?,?>)al.get(0));
				}
			}
		}
		return resultMap;
	}

	/* (non-Javadoc)
	 * @see com.seoulauction.ws.dao.CommonDao#selectForResultDataSet(java.lang.String, java.util.Map)
	 */
	@Override
	public Map<String,Object> selectForResultDataSet(String query, Map<String,Object> param)
	{
		Map<String,Object> map = sqlSession.selectOne(query, param);
		try{
			List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();	
			if (map != null && !map.isEmpty())
			{
				if(map.get("rows") instanceof ArrayList<?>){
					ArrayList<?> al = (ArrayList<?>)map.get("rows");
					for(Object obj : al){
						resultList.add(convJson((Map<?,?>)obj));
					}
					map.put("rows", resultList);
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}

		return map;
	}
	
	private Map<String,Object> convJson(Map<?,?> map){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		for( Object key : map.keySet() ){
			if(key.toString().endsWith("_JSON")){
				try{
					ObjectMapper mapper = new ObjectMapper();
					//mapper.configure(JsonParser.Feature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER, true);
					//.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "")
					String json  = null;
					if(map.get(key) instanceof byte[]){
						json = new String((byte[])map.get(key));
					}
					else if(map.get(key) instanceof String){
						json = map.get(key).toString();
					}

					Object jsonObj = null;
					if(json != null){
						json = json.replaceAll("\r", "").replaceAll("\n", "<br/>");
						jsonObj = mapper.readValue(json, Object.class);
					}
					resultMap.put(key.toString(), jsonObj);
				}
				catch(Exception ex){
					logger.debug("=============> json error {} // {}", key.toString(), map.get(key).toString());
					resultMap.put(key.toString(), "error");
					ex.printStackTrace();
				}
			}
			else{
				resultMap.put(key.toString(), map.get(key));
			}
		}
		return resultMap;
	}
}