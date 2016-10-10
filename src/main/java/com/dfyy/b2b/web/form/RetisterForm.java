package com.dfyy.b2b.web.form;

import java.io.Serializable;

public class RetisterForm implements Serializable {

	private static final long serialVersionUID = -5698111417779290868L;
	private String phone;
	private String password;
	private String password2;
	private String code;

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
