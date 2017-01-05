package com.msg.dao;

import java.util.List;

import com.msg.dto.CpuDTO;

public interface CpuDAO {
	public int cpuInfoInsert(CpuDTO dto);
	public List<CpuDTO> getAllCpuInfo();
}
