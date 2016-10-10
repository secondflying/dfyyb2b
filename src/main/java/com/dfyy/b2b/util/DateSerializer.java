package com.dfyy.b2b.util;

import java.util.Date;

import javax.xml.bind.annotation.adapters.XmlAdapter;

public class DateSerializer extends XmlAdapter<String, Date> {

	@Override 
    public String marshal(Date date) throws Exception { 
        return MyConstants.dateFormat1.format(date); 
    } 

    @Override 
    public Date unmarshal(String date) throws Exception { 
        return MyConstants.dateFormat1.parse(date); 
    }

}
