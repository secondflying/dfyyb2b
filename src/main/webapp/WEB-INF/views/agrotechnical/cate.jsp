<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="农业专业知识管理" scope="request" />
<jsp:include page="../includes/header.jsp" />


<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="index" />
			<li class=""><a id="infoLink" href="${infoUrl}">田间地头</a></li>
			<c:url var="infoUrl2" value="cate" />
			<li class="active"><a id="infoUrl2" href="${infoUrl}">知识分类</a></li>
		</ul>
	</div>
</div>

<section class="well shadow">
	<fieldset>
		<legend>
			农业知识分类
			<a id="addone" class="btn btn-info pull-right" onclick="addOne()">
				<i class="icon-plus icon-white"></i> 新增
			</a>
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
					<th align="center">名称</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty cates}">
					<tr>
						<td colspan="2">空</td>
					</tr>

				</c:if>
				<c:forEach items="${cates}" var="cate">
					<tr class="${cssClass}">
						<td style=""><c:out value="${cate.name}" /></td>
						<td style="width: 120px;">
							<button class="btn btn-small btn-warning" type="button" onclick="editOne(${cate.id},'${cate.name}')">编辑</button>
							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${cate.id})">删除</button>
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
		<h4 id="myModalLabel">编辑</h4>
	</div>
	<div class="modal-body">
		<input type="text" id="catename" style="width: 90%;" />
		<input type="hidden" id="cateid" />
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" onclick="save()">保存</button>
	</div>
</div>
<script>
	function addOne() {
		$("#catename").val('');
		$("#cateid").val('');
		$('#myModal').modal({});
	}

	function editOne(id,name) {
		$("#cateid").val(id);
		$("#catename").val(name);
		$('#myModal').modal({});
	}
	
	function save(){
		$.post('<c:url value="catesave" />', {
			cid:$("#cateid").val(),
			cname : $("#catename").val()
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
	
			$.post('<c:url value="catedelete" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
</script>


<jsp:include page="../includes/footer.jsp" />