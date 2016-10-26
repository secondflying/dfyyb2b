package com.dfyy.b2b.resource;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.Shopcart;
import com.dfyy.b2b.service.ShopcartService;
import com.dfyy.b2b.service.TokenService;
import com.dfyy.b2b.util.TokenHelper;

@Component
@Path("/shopcart")
public class ShopcartResource {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private ShopcartService shopcartService;

	@Autowired
	private TokenService tokenService;

	@GET
	@Path("/my")
	@Produces("application/json;charset=UTF-8")
	public Response myList(@QueryParam("nzd") String userid, @HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			List<Shopcart> result = shopcartService.getList(userid);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			logger.error("获取购物车列表", e);
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@POST
	@Path("/add")
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json;charset=UTF-8")
	public Response add(@FormParam("nzd") String userid, @FormParam("cid") int cid, @FormParam("count") int count,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {

			List<Shopcart> result = shopcartService.addCommodity(userid, cid, count);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();

		} catch (Exception e) {
			logger.error("获取购物车列表", e);
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@POST
	@Path("/delete")
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json;charset=UTF-8")
	public Response delete(@FormParam("nzd") String userid, @FormParam("cid") int cid,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			List<Shopcart> result = shopcartService.deleteCommodity(userid, cid);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();

		} catch (Exception e) {
			logger.error("获取购物车列表", e);
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

}
