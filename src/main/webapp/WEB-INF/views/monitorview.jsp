<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
			<table class="table table-striped table-condensed table-hover" style="width: 80%; margin-left: 3%; margin-top: 7%">
				<tr><th colspan="2" style="text-align: center">OS 정보</td></tr>
				<tr><td style="width: 50%">OS name</td><td id="os1" style="text-align: center"></td></tr>
				<tr><td style="width: 50%">OS Arch</td><td id="os2" style="text-align: center"></td></tr>
				<tr><td style="width: 50%">Available Processors</td><td id="os3" style="text-align: center"></td></tr>
				<tr><td style="width: 50%">TotalPhysicalMemorySize</td><td id="os4" style="text-align: center"></td></tr>
				<tr><td style="width: 50%">FreePhysicalMemorySize</td><td id="os5" style="text-align: center"></td></tr>
				<tr><td style="width: 50%">TotalSwapSpaceSize</td><td id="os6" style="text-align: center"></td></tr>
				<tr><td style="width: 50%">FreeSwapSpaceSize</td><td id="os7" style="text-align: center"></td></tr>
				<tr><td style="width: 50%">CommittedVirtualMemorySize</td><td id="os8" style="text-align: center"></td></tr>
			</table>
		</div>
		<div class="col-md-6">
			<form class="form-inline" style="text-align: center; margin-top: 5%">
				<div class="form-group">
					<label for="exampleInputName2" style="color: blue">cpu 사용량 :</label> 
					<span id="cpuUsage"></span>
					<div align="right">
						<input type="button" class="btn btn-default" id="checkProcess" value="실행중인 프로세스 확인">
					</div>
				</div>
			</form>
   			<div class="row" id="cpuusagechart1" style="width: 450px; height: 200px; float: left; margin-top: 5%"></div>
			<div class="row" id="cpuusagechart2" style="width: 450px; height: 200px; float: left; margin: 5% auto"></div>
		</div>
	</div>	
	<div class="row">
		<div class="col-md-6">
			heapMemory 사용량 : <div id="heap"></div><br>
			NonheapMemory 사용량 : <div id="nonheap"></div><br>
		</div>
		<div class="col-md-2" style="margin-top: 10%">
			<form class="form-inline">
				<div class="form-group">
					<label for="exampleInputName2">전체 공간</label> 
					<span id="total"></span>
				</div>
			</form>
			<form class="form-inline">
				<div class="form-group">
					<label for="exampleInputName2" style="color:red">사용 공간</label> 
					<span id="use"></span>
				</div>
			</form>
			<form class="form-inline">
				<div class="form-group">
					<label for="exampleInputName2" style="color:blue">사용가능 공간</label> 
					<span id="usable"></span>
				</div>
			</form>
			<input type="button" id="checkDiskDetail" class="btn btn-default" value="파티션별 용량 확인"/>
		</div>
		<div class="col-md-4">
			<div id="container" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>
		</div>
	</div>

	<div class="modal fade" id="layerpop">
		<div class="modal-dialog modal-lg">
			<div class="modal-content modal-lg">
				<!-- header -->
				<div class="modal-header">
					<!-- 닫기(x) 버튼 -->
					<button type="button" class="close" data-dismiss="modal">×</button>
					<!-- header title -->
					<h4 class="modal-title">실행중인 프로세스 목록</h4>
				</div>
				<!-- body -->
				<div class="modal-body" id="modalBody">
					<table id="resultTable" class="table table-bordered">
						<tr>
							<th>Proccess Name</th><th>PID</th><th>Session Name</th><th>Memory Usage</th>
						</tr>
					</table>
				</div>
				<!-- Footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="diskDetail">
		<div class="modal-dialog modal-lg">
			<div class="modal-content modal-lg">
				<!-- header -->
				<div class="modal-header">
					<!-- 닫기(x) 버튼 -->
					<button type="button" class="close" data-dismiss="modal">×</button>
					<!-- header title -->
					<h4 class="modal-title">파티션별 디스트 용량</h4>
				</div>
				<!-- body -->
				<div class="modal-body" id="modalBody">
					<table id="resultDiskDetail" class="table table-bordered">
						<tr>
							<th>Disk Name</th><th>Total Size(GB)</th><th>Usable Size(GB)</th><th>Used Size(GB)</th>
						</tr>
					</table>
				</div>
				<!-- Footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	
</body>
</html>