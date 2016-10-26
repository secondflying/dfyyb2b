package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Shopcart;

@Repository
public interface ShopcartDao extends CrudRepository<Shopcart, Integer>, JpaSpecificationExecutor<Shopcart> {
	
	@Query("select u from Shopcart as u left join fetch u.commodity left join fetch u.nzd  where u.nzd.id = ?1 order by u.time desc ")
	public List<Shopcart> getList(String userid);
	
	
	@Query("select u from Shopcart as u left join fetch u.commodity left join fetch u.nzd  where u.nzd.id = ?1 and u.commodity.id = ?2")
	public Shopcart getSingle(String userid,int cid);
}
