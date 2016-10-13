package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.CommodityUnit;

@Repository
public interface CommodityUnitDao extends CrudRepository<CommodityUnit, Integer>,
		JpaSpecificationExecutor<CommodityUnit> {
	@Query("select u from CommodityUnit as u where u.status=0 order by u.id asc ")
	public List<CommodityUnit> getAll();
}
