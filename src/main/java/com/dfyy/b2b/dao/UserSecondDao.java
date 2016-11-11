package com.dfyy.b2b.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.UserSecond;

@Repository
public interface UserSecondDao extends CrudRepository<UserSecond, Integer>, JpaSpecificationExecutor<UserSecond> {

	@Query("select u from UserSecond as u left join fetch u.user left join fetch u.second left join fetch u.nzd left join fetch u.contact where u.second.nzd.id = ?1 and u.second.type = 2 order by u.time desc")
	public List<UserSecond> getOrdersOfNzd(String nzd, Pageable pageable);

	@Query("select u from UserSecond as u left join fetch u.user left join fetch u.second left join fetch u.nzd left join fetch u.contact where u.second.nzd.id = ?1 and u.second.type = 2  and u.time <= ?2 order by u.time desc")
	public List<UserSecond> getOrdersOfNzd(String nzd, Date lasttime, Pageable pageable);

	@Query("select u from UserSecond as u left join fetch u.user left join fetch u.second left join fetch u.nzd left join fetch u.contact where u.second.nzd.id = ?1 and u.second.id = ?2 and u.second.type = 2 order by u.time desc")
	public List<UserSecond> getSellHistory(String nzd, int sid, Pageable pageable);

	@Query("select u from UserSecond as u left join fetch u.user left join fetch u.second left join fetch u.nzd left join fetch u.contact where u.second.nzd.id = ?1 and u.second.id = ?2 and u.second.type = 2  and u.time <= ?2 order by u.time desc")
	public List<UserSecond> getSellHistory(String nzd, int sid, Date lasttime, Pageable pageable);
	
	
	@Query("select u from UserSecond as u left join fetch u.user left join fetch u.second left join fetch u.nzd left join fetch u.contact where u.second.nzd.id = ?1 and u.second.id in (?2) and u.second.type = 2 order by u.time desc")
	public List<UserSecond> getSellHistory(String nzd, int[] sids, Pageable pageable);

	@Query("select u from UserSecond as u left join fetch u.user left join fetch u.second left join fetch u.nzd left join fetch u.contact where u.second.nzd.id = ?1 and u.second.id in (?2) and u.second.type = 2  and u.time <= ?2 order by u.time desc")
	public List<UserSecond> getSellHistory(String nzd, int[] sids, Date lasttime, Pageable pageable);

	@Query("select u from UserSecond as u left join fetch u.user left join fetch u.second left join fetch u.nzd left join fetch u.contact where u.second.nzd.id = ?1 and u.id = ?2 and u.second.type = 2")
	public UserSecond getSellOrder(String nzd, int oid);
}
