package com.dfyy.b2b.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.CommodityOfNzd;

@Repository
public interface CommodityOfNzdDao extends CrudRepository<CommodityOfNzd, Integer>,
		JpaSpecificationExecutor<CommodityOfNzd> {

	@Query("select u from CommodityOfNzd as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.status = 3 and u.nzd=?1 order by u.buytime desc ")
	public List<CommodityOfNzd> getNzdBuyed(String nzd, Pageable page);

	@Query("select u from CommodityOfNzd as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.status = 3 and u.nzd=?1 and u.buytime <= ?2  order by u.buytime desc ")
	public List<CommodityOfNzd> getNzdBuyed(String nzd, Date lasttime, Pageable page);
	
	@Query("select count(*) from CommodityOfNzd as u where u.status = 3 and u.nzd=?1")
	public int getCountNzdBuyed(String nzd);

}
