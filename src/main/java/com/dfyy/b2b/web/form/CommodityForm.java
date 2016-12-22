package com.dfyy.b2b.web.form;

import java.io.Serializable;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.dfyy.b2b.bussiness.Area;
import com.dfyy.b2b.bussiness.CommodityGradualprice;
import com.dfyy.b2b.bussiness.CommodityGradualrebate;
import com.dfyy.b2b.dto.AttachmentDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CommodityForm implements Serializable {

	private static final long serialVersionUID = 1L;
	private String userid;
	private Integer id;
	private String name;
	private String cname;
	private Integer cid;
	private Integer unit;
	private Double price;
	private Double oprice;
	private Double maxcount;
	private Double retail;
	private Area zone;
	private String factory;
	private String code;
	private String standard;
	private String composition;
	private Double number;
	private Double step;
	private Double brokerage;
	private Integer status;

	private List<AttachmentDto> docs;
	private List<CommodityGradualprice> gprices;
	private List<CommodityGradualrebate> grebates;

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

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public Integer getUnit() {
		return unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getFactory() {
		return factory;
	}

	public void setFactory(String factory) {
		this.factory = factory;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public String getComposition() {
		return composition;
	}

	public void setComposition(String composition) {
		this.composition = composition;
	}

	public Double getNumber() {
		return number;
	}

	public void setNumber(Double number) {
		this.number = number;
	}

	public Double getStep() {
		return step;
	}

	public void setStep(Double step) {
		this.step = step;
	}

	public Double getBrokerage() {
		return brokerage;
	}

	public void setBrokerage(Double brokerage) {
		this.brokerage = brokerage;
	}

	public List<AttachmentDto> getDocs() {
		return docs;
	}

	public void setDocs(List<AttachmentDto> docs) {
		this.docs = docs;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public List<CommodityGradualprice> getGprices() {
		return gprices;
	}

	public void setGprices(List<CommodityGradualprice> gprices) {
		this.gprices = gprices;
	}

	public List<CommodityGradualrebate> getGrebates() {
		return grebates;
	}

	public void setGrebates(List<CommodityGradualrebate> grebates) {
		this.grebates = grebates;
	}

	public Double getOprice() {
		return oprice;
	}

	public void setOprice(Double oprice) {
		this.oprice = oprice;
	}

	public Double getMaxcount() {
		return maxcount;
	}

	public void setMaxcount(Double maxcount) {
		this.maxcount = maxcount;
	}

	public Double getRetail() {
		return retail;
	}

	public void setRetail(Double retail) {
		this.retail = retail;
	}

	public Area getZone() {
		return zone;
	}

	public void setZone(Area zone) {
		this.zone = zone;
	}
	
}
