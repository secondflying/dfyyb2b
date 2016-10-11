package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import com.dfyy.b2b.bussiness.UserDoc;
@Repository
public interface UserDocDao extends CrudRepository<UserDoc, Integer>,JpaSpecificationExecutor<UserDoc>  {

	@Query("select u from UserDoc as u where u.uid = ?1")
	public List<UserDoc> getByUser(String userID);
	
}
