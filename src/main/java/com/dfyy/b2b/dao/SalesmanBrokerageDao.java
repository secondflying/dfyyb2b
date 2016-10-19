package com.dfyy.b2b.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.SalesmanBrokerage;

@Repository
public interface SalesmanBrokerageDao extends CrudRepository<SalesmanBrokerage, Integer>, JpaSpecificationExecutor<Integer> {

	@Query("select u from SalesmanBrokerage u where u.status != -1")
	public SalesmanBrokerage getvalue();
	
}
