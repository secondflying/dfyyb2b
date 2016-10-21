package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.CommodityProtective;

@Repository
public interface CommodityProtectiveDao extends CrudRepository<CommodityProtective, Integer>,
JpaSpecificationExecutor<CommodityProtective> {

	@Query("select u from CommodityProtective u where u.cid=?1 and u.status=0")
	public List<CommodityProtective> getByCommodity(Integer aid);
}
