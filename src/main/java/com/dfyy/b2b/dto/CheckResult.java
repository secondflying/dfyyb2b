package com.dfyy.b2b.dto;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class CheckResult implements Serializable {

	private static final long serialVersionUID = 1L;

	@XmlElement
	private boolean result;

	@XmlElement
	private String message;

	public CheckResult() {
	}

	public CheckResult(boolean result) {
		super();
		this.result = result;
	}

	public CheckResult(boolean result, String message) {
		super();
		this.message = message;
		this.result = result;
	}

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
