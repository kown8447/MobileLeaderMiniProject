package com.msg.dto;

public class MemoryDTO {
	private String regdate;
	private long usedmemory;
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
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
