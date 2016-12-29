package com.msg.service;

import java.io.File;
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
}
