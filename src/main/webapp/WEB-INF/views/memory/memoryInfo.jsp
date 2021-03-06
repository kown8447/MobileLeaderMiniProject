<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- div id=row start -->
<div id="row" style="margin: 0 auto">
	<!-- div id=cpudiv1 start -->
	<div id="memorydiv1" style="margin: 0 auto">
		<!-- memory 정보 검색 할 수 있는 input 및 button -->
		<div class="page-header">
  			<h1><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>  MEMORY 정보</h1>
		</div>
		<form class="form-inline">
			<div class="form-group">
		    	<input type="date" class="form-control" name="startDate" id="hour24">
		    	<button type="button" class="btn btn-default" id="search">
		    		<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 검색
		    	</button>
		    </div>
		    <div>
			    <button type="button" class="btn btn-default" id="hour">
			    	<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 1시간
				</button>
			    <button type="button" class="btn btn-default" id="hour3">
			    	<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 3시간
			    </button>
			    <button type="button" class="btn btn-default" id="hour6">
			    	<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 6시간
			    </button>
		    </div>
	    </form>
	</div>
	<!-- div id=cpudiv1 end -->
<!-- div id=cpudiv2 start -->
	<div id="memorydiv2" style="margin: 0 auto">
		<!-- cpu 정보 chart 와 table -->
    	<div id="memorychart" style="width:70%; float:left"></div>
    	<div id="memorytablediv" class="table-responsive" style="width:30%; height:300px; float:right;">
		    <table id="memorytable" class="table table-hover" style="text-align:center;">
		    </table>
	    </div>
	</div>
	<!-- div id=cpudiv2 end -->
</div>
<!-- div id=row end -->