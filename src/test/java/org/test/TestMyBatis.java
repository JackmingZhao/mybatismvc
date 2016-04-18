package org.test;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;

import com.alibaba.fastjson.JSON;
import com.cn.test.pojo.User;
import com.cn.test.service.IUserService;

@RunWith(JUnit4ClassRunner.class)
// 表示继承了SpringJUnit4ClassRunner类
@ContextConfiguration(locations={"classpath:spring-mybatis.xml"})
public class TestMyBatis {
	private static Logger logger = Logger.getLogger(TestMyBatis.class);
	@Resource
	private IUserService userService = null;

	@Test
	public void test1() {
		User user = userService.getUserById("1");
		// System.out.println(user.getUserName());
		// logger.info("值："+user.getUserName());
		logger.info(JSON.toJSONString(user));
	}
}