package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.SalesmanZone;
import com.dfyy.b2b.dao.SalesmanZoneDao;

@Service
@Transactional
public class SalesmanZoneService {

	@Autowired
	private SalesmanZoneDao dao;
	
	/**
	 * 新增
	 * @param sZone
	 */
	public void addSalesmanZone(SalesmanZone sZone){
		dao.save(sZone);
	}
	
	/**
	 * 删除
	 * @param id
	 */
	public void deleteSalesmanZone(int id){
		SalesmanZone salesmanZone = dao.findOne(id);
		if(salesmanZone!=null){
			salesmanZone.setStatus(-1);
			dao.save(salesmanZone);
		}
	}
	
	/**
	 * 获取某业务员的所有区域
	 * @param uid
	 * @return
	 */
	public List<SalesmanZone> getByUid(String uid){
		return dao.getByUid(uid);
	}
	
	/**
	 * 获取某区域的所有业务员
	 * @param aid
	 * @return
	 */
	public List<SalesmanZone> getByAid(int aid){
		return dao.getByAid(aid);
	}
	
	/**
	 * 根据用户和区域获取记录
	 * @param uid
	 * @param aid
	 * @return
	 */
	public SalesmanZone getByUidAndAid(String uid,int aid){
		return dao.getByUidAndAid(uid, aid);
	}
}
