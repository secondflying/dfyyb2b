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
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
}

.imgcon {
	width: 100%;
	max-width: 720px; margin : 0 auto;
	height: auto;
	position: relative;
	margin: 0 auto;
}

#downloaddiv {
	width: 100%;
	max-width: 720px;
	text-align: center;
	position: absolute;
	top: 0;
	left: 0;
}

#download {
	display: block;
}

#sharecode {
	width: 100%;
	max-width: 720px;
	position: absolute;
	text-align: center; position : absolute; top : 0; left : 0;
	color: #ffffff;
	font-size: 12px;
	position: absolute;
	top: 0;
	left: 0;
}

#bottomdownload {
	width: 100%;
	position: fixed;
	bottom: 0px;
}

#bottomdownload a {
	display: block;
	margin: 0 auto;
	max-width: 720px;
}
</style>
</head>
<body>
	<div id="container">
		<div class="imgcon">
			<img src="../assets/img/share/1.jpg" style="width: 100%;" />
		</div>
		<div class="imgcon">
			<img src="../assets/img/share/2.jpg" style="width: 100%;" />
			<div id="downloaddiv">
				<a id="download" href="http://a.app.qq.com/o/simple.jsp?pkgname=com.zhonghaodi.goodfarming">
					<img src="../assets/img/share/download.png" style="width: 50%;" />
				</a>
			</div>
		</div>
		<div class="imgcon">
			<img src="../assets/img/share/3.jpg" style="width: 100%;" />
		</div>
		<div class="imgcon">
			<img src="../assets/img/share/4.jpg" style="width: 100%;" />
			<div id="sharecode">
				<label>${user.tjcode}</label>
			</div>
		</div>
		<div class="imgcon">
			<img src="../assets/img/share/5.jpg" style="width: 100%;" />
		</div>
	</div>
	<div id="bottomdownload">
		<a href="http://a.app.qq.com/o/simple.jsp?pkgname=com.zhonghaodi.goodfarming">
			<img src="../assets/img/share/bottom.jpg" style="width: 100%;" />
		</a>
	</div>
</body>

</html>




