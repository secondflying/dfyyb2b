package com.dfyy.b2b.dto;

import java.io.Serializable;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import com.dfyy.b2b.bussiness.CommodityOfNzd;
import com.dfyy.b2b.bussiness.Orders;

@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class CommodityOfNzdResult implements Serializable {

	@XmlElement
	private long lastTime;

	@XmlElementWrapper
	@XmlElementRef
	private List<CommodityOfNzd> results;

	public CommodityOfNzdResult() {
	}

	public List<CommodityOfNzd> getResults() {
		return results;
	}

	public void setResults(List<CommodityOfNzd> results) {
		this.results = results;
	}

	public long getLastTime() {
		return lastTime;
	}

	public void setLastTime(long lastTime) {
		this.lastTime = lastTime;
	}

}
