package com.dfyy.b2b.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.CommodityOfNzd;
import com.dfyy.b2b.bussiness.OrderBrokerage;
import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.bussiness.OrdersInventory;
import com.dfyy.b2b.bussiness.PartnerDealer;
import com.dfyy.b2b.bussiness.PpBrokerage;
import com.dfyy.b2b.bussiness.SalesmanStore;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.dao.CommodityDao;
import com.dfyy.b2b.dao.CommodityGradualpriceDao;
import com.dfyy.b2b.dao.CommodityOfNzdDao;
import com.dfyy.b2b.dao.OrderBrokerageDao;
import com.dfyy.b2b.dao.OrdersDao;
import com.dfyy.b2b.dao.OrdersInventoryDao;
import com.dfyy.b2b.dao.PartnerDealerDao;
import com.dfyy.b2b.dao.PpBrokerageDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.SalesmanStoreDao;
import com.dfyy.b2b.dao.UserDao;
import com.dfyy.b2b.dto.CommodityOfNzdResult;
import com.dfyy.b2b.dto.OrdersResult;
import com.dfyy.b2b.util.PublicHelper;

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

	@Autowired
	private OrderBrokerageDao orderBrokerageDao;

	@Autowired
	private PpBrokerageDao ppBrokerageDao;

	@Autowired
	private SalesmanStoreDao salesmanStoreDao;

	@Autowired
	private OrdersInventoryDao inventoryDao;

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
	 * 获取某个农资店购买的所有订单列表
	 * 
	 * @param nzd
	 * @param page
	 * @param time
	 * @return
	 */
	public OrdersResult getBuyHistory(String nzd, int cid, int page, long time) {
		OrdersResult result = new OrdersResult();
		if (page == 0) {
			List<Orders> list = orderDao.getNzdBuyCommodity(nzd, cid, new PageRequest(page, 20));

			result.setResults(list);
			result.setLastTime(new Date().getTime());
		} else {
			List<Orders> list = orderDao.getNzdBuyCommodity(nzd, cid, new Date(time), new PageRequest(page, 20));
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
	 * 确定发货
	 * 
	 * @param oid
	 * @return
	 */
	public boolean confirmSend(int oid) {
		Orders order = orderDao.findOne(oid);
		order.setStatus(1);
		orderDao.save(order);
		return true;
	}

	/**
	 * 确定订单送达
	 * 
	 * @param oid
	 * @return
	 */
	public boolean confirmArrival(int oid) {
		Orders order = orderDao.findOne(oid);
		order.setStatus(2);
		orderDao.save(order);
		return true;
	}

	/**
	 * 拒绝订单退货
	 * 
	 * @param oid
	 * @return
	 */
	public boolean backStop(int oid) {
		Orders order = orderDao.findOne(oid);
		order.setStatus(2);
		orderDao.save(order);
		return true;
	}

	/**
	 * 同意订单退货
	 * 
	 * @param oid
	 * @return
	 */
	public boolean backPass(int oid) {
		Orders order = orderDao.findOne(oid);
		order.setStatus(11);
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

		// 确认收货，增加库存
		OrdersInventory inventory = inventoryDao.getCommodityInventory(nzd, order.getCommodity().getId());
		if (inventory == null) {
			inventory = new OrdersInventory();
			inventory.setNzd(nzd);
			inventory.setCid(order.getCommodity().getId());
			inventory.setCount(order.getCount());
			inventory.setTime(new Date());
		} else {
			inventory.setCount(inventory.getCount() + order.getCount());
			inventory.setTime(new Date());
		}
		inventoryDao.save(inventory);

		OrderBrokerage orderbro = new OrderBrokerage();
		orderbro.setOid(order.getId());
		PpBrokerage ppBrokerage = ppBrokerageDao.getByCid(order.getCommodity().getType().getId());
		PartnerDealer partnerDealer = dealerDao.getByDid(order.getCommodity().getProvider().getId());
		if (partnerDealer != null) {
			orderbro.setBpartner(PublicHelper.correctTo(order.getPrice() * order.getCount() * ppBrokerage.getPartner()));
			orderbro.setPid(partnerDealer.getPid());
		}
		SalesmanStore salesmanStore = salesmanStoreDao.getBySid(nzd);
		if (salesmanStore != null) {
			orderbro.setBsalesman(PublicHelper.correctTo(order.getPrice() * order.getCount()
					* order.getCommodity().getBrokerage()));
			orderbro.setSid(salesmanStore.getUid());
		}
		orderbro.setBplatform(PublicHelper.correctTo(order.getPrice() * order.getCount() * ppBrokerage.getPlatform()));
		orderbro.setStatus(0);
		orderbro.setTime(order.getTime());

		orderBrokerageDao.save(orderbro);

		return true;
	}

	/**
	 * 获取订单佣金
	 * 
	 * @param oid
	 * @return
	 */
	public OrderBrokerage getBrokerageByOid(int oid) {
		return orderBrokerageDao.getByOid(oid);
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
