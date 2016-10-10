<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="vu" uri="http://com.dfyy.util/ViewUtils"%>

<c:set var="pageTitle" value="评论管理" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">

	<h3 style="color: #505050;">${agrotechnical.title}</h3>
	<p style="color: #888888;">
		<small><fmt:formatDate value='${agrotechnical.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></small>
	</p>
	<div class="mcontent">${agrotechnical.content1}</div>
</section>

<c:if test="${agrotechnical.responses != null}">
	<section class="well shadow">
		<fieldset>
			<legend>回复 </legend>
			<div class="divnull">&nbsp;&nbsp;</div>

			<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
				<tbody>
					<c:forEach items="${agrotechnical.responses}" var="response">
						<tr class="${cssClass}">
							<td>
								<div class="row">
									<div style="display: inline-block; margin-left: 0px; margin-top: 0px;">
										<img style="width: 50px; height: 50px; vertical-align: bottom;"
											src="${imageUrl1}/${response.writer.thumbnail}" />
									</div>

									<div style="display: inline-block;">
										<div style="width: 800px; text-align: left;">
											<c:out value="${response.content}" />
										</div>
										<div style="text-align: left;">
											<label class="writer"><c:out value="${response.writer.alias}" /></label> <label
												style="font-size: 10px; display: inline-block;">时间：<fmt:formatDate value='${response.time}'
													type='date' pattern='yyyy-MM-dd HH:mm:ss' /></label> &nbsp;&nbsp; <label
												style="font-size: 10px; display: inline-block;"><c:out value="电话：${response.writer.phone}" /></label>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${response.id})">删除</button>
										</div>

									</div>
								</div> 
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</fieldset>
	</section>
</c:if>

<script>

	function deleteOne(id) {
		bootbox.confirm("确定删除该评论吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
	
			$.post('<c:url value="resdelete" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			}); 
		});
	}
	
</script>
<jsp:include page="../includes/footer.jsp" />



