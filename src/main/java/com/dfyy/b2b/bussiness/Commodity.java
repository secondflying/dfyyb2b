package com.dfyy.b2b.bussiness;

import java.io.Serializable;

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

import org.joda.time.DateTime;

@Entity
@Table(name = "b2b_commodity")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class Commodity implements Serializable {

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
	@JoinColumn(name = "tid")
	@XmlElement
	private CommodityType type;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "unit")
	@XmlElement
	private CommodityUnit unit;

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
	@XmlTransient
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
	private DateTime time;

	@Column(name = "price")
	@XmlElement
	private Double price;

	@Column(name = "pricetime")
	@XmlElement
	private DateTime pricetime;

	@Column(name = "status")
	@XmlElement
	private Integer status;

	public Commodity() {

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

	public DateTime getTime() {
		return time;
	}

	public void setTime(DateTime time) {
		this.time = time;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public DateTime getPricetime() {
		return pricetime;
	}

	public void setPricetime(DateTime pricetime) {
		this.pricetime = pricetime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
}
