package com.msg.dto;

import java.sql.Date;

public class MemoryDTO {
	private Date regdate;
	private long usedmemory;
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public long getUsedmemory() {
		return usedmemory;
	}
	public void setUsedmemory(long usedmemory) {
		this.usedmemory = usedmemory;
	}
	@Override
	public String toString() {
		return "MemoryDTO [regdate=" + regdate + ", usedmemory=" + usedmemory + "]";
	}
}
