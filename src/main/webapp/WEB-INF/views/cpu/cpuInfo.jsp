<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- div id=row start -->
<div id="row" style="margin: 0 auto">
	<!-- div id=cpudiv1 start -->
	<div id="cpudiv1" style="margin: 0 auto">
		<!-- cpu 정보 검색 할 수 있는 input 및 button -->
		<b>cpu 정보</b>
		<hr>
		<div class="col-xs-4">
	    	<input type="date" class="form-control" id="cpudate">
	    </div>
	    <button type="button" class="btn btn-default btn-xs" id="cpusearch">검색</button>
	    <button type="button" class="btn btn-default btn-xs" id="cpusearch1hour">1시간</button>
	    <button type="button" class="btn btn-default btn-xs" id="cpusearch3hour">3시간</button>
	    <button type="button" class="btn btn-default btn-xs" id="cpusearch6hour">6시간</button>
    	현재시간 <span id="sysdate"></span>
	</div>
	<!-- div id=cpudiv1 end -->
	<!-- div id=cpudiv2 start -->
	<div id="cpudiv2" style="margin: 0 auto">
		<!-- cpu 정보 chart 와 table -->
    	<div id="cpuusagechart" style="width:70%; float:left"></div>
    	<div id="cpuusagetable" style="width:30%; height:300px; float:right;">
		    <table id="cputable" class="table table-hover">
		      <thead>
		        <tr>
		          <th>날짜</th>
		          <th>사용량(%)</th>
		        </tr>
		      </thead>
		      <tbody id="tbodylist" style="width:100px; overflow: auto;">
		        <c:forEach items="${allcpuinfo}" var="info">
					<tr>
						<td>${info.regdate}</td>
						<td>${info.cpuusage}</td>
					</tr>
				</c:forEach>
		      </tbody>
		    </table>
	    </div>
	</div>
	<!-- div id=cpudiv2 end -->
</div>
<!-- div id=row end -->
	