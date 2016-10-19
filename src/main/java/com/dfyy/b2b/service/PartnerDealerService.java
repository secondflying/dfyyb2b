package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.PartnerDealer;
import com.dfyy.b2b.dao.PartnerDealerDao;

@Service
@Transactional
public class PartnerDealerService {

	@Autowired
	private PartnerDealerDao dao;
	
	/**
	 * 存储经销商合伙人关系
	 * @param partnerdealer
	 */
	public void savePartnerDealer(PartnerDealer partnerdealer){
		dao.save(partnerdealer);
	}
	
	/**
	 * 删除
	 * @param id
	 */
	public void delete(int id){
		PartnerDealer partnerDealer = dao.findOne(id);
		if(partnerDealer!=null){
			partnerDealer.setStatus(-1);
			dao.save(partnerDealer);
		}
	}
	
	/**
	 * 获取合伙人下属的经销商
	 * @param pid
	 * @return
	 */
	public List<PartnerDealer> getByPid(String pid){
		return dao.getByPid(pid);
	}
	
	/**
	 * 获取经销商的合伙人信息
	 * @param did
	 * @return
	 */
	public PartnerDealer getByDid(String did){
		return dao.getByDid(did);
	}
}
