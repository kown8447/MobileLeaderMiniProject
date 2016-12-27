var cpuArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
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
						for(var i=9; i>0; i--){
							cpuArray[i] = cpuArray[i-1];
						}
						cpuArray[0] = cpuusage;
						
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