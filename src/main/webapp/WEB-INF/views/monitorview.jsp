<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script>
	$(function(){
		$.ajax(
			{
				url:"OsAjax.htm",
				dataType:"json",
				success:function(data){
					$('#os1').text(data.osInfo.os1);
					$('#os2').text(data.osInfo.os2);
					$('#os3').text(data.osInfo.os3);
					$('#os4').text(data.osInfo.os4);
					$('#os5').text(data.osInfo.os5);
					$('#os6').text(data.osInfo.os6);
					$('#os7').text(data.osInfo.os7);
					$('#os8').text(data.osInfo.os8);
					$('#os9').text(data.osInfo.os9);
				}
			}
		);
		
		cpuUsage = setInterval(function() {
			$.ajax(
					{
						url:"cpuAjax.htm",
						dataType:"json",
						success:function(data){
							$('#cpuUsage').text(data.cpuUsage+'%');
						}
					}		
				);
		}, 1000);
		
		memoryInfo = setInterval(function() {
			$.ajax(
					{
						url:"memoryAjax.htm",
						dataType:"json",
						success:function(data){
							$('#heap').text(data.memoryInfo.heap);
							$('#nonheap').text(data.memoryInfo.nonheap);
						}
					}		
				);
		}, 1000);
		
		$.ajax(
				{
					url:"diskAjax.htm",
					dataType:"json",
					success:function(data){
						$('#total').text(data.diskInfo.total);
						$('#usable').text(data.diskInfo.usable);
					}
				}
			);
		
	});
</script>

<title>Server System Monitor</title>
</head>
<body>
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
	cpu 사용량 : <div id="cpuUsage"></div><br>
	heapMemory 사용량 : <div id="heap"></div><br>
	NonheapMemory 사용량 : <div id="nonheap"></div><br>
	disk 공간 : <div id="total"></div><br>
	disk 사용가능 공간 : <div id="usable"></div>
</body>
</html>