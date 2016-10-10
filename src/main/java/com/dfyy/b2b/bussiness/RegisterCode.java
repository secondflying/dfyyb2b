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
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import com.dfyy.b2b.util.JaxbDateSerializer;

@Entity
@Table(name = "registercode")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class RegisterCode implements Serializable {

	private static final long serialVersionUID = 5310627505492395299L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;


	@Column(name = "phone")
	@XmlElement
	private String phone;

	@Column(name = "code")
	@XmlElement
	private String code;
	
	@Column(name = "time")
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;

	@Column(name = "status")
	@XmlTransient
	private Integer status;


	public RegisterCode() {

	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}


	public Integer getStatus() {
		return status;
	}


	public void setStatus(Integer status) {
		this.status = status;
	}


	public Date getTime() {
		return time;
	}


	public void setTime(Date time) {
		this.time = time;
	}

}
