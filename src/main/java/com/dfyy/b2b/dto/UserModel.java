package com.dfyy.b2b.dto;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.dfyy.b2b.bussiness.SUser;

@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class UserModel extends CheckResult {
	private static final long serialVersionUID = -2790969844320675642L;

	@XmlElement
	private SUser user;

	public UserModel() {
	}

	public SUser getUser() {
		return user;
	}

	public void setUser(SUser user) {
		this.user = user;
	}

}
