package com.dfyy.b2b.service;

import com.dfyy.b2b.bussiness.User;

public interface UserContext {
	public User getCurrentUser();

	public void setCurrentUser(User user);
}
