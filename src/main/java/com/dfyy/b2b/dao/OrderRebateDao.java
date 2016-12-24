package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.OrderRebate;

@Repository
public interface OrderRebateDao extends CrudRepository<OrderRebate, Integer>, JpaSpecificationExecutor<OrderRebate> {

	@Query("select u from OrderRebate as u left join fetch u.nzd left join fetch u.commodity left join fetch u.provider where u.nzd.id=?1 and u.status <> -1 order by u.starttime desc ")
	public List<OrderRebate> getByNzd(String nid,Pageable page);
	
	@Query("select count(u) from OrderRebate as u where u.nzd.id=?1 and u.status <> -1")
	public int getCountByNzd(String userid);
	
	@Query("select u from OrderRebate as u left join fetch u.nzd left join fetch u.commodity left join fetch u.provider where u.commodity.id=?1 and u.status <> -1 order by u.starttime desc ")
	public List<OrderRebate> getByCommodity(int cid,Pageable page);
	
	@Query("select count(u) from OrderRebate as u where u.commodity.id=?1 and u.status <> -1")
	public int getCountByCommodity(int cid);
	
	@Query("select u from OrderRebate as u left join fetch u.nzd left join fetch u.commodity left join fetch u.provider where u.provider.id=?1 and u.status <> -1 order by u.starttime desc ")
	public List<OrderRebate> getByProvider(String pid,Pageable page);
	
	@Query("select count(u) from OrderRebate as u where u.provider.id=?1 and u.status <> -1")
	public int getCountByProvider(String pid);
	
	@Query("select u from OrderRebate as u left join fetch u.nzd left join fetch u.commodity left join fetch u.provider where u.nzd.id=?1 and u.commodity.id=?2 and u.rstatus=0 and u.status <> -1 order by u.starttime desc ")
	public List<OrderRebate> getByNzdAndCommodity(String nid,int cid);
}
