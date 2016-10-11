package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.dfyy.b2b.bussiness.UserType;

public interface UserTypeDao extends CrudRepository<UserType,Integer> , JpaSpecificationExecutor<UserType>{

	@Query("select u from UserType u  where u.status = 0 order by seq ASC")
	public List<UserType> getAll();
	
	@Query("select u from UserType u  where u.status = 0 and u.id!=4 order by seq ASC")
	public List<UserType> getProviders();
}
