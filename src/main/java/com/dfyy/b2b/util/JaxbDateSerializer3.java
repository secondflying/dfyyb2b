package com.dfyy.b2b.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.xml.bind.annotation.adapters.XmlAdapter;

public class JaxbDateSerializer3 extends XmlAdapter<String, Date> {

	@Override
	public String marshal(Date date) throws Exception {
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}

	@Override
	public Date unmarshal(String date) throws Exception {
		return new SimpleDateFormat("yyyy-MM-dd").parse(date);
	}

}
