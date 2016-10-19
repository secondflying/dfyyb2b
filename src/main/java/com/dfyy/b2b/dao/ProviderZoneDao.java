package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.ProviderZone;

@Repository
public interface ProviderZoneDao extends CrudRepository<ProviderZone, Integer>, JpaSpecificationExecutor<Integer> {

	@Query("select u from ProviderZone u left join fetch u.provider left join fetch u.area where u.status != -1 and u.provider.id = ?1")
	public List<ProviderZone> getByUid(String uid);
	
	@Query("select u from ProviderZone u left join fetch u.provider left join fetch u.area where u.status != -1 and u.area.id = ?2 and u.provider.id = ?1")
	public ProviderZone getByUidAndAid(String uid,int aid);
}
