package com.dfyy.b2b.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.Commodity2;
import com.dfyy.b2b.bussiness.CommodityAttachment;
import com.dfyy.b2b.bussiness.CommodityGradualprice;
import com.dfyy.b2b.bussiness.CommodityGradualrebate;
import com.dfyy.b2b.bussiness.CommodityOfPro;
import com.dfyy.b2b.bussiness.CommodityPrice;
import com.dfyy.b2b.bussiness.CommodityProtective;
import com.dfyy.b2b.bussiness.CommodityReview;
import com.dfyy.b2b.bussiness.CommodityTag;
import com.dfyy.b2b.bussiness.CommodityType;
import com.dfyy.b2b.bussiness.CommodityUnit;
import com.dfyy.b2b.bussiness.PartnerDealer;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.dao.Commodity2Dao;
import com.dfyy.b2b.dao.CommodityAttachmentDao;
import com.dfyy.b2b.dao.CommodityDao;
import com.dfyy.b2b.dao.CommodityGradualpriceDao;
import com.dfyy.b2b.dao.CommodityGradualrebateDao;
import com.dfyy.b2b.dao.CommodityOfProDao;
import com.dfyy.b2b.dao.CommodityPriceDao;
import com.dfyy.b2b.dao.CommodityProtectiveDao;
import com.dfyy.b2b.dao.CommodityReviewDao;
import com.dfyy.b2b.dao.CommodityTagDao;
import com.dfyy.b2b.dao.CommodityTypeDao;
import com.dfyy.b2b.dao.CommodityUnitDao;
import com.dfyy.b2b.dao.PartnerDealerDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.UserDao;
import com.dfyy.b2b.dto.AttachmentDto;
import com.dfyy.b2b.dto.CommoditiesResult;
import com.dfyy.b2b.web.form.CommodityForm;

@Service
@Transactional
public class CommodityService {

	@Autowired
	private CommodityDao commodityDao;

	@Autowired
	private CommodityOfProDao commodityOfProDao;

	@Autowired
	private Commodity2Dao commodity2Dao;

	@Autowired
	private CommodityTypeDao commodityTypeDao;

	@Autowired
	private CommodityTagDao commodityTagDao;

	@Autowired
	private CommodityUnitDao commodityUnitDao;

	@Autowired
	private CommodityAttachmentDao commodityAttachmentDao;

	@Autowired
	private CommodityReviewDao commodityReviewDao;

	@Autowired
	private CommodityPriceDao commodityPriceDao;

	@Autowired
	private CommodityGradualpriceDao commodityGradualpriceDao;

	@Autowired
	private CommodityGradualrebateDao commodityGradualrebateDao;

	@Autowired
	private CommodityProtectiveDao commodityProtectiveDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private PartnerDealerDao pDealerDao;

	@Autowired
	private SUserDao sUserDao;

	/**
	 * 获取某个农资店能看到的在线商品列表
	 * 
	 * @param userid
	 * @param page
	 * @param size
	 * @return
	 */
	public CommoditiesResult getOnlineCommodity(String nzd, String type, String key, int page, long time) {
		CommoditiesResult result = new CommoditiesResult();
		SUser user = sUserDao.findOne(nzd);
		List<CommodityOfPro> list = null;
		if (page == 0) {
			if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(key)) {
				list = commodityOfProDao.getOnline(nzd, user.getY(), user.getX(), Integer.parseInt(type), key,
						new PageRequest(page, 20));
			} else if (StringUtils.isNotBlank(type) && StringUtils.isBlank(key)) {
				list = commodityOfProDao.getOnline(nzd, user.getY(), user.getX(), Integer.parseInt(type),
						new PageRequest(page, 20));
			} else if (StringUtils.isNotBlank(key) && StringUtils.isBlank(type)) {
				list = commodityOfProDao.getOnline(nzd, user.getY(), user.getX(), key, new PageRequest(page, 20));
			} else {
				list = commodityOfProDao.getOnline(nzd, user.getY(), user.getX(), new PageRequest(page, 20));
			}

			result.setLastTime(new Date().getTime());
		} else {

			if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(key)) {
				list = commodityOfProDao.getOnline(nzd, user.getY(), user.getX(), Integer.parseInt(type), key,
						new Date(time), new PageRequest(page, 20));
			} else if (StringUtils.isNotBlank(type) && StringUtils.isBlank(key)) {
				list = commodityOfProDao.getOnline(nzd, user.getY(), user.getX(), Integer.parseInt(type),
						new Date(time), new PageRequest(page, 20));
			} else if (StringUtils.isNotBlank(key) && StringUtils.isBlank(type)) {
				list = commodityOfProDao.getOnline(nzd, user.getY(), user.getX(), key, new Date(time), new PageRequest(
						page, 20));
			} else {
				list = commodityOfProDao.getOnline(nzd, user.getY(), user.getX(), new Date(time), new PageRequest(page,
						20));
			}

