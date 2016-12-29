/*
 * @javascript name : monitorview.js
 * @date : 2017.01.09
 * @description : monitorview.jsp 에 사용되는 Chart 및 Ajax 비동기 통신 정보를 출력하기 위한 스크립트
*/
var cpuArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
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

					        title: {
					            text: ''
					        },

					        xAxis: {
					            tickInterval: 1,
					        },

					        yAxis: {
					            type: 'logarithmic',
					            minorTickInterval: 0.1,
					            max: 99
					        },

					        tooltip: {
					            headerFormat: '<b>cpu usage</b><br/>',
					            pointFormat: '{point.y}%'
					        },

					        series: [{
					            data: cpuArray,
					            pointStart: 1
					        }]
					    });
						/* cpu Usage Chart 2 END */
						
						
						/* cpu Usage Chart 1 START */
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
						$('#heap').text(data.memoryInfo.heap);
						$('#nonheap').text(data.memoryInfo.nonheap);
					}
				}		
			);
	}, 1000);
	
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
				        colors: ['#FF0000', '#4000FF', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
				    });
					
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
					var content = "";
					$.each(data.proccess,function(key,value) {
						var split = value.split(',');
						content += '<tr><td>'+split[0].replace(/"/g, '')+'</td><td>'+split[1].replace(/"/g, '')+'</td><td>'+split[2].replace(/"/g, '')+'</td><td>'+split[4].replace(/"/g, '');
						if(split[5] != undefined){
							content+=split[5].replace(/"/g, '');
						}
						content += '</td></tr>';
					});
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
					console.log(data.disklist);
					var content = "";
					$.each(data.disklist,function(key,value) {
						content += '<tr><td>'+value.name+'</td><td>'+value.total+'</td><td>'+value.usable+'</td><td>'+value.used+'</td></tr>';
					});
					$('#resultDiskDetail').append(content);
					$('#diskDetail').modal();
				}
			}
		);
	});
});