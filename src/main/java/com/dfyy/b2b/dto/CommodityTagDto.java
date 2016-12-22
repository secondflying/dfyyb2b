package com.dfyy.b2b.dto;

import java.io.Serializable;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CommodityTagDto implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String image;
	private boolean hasright;
	private Integer column;
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
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public boolean isHasright() {
		return hasright;
	}
	public void setHasright(boolean hasright) {
		this.hasright = hasright;
	}
	public Integer getColumn() {
		return column;
	}
	public void setColumn(Integer column) {
		this.column = column;
	}
	
	

}
