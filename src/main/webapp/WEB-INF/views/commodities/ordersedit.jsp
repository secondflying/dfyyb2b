<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="积分订单管理" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			订单信息	
			<c:if test="${pointOrder.status==0}">
				<a id="addone-a" class="btn btn-danger pull-right" href="#addOne-modal" data-toggle="modal">
					<i class="icon-plus icon-white"></i> 发货
				</a>
			</c:if>			
			<c:url var="backUrl" value="orders?page=${page}&size=${size}" />
			<label class="pull-right" style="width:10px;">  </label>
			<a class="btn btn-info pull-right" href="${backUrl}" data-toggle="modal">
				返回
			</a>		
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="row-fluid">
			<div class="span4">
				<fieldset>
					<label class="control-label"><c:out value="时间：${pointOrder.time}"/></label>
					
					<c:choose>  
					    <c:when test="${pointOrder.status==0}"><label class="control-label">状态：待出库</label></c:when>  
					    <c:when test="${pointOrder.status==1}"><label class="control-label">状态：已发货</label></c:when>
					    <c:when test="${pointOrder.status==2}"><label class="control-label">状态：已收货</label></c:when>  
					</c:choose> 
				</fieldset>
			</div>
		</div>
		
	</fieldset>
</section>
<section class="well shadow">
	<fieldset>
		<legend>
			商品信息	
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="row-fluid">
			<div class="span7">
				<fieldset>
					<label class="control-label"><c:out value="名  称：${pointOrder.commodity.name}"/></label>
					<label class="control-label"><c:out value="积  分：${pointOrder.commodity.point}"/></label>
					<label class="control-label"><c:out value="描  述：${pointOrder.commodity.description}"/></label>
				</fieldset>
			</div>
			<div>
				<c:url var="thumbnailUrl" value="${imageUrl}/${pointOrder.commodity.image}" />
				<img src="${thumbnailUrl}" style="width:100px;" id="thumbnail" />
			</div>
		</div>
	</fieldset>
</section>

<section class="well shadow">
	<fieldset>
		<legend>
			购买用户			
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="row-fluid">
			<div class="span4">
				<fieldset>
					<label class="control-label"><c:out value="别  名：${pointOrder.user.alias}"/></label>
					<label class="control-label"><c:out value="电  话：${pointOrder.user.phone}"/></label>
					<label class="control-label"><c:out value="级  别：${pointOrder.user.levelID}"/></label>
				</fieldset>
			</div>
		</div>
		
	</fieldset>
</section>

<section class="well shadow">
	<fieldset>
		<legend>
			收货地址			
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="row-fluid">
			<div class="span4">
				<fieldset>
					<label class="control-label"><c:out value="姓  名：${pointOrder.contact.name}"/></label>
					<label class="control-label"><c:out value="电  话：${pointOrder.contact.phone}"/></label>
					<label class="control-label"><c:out value="地  址：${pointOrder.contact.address}"/></label>
					<label class="control-label"><c:out value="邮  编：${pointOrder.contact.postnumber}"/></label>
				</fieldset>
			</div>
		</div>
		
	</fieldset>
</section>	

<c:if test="${pointOrder.express!=null}">
	<section class="well shadow">
		<fieldset>
			<legend>
				运单信息		
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="row-fluid">
				<div class="span4">
					<fieldset>
						<label class="control-label"><c:out value="快递公司：${pointOrder.express.expname}"/></label>
						<label class="control-label"><c:out value="运单编号：${pointOrder.express.code}"/></label>
					</fieldset>
				</div>
			</div>
			
		</fieldset>
	</section>
</c:if>	

<div class="modal hide fade" id="addOne-modal" data-backdrop="static" data-keyboard="false">
	<c:url var="postCommodityUrl" value="orderpost?page=${page}&size=${size}" />
	<form id="express-form" class="form-horizontal" action="${postCommodityUrl }" method="post" enctype="multipart/form-data">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">发货快递信息</h3>
		</div>
		<br>
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="expname">快递公司：</label>
				<div class="controls">
					<input type="text" class="span3" name="expname" id="expname" placeholder="输入快递公司名称" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="code">运单编号：</label>
				<div class="controls">
					<input type="text" class="span3" name="code" id="code" placeholder="输入运单编号" />
					<span class="help-inline"></span>
				</div>
			</div>
			<input type="hidden" name="poid" id="poid" value="${pointOrder.id}" />
			<div class="control-group">
				<label class="control-label span2" for="login-btn"></label>
				<input type="submit" id="recipe-btn" value="确  定" class="btn btn-info span3">
			</div>
		</fieldset>
	</form>
</div>

<script>
	

$(document).ready(function() {
	
	addCateFormValidate();

});
function addCateFormValidate() {
	$("#prepaid-form").validate(
			{
				debug : true,
				rules : {
					expname : {
						required : true
					},
					code : {
						required : true
					}
				},

				messages : {
					expname : {
						required : "必填"
					},
					code : {
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
	
</script>
<jsp:include page="../includes/footer.jsp" />