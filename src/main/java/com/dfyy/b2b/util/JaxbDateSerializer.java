package com.dfyy.b2b.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.xml.bind.annotation.adapters.XmlAdapter;

public class JaxbDateSerializer extends XmlAdapter<String, Date> {

	@Override
	public String marshal(Date date) throws Exception {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
	}

	@Override
	public Date unmarshal(String date) throws Exception {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
	}

}
