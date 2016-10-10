<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="充值" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			充值记录
			<a id="addone-a" class="btn btn-info pull-right" href="#addOne-modal" data-toggle="modal">
				<i class="icon-plus icon-white"></i> 充值
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
					<th align="center">昵称</th>
					<th align="center" >手机</th>
					<th align="center">优惠币</th>
					<th align="center">时间</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty prepaidLogs}">
					<tr>
						<td colspan="4">空</td>
					</tr>

				</c:if>
				<c:forEach items="${prepaidLogs}" var="prepaidlog">
					<tr class="${cssClass}">
						<td>
						<c:out value="${prepaidlog.user.alias}" />
						</td>
						<td>
						<c:out value="${prepaidlog.user.phone}" />
						</td>
						<td>
						<c:out value="${prepaidlog.count}" />
						</td>
						<td>
						<c:out value="${prepaidlog.time}" />	
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<div class="modal hide fade" id="addOne-modal" data-backdrop="static" data-keyboard="false">
	<c:url var="prepaidUrl" value="addone" />
	<form id="prepaid-form" class="form-horizontal" action="${prepaidUrl }" method="post" enctype="multipart/form-data">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">优惠币充值</h3>
		</div>
		<br>
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="phone">手    机</label>
				<div class="controls">
					<input type="text" class="span3" name="phone" id="phone" placeholder="输入充值用户的手机号码" 
					style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="11"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="count">金    额</label>
				<div class="controls">
					<input type="text" class="span3" name="count" id="count" placeholder="输入优惠币的个数" 
					style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="10"/>
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
		
		page();		
		addCateFormValidate();
	
	});
	function addCateFormValidate() {
		$("#prepaid-form").validate(
				{
					debug : true,
					rules : {
						phone : {
							required : true
						},
						count : {
							required : true
						}
					},

					messages : {
						phone : {
							required : "必填"
						},
						count : {
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
						var phone = $("#phone").val();
						checkphone(form,phone,"phone");
					}
				});
	}
	
	function checkphone(form,phone,field){

		$.post('<c:url value="checkphone" />', {
			phone : phone,
			fieldName : field
		}).done(function(data) {
			if(data!=null && data!=""){
				var element = $("#"+data.field);
				var childa=$('<label for="'+data.field+'"></label>');
				childa.addClass('invalid');
				childa.html(data.error);
				element.nextAll(".help-inline").empty();
				element.nextAll(".help-inline").append(childa);
			}
			else{
				form.submit();	
			}
			
		}).fail(function() {
		});

		return false;
	}
</script>


<jsp:include page="../includes/footer.jsp" />