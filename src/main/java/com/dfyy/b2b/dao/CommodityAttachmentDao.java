package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.CommodityAttachment;

@Repository
public interface CommodityAttachmentDao extends CrudRepository<CommodityAttachment, Integer>,
		JpaSpecificationExecutor<CommodityAttachment> {

	@Query("select u from CommodityAttachment u where u.cid=?1")
	public List<CommodityAttachment> getByCommodity(Integer aid);

	@Query("delete from CommodityAttachment as u where u.cid = ?1")
	@Modifying()
	public int deleteByCommodity(Integer cid);
}
