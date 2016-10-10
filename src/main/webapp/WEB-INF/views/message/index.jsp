<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="消息浏览" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			历史消息浏览
			<div class="input-append pull-right">
				<button id="locationBtn" class="btn btn-info" type="button" onclick="send()">发送消息</button>
			</div>
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<c:if test="${success != null}">
			<div class="alert alert-success" id="successMessage">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				<strong><c:out value="${success}" /></strong>
			</div>
			<script>
				$("#successMessage").delay(2000).slideUp("slow");
			</script>
		</c:if>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">内容</th>
					<th align="center">时间</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty messages}">
					<tr>
						<td colspan="3">空</td>
					</tr>
				</c:if>
				<c:forEach items="${messages}" var="message">
					<tr class="${cssClass}">
						<td style="text-align: left;"><c:out value="${message.content}" /></td>
						<td style="width: 150px;"><fmt:formatDate value='${message.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td style="width: 80px;">
							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${message.id})">删除</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">群发消息</h4>
	</div>
	<div class="modal-body">
		<textarea id="contendTxt" style="width: 90%; height: 80px;"></textarea>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" id="btnSend">发送</button>
	</div>
</div>

<script>
	$(document).ready(function() {
	    var size = 20;
		var sumcount = parseInt(${sumcount}); 
		if(sumcount == 0){
			return false;
		}
		
	    var numPages = Math.ceil(sumcount/size);
	    var currentPage = getUrlParam("page");
	    currentPage = currentPage ? parseInt(currentPage) + 1 : 1;
	    var options = {
	            currentPage: currentPage,
	            totalPages: numPages,
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
	        		window.location.href = '<c:url value="index" />?page=' + page + "&size=" + size;
	            }
	    };
	    var $pager = $('<div class="page"></div>');  
	    $pager.insertAfter($('table'));
	    $pager.bootstrapPaginator(options);
	});
	
	function send(){
		$("#contendTxt").val('');
		$('#myModal').modal({});
		
		
		$('#btnSend').unbind('click');
		$("#btnSend").click(function() {
			if($(this).hasClass("disabled")){
				return;
			}else{
				$(this).addClass("disabled");
				$(this).prop("disabled",true);
				$(this).html('发送中...');
				sendmsg();
			}
		});
	} 
	
	function sendmsg(){
		$.post('<c:url value="send" />', {
			content : $("#contendTxt").val()
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		}); 
	}
	
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
	
</script>


<jsp:include page="../includes/footer.jsp" />