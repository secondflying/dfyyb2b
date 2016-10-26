package com.dfyy.b2b.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.UserToken;

@Repository
public interface UserTokenDao extends CrudRepository<UserToken, String>, JpaSpecificationExecutor<UserToken> {

	@Query("select u from UserToken as u where u.uid = ?1")
	public UserToken findByUserID(String uid);

	@Query("select u from UserToken as u where u.uid = ?1 and u.token = ?2")
	public UserToken findByUserIDAndToken(String uid,String token);

}
