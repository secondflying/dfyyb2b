package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.UserReview;

@Repository
public interface UserReviewDao extends CrudRepository<UserReview, Integer>, JpaSpecificationExecutor<Integer> {

	@Query("select u from UserReview u where u.uid = ?1 order by time DESC")
	public List<UserReview> getByUid(String uid);
	
}
