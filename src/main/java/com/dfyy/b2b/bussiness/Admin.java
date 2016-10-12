package com.dfyy.b2b.bussiness;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


@Entity
@Table(name = "admin")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class Admin implements Serializable {

	private static final long serialVersionUID = 695199502414743668L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;

	@Column(name = "name")
	@XmlElement
	private String name;

	@Column(name = "password")
	@XmlTransient
	private String password;

	@Column(name = "status")
	@XmlTransient
	private Integer status;

	@ManyToMany
	@JoinTable(name = "admin_function", joinColumns = @JoinColumn(name = "aid", referencedColumnName = "id"), inverseJoinColumns = @JoinColumn(name = "fid", referencedColumnName = "id"))
	private List<Function> functions;

	@ManyToMany
	@JoinTable(name = "admin_zone", joinColumns = @JoinColumn(name = "aid", referencedColumnName = "id"), inverseJoinColumns = @JoinColumn(name = "zid", referencedColumnName = "id"))
	private List<Zone> zones;

	public Admin() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public List<Function> getFunctions() {
		return functions;
	}

	public void setFunctions(List<Function> functions) {
		this.functions = functions;
	}

	public List<Zone> getZones() {
		return zones;
	}

	public void setZones(List<Zone> zones) {
		this.zones = zones;
	}

}
