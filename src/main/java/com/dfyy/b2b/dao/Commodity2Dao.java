package com.dfyy.b2b.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Commodity2;

@Repository
public interface Commodity2Dao extends CrudRepository<Commodity2, Integer>, JpaSpecificationExecutor<Commodity2> {
}
