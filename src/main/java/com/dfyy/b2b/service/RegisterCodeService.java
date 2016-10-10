package com.dfyy.b2b.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.RegisterCode;
import com.dfyy.b2b.dao.RegisterCodeDao;

@Service
@Transactional
public class RegisterCodeService {

	@Autowired
	private RegisterCodeDao dao;

	public RegisterCode add(String phone, String code) {

		RegisterCode rc = dao.findByPhoneAndCode(phone, code);
		if (rc != null) {
			return rc;
		}

		rc = new RegisterCode();
		rc.setPhone(phone);
		rc.setCode(code);
		rc.setTime(new Date());
		rc.setStatus(0);
		dao.save(rc);
		return rc;
	}
	
	public List<RegisterCode> findByPhone(String phone) {
		return dao.findByPhone(phone);
	}

	public RegisterCode findByPhoneAndCode(String phone, String code) {
		return dao.findByPhoneAndCode(phone, code);
	}

}
