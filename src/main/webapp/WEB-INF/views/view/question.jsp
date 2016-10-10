<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="vu" uri="http://com.dfyy.util/ViewUtils"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>${question.content}</title>
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
	border-bottom: solid 1px #cccccc;
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
	font-size: 16px;
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

<body style="background-color: #eeeeee;">
	<div class="container">
		<div class="mblock">
			<div class="muser">
				<img class="img-rounded" src="${userUrl}/${question.writer.thumbnail}" />
				<div class="musername">${question.writer.alias}</div>
				<div class="muserlevel muserlevel${question.writer.levelID }">${question.writer.identifier}${question.writer.level.name}</div>
				<div class="mtime">${vu:getStandardDate(question.time) }</div>
				<div class="mcrop">${question.crop.name}</div>
			</div>

			<div class="mborder">
				<div class="mcontent">${question.content}</div>
				<div class="mimage">
					<c:forEach items="${question.attachments}" var="att">
						<img src="${imageUrl}/${att.url}" />
					</c:forEach>
				</div>
			</div>
			<div style="color: #888888; text-align: center; height: 30px; line-height: 30px;">已有${question.responsecount }个答案</div>
		</div>

		<c:forEach items="${question.responses}" var="res">
			<div class="mblock">
				<div class="muser">

					<img class="img-rounded" src="${userUrl}/${res.writer.thumbnail}" />
					<div class="musername">${res.writer.alias}</div>
					<div class="muserlevel muserlevel${res.writer.levelID }">${res.writer.identifier}${vu:getLevelName(res.writer.levelID) }</div>
					<div class="mtime">${vu:getStandardDate(res.time) }</div>

				</div>
				<div class="mcontent mborder">${res.content1}</div>

				<div class="mcomment">
					<c:url var="imgurl1" value="/assets/img/comment.png" />
					<c:url var="imgurl2" value="/assets/img/zan.png" />

					<div class="mpinglun">
						<img src="${imgurl1 }" /> 评论(${res.commentCount})
					</div>
					<div class="mzantong">
						<img src="${imgurl2 }" /> 赞同(${res.agree != null ? res.agree : 0})
					</div>
				</div>
			</div>
		</c:forEach>


		<div class="row" style="padding: 10px; text-align: center;">
			<a style="display: block;" href="http://a.app.qq.com/o/simple.jsp?pkgname=com.zhonghaodi.goodfarming">
				<c:url var="imgurl" value="/assets/img/download.png" />
				<img src="${imgurl}" />
			</a>
		</div>
	</div>
</body>

<c:url var="jsurl1" value="/assets/jquery/js/jquery-1.8.3.js" />
<script src="${jsurl1}"></script>
</html>

