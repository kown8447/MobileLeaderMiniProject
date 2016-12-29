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
		/*// 총 물리적 메모리 + 가상 메모리 
		long totalvirtualMemory = osmxb.getTotalSwapSpaceSize(); 
		// 남은 물리적 메모리 
		long freePhysicalMemorySize = osmxb.getFreePhysicalMemorySize();
		System.out.println("자꾸 내 이름으로"+(totalvirtualMemory/1024.0/1024.0/1024.0));
		System.out.println("메모리 사용량 : "+((totalvirtualMemory-freePhysicalMemorySize)/1024.0/1024.0/1024.0));
		Double compare=(Double)(1-freePhysicalMemorySize*1.0/totalvirtualMemory)*100; 
		String str="메모리 이미 사용:"+compare.intValue()+"%";*/
		
		Long totalPhysicalMemorySize = osmxb.getTotalPhysicalMemorySize();
		Long usedPhysicalMemorySize = totalPhysicalMemorySize - osmxb.getFreePhysicalMemorySize();
		Long freePhysicalMemorySize = osmxb.getFreePhysicalMemorySize()/1024/1024;
		//Double usedPhysicalMemory = Double.parseDouble(String.format("%.2f",usedPhysicalMemorySize/1024/1024/1024.0));
		
		//System.out.println("totalMemory : " + totalPhysicalMemorySize/1024/1024);
		//System.out.println("freeMemory : " + freePhysicalMemorySize);
		//System.out.println("usedMemory : " + usedPhysicalMemorySize/1024/1024);
		//System.out.println("usedMemory(GB) : " + usedPhysicalMemory);
		
		Map<String, Long> result = new HashMap<String, Long>();
		result.put("totalMemory", totalPhysicalMemorySize/1024/1024);
		result.put("freeMemory", freePhysicalMemorySize);
		result.put("usedMemory", usedPhysicalMemorySize/1024/1024);
		//result.put("usedMemoryByGB", usedPhysicalMemory);
		
		/*MemoryMXBean membean = (MemoryMXBean) ManagementFactory.getMemoryMXBean();
		
		MemoryUsage heap = membean.getHeapMemoryUsage();
		System.out.println("Heap Memory: " + heap.toString());
		System.out.println("Used Heap Memory: " + heap.getUsed()/1024);
		System.out.println("Max Heap Memory: " + heap.getMax()/1024);
		
		MemoryUsage nonheap = membean.getNonHeapMemoryUsage();
		System.out.println("NonHeap Memory: " + nonheap.toString());
		
		//Map<String, String> result = new HashMap<String, String>();
		Map<String, Long> result = new HashMap<String, Long>();
		
		//result.put("heap", heap.toString());
		result.put("heap", heap.getUsed()/1024);
		result.put("maxHeap", heap.getMax()/1024);
		//result.put("nonheap", nonheap.toString());
		result.put("nonheap", nonheap.getUsed()/1024);
		result.put("maxNonHeap", nonheap.getMax()/1024);*/
		
		return result;
	}
}
