package com.msg.dto;

import java.sql.Date;

public class CpuDTO {
	private String regdate;
	private int cpuusage;
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
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
