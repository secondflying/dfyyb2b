package com.dfyy.b2b.web.authentication;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.service.UserService;

@Component("b2bUserDetailsService")
public class B2BUserDetailsService implements UserDetailsService {

	@Autowired
	private UserService adminService;

	@Autowired
	private HttpServletRequest request;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User admin = adminService.findByPhone(username);
		if (admin == null) {
			throw new UsernameNotFoundException("用户不存在");
		}

		return new B2BUserDetails(admin);
	}

}
