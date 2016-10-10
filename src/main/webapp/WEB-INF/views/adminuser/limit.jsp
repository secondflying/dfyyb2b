<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:set var="pageTitle" value="权限分配" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<legend> 权限分配 </legend>
	<div class="divnull">&nbsp;&nbsp;</div>
	<c:url var="adminlimitUrl" value="limitedit" />
	<form id="limitedit-form" class="form-horizontal" action="${adminlimitUrl }" method="post"
		enctype="application/x-www-form-urlencoded">
		<fieldset>
			<input name="aid" value="${aid}" type="hidden" />
			<table>
				<c:forEach items="${lists}" var="limit">
					<c:if test="${limit.column==0}">
						<tr>
							<td style="width: 200px;">
								<ul class="rights">
									<li>
									
									<input name="quanxian" type="checkbox" value="${limit.id}" ${limit.hasright?"checked":""} />
									 <label for="name">${limit.name }</label>
									</li>
								</ul>
							</td>
					</c:if>
					<c:if test="${limit.column==1}">
						<td style="width: 200px;">
							<ul class="rights">
								<li><input name="quanxian" type="checkbox" value="${limit.id}" ${limit.hasright?"checked":""} /> 
								<label for="name">${limit.name }</label>
								</li>
							</ul>
						</td>
					</c:if>
					<c:if test="${limit.column==2}">
						<td style="width: 200px;">
							<ul class="rights">
								<li><input name="quanxian" type="checkbox" value="${limit.id}" ${limit.hasright?"checked":""} />
								 <label for="name">${limit.name }</label></li>
							</ul>
						</td>
					</c:if>
					<c:if test="${limit.column==3}">
						<td style="width: 200px;">
							<ul class="rights">
								<li><input name="quanxian" type="checkbox" value="${limit.id}" ${limit.hasright?"checked":""} />
										<label for="name">${limit.name }</label></li>
							</ul>
						</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
			<div class="control-group">
				<label class="control-label span2" for="login-btn"></label>
				<input type="submit" id="recipe-btn" value="确  定" class="btn btn-info span3">
			</div>
		</fieldset>
	</form>
</section>

<script>

</script>


<jsp:include page="../includes/footer.jsp" />