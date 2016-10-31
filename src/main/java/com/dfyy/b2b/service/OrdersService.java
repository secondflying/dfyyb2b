package com.dfyy.b2b.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.dao.CommodityDao;
import com.dfyy.b2b.dao.CommodityGradualpriceDao;
import com.dfyy.b2b.dao.OrdersDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dto.OrdersResult;

@Service
@Transactional
public class OrdersService {

	private SUserDao sUserDao;

	@Autowired
	private CommodityDao commodityDao;

	@Autowired
	private CommodityGradualpriceDao gradualpriceDao;

	@Autowired
	private OrdersDao orderDao;

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

	public Orders getSingle(int orderid) {
		Orders order = orderDao.findOne(orderid);
		return order;
	}

}
