package com.spring.dto;

import java.sql.Date;

public class CpuDTO {
	private Date regdate;
	private int cpuusage;
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getCpuusage() {
		return cpuusage;
	}
	public void setCpuusage(int cpuusage) {
		this.cpuusage = cpuusage;
	}
	@Override
	public String toString() {
		return "CpuDTO [regdate=" + regdate + ", cpuusage=" + cpuusage + "]";
	}
}
