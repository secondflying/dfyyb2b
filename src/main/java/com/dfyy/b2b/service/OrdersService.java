package com.dfyy.b2b.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.CommodityGradualrebate;
import com.dfyy.b2b.bussiness.CommodityOfNzd;
import com.dfyy.b2b.bussiness.OrderBrokerage;
import com.dfyy.b2b.bussiness.OrderRebate;
import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.bussiness.OrdersInventory;
import com.dfyy.b2b.bussiness.PartnerDealer;
import com.dfyy.b2b.bussiness.PpBrokerage;
import com.dfyy.b2b.bussiness.SalesmanStore;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.dao.CommodityDao;
import com.dfyy.b2b.dao.CommodityGradualpriceDao;
import com.dfyy.b2b.dao.CommodityGradualrebateDao;
import com.dfyy.b2b.dao.CommodityOfNzdDao;
import com.dfyy.b2b.dao.OrderBrokerageDao;
import com.dfyy.b2b.dao.OrderRebateDao;
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
	private CommodityGradualrebateDao commodityGradualrebateDao;

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

	@Autowired
	private OrderRebateDao rebateDao;

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
		double parter = ppBrokerage == null ? 0 : ppBrokerage.getPartner();

		PartnerDealer partnerDealer = dealerDao.getByDid(order.getCommodity().getProvider().getId());
		if (partnerDealer != null) {
			orderbro.setBpartner(PublicHelper.correctTo(order.getPrice() * order.getCount() * parter));
			orderbro.setPid(partnerDealer.getPid());
		}

		double platform = ppBrokerage == null ? 0 : ppBrokerage.getPlatform();
		orderbro.setBplatform(PublicHelper.correctTo(order.getPrice() * order.getCount() * platform));
		orderbro.setStatus(0);
		orderbro.setTime(order.getTime());

		SalesmanStore salesmanStore = salesmanStoreDao.getBySid(nzd);
		if (salesmanStore != null) {
			orderbro.setBsalesman(PublicHelper.correctTo(order.getPrice() * order.getCount()
					* order.getCommodity().getBrokerage()));
			orderbro.setSid(salesmanStore.getUid());
		}

		orderBrokerageDao.save(orderbro);

		// 确认收货，累计返利
		OrderRebate orderRebate = null;
		Commodity commodity = commodityDao.findOne(order.getCommodity().getId());
		commodity.setGradualrebates(commodityGradualrebateDao.getByCommodity(order.getCommodity().getId()));
		List<OrderRebate> rebates = rebateDao
				.getByNzdAndCommodity(order.getNzd().getId(), order.getCommodity().getId());
		if (rebates == null || rebates.size() == 0) {
			orderRebate = new OrderRebate();
			orderRebate.setCommodity(order.getCommodity());
			orderRebate.setNzd(order.getNzd());
			orderRebate.setProvider(order.getCommodity().getProvider());
			orderRebate.setCount(order.getCount());
			orderRebate.setTotal(PublicHelper.correctTo(order.getCount() * order.getPrice()));
			Date sDate = new Date();
			orderRebate.setStarttime(sDate);
			if (commodity.getRebatedays() != null) {
				Date etime = PublicHelper.getNextday(sDate, commodity.getRebatedays());
				orderRebate.setEndtime(etime);
			}
		} else {
			Date date = new Date();
			for (Iterator iterator = rebates.iterator(); iterator.hasNext();) {
				OrderRebate rebate = (OrderRebate) iterator.next();
				if (rebate.getEndtime() == null) {
					orderRebate = rebate;
					int count = orderRebate.getCount() == null ? order.getCount() : (orderRebate.getCount() + order
							.getCount());
					orderRebate.setCount(count);
					double total = orderRebate.getTotal() == null ? PublicHelper.correctTo(order.getCount()
							* order.getPrice()) : PublicHelper.correctTo(orderRebate.getTotal() + order.getCount()
							* order.getPrice());
					orderRebate.setTotal(total);
					if (commodity.getRebatedays() != null) {
						Date etime = PublicHelper.getNextday(orderRebate.getStarttime(), commodity.getRebatedays());
						orderRebate.setEndtime(etime);
					}
					break;
				} else {
					if (date.before(rebate.getEndtime())) {
						orderRebate = rebate;
						int count = orderRebate.getCount() == null ? order.getCount() : (orderRebate.getCount() + order
								.getCount());
						orderRebate.setCount(count);
						double total = orderRebate.getTotal() == null ? PublicHelper.correctTo(order.getCount()
								* order.getPrice()) : PublicHelper.correctTo(orderRebate.getTotal() + order.getCount()
								* order.getPrice());
						orderRebate.setTotal(total);
						break;
					}
				}
			}
			if (orderRebate == null) {
				orderRebate = new OrderRebate();
				orderRebate.setCommodity(order.getCommodity());
				orderRebate.setNzd(order.getNzd());
				orderRebate.setProvider(order.getCommodity().getProvider());
				orderRebate.setCount(order.getCount());
				orderRebate.setTotal(PublicHelper.correctTo(order.getCount() * order.getPrice()));
				Date sDate = new Date();
				orderRebate.setStarttime(sDate);
				if (commodity.getRebatedays() != null) {
					Date etime = PublicHelper.getNextday(sDate, commodity.getRebatedays());
					orderRebate.setEndtime(etime);
				}
			}
		}

		double rate = 0;
		double amount = 0;
		if (commodity.getGradualrebates() != null && commodity.getGradualrebates().size() > 0) {
			for (Iterator iterator = commodity.getGradualrebates().iterator(); iterator.hasNext();) {
				CommodityGradualrebate crebate = (CommodityGradualrebate) iterator.next();
				if (orderRebate.getCount() >= crebate.getMinnumber()) {
					rate = crebate.getRebate();
					amount = PublicHelper.correctTo(rate * orderRebate.getTotal());
				}
			}
		}
		orderRebate.setRate(rate);
		orderRebate.setAmount(amount);
		orderRebate.setRstatus(0);
		orderRebate.setStatus(0);
		rebateDao.save(orderRebate);

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

	/**
	 * 申请延长保护期
	 * 
	 * @param oid
	 * @param nzd
	 * @return
	 */
	public boolean extendProtectionApply(int oid, String nzd, int days) {
		Orders order = orderDao.findOne(oid);
		checkOrderValid(nzd, order);

		if (order.getStatus() != 3) {
			throw new RuntimeException("订单未确认，不能申请延长保护期");
		}

		if (order.getExtendStatus() != null) {
			throw new RuntimeException("已申请延长保护期，不能重复申请");
		}

		order.setExtendStatus(0);
		order.setExtendDays(days);
		orderDao.save(order);
		return true;
	}

	/**
	 * 通过延长保护期
	 * 
	 * @param oid
	 * @return
	 */
	public boolean extendProtectionConfirm(int oid) {
		Orders order = orderDao.findOne(oid);

		if (order.getStatus() != 3) {
			throw new RuntimeException("订单未确认，不能申请延长保护期");
		}

		if (!(order.getExtendStatus() != null && order.getExtendStatus() == 0)) {
			throw new RuntimeException("该订单未申请延长保护期，无法审核");
		}

		order.setExtendStatus(null);

		Date start = order.getEndtime() == null ? order.getTime() : order.getEndtime();
		Date end = new DateTime(start).plusDays(order.getExtendDays()).toDate();
		order.setEndtime(end);
		order.setExtendStatus(null);
		order.setExtendDays(null);
		orderDao.save(order);
		return true;
	}

	/**
	 * 驳回延长保护期
	 * 
	 * @param oid
	 * @return
	 */
	public boolean extendProtectionBack(int oid) {
		Orders order = orderDao.findOne(oid);

		if (order.getStatus() != 3) {
			throw new RuntimeException("订单未确认，不能申请延长保护期");
		}

		if (!(order.getExtendStatus() != null && order.getExtendStatus() == 0)) {
			throw new RuntimeException("该订单未申请延长保护期，无法审核");
		}
		order.setExtendStatus(null);
		order.setExtendDays(null);
		orderDao.save(order);
		return true;
	}

	public boolean setProtection(int oid, int days, double radius) {
		Orders order = orderDao.findOne(oid);
		if (order.getStatus() != 3) {
			throw new RuntimeException("订单未确认，不能申请延长保护期");
		}

		Date start = order.getEndtime() == null ? order.getTime() : order.getEndtime();
		Date end = new DateTime(start).plusDays(days).toDate();
		order.setEndtime(end);
		order.setRadius(radius);
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
		String[] users = getProviderName(userid);
		List<Orders> list = orderDao.getByProvider(users, new PageRequest(page, size));
		return list;
	}

	/**
	 * 获取供应商订单个数
	 * 
	 * @param userid
	 * @return
	 */
	public int getCountOrdersOfProvider(String userid) {
		String[] users = getProviderName(userid);
		int count = orderDao.getCountByProvider(users);
		return count;
	}

	public List<Orders> getConfirmedOfProvider(String userid, int page, int size) {
		String[] users = getProviderName(userid);
		return orderDao.getConfirmedOfProvider(users, new PageRequest(page, size));
	}

	public int getConfirmedOfProviderCount(String userid) {
		String[] users = getProviderName(userid);
		return orderDao.getConfirmedOfProviderCount(users);
	}

	/**
	 * 获取快到保护期的订单列表
	 * 
	 * @param userids
	 * @param page
	 * @return
	 */
	public List<Orders> getNearProtectionOfProvider(String userid, int days, int page, int size) {
		String[] users = getProviderName(userid);
		Date end = new DateTime().plusDays(days).toDate();
		return orderDao.getNearProtectionOfProvider(users, end, new PageRequest(page, size));
	}

	public int getNearProtectionOfProviderCount(String userid, int days) {
		String[] users = getProviderName(userid);
		Date end = new DateTime().plusDays(days).toDate();
		return orderDao.getNearProtectionOfProviderCount(users, end);
	}

	private String[] getProviderName(String userid) {
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
		return users.toArray(new String[0]);
	}
}
