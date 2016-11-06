package com.dfyy.b2b.dto;

import java.io.Serializable;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import com.dfyy.b2b.bussiness.NzdMember;

@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
public class NzdMembersResult implements Serializable {

	private static final long serialVersionUID = 1115896407880849098L;

	@XmlElement
	private long lastTime;

	@XmlElementWrapper
	@XmlElementRef
	private List<NzdMember> results;

	public NzdMembersResult() {
	}

	public List<NzdMember> getResults() {
		return results;
	}

	public void setResults(List<NzdMember> results) {
		this.results = results;
	}

	public long getLastTime() {
		return lastTime;
	}

	public void setLastTime(long lastTime) {
		this.lastTime = lastTime;
	}

}
