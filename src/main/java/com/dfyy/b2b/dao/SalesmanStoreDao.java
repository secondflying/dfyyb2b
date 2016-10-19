package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.SalesmanStore;

@Repository
public interface SalesmanStoreDao extends CrudRepository<SalesmanStore, Integer>, JpaSpecificationExecutor<Integer> {

	@Query("select u from SalesmanStore u left join fetch u.store where u.status != -1 and u.uid = ?1")
	public List<SalesmanStore> getByUid(String uid);
	
	@Query("select u from SalesmanStore u left join fetch u.store where u.status != -1 and u.store.id = ?1")
	public SalesmanStore getBySid(String sid);
	
}
