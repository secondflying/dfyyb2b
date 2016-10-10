<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>积分规则</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<c:url var="cssUrl" value="/assets/bootstrap/css/bootstrap.css" />
<link href="${cssUrl}" rel="stylesheet" />
<c:url var="cssUrl" value="/assets/bootstrap/css/bootstrap-responsive.css" />
<link href="${cssUrl}" rel="stylesheet" />

<style type="text/css">
html{
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}
body {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
	background: url("../assets/img/point_rule.jpg") no-repeat center center fixed;
	 -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
	background-size: cover;
}

#bdiv {
	width: 100%;
	height: 100%;
	padding:0 0 70px 0;
}

.rdiv {
	color: #ffffff;
	padding: 10px 20px 10px 20px;
	font-size: 18px;
}

</style>
</head>
<body>
	<div id="bdiv">
		<c:forEach items="${prs}" var="pr">
			<div class="rdiv" style="">${pr}</div>
		</c:forEach>
	</div>
</body>
</html>




