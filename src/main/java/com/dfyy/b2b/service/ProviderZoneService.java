package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.ProviderZone;
import com.dfyy.b2b.dao.ProviderZoneDao;

@Service
@Transactional
public class ProviderZoneService {

	@Autowired
	private ProviderZoneDao dao;
	
	/**
	 * 新增
	 * @param pZone
	 */
	public void save(ProviderZone pZone){
		dao.save(pZone);
	}
	
	/**
	 * 删除
	 * @param id
	 */
	public void deleteProviderZone(int id){
		ProviderZone providerZone = dao.findOne(id);
		if(providerZone!=null){
			providerZone.setStatus(-1);
			dao.save(providerZone);
		}
	}
	
	/**
	 * 获取某合伙人或厂家的所有销售区域
	 * @param uid
	 * @return
	 */
	public List<ProviderZone> getByUid(String uid){
		return dao.getByUid(uid);
	}
	
	/**
	 * 根据用户和区域获取记录
	 * @param uid
	 * @param aid
	 * @return
	 */
	public ProviderZone getByUidAndAid(String uid,int aid){
		return dao.getByUidAndAid(uid, aid);
	}
}
