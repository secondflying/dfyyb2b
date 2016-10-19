package com.dfyy.b2b.dto;

import java.io.Serializable;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ProkerageDto implements Serializable {

	private static final long serialVersionUID = 8617747454891897376L;
	
	private int id;
	
	private String name;

	private int category;
	
	private int status;

	private String image;
	
	private double platform;
	
	private double partner;
	
	private int pid;
	
	private List<ProkerageDto> childs;
	
	public ProkerageDto(int i,String n,int c,int s,String im,double pl,double pa,int pi) {
		// TODO Auto-generated constructor stub
		id = i;
		name = n;
		category = c;
		status = s;
		image = im;
		platform = pl;
		partner = pa;
		pid = pi;
	}
	
	public ProkerageDto(Object[] o){
		id = (int)o[0];
		name = String.valueOf(o[1]);
		category = (int)o[2];
		status = (int)o[3];
		image = o[4]==null?null:String.valueOf(o[4]);
		platform = o[5]==null?0:(double)o[5];
		partner = o[6]==null?0:(double)o[6];
		pid = o[7]==null?0:(int)o[7];
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public double getPlatform() {
		return platform;
	}

	public void setPlatform(double platform) {
		this.platform = platform;
	}

	public double getPartner() {
		return partner;
	}

	public void setPartner(double partner) {
		this.partner = partner;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public List<ProkerageDto> getChilds() {
		return childs;
	}

	public void setChilds(List<ProkerageDto> childs) {
		this.childs = childs;
	}
	
}
