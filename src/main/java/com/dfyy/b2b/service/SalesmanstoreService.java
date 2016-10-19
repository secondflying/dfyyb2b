package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.SalesmanStore;
import com.dfyy.b2b.dao.SalesmanStoreDao;

@Service
@Transactional
public class SalesmanstoreService {

	@Autowired
	private SalesmanStoreDao dao;
	
	/**
	 * 存储业务员农资店记录
	 * @param salesmanStore
	 */
	public void saveSalesmanStore(SalesmanStore salesmanStore){
		dao.save(salesmanStore);
	}
	
	/**
	 * 删除
	 * @param id
	 */
	public void delete(int id){
		SalesmanStore salesmanStore = dao.findOne(id);
		if(salesmanStore!=null){
			salesmanStore.setStatus(-1);
			dao.save(salesmanStore);
		}
	}
	
	/**
	 * 获取业务员负责的农资店
	 * @param uid
	 * @return
	 */
	public List<SalesmanStore> getByUid(String uid){
		return dao.getByUid(uid);
	}
	
	/**
	 * 获取农资店的业务员
	 * @param sid
	 * @return
	 */
	public SalesmanStore getByStore(String sid){
		return dao.getBySid(sid);
	}
}
