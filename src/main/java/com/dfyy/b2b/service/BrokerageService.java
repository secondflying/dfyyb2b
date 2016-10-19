package com.dfyy.b2b.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.PpBrokerage;
import com.dfyy.b2b.bussiness.SalesmanBrokerage;
import com.dfyy.b2b.dao.PpBrokerageDao;
import com.dfyy.b2b.dao.SalesmanBrokerageDao;
import com.dfyy.b2b.dto.ProkerageDto;

@Service
@Transactional
public class BrokerageService {

	@Autowired
	private PpBrokerageDao ppBrokerageDao;
	@Autowired
	private SalesmanBrokerageDao salesmanBrokerageDao;
	
	/**
	 * 获取平台佣金系数树
	 * @return
	 */
	public List<ProkerageDto> getByAllCrops(){
		List<Object> objects = ppBrokerageDao.getByAllCrop();
		List<ProkerageDto> crops = getChildrens(-1, objects);
		return crops;
	}
	
	private List<ProkerageDto> getChildrens(Integer parentid, Iterable<Object> objectss) {
		List<ProkerageDto> childrens = new ArrayList<ProkerageDto>();
		for (Iterator<Object> iterator = objectss.iterator(); iterator.hasNext();) {
			Object[] objects = (Object[]) iterator.next();
			int kid = (int)objects[2];
			if ( kid == parentid) {
				ProkerageDto prokerageDto = new ProkerageDto(objects);
				childrens.add(prokerageDto);
				prokerageDto.setChilds(getChildrens(prokerageDto.getId(), objectss));
			}
		}
		return childrens;
	}
	
	/**
	 * 根据类别id获取平台佣金系数
	 * @param cid
	 * @return
	 */
	public PpBrokerage getByCrop(int cid){
		return ppBrokerageDao.getByCid(cid);
	}
	
	/**
	 * 存储平台佣金系数记录
	 * @param ppBrokerage
	 */
	public void save(PpBrokerage ppBrokerage){
		ppBrokerageDao.save(ppBrokerage);
	}
	
	/**
	 * 删除平台佣金系数记录
	 * @param id
	 */
	public void delete(int id){
		PpBrokerage ppBrokerage = ppBrokerageDao.findOne(id);
		if(ppBrokerage!=null){
			ppBrokerage.setStatus(-1);
			ppBrokerageDao.save(ppBrokerage);
		}
	}
	
	/**
	 * 获取业务员佣金范围
	 * @return
	 */
	public SalesmanBrokerage getSalesmanBrokerage(){
		return salesmanBrokerageDao.getvalue();
	}
	
	/**
	 * 存储业务员佣金系数记录
	 * @param s
	 */
	public void saveS(SalesmanBrokerage s){
		salesmanBrokerageDao.save(s);
	}
	
	/**
	 * 删除业务员佣金系数记录
	 * @param id
	 */
	public void deleteS(int id){
		SalesmanBrokerage salesmanBrokerage = salesmanBrokerageDao.findOne(id);
		if(salesmanBrokerage!=null){
			salesmanBrokerage.setStatus(-1);
			salesmanBrokerageDao.save(salesmanBrokerage);
		}
	}
}
