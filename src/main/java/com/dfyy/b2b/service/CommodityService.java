package com.dfyy.b2b.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.Commodity2;
import com.dfyy.b2b.bussiness.CommodityAttachment;
import com.dfyy.b2b.bussiness.CommodityTag;
import com.dfyy.b2b.bussiness.CommodityType;
import com.dfyy.b2b.bussiness.CommodityUnit;
import com.dfyy.b2b.dao.Commodity2Dao;
import com.dfyy.b2b.dao.CommodityAttachmentDao;
import com.dfyy.b2b.dao.CommodityDao;
import com.dfyy.b2b.dao.CommodityTagDao;
import com.dfyy.b2b.dao.CommodityTypeDao;
import com.dfyy.b2b.dao.CommodityUnitDao;
import com.dfyy.b2b.dao.UserDao;
import com.dfyy.b2b.dto.AttachmentDto;
import com.dfyy.b2b.web.form.CommodityForm;

@Service
@Transactional
public class CommodityService {

	@Autowired
	private CommodityDao commodityDao;

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
	private UserDao userDao;

	public List<Commodity> getCommodityOfProvider(String userid, int page, int size) {
		List<Commodity> list = commodityDao.getByUser(userid, new PageRequest(page, size));
		return list;
	}

	public int getCountCommodityOfProvider(String userid) {
		return commodityDao.getCountByUser(userid);
	}

	public Commodity getCommodity(int id) {
		Commodity obj = commodityDao.findOne(id);
		return obj;
	}

	public void deleteCommodity(Integer id) {
		Commodity obj = commodityDao.findOne(id);
		obj.setStatus(-1);
		commodityDao.save(obj);
	}

	public Commodity createCommodity(CommodityForm obj) {
		Commodity commodity = new Commodity();
		commodity.setStatus(obj.getStatus());
		commodity.setProvider(userDao.findOne(obj.getUserid()));

		// 添加别的属性
		commodity.setName(obj.getName());
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

		return commodityDao.save(commodity);
	}

	public Commodity editCommodity(CommodityForm obj) {
		Commodity commodity = commodityDao.findOne(obj.getId());

		// 添加别的属性
		commodity.setName(obj.getName());
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

		return commodityDao.save(commodity);
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
