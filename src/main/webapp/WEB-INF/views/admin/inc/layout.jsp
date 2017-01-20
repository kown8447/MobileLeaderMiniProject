<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<script src="${pageContext.request.contextPath}/js/main.js" type="text/javascript"></script>
<title>리소스 모니터링</title>
</head>
<body style="background:#f8f8f8;">
	<tiles:insertAttribute name="header"/>
	<tiles:insertAttribute name="content"/>
</body>
</html>