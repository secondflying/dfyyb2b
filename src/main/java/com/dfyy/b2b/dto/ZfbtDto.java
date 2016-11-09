package com.dfyy.b2b.dto;

import java.io.Serializable;
import java.util.Date;

import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.dfyy.b2b.util.JaxbDateSerializer;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ZfbtDto implements Serializable {
	private static final long serialVersionUID = -6135073320882326519L;

	private String nzd;
	private int cid;
	private int count;
	private Double nprice;
	private Double oprice;
	private Double size;
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date starttime;
	@XmlJavaTypeAdapter(JaxbDateSerializer.class)
	private Date endtime;
	private Integer maxbuy;
	private boolean useCoupon;
	private Integer coupon;
	private Integer couponMax;
	private int zone;

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

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
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

	public Integer getMaxbuy() {
		return maxbuy;
	}

	public void setMaxbuy(Integer maxbuy) {
		this.maxbuy = maxbuy;
	}

	public boolean isUseCoupon() {
		return useCoupon;
	}

	public void setUseCoupon(boolean useCoupon) {
		this.useCoupon = useCoupon;
	}

	public Integer getCoupon() {
		return coupon;
	}

	public void setCoupon(Integer coupon) {
		this.coupon = coupon;
	}

	public Integer getCouponMax() {
		return couponMax;
	}

	public void setCouponMax(Integer couponMax) {
		this.couponMax = couponMax;
	}

	public int getZone() {
		return zone;
	}

	public void setZone(int zone) {
		this.zone = zone;
	}

	public Double getSize() {
		return size;
	}

	public void setSize(Double size) {
		this.size = size;
	}

}
