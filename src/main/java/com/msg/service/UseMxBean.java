package com.msg.service;

import java.io.File;
import java.lang.management.ClassLoadingMXBean;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.lang.management.RuntimeMXBean;
import java.lang.management.ThreadMXBean;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sun.management.OperatingSystemMXBean;

@Service
public class UseMxBean {

	/*
	 * 디스크용량
	 */
	public Map<String, String> showDisk() {
		File root = null;

		try {
			root = new File("/");

			System.out.println("Total Space: " + toMB(root.getTotalSpace()));
			System.out.println("Usable Space: " + toMB(root.getUsableSpace()));

			/* added by cafe mocha */
			// System.exit(0);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, String> diskInfo = new HashMap<String, String>();
		diskInfo.put("total", toMB(root.getTotalSpace()));
		diskInfo.put("usable", toMB(root.getUsableSpace()));
		return diskInfo;
	}

	private void showRuntime() {
		RuntimeMXBean runbean = (RuntimeMXBean) ManagementFactory.getRuntimeMXBean();
	}

	/*cpu 사용량*/
	public double showCPU() {
		final OperatingSystemMXBean osBean = (com.sun.management.OperatingSystemMXBean) ManagementFactory
				.getOperatingSystemMXBean();

		double load,cpuUsage;
		load = osBean.getSystemCpuLoad();
		cpuUsage = load*100.0;
		
		return cpuUsage;
	}

	/*메모리 사용량*/
	public Map<String, String> showMemory() {
		MemoryMXBean membean = (MemoryMXBean) ManagementFactory.getMemoryMXBean();

		MemoryUsage heap = membean.getHeapMemoryUsage();
		System.out.println("Heap Memory: " + heap.toString());

		MemoryUsage nonheap = membean.getNonHeapMemoryUsage();
		System.out.println("NonHeap Memory: " + nonheap.toString());
		
		Map<String, String> result = new HashMap<String, String>();
		
		result.put("heap", heap.toString());
		result.put("nonheap", nonheap.toString());
		
		return result;
	}

	private void showClassLoading() {
		ClassLoadingMXBean classbean = (ClassLoadingMXBean) ManagementFactory.getClassLoadingMXBean();

		System.out.println("TotalLoadedClassCount: " + classbean.getTotalLoadedClassCount());
		System.out.println("LoadedClassCount: " + classbean.getLoadedClassCount());
		System.out.println("UnloadedClassCount: " + classbean.getUnloadedClassCount());

	}

	private void showThreadBean() {
		ThreadMXBean tbean = (ThreadMXBean) ManagementFactory.getThreadMXBean();

		long[] ids = tbean.getAllThreadIds();

		System.out.println("Thread Count: " + tbean.getThreadCount());

		for (long id : ids) {
			System.out.println("Thread CPU Time(" + id + ")" + tbean.getThreadCpuTime(id));
			System.out.println("Thread User Time(" + id + ")" + tbean.getThreadCpuTime(id));
		}

	}

	/*OS 정보*/
	public Map<String, Object> showOSBean() {

		OperatingSystemMXBean osbean = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
		Map<String, Object> OsInfo = new HashMap<String, Object>();
		
		OsInfo.put("os1", osbean.getName());
		OsInfo.put("os2", osbean.getArch());
		OsInfo.put("os3", osbean.getAvailableProcessors());
		OsInfo.put("os4", toMB(osbean.getTotalPhysicalMemorySize()));
		OsInfo.put("os5", toMB(osbean.getFreePhysicalMemorySize()));
		OsInfo.put("os6", toMB(osbean.getTotalSwapSpaceSize()));
		OsInfo.put("os7", toMB(osbean.getFreeSwapSpaceSize()));
		OsInfo.put("os8", toMB(osbean.getCommittedVirtualMemorySize()));
		OsInfo.put("os9", osbean.getSystemLoadAverage());
		
		System.out.println("OS Name: " + osbean.getName());
		System.out.println("OS Arch: " + osbean.getArch());
		System.out.println("Available Processors: " + osbean.getAvailableProcessors());
		System.out.println("TotalPhysicalMemorySize: " + toMB(osbean.getTotalPhysicalMemorySize()));
		System.out.println("FreePhysicalMemorySize: " + toMB(osbean.getFreePhysicalMemorySize()));
		System.out.println("TotalSwapSpaceSize: " + toMB(osbean.getTotalSwapSpaceSize()));
		System.out.println("FreeSwapSpaceSize: " + toMB(osbean.getFreeSwapSpaceSize()));
		System.out.println("CommittedVirtualMemorySize: " + toMB(osbean.getCommittedVirtualMemorySize()));
		System.out.println("SystemLoadAverage: " + osbean.getSystemLoadAverage());
		
		return OsInfo;

	}

	public UseMxBean() {
		seperator();
		showOSBean();
		seperator();
		showThreadBean();
		seperator();
		showClassLoading();
		seperator();
		showMemory();
		seperator();
		showDisk();
		seperator();
		showCPU();
		seperator();
	}

	/* added cafe mocha 2009-06 */
	private void seperator() {
		System.out.println("-----------------------------------------------");
	}

	/* added cafe mocha 2009-06 */
	private String toMB(long size) {
		return (int) (size / (1024 * 1024)) + "(MB)";
	}

}
