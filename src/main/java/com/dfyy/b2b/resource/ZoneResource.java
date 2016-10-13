package com.dfyy.b2b.resource;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.CommodityType;
import com.dfyy.b2b.dto.ZoneResult;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.service.ZoneService;

@Component
@Path("/zone")
public class ZoneResource {

	@Autowired
	private ZoneService service;

	@Autowired
	private CommodityService commodityService;

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@GET
	@Produces("application/json;charset=UTF-8")
	public List<CommodityType> getAll() {
		return commodityService.getTreeCommodityType();
	}

	@GET
	@Path("/my")
	@Produces("application/json;charset=UTF-8")
	public ZoneResult getZone(@QueryParam("x") double x, @QueryParam("y") double y) {
		return service.getZoneByCood(x, y);
	}
}
