<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="秒杀订单" scope="request" />
<jsp:include page="header.jsp" />


<section class="well shadow">
	<fieldset>
		<legend>
			秒杀订单
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">缩略图</th>
					<th align="center" >秒杀产品</th>
					<th align="center">时间</th>
					<th align="center">订购人</th>
					<th align="center">总价</th>
					<th align="center">状态</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty orders}">
					<tr>
						<td colspan="8">空</td>
					</tr>

				</c:if>
				<c:forEach items="${orders}" var="order">
					<tr class="${cssClass}">
						<td style="width:120px;"><img style="width:120px; height:90px;" src="${imageUrl}/${order.second.image}" id="recipeImage" /></td>
						<td>
							<c:out value="${order.second.title}" />
							<br/>
							￥<c:out value="${order.second.nprice}" />
						</td>
						<td><c:out value="${order.time}" /></td>
						<td>
							<c:out value="${order.user.alias}" />
							<br/>
							<c:out value="${order.user.phone}" />
						</td>
						<td>￥<c:out value="${order.price}" /></td>
						<td>
						<c:choose>  
						    <c:when test="${order.status==0}"><span class="label label-default" style="width:60px; text-align:center; background-color:#d9534f">未完成</span></c:when>  
						    <c:when test="${order.status==1}"><span class="label label-default" style="width:60px; text-align:center; background-color:#5cb85c">已完成</span></c:when>  
						</c:choose> 
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
			window.location.href = '<c:url value="/nzd/secondorders" />?page=' + page + "&size=" + size;
		}
	};

	var $pager = $('<div class="page"></div>');
	$pager.insertAfter($('table'));
	$pager.bootstrapPaginator(options);
});
</script>


<jsp:include page="../includes/footer.jsp" />