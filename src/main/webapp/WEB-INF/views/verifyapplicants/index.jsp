<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="用户申请管理" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			用户申请列表
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
			<thead>
				<tr>
					<th align="center">用户名</th>
					<th align="center">申请级别</th>
					<th align="center">描述</th>
					<th align="center">申请时间</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty applicants}">
					<tr>
						<td colspan="5">空</td>
					</tr>

				</c:if>
				<c:forEach items="${applicants}" var="applicant">
					<tr class="${cssClass}">
						<td><c:out value="${applicant.user.phone}" /></td>
						<td><c:out value="${applicant.level.name}" /></td>
						<td>
							<div class="textdiv" style="width:200px;">
								<c:out value="${applicant.description}" />
							</div> 
						</td>
						<td><c:out value="${applicant.time}" /></td>
						<td>
							<c:url var="eUrl" value="check?id=${applicant.id}" />
							<a id="editone" class="btn btn-small btn-warning" href="${eUrl}">
								审核
							</a>
						</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<jsp:include page="../includes/footer.jsp" />