package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.PartnerDealer;

@Repository
public interface PartnerDealerDao extends CrudRepository<PartnerDealer, Integer>, JpaSpecificationExecutor<Integer>  {

	@Query("select u from PartnerDealer u left join fetch u.dealer where u.status != -1 and u.pid = ?1")
	public List<PartnerDealer> getByPid(String pid);
	
	@Query("select u from PartnerDealer u left join fetch u.dealer where u.status != -1 and u.dealer.id = ?1")
	public PartnerDealer getByDid(String did);
}
