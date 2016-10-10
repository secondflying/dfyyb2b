<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="pageTitle" value="" scope="request" />
<jsp:include page="./includes/indexheader.jsp" />

<div class="container">
	<form id="register" action="register" class="form-signin" method="post">
		<h2 class="form-signin-heading">用户注册</h2>
		<c:if test="${error != null}">
			<div class="alert alert-error">
				注册失败：
				<c:out value="${error}" />
			</div>
		</c:if>

		<label for="username" class="sr-only">手机号：</label>
		<input type="text" id="phone" name="phone" class="form-control" placeholder="输入用户名" required autofocus>
		<label for="password" class="sr-only">密码：</label>
		<input type="password" id="password" name="password" class="form-control" placeholder="输入密码" required>
		<label for="password" class="sr-only">确认密码：</label>
		<input type="password" id="password2" name="password2" class="form-control" placeholder="输入确认密码" required>
		<button class="btn btn-lg btn-primary btn-block" type="submit">注册</button>
	</form>
</div>
<script>
	$(document).ready(function() {
		setplaceholderSupport();
	});
</script>

<jsp:include page="./includes/footer.jsp" />