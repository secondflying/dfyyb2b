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

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.dfyy.b2b.util.JaxbDateSerializer;

@Entity
@Table(name = "user_second")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class UserSecond implements Serializable {

	private static final long serialVersionUID = 8992615588335580056L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;

	@Column(name = "usid")
	@XmlElement
	private String usid;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "uid")
	@XmlElement
	private SUser user;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "sid")
	@XmlElement
	private Second second;

	@Column(name = "status")
	@XmlElement
	private Integer status;

	@Column(name = "price")
	@XmlElement
	private Double price;

	@Column(name = "time")
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "nid")
	@NotFound(action=NotFoundAction.IGNORE)
	@XmlElement
	private SUser nzd;
	
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "cid")
	@NotFound(action=NotFoundAction.IGNORE)
	@XmlElement
	private Contact contact;

	@Column(name = "coupon")
	@XmlElement
	private Integer coupon;

	public UserSecond() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsid() {
		return usid;
	}

	public void setUsid(String usid) {
		this.usid = usid;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public SUser getUser() {
		return user;
	}

	public void setUser(SUser user) {
		this.user = user;
	}

	public Second getSecond() {
		return second;
	}

	public void setSecond(Second second) {
		this.second = second;
	}

	public SUser getNzd() {
		return nzd;
	}

	public void setNzd(SUser nzd) {
		this.nzd = nzd;
	}

	public Integer getCoupon() {
		return coupon;
	}

	public void setCoupon(Integer coupon) {
		this.coupon = coupon;
	}

	public Contact getContact() {
		return contact;
	}

	public void setContact(Contact contact) {
		this.contact = contact;
	}

}
