package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import com.dfyy.b2b.bussiness.User;

@Repository
public interface UserDao extends CrudRepository<User, String>, JpaSpecificationExecutor<String> {

	@Query("select u from User u where u.status != -1")
	public List<User> getAll(Pageable pageable);

	@Query("select u from User u where u.phone=?1 and u.status != -1")
	public User findByPhone(String name);

	@Query("select count(u) from User u where u.status != -1")
	public int getCount();

}
