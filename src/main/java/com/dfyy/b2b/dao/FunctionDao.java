package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Function;

@Repository
public interface FunctionDao extends CrudRepository<Function, Integer>, JpaSpecificationExecutor<Function> {

	@Query("select u from Function u order by id")
	public List<Function> getAll();
}
