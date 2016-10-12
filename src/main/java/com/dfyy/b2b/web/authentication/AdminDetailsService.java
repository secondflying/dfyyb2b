package com.dfyy.b2b.web.authentication;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.Admin;
import com.dfyy.b2b.bussiness.Zone;
import com.dfyy.b2b.service.AdminService;

@Component
public class AdminDetailsService implements UserDetailsService {

	@Autowired
	private AdminService adminService;

	@Autowired
	private HttpServletRequest request;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Admin admin = adminService.getByName(username);
		if (admin == null) {
			throw new UsernameNotFoundException("用户不存在");
		}
		
		return new AdminUserDetails(admin, null);

//		String zoneObject = request.getParameter("zone");
//		if (zoneObject == null) {
//			throw new UsernameNotFoundException("未选择区域");
//		}
//
//		int zone = Integer.parseInt(zoneObject.toString());
//
//		String name = admin.getName();
//		List<Zone> zones = name.equals("king") ? adminService.getAllZone() : admin.getZones();
//		for (Zone zone2 : zones) {
//			if (zone2.getId() == zone) {
//				return new AdminUserDetails(admin, zone2);
//			}
//		}
//		throw new SessionAuthenticationException("无当前区域操作权限");
	}

}
