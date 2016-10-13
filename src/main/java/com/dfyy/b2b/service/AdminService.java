package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Admin;
import com.dfyy.b2b.bussiness.Function;
import com.dfyy.b2b.bussiness.Zone;
import com.dfyy.b2b.dao.AdminDao;
import com.dfyy.b2b.dao.FunctionDao;
import com.dfyy.b2b.dao.ZoneDao;

@Service
@Transactional
public class AdminService {

	@Autowired
	private AdminDao dao;

	@Autowired
	private FunctionDao functionDao;

	@Autowired
	private ZoneDao zoneDao;

	/**
	 * 获取超级管理员以外的所有管理员账户
	 * @param page
	 * @param size
	 * @return
	 */
	public List<Admin> getAllAdmins(int page, int size) {
		List<Admin> admins = dao.getAll(new PageRequest(page, size));
		for (Admin admin : admins) {
			List<Function> functions = admin.getFunctions();
			for (Function function : functions) {
			}

			List<Zone> zones = admin.getZones();
			for (Zone zone : zones) {
			}
		}
		return admins;
	}

	/**
	 * 获取超级管理员之外的其他管理员数量
	 * @return
	 */
	public int getAllCount() {
		return dao.getCount();
	}

	/**
	 * 根据用户名获取管理员账户
	 * @param name
	 * @return
	 */
	public Admin getByName(String name) {
		Admin admin = dao.findByName(name);
		List<Function> functions = admin.getFunctions();
		for (Function function : functions) {
			// System.out.println(function.getName());
		}
		List<Zone> zones = admin.getZones();
		for (Zone zone : zones) {
		}
		return admin;
	}

	/**
	 * 根据id获取管理员账户
	 * @param id
	 * @return
	 */
	public Admin getById(Integer id) {
		Admin admin = dao.findOne(id);
		List<Function> functions = admin.getFunctions();
		for (Function function : functions) {
			// System.out.println(function.getName());
		}
		List<Zone> zones = admin.getZones();
		for (Zone zone : zones) {
		}
		return admin;
	}

	/**
	 * 创建一个新的管理员
	 * @param name
	 * @param password
	 * @return
	 */
	public Admin createAdmin(String name, String password) {
		Admin admin = new Admin();
		admin.setName(name);
		admin.setPassword(password);
		admin.setStatus(1);
		dao.save(admin);
		return admin;
	}

	/**
	 * 删除管理员
	 * @param id
	 */
	public void delete(Integer id) {
		Admin admin = dao.findOne(id);
		admin.setStatus(-1);
		dao.save(admin);
	}

	/**
	 * 获取所有权限
	 * @return
	 */
	public List<Function> getAllFunctions() {
		return functionDao.getAll();
	}

	/**
	 * 给用户增加权限
	 * @param uid
	 * @param functions
	 */
	public void addFunction(Integer uid, List<Integer> functions) {
		// 给用户加权限
		Admin admin = dao.findOne(uid);
		if (admin != null) {
			admin.getFunctions().clear();
			for (Integer fid : functions) {
				admin.getFunctions().add(functionDao.findOne(fid));
			}
			dao.save(admin);
		}
	}

	/**
	 * 获取所有区域
	 * @return
	 */
	public List<Zone> getAllZone() {
		return zoneDao.getAll();
	}

	/**
	 * 给用户配置区域
	 * @param uid
	 * @param zones
	 */
	public void addZone(Integer uid, List<Integer> zones) {
		// 给用户加权限
		Admin admin = dao.findOne(uid);
		if (admin != null) {
			admin.getFunctions().clear();
			for (Integer fid : zones) {
				admin.getZones().add(zoneDao.findOne(fid));
			}
			dao.save(admin);
		}
	}

	/**
	 * 更新管理员账户信息
	 * @param admin
	 */
	public void updateAdmin(Admin admin) {
		dao.save(admin);
	}
}
