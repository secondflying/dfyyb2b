package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.SecondAttachment;

@Repository
public interface SecondAttachmentDao extends CrudRepository<SecondAttachment, Integer>,
		JpaSpecificationExecutor<SecondAttachment> {

	@Query("select u from SecondAttachment u where u.sid=?1")
	public List<SecondAttachment> getBySecond(Integer sid);

	@Query("delete from SecondAttachment as u where u.sid = ?1")
	@Modifying()
	public int deleteBySecond(Integer aid);
}
