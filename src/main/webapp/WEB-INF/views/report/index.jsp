<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="统计" scope="request" />
<jsp:include page="../includes/header.jsp" />
<c:url var="btcss" value="/assets/css/bt.css" />
<link href="${btcss}" rel="stylesheet">
<section class="well shadow">
	<fieldset>
		<legend> 统计类型 </legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<ul id="cateList" class="nav nav-pills" style="margin: 0;">
			<li id="report1" class="active"><a href="index">用户分类统计</a></li>
			<li id="report2" class=""><a href="userRegister">新用户注册统计</a></li>
			<li id="report2" class=""><a href="userActive">活跃用户统计</a></li>
			<li id="report3" class=""><a href="userRecommend">用户推荐统计</a></li>
			<li id="report3" class=""><a href="userRecTime">每日推荐统计</a></li>
			<li id="report4" class=""><a href="userSecond">秒杀订单统计</a></li>
			<li id="report5" class=""><a href="topQuestion">作物问题top10</a></li>
			<li id="report6" class=""><a href="userSignin">每日签到</a></li>
<!-- 			<li id="report7" class=""><a href="userResponse">每日回答</a></li> -->
		</ul>
	</fieldset>
</section>

<section id="category" class="well shadow" style="display: block">
	<div class="row">
		<div class="col-sm-2">
			<!-- 				所有 -->
			<!-- 				<br/> -->
			<!-- 				今日 -->
			<!-- 				<br/> -->
			<!-- 				昨日 -->
			<!-- 				<br/> -->
			<!-- 				本周 -->
			<!-- 				<br/> -->
			<!-- 				上周 -->
			<br />
		</div>
		<div id="canvas-holder" class="col-sm-6">
			<canvas id="chart-area" width="400" height="400" />
		</div>
		<div id="legenddiv" class="col-sm-2" style="vertical-align: bottom"></div>
	</div>
</section>

<script type="text/javascript" src="../../assets/javascript/Chart.js"></script>
<script>
$(document).ready(
		function () {
		$.get('<c:url value="category" />',
			function (result) {
			var ctx = document.getElementById("chart-area").getContext("2d");
			var myPie = new Chart(ctx).Pie(result);
			$.each(result, function (n, value) {
				var html = '<span class="label label-default" style="width:80px; text-align:center; background-color:' + value.color + '">'
					 + value.label
					 + ':'
					 + value.value
					 + '</span><br/>';

				$("#legenddiv").append(html);
			});

		});
	});

</script>


<jsp:include page="../includes/footer.jsp" />