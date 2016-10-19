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

@Entity
@Table(name = "area")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class Area implements Serializable {
	private static final long serialVersionUID = 937941402826854968L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;
	
	@Column(name = "name")
	@XmlElement
	private String name;
	
	@Column(name = "parentid")
	@XmlElement
	private Integer parentid;
	
	@Column(name = "status")
	@XmlTransient
	private Integer status;
	
	@Transient
	@XmlElementWrapper
	@XmlElementRef
	private List<Area> nodes;
	
	public Area() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getParentid() {
		return parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Area> getNodes() {
		return nodes;
	}

	public void setNodes(List<Area> nodes) {
		this.nodes = nodes;
	}
	
	
}
