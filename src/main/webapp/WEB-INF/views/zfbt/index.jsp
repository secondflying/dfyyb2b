<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="政府补贴" scope="request" />
<jsp:include page="../includes/header.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="index" />
			<li class="active"><a href="${infoUrl}">秒杀列表</a></li>
			<c:url var="infoUrl2" value="orders" />
			<li class=""><a href="${infoUrl2}">秒杀订单</a></li>
		</ul>
	</div>
</div>

<section class="well shadow">
	<fieldset>
		<legend>
			秒杀列表
			<c:url var="editUrl" value="add" />
			<a id="addone" class="btn btn-info pull-right" href="${editUrl}">
				<i class="icon-plus icon-white"></i> 新增
			</a>
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">缩略图</th>
					<th align="center">标题</th>
					<th align="center">起止时间</th>
					<th align="center">原价</th>
					<th align="center">现价</th>
					<th align="center">状态</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty seconds}">
					<tr>
						<td colspan="8">空</td>
					</tr>

				</c:if>
				<c:forEach items="${seconds}" var="second">
					<tr class="${cssClass}">
						<td style="width: 120px;"><img style="width: 120px; height: 90px;" src="${imageUrl}/${second.image}"
							id="secondImage" /></td>
						<td style="width: 90px;"><c:out value="${second.title}" /></td>
						<td style="height: 50px; text-align: left;"><c:out value="开始：${second.starttime}" /> <br> <c:out
								value="结束：${second.endtime}" /></td>
						<td style="width: 75px;"><c:out value="￥${second.oprice}" /></td>
						<td style="width: 75px;"><c:out value="￥${second.nprice}" /></td>
						<td style="width: 75px;"><c:choose>
								<c:when test="${second.verify==1 && second.status==0}">未开始</c:when>
								<c:when test="${second.verify==1 && second.status==1}">进行中</c:when>
								<c:when test="${second.verify==1 && second.status==2}">已结束</c:when>
							</c:choose></td>
						<td style="width: 100px;"><c:url var="eUrl" value="edit?id=${second.id}" /> <a id="editone"
								class="btn btn-small btn-warning" href="${eUrl}"> 编辑 </a>
							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${second.id})">删除</button></td>

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