package com.dfyy.b2b.dao;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.OrdersInventory;

@Repository
public interface OrdersInventoryDao extends CrudRepository<OrdersInventory, Integer>,
		JpaSpecificationExecutor<OrdersInventory> {

	@Query("select u from OrdersInventory as u  where u.nzd = ?1 and u.cid = ?2 ")
	public OrdersInventory getCommodityInventory(String nzd, int cid);

}
