package com.dfyy.b2b.web.form;

import java.io.Serializable;

public class AreaForm implements Serializable {

	private String parentarea;
	
	private String area;
	
	public AreaForm() {
	}

	public String getParentarea() {
		return parentarea;
	}

	public void setParentarea(String parentarea) {
		this.parentarea = parentarea;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}
	
	
}
