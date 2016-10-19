package com.dfyy.b2b.web.form;

import java.io.Serializable;
import java.util.List;

import com.dfyy.b2b.bussiness.Area;
import com.dfyy.b2b.bussiness.UserType;
import com.dfyy.b2b.bussiness.Zone;
import com.dfyy.b2b.dto.AttachmentDto;

public class UserForm implements Serializable {

	private static final long serialVersionUID = 695199502414743668L;

	private String id;

	private String phone;

	private String password;
	
	private String alias;

	private UserType type;

	private String address;

	private String zipcode;

	private String contacts;

	private Double x;

	private Double y;

	private int zone;
	
	private String zonename;

	private List<AttachmentDto> docs;

	public UserForm() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public UserType getType() {
		return type;
	}

	public void setType(UserType type) {
		this.type = type;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
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

	public int getZone() {
		return zone;
	}

	public void setZone(int zone) {
		this.zone = zone;
	}

	public List<AttachmentDto> getDocs() {
		return docs;
	}

	public void setDocs(List<AttachmentDto> docs) {
		this.docs = docs;
	}

	public String getZonename() {
		return zonename;
	}

	public void setZonename(String zonename) {
		this.zonename = zonename;
	}
	
}
