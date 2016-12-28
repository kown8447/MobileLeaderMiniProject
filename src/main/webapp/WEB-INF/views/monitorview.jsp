<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
<style type="text/css">
			.highcharts-yaxis-grid .highcharts-grid-line {
				display: none;
			}
</style>
<script src="${pageContext.request.contextPath}/js/monitorview.js" type="text/javascript"></script>

<title>Server System Monitor</title>
</head>
<body>
	<div class="row">
		<div class="col-md-6">
			<table class="table">
				<tr style="text-align:center"><td colspan="2">OS 정보</td></tr>
				<tr><td>OS name</td><td id="os1"></td></tr>
				<tr><td>OS Arch</td><td id="os2"></td></tr>
				<tr><td>Available Processors</td><td id="os3"></td></tr>
				<tr><td>TotalPhysicalMemorySize</td><td id="os4"></td></tr>
				<tr><td>FreePhysicalMemorySize</td><td id="os5"></td></tr>
				<tr><td>TotalSwapSpaceSize</td><td id="os6"></td></tr>
				<tr><td>FreeSwapSpaceSize</td><td id="os7"></td></tr>
				<tr><td>CommittedVirtualMemorySize</td><td id="os8"></td></tr>
				<tr><td>SystemLoadAverage</td><td id="os9"></td></tr>
			</table>
		</div>
		<div class="col-md-6">
			cpu 사용량 : <div id="cpuUsage"></div><br>
			<div style="width: 700px; height: 400px; margin: 0 auto">
    			<div id="cpuusagechart1" style="width: 300px; height: 200px; float: left"></div>
				<div id="cpuusagechart2" style="width: 310px; height: 200px; float: left; margin: 0 auto"></div>
			</div>
		</div>
	</div>	
	<div class="row">
		<div class="col-md-6">
			heapMemory 사용량 : <div id="heap"></div><br>
			NonheapMemory 사용량 : <div id="nonheap"></div><br>
		</div>
		<div class="col-md-6">
			disk 공간 : <div id="total"></div><br>
			disk 사용한 공간 : <div id="use"></div><br>
			disk 사용가능 공간 : <div id="usable"></div>
			<div id="container" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>
		</div>
	</div>
</body>
</html>