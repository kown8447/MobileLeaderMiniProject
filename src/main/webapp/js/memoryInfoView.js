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
			if($('#hour24').val().length > 0){
				startDate = $('#hour24').val();
			}
			if(startDate == 0 ){
				alert("조회 기간을 입력하세요.");
				event.preventDefault();
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
							$('#memorytable').empty();
							$('#memorytable').append("<thead><tr style='position:relative;top:expression(this.offsetParent.scrollTop);'><th style='text-align:center;'>번호</th><th style='text-align:center;'>날짜</th><th style='text-align:center;'>사용량(MB)</th></tr></thead><tbody id='tbodylist' style='text-align:center; width:100%; height: 350px;'>");
							var length = data.selected.length;
							for(var i = 0 ; i < length; i++){
								$('#memorytable').append("<tr><td>"+(i+1)+"</td><td>"+data.selected[i].regdate+"</td><td>"+data.selected[i].usedmemory+"</td></tr></tbody>");
							}
							startDate = 0;
							$('#hour24').val("");
							/*--------- 테이블 관리 ---------*/
							
							/*--------- 차트 관리 ---------*/
							if(data.selected.length == 0){
								alert("해당 날짜에 데이터가 존재하지 않습니다.");
								return;
							}
							var memoryArray = new Array();
							var dateArray = new Array();
							var regdate = new Array();
							var date = new Array();
							var year = new Array();
							var month = new Array();
							var day = new Array();
							var time =  new Array();
							var hour = new Array();
							var minute = new Array();
							var seconds = new Array();
							var utcdate = new Array();
							for(var i = 0 ; i < length; i++){
								memoryArray[i] = data.selected[i].usedmemory;
								dateArray[i] = data.selected[i].regdate;
								regdate[i] = data.selected[i].regdate.split(' ');
								date[i] = regdate[i][0].split('-');
								year[i] = date[i][0];
								month[i] = date[i][1];
								day[i] = date[i][2];
								time[i] = regdate[i][1].split(':');
								hour[i] = time[i][0];
								minute[i] = time[i][1];
								seconds[i] = time[i][2].split('.')[0];
								utcdate[i] = hour[i] + ":" + minute[i] + ":" + seconds[i];  
							}
							
							//Highchart
							Highcharts.setOptions({
						        colors: ['#AACCE2', '#E2AABE',  '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
						    });
							Highcharts.chart('memorychart', {
						        chart: {
						            type: 'spline',
						            backgroundColor: '#f8f8f8'
						        },
						        title: {
						            text: '기간별 메모리 사용량'
						        },
						        subtitle: {
						            text: year[0]+'년'+month[0]+'월'+day[0]+'일'+' Memory 사용량'
						        },
						        xAxis: {
						            labels: {
							            step : Math.ceil(length/12)
						            },
						            categories: utcdate
						        },
						        yAxis: {
						            title: {
						                text: 'Memory Size (MB)'
						            }
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
						                dataLabels: {
						                    enabled: true,
						                    style : {
						                    	'fontSize' : '8px', 
						                    	'fontWeight' : 'bold'
						                    },
						                    format : '{point.y:.0f}'
						                },
						            }
						        },
						        series: [{
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
						event.preventDefault();
					}
			});
			event.preventDefault();
		});
	});