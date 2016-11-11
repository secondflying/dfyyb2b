package com.dfyy.b2b.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.OrdersInventory;
import com.dfyy.b2b.bussiness.OrdersSecond;
import com.dfyy.b2b.bussiness.UserSecond;
import com.dfyy.b2b.dto.CheckResult;
import com.dfyy.b2b.dto.SecondsResult;
import com.dfyy.b2b.dto.UserSecondsResult;
import com.dfyy.b2b.dto.ZfbtDto;
import com.dfyy.b2b.service.TokenService;
import com.dfyy.b2b.service.ZfbtService;
import com.dfyy.b2b.util.TokenHelper;
import com.sun.jersey.api.core.ResourceContext;

@Component
@Path("/zfbt")
public class ZfbtResource {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Context
	private ResourceContext resourceContext;

	@Autowired
	private ZfbtService zfbtService;

	@Autowired
	private TokenService tokenService;

	@POST
	@Path("/convert")
	@Consumes("application/json")
	@Produces("application/json;charset=UTF-8")
	public Response convert(ZfbtDto dto, @HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(dto.getNzd())) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, dto.getNzd(), token);
		try {
			zfbtService.convert(dto);
			return Response.status(Status.OK).entity(new CheckResult(true)).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/inventory")
	@Produces("application/json;charset=UTF-8")
	public Response inventory(@QueryParam("nzd") String userid, @QueryParam("cid") int cid,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			OrdersInventory result = zfbtService.getInventory(userid, cid);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/my")
	@Produces("application/json;charset=UTF-8")
	public Response mySeconds(@QueryParam("nzd") String userid, @QueryParam("page") @DefaultValue("0") int page,
			@QueryParam("time") @DefaultValue("0") long time, @HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			SecondsResult result = zfbtService.getMySeconds(userid, page, time);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/single")
	@Produces("application/json;charset=UTF-8")
	public Response single(@QueryParam("nzd") String userid, @QueryParam("cid") int cid,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			OrdersSecond result = zfbtService.getSingleSecond(userid, cid);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@POST
	@Path("/offshelf")
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json;charset=UTF-8")
	public Response cancel(@FormParam("nzd") String userid, @FormParam("cid") int cid,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);
		try {
			zfbtService.offShelf(userid, cid);
			return Response.status(Status.OK).entity(new CheckResult(true)).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.OK).entity(new CheckResult(false, e.getMessage()))
					.type(MediaType.APPLICATION_JSON).build();
		}
	}

	@GET
	@Path("/orders")
	@Produces("application/json;charset=UTF-8")
	public Response myOrders(@QueryParam("nzd") String userid, @QueryParam("page") @DefaultValue("0") int page,
			@QueryParam("time") @DefaultValue("0") long time, @HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			UserSecondsResult result = zfbtService.getMyOrders(userid, page, time);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/sellhistory")
	@Produces("application/json;charset=UTF-8")
	public Response sellhistory(@QueryParam("nzd") String userid, @QueryParam("sid") int sid,
			@QueryParam("page") @DefaultValue("0") int page, @QueryParam("time") @DefaultValue("0") long time,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}
		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			UserSecondsResult result = zfbtService.getSellHistory(userid, sid, page, time);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/commoditysell")
	@Produces("application/json;charset=UTF-8")
	public Response commoditysell(@QueryParam("nzd") String userid, @QueryParam("cid") int cid,
			@QueryParam("page") @DefaultValue("0") int page, @QueryParam("time") @DefaultValue("0") long time,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}
		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			UserSecondsResult result = zfbtService.getCommoditySell(userid, cid, page, time);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/orderdetail")
	@Produces("application/json;charset=UTF-8")
	public Response orderDetail(@QueryParam("nzd") String userid, @QueryParam("oid") int oid,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			UserSecond result = zfbtService.getSellOrderDetail(userid, oid);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@POST
	@Path("/orderconfirm")
	@Consumes("application/x-www-form-urlencoded")
	public Response confirmOrder(@FormParam("oid") int oid, @FormParam("nzd") String uid,
			@HeaderParam("X-Token") String token) {

		if (StringUtils.isBlank(uid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, uid, token);

		try {
			zfbtService.conformUserOrder2(uid, oid);
			return Response.status(Status.OK).build();
		} catch (Exception e) {
			return Response.status(Status.BAD_REQUEST).entity(e.getMessage()).type(MediaType.TEXT_PLAIN).build();
		}
	}

}
