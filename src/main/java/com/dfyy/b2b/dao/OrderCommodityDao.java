//package com.dfyy.b2b.dao;
//
//import java.util.Date;
//import java.util.List;
//
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
//import org.springframework.data.jpa.repository.Query;
//import org.springframework.data.repository.CrudRepository;
//import org.springframework.stereotype.Repository;
//
//import com.dfyy.b2b.bussiness.OrderCommodity;
//
//@Repository
//public interface OrderCommodityDao extends CrudRepository<OrderCommodity, Integer>,
//		JpaSpecificationExecutor<OrderCommodity> {
//
//	@Query("select u from OrderCommodity as u left join fetch u.nzd  left join fetch u.commodity  where u.nzd.id = ?1 and u.status >= 0 order by u.time desc ")
//	public List<OrderCommodity> getByNzd(String userid, Pageable page);
//
//	@Query("select u from OrderCommodity as u left join fetch u.nzd  left join fetch u.commodity  where u.nzd.id = ?1 and u.time <= ?2 and u.status >= 0 order by u.time desc ")
//	public List<OrderCommodity> getByNzd(String userid, Date lasttime, Pageable page);
//}
