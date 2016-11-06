package com.dfyy.b2b.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.NzdMember;

@Repository
public interface NzdMemberDao extends CrudRepository<NzdMember, Integer>, JpaSpecificationExecutor<Integer> {

	@Query("select u from NzdMember u left join fetch u.nzd left join fetch u.user where u.status != -1 and u.nzd.id = ?1")
	public List<NzdMember> getOfNzd(String nzd, Pageable page);

	@Query("select u from NzdMember u left join fetch u.nzd left join fetch u.user where u.status != -1 and u.nzd.id = ?1 and u.time <= ?2")
	public List<NzdMember> getOfNzd(String nzd, Date lasttime, Pageable page);

	@Query("select u from NzdMember u left join fetch u.nzd left join fetch u.user where u.status != -1 and u.user.id = ?1")
	public List<NzdMember> getOfUser(String user, Pageable page);

	@Query("select u from NzdMember u left join fetch u.nzd left join fetch u.user where u.status != -1 and u.user.id = ?1 and u.time <= ?2")
	public List<NzdMember> getOfUser(String user, Date lasttime, Pageable page);

	@Query("select u from NzdMember u left join fetch u.nzd left join fetch u.user where u.status != -1 and u.nzd.id = ?1 and u.user.id = ?2")
	public NzdMember getOfNzdAndUser(String nzd, String user);
}
