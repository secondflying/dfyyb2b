package com.dfyy.b2b.service;

import java.security.NoSuchAlgorithmException;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.UserToken;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.UserTokenDao;

@Service
@Transactional
public class NzdService {

	@Autowired
	private SUserDao sUserDao;

	@Autowired
	private UserTokenDao tokenDao;

	/**
	 * 农资店用户登录
	 * 
	 * @param form
	 * @return
	 */
	public SUser login(String phone, String password) {

		SUser suser1 = sUserDao.getNzdByPhoneAndPassword(phone, password);
		if (suser1 == null) {
			throw new RuntimeException("手机号，密码不匹配，无法登录");
		}
		return suser1;
	}

	public SUser getByID(String userid) {
		SUser suser1 = sUserDao.findOne(userid);
		return suser1;
	}

	public String createUserToken(String userid, String phone) {

		UserToken userToken = tokenDao.findByUserID(userid);
		if (userToken == null) {
			userToken = new UserToken();
			userToken.setUid(userid);
			userToken.setTime(new Date());

			String token = userid + "_" + phone;

			try {
				java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
				byte[] array = md.digest(token.getBytes());
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < array.length; ++i) {
					sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
				}
				token = sb.toString();
			} catch (NoSuchAlgorithmException e) {
			}
			userToken.setToken(token);

		} else {
			userToken.setTime(new Date());
		}

		tokenDao.save(userToken);

		return userToken.getToken();
	}

}
