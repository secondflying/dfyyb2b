package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Area;
@Repository
public interface AreaDao  extends CrudRepository<Area, Integer>, JpaSpecificationExecutor<Area> {
	@Query("select u from Area as u where u.name=?1")
	public Area getByName(String name);
	@Query("select u from Area as u where u.status <> -1")
	public List<Area> getAll();
	
}
