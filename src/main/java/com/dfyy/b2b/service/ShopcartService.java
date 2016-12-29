package com.dfyy.b2b.service;

import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import net.sf.ehcache.search.aggregator.Count;

import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.CommodityGradualprice;
import com.dfyy.b2b.bussiness.CommodityProtective;
import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.Shopcart;
import com.dfyy.b2b.dao.CommodityDao;
import com.dfyy.b2b.dao.CommodityGradualpriceDao;
import com.dfyy.b2b.dao.CommodityProtectiveDao;
import com.dfyy.b2b.dao.OrdersDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.ShopcartDao;
import com.dfyy.b2b.dto.ShopcartResult;
import com.dfyy.b2b.dto.TotalOrders;

@Service
@Transactional
public class ShopcartService {

	@Autowired
	private ShopcartDao sDao;

	@Autowired
	private SUserDao sUserDao;

	@Autowired
	private CommodityDao commodityDao;

	@Autowired
	private CommodityGradualpriceDao gradualpriceDao;

	@Autowired
	private CommodityProtectiveDao protectiveDao;

	@Autowired
	private OrdersDao orderDao;

	/**
	 * 获取某个农资店用户的购物车列表
	 * 
	 * @param userid
	 * @return
	 */
	public ShopcartResult getList(String userid) {
		List<Shopcart> resultList = sDao.getList(userid);
		double totalPrice = 0;
		for (Shopcart shopcart : resultList) {
			Commodity c = shopcart.getCommodity();
			List<CommodityGradualprice> prices = gradualpriceDao.getByCommodityAndCount(c.getId(), shopcart.getCount());
			if (prices != null && prices.size() > 0) {
				shopcart.setPrice(prices.get(0).getPrice());
			} else {
				shopcart.setPrice(c.getPrice());
			}
			totalPrice += shopcart.getPrice() * shopcart.getCount();
		}

		ShopcartResult result = new ShopcartResult();
		result.setTotalPrice(totalPrice);
		result.setResults(resultList);
		return result;
	}

	/**
	 * 添加商品到购物车
	 * 
	 * @param userid
	 * @return
	 */
	public ShopcartResult addCommodity(String userid, int cid, int count) {
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

		return getList(userid);

	}

	/**
	 * 从购物车删除商品
	 * 
	 * @param userid
	 * @return
	 */
	public ShopcartResult deleteCommodity(String userid, int cid) {
		Shopcart shopcart = sDao.getSingle(userid, cid);
		if (shopcart != null) {
			sDao.delete(shopcart);
		}
		return getList(userid);
	}

	public TotalOrders submit(String userid) {
		TotalOrders to = new TotalOrders();

		List<Shopcart> resultList = sDao.getList(userid);
		double total = 0;
		for (Shopcart shopcart : resultList) {
			Commodity c = shopcart.getCommodity();
			List<CommodityGradualprice> prices = gradualpriceDao.getByCommodityAndCount(c.getId(), shopcart.getCount());
			if (prices != null && prices.size() > 0) {
				shopcart.setPrice(prices.get(0).getPrice());
			} else {
				shopcart.setPrice(c.getPrice());
			}

			DateTime dt = new DateTime();

			Orders order = new Orders();
			order.setNzd(sUserDao.findOne(userid));
			order.setTime(dt.toDate());
			order.setStatus(0);
			order.setCount(shopcart.getCount());
			order.setPrice(shopcart.getPrice());
			order.setCommodity(c);

			// 根据数量计算保护期时间和半径

			List<CommodityProtective> protectives = protectiveDao.getByCommodity(c.getId());
			if (protectives != null && protectives.size() > 0) {
				Collections.sort(protectives, new Comparator<CommodityProtective>() {

					@Override
					public int compare(CommodityProtective o1, CommodityProtective o2) {
						if (o1.getMinnumber() < o2.getMinnumber()) {
							return -1;
						} else if (o1.getMinnumber() == o2.getMinnumber()) {
							return 0;
						} else {
							return 1;
						}
					}
				});
				for (CommodityProtective p : protectives) {
					if (shopcart.getCount() >= p.getMinnumber()) {
						order.setTime(dt.plusDays(p.getDays().intValue()).toDate());
						order.setRadius(p.getRadius());
					}
				}
			}

			orderDao.save(order);

			total += shopcart.getPrice() * shopcart.getCount();
			to.add(order);
		}
		to.setTotalPrice(total);
		sDao.clear(userid);
		return to;
	}

}
