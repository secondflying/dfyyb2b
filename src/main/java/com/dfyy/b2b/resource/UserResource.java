package com.dfyy.b2b.resource;

import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.service.NzdService;
import com.dfyy.b2b.service.TokenService;
import com.dfyy.b2b.util.TokenHelper;

@Component
@Scope("prototype")
public class UserResource {
	@Autowired
	private NzdService nzdService;

	@Autowired
	private TokenService tokenService;

	private String uid;

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	/**
	 * 获取用户详情
	 * 
	 * @param uid
	 * @return
	 */
	@GET
	@Produces("application/json;charset=UTF-8")
	public SUser getDetail(@PathParam("uid") String uid, @HeaderParam("X-Token") String token) {
		TokenHelper.verifyToken(tokenService, uid, token);

		return nzdService.getByID(uid);
	}

}
