package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.CommodityReview;

@Repository
public interface CommodityReviewDao extends CrudRepository<CommodityReview, Integer>, JpaSpecificationExecutor<Integer> {

	@Query("select u from CommodityReview u where u.cid = ?1 order by time DESC")
	public List<CommodityReview> getByCid(int cid);
}
