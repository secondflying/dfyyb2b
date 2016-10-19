package com.dfyy.b2b.web.form;

import java.io.Serializable;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.dfyy.b2b.dto.AttachmentDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CommodityForm implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer id;
	private int status;
	private String userid;
	private String name;
	private String image;
	private Integer exchange;
	private Integer number;
	private String description;
	private List<AttachmentDto> docs;


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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public List<AttachmentDto> getDocs() {
		return docs;
	}

	public void setDocs(List<AttachmentDto> docs) {
		this.docs = docs;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

}
