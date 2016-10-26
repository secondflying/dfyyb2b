package com.dfyy.b2b.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.Shopcart;
import com.dfyy.b2b.dao.CommodityDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.ShopcartDao;

@Service
@Transactional
public class ShopcartService {

	@Autowired
	private ShopcartDao sDao;

	@Autowired
	private SUserDao sUserDao;

	@Autowired
	private CommodityDao commodityDao;

	/**
	 * 获取某个农资店用户的购物车列表
	 * 
	 * @param userid
	 * @return
	 */
	public List<Shopcart> getList(String userid) {
		return sDao.getList(userid);
	}

	/**
	 * 添加商品到购物车
	 * 
	 * @param userid
	 * @return
	 */
	public List<Shopcart> addCommodity(String userid, int cid, int count) {
		SUser user = sUserDao.findOne(userid);
		Commodity commodity = commodityDao.findOne(cid);

		Shopcart shopcart = sDao.getSingle(userid, cid);
		if (shopcart == null) {
			shopcart = new Shopcart();
		}

		shopcart.setCommodity(commodity);
		shopcart.setNzd(user);
		shopcart.setCount(shopcart.getCount() + count);
		shopcart.setTime(new Date());

		sDao.save(shopcart);

		return sDao.getList(userid);

	}

	/**
	 * 从购物车删除商品
	 * 
	 * @param userid
	 * @return
	 */
	public List<Shopcart> deleteCommodity(String userid, int cid) {
		Shopcart shopcart = sDao.getSingle(userid, cid);
		if (shopcart != null) {
			sDao.delete(shopcart);
		}
		return sDao.getList(userid);

	}

}
