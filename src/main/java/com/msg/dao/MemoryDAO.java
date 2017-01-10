package com.msg.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.msg.dto.MemoryDTO;

public interface MemoryDAO {
	public int memoryInfoInsert(MemoryDTO dto);
	public List<MemoryDTO> getAllMemoryInfo();
	public List<MemoryDTO> getMemoryInfo(Map<String,String> startDate);
}
