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
	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is not null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x, Pageable page);

	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is not null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) and u.time <= ?4  order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x, Date lasttime, Pageable page);
	
	
	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.type in (?4) and ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is not null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x,List<Integer> subs, Pageable page);

	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.type in (?4) and ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is not null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) and u.time <= ?5  order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x,List<Integer> subs,  Date lasttime, Pageable page);
	
	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.name like %?4% and ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is not null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x, String key, Pageable page);

	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.name like %?4% and ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is not null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) and u.time <= ?5  order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x, String key, Date lasttime, Pageable page);
	
	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.type in (?4) and u.name like %?5% and ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is not null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x,List<Integer> subs, String key, Pageable page);

	@Query("select u from CommodityOfPro as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.type in (?4) and u.name like %?5% and ((u.endtime is null) or (u.endtime is not null and CURRENT_TIMESTAMP > u.endtime ) or (u.nid is null) or (u.nid = ?1) or (u.nid is not null and u.nid <> ?1 and GETDISTANCE(?2,?3,u.y,u.x) > u.radius)) and u.time <= ?6  order by u.time desc ")
	public List<CommodityOfPro> getOnline(String nzd, double y, double x,List<Integer> subs, String key, Date lasttime, Pageable page);
}
