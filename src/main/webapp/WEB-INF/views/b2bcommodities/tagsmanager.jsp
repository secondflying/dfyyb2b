<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="商品管理" scope="request" />
<jsp:include page="../includes/mheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infUrl" value="informal" />
			<li><a href="${infUrl}">待审核商品</a></li>
			<c:url var="cheUrl" value="checked" />
			<li class="active"><a href="${cheUrl}">已上架商品</a></li>
		</ul>
	</div>
</div>

<section class="content-wrap">
	<div class="container">
		<div class="row">
			<div class="column span12">
				<div class="well">
					<legend>
						商品标签
					</legend>
					<div class="divnull">&nbsp;&nbsp;</div>
					<c:url var="adminlimitUrl" value="commoditytagsedit" />
					<form id="limitedit-form" class="form-horizontal" action="${adminlimitUrl }" method="post"
						enctype="application/x-www-form-urlencoded">
						<fieldset>
							<input name="cid" value="${cid}" type="hidden" />
							<table>
								<c:forEach items="${lists}" var="limit">
									<c:if test="${limit.column==0}">
										<tr>
											<td style="width: 200px;">
												<ul class="rights">
													<li>													
													<input name="biaoqian" type="checkbox" value="${limit.id}" ${limit.hasright?"checked":""} />
													 <label for="name">${limit.name }</label>
													</li>
												</ul>
											</td>
									</c:if>
									<c:if test="${limit.column==1}">
										<td style="width: 200px;">
											<ul class="rights">
												<li><input name="biaoqian" type="checkbox" value="${limit.id}" ${limit.hasright?"checked":""} /> 
												<label for="name">${limit.name }</label>
												</li>
											</ul>
										</td>
									</c:if>
									<c:if test="${limit.column==2}">
										<td style="width: 200px;">
											<ul class="rights">
												<li><input name="biaoqian" type="checkbox" value="${limit.id}" ${limit.hasright?"checked":""} />
												 <label for="name">${limit.name }</label></li>
											</ul>
										</td>
									</c:if>
									<c:if test="${limit.column==3}">
										<td style="width: 200px;">
											<ul class="rights">
												<li><input name="biaoqian" type="checkbox" value="${limit.id}" ${limit.hasright?"checked":""} />
														<label for="name">${limit.name }</label></li>
											</ul>
										</td>
										</tr>
									</c:if>
								</c:forEach>
							</table>
							<div class="divnull">&nbsp;&nbsp;</div>
							<div class="divnull">&nbsp;&nbsp;</div>
							<div class="control-group">
								<label class="control-label span2" for="login-btn"></label>
								<input type="submit" id="recipe-btn" value="确  定" class="btn btn-info span2">
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
	
</section>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script>

$(document).ready(function () {

});	
</script>
<jsp:include page="../includes/footer.jsp" />