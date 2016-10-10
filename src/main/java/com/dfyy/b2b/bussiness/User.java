package com.dfyy.b2b.bussiness;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "b2b_user")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class User implements Serializable {

	private static final long serialVersionUID = 695199502414743668L;

	@Id
	@Column(name = "id")
	@GenericGenerator(name = "idGenerator", strategy = "assigned")
	@GeneratedValue(generator = "idGenerator")
	@XmlElement
	private String id;

	@Column(name = "phone")
	@XmlElement
	private String phone;

	@Column(name = "password")
	@XmlTransient
	private String password;

	@Column(name = "status")
	@XmlTransient
	private Integer status;

	public User() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

}
