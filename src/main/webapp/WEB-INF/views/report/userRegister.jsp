<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="统计" scope="request" />
<jsp:include page="../includes/header.jsp" />
<c:url var="btcss" value="/assets/css/bt.css" />
<link href="${btcss}" rel="stylesheet">
<c:url var="cssUrl1" value="/assets/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link href="${cssUrl1}" rel="stylesheet" media="screen">

<section class="well shadow">
	<fieldset>
		<legend>统计类型 </legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<ul id="cateList" class="nav nav-pills" style="margin: 0;">
			<li id="report1" class=""><a href="index">用户分类统计</a></li>
			<li id="report2" class="active"><a href="userRegister">新用户注册统计</a></li>
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
		查询时段
		<input path="starttime" name='starttime' id="starttime" class="input-large" class="form_datetime" />
		至
		<input path="endtime" name='endtime' id="endtime" class="input-large" class="form_datetime" />
		<button id="locationBtn" class="btn btn-info" type="button" onclick="search()">查找</button>
	</div>
	<div class="row">
		<div id="canvas-holder">
			<canvas id="chart-area" width="850" height="400" />
		</div>
	</div>
</section>
<script type="text/javascript" src="../../assets/bootstrap/js/moment.js"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../assets/javascript/Chart.js"></script>
<script>
	$(document).ready(function() {
		$('#starttime').val(moment(new Date()).subtract(7, 'day').format("YYYY-MM-DD"));
		$('#endtime').val(moment(new Date()).format("YYYY-MM-DD"));
		$('#starttime').datetimepicker({
			format : "yyyy-mm-dd",
			weekStart : 1,
			autoclose : true,
			minView : 2,
			todayHighlight : true,
			language : 'zh-CN'
		});
		$('#endtime').datetimepicker({
			format : "yyyy-mm-dd",
			weekStart : 1,
			autoclose : true,
			minView : 2,
			todayHighlight : true,
			language : 'zh-CN'
		});

		search();
	});

	var myLineChart;
	function search() {
		var url = '<c:url value="userRegister.json" />';
		url = url + "?starttime=" + $('#starttime').val() + "&endtime=" + $('#endtime').val();
		$.get(url, function(result) {
			if (myLineChart) {
				myLineChart.destroy();
			}
			var data = {
				labels : result[0],
				datasets : [ {
					label : "",
					fillColor : "rgba(220,220,220,0.5)",
					strokeColor : "rgba(220,220,220,0.8)",
					highlightFill : "rgba(220,220,220,0.75)",
					highlightStroke : "rgba(220,220,220,1)",
					data : result[1]
				} ]
			};

			var ctx = document.getElementById("chart-area").getContext("2d");
			myLineChart = new Chart(ctx).Line(data, {
				bezierCurve : false
			});
		});
	}
</script>


<jsp:include page="../includes/footer.jsp" />