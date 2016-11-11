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
@Table(name = "account")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class Account implements Serializable {

	private static final long serialVersionUID = 8083217916061160718L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;

	@Column(name = "code")
	@XmlElement
	private String code;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "pay")
	@XmlElement
	private SUser pay;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "income")
	@XmlElement
	@NotFound(action=NotFoundAction.IGNORE)
	private SUser income;

	@Column(name = "currency")
	@XmlElement
	private Integer currency;

	@Column(name = "time")
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;

	@Column(name = "status")
	@XmlElement
	private Integer status;

	@Column(name = "remark")
	@XmlElement
	private String remark;

	public Account() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public SUser getPay() {
		return pay;
	}

	public void setPay(SUser pay) {
		this.pay = pay;
	}

	public SUser getIncome() {
		return income;
	}

	public void setIncome(SUser income) {
		this.income = income;
	}

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
