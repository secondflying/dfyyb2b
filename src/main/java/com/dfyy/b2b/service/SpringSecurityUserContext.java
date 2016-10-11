package com.dfyy.b2b.service;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.web.authentication.B2BUserDetails;

@Component
public class SpringSecurityUserContext implements UserContext {

	@Override
	public User getCurrentUser() {
		// TODO Auto-generated method stub
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		if (authentication == null) {
			return null;
		}
		B2BUserDetails b2bUserDetails = (B2BUserDetails)authentication.getPrincipal();
		User user  = new User();
		user.setId(b2bUserDetails.getId());
		user.setPassword(b2bUserDetails.getPassword());
		user.setPhone(b2bUserDetails.getName());
		user.setStatus(b2bUserDetails.getStatus());
		return user;
	}

	@Override
	public void setCurrentUser(User user) {
		// TODO Auto-generated method stub
		if (user == null) {
			throw new IllegalArgumentException("user cannot be null");
		}
		B2BUserDetails userDetails = new B2BUserDetails(user);
		UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
				userDetails, userDetails.getPassword(),
				userDetails.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authentication);
	}

}
