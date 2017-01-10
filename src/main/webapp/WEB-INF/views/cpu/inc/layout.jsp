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
<title>Insert title here</title>
<script type="text/javascript">
function fn_cpuonload() {
	var now = new Date();
	document.getElementById("cpudate").value = now.toDateString();
	document.getElementById("sysdate").innerHTML = "<b>" + now.toLocaleDateString() + now.toLocaleTimeString() + "</b>";
}

var searchhour;	//검색시간변수

$(function(){
	$('#cpusearch').click(function(event){
		var cpudate = document.getElementById("cpudate").value;
		searchhour = 24;
		alert(cpudate + "조회");
		var data = {"searchhour" : searchhour}
		$.ajax({
			url:""
		});
	});
	$('#cpusearch1hour').click(function(event){
		searchhour = 1;
		var data = {"searchhour" : searchhour}
		alert(data);
		$.ajax({
			url:"cpuhour.htm",
			data:data,
			dataType:"json",
			success:function(data){
				var a = data.cpuUsage.regdate;
				alert(a);
			}
		});
	});
	$('#cpusearch3hour').click(function(event){
		searchhour = 3;
		var data = {"searchhour" : searchhour}
		$.ajax({
			url:"cpuhour.htm",
			data:data,
			dataType:"json",
			success:function(data){
				alert("성공");
			}
		});
	});
	$('#cpusearch6hour').click(function(event){
		searchhour = 6;
		var data = {"searchhour" : searchhour}
		$.ajax({
			url:"cpuhour.htm",
			data:data,
			dataType:"json",
			success:function(data){
				alert("성공");
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