			result.setLastTime(time);
		}

		result.setResults(list);
		return result;
	}

	/**
	 * 获取某供应商的商品
	 * 
	 * @param userid
	 * @param page
	 * @param size
	 * @return
	 */
	public List<Commodity> getCommodityOfProvider(String userid, int page, int size) {
		List<Commodity> list = commodityDao.getByUser(userid, new PageRequest(page, size));
		return list;
	}

	/**
	 * 获取某供应商的商品个数
	 * 
	 * @param userid
	 * @return
	 */
	public int getCountCommodityOfProvider(String userid) {
		return commodityDao.getCountByUser(userid);
	}

	/**
	 * 按状态获取商品
	 * 
	 * @param status
	 * @param page
	 * @param size
	 * @return
	 */
	public List<Commodity> getCommoditiesByStatus(int status, int page, int size) {
		return commodityDao.getByStatus(status, new PageRequest(page, size));
	}

	/**
	 * 获取某状态商品个数
	 * 
	 * @param status
	 * @return
	 */
	public int getCommoditiesCountByStatus(int status) {
		return commodityDao.getCountByStatus(status);
	}

	/**
	 * 按状态和名称查找商品
	 * 
	 * @return
	 */
	public List<Commodity> findCommoditiesByStatus(String key, int status, int page, int size) {
		return commodityDao.searchByStatus(key, status, new PageRequest(page, size));
	}

	/**
	 * 按状态和名称获取商品个数
	 * 
	 * @return
	 */
	public int findCommoditiesCountByStatus(String key, int status) {
		return commodityDao.searchCountByStatus(key, status);
	}

	/**
	 * 获取合伙人待审核的商品
	 * 
	 * @param uid
	 * @param page
	 * @param size
	 * @return
	 */
	public List<Commodity> getInformalByPartner(String uid, int page, int size) {
		List<PartnerDealer> partnerDealers = pDealerDao.getByPid(uid);
		if (partnerDealers == null || partnerDealers.size() == 0) {
			return null;
		}
		List<String> uids = new ArrayList<String>();
		for (Iterator iterator = partnerDealers.iterator(); iterator.hasNext();) {
			PartnerDealer partnerDealer = (PartnerDealer) iterator.next();
			uids.add(partnerDealer.getDealer().getId());
		}
		List<Commodity> commodities = commodityDao.getInformalByDealers(uids, new PageRequest(page, size));
		return commodities;
	}

	public int getInformalCountByPartner(String uid) {
		List<PartnerDealer> partnerDealers = pDealerDao.getByPid(uid);
		if (partnerDealers == null || partnerDealers.size() == 0) {
			return 0;
		}
		List<String> uids = new ArrayList<String>();
		for (Iterator iterator = partnerDealers.iterator(); iterator.hasNext();) {
			PartnerDealer partnerDealer = (PartnerDealer) iterator.next();
			uids.add(partnerDealer.getDealer().getId());
		}
		int count = commodityDao.getInformalCountByDealers(uids);
		return count;
	}

	/**
	 * 根据id获取商品
	 * 
	 * @param id
	 * @return
	 */
	public Commodity getCommodity(int id) {
		Commodity obj = commodityDao.findOne(id);
		return obj;
	}

	public Commodity getCommodityFull(int id) {
		Commodity obj = commodityDao.findOne(id);
		obj.setTags(getTagsOfCommodity(id));
		obj.setAttachments(commodityAttachmentDao.getByCommodity(id));
		obj.setGradualprices(commodityGradualpriceDao.getByCommodity(id));
		obj.setGradualrebates(commodityGradualrebateDao.getByCommodity(id));
		obj.setProtectives(commodityProtectiveDao.getByCommodity(id));
		return obj;
	}

	/**
	 * 删除商品
	 * 
	 * @param id
	 */
	public void deleteCommodity(Integer id) {
		Commodity obj = commodityDao.findOne(id);
		obj.setStatus(-1);
		commodityDao.save(obj);
	}

	/**
	 * 新增商品
	 * 
	 * @param obj
	 * @return
	 */
	public Commodity createCommodity(CommodityForm obj) {
		Commodity commodity = new Commodity();
		commodity.setStatus(obj.getStatus());
		commodity.setProvider(userDao.findOne(obj.getUserid()));

		// 添加别的属性
		commodity.setName(obj.getName());
		commodity.setBrokerage(obj.getBrokerage());
		commodity.setCode(obj.getCode());
		commodity.setComposition(obj.getComposition());
		commodity.setFactory(obj.getFactory());
		commodity.setNumber(obj.getNumber());
		commodity.setPrice(obj.getPrice());
		commodity.setPricetime(new Date());
		commodity.setOprice(obj.getOprice());
		commodity.setRetail(obj.getRetail());
		commodity.setMaxcount(obj.getMaxcount());
		commodity.setStandard(obj.getStandard());
		commodity.setStep(obj.getStep());
		commodity.setTime(new Date());
		commodity.setZone(obj.getZone());
		commodity.setRebatedays(obj.getRebatedays());
		CommodityType type = commodityTypeDao.findOne(obj.getCid());
		commodity.setType(type);
		CommodityUnit unit = commodityUnitDao.findOne(obj.getUnit());
		commodity.setUnit(unit);
		commodityDao.save(commodity);

		if (obj.getDocs() != null && obj.getDocs().size() > 0) {
			String firsturl = null;

			for (AttachmentDto att : obj.getDocs()) {
				if (StringUtils.isNotBlank(att.getUrl())) {
					CommodityAttachment qa = new CommodityAttachment();
					qa.setCid(commodity.getId());
					qa.setUrl(att.getUrl());
					commodityAttachmentDao.save(qa);

					if (StringUtils.isBlank(firsturl)) {
						firsturl = att.getUrl();
					}
				}
			}

			commodity.setImage(firsturl);
		}

		if (obj.getGprices() != null && obj.getGprices().size() > 0) {
			for (Iterator iterator = obj.getGprices().iterator(); iterator.hasNext();) {
				CommodityGradualprice priceobj = (CommodityGradualprice) iterator.next();
				priceobj.setCid(commodity.getId());
				priceobj.setUid(commodity.getUnit().getId());
				priceobj.setTime(new Date());
				priceobj.setStatus(0);
				commodityGradualpriceDao.save(priceobj);
			}
		}
		if (obj.getGrebates() != null && obj.getGrebates().size() > 0) {
			for (Iterator iterator = obj.getGrebates().iterator(); iterator.hasNext();) {
				CommodityGradualrebate rebateobj = (CommodityGradualrebate) iterator.next();
				rebateobj.setCid(commodity.getId());
				rebateobj.setTime(new Date());
				rebateobj.setStatus(0);
				commodityGradualrebateDao.save(rebateobj);
			}
		}

		return commodityDao.save(commodity);
	}

	/**
	 * 编辑商品
	 * 
	 * @param obj
	 * @return
	 */
	public Commodity editCommodity(CommodityForm obj) {
		Commodity commodity = commodityDao.findOne(obj.getId());
		commodity.setStatus(obj.getStatus());
		List<CommodityAttachment> docs = commodityAttachmentDao.getByCommodity(commodity.getId());
		if (docs != null && docs.size() > 0) {
			for (Iterator iterator = docs.iterator(); iterator.hasNext();) {
				CommodityAttachment commodityAttachment = (CommodityAttachment) iterator.next();
				commodityAttachmentDao.delete(commodityAttachment);
			}
		}
		List<CommodityGradualprice> gradualprices = getGradualprices(commodity.getId());
		if (gradualprices != null && gradualprices.size() > 0) {
			for (Iterator iterator = gradualprices.iterator(); iterator.hasNext();) {
				CommodityGradualprice commodityGradualprice = (CommodityGradualprice) iterator.next();
				commodityGradualprice.setStatus(-1);
				commodityGradualpriceDao.save(commodityGradualprice);
			}
		}
		List<CommodityGradualrebate> gradualrebates = getGradualrebates(commodity.getId());
		if (gradualrebates != null && gradualrebates.size() > 0) {
			for (Iterator iterator = gradualrebates.iterator(); iterator.hasNext();) {
				CommodityGradualrebate commodityGradualrebate = (CommodityGradualrebate) iterator.next();
				commodityGradualrebate.setStatus(-1);
				commodityGradualrebateDao.save(commodityGradualrebate);
			}
		}

		// 添加别的属性
		commodity.setName(obj.getName());
		commodity.setBrokerage(obj.getBrokerage());
		commodity.setCode(obj.getCode());
		commodity.setComposition(obj.getComposition());
		commodity.setFactory(obj.getFactory());
		commodity.setNumber(obj.getNumber());
		commodity.setPrice(obj.getPrice());
		commodity.setOprice(obj.getOprice());
		commodity.setMaxcount(obj.getMaxcount());
		commodity.setRetail(obj.getRetail());
		commodity.setPricetime(new Date());
		commodity.setStandard(obj.getStandard());
		commodity.setStep(obj.getStep());
		CommodityType type = commodityTypeDao.findOne(obj.getCid());
		commodity.setType(type);
		CommodityUnit unit = commodityUnitDao.findOne(obj.getUnit());
		commodity.setUnit(unit);
		commodity.setZone(obj.getZone());
		commodity.setRebatedays(obj.getRebatedays());
		commodityDao.save(commodity);

		commodityAttachmentDao.deleteByCommodity(commodity.getId());
		if (obj.getDocs() != null && obj.getDocs().size() > 0) {
			String firsturl = null;

			for (AttachmentDto att : obj.getDocs()) {
				if (StringUtils.isNotBlank(att.getUrl())) {
					CommodityAttachment qa = new CommodityAttachment();
					qa.setCid(commodity.getId());
					qa.setUrl(att.getUrl());
					commodityAttachmentDao.save(qa);

					if (StringUtils.isBlank(firsturl)) {
						firsturl = att.getUrl();
					}
				}
			}

			commodity.setImage(firsturl);
		}
		if (obj.getGprices() != null && obj.getGprices().size() > 0) {
			for (Iterator iterator = obj.getGprices().iterator(); iterator.hasNext();) {
				CommodityGradualprice priceobj = (CommodityGradualprice) iterator.next();
				priceobj.setCid(commodity.getId());
				priceobj.setUid(commodity.getUnit().getId());
				priceobj.setTime(new Date());
				priceobj.setStatus(0);
				commodityGradualpriceDao.save(priceobj);
			}
		}
		if (obj.getGrebates() != null && obj.getGrebates().size() > 0) {
			for (Iterator iterator = obj.getGrebates().iterator(); iterator.hasNext();) {
				CommodityGradualrebate rebateobj = (CommodityGradualrebate) iterator.next();
				rebateobj.setCid(commodity.getId());
				rebateobj.setTime(new Date());
				rebateobj.setStatus(0);
				commodityGradualrebateDao.save(rebateobj);
			}
		}
		return commodityDao.save(commodity);
	}

	/**
	 * 审核商品
	 * 
	 * @param status
	 * @param commodity
	 * @return
	 */
	public void checkCommodity(Commodity commodity, CommodityReview review) {
		commodityDao.save(commodity);
		commodityReviewDao.save(review);
		if (commodity.getStatus() == 3) {
			// 存储价格更新记录
			CommodityPrice commodityPrice = new CommodityPrice();
			commodityPrice.setCid(commodity.getId());
			commodityPrice.setPrice(commodity.getPrice());
			commodityPrice.setUid(commodity.getUnit().getId());
			commodityPrice.setTime(new Date());
			commodityPrice.setStatus(0);
			commodityPriceDao.save(commodityPrice);
		}
	}

	/**
	 * 获取最新的审核意见
	 * 
	 * @param cid
	 * @return
	 */
	public CommodityReview getReviews(int cid) {
		List<CommodityReview> reviews = commodityReviewDao.getByCid(cid);
		if (reviews == null || reviews.size() == 0) {
			return null;
		}
		return reviews.get(0);
	}

	/**
	 * 获取商品的阶梯价格
	 * 
	 * @param cid
	 * @return
	 */
	public List<CommodityGradualprice> getGradualprices(int cid) {
		return commodityGradualpriceDao.getByCommodity(cid);
	}

	/**
	 * 获取商品的阶梯返利
	 * 
	 * @param cid
	 * @return
	 */
	public List<CommodityGradualrebate> getGradualrebates(int cid) {
		return commodityGradualrebateDao.getByCommodity(cid);
	}

	/**
	 * 获取商品的保护条件
	 * 
	 * @param cid
	 * @return
	 */
	public List<CommodityProtective> getProtectives(int cid) {
		return commodityProtectiveDao.getByCommodity(cid);
	}

	/**
	 * 新增编辑保护条件
	 * 
	 * @param commodityProtective
	 * @return
	 */
	public CommodityProtective saveOrUpdate(CommodityProtective commodityProtective) {
		return commodityProtectiveDao.save(commodityProtective);
	}

	/**
	 * 获取保护条件
	 * 
	 * @param id
	 * @return
	 */
	public CommodityProtective getProtective(int id) {
		return commodityProtectiveDao.findOne(id);
	}

	/**
	 * 获取商品类别，树状结构
	 * 
	 * @return
	 */
	public List<CommodityType> getTreeCommodityType() {
		List<CommodityType> crops = commodityTypeDao.getAll();
		List<CommodityType> crops2 = getChildrens(-1, crops);
		return crops2;
	}

	/**
	 * 获取所有商品大类
	 * 
	 * @return
	 */
	public List<CommodityType> getCommodityTypeParent() {
		List<CommodityType> crops = commodityTypeDao.getAllParent();
		return crops;
	}

	/**
	 * 根据id获取商品类型
	 * 
	 * @param id
	 * @return
	 */
	public CommodityType getCommodityType(int id) {
		return commodityTypeDao.findOne(id);
	}

	/**
	 * 存储商品分类
	 * 
	 * @param type
	 */
	public void saveCommodityType(CommodityType type) {
		commodityTypeDao.save(type);
	}

	/**
	 * 删除商品分类
	 * 
	 * @param id
	 */
	public void deleteCommodityType(int id) {
		commodityTypeDao.delete(id);
	}

	/**
	 * 获取所有商品标签
	 * 
	 * @return
	 */
	public List<CommodityTag> getAllCommodityTags() {
		List<CommodityTag> crops = commodityTagDao.getAll();
		return crops;
	}

	/**
	 * 获取某个商品的标签列表
	 * 
	 * @param cid
	 * @return
	 */
	public List<CommodityTag> getTagsOfCommodity(int cid) {
		Commodity2 commodity2 = commodity2Dao.findOne(cid);
		Hibernate.initialize(commodity2.getTags());
		return commodity2.getTags();
	}

	/**
	 * 根据id获取标签
	 * 
	 * @param id
	 * @return
	 */
	public CommodityTag getTagById(int id) {
		return commodityTagDao.findOne(id);
	}

	/**
	 * 存储标签
	 * 
	 * @param tag
	 */
	public void saveTag(CommodityTag tag) {
		commodityTagDao.save(tag);
	}

	/**
	 * 删除标签
	 * 
	 * @param id
	 */
	public void deleteTag(int id) {
		commodityTagDao.delete(id);
	}

	/**
	 * 获取所有商品单位
	 * 
	 * @return
	 */
	public List<CommodityUnit> getAllCommodityUnits() {
		List<CommodityUnit> crops = commodityUnitDao.getAll();
		return crops;
	}

	/**
	 * 获取某商品的图片
	 * 
	 * @param cid
	 * @return
	 */
	public List<CommodityAttachment> getdocByCommodity(int cid) {
		return commodityAttachmentDao.getByCommodity(cid);
	}

	/**
	 * 根据id获取单位
	 * 
	 * @param id
	 * @return
	 */
	public CommodityUnit getUnitById(int id) {
		return commodityUnitDao.findOne(id);
	}

	/**
	 * 存储商品单位
	 * 
	 * @param unit
	 */
	public void saveUnit(CommodityUnit unit) {
		commodityUnitDao.save(unit);
	}

	/**
	 * 删除商品分类
	 * 
	 * @param id
	 */
	public void deleteUnit(int id) {
		commodityUnitDao.delete(id);
	}

	/**
	 * 给商品增加标签
	 * 
	 * @param cid
	 * @param tags
	 */
	public void addTagsToCommodity(int cid, List<Integer> tids) {
		Commodity2 commodity2 = commodity2Dao.findOne(cid);
		if (commodity2 != null) {
			List<CommodityTag> tags = commodity2.getTags();
			tags.clear();

			for (Integer tid : tids) {
				tags.add(commodityTagDao.findOne(tid));
			}
			commodity2Dao.save(commodity2);
		}
	}

	private List<CommodityType> getChildrens(Integer parentid, Iterable<CommodityType> crops) {
		List<CommodityType> childrens = new ArrayList<CommodityType>();
		for (Iterator<CommodityType> iterator = crops.iterator(); iterator.hasNext();) {
			CommodityType crop = (CommodityType) iterator.next();
			if (crop.getCategory() == parentid) {
				childrens.add(crop);
				crop.setChildCrops(getChildrens(crop.getId(), crops));
			}
		}
		return childrens;
	}

}
