<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="用户反馈" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend> 用户反馈列表 </legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="alert alert-success" id="successMessage" style="display:none;">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<strong>发送成功</strong>
		</div>
		<c:if test="${read != null}">
			<input id="read" type="hidden" value='${read}' />
		</c:if>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">用户</th>
					<th align="center">电话</th>
					<th align="center">内容</th>
					<th align="center">时间</th>
					<th align="center">操作</th>
					<th align="center">回复</th>

				</tr>
			</thead>
			<tbody>
				<c:if test="${empty feedback}">
					<tr>
						<td colspan="6">空</td>
					</tr>

				</c:if>
				<c:forEach items="${feedback}" var="feedback">
					<tr class="${cssClass}">
						<td style="width: 120px;"><c:out value="${feedback.user.alias}" /></td>
						<td style="width: 120px;"><c:out value="${feedback.user.phone}" /></td>
						<td style="height: 50px; text-align: left;">
							<div class="">
								<c:out value="${feedback.content}" />
							</div>
						</td>
						<td style="width: 80px;"><fmt:formatDate value='${feedback.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td style="width: 80px;">
							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${feedback.id})">删除</button>
						</td>
						<td style="width: 80px;">
							<button id="addone" class="btn btn-mini btn-info" onclick="sendMessage('${feedback.user.phone}')">发送</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>
<div id="messageModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">发送消息</h4>
	</div>
	<div class="modal-body">
		<textarea id="contendTxt" style="width: 90%; height: 80px;"></textarea>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" id="btnSendMessage">发送</button>
	</div>
</div>
<script>

	$(document).ready(function() {
		
		var $pager = $('<div class="page"></div>');  //分页div
	    $pager.insertAfter($('table'));
	    
		var totalPage = parseInt(${totalPage}); 
	    var currentPage = getUrlParam("page");
	    currentPage = currentPage ? parseInt(currentPage) + 1 : 1;
	    var options = {
	            currentPage: currentPage,
	            totalPages: totalPage,
	            size:'small',
	            alignment:'center',
	            itemTexts: function (type, page, current) {
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
	                    return ""+page;
	                }
	            },
	            onPageClicked: function (event, originalEvent, type, page) { 
	            	var page = page-1; 
	        		window.location.href = '<c:url value="index" />?page=' + page;
	            }
	    };

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
	
	function sendMessage(phone){
		$('#btnSendMessage').unbind('click');
		$("#btnSendMessage").click(function(){
			$.post('<c:url value="/manager/usermanager/sendmessage" />', {
				phone:phone,
				message : $("#contendTxt").val()
			}).done(function(data) {
				$('#messageModal').modal('hide');
				$("#successMessage").show().delay(2000).slideUp("slow");
			}).fail(function() {
			}); 	
		});
		$('#messageModal').modal({});
	}
</script>


<jsp:include page="../includes/footer.jsp" />