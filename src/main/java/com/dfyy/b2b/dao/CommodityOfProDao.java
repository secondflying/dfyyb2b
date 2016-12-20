package com.dfyy.b2b.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.CommodityOfPro;

@Repository
public interface CommodityOfProDao extends CrudRepository<CommodityOfPro, Integer>,
		JpaSpecificationExecutor<CommodityOfPro> {
	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x, Pageable page);

	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) and u.time <= ?4  order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x, Date lasttime, Pageable page);
}
