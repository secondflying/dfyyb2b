package com.dfyy.b2b.bussiness;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@Entity
@Table(name = "b2b_commodity_type")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
@JsonIgnoreProperties(ignoreUnknown = true)
public class CommodityType implements Serializable {

	private static final long serialVersionUID = 1677392261112853670L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private int id;

	@Column(name = "name")
	@XmlElement
	private String name;

	@Column(name = "category")
	@XmlElement
	private int category;

	@Column(name = "status")
	@XmlTransient
	private Integer status;

	@Column(name = "image")
	@XmlElement
	private String image;

	@Transient
	@XmlElementWrapper
	@XmlElementRef
	private List<CommodityType> childCrops;

	public CommodityType() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public List<CommodityType> getChildCrops() {
		return childCrops;
	}

	public void setChildCrops(List<CommodityType> childCrops) {
		this.childCrops = childCrops;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

}
