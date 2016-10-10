<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="配方管理" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			病虫害列表
			<c:url var="editUrl" value="/manager/diseases/edit" />
			<a id="addone" class="btn btn-blue pull-right" href="${editUrl}">
				<i class="icon-plus icon-white"></i> 新增
			</a>
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
					<th align="center">缩略图</th>
					<th align="center" >名称</th>
					<th align="center">描述</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty diseases}">
					<tr>
						<td colspan="5">空</td>
					</tr>

				</c:if>
				<c:forEach items="${diseases}" var="disease">
					<tr class="${cssClass}">
						<td style="width:120px;"><img style="width:120px; height:90px;" src="${imageUrl}/${disease.thumbnail}" id="diseaseImage" /></td>
						<td style="width:120px;"><c:out value="${disease.name}" /></td>
						<td style="height:50px; text-align:left;">
						<div class="textdiv">
							<c:out value="${disease.description}" />
						</div> 
						</td>
						<td  style="width:120px;">
							<c:url var="eUrl" value="/manager/diseases/edit?id=${disease.id}" />
							<a id="editone" class="btn btn-small btn-orange" href="${eUrl}">
								编辑
							</a>
							<button class="btn btn-small btn-red" type="button" onclick="deleteOne(${disease.id})">删除</button>
						</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<script>

	$(document).ready(function() {
		
		page();						
	
	});

	function deleteOne(id) {
		bootbox.confirm("确定要删除吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
	
			$.post('<c:url value="/manager/disease/delete" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
</script>


<jsp:include page="../includes/footer.jsp" />