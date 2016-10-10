<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:set var="pageTitle" value="管理员账户" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			管理员列表
			<a id="addone" class="btn btn-info pull-right" href="#addOne-modal" data-toggle="modal">
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
			<thead class="info">
				<tr>
					<th style="width: 100px;" align="center">用户名</th>
					<th align="center">功能权限</th>
					<th align="center">操作区域</th>
					<th style="width: 150px;" align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty admins}">
					<tr>
						<td colspan="4">空</td>
					</tr>

				</c:if>
				<c:forEach items="${admins}" var="admin">
					<tr class="${cssClass}">
						<td><c:out value="${admin.name}" /></td>
						<td><c:if test="${empty admin.functions}">
								无任何功能权限
							</c:if> <c:forEach items="${admin.functions}" var="function">
								<c:out value="${function.name}  " />
							</c:forEach></td>
						<td><c:if test="${empty admin.zones}">
								无任何操作区域
							</c:if> <c:forEach items="${admin.zones}" var="zone">
								<c:out value="${zone.name}  " />
							</c:forEach></td>
						<td><c:url var="eUrl" value="limit?name=${admin.name}" /> <a id="editone"
								class="btn btn-mini btn-warning" href="${eUrl}"> 功能授权 </a> <c:url var="eUrl" value="zone?name=${admin.name}" />
							<a id="editone" class="btn btn-mini btn-warning" href="${eUrl}"> 区域授权 </a> <a id="resetpass"
								class="btn btn-mini btn-info" href="javascript:resetpass(${admin.id })"> 重置密码 </a>
							<button class="btn btn-mini btn-danger" type="button" onclick="deleteOne(${admin.id})">删除</button></td>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>
<div class="modal hide fade" id="addOne-modal" data-backdrop="static" data-keyboard="false">
	<c:url var="addadminUrl" value="addone" />
	<form id="addadmin-form" class="form-horizontal" action="${addadminUrl }" method="post" enctype="multipart/form-data">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">创建管理员账户</h3>
		</div>
		<br>
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="name">用户名</label>
				<div class="controls">
					<input type="text" class="span3" name="name" id="name" placeholder="输入用户名" style="IME-MODE: disabled;"
						onkeyup="value=value.replace(/[\W]/g,'') "
						onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" maxlength="30" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="password">密 码</label>
				<div class="controls">
					<input type="password" class="span3" name="password" id="password" placeholder="请设置账户密码"
						style="IME-MODE: disabled;" onkeyup="value=value.replace(/[\W]/g,'') "
						onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" maxlength="30" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="confirm">确认密码</label>
				<div class="controls">
					<input type="password" class="span3" name="confirm" id="confirm" placeholder="请再次输入账户密码"
						style="IME-MODE: disabled;" onkeyup="value=value.replace(/[\W]/g,'') "
						onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" maxlength="30" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label span2" for="login-btn"></label>
				<input type="submit" id="recipe-btn" value="确  定" class="btn btn-info span3">
			</div>
		</fieldset>
	</form>
</div>

<div class="modal hide fade" id="reset-modal" data-backdrop="static" data-keyboard="false">
	<form id="reset-form" class="form-horizontal" action="" method="post" enctype="multipart/form-data">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">账户密码重置</h3>
			<input id="selid" type="hidden">
		</div>
		<br>
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="old">旧密码</label>
				<div class="controls">
					<input type="password" class="span3" name="old" id="old" placeholder="输入旧密码" style="IME-MODE: disabled;"
						onkeyup="value=value.replace(/[\W]/g,'') "
						onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" maxlength="30" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="newpass">新密码</label>
				<div class="controls">
					<input type="password" class="span3" name="newpass" id="newpass" placeholder="请输入新密码" style="IME-MODE: disabled;"
						onkeyup="value=value.replace(/[\W]/g,'') "
						onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" maxlength="30" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="confirmpass">确认新密码</label>
				<div class="controls">
					<input type="password" class="span3" name="confirmpass" id="confirmpass" placeholder="请再次输入新密码"
						style="IME-MODE: disabled;" onkeyup="value=value.replace(/[\W]/g,'') "
						onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" maxlength="30" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label span2" for="login-btn"></label>
				<input type="submit" id="recipe-btn" value="确  定" class="btn btn-info span3">
			</div>
		</fieldset>
	</form>
</div>
<script>

$(document).ready(function() {	 
    var size = 10;
	var sumcount = parseInt(${sumcount}); 
	if(sumcount ==0){return false}
	
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
    addCateFormValidate();
    addResetFormValidate();
});

function addCateFormValidate() {
	$("#addadmin-form").validate(
			{
				debug : true,
				rules : {
					name : {
						required : true
					},
					password : {
						required : true
					},
					confirm : {
						required : true
					}
				},

				messages : {
					name : {
						required : "必填"
					},
					password : {
						required : "必填"
					},
					confirm : {
						required : "必填"
					}
				},

				errorClass : 'invalid',
				validClass : 'invalid',
				errorPlacement : function(error, element) {
					 element.nextAll(".help-inline").html(error);

				},
				success : function(label) {
					label.html("");
				},
				submitHandler : function(form) {
					var pass = $("#password").val();
					var confirm = $("#confirm").val();
					if(pass!=confirm){
						var element = $("#confirm");
						var childa=$('<label for="confirm"></label>');
						childa.addClass('invalid');
						childa.html("密码确认失败，请重新输入");
						element.nextAll(".help-inline").empty();
						element.nextAll(".help-inline").append(childa);
					}
					else{
						form.submit();
					}
				}
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
function resetpass(id){
	$('#selid').val(id);
	$("#old").val("");
	$("#newpass").val("");
	$("#confirmpass").val("");
	$('#reset-modal').modal('show');
}
function addResetFormValidate() {
	$("#reset-form").validate(
			{
				debug : true,
				rules : {
					old : {
						required : true
					},
					newpass : {
						required : true
					},
					confirmpass : {
						required : true
					}
				},

				messages : {
					old : {
						required : "必填"
					},
					newpass : {
						required : "必填"
					},
					confirmpass : {
						required : "必填"
					}
				},

				errorClass : 'invalid',
				validClass : 'invalid',
				errorPlacement : function(error, element) {
					 element.nextAll(".help-inline").html(error);

				},
				success : function(label) {
					label.html("");
				},
				submitHandler : function(form) {
					var id = $("#selid").val();
					var old = $("#old").val();
					var pass = $("#newpass").val();
					var confirm = $("#confirmpass").val();
					if(pass!=confirm){
						var element = $("#confirmpass");
						var childa=$('<label for="confirm"></label>');
						childa.addClass('invalid');
						childa.html("新密码确认失败，请重新输入");
						element.nextAll(".help-inline").empty();
						element.nextAll(".help-inline").append(childa);
					}
					else{
						$.post('<c:url value="resetpass" />', {
							id : id,
							old:old,
							pass:pass
						}).done(function(data) {
							if(data!="true"){
								var element = $("#old");
								var childa=$('<label for="old"></label>');
								childa.addClass('invalid');
								childa.html("密码错误");
								element.nextAll(".help-inline").empty();
								element.nextAll(".help-inline").append(childa);
							}
							else{
								$('#reset-modal').modal('hide');
								window.setTimeout(popMessage,1000);								
							}
							
						}).fail(function(data) {
							
						});
					}
				}
			});
}

function popMessage(){
	alert("修改成功");
}


</script>


<jsp:include page="../includes/footer.jsp" />