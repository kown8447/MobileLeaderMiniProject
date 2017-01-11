<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="row" style="margin: 0 auto">
  <div>
    <div class="col-xs-4">
    <input type="date" class="form-control" id="cpudate">
    </div>
    <button type="button" class="btn btn-default btn-xs" id="cpusearch">검색</button>
    <button type="button" class="btn btn-default btn-xs" id="cpusearch1hour">1시간</button>
    <button type="button" class="btn btn-default btn-xs" id="cpusearch3hour">3시간</button>
    <button type="button" class="btn btn-default btn-xs" id="cpusearch6hour">6시간</button>
    현재시간 <span id="sysdate"></span>
    <br/>
    <div id="cpuusagechart" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
    
    <table class="table table-hover" style="width:400px">
      <thead>
        <tr>
          <th>날짜</th>
          <th>사용량(%)</th>
        </tr>
      </thead>
      <tbody id="tbodylist">
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
<%-- CPU
<hr>
<div class="row">
	<input type="date" id="cpudate">
	<input type="button" value="검색">
	<input type="button" value="1시간">
	<input type="button" value="3시간">
	<input type="button" value="6시간">
	현재 시간 
	<table class="table">
		<tr>
			<th>날짜</th>
			<th>사용량(%)</th>
		</tr>
		<c:forEach items="${allcpuinfo}" var="info">
			<tr>
				<td>${info.regdate}</td>
				<td>${info.cpuusage}</td>
			</tr>
		</c:forEach>
	</table>
</div> --%>
	