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
@Table(name = "b2b_nzd_member")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class NzdMember implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "nzd")
	@XmlElement
	private SUser nzd;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user")
	@XmlElement
	private SUser user;

	@Column(name = "time")
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;

	@Column(name = "status")
	@XmlElement
	private Integer status;

	public NzdMember() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public SUser getNzd() {
		return nzd;
	}

	public void setNzd(SUser nzd) {
		this.nzd = nzd;
	}

	public SUser getUser() {
		return user;
	}

	public void setUser(SUser user) {
		this.user = user;
	}

}
