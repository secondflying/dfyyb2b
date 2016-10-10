<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="vu" uri="http://com.dfyy.util/ViewUtils"%>


<!DOCTYPE html>
<html lang="en">
<head>
<title>${agrotechnical.title}</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<c:url var="cssUrl" value="/assets/bootstrap/css/bootstrap.css" />
<link href="${cssUrl}" rel="stylesheet" />
<c:url var="cssUrl" value="/assets/bootstrap/css/bootstrap-responsive.css" />
<link href="${cssUrl}" rel="stylesheet" />
<style type="text/css">
html body {
	width: 100%;
	margin: 0;
	padding: 0;
}

.container {
	margin: 5px;
}

.mblock {
	margin: 5px 0;
	background-color: #ffffff;
}

.mimage {
	padding: 0 10px;
}

.mimage img {
	width: 120px;
	height: 120px;
}

.muser {
	padding: 5px;
	position: relative;
}

.musername {
	position: absolute;
	top: 6px;
	left: 45px;
}

.mtime {
	position: absolute;
	top: 27px;
	left: 102px;
	color: #7F7F7F;
}

.muserlevel {
	position: absolute;
	top: 25px;
	left: 40px;
	border-radius: 5px;
	color: #ffffff;
	font-size: 12px;
}

.muserlevel1 {
	background-color: #69cfb3;
}

.muserlevel2 {
	background-color: #bb9ee4;
}

.muserlevel3 {
	background-color: #eb6464;
}

.muserlevel4 {
	background-color: #ff7f00;
}

.mcrop {
	position: absolute;
	right: 5px;
	top: 5px;
	color: #63C0A5;
}

.mborder {
	border-top: solid 1px #E0E0DE;
	border-bottom: solid 1px #E0E0DE;
	margin: 5px 10px 5px 10px;
	padding: 5px 0;
}

.mcontent {
	font-size: 18px;
	line-height: 20px;
	padding: 5px 10px;
}


.mcontent img {
	max-width: 100%;
	text-align: center;
}

.img-rounded {
	height: 40px;
	width: 40px;
	border-radius: 20px;
}

.mcomment {
	height: 30px;
	line-height: 30px;
	position: relative;
	padding: 5px 0;
}

.mcomment img {
	height: 20px;
	width: 20px;
}

.mpinglun {
	position: absolute;
	left: 0px;
	width: 49%;
	border-right: solid 1px #D8D8D8;
	text-align: center;
	color: #ACACAC;
	width: 49%;
}

.mzantong {
	position: absolute;
	right: 0px;
	width: 49%;
	text-align: center;
	color: #ACACAC;
}
</style>
</head>
<body>
	<div class="container">
		<h3 style="color: #505050;">${agrotechnical.title}</h3>
		<p style="color: #888888;">
			<small><fmt:formatDate value='${agrotechnical.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></small>
		</p>
			<div class="mcontent">
				${agrotechnical.content1}
			</div>

		<p style="color: #888888; height: 20px; line-height: 20px; padding-right: 10px;" class="text-right">
			<c:url var="imgurl" value="/assets/img/zan@3x.png" />
			<small>阅读数：${agrotechnical.readc} &nbsp;&nbsp;</small><img src="${imgurl}"
				style="vertical-align: top; width: 16px; height: 16px; cursor: pointer;" onclick="zan(${agrotechnical.id})" /><small
				id="zanshow">${agrotechnical.zan}
		</p>
		<c:forEach items="${agrotechnical.responses}" var="res">
			<div class="mblock">
				<div class="muser">

					<img class="img-rounded" src="${userUrl}/${res.writer.thumbnail}" />
					<div class="musername">${res.writer.alias}</div>
					<div class="muserlevel muserlevel${res.writer.levelID }">${res.writer.identifier}${vu:getLevelName(res.writer.levelID) }</div>
					<div class="mtime">${vu:getStandardDate(res.time) }</div>
				</div>
				<div class="mcontent mborder">${res.content}</div>
			</div>
		</c:forEach>
		<c:if test="${sd}">
			<div class="row" style="padding: 10px; text-align: center;">
				<a style="display: block;" href="http://a.app.qq.com/o/simple.jsp?pkgname=com.zhonghaodi.goodfarming">
					<c:url var="imgurl" value="/assets/img/download.png" />
					<img src="${imgurl}" />
				</a>
			</div>
		</c:if>
	</div>
</body>

<c:url var="jsurl1" value="/assets/jquery/js/jquery-1.8.3.js" />
<script src="${jsurl1}"></script>

<script>
	function zan(id) {
		$.post('<c:url value="/view/agrotechnical/zan" />', {
			id : id
		}).done(function(data) {
			$("#zanshow").html(data.zan);
		}).fail(function() {
		});
	}
</script>
</html>




