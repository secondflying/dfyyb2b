package com.dfyy.b2b.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.RegisterCode;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.bussiness.UserDoc;
import com.dfyy.b2b.dao.FunctionDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.UserDao;
import com.dfyy.b2b.dao.UserDocDao;
import com.dfyy.b2b.dao.ZoneDao;
import com.dfyy.b2b.util.PublicHelper;
import com.dfyy.b2b.web.form.RetisterForm;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private UserDocDao docDao;

	@Autowired
	private SUserDao sUserDao;

	@Autowired
	private FunctionDao functionDao;

	@Autowired
	private ZoneDao zoneDao;

	@Autowired
	private RegisterCodeService codeService;

	/**
	 * 用户注册
	 * @param form
	 * @return
	 */
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

		SUser suser1 = sUserDao.getUserByPhone(form.getPhone());
		if (suser1 != null) {
			throw new RuntimeException("该手机号已注册。");
		}

		String codeString = UUID.randomUUID().toString();

		// 在种好地的用户表中创建用户

		SUser suser = new SUser();
		suser.setId(codeString);
		suser.setPhone(form.getPassword());
		// suser.setPassword(form.getPassword());
		suser.setAlias("");
		suser.setAddress("");
		suser.setThumbnail("");
		suser.setPoint(0);
		suser.setCurrency(0);
		suser.setTime(new Date());
		suser.setScoring(0.0);
		suser.setTjcoin(0);
		suser.setLevelID(1);

		// 生成唯一推荐码
		String code = PublicHelper.generateCode();
		while (true) {
			if (sUserDao.getUserByTjCode(code) == null) {
				suser.setTjcode(code);
				break;
			}
			code = PublicHelper.generateCode();
		}

		sUserDao.save(suser);

		// 在b2b的用户表中创建用户
		User user = new User();
		user.setId(codeString);
		user.setPhone(form.getPhone());
		user.setPassword(form.getPassword());
		user.setStatus(0);
		// user.setLevel(levelDao.findOne(1));
		userDao.save(user);
		return user;
	}
	
	/**
	 * 获取正式用户
	 * @param pageable
	 * @return
	 */
	public List<User> getFormal(String key,Pageable pageable){
		return userDao.findByStatus(1,key, pageable);
	}
	
	/**
	 * 获取待审核的用户
	 * @param pageable
	 * @return
	 */
	public List<User> getInformal(String key,Pageable pageable){
		return userDao.findByStatus(0,key, pageable);
	}
	
	/**
	 * 获取指定状态的用户个数
	 * @param status
	 * @return
	 */
	public int getCountByStatus(int status,String key){
		return userDao.getCountByStatus(status,key);
	}
	
	/**
	 * 获取不同类型的用户
	 * @param type
	 * @param key
	 * @param pageable
	 * @return
	 */
	public List<User> getByType(int type,String key,Pageable pageable){
		return userDao.findByType(type, key, pageable);
	}
	
	/**
	 * 获取指定类型的用户个数
	 * @param status
	 * @return
	 */
	public int getCountByType(int type,String key){
		return userDao.getCountByType(type, key);
	}

	/**
	 * 通过手机号获取用户信息
	 * @param name
	 * @return
	 */
	public User findByPhone(String name) {
		User admin = userDao.findByPhone(name);
		return admin;
	}

	/**
	 * 根据id获取用户
	 * @param id
	 * @return
	 */
	public User getById(String id) {
		User admin = userDao.findOne(id);
		admin.setDocs(docDao.getByUser(admin.getId()));
		return admin;
	}

	/**
	 * 删除用户
	 * @param id
	 */
	public void delete(String id) {
		User admin = userDao.findOne(id);
		admin.setStatus(-1);
		userDao.save(admin);
	}
	
	/**
	 * 更新用户信息
	 * @param user
	 */
	public void update(User user){
		userDao.save(user);
	}
	
	/**
	 * 存储用户资料
	 * @param doc
	 */
	public void saveDoc(UserDoc doc){
		docDao.save(doc);
	}
	/**
	 * 删除用户资料
	 * @param id
	 */
	public void deleteDoc(int id){
		docDao.delete(id);
	}
}
