package com.dfyy.b2b.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Second;

@Repository
public interface SecondDao extends CrudRepository<Second, Integer>, JpaSpecificationExecutor<Second> {
	@Query("select u from Second as u left join fetch u.nzd  where u.nzd.id = ?1 and u.type = 2 order by u.time desc")
	public List<Second> getOfNzd(String nzd, Pageable pageable);

	@Query("select u from Second as u left join fetch u.nzd  where u.nzd.id = ?1 and u.type = 2 and u.time <= ?2 order by u.time desc")
	public List<Second> getOfNzd(String nzd, Date lasttime, Pageable pageable);
	
}
