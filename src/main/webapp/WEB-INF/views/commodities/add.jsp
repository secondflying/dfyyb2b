<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="新增商品" scope="request" />
<jsp:include page="../includes/proheader.jsp" />

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
				<label class="control-label" for="description">描述</label>
				<div class="controls">
					<textarea rows="5" path="description" name='description' id="description" class="span8" placeholder="输入描述信息"></textarea>
					<span class="help-inline"></span>
				</div>
			</div>
			
			<br />
			<input type="file" name="uploadify" id="multiple_file_upload" />
			<p id="attachmenttip" class="text-error">请上传外包装正面、背面、内料；田间实验图片(最多3张)；相关证书图片(最多3张)否则审核不能通过</p>
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
	
	$('#starttime').datetimepicker({
		language : 'zh-CN'
	});
	$('#endtime').datetimepicker({
		language : 'zh-CN'
	});
	
	
	
	$("#multiple_file_upload").uploadify({
		'removeTimeOut' : 0,
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
				var itemid = $("#attachmentsdiv").children('div').length;
				var html = '<div id="panel' + itemid + '" style="width:150px;height:150px;display:inline-block;position: relative;margin: 0px 5px;border: solid 1px #ccc;">';
				html += '<img class="image" src="${imageUrl}/' + data + '" />';
				html += '<a class="imageClose" href="javascript:deleteImagePanel(' + itemid + ')"></a>';
                html += '<input type="hidden" path="docs[' + itemid + '].url" name="docs[' + itemid + '].url" id="docs[' + itemid + '].url" value="' + data + '" />';
				html += '</div>';

				$("#attachmentsdiv").append(html);
			}

		},
		'onQueueComplete' : function (stats) {
			$("#saveform").attr("disabled", false);
		}

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

function deleteImagePanel(id) {
	$("#panel" + id).remove();
}

</script>
<jsp:include page="../includes/footer.jsp" />