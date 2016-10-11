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
		<input type="text" id="phone" name="phone" class="form-control" placeholder="输入手机号码" required autofocus onkeyup="clearNoNum(this)" maxlength="11">
		<label for="code" class="sr-only">验证码：</label>
		<div class="input-append form-control">
			<input id="code" name="code" class="form-control" style="line-height: 26px; width:122px; border: 1px solid #cccccc;" placeholder="输入短信验证码"
			    required onkeyup="clearNoNum(this)" maxlength="4" />
			<button id="smsBtn" class="btn btn-info" type="button" style="width:100px;" onclick="getcode();">获取验证码</button>
		</div>
		<label for="password" class="sr-only">密码：</label>
		<input type="password" id="password" name="password" class="form-control" placeholder="输入密码" required>
		<label for="password" class="sr-only">确认密码：</label>
		<input type="password" id="password2" name="password2" class="form-control" placeholder="输入确认密码" required>
		<label for="password" class="sr-only"></label>
		<button class="btn btn-lg btn-primary span2" type="submit">注册</button>
	</form>
</div>
<script>
	$(document).ready(function() {
		setplaceholderSupport();
	});
	
	var wait=60; 
	var time=1;
	function settime(o) { 
		if (wait == 0) { 
			o.removeAttribute("disabled");	
			o.innerHTML="获取验证码"; 
			wait = 60; 
		} else { 
			o.setAttribute("disabled", true); 
			o.innerHTML="重新发送(" + wait + ")"; 
			wait--; 
			setTimeout(function() { settime(o) }, 1000);
		} 
	} 
	
	function getcode(){

		var phone = $('#phone').val();
		if(phone==null || phone ==""){
			bootbox.alert("请输入正确的手机号");
			return;
		}
		$.post('<c:url value="checkcode" />', {
			phone:phone,
			n:time
		}).done(function(data) {
			var btn = document.getElementById("smsBtn");
			settime(btn);
		}).fail(function() {
			time++;
			bootbox.alert("获取验证码失败");
		});
	}
	
</script>

<jsp:include page="./includes/footer.jsp" />