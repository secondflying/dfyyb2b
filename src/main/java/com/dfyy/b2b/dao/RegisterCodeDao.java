package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.RegisterCode;

@Repository
public interface RegisterCodeDao extends CrudRepository<RegisterCode, Integer>, JpaSpecificationExecutor<RegisterCode> {

	@Query("select u from RegisterCode u where u.phone = ?1")
	public List<RegisterCode> findByPhone(String phone);

	@Query("select u from RegisterCode u where u.phone = ?1 and u.code = ?2")
	public RegisterCode findByPhoneAndCode(String phone, String code);
}
