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
	
	/**
	 * 获取所有用户类型
	 * @return
	 */
	public List<UserType> getAll(){
		return dao.getAll();
	}
	
	/**
	 * 获取所有供应商用户类型
	 * @return
	 */
	public List<UserType> getProvider(){
		return dao.getProviders();
	}
	
	/**
	 * 根据id获取用户类型
	 * @param id
	 * @return
	 */
	public UserType geTypeById(int id){
		return dao.findOne(id);
	}
}
