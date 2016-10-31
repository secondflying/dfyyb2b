package com.dfyy.b2b.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import com.dfyy.b2b.bussiness.Orders;

@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class TotalOrders implements Serializable {

	@XmlElement
	private double totalPrice;

	@XmlElementWrapper
	@XmlElementRef
	private List<Orders> results;

	public void add(Orders o) {
		if (results == null) {
			results = new ArrayList<Orders>();
		}
		results.add(o);
	}

	public TotalOrders() {
	}

	public List<Orders> getResults() {
		return results;
	}

	public void setResults(List<Orders> results) {
		this.results = results;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

}
