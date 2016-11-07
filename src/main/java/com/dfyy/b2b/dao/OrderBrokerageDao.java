package com.dfyy.b2b.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.OrderBrokerage;

@Repository
public interface OrderBrokerageDao extends CrudRepository<OrderBrokerage, Integer>, JpaSpecificationExecutor<OrderBrokerage>{
	
	@Query("select u from OrderBrokerage as u where u.oid=?1 and u.status <> -1")
	public OrderBrokerage getByOid(int oid);
}
