package com.dfyy.b2b.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.OrdersSecond;

@Repository
public interface OrdersSecondDao extends CrudRepository<OrdersSecond, Integer>, JpaSpecificationExecutor<OrdersSecond> {

	@Query("select u from OrdersSecond as u left join fetch u.second where u.nzd = ?1 and u.cid = ?2 and u.status=0")
	public OrdersSecond getCommoditySecond(String nzd, int cid);
	
	@Query("select u from OrdersSecond as u left join fetch u.second where u.nzd = ?1 and u.cid = ?2")
	public List<OrdersSecond> getCommoditySeconds(String nzd, int cid);


	@Query("select u from OrdersSecond as u left join fetch u.second where u.nzd = ?1 and u.status=0")
	public List<OrdersSecond> getCommoditySecond(String nzd, Pageable page);

	@Query("select u from OrdersSecond as u left join fetch u.second where u.nzd = ?1 and u.time <= ?2 and u.status=0")
	public List<OrdersSecond> getCommoditySecond(String nzd, Date lasttime, Pageable page);
}
