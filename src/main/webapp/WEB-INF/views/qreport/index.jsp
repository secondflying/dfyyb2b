<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="病害举报" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend> 病害举报 </legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">被举报人</th>
					<th align="center">答案内容</th>
					<th align="center">举报人</th>
					<th align="center">举报原因</th>
					<th align="center">时间</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty reports}">
					<tr>
						<td colspan="6">空</td>
					</tr>

				</c:if>
				<c:forEach items="${reports}" var="report">
					<tr class="${cssClass}">
						<td style="width: 160px;"><c:out value="${report.response.writer.alias}" /></td>
						<td style="width: 160px;"><c:out value="${report.response.content1}" /></td>
						<td style="width: 100px;"><c:out value="${report.user.alias}" /></td>
						<td style="width: 160px;"><c:out value="${report.reason}" /></td>
						<td style="width: 100px;"><fmt:formatDate value='${report.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td style="width: 100px;">
							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${report.response.id})">删除</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>


<script>
$(document).ready(function () {
	var size = 10;
	var sumcount = parseInt(${sumcount});
	if (sumcount == 0) {
		return false
	}
	var numPages = Math.ceil(sumcount / size);
	var currentPage = getUrlParam("page");
	currentPage = currentPage ? parseInt(currentPage) + 1 : 1;
	var options = {
		currentPage : currentPage,
		totalPages : numPages,
		size : 'small',
		alignment : 'center',
		itemTexts : function (type, page, current) {
			switch (type) {
			case "first":
				return "首页";
			case "prev":
				return "前一页";
			case "next":
				return "后一页";
			case "last":
				return "末页";
			case "page":
				return "" + page;
			}
		},

		onPageClicked : function (event, originalEvent, type, page) {
			var page = page - 1;
			window.location.href = '<c:url value="index" />?page=' + page + "&size=" + size;
		}
	};

	var $pager = $('<div class="page"></div>');
	$pager.insertAfter($('table'));
	$pager.bootstrapPaginator(options);
});	
	
	function deleteOne(id) {
		bootbox.confirm("确定要删除该答案吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
	
			$.post('<c:url value="/manager/question/resdelete" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
</script>


<jsp:include page="../includes/footer.jsp" />