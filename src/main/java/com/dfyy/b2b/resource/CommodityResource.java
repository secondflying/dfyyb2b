package com.dfyy.b2b.resource;

import java.util.List;

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

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.CommodityType;
import com.dfyy.b2b.bussiness.OrderOfPro;
import com.dfyy.b2b.dto.CommoditiesResult;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.service.TokenService;
import com.dfyy.b2b.util.TokenHelper;
import com.sun.jersey.api.core.ResourceContext;

@Component
@Path("/commodity")
public class CommodityResource {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Context
	private ResourceContext resourceContext;

	@Autowired
	private CommodityService commodityService;

	@Autowired
	private TokenService tokenService;

	@GET
	@Path("/online")
	@Produces("application/json;charset=UTF-8")
	public Response online(@QueryParam("nzd") String userid, @QueryParam("type") String type,
			@QueryParam("key") String key, @QueryParam("page") @DefaultValue("0") int page,
			@QueryParam("time") @DefaultValue("0") long time, @HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}

		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			CommoditiesResult result = commodityService.getOnlineCommodity(userid, type, key, page, time);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/{cid}")
	@Produces("application/json;charset=UTF-8")
	public Response single(@PathParam("cid") int cid) {
		try {
			Commodity result = commodityService.getCommodityFull(cid);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/ptypes")
	@Produces("application/json;charset=UTF-8")
	public Response ptypes(@HeaderParam("X-Token") String token) {
		try {
			List<CommodityType> result = commodityService.getCommodityTypeParent();
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

	@GET
	@Path("/{cid}/protection")
	@Produces("application/json;charset=UTF-8")
	public Response protection(@PathParam("cid") int cid) {
		try {
			List<OrderOfPro> result = commodityService.getCommodityProtection(cid);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}
}
