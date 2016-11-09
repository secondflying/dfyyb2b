package com.dfyy.b2b.bussiness;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import com.dfyy.b2b.util.JaxbDateSerializer;
import com.dfyy.b2b.util.JaxbDateSerializer2;

@Entity
@Table(name = "second")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class Second implements Serializable {

	private static final long serialVersionUID = 5936268351472072852L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;

	@XmlElement
	@Column(name = "title")
	private String title;

	@XmlElement
	@Column(name = "content")
	private String content;

	@XmlElement
	@Column(name = "image")
	private String image;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "uid")
	@XmlElement
	private SUser nzd;

	@Column(name = "status")
	@XmlElement
	private Integer verify;

	@Transient
	@XmlElement
	private Integer status;

	@Column(name = "stime")
	@XmlJavaTypeAdapter(JaxbDateSerializer2.class)
	private Date starttime;

	@Column(name = "etime")
	@XmlJavaTypeAdapter(JaxbDateSerializer2.class)
	private Date endtime;

	@Column(name = "count")
	@XmlElement
	private Integer count;

	@Column(name = "nprice")
	@XmlElement
	private Double nprice;

	@Column(name = "oprice")
	@XmlElement
	private Double oprice;

	@Column(name = "acount")
	@XmlElement
	private Integer acount;
	
	@Column(name = "maxbuy")
	@XmlElement
	private Integer maxbuy;
	
	@Column(name = "usecoupon")
	@XmlElement
	private boolean useCoupon;
	
	@Column(name = "coupon")
	@XmlElement
	private Integer coupon;
	
	@Column(name = "maxcoupon")
	@XmlElement
	private Integer couponMax;

	@Column(name = "time")
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;
	
	@Column(name = "type")
	@XmlElement
	private Integer type;
	
	@Column(name = "x")
	private Double x;
	
	@Column(name = "y")
	private Double y;
	
	@Column(name = "size")
	private Double size;
	
	@Column(name = "zone")
	@XmlElement
	private Integer zone;
	
	
	@Column(name = "haocount")
	@XmlElement
	private Integer haocount;

	@Column(name = "zhongcount")
	@XmlElement
	private Integer zhongcount;

	@Column(name = "chacount")
	@XmlElement
	private Integer chacount;

	@Column(name = "sumcount")
	@XmlElement
	private Integer sumcount;
	
	
	@XmlElementWrapper
	@XmlElementRef
	@Transient
	private List<SecondAttachment> attachments;
	
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
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

	public Double getSize() {
		return size;
	}

	public void setSize(Double size) {
		this.size = size;
	}

	@Transient
	@XmlElement
	private Double distance;
	
	public Second() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Double getNprice() {
		return nprice;
	}

	public void setNprice(Double nprice) {
		this.nprice = nprice;
	}

	public Double getOprice() {
		return oprice;
	}

	public void setOprice(Double oprice) {
		this.oprice = oprice;
	}

	public Double getDistance() {
		return distance;
	}

	public void setDistance(Double distance) {
		this.distance = distance;
	}

	public SUser getNzd() {
		return nzd;
	}

	public void setNzd(SUser nzd) {
		this.nzd = nzd;
	}

	public Integer getVerify() {
		return verify;
	}

	public void setVerify(Integer verify) {
		this.verify = verify;
	}

	public Integer getAcount() {
		return acount;
	}

	public void setAcount(Integer acount) {
		this.acount = acount;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getMaxbuy() {
		return maxbuy;
	}

	public void setMaxbuy(Integer maxbuy) {
		this.maxbuy = maxbuy;
	}

	public List<SecondAttachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<SecondAttachment> attachments) {
		this.attachments = attachments;
	}

	public Integer getCoupon() {
		return coupon;
	}

	public void setCoupon(Integer coupon) {
		this.coupon = coupon;
	}

	public Integer getZone() {
		return zone;
	}

	public void setZone(Integer zone) {
		this.zone = zone;
	}

	public Integer getHaocount() {
		return haocount;
	}

	public void setHaocount(Integer haocount) {
		this.haocount = haocount;
	}

	public Integer getZhongcount() {
		return zhongcount;
	}

	public void setZhongcount(Integer zhongcount) {
		this.zhongcount = zhongcount;
	}

	public Integer getChacount() {
		return chacount;
	}

	public void setChacount(Integer chacount) {
		this.chacount = chacount;
	}

	public Integer getSumcount() {
		return sumcount;
	}

	public void setSumcount(Integer sumcount) {
		this.sumcount = sumcount;
	}

	public Integer getCouponMax() {
		return couponMax;
	}

	public void setCouponMax(Integer couponMax) {
		this.couponMax = couponMax;
	}

	public boolean isUseCoupon() {
		return useCoupon;
	}

	public void setUseCoupon(boolean useCoupon) {
		this.useCoupon = useCoupon;
	}

}
