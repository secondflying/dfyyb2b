package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.CommodityGradualrebate;

@Repository
public interface CommodityGradualrebateDao extends CrudRepository<CommodityGradualrebate, Integer>,
JpaSpecificationExecutor<CommodityGradualrebate> {

	@Query("select u from CommodityGradualrebate u where u.cid=?1 and u.status=0")
	public List<CommodityGradualrebate> getByCommodity(Integer aid);
}
