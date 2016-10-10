package com.dfyy.b2b.dao;

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
}
