package com.msg.service;

import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

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
	public Map<String, String> showMemory() {
		MemoryMXBean membean = (MemoryMXBean) ManagementFactory.getMemoryMXBean();

		MemoryUsage heap = membean.getHeapMemoryUsage();

		MemoryUsage nonheap = membean.getNonHeapMemoryUsage();

		Map<String, String> result = new HashMap<String, String>();

		result.put("heap", heap.toString());
		result.put("nonheap", nonheap.toString());

		return result;
	}
}
