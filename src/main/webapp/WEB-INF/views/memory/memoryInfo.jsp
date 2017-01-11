<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	//var memoryArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	var startDate = 0; 
	
	$(function(){
		$('#hour').click(function(event){
			startDate = 1;
			$('#search').click();
			event.preventDefault();
		});
		$('#hour3').click(function(event){
			startDate = 3;
			$('#search').click();
			event.preventDefault();
		});
		$('#hour6').click(function(event){
			startDate = 6;
			$('#search').click();
			event.preventDefault();
		});
		
		$('#search').click(function(){
			//alert("startDate : " + startDate + "\n hour24 length : " + $('#hour24').val().length);
			if($('#hour24').val().length > 0){
				startDate = $('#hour24').val();
			}
			if(startDate == 0 ){
				alert("조회 기간을 입력하세요.");				
				return;
			}
			var allData = {"startDate" : startDate};
			$.ajax(
					{
						url:"memoryInfoAjax.htm",
						data:allData,
						dataType:"json",
						success:function(data){
							/*--------- 테이블 관리 ---------*/
							$('.table').empty();
							$('.table').append("<tr><th>날짜</th><th>사용량(MB)</th></tr>");
							var length = data.selected.length;
							for(var i = 0 ; i < length; i++){
								$('.table').append("<tr><td>"+data.selected[i].regdate+"</td><td>"+data.selected[i].usedmemory+"</td></tr>");
							}
							startDate = 0;
							$('#hour24').val(0);
							/*--------- 테이블 관리 ---------*/
							
							/*--------- 차트 관리 ---------*/
							if(data.selected.length == 0){
								alert("해당 날짜에 데이터가 존재하지 않습니다.");
								return;
							}
							var memoryArray = new Array();
							var dateArray = new Array();
							for(var i = 0 ; i < length; i++){
								memoryArray[i] = data.selected[i].usedmemory;
								dateArray[i] = data.selected[i].regdate;
							}								
							var regdate = data.selected[0].regdate.split(' ');
							var date = regdate[0].split('-');
							var year = date[0];
							var month = date[1]-1;
							var day = date[2];
							var time = regdate[1].split(':');
							var hour = time[0];
							var minute = time[1];
							var seconds = time[2].split('.')[0];
							//console.log("년 : " , year, "월:", month, "일:" ,day);
							/* var totalMemory = data.memoryInfo.totalMemory;
							var freeMemory = data.memoryInfo.freeMemory;
							var usedMemory = data.memoryInfo.usedMemory;
							$('#usedMemory').html("<font color='red'><b>사용중인 메모리 : </b></font><br>" + usedMemory + "MB");
							$('#usedMemoryByGB').html("<font color='red'><b>실제 메모리 : </b></font><br>" + totalMemory + "MB<br>"
									+ "<font color='green'><b>사용 가능한 메모리 : </b></font><br>" + freeMemory + "MB<br>"
									+ "<font color='blue'><b>사용중인 메모리 : </b></font><br>" + usedMemory + "MB");
							
							for(var i=0; i<9; i++){
								memoryArray[i] = memoryArray[i+1];
							}
							memoryArray[9] = usedMemory; */
							
							//Highchart
							Highcharts.chart('memoryContainer', {
						        chart: {
						            type: 'spline'
						        },
						        title: {
						            text: '메모리 사용량'
						        },
						        subtitle: {
						            text: '검색 기간 Memory 사용량'
						        },
						        xAxis: {
						            type : 'datetime',
						            labels: {
							            overflow : 'justify',
							            step : 2
						            },
						            categories:[dateArray]
						        	
						        },
						        yAxis: {
						            title: {
						                text: 'Memory Size (MB)'
						            }/* ,
						            tickInterval : 2,
						            tickAmount : 5,
						            minorGridLineWidth: 0,
						            gridLineWidth: 0,
						            alternateGridColor: null */
						            
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
						                    	'fontSize' : '12px', 
						                    	'fontWeight' : 'bold'
						                    },
						                    format : '{point.y:.0f}'
						                },
						               /*  pointInterval: 300000, // one hour
						                pointStart: Date.UTC(year, month, day, hour, minute, seconds) */
						            }
						        },
						        series: [{
						            /* type: 'area', */
						        	name: 'Used Memory',
						            data: memoryArray
						        }],
						        navigation: {
						            menuItemStyle: {
						                fontSize: '10px'
						            },
						            
						        }
							});
					},
					error:function(){
						alert("조회 기간에 데이터가 존재하지 않습니다.");
					}
			});
			event.preventDefault();
		});
		
		
	});
</script>
<div class="row">
	<h1 style="text-align:center; color:red; font-weight:bold;">여기는 memory 정보 보여주는 곳</h1>
	<form style="margin-left:1%; text-align:center;" id="" action="">
		날짜 : <input type="date" name="startDate" id="hour24"/>
		<input type="button" value="검색" id="search"/>
		<input type="button" value="1시간" id="hour"/>
		<input type="button" value="3시간" id="hour3"/>
		<input type="button" value="6시간" id="hour6"/>
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
		<%-- <c:forEach items="${selected}" var="info">
			<tr>
				<td>${info.regdate}</td>
				<td>${info.usedmemory}</td>
			</tr>
		</c:forEach> --%>
	</table>
</div>