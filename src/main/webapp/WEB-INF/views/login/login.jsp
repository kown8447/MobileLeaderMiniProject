<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags"%>

<div class="container">
	<c:url value="/login" var="loginURL" />
	<div class="wrapper">
		<form class="form-signin" name="f" action="${loginURL}" method="post">
			<div class="input-group">
				<span class="input-group-addon" id="sizing-addon1"> 
					<i class="fa fa-user"></i>
				</span> 
				<input type="text" name="id" id="id" class="form-control f-input" placeholder="MemberID">
			</div>

			<div class="input-group">
				<span class="input-group-addon" id="sizing-addon1"> 
					<i class="fa fa-lock"></i>
				</span> 
				<input type="password" name="password" id="password" class="form-control f-input" placeholder="Password">
			</div>

			<input class="btn btn-block" type="submit" value="LOGIN" id="loginBtn"
				style="background: linear-gradient(to right, #35c3c1, #47C83E)">
			<br>
		</form>
	</div>
</div>
