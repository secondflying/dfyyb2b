<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="下级经销商" scope="request" />
<jsp:include page="../includes/proheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="informal" />
			<li class=""><a href="${infoUrl}">待审核商品</a></li>
			<c:url var="infoUrl2" value="subordinates" />
			<li class="active"><a href="${infoUrl2}">经销商</a></li>
		</ul>
	</div>
</div>

<section class="well">
	<fieldset>
		<legend>
			下级经销商
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<c:if test="${success != null}">
			<div class="alert alert-success" id="successMessage">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				<strong><c:out value="${success}" /></strong>
			</div>
			<script>
				$("#successMessage").delay(2000).slideUp("slow");
			</script>
		</c:if>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead class="info">
				<tr>
					<th align="center">名称</th>
					<th align="center">地址</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty pdealers}">
					<tr>
						<td colspan="4">空</td>
					</tr>

				</c:if>
				<c:forEach items="${pdealers}" var="user">
					<tr class="${cssClass}">
						<td style="width:120px;"><c:out value="${user.dealer.alias}" /></td>
						<td style="width:200px;"><c:out value="${user.dealer.address}" /></td>
						<td>
							<c:url var="cUrl" value="dealercommodities?id=${user.dealer.id}" />
							<a id="checkone" class="btn btn-small btn-warning" href="${cUrl}">
								商品
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<script>

	$(document).ready(function() {
		 
	});

</script>


<jsp:include page="../includes/footer.jsp" />