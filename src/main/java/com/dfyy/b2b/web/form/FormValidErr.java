package com.dfyy.b2b.web.form;

public class FormValidErr {
	private String field;
	private String error;
	
	public FormValidErr(){
		
	}
	
	public FormValidErr(String f,String e){
		this.field = f;
		this.error = e;
	}
	
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
}
