package com.dfyy.b2b.dao;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.dfyy.b2b.bussiness.Account;

@Repository
public interface AccountDao extends CrudRepository<Account, Integer>, JpaSpecificationExecutor<Account> {

	@Query("select u from Account u left join fetch u.pay left join fetch u.income where u.code=?1 and u.status=0")
	public Account findByCode(String code);

	@Query("select u from Account u left join fetch u.pay left join fetch u.income where u.pay.id=?1 and u.status=0")
	public List<Account> findByUser(String userid);

	@Query("select u from Account u left join fetch u.pay left join fetch u.income where u.pay.id=?1 and u.status=1")
	public List<Account> findByPay(String payid);

	@Query("select u from Account u left join fetch u.pay left join fetch u.income where u.income.id=?1 and u.status=1")
	public List<Account> findByIncome(String incomeid);

	@Query("select u from Account u left join fetch u.pay left join fetch u.income where (u.pay.id=?1 or u.income.id=?1 ) and u.status=1")
	public List<Account> myAccount(String user);
	
	@Query("select u from Account u left join fetch u.pay left join fetch u.income  where u.status = 1 order by u.time desc")
	public List<Account> getByPage(Pageable pageable);
	
	@Query("select count(u) from Account u where u.status = 1 ")
	public int getCount();
}
