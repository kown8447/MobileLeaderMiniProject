<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="header">
  <h1 class="logo">
  	<a href="${pageContext.request.contextPath}/main.htm"><img alt="logo" src="${pageContext.request.contextPath}/images/img_top_logo.gif"></a>
  </h1>
</div>
 <div class="content">
	<div class="fixed_nav">
   <div class="navi_wrapper">
          <ul class="clearfix">
            <li><a class="third after" href="${pageContext.request.contextPath}/osInfo.htm">OS 정보</a></li>
            <li><a class="third after" href="${pageContext.request.contextPath}/cpuInfo.htm">CPU 정보</a></li>
            <li><a class="third after" href="${pageContext.request.contextPath}/memoryInfo.htm">Memory 정보</a></li>
            <li><a class="third after" href="${pageContext.request.contextPath}/diskInfo.htm">Disk 정보</a></li>
            <li><a class="third after" href="${pageContext.request.contextPath}/admin.htm">관리자(실시간 조회)</a></li>
          </ul>
    </div>
	 </div>
</div>