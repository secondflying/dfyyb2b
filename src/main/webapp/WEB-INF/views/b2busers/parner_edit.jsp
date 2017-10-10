<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="合伙人信息" scope="request" />
<jsp:include page="../includes/mheader.jsp" />
<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="partners" />
			<li class="active"><a href="${infoUrl}">合伙人</a></li>
			<c:url var="dealerUrl" value="dealers" />
			<li class=""><a href="${dealerUrl}">经销商</a></li>
			<c:url var="manuUrl" value="manufacturers" />
			<li class=""><a href="${manuUrl}">厂家</a></li>
			<c:url var="saleUrl" value="salesmans" />
			<li class=""><a href="${saleUrl}">业务员</a></li>
			<c:url var="storeUrl" value="stores" />
			<li class=""><a href="${storeUrl}">农资店</a></li>
			<c:url var="infoUrl2" value="informal" />
			<li class=""><a href="${infoUrl2}">待审核用户</a></li>
		</ul>
	</div>
</div>
<section class="content-wrap">
<c:url var="editUrl" value="edit" />
<form id="userform" action="${editUrl}" method="post">
		<fieldset>
			<legend>
				用户信息
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存并提交" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="alias">名称</label>
				<div class="controls">
					<input path="alias" name='alias' id="alias"  value="${user.alias }" class="input-xxlarge" placeholder="输入名称" required />
					<span class="help-inline"></span>
					<input path="id" name='id' id="id" type="hidden" value="${user.id }" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="address">地址</label>
				<div class="controls">
					<input path="address" name='address' id="address"  value="${user.address }" class="input-xxlarge" placeholder="输入地址" required/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="zipcode">邮编</label>
				<div class="controls">
					<input path="zipcode" name='zipcode' id="zipcode" value="${user.zipcode }" class="input-xxlarge" placeholder="输入邮编" onkeyup="clearNoNum(this)" maxlength="6" />
					<span class="help-inline"></span>
				</div>
			</div>
			 <c:if test="${user.type.id != 4}">
			<div id="expanddiv">
			<div class="control-group">
				<label class="control-label" for="contacts">联系人</label>
				<div class="controls">
					<input path="contacts" name='contacts' id="contacts" value="${user.contacts }" class="input-xxlarge" placeholder="联系人姓名" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="zone.name">区域</label>
				<div class="controls">
					<input path="zonename" name='zonename' id="zonename" class="input-xxlarge"  value="${user.zone.name }" placeholder="区域" />
					<span class="help-inline"></span>
					<input id="zoneid" name="zone" type="hidden"  value="${user.zone.id }"/>
				</div>
			</div>
			</div>
			</c:if>
		</fieldset>
	</form>	
	
</section>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="display:none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					选择区域
				</h4>
			</div>
			<div class="modal-body" id="treeChooseZoneId">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="cssUrl1" value="/assets/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link href="${cssUrl1}" rel="stylesheet" media="screen">
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script>
$(document).ready(function () {

	$('#treeChooseZoneId').load('<c:url value="/utils/select/zones" />');
	$('#zonename').bind('click', function() {
		$('#myModal').modal( {
			keyboard : false
		})
	});

});
	
	function clickQuyuType(id,sname,level) {
		$('#zonename').val(sname);
		$('#zoneid').val(id);
		$('#myModal').modal('hide');
	} 
</script>
<jsp:include page="../includes/footer.jsp" />