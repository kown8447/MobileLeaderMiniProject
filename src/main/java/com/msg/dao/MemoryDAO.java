package com.msg.dao;

import java.util.HashMap;
import java.util.List;

import com.msg.dto.MemoryDTO;

public interface MemoryDAO {
	public int memoryInfoInsert(MemoryDTO dto);
	public List<MemoryDTO> getAllMemoryInfo();
	public List<MemoryDTO> getMemoryInfo(HashMap<String,String> startDate);
}
