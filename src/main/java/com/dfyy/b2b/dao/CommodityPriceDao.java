package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.CommodityPrice;

@Repository
public interface CommodityPriceDao extends CrudRepository<CommodityPrice, Integer>,
JpaSpecificationExecutor<CommodityPrice> {

	@Query("select u from CommodityPrice u where u.cid=?1 and u.status=0 order by u.time DESC")
	public List<CommodityPrice> getByCommodity(Integer aid);
}
