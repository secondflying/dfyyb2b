package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.SUser;

@Repository
public interface SUserDao extends CrudRepository<SUser, String>, JpaSpecificationExecutor<SUser> {

	@Query("select u from SUser as u where u.phone = ?1")
	public SUser getUserByPhone(String phone);

	@Query("select u from SUser as u where u.tjcode = ?1")
	public SUser getUserByTjCode(String tjcode);
	
	@Query("select u from SUser as u where u.levelID = 3 and (u.alias like %?1% or u.phone like %?1%) order by u.time")
	public List<SUser> getAllNzd(String keyword, Pageable pageable);
	
	@Query("select count(u) from SUser as u where u.levelID = 3 and (u.alias like %?1% or u.phone like %?1%) ")
	public int getAllNzdCount(String keyword);
	
	@Query("select u from SUser as u where u.levelID = 3 and u.phone = ?1 and u.password = ?2 ")
	public SUser getNzdByPhoneAndPassword(String phone, String password);
}
