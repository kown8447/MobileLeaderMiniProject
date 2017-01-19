package com.msg.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

/*
 * @Class : CpuInfoService
 * @Date : 2017.01.04
 * @Desc : Disk 의 각종 정보를 담고 있는 클래스
*/

@Service
public class DiskInfoService {
	
	/*
	 * @method name : showDisk
	 * @description : Disk의 용량을 구하는 함수로, C: 의 용량만 구함
	*/
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
		diskInfo.put("total", toMBNonString(root.getTotalSpace()));	//총 용량
		diskInfo.put("usable", toMBNonString(root.getUsableSpace()));	//사용 가능한 용량
		diskInfo.put("use", toMBNonString(root.getTotalSpace() - root.getUsableSpace()));	//사용한 용량
		return diskInfo;
	}

	/*
	 * @method name : showAllDisk
	 * @description : 각 파티션별 용량을 구한 후, 파티션의 용량을 합쳐서 총용량 / 총 사용 용량 / 총 사용 가능 용량을 구함
	*/
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

	/*
	 * @method name : checkDiskDetail
	 * @description : 각 파티션별 용량을 구하되, showAllDisk 와는 달리 파티션별 용량을 합치지 않고, 각 파티션별 정보를 Map클래스에 담아서 반환함
	*/
	public List<Map<String, Object>> checkDiskDetail() {
		String drive; // 드라이브 명
		List<Map<String, Object>> lists = new ArrayList<Map<String, Object>>();
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
	
	/*
	 * @method name : executeCrystalDiskInfo
	 * @description : crystalDiskInfo.exe 를 실행시켜, log를 통한 disk 수명을 확인하고 정보를 return 하는 함수
	*/
	public Map<String, String> executeCrystalDiskInfo(){
		String directory ="D:\\diskinfo\\DiskInfo.exe";
		Runtime rt = Runtime.getRuntime();
		Process p;
		BufferedReader br = null;
		FileInputStream fis = null;
		InputStreamReader isr = null;
		File file = new File("D:\\diskinfo\\Smart\\RevuAhn_950X NeoFD0707581A1200059504\\Smart.ini");
		String temp ="";
		String content = "";
		String healthStatus="";
		String temperature="";
		String powerOnCount="";
		String powerOnHours="";
		Map<String, String> result = new HashMap<String, String>();
		
		try {
			p = rt.exec(directory);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			fis = new FileInputStream(file);
			isr = new InputStreamReader(fis, "UTF-8");
			br = new BufferedReader(isr);
			
			while((temp = br.readLine())!=null){
				if(temp.contains("HealthStatus")){
					String[] split = temp.split("=");
					healthStatus = split[1];
					result.put("healthStatus", healthStatus);
				}else if(temp.contains("Temperature")){
					String[] split = temp.split("=");
					temperature = split[1];
					result.put("temperature", temperature);
				}else if(temp.contains("PowerOnCount")){
					String[] split = temp.split("=");
					powerOnCount = split[1];
					result.put("powerOnCount", powerOnCount);
				}else if(temp.contains("PowerOnHours")){
					String[] split = temp.split("=");
					powerOnHours = split[1];
					result.put("powerOnHours", powerOnHours);
				}
				content += temp + "\n";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
