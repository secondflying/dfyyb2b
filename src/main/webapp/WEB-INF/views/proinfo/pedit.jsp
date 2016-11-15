<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="编辑信息" scope="request" />
<jsp:include page="../includes/proheader.jsp" />


<section class="well">
	<c:url var="perfectUrl" value="edit" />
	<form id="userform" action="${perfectUrl}" method="post">
		<fieldset>
			<legend>
				编辑用户信息
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存并提交" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="alias">名称</label>
				<div class="controls">
					<input path="alias" name='alias' id="alias" class="input-xxlarge" placeholder="输入名称" required value="${user.alias }" />
					<span class="help-inline"></span>
					<input path="id" name='id' id="id" type="hidden" value="${user.id }" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="address">地址</label>
				<div class="controls">
					<input path="address" name='address' id="address" class="input-xxlarge" placeholder="输入地址" required value="${user.address }"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="zipcode">邮编</label>
				<div class="controls">
					<input path="zipcode" name='zipcode' id="zipcode" class="input-xxlarge" placeholder="输入邮编" onkeyup="clearNoNum(this)" maxlength="6" required value="${user.zipcode }"/>
					<span class="help-inline"></span>
				</div>
			</div>
			
			<br />
			<input type="file" name="uploadify" id="multiple_file_upload" />
			<p id="attachmenttip" class="text-error">请上传身份证等资料，否则审核不能通过</p>
			<div id="attachmentsdiv">
				<c:set value="0" var="sum" />
				<c:forEach items="${user.docs}" var="doc">
					<div id="panel${sum}"
						style="width: 150px; height: 150px; display: inline-block; position: relative; margin: 0px 5px; border: solid 1px #ccc;">
						<img class="image" src="${imageUrl}/${doc.url}" />
						<a class="imageClose" href="javascript:deleteImagePanel(${sum})"></a>
						<input type="hidden" path="docs[${sum}].id" name="docs[${sum}].id" id="docs[${sum}].id"
							value="${doc.id}" />
						<input type="hidden" path="docs[${sum}].url" name="docs[${sum}].url" id="docs[${sum}].url"
							value="${doc.url}" />
					</div>
					<c:set value="${sum + 1}" var="sum" />
				</c:forEach>
			</div>
		</fieldset>
	</form>
</section>

<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="cssUrl1" value="/assets/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link href="${cssUrl1}" rel="stylesheet" media="screen">
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script>
$(document).ready(function () {

	setplaceholderSupport();
	addFormValidate();
	
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
		$("#second").validate({
			debug : true,
			rules : {
				alias : {
					required : true
				},
				typeid : {
					required : true
				},
				address : {
					required : true
				},
				zipcode : {
					required : true
				}
			},

			messages : {
				alias : {
					required : "必填"
				},
				typeid : {
					required : "必填"
				},
				address : {
					required : "必填"
				},
				zipcode : {
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
	function deleteImagePanel(id) {
		$("#panel" + id).remove();
	}
	
</script>
<jsp:include page="../includes/footer.jsp" />