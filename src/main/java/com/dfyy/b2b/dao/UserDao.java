package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import com.dfyy.b2b.bussiness.User;
import java.lang.String;

@Repository
public interface UserDao extends CrudRepository<User, String>, JpaSpecificationExecutor<String> {

	@Query("select u from User u left join fetch u.type left join fetch u.zone where u.status != -1")
	public List<User> getAll(Pageable pageable);
	
	@Query("select u from User u left join fetch u.type left join fetch u.zone where u.status =?1 and (u.alias like %?2% or u.phone like %?2%) order by time DESC")
	public List<User> findByStatus(int status,String keyword,Pageable pageable);

	@Query("select u from User u left join fetch u.type left join fetch u.zone where u.phone=?1 and u.status != -1")
	public User findByPhone(String name);

	@Query("select count(u) from User u where u.status != -1")
	public int getCount();
	
	@Query("select count(u) from User u where u.status = ?1 and (u.alias like %?2% or u.phone like %?2%)")
	public int getCountByStatus(int status,String keyword);

}
