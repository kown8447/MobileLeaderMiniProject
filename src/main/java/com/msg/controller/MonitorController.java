package com.msg.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.msg.service.CpuInfoService;
import com.msg.service.DiskInfoService;
import com.msg.service.MemoryInfoService;
import com.msg.service.OsInfoService;
import com.msg.service.UseMxBean;


/*
 * @Class : MonitorController
 * @Date : 2017.01.03
 * @Desc : Controller Class 로 CPU, DISK, OS, Memory 정보를 가지는 Service 클래스에 접근하는 역할을 함
*/

@Controller
public class MonitorController {
	
	@Autowired private View jsonview;	//Ajax 비동기 통신을 위한 view 클래스
	@Autowired private CpuInfoService cpuInfoService;	//CPU 정보를 가지고 있는 서비스 클래스
	@Autowired private DiskInfoService diskInfoService;	//하드디스크 정보를 가지고 있는 서비스 클래스
	@Autowired private MemoryInfoService memoryInfoService;	//메모리 정보를 가지고 있는 서비스 클래스
	@Autowired private OsInfoService osInfoService;	//OS정보를 가지고 있는 서비스 클래스
	
	/*
	 * @method name : goMonitorview
	 * @description : 메인화면을 출력하기 위한 함수
	*/
	@RequestMapping("/main.htm")
	public String goMonitorview(){
		return "monitorview";
	}
	
	/*
	 * @method name : getCpuInfo
	 * @description : CPU 사용량을 비동기로 출력하기 위해 CpuInfoService 클래스를 호출하는 함수
	*/
	@RequestMapping("cpuAjax.htm")
	public View getCpuInfo(Model model){
		double cpuUsage = cpuInfoService.showCPU();
		model.addAttribute("cpuUsage", cpuUsage);
		return jsonview;
	}
	
	/*
	 * @method name : getMemoryInfo
	 * @description : 메모리 사용량을 비동기로 출력하기 위해 MemoryInfoService 클래스를 호출하는 함수
	*/
	@RequestMapping("memoryAjax.htm")
	public View getMemoryInfo(Model model){
		Map<String, Long> memoryInfo = memoryInfoService.showMemory();
		model.addAttribute("memoryInfo", memoryInfo);
		return jsonview;
	}
	
	/*
	 * @method name : getOsInfo
	 * @description : OS 기본정보를 비동기로 출력하기 위해 OsInfoService 클래스를 호출하는 함수
	*/
	@RequestMapping("OsAjax.htm")
	public View getOsInfo(Model model){
		Map<String, Object> OsInfo = osInfoService.showOSBean();
		model.addAttribute("osInfo", OsInfo);
		return jsonview;
	}
	
	/*
	 * @method name : getDiskInfo
	 * @description : 디스크 용량을 비동기로 출력하기 위해 diskInfoService 클래스를 호출하는 함수
	*/
	@RequestMapping("diskAjax.htm")
	public View getDiskInfo(Model model){
		Map<String, Double> diskInfo = diskInfoService.showAllDisk();
		model.addAttribute("diskInfo", diskInfo);
		return jsonview;
	}
	
	/*
	 * @method name : checkRunningProccess
	 * @description : 현재 실행되고 있는 프로세스 정보를 비동기로 출력하기 위해 CpuInfoService 클래스를 호출하는 함수
	*/
	@RequestMapping("checkProccess.htm")
	public View checkRunningProccess(Model model){
		List<Object> lists = cpuInfoService.checkRunningProcess();
		model.addAttribute("proccess", lists);
		return jsonview;
	}
	
	/*
	 * @method name : checkDiskDetail
	 * @description : 디스크의 파티션별 용량 정보를 비동기로 출력하기 위해 DiskInfoService 클래스를 호출하는 함수
	*/
	@RequestMapping("checkDiskDetail.htm")
	public View checkDiskDetail(Model model){
		List<Map<String, Object>> lists = diskInfoService.checkDiskDetail();
		model.addAttribute("disklist", lists);
		return jsonview;
	}
}
