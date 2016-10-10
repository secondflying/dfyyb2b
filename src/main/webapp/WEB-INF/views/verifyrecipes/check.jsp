<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="审核配方" scope="request" />
<jsp:include page="../includes/header.jsp" />


<section class="well shadow">
	<c:url var="addUrl" value="/nzd/index/edit" />	
	<form id="reicpe" action="${addUrl}" method="post">
		<fieldset>
			<legend>配方信息				
				<c:url var="verifyUrl" value="verify?id=${recipe.id}" />
				<a class="btn btn-success pull-right" href="${verifyUrl}" data-toggle="modal">
					通过
				</a>
				<label class="pull-right" style="width:10px;">  </label>
				<a class="btn btn-danger pull-right" href="javascript:notverify(${recipe.id})">
					拒绝
				</a>
				<c:url var="backUrl" value="index" />
				<label class="pull-right" style="width:10px;">  </label>
				<a class="btn btn-info pull-right" href="${backUrl}" data-toggle="modal">
					返回
				</a>
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label"><c:out value="标题：${recipe.title}"/></label>
			</div>
			<div class="control-group">
				<label class="control-label" style="width:400px"><c:out value="描述：${recipe.description}"/></label>
			</div>
			<div class="control-group">
				<label class="control-label"><c:out value="原价：${recipe.price}"/></label>
			</div>
			<div class="control-group">
				<label class="control-label"><c:out value="现价：${recipe.newprice}"/></label>
			</div>
			<div class="control-group">
				<label class="control-label"><c:out value="主治病害：${recipe.disease.name}"/></label>
			</div>
			<br />
			<br />
			<div id="attachmentsdiv">
				<c:set value="0" var="sum" />
				<c:forEach items="${recipe.attachments}" var="attachment">
					<div id="panel${sum}" style="width:150px;height:150px;display:inline-block;position: relative;margin: 0px 5px;border: solid 1px #ccc;">
						<img class="image" src="${imageUrl}/${attachment.url}" />
						<a class="imageClose" href="javascript:deleteImagePanel(${sum})"></a>
						<input type="hidden" path="attachments[${sum}].id" name="attachments[${sum}].id" id="attachments[${sum}].id" value="${attachment.id}" />
						<input type="hidden" path="attachments[${sum}].url" name="attachments[${sum}].url" id="attachments[${sum}].url" value="${attachment.url}" />
					</div>
					<c:set value="${sum + 1}" var="sum" />
				</c:forEach>
			</div>
			
		</fieldset>
	</form>
</section>

<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>

<script>
function notverify(id) {
	bootbox.confirm("确定要拒绝吗？", "取消", "确定", function(isOk) {
		if (!isOk) {
			return;
		}

		$.post('<c:url value="notverify" />', {
			id : id
		}).done(function(data) {
			window.location.href ='<c:url value="index" />'; 
		}).fail(function() {
		});
	});
}
</script>
<jsp:include page="../includes/footer.jsp" />