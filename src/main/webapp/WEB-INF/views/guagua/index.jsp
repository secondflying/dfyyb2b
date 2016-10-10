<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="刮刮乐商品" scope="request" />
<jsp:include page="../includes/header.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="index" />
			<li class="active"><a href="${infoUrl}">刮刮乐商品</a></li>
			<c:url var="infoUrl2" value="orders" />
			<li class=""><a href="${infoUrl2}">刮刮乐订单</a></li>
		</ul>
	</div>
</div>

<section class="well shadow">
	<fieldset>
		<legend>
			刮刮乐商品
			<c:url var="editUrl" value="edit" />
			<a id="addone" class="btn btn-info pull-right" href="${editUrl}">
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
					<th align="center">图片</th>
					<th align="center">名称</th>
					<th align="center">起止时间</th>
					<th align="center">个数</th>
					<th align="center">描述</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty guagua}">
					<tr>
						<td colspan="5">空</td>
					</tr>

				</c:if>
				<c:forEach items="${guagua}" var="gua">
					<tr class="${cssClass}">
						<td style="width:120px;"><img style="width:120px; height:90px;" src="${imageUrl}/${gua.image}" /></td>
						<td style="width:120px;"><c:out value="${gua.name}" /></td>
						<td style="width:180px; ">
						开始：<fmt:formatDate value='${gua.starttime}' type='date' pattern='yyyy-MM-dd HH:mm' />
						<br>
						结束：<fmt:formatDate value='${gua.endtime}' type='date' pattern='yyyy-MM-dd HH:mm' />
						</td>
						<td style="width:50px;"><c:out value="${gua.count}" /> </td>
						<td style="height:50px; text-align:left;">
						<div class="textdiv" style="width:100px;">
							<c:out value="${gua.description}" />
						</div> 
						</td>
						<td  style="width:100px;">
							<c:url var="eUrl" value="edit?id=${gua.id}" />
							<a id="editone" class="btn btn-small btn-warning" href="${eUrl}">
								编辑
							</a>
							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${gua.id})">下架</button>
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