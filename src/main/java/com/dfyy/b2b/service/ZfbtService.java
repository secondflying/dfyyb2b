package com.dfyy.b2b.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.CommodityAttachment;
import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.bussiness.OrdersInventory;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.Second;
import com.dfyy.b2b.bussiness.SecondAttachment;
import com.dfyy.b2b.bussiness.UserSecond;
import com.dfyy.b2b.dao.CommodityAttachmentDao;
import com.dfyy.b2b.dao.CommodityDao;
import com.dfyy.b2b.dao.OrdersDao;
import com.dfyy.b2b.dao.OrdersInventoryDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.SecondAttachmentDao;
import com.dfyy.b2b.dao.SecondDao;
import com.dfyy.b2b.dao.UserSecondDao;
import com.dfyy.b2b.dto.SecondsResult;
import com.dfyy.b2b.dto.UserSecondsResult;
import com.dfyy.b2b.dto.ZfbtDto;
import com.dfyy.b2b.util.PublicConfig;

@Service
@Transactional
public class ZfbtService {

	@Autowired
	private SUserDao sUserDao;

	@Autowired
	private CommodityDao commodityDao;

	@Autowired
	private CommodityAttachmentDao commodityAttachmentDao;

	@Autowired
	private OrdersDao orderDao;

	@Autowired
	private OrdersInventoryDao inventoryDao;

	@Autowired
	private SecondDao secondDao;

	@Autowired
	private SecondAttachmentDao secondAttachmentDao;

	@Autowired
	private UserSecondDao userSecondDao;

	/**
	 * 上架B端商品到超实惠
	 * 
	 * @param nzd
	 * @param cid
	 */
	public void convert(ZfbtDto dto) {
		SUser nzd = sUserDao.findOne(dto.getNzd());
		if (nzd == null) {
			throw new RuntimeException("该农资店不存在");
		}

		Commodity commodity = commodityDao.findOne(dto.getCid());
		if (commodity == null) {
			throw new RuntimeException("该商品不存在");
		}

		List<Orders> orders = orderDao.getNzdBuyCommodity(nzd.getId(), dto.getCid(), null);
		if (orders == null || orders.size() == 0) {
			throw new RuntimeException("农资店没有进货该商品");
		}

		OrdersInventory inventory = inventoryDao.getCommodityInventory(nzd.getId(), dto.getCid());
		if (inventory == null || inventory.getCount() == 0) {
			throw new RuntimeException("农资店该商品的库存为0");
		}

		if (dto.getCount() > inventory.getCount()) {
			throw new RuntimeException("农资店该商品的库存不够");
		}

		inventory.setCount(inventory.getCount() - dto.getCount());
		inventoryDao.save(inventory);

		Second second = new Second();
		second.setTitle(commodity.getName());
		second.setContent(commodity.getName());

		second.setCount(dto.getCount());
		second.setStarttime(dto.getStarttime());
		second.setEndtime(dto.getEndtime());
		second.setOprice(dto.getOprice());
		second.setNprice(dto.getNprice());
		second.setNzd(nzd);
		second.setAcount(dto.getCount());
		second.setTime(new Date());
		second.setType(2);
		second.setVerify(1);
		second.setX(nzd.getX());
		second.setY(nzd.getY());
		second.setSize(dto.getSize());
		second.setMaxbuy(dto.getMaxbuy());
		second.setZone(dto.getZone());
		second.setHaocount(0);
		second.setZhongcount(0);
		second.setChacount(0);
		second.setSumcount(0);

		second.setCoupon(dto.getCoupon());
		second.setCouponMax(dto.getCouponMax());
		second.setUseCoupon(dto.isUseCoupon());
		second.setImage(commodity.getImage());
		secondDao.save(second);

		List<CommodityAttachment> atts = commodityAttachmentDao.getByCommodity(commodity.getId());
		for (CommodityAttachment att : atts) {
			if (StringUtils.isNotBlank(att.getUrl())) {
				SecondAttachment attachment = new SecondAttachment();
				attachment.setSid(second.getId());
				attachment.setStatus(0);
				attachment.setUrl(att.getUrl());
				secondAttachmentDao.save(attachment);

				File big = new File(PublicConfig.getImagePath() + "seconds" + File.separator + "big" + File.separator,
						att.getUrl());
				File small = new File(PublicConfig.getImagePath() + "seconds" + File.separator + "small"
						+ File.separator, att.getUrl());
				File big2 = new File(PublicConfig.getImagePath() + "b2bcommodity" + File.separator + "big"
						+ File.separator, att.getUrl());
				File small2 = new File(PublicConfig.getImagePath() + "b2bcommodity" + File.separator + "small"
						+ File.separator, att.getUrl());
				if (!big.exists()) {
					try {
						IOUtils.copy(new FileInputStream(big2), new FileOutputStream(big));
					} catch (FileNotFoundException e) {
					} catch (IOException e) {
					}
				}

				if (!small.exists()) {
					try {
						IOUtils.copy(new FileInputStream(small2), new FileOutputStream(small));
					} catch (FileNotFoundException e) {
					} catch (IOException e) {
					}
				}
			}
		}
	}

	public OrdersInventory getInventory(String nzd, int cid) {
		OrdersInventory inventory = inventoryDao.getCommodityInventory(nzd, cid);
		if (inventory == null) {
			throw new RuntimeException("农资店无该商品");
		}

		return inventory;
	}

	/**
	 * 农资店上架的超实惠列表
	 * 
	 * @param nzd
	 * @param page
	 * @param time
	 * @return
	 */
	public SecondsResult getMySeconds(String nzd, int page, long time) {
		SecondsResult result = new SecondsResult();
		if (page == 0) {
			List<Second> list = secondDao.getOfNzd(nzd, new PageRequest(page, 20));

			result.setResults(list);
			result.setLastTime(new Date().getTime());
		} else {
			List<Second> list = secondDao.getOfNzd(nzd, new Date(time), new PageRequest(page, 20));
			result.setResults(list);
			result.setLastTime(time);
		}
		return result;
	}

	/**
	 * 农资店超实惠订单列表
	 * 
	 * @param nzd
	 * @param page
	 * @param time
	 * @return
	 */
	public UserSecondsResult getMyOrders(String nzd, int page, long time) {
		UserSecondsResult result = new UserSecondsResult();
		if (page == 0) {
			List<UserSecond> list = userSecondDao.getOrdersOfNzd(nzd, new PageRequest(page, 20));

			result.setResults(list);
			result.setLastTime(new Date().getTime());
		} else {
			List<UserSecond> list = userSecondDao.getOrdersOfNzd(nzd, new Date(time), new PageRequest(page, 20));
			result.setResults(list);
			result.setLastTime(time);
		}
		return result;
	}

	/**
	 * 农资店单个超实惠售卖历史
	 * 
	 * @param nzd
	 * @param page
	 * @param time
	 * @return
	 */
	public UserSecondsResult getSellHistory(String nzd, int sid, int page, long time) {
		UserSecondsResult result = new UserSecondsResult();
		if (page == 0) {
			List<UserSecond> list = userSecondDao.getSellHistory(nzd, sid, new PageRequest(page, 20));

			result.setResults(list);
			result.setLastTime(new Date().getTime());
		} else {
			List<UserSecond> list = userSecondDao.getSellHistory(nzd, sid, new Date(time), new PageRequest(page, 20));
			result.setResults(list);
			result.setLastTime(time);
		}
		return result;
	}
}
