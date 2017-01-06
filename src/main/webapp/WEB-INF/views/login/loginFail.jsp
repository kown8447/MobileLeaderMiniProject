<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="text-wrapper" style="margin-top: 15%">
    <div class="title" data-content="404">
        Login Fail
    </div>

    <div class="subtitle">
        	로그인 실패하였습니다. 다시 시도해 주세요. 
    </div>

    <div class="buttons">
        <a class="button" href="${pageContext.request.contextPath}/main.htm">Go to homepage</a>
    </div>
</div>