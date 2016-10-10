package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Zone;

@Repository
public interface ZoneDao extends CrudRepository<Zone, Integer>, JpaSpecificationExecutor<Zone> {
	@Query("select u from Zone u  where u.online = 1 order by seq ASC")
	public List<Zone> getAll();
}
