package com.dfyy.b2b.resource;

import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.dto.CheckResult;
import com.dfyy.b2b.dto.UserModel;
import com.dfyy.b2b.service.NzdService;
import com.dfyy.b2b.service.SMSService;
import com.sun.jersey.api.core.ResourceContext;

@Component
@Path("/nzd")
public class UsersResource {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Context
	private ResourceContext resourceContext;

	@Autowired
	private NzdService nzdService;

	@Autowired
	private SMSService smsService;

	@POST
	@Path("/login")
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json;charset=UTF-8")
	public CheckResult login(@FormParam("phone") String phone, @FormParam("password") String password,
			@Context HttpServletResponse response) {

		if (StringUtils.isBlank(phone) || StringUtils.isBlank(password)) {
			return new CheckResult(false, "电话和密码为必填项！");
		} else {

			try {
				SUser user = nzdService.login(phone, password);
				logger.info("登录用户：{} 成功", phone);

				response.setHeader("X-Token", nzdService.createUserToken(user.getId(), user.getPhone()));

				UserModel result = new UserModel();
				result.setResult(true);
				result.setUser(user);
				return result;
			} catch (Exception e) {
				logger.error("登录：{} 失败", phone, e);
				return new CheckResult(false, e.getMessage());
			}
		}
	}
	
	
	/**
	 * 检查昵称是否存在
	 * 
	 * @param uid
	 * @param points
	 * @return
	 */
	@POST
	@Path("/checkname")
	@Produces("application/json;charset=UTF-8")
	@Consumes("application/x-www-form-urlencoded")
	public CheckResult checkname(@FormParam("alias") String alias) {
		boolean exist = nzdService.checkByAlias(alias);
		return new CheckResult(exist);
	}


	@Path("/{uid}")
	public UserResource getById(@PathParam("uid") String uid) {
		UserResource userResource = resourceContext.getResource(UserResource.class);
		userResource.setUid(uid);
		return userResource;
	}

}
