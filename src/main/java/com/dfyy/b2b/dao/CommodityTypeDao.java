package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.CommodityType;

@Repository
public interface CommodityTypeDao extends CrudRepository<CommodityType, Integer>,
		JpaSpecificationExecutor<CommodityType> {
	@Query("select u from CommodityType as u order by u.id asc")
	public List<CommodityType> getAll();

	@Query("select u from CommodityType as u where u.category is not null order by u.category asc, u.id asc")
	public List<CommodityType> getAllSub();
	
	@Query("select u from CommodityType as u where u.category = -1 order by u.id asc")
	public List<CommodityType> getAllParent();
	
	
	@Query("select u.id from CommodityType as u where u.category = ?1 order by u.id asc")
	public List<Integer> getSubs(int ptype);
}
