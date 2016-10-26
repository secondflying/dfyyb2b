package com.dfyy.b2b.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.dao.UserTokenDao;

@Service
@Transactional
public class TokenService {

	@Autowired
	private UserTokenDao tokenDao;

	public boolean isvalid(String userid, String token) {
		return tokenDao.findByUserIDAndToken(userid, token) != null;
	}
}
