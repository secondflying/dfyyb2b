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
<body style="background-color: #37be99; margin: 0; padding: 0;">
	<div style="text-align: center;">
		<c:url var="shareimg" value="/assets/img/logo256.png" />
		<img style="width: 100px; height: 100px;" src="${shareimg}" />
	</div>
	<div style="text-align: center; background-color: #f9be00; height: 4px; margin: 0; padding: 0;"></div>

	<div style="color: #ffffff; text-align: center; margin: 10px auto; font-size: 20px; font-weight: bold;">种好地</div>
	<div style="color: #ffffff; text-align: center; margin: 10px auto; font-size: 18px;">让种地更简单</div>
	<div style="color: #ffffff; text-align: center; margin: 25px auto 10px auto; font-size: 16px;">农民的手机植物医生</div>
	<div style="color: #ffffff; text-align: center; margin: 10px auto; font-size: 16px;">病害图谱全面共享</div>
	<div style="color: #ffffff; text-align: center; margin: 10px auto; font-size: 16px;">专家即时在线诊断</div>
	<div style="color: #ffffff; text-align: center; margin: 40px auto 0 auto; font-size: 16px;">记得点我下载哦</div>
	<div style="text-align: center; background-color: #63d7a6; padding: 10px;">
		<a style="display: block;" href="http://a.app.qq.com/o/simple.jsp?pkgname=com.zhonghaodi.goodfarming">
			<c:url var="imgurl" value="/assets/img/downloadApp.png" />
			<img src="${imgurl}" style="width: 80px; height: 80px;" />
		</a>
	</div>
	<div style="text-align: center; background-color: #62ebdb; height: 4px; margin: 0; padding: 0;"></div>
	<div style="color: #ffffff; text-align: center; margin: 10px auto; font-size: 16px;">我正在使用 你 还在等什么</div>
	<div style="color: #ffffff; text-align: center; margin: 10px auto; font-size: 16px;">下载种好地APP注册记得输入我的推荐码</div>
	<div style="color: #ffffff; text-align: center; margin: 10px auto; font-size: 16px;">${user.tjcode}</div>
	<!-- 		<div class="row" style="color: #ffffff; text-align: center;"> -->
	<!-- 			<h4>下载种好地App注册输入我的推荐码</h4> -->
	<%-- 			<h3>${user.tjcode}</h3> --%>
	<!-- 			<h4>手机植物医生：专家在线，即时回答，诊断精确，知识全面。</h4> -->
	<!-- 		</div> -->
	<!-- 		<div class="row" style="padding: 10px; text-align: center;"> -->
	<!-- 			<a style="display: block;" href="http://a.app.qq.com/o/simple.jsp?pkgname=com.zhonghaodi.goodfarming"> -->
	<%-- 				<c:url var="imgurl" value="/assets/img/download.png" /> --%>
	<%-- 				<img src="${imgurl}" /> --%>
	<!-- 			</a> -->
	<!-- 		</div> -->
</body>

</html>




