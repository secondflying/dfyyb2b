package com.dfyy.b2b.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.CommodityOfNzd;
import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.bussiness.PartnerDealer;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.dao.CommodityDao;
import com.dfyy.b2b.dao.CommodityGradualpriceDao;
import com.dfyy.b2b.dao.CommodityOfNzdDao;
import com.dfyy.b2b.dao.OrdersDao;
import com.dfyy.b2b.dao.PartnerDealerDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.UserDao;
import com.dfyy.b2b.dto.CommodityOfNzdResult;
import com.dfyy.b2b.dto.OrdersResult;

@Service
@Transactional
public class OrdersService {

	@Autowired
	private SUserDao sUserDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private CommodityDao commodityDao;

	@Autowired
	private CommodityGradualpriceDao gradualpriceDao;

	@Autowired
	private OrdersDao orderDao;

	@Autowired
	private CommodityOfNzdDao commodityOfNzdDao;

	@Autowired
	private PartnerDealerDao dealerDao;

	/**
	 * 获取某个农资店购买的所有订单列表
	 * 
	 * @param nzd
	 * @param page
	 * @param time
	 * @return
	 */
	public OrdersResult getMyOrders(String nzd, int page, long time) {
		OrdersResult result = new OrdersResult();
		if (page == 0) {
			List<Orders> list = orderDao.getByNzd(nzd, new PageRequest(page, 20));

			result.setResults(list);
			result.setLastTime(new Date().getTime());
		} else {
			List<Orders> list = orderDao.getByNzd(nzd, new Date(time), new PageRequest(page, 20));
			result.setResults(list);
			result.setLastTime(time);
		}
		return result;
	}

	/**
	 * 获取农资店购买的商品列表
	 * 
	 * @param nzd
	 * @param page
	 * @param time
	 * @return
	 */
	public CommodityOfNzdResult getMyBuyedCommodity(String nzd, int page, long time) {
		CommodityOfNzdResult result = new CommodityOfNzdResult();
		if (page == 0) {
			List<CommodityOfNzd> list = commodityOfNzdDao.getNzdBuyed(nzd, new PageRequest(page, 20));

			result.setResults(list);
			result.setLastTime(new Date().getTime());
		} else {
			List<CommodityOfNzd> list = commodityOfNzdDao.getNzdBuyed(nzd, new Date(time), new PageRequest(page, 20));
			result.setResults(list);
			result.setLastTime(time);
		}
		return result;
	}

	/**
	 * 获取订单详情
	 * 
	 * @param orderid
	 * @return
	 */
	public Orders getSingle(int orderid) {
		Orders order = orderDao.findOne(orderid);
		return order;
	}

	/**
	 * 取消订单
	 * 
	 * @param oid
	 * @param nzd
	 * @return
	 */
	public boolean cancel(int oid, String nzd) {
		Orders order = orderDao.findOne(oid);
		checkOrderValid(nzd, order);

		if (order.getStatus() != 0) {
			throw new RuntimeException("只能取消未发货订单");
		}

		order.setStatus(10);
		orderDao.save(order);
		return true;
	}

	/**
	 * 确定收货
	 * 
	 * @param oid
	 * @param nzd
	 * @return
	 */
	public boolean confirm(int oid, String nzd) {
		Orders order = orderDao.findOne(oid);
		checkOrderValid(nzd, order);

		if (order.getStatus() != 2) {
			throw new RuntimeException("订单未送达，不能确定收货");
		}

		order.setStatus(3);
		orderDao.save(order);
		return true;
	}

	/**
	 * 订单退货申请
	 * 
	 * @param oid
	 * @param nzd
	 * @return
	 */
	public boolean back(int oid, String nzd) {
		Orders order = orderDao.findOne(oid);
		checkOrderValid(nzd, order);

		if (order.getStatus() != 2) {
			throw new RuntimeException("订单未送达，不能退货");
		}

		order.setStatus(4);
		orderDao.save(order);
		return true;
	}

	private void checkOrderValid(String nzd, Orders order) {
		if (order == null) {
			throw new RuntimeException("订单不存在");
		}

		if (!order.getNzd().getId().equals(nzd)) {
			throw new RuntimeException("只能由订购用户操作");
		}
	}

	/**
	 * 获取供应商的订单列表
	 * 
	 * @param userid
	 * @param page
	 * @param size
	 * @return
	 */
	public List<Orders> getOrdersOfProvider(String userid, int page, int size) {

		User provider = userDao.findOne(userid);
		// 如果是合伙人，获取该合伙人下经销商的所有列表
		List<String> users = new ArrayList<>();
		users.add(provider.getId());
		if (provider.getType().getId() == 2) {
			List<PartnerDealer> dealers = dealerDao.getByPid(provider.getId());
			for (PartnerDealer partnerDealer : dealers) {
				users.add(partnerDealer.getDealer().getId());
			}
		}
		List<Orders> list = orderDao.getByProvider(users.toArray(new String[0]), new PageRequest(page, size));
		return list;
	}

	/**
	 * 获取供应商订单个数
	 * 
	 * @param userid
	 * @return
	 */
	public int getCountOrdersOfProvider(String userid) {
		User provider = userDao.findOne(userid);
		// 如果是合伙人，获取该合伙人下经销商的所有列表
		List<String> users = new ArrayList<>();
		users.add(provider.getId());
		if (provider.getType().getId() == 2) {
			List<PartnerDealer> dealers = dealerDao.getByPid(provider.getId());
			for (PartnerDealer partnerDealer : dealers) {
				users.add(partnerDealer.getDealer().getId());
			}
		}
		int count = orderDao.getCountByProvider(users.toArray(new String[0]));
		return count;
	}
}
