package com.dfyy.b2b.resource;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.AppFile;
import com.dfyy.b2b.service.AppFileService;

@Component
@Path("apps")
public class AppFileResource {

	@Autowired
	private AppFileService service;


	@GET
	@Path("/android")
	@Produces("application/json;charset=UTF-8")
	public AppFile getAndroid(@Context UriInfo uriInfo, @Context HttpServletRequest request) {

		String host = uriInfo.getRequestUri().getHost();
		AppFile app = service.getById(3);

		return app;
	}

	@GET
	@Path("/ios")
	@Produces("application/json;charset=UTF-8")
	public AppFile getIos() {
		return service.getById(4);
	}
}
