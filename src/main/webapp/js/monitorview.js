/*
 * @javascript name : monitorview.js
 * @date : 2017.01.09
 * @description : monitorview.jsp 에 사용되는 Chart 및 Ajax 비동기 통신 정보를 출력하기 위한 스크립트
*/
var cpuArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var memoryArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
$(function(){
	
	/*
	 * @method name : ajax 익명 함수
	 * @description : OS 정보를 JSP 의 Table에 출력하는 함수
	*/
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
			}
		}
	);
	
	/*
	 * @method name : cpuUsage
	 * @description : CPU 사용량을 실시간으로 표시하기 위해 사용되는 재귀 호출 함수
	*/
	cpuUsage = setInterval(function() {
		$.ajax(
				{
					url:"cpuAjax.htm",
					dataType:"json",
					success:function(data){
						$('#cpuUsage').text(data.cpuUsage+'%');
						var cpuusage = Math.floor(data.cpuUsage);
						for(var i=0; i<10; i++){
							cpuArray[i] = cpuArray[i+1];
						}
						cpuArray[9] = cpuusage;
						
						/* cpu Usage Chart 2 START */
						Highcharts.chart('cpuusagechart2', {
							chart: {
					            backgroundColor: '#f8f8f8'
					        },		
					        title: {
					        	text: 'CPU 사용량'
					        },
					        xAxis: {
					            tickInterval: 1,
					        },

					        yAxis: {
					            type: 'logarithmic',
					            minorTickInterval: 0.1,
					            max: 99,
					            title: {
					            	text: 'CPU 사용량(%)'
					            },
					            labels: {
					                formatter: function () {
					                    return this.value + "%";
					                }
					            }
					        },

					        tooltip: {
					            headerFormat: '<b>cpu usage</b><br/>',
					            pointFormat: '{point.y}%'
					        },

					        series: [{
					            data: cpuArray,
					            pointStart: 1,
					            name: 'CPU USAGE'
					        }]
					    });
						/* cpu Usage Chart 2 END */
						
						
						/* cpu Usage Chart 1 START */
						var gaugeOptions = {

						        chart: {
						            type: 'solidgauge',
						            backgroundColor: '#f8f8f8'
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
						    var chartSpeed = Highcharts.chart('cpuusagechart1', Highcharts.merge(gaugeOptions, {
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

						    /* cpu Usage Chart 1 END */
					}
				}		
			);
	}, 2500);
	
	/*
	 * @method name : memoryInfo
	 * @description : 메모리 사용량을 실시간으로 표시하기 위해 사용되는 재귀 호출 함수
	*/
	memoryInfo = setInterval(function() {
		$.ajax(
				{
					url:"memoryAjax.htm",
					dataType:"json",
					success:function(data){
						var totalMemory = data.memoryInfo.totalMemory;
						var freeMemory = data.memoryInfo.freeMemory;
						var usedMemory = data.memoryInfo.usedMemory;
						$('#usedMemory').html("<font color='#AE758A'><b>사용중인 메모리 : </b></font>" + usedMemory + "MB");
						$('#usedMemoryByGB').html("<font color='#AE758A'><b>실제 메모리 : </b></font>" + totalMemory + "MB<br/>"
								+ "<font color='#A8E3A8'><b>사용 가능한 메모리 : </b></font>" + freeMemory + "MB<br/>"
								+ "<font color='#AACCE2'><b>사용중인 메모리 : </b></font>" + usedMemory + "MB");
						
						for(var i=0; i<9; i++){
							memoryArray[i] = memoryArray[i+1];
						}
						memoryArray[9] = usedMemory;
						
						Highcharts.chart('memoryContainer', {
					        chart: {
					            type: 'spline',
					            backgroundColor: '#f8f8f8'
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
						
						
						/* stacked column chart  */
						Highcharts.chart('memoryChart', {
						        chart: {
						            type: 'column',
						            backgroundColor: '#f8f8f8'
						        },
						        title: {
						            text: 'Memory'
						        },
						        xAxis: {
						            categories: ['Memory']
						        },
						        yAxis: {
						            //min: 0,
						            tickAmount : 5,
						            title: {
						                text: 'Used Memory'
						            }
						        },
						        tooltip: {
						            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
						            shared: true
						        },
						        plotOptions: {
						            column: {
						                stacking: 'percent'
						            },
						            series: {
						                dataLabels: {
						                    enabled: true,
						                    verticalAlign : 'middle',
						                    format : '{point.percentage:.0f}%'
						                }
						            }
						        },
						        series: [{
						            name: 'Free memory',
						            data: [freeMemory]
						        }, {
						            name: 'Used memory',
						            data: [usedMemory]
						        }]
						    });
						
					}
				}		
			);
	}, 3000);
	
	/*
	 * @method name : ajax 익명함수
	 * @description : 디스크 용량을 표시하는 함수
	*/
	$.ajax(
			{
				url:"diskAjax.htm",
				dataType:"json",
				success:function(data){
					$('#total').text(data.diskInfo.total+'GB');
					$('#usable').text(data.diskInfo.usable+'GB');
					$('#use').text(data.diskInfo.use+'GB');
					
					var usePercent = data.diskInfo.use/data.diskInfo.total*100;
					var usablePercent = data.diskInfo.usable/data.diskInfo.total*100;
					
					Highcharts.setOptions({
				        colors: ['#E2AABE', '#D9EEFD', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
				    });
					
				    Highcharts.chart('container', {
				        chart: {
				            plotBackgroundColor: null,
				            plotBorderWidth: null,
				            plotShadow: false,
				            type: 'pie',
				            backgroundColor: '#f8f8f8'
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
				            name: 'Space',
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
	
	/*
	 * @method name : checkProcess 익명함수
	 * @description : 현재 실행중인 프로세스의 정보를 Modal 로 출력해 주는 함수
	*/
	$('#checkProcess').click(function(){
		$.ajax(
			{
				url:"checkProccess.htm",
				dataType:"json",
				success:function(data){
					var content = "<tr><th>Proccess Name</th><th>PID</th><th>Session Name</th><th>Memory Usage</th></tr>";
					$.each(data.proccess,function(key,value) {
						var split = value.split(',');
						content += '<tr><td>'+split[0].replace(/"/g, '')+'</td><td>'+split[1].replace(/"/g, '')+'</td><td>'+split[2].replace(/"/g, '')+'</td><td>'+split[4].replace(/"/g, '');
						if(split[5] != undefined){
							content+=split[5].replace(/"/g, '');
						}
						content += '</td></tr>';
					});
					$('#resultTable').empty();
					$('#resultTable').append(content);
					$('#layerpop').modal();
				}
			}
		);
	});
	
	/*
	 * @method name : checkDiskDetail 익명함수
	 * @description : 파티션별 용량 정보를 Modal 로 출력해 주는 함수
	*/
	$('#checkDiskDetail').click(function(){
		$.ajax(
			{
				url:"checkDiskDetail.htm",
				dataType:"json",
				success:function(data){
					var content = "<tr><th>Disk Name</th><th>Total Size(GB)</th><th>Usable Size(GB)</th><th>Used Size(GB)</th></tr>";
					$.each(data.disklist,function(key,value) {
						content += '<tr><td>'+value.name+'</td><td>'+value.total+'</td><td>'+value.usable+'</td><td>'+value.used+'</td></tr>';
					});
					$('#resultDiskDetail').empty();
					$('#resultDiskDetail').append(content);
					$('#diskDetail').modal();
				}
			}
		);
	});
});