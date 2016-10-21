package com.dfyy.b2b.web.form;

import java.io.Serializable;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
@JsonIgnoreProperties(ignoreUnknown = true)
public class ProtectiveForm implements Serializable {

	private Integer id;

	private Integer cid;
	
	private Double minnumber;
	
	private Double maxnumber;
	
	private Double days;

	private Double radius;
	
	public ProtectiveForm() {
		// TODO Auto-generated constructor stub
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public Double getMinnumber() {
		return minnumber;
	}

	public void setMinnumber(Double minnumber) {
		this.minnumber = minnumber;
	}

	public Double getMaxnumber() {
		return maxnumber;
	}

	public void setMaxnumber(Double maxnumber) {
		this.maxnumber = maxnumber;
	}

	public Double getDays() {
		return days;
	}

	public void setDays(Double days) {
		this.days = days;
	}

	public Double getRadius() {
		return radius;
	}

	public void setRadius(Double radius) {
		this.radius = radius;
	}
	
	
}
