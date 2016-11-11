package com.dfyy.b2b.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Account;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.dao.AccountDao;
import com.dfyy.b2b.dao.SUserDao;

@Service
@Transactional
public class AccountService {

	@Autowired
	private AccountDao dao;

	@Autowired
	private SUserDao userDao;

	public Account pay(String uid, int currency) {

		SUser user = userDao.findOne(uid);
		if (user.getCurrency() < currency) {
			throw new RuntimeException("已经超额");
		}

		Account account = new Account();
		account.setCurrency(currency);
		account.setPay(user);
		account.setStatus(0);
		account.setCode(UUID.randomUUID().toString());
		dao.save(account);
		return account;
	}

	public boolean checkPay(String uid) {
		List<Account> accounts = dao.findByUser(uid);
		if (accounts == null) {
			return true;
		} else {
			return false;
		}
	}

	public void cancelPay(String uid) {
		List<Account> accounts = dao.findByUser(uid);
		if (accounts != null && accounts.size() > 0) {
			for (Account account : accounts) {
				account.setStatus(-1);
				dao.save(account);
			}
		}
	}

	public Account payTransform(String incomeUser, String code) {
		Account account = dao.findByCode(code);
		if (account == null) {
			throw new RuntimeException("支付项目不存在或已完成入账操作");
		}

		SUser income = userDao.findOne(incomeUser);
		income.setCurrency(income.getCurrency() + account.getCurrency());
		userDao.save(income);

		SUser pay = account.getPay();
		pay.setCurrency(pay.getCurrency() - account.getCurrency());
		userDao.save(pay);

		account.setIncome(income);
		account.setTime(new Date());
		account.setStatus(1);
		dao.save(account);

		return account;
	}

	public List<Account> getByPage(int page, Integer size) {
		return dao.getByPage(new PageRequest(page, size));
	}

	public int getCount() {
		return dao.getCount();
	}

	public Account payTransform(String incomeUser, String payUser, int currency) {

		Account account = new Account();

		SUser income = userDao.findOne(incomeUser);
		income.setCurrency(income.getCurrency() + currency);
		userDao.save(income);

		SUser pay = userDao.findOne(payUser);
		pay.setCurrency(pay.getCurrency() - currency);
		userDao.save(pay);

		account.setPay(pay);
		account.setIncome(income);
		account.setCurrency(currency);
		account.setTime(new Date());
		account.setStatus(1);
		dao.save(account);

		return account;
	}
}
