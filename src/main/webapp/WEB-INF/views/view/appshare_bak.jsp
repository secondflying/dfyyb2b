<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>应用分享</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<c:url var="cssUrl" value="/assets/bootstrap/css/bootstrap.css" />
<link href="${cssUrl}" rel="stylesheet" />
<c:url var="cssUrl" value="/assets/bootstrap/css/bootstrap-responsive.css" />
<link href="${cssUrl}" rel="stylesheet" />
</head>
<body style="background-color: #1ab289;">
	<div class="container">
		<div class="row" style="text-align: center;">
			<div style="width: 230px; height: 230px; background-color: #ffffff; border-radius: 50%; margin: 10px auto;">
				<img class="img-rounded" style="width: 220px; height: 220px; border-radius: 50%; margin: 5px auto;"
					src="${imageUrl}/${user.thumbnail}" />
			</div>
		</div>

		<div class="row" style="color: #ffffff; text-align: center; margin: 10px auto;">
			<c:url var="shareimg" value="/assets/img/sharelogo.png" />
			<img src="${shareimg}" />
		</div>
		<div class="row" style="color: #ffffff; text-align: center;">
			<h4>下载种好地App注册输入我的推荐码</h4>
			<h3>${user.tjcode}</h3>
			<h4>手机植物医生：专家在线，即时回答，诊断精确，知识全面。</h4>
		</div>
		<div class="row" style="padding: 10px; text-align: center;">
			<a style="display: block;" href="http://a.app.qq.com/o/simple.jsp?pkgname=com.zhonghaodi.goodfarming">
				<c:url var="imgurl" value="/assets/img/download.png" />
				<img src="${imgurl}" />
			</a>
		</div>
	</div>
</body>

</html>




