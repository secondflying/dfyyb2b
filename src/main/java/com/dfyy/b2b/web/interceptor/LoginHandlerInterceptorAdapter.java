/**
 * 
 */
package com.dfyy.b2b.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.web.authentication.B2BUserDetails;

/**
 * Copyright © 2015 Geoway. All rights reserved.
 * 
 * @Title: HandlerInterceptorAdapter.java
 * @Prject: press-core
 * @Package: com.geoway.press.core.support.interceptor
 * @Description: 登陆拦截器
 * @author: daidd
 * @date: 2015年9月25日 下午3:38:02
 * @version: V1.0
 */
public class LoginHandlerInterceptorAdapter extends HandlerInterceptorAdapter {
	final Logger log = Logger.getLogger(LoginHandlerInterceptorAdapter.class);

	@Autowired
	private UserService service;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		if (modelAndView != null) {
			Authentication login = SecurityContextHolder.getContext().getAuthentication();
			if (login != null) {
				B2BUserDetails user = (B2BUserDetails) login.getPrincipal();
				String name = user.getName();
//				List<Function> functions = name.equals("king") ? service.getAllFunctions() : user.getFunctions();
//				modelAndView.addObject("functions", functions);
//				modelAndView.addObject("zone", user.getZone());
			}
		}

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
	}

}
