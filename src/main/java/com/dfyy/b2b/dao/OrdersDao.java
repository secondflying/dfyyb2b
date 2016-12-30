package com.dfyy.b2b.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Orders;

@Repository
public interface OrdersDao extends CrudRepository<Orders, Integer>, JpaSpecificationExecutor<Orders> {

	@Query("select u from Orders as u left join fetch u.nzd  left join fetch u.commodity  where u.nzd.id = ?1 and u.status >= 0 order by u.time desc ")
	public List<Orders> getByNzd(String nzd, Pageable page);

	@Query("select u from Orders as u left join fetch u.nzd  left join fetch u.commodity  where u.nzd.id = ?1 and u.time <= ?2 and u.status >= 0 order by u.time desc ")
	public List<Orders> getByNzd(String nzd, Date lasttime, Pageable page);
	
	@Query("select count(*) from Orders as u where u.nzd.id = ?1 and u.status >= 0 ")
	public int getCountByNzd(String nzd);

	@Query("select u from Orders as u left join fetch u.nzd  left join fetch u.commodity  where u.nzd.id = ?1 and u.commodity.id = ?2 and u.status = 3 order by u.time desc ")
	public List<Orders> getNzdBuyCommodity(String nzd, int cid, Pageable page);

	@Query("select u from Orders as u left join fetch u.nzd  left join fetch u.commodity  where u.nzd.id = ?1 and u.commodity.id = ?2 and u.time <= ?3 and u.status = 3 order by u.time desc ")
	public List<Orders> getNzdBuyCommodity(String nzd, int cid, Date lasttime, Pageable page);

	@Query("select u from Orders as u left join fetch u.nzd  left join fetch u.commodity  where u.commodity.provider.id in (?1) order by u.time desc ")
	public List<Orders> getByProvider(String[] userids, Pageable page);

	@Query("select count(*) from Orders as u where u.commodity.provider.id in (?1) ")
	public int getCountByProvider(String[] userids);
	
	
	@Query("select u from Orders as u left join fetch u.nzd  left join fetch u.commodity  where u.nzd.id in (?1) order by u.time desc ")
	public List<Orders> getBySalesman(String[] userids, Pageable page);

	@Query("select count(*) from Orders as u where u.nzd.id in (?1) ")
	public int getCountBySalesman(String[] userids);

	/**
	 * 已确认收获的订单列表
	 * 
	 * @param userids
	 * @param page
	 * @return
	 */
	@Query("select u from Orders as u left join fetch u.nzd  left join fetch u.commodity  where u.commodity.provider.id in (?1) and u.status = 3  order by u.time desc ")
	public List<Orders> getConfirmedOfProvider(String[] userids, Pageable page);

	@Query("select count(*) from Orders as u where u.commodity.provider.id in (?1)  and u.status = 3")
	public int getConfirmedOfProviderCount(String[] userids);
	
	/**
	 * 获取快到保护期的订单列表
	 * @param userids
	 * @param page
	 * @return
	 */
	@Query("select u from Orders as u left join fetch u.nzd  left join fetch u.commodity  where u.commodity.provider.id in (?1) and u.status = 3  and u.endtime < ?2  order by u.time desc ")
	public List<Orders> getNearProtectionOfProvider(String[] userids, Date end, Pageable page);

	@Query("select count(*) from Orders as u where u.commodity.provider.id in (?1)  and u.status = 3 and u.endtime < ?2")
	public int getNearProtectionOfProviderCount(String[] userids, Date end);

	
	/**
	 * 获取已送达订单超过7天的订单，
	 */
	@Query("select u from Orders as u where u.status = 2 and u.alterTime <= ?1")
	public List<Orders> getHasArrival(Date end);
	
	
	/**
	 * 获取保护期快到的
	 * @param userids
	 * @param end
	 * @param page
	 * @return
	 */
	@Query("select u from Orders as u left join fetch u.nzd  left join fetch u.commodity  where u.status = 3  and u.endtime <= ?2 and u.sendmsg <>1 order by u.time desc ")
	public List<Orders> getNearProtectionOfProvider( Date end);
}
