package com.dfyy.b2b.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.AppFile;

@Repository
public interface AppFileDao extends CrudRepository<AppFile, Integer>, JpaSpecificationExecutor<AppFile> {

}
