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
@Table(name = "b2b_orders_rebate")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class OrderRebate implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "nid")
	@XmlElement
	private SUser nzd;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "cid")
	@XmlElement
	private Commodity commodity;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "pid")
	@XmlElement
	private User provider;
	
	@Column(name = "count")
	@XmlElement
	private Integer count;
	
	@Column(name = "rate")
	@XmlElement
	private Double rate;
	
	@Column(name = "amount")
	@XmlElement
	private Double amount;
	
	@Column(name = "starttime")
	@XmlElement
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date starttime;
	
	@Column(name = "endtime")
	@XmlElement
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date endtime;
	
	@Column(name = "rstatus")
	@XmlElement
	private Integer rstatus;
	
	@Column(name = "status")
	@XmlElement
	private Integer status;
	
	@Column(name = "total")
	@XmlElement
	private Double total;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SUser getNzd() {
		return nzd;
	}

	public void setNzd(SUser nzd) {
		this.nzd = nzd;
	}

	public Commodity getCommodity() {
		return commodity;
	}

	public void setCommodity(Commodity commodity) {
		this.commodity = commodity;
	}

	public User getProvider() {
		return provider;
	}

	public void setProvider(User provider) {
		this.provider = provider;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Double getRate() {
		return rate;
	}

	public void setRate(Double rate) {
		this.rate = rate;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Integer getRstatus() {
		return rstatus;
	}

	public void setRstatus(Integer rstatus) {
		this.rstatus = rstatus;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

}
