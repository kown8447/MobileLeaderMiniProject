package com.msg.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.msg.service.UseMxBean;

@Controller
public class MonitorController {
	
	@Autowired
	private View jsonview;
	
	@Autowired
	private UseMxBean useMxBean;
	
	@RequestMapping("/main.htm")
	public String goMonitorview(){
		return "monitorview";
	}
	
	@RequestMapping("cpuAjax.htm")
	public View getCpuInfo(Model model){
		double cpuUsage = useMxBean.showCPU();
		model.addAttribute("cpuUsage", cpuUsage);
		return jsonview;
	}
	
	@RequestMapping("memoryAjax.htm")
	public View getMemoryInfo(Model model){
		Map<String, String> memoryInfo = useMxBean.showMemory();
		model.addAttribute("memoryInfo", memoryInfo);
		return jsonview;
	}
	
	@RequestMapping("OsAjax.htm")
	public View getOsInfo(Model model){
		Map<String, Object> OsInfo = useMxBean.showOSBean();
		model.addAttribute("osInfo", OsInfo);
		return jsonview;
	}
	
	@RequestMapping("diskAjax.htm")
	public View getDiskInfo(Model model){
		Map<String, Integer> diskInfo = useMxBean.showDisk();
		model.addAttribute("diskInfo", diskInfo);
		return jsonview;
	}
}
