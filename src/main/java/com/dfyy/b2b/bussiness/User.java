package com.dfyy.b2b.bussiness;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import org.hibernate.annotations.GenericGenerator;

import com.dfyy.b2b.util.JaxbDateSerializer;


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
	
	@Column(name = "alias")
	@XmlElement
	private String alias;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "type")
	@XmlElement
	private UserType type;
	
	@Column(name = "address")
	@XmlElement
	private String address;
	
	@Column(name = "zipcode")
	@XmlElement
	private String zipcode;
	
	@Column(name = "contacts")
	@XmlElement
	private String contacts;
	
	@Column(name = "x")
	@XmlElement
	private Double x;

	@Column(name = "y")
	@XmlElement
	private Double y;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "zone")
	@XmlElement
	private Zone zone;
	
	@Column(name = "time")
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;

	@Column(name = "status")
	@XmlTransient
	private Integer status;
	
	@XmlElementWrapper
	@XmlElementRef
	@Transient
	private List<UserDoc> docs;

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

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public UserType getType() {
		return type;
	}

	public void setType(UserType type) {
		this.type = type;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
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

	public Zone getZone() {
		return zone;
	}

	public void setZone(Zone zone) {
		this.zone = zone;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public List<UserDoc> getDocs() {
		return docs;
	}

	public void setDocs(List<UserDoc> docs) {
		this.docs = docs;
	}

	
}
