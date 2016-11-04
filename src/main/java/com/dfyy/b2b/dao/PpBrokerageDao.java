package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.PpBrokerage;


@Repository
public interface PpBrokerageDao extends CrudRepository<PpBrokerage, Integer>, JpaSpecificationExecutor<Integer> {

	@Query(value="SELECT t.*,p.platform,p.partner,p.id as pid FROM b2b_commodity_type t left outer join b2b_pp_brokerage p on (t.id=p.cid and p.status=0) order by t.id asc",nativeQuery=true)//原生sql语句
	public List<Object> getByAllCrop();
	
	@Query("select u from PpBrokerage u left join fetch u.crop where u.status != -1 and u.crop.id = ?1")
	public PpBrokerage getByCid(int cid);
}
