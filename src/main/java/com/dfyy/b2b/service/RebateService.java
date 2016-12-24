package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.OrderRebate;
import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.dao.OrderRebateDao;

@Service
@Transactional
public class RebateService {
	
	@Autowired
	private OrderRebateDao rebateDao;
	
	/**
	 * 获取某供应商的所有返利
	 * @param uid
	 * @param page
	 * @param size
	 * @return
	 */
	public List<OrderRebate> getByProvider(String uid,int page, int size){
		return rebateDao.getByProvider(uid, new PageRequest(page, size));
	}
	
	/**
	 * 获取某供应商所有返利记录个数
	 * @param uid
	 * @return
	 */
	public int getCountByProvider(String uid){
		return rebateDao.getCountByProvider(uid);
	}
	
	/**
	 * 获取某商品的所有返利
	 * @param cid
	 * @param page
	 * @param size
	 * @return
	 */
	public List<OrderRebate> getByCommodity(int cid,int page,int size){
		return rebateDao.getByCommodity(cid, new PageRequest(page, size));
	}
	
	/**
	 * 获取某商品返利记录个数
	 * @param cid
	 * @return
	 */
	public int getCountByCommodity(int cid){
		return rebateDao.getCountByCommodity(cid);
	}
	
	/**
	 * 获取某农资店的所有返利
	 * @param nid
	 * @param page
	 * @param size
	 * @return
	 */
	public List<OrderRebate> getByNzd(String nid,int page,int size){
		return rebateDao.getByNzd(nid, new PageRequest(page, size));
	}
	
	/**
	 * 获取某农资店所有返利记录个数
	 * @param nid
	 * @return
	 */
	public int getCountByNzd(String nid){
		return rebateDao.getCountByNzd(nid);
	}

	/**
	 * 结算一个返利记录
	 * 
	 * @param id
	 * @return
	 */
	public boolean finalrebate(int id) {
		OrderRebate rebate  = rebateDao.findOne(id);
		rebate.setRstatus(1);
		rebateDao.save(rebate);
		return true;
	} 
}
