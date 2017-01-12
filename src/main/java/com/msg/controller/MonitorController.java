package com.msg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import com.msg.dto.CpuDTO;
import com.msg.dto.MemoryDTO;
import com.msg.service.CpuInfoService;
import com.msg.service.DiskInfoService;
import com.msg.service.MemoryInfoService;
import com.msg.service.OsInfoService;


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
	
	
	@RequestMapping(value="/login.htm", method=RequestMethod.GET)
	public String goLogin(){
		return "login.login";
	}
	
	@RequestMapping("/loginFail.htm")
	public String goLoginFail(){
		return "login.loginFail";
	}
	
	/*
	 * @method name : goMonitorview
	 * @description : 메인화면을 출력하기 위한 함수
	*/
	@RequestMapping("/main.htm")
	public String goMonitorview(){
		return "home.main";
	}
	
	/*
	 * @method name : monitorview
	 * @description : 실시간 조회 페이지로 이동
	*/
	@RequestMapping("/admin.htm")
	@Secured("ROLE_ADMIN")
	public String monitorview(){
		return "admin.monitorview";
	} 
	
	/*
	 * @method name : goOsInfo
	 * @description : OS 정보 조회 페이지로 이동
	*/
	@RequestMapping("/osInfo.htm")
	public String goOsInfo(Model model){
		Map<String, Object> data = osInfoService.showOSBean();
		model.addAttribute("osInfo", data);
		return "os.osInfo";
	}
	
	/*
	 * @method name : goCpuInfo
	 * @description : cpu 정보 조회 페이지로 이동
	*/
	@RequestMapping("/cpuInfo.htm")
	public String goCpuInfo(Model model){
		List<CpuDTO> allcpuinfo = cpuInfoService.getAllCpuInfo();
		model.addAttribute("allcpuinfo", allcpuinfo);
		return "cpu.cpuInfo";
	}
	
	
	/*
	 * @method name : goMemoryInfo
	 * @description : memory 정보 조회 페이지로 이동
	*/
	@RequestMapping("/memoryInfo.htm")
	public String goMemoryInfo(Model model){
		List<MemoryDTO> list = memoryInfoService.getAllMemoryInfo();
		System.out.println(list);
		model.addAttribute("allmemory", list);
		return "memory.memoryInfo";
	}
	
	/*
	 * @method name : goDiskInfo
	 * @description : disk 정보 조회 페이지로 이동
	*/
	@RequestMapping("/diskInfo.htm")
	public String goDiskInfo(Model model){
		Map<String, Double> diskInfo = diskInfoService.showAllDisk();
		List<Map<String, Object>> disklist = diskInfoService.checkDiskDetail();
		model.addAttribute("diskInfo", diskInfo);
		model.addAttribute("disklist", disklist);
		return "disk.diskInfo";
	}
	
	/*
	 * @method name : getCpuInfoAjax
	 * @description : CPU 사용량을 비동기로 출력하기 위해 CpuInfoService 클래스를 호출하는 함수
	*/
	@RequestMapping("CpuInfoAjax.htm")
	public View getCpuInfoAjax(Model model, @RequestParam(value="searchhour") String searchhour){
		HashMap<String, String> cpusearch = new HashMap<String, String>();
		cpusearch.put("searchhour", searchhour);
		List<CpuDTO> list = cpuInfoService.getCpuInfoAjax(cpusearch);
		model.addAttribute("cpuUsage", list);
		return jsonview;
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
	 * @method name : getMemoryInfoAjax
	 * @description : 메모리 사용량을 비동기로 출력하기 위해 MemoryInfoService 클래스를 호출하는 함수
	 */
	@RequestMapping("memoryInfoAjax.htm")
	public View getMemoryInfoAjax(Model model, @RequestParam(value="startDate") String startDate){
		List<MemoryDTO> list = memoryInfoService.getAllMemoryInfo();
		model.addAttribute("allmemory", list);
		
		List<MemoryDTO> mList = null;
		Map<String, String> as = new HashMap<String, String>();
		mList = memoryInfoService.getMemoryInfo(as);
		model.addAttribute("selected", mList);
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
