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
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import com.dfyy.b2b.util.JaxbDateSerializer;

@Entity
@Table(name = "b2b_nzd_commodity_protective")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class CommodityOfPro implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "uid")
	@XmlElement
	private User provider;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "type")
	@XmlElement
	private CommodityType type;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "unit")
	@XmlElement
	private CommodityUnit unit;

	@Column(name = "nid")
	private String nid;

	@Column(name = "name")
	@XmlElement
	private String name;

	@Column(name = "image")
	@XmlElement
	private String image;

	@Column(name = "factory")
	@XmlElement
	private String factory;

	@Column(name = "code")
	@XmlElement
	private String code;

	@Column(name = "standard")
	@XmlElement
	private String standard;

	@Column(name = "composition")
	@XmlElement
	private String composition;

	@Column(name = "number")
	@XmlElement
	private Double number;

	@Column(name = "step")
	@XmlElement
	private Double step;

	@Column(name = "brokerage")
	@XmlElement
	private Double brokerage;

	@Column(name = "time")
	@XmlElement
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;

	@Column(name = "price")
	@XmlElement
	private Double price;

	@Column(name = "pricetime")
	@XmlElement
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date pricetime;

	@Column(name = "status")
	@XmlElement
	private Integer status;

	@Column(name = "radius")
	@XmlTransient
	private Double radius;

	@Column(name = "x")
	@XmlTransient
	private Double x;

	@Column(name = "y")
	@XmlTransient
	private Double y;

	@Column(name = "endtime")
	@XmlTransient
	private Date endtime;
	
	
	@Column(name = "hastag")
	@XmlTransient
	private int hastag;

	public CommodityOfPro() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getProvider() {
		return provider;
	}

	public void setProvider(User provider) {
		this.provider = provider;
	}

	public CommodityType getType() {
		return type;
	}

	public void setType(CommodityType type) {
		this.type = type;
	}

	public CommodityUnit getUnit() {
		return unit;
	}

	public void setUnit(CommodityUnit unit) {
		this.unit = unit;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getFactory() {
		return factory;
	}

	public void setFactory(String factory) {
		this.factory = factory;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public String getComposition() {
		return composition;
	}

	public void setComposition(String composition) {
		this.composition = composition;
	}

	public Double getNumber() {
		return number;
	}

	public void setNumber(Double number) {
		this.number = number;
	}

	public Double getStep() {
		return step;
	}

	public void setStep(Double step) {
		this.step = step;
	}

	public Double getBrokerage() {
		return brokerage;
	}

	public void setBrokerage(Double brokerage) {
		this.brokerage = brokerage;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Date getPricetime() {
		return pricetime;
	}

	public void setPricetime(Date pricetime) {
		this.pricetime = pricetime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	// public User getNzd() {
	// return nzd;
	// }
	//
	// public void setNzd(User nzd) {
	// this.nzd = nzd;
	// }

	public Double getRadius() {
		return radius;
	}

	public void setRadius(Double radius) {
		this.radius = radius;
	}

	public Double getX() {
		return x;
	}

	public void setX(Double x) {
		this.x = x;
	}

	public Double getY() {
		return y;
	}

	public void setY(Double y) {
		this.y = y;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public int getHastag() {
		return hastag;
	}

	public void setHastag(int hastag) {
		this.hastag = hastag;
	}

}
