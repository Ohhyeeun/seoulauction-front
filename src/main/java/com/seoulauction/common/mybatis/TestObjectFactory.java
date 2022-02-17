package com.seoulauction.common.mybatis;

import org.apache.ibatis.reflection.factory.DefaultObjectFactory;

import java.util.Properties;

public class TestObjectFactory extends DefaultObjectFactory {
	public void setProperties(Properties properties) {
		super.setProperties(properties);
	}
}
