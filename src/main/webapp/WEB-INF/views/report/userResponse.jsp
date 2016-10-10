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

<!-- <section class="well shadow"> -->
<!-- 	<fieldset> -->
<!-- 		<legend>统计类型 </legend> -->
<!-- 		<div class="divnull">&nbsp;&nbsp;</div> -->
<!-- 		<ul id="cateList" class="nav nav-pills" style="margin: 0;"> -->
<!-- 			<li id="report1" class=""><a href="index">用户分类统计</a></li> -->
<!-- 			<li id="report2" class=""><a href="userRegister">新用户注册统计</a></li> -->
<!-- 			<li id="report2" class=""><a href="userActive">活跃用户统计</a></li> -->
<!-- 			<li id="report3" class=""><a href="userRecommend">用户推荐统计</a></li> -->
<!-- 			<li id="report3" class=""><a href="userRecTime">每日推荐统计</a></li> -->
<!-- 			<li id="report4" class=""><a href="userSecond">秒杀订单统计</a></li> -->
<!-- 			<li id="report5" class=""><a href="topQuestion">作物问题top10</a></li> -->
<!-- 			<li id="report6" class=""><a href="userSignin">每日签到</a></li> -->
<!-- 			<li id="report7" class="active"><a href="userResponse">每日回答</a></li> -->
<!-- 		</ul> -->
<!-- 	</fieldset> -->
<!-- </section> -->

<section id="category" class="well shadow" style="display: block">
	<div class="row">
		查询时间
		<input path="time" name='time' id="time" class="input-large" class="form_datetime" />
		至
		<input path="endtime" name='endtime' id="endtime" class="input-large" class="form_datetime" />
		<button id="locationBtn" class="btn btn-info" type="button" onclick="search()">查找</button>
	</div>
	<div class="row">
		<table id="remList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">姓名</th>
					<th align="center">用户类型</th>
					<th align="center">联系电话</th>
					<th align="center">回答问题个数</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty responseStaDtos}">
					<tr>
						<td colspan="4">空</td>
					</tr>
				</c:if>
				<c:forEach items="${responseStaDtos}" var="responsesta">
					<tr class="${cssClass}">
						<td><c:out value="${responsesta.name}" /></td>
						<td><c:out value="${responsesta.level}" /></td>
						<td><c:out value="${responsesta.phone}" /></td>
						<td><c:out value="${responsesta.count}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</section>
<script type="text/javascript" src="../../assets/bootstrap/js/moment.js"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../assets/javascript/Chart.js"></script>
<script>
	$(document).ready(function() {
		$('#time').val(moment(new Date()).format("YYYY-MM-DD"));
		$('#endtime').val(moment(new Date()).format("YYYY-MM-DD"));
		
	    var time = getUrlParam("time");
	    var endtime = getUrlParam("endtime");
	    if(time){
			$('#time').val(time);
	    }
	    
	    if(endtime){
			$('#endtime').val(endtime);
	    }

		$('#time').datetimepicker({
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
		
	});

	function search() {
		var url = '<c:url value="index" />';
		url = url + "?time=" + $('#time').val() + "&endtime="  + $('#endtime').val();
		window.location.href = url;
	}
</script>


<jsp:include page="../includes/footer.jsp" />