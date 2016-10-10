<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="编辑作物信息" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<c:url var="addUrl" value="editone" />
	<form id="disease2" action="${addUrl}" method="post">
		<fieldset>
			<legend>
				作物信息编辑
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="name">名称</label>
				<input type="hidden" path="id" name='id' id="id" class="input-xxlarge" value="${crop.id}" />
				<div class="controls">
					<input path="name" name='name' id="name" class="input-xxlarge" value="${crop.name}" placeholder="输入作物名称" />
					<span class="help-inline"></span>
				</div>
			</div>


			<input type="file" name="uploadify" id="multiple_file_upload" />
			<div id="attachmentsdiv">
				<c:if test="${crop.image != null }">
					<div id="panel1"
						style="width: 150px; height: 150px; display: inline-block; position: relative; margin: 0px 5px; border: solid 1px #ccc;">
						<img class="image" src="${imageUrl}/${crop.image}" />
						<a class="imageClose" href="javascript:deleteImagePanel(1)"></a>
						<input type="hidden" path="image" name="image" id="image" value="${crop.image}" />
					</div>
				</c:if>
			</div>

		</fieldset>
	</form>
</section>
<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>

<script>
$(document).ready(function () {
	setplaceholderSupport();
	addFormValidate();

	$("#multiple_file_upload").uploadify({
		'removeTimeOut' : 0,
		'multi':false,
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
                html += '<img class="image" src="${imageUrl}/'+data+'" />';
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

});

function addFormValidate() {
	$("#disease2").validate({
		debug : true,
		rules : {
			name : {
				required : true
			},
			description : {
				required : true
			}
		},

		messages : {
			name : {
				required : "必填"
			},
			description : {
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