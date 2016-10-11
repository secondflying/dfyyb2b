package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.UserType;
import com.dfyy.b2b.dao.UserTypeDao;

@Service
@Transactional
public class UserTypeService {

	@Autowired
	private UserTypeDao dao;
	
	public List<UserType> getAll(){
		return dao.getAll();
	}
	
	public List<UserType> getProvider(){
		return dao.getProviders();
	}
}
