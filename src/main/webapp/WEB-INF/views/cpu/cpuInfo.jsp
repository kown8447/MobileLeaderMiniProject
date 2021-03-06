<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- div id=row start -->
<div id="row" style="margin: 0 auto">
	<!-- div id=cpudiv1 start -->
	<div id="cpudiv1" style="margin: 0 auto">
		<!-- cpu 정보 검색 할 수 있는 input 및 button -->
		<div class="page-header">
  			<h1><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>  CPU 정보</h1>
		</div>
	    <form class="form-inline">
			<div class="form-group">
		    	<input type="date" class="form-control" id="cpudate">
		    	<button type="button" class="btn btn-default" id="cpusearch">
		    		<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 검색
		    	</button>
	    	</div>
	   		<div>
	   			<button type="button" class="btn btn-default" id="cpusearch1hour">
				<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 1시간
				</button>
				<button type="button" class="btn btn-default" id="cpusearch3hour">
				<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 3시간
	    		</button>
	    		<button type="button" class="btn btn-default" id="cpusearch6hour">
	    		<span class="glyphicon glyphicon-time" aria-hidden="true"></span> 6시간
	    		</button>
    		</div>
	    </form>
  	</div>
	<!-- div id=cpudiv1 end -->
	<!-- div id=cpudiv2 start -->
	<div id="cpudiv2" style="margin: 0 auto">
		<!-- cpu 정보 chart 와 table -->
    	<div id="cpuusagechart" style="width:70%; float:left"></div>
    	<div id="cpuusagetable" class="table-responsive" style="width:30%; height:300px; float:right;">
		    <table id="cputable" class="table table-hover" style="text-align:center;">
		      <thead>
		        <tr style="position:relative;top:expression(this.offsetParent.scrollTop);">
		        	<th style="text-align:center;">번호</th>
					<th style="text-align:center;">날짜</th>
					<th style="text-align:center;">사용량(%)</th>
		        </tr>
		      </thead>
		      <tbody id="tbodylist" style="text-align:center; width:100%; height: 350px;">
		      </tbody>
		    </table>
	    </div>
	</div>
	<!-- div id=cpudiv2 end -->
</div>
<!-- div id=row end -->
	