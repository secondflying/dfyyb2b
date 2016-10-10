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
		<legend>
			统计类型
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<ul id="cateList" class="nav nav-pills" style="margin: 0;">
			<li id="report1" class=""><a href="index">用户分类统计</a></li>
			<li id="report2" class=""><a href="userRegister">新用户注册统计</a></li>
			<li id="report2" class=""><a href="userActive">活跃用户统计</a></li>
			<li id="report3" class=""><a href="userRecommend">用户推荐统计</a></li>
			<li id="report3" class=""><a href="userRecTime">每日推荐统计</a></li>
			<li id="report4" class=""><a href="userSecond">秒杀订单统计</a></li>
			<li id="report5" class="active"><a href="topQuestion">作物问题top10</a></li>
			<li id="report6" class=""><a href="userSignin">每日签到</a></li>
<!-- 			<li id="report7" class=""><a href="userResponse">每日回答</a></li> -->
		</ul>
	</fieldset>
</section>


<section id="questionsta" class="well shadow">
	<fieldset>
		<table id="remList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">作物名称</th>
					<th align="center">问题数</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty questionStas}">
					<tr>
						<td colspan="2">空</td>
					</tr>

				</c:if>
				<c:forEach items="${questionStas}" var="questionSta">
					<tr class="${cssClass}">
						<td><c:out value="${questionSta.crop.name}" /></td>
						<td><c:out value="${questionSta.count}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<script type="text/javascript" src="../../assets/javascript/Chart.js"></script>
<script>
	
</script>


<jsp:include page="../includes/footer.jsp" />