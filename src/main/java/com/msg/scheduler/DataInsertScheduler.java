package com.msg.scheduler;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.msg.dao.CpuDAO;
import com.msg.dao.MemoryDAO;
import com.msg.service.CpuInfoService;
import com.msg.service.MemoryInfoService;
import com.spring.dto.CpuDTO;
import com.spring.dto.MemoryDTO;

public class DataInsertScheduler {

	@Autowired private SqlSession sqlsession;
	@Autowired private CpuInfoService cpuservice;
	@Autowired private MemoryInfoService memoryservice;
	
	//@Scheduled(fixedRate=10000)
	public void cpuDataInsert(){
		System.out.println("cpu 삽입 스케쥴러...");
		CpuDAO dao = sqlsession.getMapper(CpuDAO.class);
		CpuDTO dto = new CpuDTO();
		double cpuusage = cpuservice.showCPU();
		dto.setCpuusage((int)cpuusage);
		try {
			dao.cpuInfoInsert(dto);
		} catch (Exception e) {
			System.out.println("cpuinfo 삽입 실패 : " + e.getMessage());
		}
	}
	
	//@Scheduled(fixedRate=10000)
	public void memoryDataInsert(){
		System.out.println("memory 삽입 스케쥴러...");
		MemoryDAO dao = sqlsession.getMapper(MemoryDAO.class);
		MemoryDTO dto = new MemoryDTO();
		Map<String, Long> memorydata = memoryservice.showMemory();
		long usedmemory = memorydata.get("usedMemory");
		dto.setUsedmemory(usedmemory);
		try {
			dao.memoryInfoInsert(dto);
		} catch (Exception e) {
			System.out.println("memoryinfo 삽입 실패 : " + e.getMessage());
		}
	}
}