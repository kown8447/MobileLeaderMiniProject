<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${pageContext.request.contextPath}/main.htm">Main</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="${pageContext.request.contextPath}/osInfo.htm">OS 정보<span class="sr-only">(current)</span></a></li>
        <li><a href="${pageContext.request.contextPath}/cpuInfo.htm">CPU 정보</a></li>
        <li><a href="${pageContext.request.contextPath}/memoryInfo.htm">Memory 정보</a></li>
        <li><a href="${pageContext.request.contextPath}/diskInfo.htm">Disk 정보</a></li>
        <li><a href="${pageContext.request.contextPath}/admin.htm">관리자(실시간 조회)</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
			<se:authorize access="isAnonymous()">
				<li><a href="${pageContext.request.contextPath}/login.htm">로그인</a></li>
			</se:authorize>
			<se:authorize access="isAuthenticated()">
				<li><a href="${pageContext.request.contextPath}/logout.htm">로그아웃</a></li>
			</se:authorize>
		</ul>
    </div><!-- /.navbar-collapse -->
    
  </div><!-- /.container-fluid -->
</nav>