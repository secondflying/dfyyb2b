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
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import com.dfyy.b2b.util.JaxbDateSerializer;

@Entity
@Table(name = "b2b_commodity_gradualrebate")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class CommodityGradualrebate implements Serializable {

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
	
	@Column(name = "rebate")
	@XmlElement
	private Double rebate;
	
	@Column(name = "minNumber")
	@XmlElement
	private Integer minnumber;
	
//	@Column(name = "maxNumber")
//	@XmlElement
//	private Integer maxnumber;
	
	@Column(name = "time")
	@XmlElement
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
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

	public Double getRebate() {
		return rebate;
	}

	public void setRebate(Double rebate) {
		this.rebate = rebate;
	}

	public Integer getMinnumber() {
		return minnumber;
	}

	public void setMinnumber(Integer minnumber) {
		this.minnumber = minnumber;
	}

//	public Integer getMaxnumber() {
//		return maxnumber;
//	}
//
//	public void setMaxnumber(Integer maxnumber) {
//		this.maxnumber = maxnumber;
//	}

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
