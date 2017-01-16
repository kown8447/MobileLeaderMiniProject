/**
 * cpuInfoView.js
 */

var searchhour = "";	//검색시간변수
var cpudate	= "";		//검색날짜변수

$(function(){
	$('#cpusearch').click(function(event){
		if(searchhour == "") {
			var cpudate = document.getElementById("cpudate").value;
			var data = {"searchhour" : cpudate}
			cpudate = "";		//cpudate 초기화
		} else {
			var data = {"searchhour" : searchhour}
			searchhour = "";	//searchhour 초기화
		}
		
		/* ajax start */
		$.ajax({
			url:"CpuInfoAjax.htm",
			data:data,
			dataType:"json",
			success:function(data){
				if (data.cpuUsage.length == 0) {
					alert("해당 날짜에 데이터가 존재하지 않습니다");
					return;
				}
				var regdate;
				var cpuusage;
				var length = data.cpuUsage.length;
				var cpuArray = new Array();
				var date = new Array();
				var time = new Array();
				var tbody = document.getElementById("tbodylist");
				tbody.innerHTML = "";
				for (var i=0; i<data.cpuUsage.length; i++){
					regdate = data.cpuUsage[i].regdate;
					cpuusage = data.cpuUsage[i].cpuusage;
					date[i] = regdate.substring(0, 10);
					time[i] = regdate.substring(11, 16);
					cpuArray[i] = cpuusage;
					tbody.innerHTML += "<tr><td>" + (i+1) + "</td><td>" + regdate + "</td><td>" + cpuusage + "</td></tr>";
				}
				
				/* cpu usage chart start */
				
				Highcharts.setOptions({
			        colors: ['#E2AABE', '#D9EEFD', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
			    });
				
				Highcharts.chart('cpuusagechart', {
			        chart: {
			            type: 'area',
			            backgroundColor: '#f8f8f8'
			        },
			        title: {
			            text: date[0] + ' CPU 사용량'
			        },
			        xAxis: {
			        	labels: {
				            step : Math.ceil(length/12)
			            },
			            categories: time
			        },
			        yAxis: {
			            title: {
			                text: 'CPU 사용량 (%)'
			            } ,
			            labels: {
			                formatter: function () {
			                    return this.value + "%";
			                }
			            }
			        },
			        tooltip: {
			            pointFormat: '<b>{point.y:,.0f}% ({point.x})</b>'
			        },
			        plotOptions: {
			            area: {
			                pointStart: 1,
			                marker: {
			                    enabled: false,
			                    symbol: 'circle',
			                    radius: 2,
			                    states: {
			                        hover: {
			                            enabled: true
			                        }
			                    }
			                }
			            }
			        },
			        series: [{
			            name: 'CPU USAGE',
			            data: cpuArray	//받아온 data값 넘김
			        }]
			    });
				/* cpu usage chart end */
			},
			error:function(){
				alert("조회 기간에 데이터가 존재하지 않습니다.");
				event.preventDefault();
			}
		});
		/* ajax end */
	});
	
	$('#cpusearch1hour').click(function(event){
		searchhour = 1;
		$('#cpusearch').click();
		event.preventDefault();
	});
	
	$('#cpusearch3hour').click(function(event){
		searchhour = 3;
		$('#cpusearch').click();
		event.preventDefault();
	});
	
	$('#cpusearch6hour').click(function(event){
		searchhour = 6;
		$('#cpusearch').click();
		event.preventDefault();
	});
});