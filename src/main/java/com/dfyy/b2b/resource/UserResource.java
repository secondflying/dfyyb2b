package com.dfyy.b2b.resource;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.StreamingOutput;
import javax.ws.rs.core.Response.Status;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.bussiness.OrderRebate;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.dto.CommoditiesResult;
import com.dfyy.b2b.dto.NzdMembersResult;
import com.dfyy.b2b.service.NzdService;
import com.dfyy.b2b.service.RebateService;
import com.dfyy.b2b.service.TokenService;
import com.dfyy.b2b.util.TokenHelper;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

@Component
@Scope("prototype")
public class UserResource {
	@Autowired
	private NzdService nzdService;

	@Autowired
	private TokenService tokenService;

	@Autowired
	private RebateService rebateService;

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

	@GET
	@Path("/QR")
	@Produces("image/png")
	public Response getQR(@PathParam("uid") final String uid, @HeaderParam("X-Token") String token) {
		SUser nzd = nzdService.getByID(uid);
		if (nzd == null) {
			return Response.status(Status.NOT_FOUND).entity("该农资店不存在").build();
		}
		StreamingOutput output = new StreamingOutput() {
			public void write(OutputStream output) throws IOException, WebApplicationException {
				try {
					if (StringUtils.isNotBlank(uid)) {
						String codeStr = "nzd:" + uid;
						BitMatrix byteMatrix = new MultiFormatWriter().encode(new String(codeStr.getBytes("GBK"),
								"iso-8859-1"), BarcodeFormat.QR_CODE, 200, 200);
						MatrixToImageWriter.writeToStream(byteMatrix, "png", output);
					}

				} catch (WriterException e) {
				}
			}
		};

		return Response.status(Status.OK).entity(output).build();
	}

	@GET
	@Path("/members")
	@Produces("application/json;charset=UTF-8")
	public NzdMembersResult members(@PathParam("uid") String uid, @QueryParam("page") @DefaultValue("0") int page,
			@QueryParam("time") @DefaultValue("0") long time, @HeaderParam("X-Token") String token) {
		TokenHelper.verifyToken(tokenService, uid, token);
		return nzdService.myMembers(uid, page, time);
	}

	@GET
	@Path("/salesman")
	@Produces("application/json;charset=UTF-8")
	public User salesman(@PathParam("uid") String uid, @HeaderParam("X-Token") String token) {
		TokenHelper.verifyToken(tokenService, uid, token);
		return nzdService.salesman(uid);
	}

	@GET
	@Path("/rebates")
	@Produces("application/json;charset=UTF-8")
	public Response rebates(@PathParam("nzd") String userid, @QueryParam("page") @DefaultValue("0") int page,
			@HeaderParam("X-Token") String token) {
		if (StringUtils.isBlank(userid)) {
			return Response.status(Status.BAD_REQUEST).entity("用户ID未指定").build();
		}
		TokenHelper.verifyToken(tokenService, userid, token);

		try {
			List<OrderRebate> result = rebateService.getByNzd(userid, page);
			return Response.status(Status.OK).entity(result).type(MediaType.APPLICATION_JSON).build();
		} catch (Exception e) {
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity(e.getMessage()).build();
		}
	}

}
