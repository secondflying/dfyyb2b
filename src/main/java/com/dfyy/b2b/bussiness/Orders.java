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
@Table(name = "b2b_orders")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class Orders implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "nid")
	@XmlElement
	private SUser nzd;

	@Column(name = "time")
	@XmlElement
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "cid")
	@XmlElement
	private Commodity commodity;

	@Column(name = "count")
	@XmlElement
	private int count;

	@Column(name = "price")
	@XmlElement
	private double price;

	@Column(name = "status")
	@XmlElement
	private int status;

	@Column(name = "endtime")
	@XmlElement
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date endtime;

	@Column(name = "radius")
	@XmlElement
	private Double radius;

	@Column(name = "extendStatus")
	@XmlElement
	private Integer extendStatus;

	@Column(name = "extendDays")
	@XmlElement
	private Integer extendDays;

	public Orders() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SUser getNzd() {
		return nzd;
	}

	public void setNzd(SUser nzd) {
		this.nzd = nzd;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Commodity getCommodity() {
		return commodity;
	}

	public void setCommodity(Commodity commodity) {
		this.commodity = commodity;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Double getRadius() {
		return radius;
	}

	public void setRadius(Double radius) {
		this.radius = radius;
	}

	public Integer getExtendStatus() {
		return extendStatus;
	}

	public void setExtendStatus(Integer extendStatus) {
		this.extendStatus = extendStatus;
	}

	public Integer getExtendDays() {
		return extendDays;
	}

	public void setExtendDays(Integer extendDays) {
		this.extendDays = extendDays;
	}

}
