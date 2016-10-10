package com.dfyy.b2b.bussiness;

import java.io.Serializable;

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

@Entity
@Table(name = "zones")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class Zone implements Serializable {
	private static final long serialVersionUID = -2102495146629322359L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@XmlElement
	private Integer id;

	@Column(name = "name")
	@XmlElement
	private String name;

	@Column(name = "online")
	private boolean online;
	
	@Column(name = "seq")
	private Integer seq;

	public Zone() {
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

	public boolean isOnline() {
		return online;
	}

	public void setOnline(boolean online) {
		this.online = online;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

}
