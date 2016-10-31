package com.dfyy.b2b.dto;

import java.io.Serializable;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import com.dfyy.b2b.bussiness.Shopcart;

@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class ShopcartResult implements Serializable {

	@XmlElement
	private double totalPrice;

	@XmlElementWrapper
	@XmlElementRef
	private List<Shopcart> results;

	public ShopcartResult() {
	}

	public List<Shopcart> getResults() {
		return results;
	}

	public void setResults(List<Shopcart> results) {
		this.results = results;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

}
