package com.dfyy.b2b.web.authentication;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public class LoginUtil {

	public static B2BUserDetails getLoginUser() {
		Authentication login = SecurityContextHolder.getContext().getAuthentication();
		if (login != null) {
			B2BUserDetails user = (B2BUserDetails) login.getPrincipal();
			return user;
		}
		return null;
	}

}
