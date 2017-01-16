package com.msg.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.lang.management.ClassLoadingMXBean;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.lang.management.RuntimeMXBean;
import java.lang.management.ThreadMXBean;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sun.management.OperatingSystemMXBean;

@Service
public class UseMxBean {

	/* 디스크용량(c drive only) */
	public Map<String, Integer> showDisk() {
		File root = null;

		try {
			root = new File("/");
			/* added by cafe mocha */
			// System.exit(0);

		} catch (Exception e) {
			e.printStackTrace();
		}

		Map<String, Integer> diskInfo = new HashMap<String, Integer>();
		diskInfo.put("total", toMBNonString(root.getTotalSpace()));
		diskInfo.put("usable", toMBNonString(root.getUsableSpace()));
		diskInfo.put("use", toMBNonString(root.getTotalSpace() - root.getUsableSpace()));
		return diskInfo;
	}

	/* 디스크용량(전체 파티션 포함) */
	public Map<String, Double> showAllDisk() {
		String drive; // 드라이브 명

		double size1, size2, size3;

		double totalSize = 0.0; // 드라이브의 최대 크기 = 용량
		double usableSize = 0.0; // 사용 가능한 크기
		double usedSize = 0.0; // 사용한 크기

		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2); // 소숫점 2자리까지만 보이게 변환

		File[] roots = File.listRoots();

		for (File root : roots) {
			drive = root.getAbsolutePath();
			size1 = root.getTotalSpace() / Math.pow(1024, 3);
			size2 = root.getUsableSpace() / Math.pow(1024, 3);
			size3 = size1 - size2;

			totalSize += size1;
			usableSize += size2;
			usedSize += size3;
		}

		Map<String, Double> diskInfo = new HashMap<String, Double>();
		diskInfo.put("total", Double.parseDouble(nf.format(totalSize)));
		diskInfo.put("usable", Double.parseDouble(nf.format(usableSize)));
		diskInfo.put("use", Double.parseDouble(nf.format(usedSize)));
		return diskInfo;
	}

	/* 디스크용량(파티션별 정보 출력) */
	public List<Map<String, Object>> checkDiskDetail() {
		String drive; // 드라이브 명
		List<Map<String, Object>> lists = new ArrayList<Map<String,Object>>();
		double size1, size2, size3;

		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2); // 소숫점 2자리까지만 보이게 변환

		File[] roots = File.listRoots();

		for (File root : roots) {
			drive = root.getAbsolutePath();
			size1 = root.getTotalSpace() / Math.pow(1024, 3);
			size2 = root.getUsableSpace() / Math.pow(1024, 3);
			size3 = size1 - size2;
			Map<String, Object> diskInfo = new HashMap<String, Object>();
			diskInfo.put("name", drive);
			diskInfo.put("total", Double.parseDouble(nf.format(size1)));
			diskInfo.put("usable", Double.parseDouble(nf.format(size2)));
			diskInfo.put("used", Double.parseDouble(nf.format(size3)));
			
			lists.add(diskInfo);
		}
		return lists;
	}
	
	
	private void showRuntime() {
		RuntimeMXBean runbean = (RuntimeMXBean) ManagementFactory.getRuntimeMXBean();
	}

	/* cpu 사용량 */
	public double showCPU() {
		final OperatingSystemMXBean osBean = (com.sun.management.OperatingSystemMXBean) ManagementFactory
				.getOperatingSystemMXBean();

		double load, cpuUsage;
		load = osBean.getSystemCpuLoad();
		cpuUsage = Math.round(load * 100.0);

		return cpuUsage;
	}

	/* 메모리 사용량 */
	public Map<String, String> showMemory() {
		MemoryMXBean membean = (MemoryMXBean) ManagementFactory.getMemoryMXBean();

		MemoryUsage heap = membean.getHeapMemoryUsage();

		MemoryUsage nonheap = membean.getNonHeapMemoryUsage();

		Map<String, String> result = new HashMap<String, String>();

		result.put("heap", heap.toString());
		result.put("nonheap", nonheap.toString());

		return result;
	}

	private void showClassLoading() {
		ClassLoadingMXBean classbean = (ClassLoadingMXBean) ManagementFactory.getClassLoadingMXBean();

	}

	private void showThreadBean() {
		ThreadMXBean tbean = (ThreadMXBean) ManagementFactory.getThreadMXBean();

		long[] ids = tbean.getAllThreadIds();

	}

	/* OS 정보 */
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

		return OsInfo;

	}

	/* 실행중인 프로세스 목록 */
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

	private String toMB(long size) {
		return (int) (size / (1024 * 1024)) + "(MB)";
	}

	private int toMBNonString(long size) {
		return (int) (size / (1024 * 1024));
	}

}
