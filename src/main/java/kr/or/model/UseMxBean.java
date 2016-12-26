package kr.or.model;

import java.io.File;
import java.lang.management.ClassLoadingMXBean;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.lang.management.RuntimeMXBean;
import java.lang.management.ThreadMXBean;

import com.sun.management.OperatingSystemMXBean;

public class UseMxBean {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new UseMxBean();
	}

	/*
	 * 디스크용량
	 */
	private void showDisk() {
		File root = null;

		try {
			root = new File("/");

			System.out.println("Total Space: " + toMB(root.getTotalSpace()));
			System.out.println("Usable Space: " + toMB(root.getUsableSpace()));

			/* added by cafe mocha */
			//System.exit(0);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void showRuntime() {
		RuntimeMXBean runbean = (RuntimeMXBean) ManagementFactory.getRuntimeMXBean();
	}

	/*
	 * cpu 사용량
	 */
	public void showCPU(){
		final OperatingSystemMXBean osBean = (com.sun.management.OperatingSystemMXBean)ManagementFactory.getOperatingSystemMXBean();
		   
		   double load;
		 
		   while(true){
		     load = osBean.getSystemCpuLoad();
		     
		     if(load < 0.0)
		       continue;
		     
		     System.out.println("CPU Usage : "+load*100.0+"%");
		     try {
		       Thread.sleep(2000);
		     } catch (InterruptedException e) {
		       e.printStackTrace();
		     }
		   }
	}
	
	/*
	 * 메모리 사용량
	 */
	private void showMemory() {
		MemoryMXBean membean = (MemoryMXBean) ManagementFactory.getMemoryMXBean();

		MemoryUsage heap = membean.getHeapMemoryUsage();
		System.out.println("Heap Memory: " + heap.toString());

		MemoryUsage nonheap = membean.getNonHeapMemoryUsage();
		System.out.println("NonHeap Memory: " + nonheap.toString());

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

	/**
	 * OS 정보
	 */
	private void showOSBean() {

		OperatingSystemMXBean osbean = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();

		System.out.println("OS Name: " + osbean.getName());
		System.out.println("OS Arch: " + osbean.getArch());
		System.out.println("Available Processors: " + osbean.getAvailableProcessors());
		System.out.println("TotalPhysicalMemorySize: " + toMB(osbean.getTotalPhysicalMemorySize()));
		System.out.println("FreePhysicalMemorySize: " + toMB(osbean.getFreePhysicalMemorySize()));
		System.out.println("TotalSwapSpaceSize: " + toMB(osbean.getTotalSwapSpaceSize()));
		System.out.println("FreeSwapSpaceSize: " + toMB(osbean.getFreeSwapSpaceSize()));
		System.out.println("CommittedVirtualMemorySize: " + toMB(osbean.getCommittedVirtualMemorySize()));
		System.out.println("SystemLoadAverage: " + osbean.getSystemLoadAverage());

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
