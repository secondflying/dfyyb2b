<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="拉拉呱" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			拉拉呱详情
			<button class="btn btn-danger pull-right" type="button" onclick="convert(${question.id})">转成赶大集</button>
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="row-fluid">
			<div class="span4">
				<fieldset>
					<div class="row" style="margin-left: 10px;">
						<div style="display: inline-block; margin-left: 0px; margin-top: 0px;">
							<img style="width: 100px; height: 100px; vertical-align: bottom;" src="${imageUrl1}/${question.writer.thumbnail}" />
						</div>

						<div style="display: inline-block;">
							<div style="text-align: left;">
								<label class="writer"><c:out value="${question.writer.alias}" /></label>
							</div>
							<div style="text-align: left;">
								<label style="font-size: 10px; display: inline-block;"><c:out value="电话：${question.writer.phone}" /></label>
							</div>
							<div style="text-align: left;">
								<label style="font-size: 10px; display: inline-block;">时间：<fmt:formatDate value='${question.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></label>
							</div>

						</div>
					</div>
					<div style="margin-left: 10px; margin-top: 5px;">
						<c:out value="${question.content}" />
					</div>

					<div id="myCarousel" class="carousel slide" style="width: 800px;">
						<c:if test="${size>0}">
							<div class="carousel-inner">

								<c:set value="0" var="sum" />
								<c:forEach items="${question.attachments}" var="attachment">
									<c:set var="cssClass" value="item" />
									<c:if test="${sum==0}">
										<c:set var="cssClass" value="active item" />
									</c:if>
									<div class="${cssClass}">
										<img src="${imageUrl}/${attachment.url}" alt="" style="width: auto; height: auto;" />
									</div>
									<c:set value="${sum + 1}" var="sum" />
								</c:forEach>

							</div>
							<a class="carousel-control left" href="#myCarousel" data-slide="prev">‹</a>
							<a class="carousel-control right" href="#myCarousel" data-slide="next">›</a>
						</c:if>
					</div>

				</fieldset>
			</div>
		</div>

	</fieldset>
</section>
<c:if test="${question.responses != null}">
	<section class="well shadow">
		<fieldset>
			<legend> 评论 </legend>
			<div class="divnull">&nbsp;&nbsp;</div>

			<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
				<tbody>
					<c:forEach items="${question.responses}" var="response">
						<tr class="${cssClass}">
							<td>
								<div class="row">
									<div style="display: inline-block; margin-left: 0px; margin-top: 0px;">
										<img style="width: 50px; height: 50px; vertical-align: bottom;"
											src="${imageUrl1}/${response.writer.thumbnail}" />
									</div>

									<div style="display: inline-block;">
										<div style="width: 800px; text-align: left;">
											<c:out value="${response.content1}" />
										</div>
										<div style="text-align: left;">
											<label class="writer"><c:out value="${response.writer.alias}" /></label> 
											<label style="font-size: 10px; display: inline-block;"><c:out value="时间：${response.time}" /></label>
											&nbsp;&nbsp;
											<label style="font-size: 10px; display: inline-block;"><c:out value="电话：${response.writer.phone}" /></label>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${response.id})">删除</button>
										</div>

									</div>
								</div>
								
								<c:if test="${not empty response.comments}">
									<div style="padding: 10px;border:1px solid #cccccc;">
										<div style="font-weight: bold;text-align: left">评论</div>
										<c:forEach items="${response.comments}" var="comment">
											<div>
												<div style="display: inline-block; margin-left: 0px; margin-top: 0px;">
													<img style="width: 50px; height: 50px; vertical-align: bottom;"
														src="${imageUrl1}/${comment.writer.thumbnail}" />
												</div>
												<div style="display: inline-block;">
													<div style="width: 600px; text-align: left;">
														<c:out value="${comment.content1}" />
													</div>
													<div style="text-align: left;">
														<label class="writer"><c:out value="${comment.writer.alias}" /></label> <label
															style="font-size: 10px; display: inline-block;">时间：<fmt:formatDate value='${comment.time}'
																type='date' pattern='yyyy-MM-dd HH:mm:ss' /></label> &nbsp;&nbsp; <label
															style="font-size: 10px; display: inline-block;"><c:out value="电话：${comment.writer.phone}" /></label>
														&nbsp;&nbsp;&nbsp;
														<button class="btn btn-mini btn-danger" type="button" onclick="deleteComment(${comment.id})">删除</button>
													</div>
												</div>
											</div>
										</c:forEach>

									</div>
								</c:if>
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
		bootbox.confirm("确定要删除吗？", "取消", "确定", function(isOk) {
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
	
	
	function deleteComment(id) {
		bootbox.confirm("确定要删除二级评论吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
	
			$.post('<c:url value="commentdelete" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			}); 
		});
	}
	
	
	function convert(id) {
		bootbox.confirm("确定转成赶大集吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
	
			$.post('<c:url value="convert" />', {
				id : id
			}).done(function(data) {
				window.location.href = '<c:url value="index" />';
			}).fail(function() {
			}); 
		});
	}
	
	
</script>
<jsp:include page="../includes/footer.jsp" />