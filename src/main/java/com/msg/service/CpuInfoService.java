package com.msg.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.lang.management.ManagementFactory;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msg.dao.CpuDAO;
import com.msg.dto.CpuDTO;
import com.sun.management.OperatingSystemMXBean;

/*
 * @Class : CpuInfoService
 * @Date : 2017.01.05
 * @Desc : CPU의 각종 정보를 담고 있는 클래스
*/

@Service
public class CpuInfoService {
	
	@Autowired private SqlSession sqlsession;
	
	/*
	 * @method name : showCPU
	 * @description : CPU 사용량을 측정하기 위한 함수. 반환형은 double 이며 소수점은 버리지 않음
	*/
	public double showCPU() {
		final OperatingSystemMXBean osBean = (com.sun.management.OperatingSystemMXBean) ManagementFactory
				.getOperatingSystemMXBean();

		double load, cpuUsage;
		load = osBean.getSystemCpuLoad();
		cpuUsage = Math.round(load * 100.0);

		return cpuUsage;
	}
	
	/*
	 * @method name : checkRunningProcess
	 * @description : 
	 * 현재 실행중인 프로세스의 목록을 호출함
	 * 각 프로세스의 프로세스 이름, PID, 세션이름, 메모리 사용량을 호출함
	 * 반환형은 List<Object>로 tasklist.exe 결과값을 Line 단위로 add 함
	*/
	public List<Object> checkRunningProcess() {
		List<Object> processes = new ArrayList<Object>();
		try {
			String line;
			String[] result;
			Process p = Runtime.getRuntime().exec("tasklist.exe /FO csv");
			BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
			int index = 0;
			while ((line = input.readLine()) != null) {
				index++;
				if (index == 1)
					continue;
				if (!line.trim().equals("")) {
					// processes.add(line.substring(0, line.indexOf(" ")));
					processes.add(line);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return processes;
	}
	
	/*
	 * @method name : getAllCpuInfo
	 * @description : 
	 * CPU DB내의 있는 모든 정보를 가져옴
	*/
	public List<CpuDTO> getAllCpuInfo(){
		CpuDAO dao = sqlsession.getMapper(CpuDAO.class);
		List<CpuDTO> result = dao.getAllCpuInfo();
		return result;
	}
	
	/*
	 * @method name : getCpuhour
	 * @description : 
	 * CPU 1시간, 3시간, 6시간의 DB에 있는 정보를 가져옴
	*/
	public List<CpuDTO> getCpuInfo(HashMap<String, String> cpusearch){
		CpuDAO dao = sqlsession.getMapper(CpuDAO.class);	
		System.out.println("service [cpusearch] ///" + cpusearch);
		List<CpuDTO> list = dao.getCpuInfo(cpusearch);
		System.out.println("service [list] ///" + list);
		return list;
	}
}
