<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="区域管理" scope="request" />
<jsp:include page="../includes/header.jsp" />
<c:url var="treecss" value="/assets/bootstrap/css/treeview.css" />
<link rel="stylesheet" type="text/css" href="${treecss}">
<c:url var="btcss" value="/assets/css/bt.css" />
<link href="${btcss}" rel="stylesheet">
<section class="well shadow">
<fieldset>
	<legend>
		区域关系
	</legend>
	<div class="divnull">&nbsp;&nbsp;</div>
	<div class="row">
		<div class="col-sm-6">
			<div id="treediv" class="treeview">
			</div>
		</div>
		<div class="col-sm-4">
			
			<c:url var="addUrl" value="addone" />	
			<form id="areaform" action="${addUrl}" method="post">
				<fieldset>
					选中的区域：
					<div class="input-append">
						<input id="parentarea" name="parentarea" path="parentarea" cssClass="input-xlarge" style="line-height:28px;" />
						<button id="deleteBtn" class="btn btn-info" type="button" onclick="deleteOne()">删除</button>
					</div>
					添加新的区域：
					<div class="input-append">
						<input id="area" name="area" path="area" cssClass="input-xlarge" style="line-height:28px;" />
						<input id="saveform" type="submit" class="btn btn-info" value="保存" />
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</fieldset>
</section>
<c:url var="jsurl14" value="/assets/bootstrap/js/bootstrap-treeview.js" />
<script src="${jsurl14}"></script>
<script>

	$(document).ready(function() {
		
		$.ajax({
			type : "GET",
			url : "<c:url value='allareas'/>",
			cache : false,
			success : function(data, textStatus, jqXHR) {
				if(data==null){
					return;
				}
				$('#treediv').treeview({
					  color: "#428bca",
			          data: data,
			          onNodeSelected: function(event, node) {
				            /* $('#event_output').prepend('<p>You clicked ' + node.text + '</p>'); */
				            $('#parentarea').val(node.text);
				      }
			        });
			},
			error : function(xhr, textStatus, errorThrown) {
				bootbox.alert(xhr.responseText);
			}
		});				
	
	});
	

	function deleteOne() {
		var name = $('#parentarea').val();
		bootbox.confirm("确定要删除吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
	
			$.post('<c:url value="delete" />', {
				text : name
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
</script>


<jsp:include page="../includes/footer.jsp" />