package com.cn.test.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.test.dao.UserMapper;
import com.cn.test.pojo.User;
import com.cn.test.service.IUserService;
import com.google.code.ssm.api.ParameterDataUpdateContent;
import com.google.code.ssm.api.ParameterValueKeyProvider;
import com.google.code.ssm.api.ReadThroughSingleCache;
import com.google.code.ssm.api.UpdateSingleCache;

@Service("userService")
public class UserServiceImpl implements IUserService {

	@Resource
	private UserMapper userDao;

	@Override
	@ReadThroughSingleCache(namespace = "ItemObj", expiration = 3600)
	public User getUserById(@ParameterValueKeyProvider String userId) {
		// TODO Auto-generated method stub
		return this.userDao.selectByPrimaryKey(Integer.parseInt(userId));
	}

	@Override
	@UpdateSingleCache(namespace = "ItemObj")
	public void updateUser(@ParameterValueKeyProvider @ParameterDataUpdateContent User user) {
		// TODO Auto-generated method stub
		this.userDao.updateByPrimaryKey(user);
	}

}
