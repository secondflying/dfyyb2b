package com.dfyy.b2b.bussiness;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "b2b_commodity_gradualprice")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class CommodityGradualprice implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@XmlElement
	private Integer id;

	@Column(name = "cid")
	@XmlElement
	private Integer cid;
	
	@Column(name = "unit")
	@XmlElement
	private Integer uid;
	
	@Column(name = "price")
	@XmlElement
	private Double price;
	
	@Column(name = "minNumber")
	@XmlElement
	private Double minnumber;
	
	@Column(name = "maxNumber")
	@XmlElement
	private Double maxnumber;
	
	@Column(name = "time")
	@XmlElement
	private Date time;

	@Column(name = "status")
	private Integer status;

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

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
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

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}
