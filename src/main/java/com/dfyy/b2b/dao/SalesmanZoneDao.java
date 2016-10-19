package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.SalesmanZone;

@Repository
public interface SalesmanZoneDao extends CrudRepository<SalesmanZone, Integer>, JpaSpecificationExecutor<Integer> {

	@Query("select u from SalesmanZone u left join fetch u.salesman left join fetch u.area where u.status != -1 and u.salesman.id = ?1")
	public List<SalesmanZone> getByUid(String uid);
	
	@Query("select u from SalesmanZone u left join fetch u.salesman left join fetch u.area where u.status != -1 and u.area.id = ?1")
	public List<SalesmanZone> getByAid(int aid);
	
	@Query("select u from SalesmanZone u left join fetch u.salesman left join fetch u.area where u.status != -1 and u.area.id = ?2 and u.salesman.id = ?1")
	public SalesmanZone getByUidAndAid(String uid,int aid);
	
}
