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
	max-width: 720px;
	margin: 0 auto;
	height: auto;
	position: relative;
	margin: 0 auto;
}

#downloaddiv {
	width: 35%;
	height: 30px;
	line-height: 30px;
	max-width: 200px;
	text-align: center;
	color: #ffffff;
	font-size: 14pt;
	border: solid 1px #ffffff;
	border-radius: 5px;
	position: absolute;
	top: 11%;
	left: 49%;
}

#downloaddiv a,#downloaddiv a:active,#downloaddiv a:hover,#downloaddiv a:visited
	{
	color: #ffffff;
	outline: 0;
	text-decoration: none;
}

#sharecodediv {
	width: 90%;
	text-align: center;
	color: #ffffff;
	font-size: 10pt;
	border: solid 1px #ffffff;
	border-radius: 5px;
	position: absolute;
	bottom: 3.9%;
	left: 4%;
}

#sharecodediv label {
	display: inline-block;
	margin: 0 5px;
	font-size: 12pt;
}

#sharecode {
	width: 100%;
	max-width: 720px;
	position: absolute;
	text-align: center;
	position: absolute;
	top: 0;
	left: 0;
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
			<img src="../assets/img/share/back2.jpg" style="width: 100%;" />
			<div id="downloaddiv">
				<a href="http://a.app.qq.com/o/simple.jsp?pkgname=com.zhonghaodi.goodfarming"> APP 免费下载 </a>
			</div>

			<div id="sharecodediv">
				<p>
					好友专属推荐码 <label>${user.tjcode}</label> (长按复制)
				</p>
				<p>马上下载种好地APP吧！填写好友推荐码更有意外惊喜</p>
			</div>
		</div>
	</div>
	<div id="bottomdownload">
		<a href="http://a.app.qq.com/o/simple.jsp?pkgname=com.zhonghaodi.goodfarming">
			<img src="../assets/img/share/bottom.jpg" style="width: 100%;" />
		</a>
	</div>
</body>

</html>




