package com.cn.test.service;

import com.cn.test.pojo.User;

public interface IUserService {

	public User getUserById(String userId);
	
	public void updateUser(User user);

}
