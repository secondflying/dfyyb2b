package com.dfyy.b2b.web.form;

import java.io.Serializable;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CommodityForm implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer id;
	private String name;
	private String image;
	private Integer exchange;
	private Integer number;
	private String description;

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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Integer getExchange() {
		return exchange;
	}

	public void setExchange(Integer exchange) {
		this.exchange = exchange;
	}

}
