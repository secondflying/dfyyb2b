package com.dfyy.b2b.dto;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.dfyy.b2b.bussiness.Zone;

@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class ZoneResult implements Serializable {

	private static final long serialVersionUID = 1L;

	@XmlElement
	private boolean result;

	@XmlElement
	private Zone zone;

	public ZoneResult() {
	}

	public ZoneResult(boolean result) {
		super();
		this.result = result;
	}

	public ZoneResult(boolean result, Zone zone) {
		super();
		this.zone = zone;
		this.result = result;
	}

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public Zone getZone() {
		return zone;
	}

	public void setZone(Zone zone) {
		this.zone = zone;
	}

}
