package com.dfyy.b2b.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Goodfarmingdic;

@Repository
public interface GoodfarmingdicDao  extends CrudRepository<Goodfarmingdic, Integer>, JpaSpecificationExecutor<Goodfarmingdic> {
	
	@Query("select u from Goodfarmingdic as u where u.name=?1")
	public Goodfarmingdic getByName(String name);
}
