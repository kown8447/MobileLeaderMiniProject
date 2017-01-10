package com.msg.dao;

import java.util.List;
import java.util.Map;

import com.msg.dto.CpuDTO;

public interface CpuDAO {
	public int cpuInfoInsert(CpuDTO dto);
	public List<CpuDTO> getAllCpuInfo();
	public List<CpuDTO> getCpuhour(int searchhour);
}
