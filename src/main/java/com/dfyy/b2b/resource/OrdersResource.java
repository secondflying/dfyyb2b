package com.dfyy.b2b.resource;

import javax.ws.rs.Consumes;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
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

import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.dto.CheckResult;
import com.dfyy.b2b.dto.CommodityOfNzdResult;
import com.dfyy.b2b.dto.OrdersResult;
import com.dfyy.b2b.service.OrdersService;
import com.dfyy.b2b.service.TokenService;
import com.dfyy.b2b.util.TokenHelper;
import com.sun.jersey.api.core.ResourceContext;

@Component
@Path("/orders")
public class OrdersResource {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Context
	private ResourceContext resourceContext;

	@Autowired
	private OrdersService ordersService;

	@Autowired
	private TokenService tokenService;

	@GET
	@Path("/buyedCommodity")
	@Produces("application/json;charset=UTF-8")
	public Response buyedCommodity(@QueryParam("nzd") String userid, @QueryParam("page") @DefaultValue("0") int page,
			@QueryParam("time") @DefaultValue("0") long time, @HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		// TokenHelper.verifyToken(tokenService, userid, token);

		try {
			CommodityOfNzdResult result = ordersService.getMyBuyedCommodity(userid, page, time);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/my")
	@Produces("application/json;charset=UTF-8")
	public Response online(@QueryParam("nzd") String userid, @QueryParam("page") @DefaultValue("0") int page,
			@QueryParam("time") @DefaultValue("0") long time, @HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			OrdersResult result = ordersService.getMyOrders(userid, page, time);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/buyhistory")
	@Produces("application/json;charset=UTF-8")
	public Response buyhistory(@QueryParam("nzd") String userid, @QueryParam("cid") int cid,
			@QueryParam("page") @DefaultValue("0") int page, @QueryParam("time") @DefaultValue("0") long time,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			OrdersResult result = ordersService.getBuyHistory(userid, cid, page, time);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/{oid}")
	@Produces("application/json;charset=UTF-8")
	public Response single(@PathParam("oid") int oid) {
		try {
			Orders result = ordersService.getSingle(oid);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@POST
	@Path("/cancel")
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json;charset=UTF-8")
	public Response cancel(@FormParam("nzd") String userid, @FormParam("oid") int oid,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);
		try {
			ordersService.cancel(oid, userid);
			return Response.status(Status.OK).entity(new CheckResult(true)).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@POST
	@Path("/confirm")
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json;charset=UTF-8")
	public Response confirm(@FormParam("nzd") String userid, @FormParam("oid") int oid,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);
		try {
			ordersService.confirm(oid, userid);
			return Response.status(Status.OK).entity(new CheckResult(true)).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@POST
	@Path("/back")
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json;charset=UTF-8")
	public Response back(@FormParam("nzd") String userid, @FormParam("oid") int oid,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);
		try {
			ordersService.back(oid, userid);
			return Response.status(Status.OK).entity(new CheckResult(true)).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}
	
	
	@POST
	@Path("/backCancel")
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json;charset=UTF-8")
	public Response backCancel(@FormParam("nzd") String userid, @FormParam("oid") int oid,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);
		try {
			ordersService.cancelBack(oid, userid);
			return Response.status(Status.OK).entity(new CheckResult(true)).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}
	
	
	@POST
	@Path("/extendProtection")
	@Consumes("application/x-www-form-urlencoded")
	@Produces("application/json;charset=UTF-8")
	public Response extendProtection(@FormParam("nzd") String userid, @FormParam("oid") int oid,
			
			 @FormParam("days") int days,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);
		try {
			ordersService.extendProtectionApply(oid, userid,days);
			return Response.status(Status.OK).entity(new CheckResult(true)).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}
}
