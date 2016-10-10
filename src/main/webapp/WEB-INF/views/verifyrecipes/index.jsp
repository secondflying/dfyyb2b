<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="配方审核" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			所有配方
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">缩略图</th>
					<th align="center">标题</th>
					<th align="center">描述</th>
					<th align="center">原价</th>
					<th align="center">现价</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty recipes}">
					<tr>
						<td colspan="6">空</td>
					</tr>

				</c:if>
				<c:forEach items="${recipes}" var="recipe">
					<tr class="${cssClass}">
						<td style="width:120px;"><img style="width:120px; height:90px;" src="${imageUrl}/${recipe.thumbnail}" id="recipeImage" /></td>
						<td style="width:90px;"><c:out value="${recipe.title}" /></td>
						<td style="height:50px; text-align:left;">
						<div class="textdiv1">
							<c:out value="${recipe.description}" />
						</div> 
						</td>
						<td style="width:75px;"><c:out value="${recipe.price}" /></td>
						<td style="width:75px;"><c:out value="${recipe.newprice}" /></td>
						<td  style="width:100px;">
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