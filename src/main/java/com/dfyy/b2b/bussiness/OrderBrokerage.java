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
@Table(name = "b2b_order_brokerage")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class OrderBrokerage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;
	
	@Column(name = "oid")
	@XmlElement
	private Integer oid;
	
	@Column(name = "time")
	@XmlElement
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;
	
	@Column(name = "bplatform")
	@XmlElement
	private Double bplatform;
	
	@Column(name = "pid")
	@XmlElement
	private String pid;
	
	@Column(name = "bpartner")
	@XmlElement
	private Double bpartner;
	
	@Column(name = "sid")
	@XmlElement
	private String sid;

	@Column(name = "bsalesman")
	@XmlElement
	private Double bsalesman;
	
	@Column(name = "status")
	@XmlElement
	private int status;
	
	public OrderBrokerage(){
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOid() {
		return oid;
	}

	public void setOid(Integer oid) {
		this.oid = oid;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Double getBplatform() {
		return bplatform;
	}

	public void setBplatform(Double bplatform) {
		this.bplatform = bplatform;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public Double getBpartner() {
		return bpartner;
	}

	public void setBpartner(Double bpartner) {
		this.bpartner = bpartner;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public Double getBsalesman() {
		return bsalesman;
	}

	public void setBsalesman(Double bsalesman) {
		this.bsalesman = bsalesman;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
}
