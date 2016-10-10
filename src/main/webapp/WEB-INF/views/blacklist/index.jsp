<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="黑名单" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			黑名单列表
			<div class="input-append pull-right">
				<input id="contendTxt" cssClass="input-xlarge" style="line-height: 24px;" placeholder="用户手机号" />
				<button id="locationBtn" class="btn btn-info" type="button" onclick="send()">加入黑名单</button>
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
					<th align="center">手机号</th>
					<th align="center">昵称</th>
					<th align="center">加入时间</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty blacklist}">
					<tr>
						<td colspan="4">空</td>
					</tr>
				</c:if>
				<c:forEach items="${blacklist}" var="bl">
					<tr class="${cssClass}">
						<td style="width: 150px;"><c:out value="${bl.user.phone}" /></td>
						<td style="width: 150px;"><c:out value="${bl.user.alias}" /></td>
						<td style="width: 150px;"><fmt:formatDate value='${bl.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td style="width: 80px;">
							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${bl.id})">删除</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

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
		bootbox.confirm("确定将该用户加入黑名单？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
	
			$.post('<c:url value="send" />', {
				phone : $("#contendTxt").val()
			}).done(function(data) {
				if(data.status == "ok"){
				window.location.href = window.location.href;
				}else{
					bootbox.alert(data.message);	
				}
			}).fail(function() {
			}); 
		});
	}
	
	function deleteOne(id) {
		bootbox.confirm("确定要解除黑名单吗？", "取消", "确定", function(isOk) {
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