package com.dfyy.b2b.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dfyy.b2b.bussiness.AppFile;
import com.dfyy.b2b.dao.AppFileDao;

@Service
public class AppFileService {

	@Autowired
	private AppFileDao dao;
	
	public AppFile getById(int id) {
		AppFile appFile = dao.findOne(id);
		return appFile;
	}
	
	
}
