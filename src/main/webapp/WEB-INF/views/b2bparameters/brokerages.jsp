<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="佣金系数管理" scope="request" />
<jsp:include page="../includes/mheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="commoditytypeUrl" value="commoditytype" />
			<li class=""><a href="${commoditytypeUrl}">商品分类</a></li>
			<c:url var="tagUrl2" value="tags" />
			<li class=""><a href="${tagUrl2}">商品标签</a></li>
			<c:url var="unitUrl2" value="units" />
			<li class=""><a href="${unitUrl2}">商品单位</a></li>
			<c:url var="brokerageUrl2" value="brokerages" />
			<li class="active"><a href="${brokerageUrl2}">佣金系数</a></li>
		</ul>
	</div>
</div>
<section class="content-wrap">
	<div class="container">		
		<div class="row">
			<div class="column span8">
				<section class="well">
					<legend>
						平台合伙人佣金设置
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
								<th align="center">大类</th>
								<th align="center">子类</th>
								<th align="center">平台佣金</th>
								<th align="center">合伙人佣金</th>
								<th align="center">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty objects}">
								<tr>
									<td colspan="5">空</td>
								</tr>
							</c:if>
							<c:forEach items="${objects}" var="crop">
								<tr>
									<td><b><c:out value="${crop.name}" /></b></td>
									<td></td>
									<td></td>
									<td></td>
									<td style="">
									</td>
								</tr>
								<c:forEach items="${crop.childs}" var="cc">
									<tr>
										<td></td>
										<td><c:out value="${cc.name}" /></td>
										<td><c:out value="${cc.platform}" /></td>
										<td><c:out value="${cc.partner}" /></td>
										<td style="">
											<a id="editone" class="btn btn-small btn-warning" href="javascript:setone(${cc.id },${cc.platform },${cc.partner },'${cc.name }')">设置</a> 
										</td>
									</tr>
								</c:forEach>
							</c:forEach>
						</tbody>
					</table>
				</section>
			</div>
			<div class="column span4">
				<section class="well">
					<legend>
						业务员佣金范围设置
					</legend>
					<p class="muted">  </p>
					<p class="muted">范围：
						<c:if test="${sage!=null}">
							${sage.min }--${sage.max }
							<a id="editone1" class="btn btn-small btn-success" href="javascript:setone1(${sage.min },${sage.max })">
								设置
							</a>
						</c:if>
						<c:if test="${sage==null}">
							<a id="editone1" class="btn btn-small btn-success" href="javascript:setone1(0,0)">
								设置
							</a>
						</c:if>
					</p>
				</section>
			</div>
		</div>
	</div>
</section>

<div class="modal hide fade" id="editOne-modal" data-backdrop="static" data-keyboard="false">
	<c:url var="editdeptUrl" value="editppbrokerage" />
	<form id="editdept-form" class="form-horizontal" action="${editdeptUrl }" method="post" enctype="multipart/form-data">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="title3"></h3>
		</div>
		<br>
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="platform">平台佣金</label>
				<div class="controls">
					<input type="text" class="span3" name="platform" id="platform" placeholder="平台佣金" 
					onkeyup="clearNoNum(this)" maxlength="20"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="partner">合伙人佣金</label>
				<div class="controls">
					<input type="text" class="span3" name="partner" id="partner" placeholder="合伙人佣金" 
					onkeyup="clearNoNum(this)" maxlength="20"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<input type="hidden" id="cid" name="cid"/>
			<div class="control-group">
				<label class="control-label span2" for="login-btn"></label>
				<input type="submit" id="edit-btn" value="确  定" class="btn btn-info span3">
			</div>
		</fieldset>
	</form>
</div>
<div class="modal hide fade" id="editOne-modal1" data-backdrop="static" data-keyboard="false">
	<c:url var="editdeptUrl1" value="editsalesmanbrokerage" />
	<form id="editdept-form1" class="form-horizontal" action="${editdeptUrl1 }" method="post" enctype="multipart/form-data">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="title4">业务员佣金比例范围</h3>
		</div>
		<br>
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="min">最小佣金比例</label>
				<div class="controls">
					<input type="text" class="span3" name="min" id="min" placeholder="最小值" 
					onkeyup="clearNoNum(this)" maxlength="20"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="partner">最大佣金比例</label>
				<div class="controls">
					<input type="text" class="span3" name="max" id="max" placeholder="最大值" 
					onkeyup="clearNoNum(this)" maxlength="20"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label span2" for="login-btn"></label>
				<input type="submit" id="edit-btn1" value="确  定" class="btn btn-info span3">
			</div>
		</fieldset>
	</form>
</div>
<script>

$(document).ready(function() {
	addeditFormValidate();
	addeditFormValidate1();
});

function setone(id,platform,partner,name) {
	$('#cid').val(id);
	$("#platform").val(platform);
	$("#partner").val(partner);
	$('#title3').html('设置'+name+'佣金');
	$('#editOne-modal').modal('show');
} 
function setone1(min,max) {
	$("#min").val(min);
	$("#max").val(max);
	$('#editOne-modal1').modal('show');
} 
function addeditFormValidate() {
	$("#editdept-form").validate(
			{
				debug : true,
				rules : {
					platform : {
						required : true
					},
					partner : {
						required : true
					}
				},

				messages : {
					platform : {
						required : "必填"
					},
					partner : {
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
					form.submit();
				}
			});
}
function addeditFormValidate1() {
	$("#editdept-form1").validate(
			{
				debug : true,
				rules : {
					min : {
						required : true
					},
					max : {
						required : true
					}
				},

				messages : {
					min : {
						required : "必填"
					},
					max : {
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
					form.submit();
				}
			});
}
function clearNoNum(obj) {
	//先把非数字的都替换掉，除了数字和.
	obj.value = obj.value.replace(/[^\d.]/g, "");
	//必须保证第一个为数字而不是.
	obj.value = obj.value.replace(/^\./g, "");
	//保证只有出现一个.而没有多个.
	obj.value = obj.value.replace(/\.{2,}/g, ".");
	//保证.只出现一次，而不能出现两次以上
	obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
}
</script>


<jsp:include page="../includes/footer.jsp" />