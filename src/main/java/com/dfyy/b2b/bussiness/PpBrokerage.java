package com.dfyy.b2b.bussiness;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import com.dfyy.b2b.util.JaxbDateSerializer;

@Entity
@Table(name = "b2b_pp_brokerage")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class PpBrokerage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "cid")
	@XmlElement
	private CommodityType crop;
	
	@Column(name = "platform")
	@XmlElement
	private Double platform;
	
	@Column(name = "partner")
	@XmlElement
	private Double partner;
	
	@Column(name = "time")
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;
	
	@Column(name = "status")
	@XmlElement
	private Integer status;
	
	public PpBrokerage() {
		// TODO Auto-generated constructor stub
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public CommodityType getCrop() {
		return crop;
	}

	public void setCrop(CommodityType crop) {
		this.crop = crop;
	}

	public Double getPlatform() {
		return platform;
	}

	public void setPlatform(Double platform) {
		this.platform = platform;
	}

	public Double getPartner() {
		return partner;
	}

	public void setPartner(Double partner) {
		this.partner = partner;
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
