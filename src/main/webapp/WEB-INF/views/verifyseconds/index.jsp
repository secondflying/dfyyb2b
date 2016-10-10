<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="秒杀审核" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			所有秒杀
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">缩略图</th>
					<th align="center">店名</th>
					<th align="center">标题</th>
					<th align="center">描述</th>
					<th align="center">个数</th>
					<th align="center">有效期</th>
					<th align="center">原价</th>
					<th align="center">秒杀价</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty seconds}">
					<tr>
						<td colspan="9">空</td>
					</tr>

				</c:if>
				<c:forEach items="${seconds}" var="recipe">
					<tr class="${cssClass}">
						<td style="width:120px;"><img style="width:120px; height:90px;" src="${imageUrl}/${recipe.image}" id="recipeImage" /></td>
						<td style="width:75px;"><c:out value="${recipe.nzd.alias}" /></td>
						<td style="width:90px;"><c:out value="${recipe.title}" /></td>
						<td style="height:50px; text-align:left;">
						<div class="textdiv1">
							<c:out value="${recipe.content}" />
						</div> 
						</td>
						<td style="width:55px;"><c:out value="${recipe.count}" /></td>
						<td style="width:120px;">${recipe.starttime} <br/> -- <br/>${recipe.endtime} </td>
						<td style="width:65px;"><c:out value="${recipe.oprice}" /></td>
						<td style="width:65px;"><c:out value="${recipe.nprice}" /></td>
						<td  style="width:80px;">
							<c:url var="eUrl" value="check?id=${recipe.id}" />
							<a id="editone" class="btn btn-small btn-orange" href="${eUrl}">
								审核
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
	
	page();						

});
</script>


<jsp:include page="../includes/footer.jsp" />