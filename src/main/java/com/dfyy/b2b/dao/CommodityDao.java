package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Commodity;

@Repository
public interface CommodityDao extends CrudRepository<Commodity, Integer>, JpaSpecificationExecutor<Commodity> {
	@Query("select u from Commodity as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.status=?1 order by u.time desc ")
	public List<Commodity> getByStatus(int status);
}