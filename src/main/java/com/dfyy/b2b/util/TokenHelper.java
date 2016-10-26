package com.dfyy.b2b.util;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;

import com.dfyy.b2b.service.TokenService;

public class TokenHelper {

	private static boolean checkToken = false;

	public static void verifyToken(TokenService service, String uid, String token) {
		if (!PublicConfig.isCheckToken()) {
			return;
		} else {
			if (!service.isvalid(uid, token)) {
				throw new WebApplicationException(Response.status(Response.Status.UNAUTHORIZED).build());
			}
		}
	}
}
