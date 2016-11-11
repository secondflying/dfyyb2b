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
@Table(name = "b2b_orders_second")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class OrdersSecond implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;

	@Column(name = "nid")
	@XmlElement
	private String nzd;

	@Column(name = "cid")
	@XmlElement
	private int cid;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "sid")
	@XmlElement
	private Second second;

	@Column(name = "status")
	@XmlElement
	private int status;

	@Column(name = "time")
	@XmlElement
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;

	public OrdersSecond() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNzd() {
		return nzd;
	}

	public void setNzd(String nzd) {
		this.nzd = nzd;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Second getSecond() {
		return second;
	}

	public void setSecond(Second second) {
		this.second = second;
	}

}
