package com.dfyy.b2b.resource;

import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
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
}
