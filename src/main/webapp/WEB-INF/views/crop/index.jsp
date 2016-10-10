<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="作物管理" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			作物列表
<%-- 			<c:url var="editUrl" value="/manager/crop/edit" /> --%>
<%-- 			<a id="addone" class="btn btn-info pull-right" href="${editUrl}"> --%>
<!-- 				<i class="icon-plus icon-white"></i> 新增 -->
<!-- 			</a> -->
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
					<th align="center">缩略图</th>
					<th align="center">大类</th>
					<th align="center">子类</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty crops}">
					<tr>
						<td colspan="4">空</td>
					</tr>
				</c:if>
				<c:forEach items="${crops}" var="crop">
					<tr>
						<td style="width: 150px;"><img style="width: 120px; height: 90px;" src="${imageUrl}/${crop.image}"
							id="diseaseImage" /></td>
						<td style="width: 200px;"><b><c:out value="${crop.name}" /></b></td>
						<td style="width: 200px; text-align: left;"></td>
						<td style=""><c:url var="eUrl" value="edit?id=${crop.id}" /> <a
								id="editone" class="btn btn-small btn-warning" href="${eUrl}">编辑 </a> <%-- 							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${disease.id})">删除</button> --%>
						</td>
					</tr>
					<c:forEach items="${crop.childCrops}" var="cc">
						<tr>
							<td style="width: 150px;"><img style="width: 120px; height: 90px;" src="${imageUrl}/${cc.image}" /></td>
							<td style="width: 200px;"></td>
							<td style="width: 200px; text-align: left;"><c:out value="${cc.name}" /></td>
							<td style=""><c:url var="eUrl" value="edit?id=${cc.id}" /> <a
									id="editone" class="btn btn-small btn-warning" href="${eUrl}">编辑 </a> <%-- 							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${disease.id})">删除</button> --%>
							</td>
						</tr>
					</c:forEach>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<script>
	$(document).ready(function() {

	});

	function deleteOne(id) {
		bootbox.confirm("确定要删除吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}

			$.post('<c:url value="delete" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
</script>


<jsp:include page="../includes/footer.jsp" />