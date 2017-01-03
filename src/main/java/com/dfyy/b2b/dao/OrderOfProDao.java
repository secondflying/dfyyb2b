package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.OrderOfPro;

@Repository
public interface OrderOfProDao extends CrudRepository<OrderOfPro, Integer>,
		JpaSpecificationExecutor<OrderOfPro> {

	@Query("select u from OrderOfPro as u left join fetch u.nzd  where u.cid = ?1 and (CURRENT_TIMESTAMP <= u.endtime ) order by u.endtime asc ")
	public List<OrderOfPro> getCommodityProtection(int cid);
}
