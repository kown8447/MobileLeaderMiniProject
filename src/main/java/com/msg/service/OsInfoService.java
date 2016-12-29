package com.msg.service;

import java.lang.management.ManagementFactory;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sun.management.OperatingSystemMXBean;

/*
 * @Class : showOSBean
 * @Date : 2017.01.05
 * @Desc : OS 의 각종 정보를 담고 있는 클래스
*/

@Service
public class OsInfoService {
	/*
	 * @method name : showOSBean
	 * @description : OS 정보를 구하는 함수
	*/
	public Map<String, Object> showOSBean() {

		OperatingSystemMXBean osbean = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
		Map<String, Object> OsInfo = new HashMap<String, Object>();

		OsInfo.put("os1", osbean.getName());	//OS 이름
		OsInfo.put("os2", osbean.getArch());	//OS 아키텍쳐 이름
		OsInfo.put("os3", osbean.getAvailableProcessors());	//가용한 프로세서 수
		OsInfo.put("os4", toMB(osbean.getTotalPhysicalMemorySize()));	//전체 물리 메모리 크기
		OsInfo.put("os5", toMB(osbean.getFreePhysicalMemorySize()));	//사용가능한 물리 메모리 크기
		OsInfo.put("os6", toMB(osbean.getTotalSwapSpaceSize()));	//전체 Swap 메모리 크기
		OsInfo.put("os7", toMB(osbean.getFreeSwapSpaceSize()));		//사용가능한 Swap 메모리 크기
		OsInfo.put("os8", toMB(osbean.getCommittedVirtualMemorySize()));	//실제 사용되고 있는 가상메모리 크기

		return OsInfo;

	}
	
	/*
	 * @method name : toMB
	 * @description : MB 단위로 변환 후 MB String 을 합침
	*/
	private String toMB(long size) {
		return (int) (size / (1024 * 1024)) + "(MB)";
	}

	/*
	 * @method name : toMBNonString
	 * @description : MB 단위로 변환만 하는 함수
	*/
	private int toMBNonString(long size) {
		return (int) (size / (1024 * 1024));
	}
}
