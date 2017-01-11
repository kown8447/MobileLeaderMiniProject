<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script><title>Insert title here</title>
<script type="text/javascript">
function fn_cpuonload() {
	var now = new Date();
	document.getElementById("sysdate").innerHTML = "<b>" + now.toLocaleDateString() + now.toLocaleTimeString() + "</b>";
}

var searchhour;	//검색시간변수

$(function(){
	$('#cpusearch').click(function(event){
		var cpudate = document.getElementById("cpudate").value;
		if (cpudate == "") {
			alert("검색할 날짜를 입력해주세요");
			cpudate = new Date();
			return;
		}
		searchhour = cpudate;
		var data = {"searchhour" : searchhour}
		$.ajax({
			url:"cpuAjax.htm",
			data:data,
			dataType:"json",
			success:function(data){
				var regdate;
				var cpuusage;
				var cpuArray = new Array();
				var tbody = document.getElementById("tbodylist");
				tbody.innerHTML = "";
				for (var i=0; i<data.cpuUsage.length; i++){
					regdate = data.cpuUsage[i].regdate;
					cpuusage = data.cpuUsage[i].cpuusage;
					cpuArray[i] = cpuusage;
					tbody.innerHTML += "<tr><td>" + regdate + "</td><td>" + cpuusage + "</td></tr>";
				}
				/* cpu Usage Chart START */
				Highcharts.chart('cpuusagechart', {

			        title: {
			            text: ''
			        },

			        xAxis: {
			            tickInterval: 1,
			        },

			        yAxis: {
			            type: 'logarithmic',
			            minorTickInterval: 0.1,
			            max: 99,
                        title: {
                            text: 'Cpu Usage (%)'
                        }

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
				/* cpu Usage Chart END */
			}
		});
	});
	$('#cpusearch1hour').click(function(event){
		searchhour = 1;
		var data = {"searchhour" : searchhour}
		$.ajax({
			url:"cpuAjax.htm",
			data:data,
			dataType:"json",
			success:function(data){
				var regdate;
				var cpuusage;
				var cpuArray = new Array();
				var tbody = document.getElementById("tbodylist");
				tbody.innerHTML = "";
				for (var i=0; i<data.cpuUsage.length; i++){
					regdate = data.cpuUsage[i].regdate;
					cpuusage = data.cpuUsage[i].cpuusage;
					cpuArray[i] = cpuusage;
					tbody.innerHTML += "<tr><td>" + regdate + "</td><td>" + cpuusage + "</td></tr>";
				}
				/* cpu Usage Chart START */
				Highcharts.chart('cpuusagechart', {

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
				/* cpu Usage Chart END */
			}
		});
	});
	$('#cpusearch3hour').click(function(event){
		searchhour = 3;
		var data = {"searchhour" : searchhour}
		$.ajax({
			url:"cpuAjax.htm",
			data:data,
			dataType:"json",
			success:function(data){
				var regdate;
				var cpuusage;
				var cpuArray = new Array();
				var tbody = document.getElementById("tbodylist");
				tbody.innerHTML = "";
				for (var i=0; i<data.cpuUsage.length; i++){
					regdate = data.cpuUsage[i].regdate;
					cpuusage = data.cpuUsage[i].cpuusage;
					cpuArray[i] = cpuusage;
					tbody.innerHTML += "<tr><td>" + regdate + "</td><td>" + cpuusage + "</td></tr>";
				}
				/* cpu Usage Chart START */
				Highcharts.chart('cpuusagechart', {

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
				/* cpu Usage Chart END */
			}
		});
	});
	$('#cpusearch6hour').click(function(event){
		searchhour = 6;
		var data = {"searchhour" : searchhour}
		$.ajax({
			url:"cpuAjax.htm",
			data:data,
			dataType:"json",
			success:function(data){
				var regdate;
				var cpuusage;
				var cpuArray = new Array();
				var tbody = document.getElementById("tbodylist");
				tbody.innerHTML = "";
				for (var i=0; i<data.cpuUsage.length; i++){
					regdate = data.cpuUsage[i].regdate;
					cpuusage = data.cpuUsage[i].cpuusage;
					cpuArray[i] = cpuusage;
					tbody.innerHTML += "<tr><td>" + regdate + "</td><td>" + cpuusage + "</td></tr>";
				}
				/* cpu Usage Chart START */
				Highcharts.chart('cpuusagechart', {

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
				/* cpu Usage Chart END */
			}
		});
	});
});
</script>

</head>
<body onload="fn_cpuonload()">
	<tiles:insertAttribute name="header"/>
	<tiles:insertAttribute name="content"/>
</body>
</html>