<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script type="text/javascript">
	var memoryArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	
	
	$(function(){
		
		$.ajax(
				{
					url:"memoryInfoAjax.htm",
					dataType:"json",
					success:function(data){
						var totalMemory = data.memoryInfo.totalMemory;
						var freeMemory = data.memoryInfo.freeMemory;
						var usedMemory = data.memoryInfo.usedMemory;
						$('#usedMemory').html("<font color='red'><b>사용중인 메모리 : </b></font><br>" + usedMemory + "MB");
						$('#usedMemoryByGB').html("<font color='red'><b>실제 메모리 : </b></font><br>" + totalMemory + "MB<br>"
								+ "<font color='green'><b>사용 가능한 메모리 : </b></font><br>" + freeMemory + "MB<br>"
								+ "<font color='blue'><b>사용중인 메모리 : </b></font><br>" + usedMemory + "MB");
						
						for(var i=0; i<9; i++){
							memoryArray[i] = memoryArray[i+1];
						}
						memoryArray[9] = usedMemory;
						
						//Highchart
						Highcharts.chart('memoryContainer', {
					        chart: {
					            type: 'spline'
					        },
					        title: {
					            text: '메모리 사용량'
					        },
					        subtitle: {
					            text: 'Memory 사용량 실시간 출력'
					        },
					        xAxis: {
					            tickInterval : 1
					        },
					        yAxis: {
					            title: {
					                text: 'Memory Size (MB)'
					            },
					            tickInterval : 2,
					            tickAmount : 5,
					            minorGridLineWidth: 0,
					            gridLineWidth: 0,
					            alternateGridColor: null
					        },
					        tooltip: {
					            valueSuffix: 'MB'
					        },
					        plotOptions: {
					            spline: {
					                lineWidth: 3,
					                states: {
					                    hover: {
					                        lineWidth: 5
					                    }
					                },
					                marker: {
					                    enabled: false
					                },
					                pointStart: 1,
					                dataLabels: {
					                    enabled: true,
					                    style : {
					                    	'fontSize' : '9px', 
					                    	'fontWeight' : 'normal'
					                    },
					                    format : '{point.y:.0f}'
					                }
					            }
					        },
					        series: [{
					            name: 'Used Memory',
					            data: memoryArray
					        }],
					        navigation: {
					            menuItemStyle: {
					                fontSize: '10px'
					            }
					        }
					    });
						
			);
	});
</script>
<div class="row">
	<h1 style="text-align:center; color:red; font-weight:bold;">여기는 memory 정보 보여주는 곳</h1>
	<form id="" action="">
		날짜 : <input type="date"/>
		<input type="button" value="1시간"/>
		<input type="button" value="3시간"/>
		<input type="button" value="6시간"/>
	</form>
</div>
<div class="row">
	<div id="memoryContainer" style="margin-left:1%;"></div>
</div>
<div class="row" style="margin-left:1%;">
	<table class="table">
		<tr>
			<th>날짜</th>
			<th>사용량(MB)</th>
		</tr>
		<c:forEach items="${allmemory}" var="info">
			<tr>
				<td>${info.regdate}</td>
				<td>${info.usedmemory}</td>
			</tr>
		</c:forEach>
	</table>
</div>