package com.dfyy.b2b.bussiness;

import java.io.Serializable;
import java.util.Date;

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
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import org.hibernate.annotations.GenericGenerator;

import com.dfyy.b2b.util.JaxbDateSerializer;

@Entity
@Table(name = "user")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class SUser implements Serializable {
	private static final long serialVersionUID = 8517308475246169441L;

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
	private String password;

	@Column(name = "alias")
	@XmlElement
	private String alias;

	@Column(name = "thumbnail")
	@XmlElement
	private String thumbnail;

	@Column(name = "point")
	@XmlElement
	private Integer point;

	@Column(name = "description")
	@XmlElement
	private String description;

	@Column(name = "address")
	@XmlElement
	private String address;

	@Column(name = "currency")
	@XmlElement
	private Integer currency;

	@Column(name = "activity")
	private Integer activity;

	@Column(name = "scoring")
	@XmlElement
	private Double scoring;

	@Column(name = "time")
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date time;

	@Column(name = "level")
	@XmlElement
	private Integer levelID;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "level", insertable = false, updatable = false)
	private UserLevel level;

	@Column(name = "x")
	@XmlElement
	private Double x;

	@Column(name = "y")
	@XmlElement
	private Double y;

	@Column(name = "tjcode")
	@XmlElement
	private String tjcode;
	
	@Column(name = "tjcoin")
	@XmlElement
	private Integer tjcoin;

	@Column(name = "aid")
	@XmlElement
	private Integer aid;
	
	@Column(name = "teamwork")
	@XmlElement
	private boolean teamwork;
	
	@Column(name = "acceptcoupon")
	@XmlElement
	private boolean acceptCoupon;
	
	@Transient
	private Integer recCount;

	public SUser() {

	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
	}

	public Double getScoring() {
		return scoring;
	}

	public void setScoring(Double scoring) {
		this.scoring = scoring;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getLevelID() {
		return levelID;
	}

	public void setLevelID(Integer levelID) {
		this.levelID = levelID;
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

	public String getTjcode() {
		return tjcode;
	}

	public void setTjcode(String tjcode) {
		this.tjcode = tjcode;
	}

	public Integer getAid() {
		return aid;
	}

	public void setAid(Integer aid) {
		this.aid = aid;
	}

	public Integer getRecCount() {
		return recCount;
	}

	public void setRecCount(Integer recCount) {
		this.recCount = recCount;
	}

	public UserLevel getLevel() {
		return level;
	}

	public void setLevel(UserLevel level) {
		this.level = level;
	}

	public Integer getActivity() {
		return activity;
	}

	public void setActivity(Integer activity) {
		this.activity = activity;
	}

	@XmlElement
	public String getIdentifier() {
		if (activity == null) {
			return "新人";
		} else if (activity >= 2000) {
			return "特级";
		} else if (activity >= 1000 && activity <= 1999) {
			return "高级";
		} else if (activity >= 500 && activity <= 999) {
			return "中级";
		} else if (activity >= 200 && activity <= 499) {
			return "初级";
		}
		return "新人";
	}

	public boolean isTeamwork() {
		return teamwork;
	}

	public void setTeamwork(boolean teamwork) {
		this.teamwork = teamwork;
	}

	public Integer getTjcoin() {
		return tjcoin;
	}

	public void setTjcoin(Integer tjcoin) {
		this.tjcoin = tjcoin;
	}

	public boolean isAcceptCoupon() {
		return acceptCoupon;
	}

	public void setAcceptCoupon(boolean acceptCoupon) {
		this.acceptCoupon = acceptCoupon;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
