package com.dfyy.b2b.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.RegisterCode;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.dao.FunctionDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.UserDao;
import com.dfyy.b2b.dao.ZoneDao;
import com.dfyy.b2b.web.form.RetisterForm;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private SUserDao sUserDao;

	@Autowired
	private FunctionDao functionDao;

	@Autowired
	private ZoneDao zoneDao;

	@Autowired
	private RegisterCodeService codeService;

	public User register(RetisterForm form) {
		// TODO 增加其他的验证，用户名是否已存在，手机号码是否合法等
		if (!form.getPassword().equals(form.getPassword2())) {
			throw new RuntimeException("密码不匹配");
		}

		// 检测验证码是否正确
		RegisterCode rcode = codeService.findByPhoneAndCode(form.getPhone(), form.getCode());
		if (rcode == null) {
			throw new RuntimeException("此手机号无效，请获取正确的验证码");
		}

		SUser suser = sUserDao.getUserByPhone(form.getPhone());
		if(suser != null){
			throw new RuntimeException("该手机号已注册。");
		}

		String codeString = UUID.randomUUID().toString();
		
		//在种好地的用户表中创建用户
		
		//
		User user = new User();
		user.setId(codeString);
		user.setPhone(form.getPhone());
		user.setPassword(form.getPassword());
		// user.setAlias(alias);
		// user.setAddress(dto.getAddress());
		// user.setThumbnail(dto.getThumbnail());
		// user.setPoint(0);
		// user.setCurrency(0);
		// user.setTime(new Date());
		// user.setScoring(0.0);
		// user.setTjcoin(0);
		// user.setLevel(levelDao.findOne(1));
		userDao.save(user);
		return user;
	}

	public User findByPhone(String name) {
		User admin = userDao.findByPhone(name);
		return admin;
	}

	public User getById(String id) {
		User admin = userDao.findOne(id);
		return admin;
	}

	public void delete(String id) {
		User admin = userDao.findOne(id);
		admin.setStatus(-1);
		userDao.save(admin);
	}
}