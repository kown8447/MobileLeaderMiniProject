<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
여기는 memory 정보 보여주는 곳
<div class="row">
	<table class="table">
		<tr>
			<th>날짜</th>
			<th>사용량(MB)</th>
		</tr>
		<c:forEach items="${allmemory}" var="info">
			<tr>
				<td>${info.regdate}</td>
				<td>${info.usedmemory}</td>
			</tr>
		</c:forEach>
	</table>
</div>