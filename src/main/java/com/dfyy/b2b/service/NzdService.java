package com.dfyy.b2b.service;

import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.NzdMember;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.SalesmanStore;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.bussiness.UserToken;
import com.dfyy.b2b.dao.NzdMemberDao;
import com.dfyy.b2b.dao.SUserDao;
import com.dfyy.b2b.dao.SalesmanStoreDao;
import com.dfyy.b2b.dao.UserDao;
import com.dfyy.b2b.dao.UserTokenDao;
import com.dfyy.b2b.dto.NzdMembersResult;
import com.dfyy.b2b.dto.UserFullDto;

@Service
@Transactional
public class NzdService {

	@Autowired
	private SUserDao sUserDao;
	
	@Autowired
	private UserDao userDao;

	@Autowired
	private UserTokenDao tokenDao;

	@Autowired
	private NzdMemberDao nzdMemberDao;

	@Autowired
	private SalesmanStoreDao salesmanStoreDao;

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

	/**
	 * 获取农资店详情
	 * 
	 * @param userid
	 * @return
	 */
	public SUser getByID(String userid) {
		SUser suser1 = sUserDao.findOne(userid);
		return suser1;
	}

	
	public boolean checkByAlias(String alias) {
		int count = sUserDao.findByAlias(alias);
		return count > 0;
	}
	
	
	public SUser update(String uid, UserFullDto dto) {
		SUser user = sUserDao.findOne(uid);
		if (user != null) {
			user.setThumbnail(dto.getThumbnail());
			user.setDescription(dto.getDescription());
			user.setAlias(dto.getAlias());
			user.setAddress(dto.getAddress());
			sUserDao.save(user);
		}
		return user;
	}

	/**
	 * 创建用户token
	 * 
	 * @param userid
	 * @param phone
	 * @return
	 */
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

	public NzdMembersResult myMembers(String nzd, int page, long time) {
		NzdMembersResult result = new NzdMembersResult();
		if (page == 0) {
			List<NzdMember> list = nzdMemberDao.getOfNzd(nzd, new PageRequest(page, 20));
			result.setResults(list);
			result.setLastTime(new Date().getTime());
		} else {
			List<NzdMember> list = nzdMemberDao.getOfNzd(nzd, new Date(time), new PageRequest(page, 20));
			result.setResults(list);
			result.setLastTime(time);
		}
		return result;
	}

	public User salesman(String nzd) {
		SalesmanStore store = salesmanStoreDao.getBySid(nzd);
		if(store!= null){
			return userDao.findOne(store.getUid());
		}
		return null;
	}

}
