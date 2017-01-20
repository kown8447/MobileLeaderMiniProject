<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
	@project : MSG SystemMonitor
	@File name : monitorview.jsp
	@Date : 2017.01.09
	@Desc : CPU, Memory, Disk, OS 정보를 한 화면에 4분할 하여 대시보드 형태로 출력하는 View 페이지 
 -->

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
	<div class="page-header">
		<h1><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>  실시간 정보</h1>
	</div>
	<div style="width:100%; height:70%; marin:0 auto;">
		<div class="row">
			<!-------------------------------------------------------------------------- 
							OS 정보를 Table 형태로 보여주는 부분
			 ---------------------------------------------------------------------------->
			<div class="col-md-4" style="width: 24%">
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
			<div class="col-md-4" style="width: 24%">
				<!-------------------------------------------------------------------------- 
								DISK 용량을 텍스트 형태로 보여주는 부분
				 ---------------------------------------------------------------------------->
				<div class="row" style="margin-top: 10%">
					<form class="form-inline">
						<div class="form-group">
							<label for="exampleInputName2">전체 공간</label> 
							<span id="total"></span>
						</div>
					</form>
					<form class="form-inline">
						<div class="form-group">
							<label for="exampleInputName2" style="color:#AE758A">사용 공간</label> 
							<span id="use"></span>
						</div>
					</form>
					<form class="form-inline">
						<div class="form-group">
							<label for="exampleInputName2" style="color:#AACCE2">사용가능 공간</label> 
							<span id="usable"></span>
						</div>
					</form>
					<input type="button" id="checkDiskDetail" class="btn btn-default" value="파티션별 용량 확인"/>
					<input type="button" id="execCrystalDiskInfo" class="btn btn-success" value="디스크 수명 확인"/>
				</div>
				<!-------------------------------------------------------------------------- 
							DISK 용량을 Chart 형태로 보여주는 부분
			 	---------------------------------------------------------------------------->
				<div class="row">
					<div id="container" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>
				</div>
			</div>
			<div class="col-md-4" style="width: 24%">
				<!-------------------------------------------------------------------------- 
							MEMORY 사용량을 Percentage로 보여주는 부분
			 	---------------------------------------------------------------------------->
				<div class="row" style="height:280px; margin-left: 10%">
					<div id="usedMemoryByGB" style="height:100px; position : relative; margin-top:5%;"></div>
					<div id="memoryChart" style="height:200px; margin: 0 auto;"></div>
				</div>
				<!-------------------------------------------------------------------------- 
							MEMORY 사용량을 그래프 형태로 보여주는 부분
				---------------------------------------------------------------------------->	
				<div class="row" style="height:280px; margin-left: 10%">
					<div id="usedMemory" style="height:15%; position : relative; margin-top:10%;"></div>
					<div id="memoryContainer" style="height:85%; margin: 0 auto;"></div>
				</div>
			</div>
			<div class="col-md-4" style="width: 24%">
				<!-------------------------------------------------------------------------- 
							CPU 사용량을 텍스트 형식으로 보여주는 부분
			 	---------------------------------------------------------------------------->
				<form class="form-inline" style="text-align: center; height:100px; margin-top: 5%">
					<div class="form-group">
						<label for="exampleInputName2">cpu 사용량 :</label> 
						<span id="cpuUsage"></span>
						<div align="right">
							<input type="button" class="btn btn-default" id="checkProcess" value="실행중인 프로세스 확인">
						</div>
					</div>
				</form>
				<!-------------------------------------------------------------------------- 
							CPU 사용량을 Chart 형태로 보여주는 부분
			 	---------------------------------------------------------------------------->
				<div class="row" id="cpuusagechart1" style="width:300px; height:180px; margin: 0 auto;"></div>
				<div class="row" id="cpuusagechart2" style="height:300px; margin: 0 auto;"></div>
			</div>
			
			<!-------------------------------------------------------------------------- 
							현재 실행중인 프로세스 정보를 출력하는 Modal 부분
			 ---------------------------------------------------------------------------->
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
		
			<!-------------------------------------------------------------------------- 
							파티션별 DISK 용량을 출력하는 Modal 부분
			 ---------------------------------------------------------------------------->
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
			
			
			<!-------------------------------------------------------------------------- 
							Disk 수명을 확인하는 Modal
			 ---------------------------------------------------------------------------->
			<div class="modal fade" id="diskLife">
				<div class="modal-dialog modal-lg">
					<div class="modal-content modal-lg">
						<!-- header -->
						<div class="modal-header">
							<!-- 닫기(x) 버튼 -->
							<button type="button" class="close" data-dismiss="modal">×</button>
							<!-- header title -->
							<h4 class="modal-title">디스크 수명 확인</h4>
						</div>
						<!-- body -->
						<div class="modal-body" id="modalBody">
							<table class="table table-bordered">
								<tr>
									<th style="text-align: center">구분</th><th style="text-align: center">값</th>
								</tr>
								<tr style="text-align: center">
									<td>건강상태</td><td id="healthStatus"></td>
								</tr>
								<tr style="text-align: center">
									<td>온도</td><td id="temperature"></td>
								</tr>
								<tr style="text-align: center">
									<td>사용횟수</td><td id="powerOnCount"></td>
								</tr>
								<tr style="text-align: center">
									<td>사용시간</td><td id="powerOnHours"></td>
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
		</div>
	</div>
</body>
</html>