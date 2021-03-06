package com.dfyy.b2b.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Commodity;

@Repository
public interface CommodityDao extends CrudRepository<Commodity, Integer>, JpaSpecificationExecutor<Commodity> {
	
	@Query("select u from Commodity as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.status = 3 order by u.time desc ")
	public List<Commodity> getOnline(Pageable page);
	@Query("select u from Commodity as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.status = 3 and u.time <= ?1  order by u.time desc ")
	public List<Commodity> getOnline(Date lasttime,Pageable page);	
	
	@Query("select u from Commodity as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.provider.id=?1 and u.status <> -1 order by u.time desc ")
	public List<Commodity> getByUser(String userid,Pageable page);
	
	@Query("select count(u) from Commodity as u where u.provider.id=?1 and u.status <> -1")
	public int getCountByUser(String userid);
	
	@Query("select u from Commodity as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.status = ?1 order by u.time desc ")
	public List<Commodity> getByStatus(int status,Pageable page);
	
	@Query("select count(u) from Commodity as u where u.status = ?1")
	public int getCountByStatus(int status);
	
	@Query("select u from Commodity as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.status = ?2 and u.name like %?1% order by u.time desc ")
	public List<Commodity> searchByStatus(String key,int status,Pageable page);
	
	@Query("select count(u) from Commodity as u where u.status = ?2 and u.name like %?1%")
	public int searchCountByStatus(String key,int status);
	
	@Query("select u from Commodity as u left join fetch u.provider left join fetch u.type left join fetch u.unit where u.provider.id in ?1 and u.status = 0 order by u.time desc ")
	public List<Commodity> getInformalByDealers(List<String> uids,Pageable page);
	
	@Query("select count(u) from Commodity as u where u.provider.id in ?1 and u.status = 0")
	public int getInformalCountByDealers(List<String> uids);
}
