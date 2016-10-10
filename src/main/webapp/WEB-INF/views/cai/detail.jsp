<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="vu" uri="http://com.dfyy.util/ViewUtils"%>

<c:set var="pageTitle" value="回答及评论" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<h3 style="color: #505050;">问题</h3>
	<p>${cai.content}</p>
	<h3 style="color: #505050;">答案</h3>
	<p>${cai.answer}</p>
</section>

<c:if test="${cai.responses != null}">
	<section class="well shadow">
		<fieldset>
			<legend>猜农资回答 
			<c:if test="${cai.lottery1 == false}">
				<button class="btn btn-info pull-right" type="button" onclick="lottery1(${cai.id})">抽奖</button>
			</c:if>
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>

			<table id="objList" class="table  table-bordered table-hover " style="margin: 0;">
				<tbody>
					<c:forEach items="${cai.responses}" var="response">
						<tr class="${response.win ? "lottery" : ""}">
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
											<button class="btn btn-small btn-danger" type="button" onclick="deleteAnswer(${response.id})">删除</button>

											<c:if test="${response.win == true}">
												<c:choose>
													<c:when test="${response.winsend==true}">
														<span style="color:#555555;">已发送中奖消息</span>
													</c:when>
													<c:when test="${response.winsend==false}">
														<button class="btn btn-small btn-success" type="button" onclick="sendMessage(1,${response.id})">发送中奖消息</button>
													</c:when>
												</c:choose>
											</c:if>
									</div>
									</div>
									
									<c:if test="${cai.lottery1 == false}">
									<div style="display: inline-block;">
										<input type="checkbox" name="lottery1" value="${response.id}" />
									</div>
									</c:if>
									
								</div> 
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</fieldset>
	</section>
</c:if>

<c:if test="${cai.comments != null}">
	<section class="well shadow">
		<fieldset>
			<legend>猜农资评论
			<c:if test="${cai.lottery2 == false}">
				<button class="btn btn-info pull-right" type="button" onclick="lottery2(${cai.id})">抽奖</button>
			</c:if> 
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>

			<table id="objList" class="table  table-bordered table-hover" style="margin: 0;">
				<tbody>
					<c:forEach items="${cai.comments}" var="response">
						<tr class="${response.win ? "lottery" : ""}">
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
											<button class="btn btn-small btn-danger" type="button" onclick="deleteComment(${response.id})">删除</button>
											
											<c:if test="${response.win == true}">
												<c:choose>
													<c:when test="${response.winsend==true}">
														<span style="color:#555555;">已发送中奖消息</span>
													</c:when>
													<c:when test="${response.winsend==false}">
														<button class="btn btn-small btn-success" type="button" onclick="sendMessage(2,${response.id})">发送中奖消息</button>
													</c:when>
												</c:choose>
											</c:if>
										</div>
									</div>
									
									<c:if test="${cai.lottery2 == false}">
									<div style="display: inline-block;">
										<input type="checkbox" name="lottery2" value="${response.id}" />
									</div>
									</c:if>
								</div> 
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</fieldset>
	</section>
</c:if>

<div id="messageModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">发送消息</h4>
	</div>
	<div class="modal-body">
		<textarea id="contendTxt" style="width: 90%; height: 80px;">恭喜您中奖，种好地客服会联系您</textarea>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" id="btnSendMessage">发送</button>
	</div>
</div>

<script>
function deleteAnswer(id) {
	bootbox.confirm("确定删除该答案吗？", "取消", "确定", function (isOk) {
		if (!isOk) {
			return;
		}

		$.post('<c:url value="deleteAnswer" />', {
			id : id
		}).done(function (data) {
			window.location.href = window.location.href;
		}).fail(function () {});
	});
}

function deleteComment(id) {
	bootbox.confirm("确定删除该评论吗？", "取消", "确定", function (isOk) {
		if (!isOk) {
			return;
		}
		$.post('<c:url value="deleteComment" />', {
			id : id
		}).done(function (data) {
			window.location.href = window.location.href;
		}).fail(function () {});
	});
}


function lottery1(id) {
	
	var ids =[];
	$('input[name="lottery1"]:checked').each(function() {
		ids.push(this.value);
	});
	
	if(ids.length == 0){
		bootbox.alert("请勾选回答者");
		return false;
	}
	
	bootbox.confirm("确定对选中回答者进行抽奖？", "取消", "确定", function (isOk) {
		if (!isOk) {
			return false;
		}
		
		$.post('<c:url value="lottery1" />', {
			id : id,
			ids:ids.join()
		}).done(function (data) {
			if(data.result){
				window.location.href = window.location.href;
			}else{
				bootbox.alert(data.message);
			}
		}).fail(function () {});
	});
}


function lottery2(id) {
	
	var ids =[];
	$('input[name="lottery2"]:checked').each(function() {
		ids.push(this.value);
	});
	
	if(ids.length == 0){
		bootbox.alert("请勾选回答者");
		return false;
	}
	
	bootbox.confirm("确定对选中回答者进行抽奖？", "取消", "确定", function (isOk) {
		if (!isOk) {
			return false;
		}
		
		$.post('<c:url value="lottery2" />', {
			id : id,
			ids:ids.join()
		}).done(function (data) {
			if(data.result){
				window.location.href = window.location.href;
			}else{
				bootbox.alert(data.message);
			}
		}).fail(function () {});
	});
}


function sendMessage(type,id){
	$('#btnSendMessage').unbind('click');
	$("#btnSendMessage").click(function(){
		$.post('<c:url value="sendmessage" />', {
			type:type,
			id:id,
			message : $("#contendTxt").val()
		}).done(function(data) {
			if(data.result){
				window.location.href = window.location.href;
			}else{
				bootbox.alert(data.message);
			}
		}).fail(function() {
		}); 	
	});
	$('#messageModal').modal({});
}

</script>
<jsp:include page="../includes/footer.jsp" />
