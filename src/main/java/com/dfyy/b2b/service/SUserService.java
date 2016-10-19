package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.dao.SUserDao;

@Service
@Transactional
public class SUserService {
	
	@Autowired
	private SUserDao sDao;
	public List<SUser> getAllNzd(String keyword, int page, int size) {
		return sDao.getAllNzd(keyword, new PageRequest(page, size));
	}

	public int getAllNzdCount(String keyword) {
		return sDao.getAllNzdCount(keyword);
	}
	
	public SUser getById(String id){
		return sDao.findOne(id);
	}

}
