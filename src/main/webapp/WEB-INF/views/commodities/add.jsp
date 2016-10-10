<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="新增商品" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<c:url var="addUrl" value="addone" />
	<form id="commodity" action="${addUrl}" method="post">
		<fieldset>
			<legend>
				商品
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="name">名称</label>
				<div class="controls">
					<input path="name" name='name' id="name" class="input-xxlarge" placeholder="商品名称" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="point">购买类型</label>
				<div class="controls">
								<input type="radio" checked value="0" path="exchange" name="exchange" />
								积分兑换 &nbsp;&nbsp;
								<input type="radio" value="1" path="exchange" name="exchange" />
								推荐币兑换 &nbsp;&nbsp;
				</div>
			</div>
			<div class="control-group">
			<label class="control-label" for="point">积分或推荐币个数</label>
				<div class="controls">
							<input path="number" name='number' id="number" class="input-xxlarge" placeholder="" onkeyup="clearNoNum(this)"
								maxlength="20" />
							<span class="help-inline"></span>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="description">描述</label>
				<div class="controls">
					<textarea rows="5" path="description" name='description' id="description" class="span8" placeholder="输入描述信息"></textarea>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="description">可兑换用户级别</label>
				<div class="controls">
					<c:forEach items="${levels}" var="l" varStatus="loop">

						<input type="checkbox" value="${l.id}" path="levels[${loop.index}].id" name="levels[${loop.index}].id"
							id="levels[${loop.index}].id" />
						<c:out value="${l.name}" /> &nbsp;&nbsp;
							
					</c:forEach>
				</div>
			</div>
			<br />
			<input type="file" name="uploadify" id="multiple_file_upload" />
			<div id="attachmentsdiv"></div>

		</fieldset>
	</form>
</section>

<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="cssUrl1" value="/assets/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link href="${cssUrl1}" rel="stylesheet" media="screen">
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/moment.js"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

<script>

$(document).ready(function () {
	setplaceholderSupport();
	addFormValidate();

	$("#multiple_file_upload").uploadify({
		'removeTimeOut' : 0,
		'multi' : false,
		'buttonText' : '上传图片...',
		'swf' : '<c:url value="/assets/uploadify-v3.1/uploadify.swf"/>',
		'uploader' : '<c:url value="bash;jsessionid=${pageContext.session.id}"/>',
		'fileTypeExts' : '*.jpg;*.png;*.gif;*.bmp',
		'onDialogOpen' : function () {
			$("#saveform").attr("disabled", true);
		},
		'onUploadSuccess' : function (file, data, response) {
			if (data == "failure" || data == "") {
				bootbox.alert({
					buttons : {
						ok : {
							label : '确定',
							className : 'btn-myStyle'
						}
					},
					message : "抱歉，图片：" + file.name + "上传失败！",
					title : "提示",
				});
			} else {
				$("#attachmentsdiv").html("");
				var itemid = $("#attachmentsdiv").children('div').length;
				var html = '<div id="panel1" style="width:150px;height:150px;display:inline-block;position: relative;margin: 0px 5px;border: solid 1px #ccc;">';
				html += '<img class="image" src="${imageUrl}/' + data + '" />';
				html += '<a class="imageClose" href="javascript:deleteImagePanel(1)"></a>';
				html += '<input type="hidden" path="image" name="image" id="image" value="' + data + '" />';
				html += '</div>';

				$("#attachmentsdiv").append(html);
			}

		},
		'onQueueComplete' : function (stats) {
			$("#saveform").attr("disabled", false);
		}

	});
	$('#starttime').datetimepicker({
		language : 'zh-CN'
	});
	$('#endtime').datetimepicker({
		language : 'zh-CN'
	});

});

function addFormValidate() {
	$("#commodity").validate({
		debug : true,
		rules : {
			name : {
				required : true
			},
			point : {
				required : true
			}
		},

		messages : {
			name : {
				required : "必填"
			},
			point : {
				required : "必填"
			}
		},

		errorClass : 'invalid',
		validClass : 'invalid',
		errorPlacement : function (error, element) {
			element.nextAll(".help-inline").html(error);

		},
		success : function (label) {
			label.html("");
		},
		submitHandler : function (form) {
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

function deleteImagePanel(id) {
	$("#panel" + id).remove();
}

</script>
<jsp:include page="../includes/footer.jsp" />