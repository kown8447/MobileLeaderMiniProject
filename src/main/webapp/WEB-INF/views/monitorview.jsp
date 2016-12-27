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
							
							var cpuusage = Math.floor(data.cpuUsage);
							var gaugeOptions = {

							        chart: {
							            type: 'solidgauge'
							        },

							        title: null,

							        pane: {
							            center: ['50%', '85%'],
							            size: '140%',
							            startAngle: -90,
							            endAngle: 90,
							            background: {
							                backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
							                innerRadius: '60%',
							                outerRadius: '100%',
							                shape: 'arc'
							            }
							        },

							        tooltip: {
							            enabled: false
							        },

							        // the value axis
							        yAxis: {
							            stops: [
							                [0.1, '#55BF3B'], // green
							                [0.3, '#DDDF0D'], // yellow
							                [0.5, '#DF5353'] // red
							            ],
							            lineWidth: 0,
							            minorTickInterval: null,
							            tickAmount: 2,
							            title: {
							                y: -70
							            },
							            labels: {
							                y: 16
							            }
							        },

							        plotOptions: {
							            solidgauge: {
							                dataLabels: {
							                    y: 5,
							                    borderWidth: 0,
							                    useHTML: true
							                }
							            }
							        }
							    };

							    // The speed gauge
							    var chartSpeed = Highcharts.chart('container-speed', Highcharts.merge(gaugeOptions, {
							        yAxis: {
							            min: 0,
							            max: 100,
							            title: {
							                text: 'CPU usage'
							            }
							        },

							        credits: {
							            enabled: false
							        },

							        series: [{
							            name: 'CPU usage',
							            data: [cpuusage],
							            dataLabels: {
							                format: '<div style="text-align:center"><span style="font-size:25px;color:' +
							                    ((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y}</span><br/>' +
							                       '<span style="font-size:12px;color:silver">%</span></div>'
							            },
							            tooltip: {
							                valueSuffix: ' % '
							            }
							        }]

							    }));

							    // The RPM gauge
							    var chartRpm = Highcharts.chart('container-rpm', Highcharts.merge(gaugeOptions, {
							        yAxis: {
							            min: 0,
							            max: 5,
							            title: {
							                text: 'RPM'
							            }
							        },

							        series: [{
							            name: 'RPM',
							            data: [1],
							            dataLabels: {
							                format: '<div style="text-align:center"><span style="font-size:25px;color:' +
							                    ((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y:.1f}</span><br/>' +
							                       '<span style="font-size:12px;color:silver">* 1000 / min</span></div>'
							            },
							            tooltip: {
							                valueSuffix: ' revolutions/min'
							            }
							        }]

							    }));

							    // Bring life to the dials
							    setInterval(function () {
							        // Speed
							        var point,
							            newVal,
							            inc;

							        if (chartSpeed) {
							            point = chartSpeed.series[0].points[0];
							            inc = Math.round((Math.random() - 0.5) * 100);
							            newVal = point.y + inc;

							            if (newVal < 0 || newVal > 100) {
							                newVal = point.y - inc;
							            }

							            point.update(newVal);
							        }

							        // RPM
							        if (chartRpm) {
							            point = chartRpm.series[0].points[0];
							            inc = Math.random() - 0.5;
							            newVal = point.y + inc;

							            if (newVal < 0 || newVal > 5) {
							                newVal = point.y - inc;
							            }

							            point.update(newVal);
							        }
							    }, 2000);
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
						$('#total').text(data.diskInfo.total+'MB');
						$('#usable').text(data.diskInfo.usable+'MB');
						$('#use').text(data.diskInfo.use+'MB');
						
						var usePercent = data.diskInfo.use/data.diskInfo.total*100;
						var usablePercent = data.diskInfo.usable/data.diskInfo.total*100;
						
					    Highcharts.chart('container', {
					        chart: {
					            plotBackgroundColor: null,
					            plotBorderWidth: null,
					            plotShadow: false,
					            type: 'pie'
					        },
					        title: {
					            text: 'Check Disk Size'
					        },
					        tooltip: {
					            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
					        },
					        plotOptions: {
					            pie: {
					                allowPointSelect: true,
					                cursor: 'pointer',
					                dataLabels: {
					                    enabled: true,
					                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
					                    style: {
					                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
					                    }
					                }
					            }
					        },
					        series: [{
					            name: 'Brands',
					            colorByPoint: true,
					            data: [{
					                name: '사용한 공간',
					                y: usePercent
					            }, {
					                name: '사용가능한 공간',
					                y: usablePercent,
					                sliced: true,
					                selected: true
					            }]
					        }]
					    });
						
					}
				}
			);
	});
</script>

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
			<div style="width: 600px; height: 400px; margin: 0 auto">
    			<div id="container-speed" style="width: 300px; height: 200px; float: left"></div>
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