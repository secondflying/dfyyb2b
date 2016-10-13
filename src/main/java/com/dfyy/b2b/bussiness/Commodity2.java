package com.dfyy.b2b.bussiness;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "b2b_commodity")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class Commodity2 implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	@XmlElement
	private Integer id;

	@ManyToMany
	@JoinTable(name = "b2b_commodity_tag_rel", joinColumns = { @JoinColumn(name = "cid") }, inverseJoinColumns = { @JoinColumn(name = "tid") })
	@OrderBy("id ASC")
	@XmlElement
	private List<CommodityTag> tags;

	public Commodity2() {

	}

	public List<CommodityTag> getTags() {
		return tags;
	}

	public void setTags(List<CommodityTag> tags) {
		this.tags = tags;
	}

}
