package com.msg.scheduler;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import com.msg.dao.CpuDAO;
import com.msg.dao.MemoryDAO;
import com.msg.dto.CpuDTO;
import com.msg.dto.MemoryDTO;
import com.msg.service.CpuInfoService;
import com.msg.service.MemoryInfoService;

public class DataInsertScheduler {

	@Autowired private SqlSession sqlsession;
	@Autowired private CpuInfoService cpuservice;
	@Autowired private MemoryInfoService memoryservice;
	
<<<<<<< HEAD
	@Scheduled(fixedRate=5000000)
=======
	@Scheduled(fixedRate=300000)
>>>>>>> c9d862fdd360747eb4d4d23940f95035d5ae9591
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
	
<<<<<<< HEAD
	@Scheduled(fixedRate=5000000)
=======
	@Scheduled(fixedRate=300000)
>>>>>>> c9d862fdd360747eb4d4d23940f95035d5ae9591
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
