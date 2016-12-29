package com.msg.service;

import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import com.sun.management.OperatingSystemMXBean;
/*
 * @Class : MemoryInfoService
 * @Date : 2017.01.05
 * @Desc : Memory 의 각종 정보를 담고 있는 클래스
*/

@Service
public class MemoryInfoService {
	
	/*
	 * @method name : showMemory
	 * @description : 총 메모리 용량, 사용 / 여유 메모리 공간의 크기를 구하는 함수
	*/
public Map<String, Long> showMemory() {
		
		OperatingSystemMXBean osmxb = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean(); 
		
		Long totalPhysicalMemorySize = osmxb.getTotalPhysicalMemorySize();
		Long usedPhysicalMemorySize = totalPhysicalMemorySize - osmxb.getFreePhysicalMemorySize();
		Long freePhysicalMemorySize = osmxb.getFreePhysicalMemorySize()/1024/1024;
		
		Map<String, Long> result = new HashMap<String, Long>();
		result.put("totalMemory", totalPhysicalMemorySize/1024/1024);
		result.put("freeMemory", freePhysicalMemorySize);
		result.put("usedMemory", usedPhysicalMemorySize/1024/1024);
		
		return result;
	}
}
