package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.CommodityGradualprice;

@Repository
public interface CommodityGradualpriceDao extends CrudRepository<CommodityGradualprice, Integer>,
JpaSpecificationExecutor<CommodityGradualprice>  {

	@Query("select u from CommodityGradualprice u where u.cid=?1 and u.status=0")
	public List<CommodityGradualprice> getByCommodity(Integer aid);
	
	
	@Query("select u from CommodityGradualprice u where u.cid=?1 and u.status=0 and u.minnumber<= ?2  order by u.minnumber desc")
	public List<CommodityGradualprice> getByCommodityAndCount(Integer cid,int count);
}
