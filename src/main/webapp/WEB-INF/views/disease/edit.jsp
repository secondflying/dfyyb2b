<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="编辑病虫害信息" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<c:url var="addUrl" value="editone?page=${page}&size=${size}" />
	<form id="disease2" action="${addUrl}" method="post">
		<fieldset>
			<legend>
				病虫害信息编辑
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="name">名称</label>
				<input type="hidden" path="id" name='id' id="id" class="input-xxlarge" value="${disease.id}" />
				<div class="controls">
					<input path="name" name='name' id="name" class="input-xxlarge" value="${disease.name}" placeholder="输入病虫害名称" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="description">描述</label>
				<div class="controls">
					<textarea rows="5" path="description" name='description' id="description" class="span8" placeholder="输入描述信息">${disease.description}
					</textarea>
					<span class="help-inline"></span>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="description">病虫害种类</label>
				<div class="controls">
					<select class="selectpicker" name="category.id" id="category.id" path="category.id">
						<c:forEach items="${cates}" var="cate">
							<option value="${cate.id}" <c:if test="${not empty disease.category and disease.category.id == cate.id}">selected</c:if>><c:out
									value="${cate.name}" /></option>
						</c:forEach>
					</select> <span class="help-inline"></span>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="description">作物</label>
				<div class="controls">
					<select class="selectpicker" name="crop.id" id="crop.id" path="crop.id">
						<c:forEach items="${crops}" var="crop">
							<option value="${crop.id}" <c:if test="${not empty disease.crop and crop.id == disease.crop.id}">selected</c:if>><c:out
									value="${crop.name}" /></option>
						</c:forEach>
					</select> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="description">关键词</label>
				<div class="controls">
					<input id="keywordText" type="text" class="input-large" /><input  type="button" class="btn btn-info" value="增加"  onclick="addKeyword()" />
					<div id="keywordsDiv">
						<c:forEach items="${disease.keywords}" var="key" varStatus="loop">
						<div id="key${loop.index}"
							style="height: 20px; display: inline-block; position: relative; margin: 0px 5px;padding:5px 15px 5px 5px; border: solid 1px #ccc;">
							<div>${key.name}</div>
							<a class="imageClose" href="javascript:deleteKeywordPanel(${loop.index})"></a>
							<input type="hidden" path="keywords[${loop.index}].name" name="keywords[${loop.index}].name" id="keywords[${loop.index}].name"
							value="${key.name}" />
						</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<input type="file" name="uploadify" id="multiple_file_upload" />
			<div id="attachmentsdiv">
				<c:forEach items="${disease.attachments}" var="attachment" varStatus="loop">
					<div id="panel${loop.index}"
						style="width: 150px; height: 150px; display: inline-block; position: relative; margin: 0px 5px; border: solid 1px #ccc;">
						<img class="image" src="${imageUrl}/${attachment.url}" />
						<a class="imageClose" href="javascript:deleteImagePanel(${loop.index})"></a>
						<input type="hidden" path="attachments[${loop.index}].url" name="attachments[${loop.index}].url" id="attachments[${loop.index}].url"
							value="${attachment.url}" />
					</div>
				</c:forEach>
			</div>

		</fieldset>
	</form>
</section>
<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>

<script>
var recipeUpload;
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
				html += '<a class="imageClose" href="javascript:deleteImagePanel('
				 + itemid + ')"></a>';
				html += '<input type="hidden" path="attachments[' + itemid + '].url" name="attachments[' + itemid + '].url" id="attachments[' + itemid + '].url" value="' + data + '" />';
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
	
	
	function addKeyword(){
		var text = $('#keywordText').val();
		if(!text){
			bootbox.alert("请输入关键字名称");
			return false;
		}
		
		
		var itemid = $("#keywordsDiv").children('div').length;
		if(itemid >= 5){
			bootbox.alert("最多只能设置5个关键字");
			return false;
		}
		var html = '<div id="key' + itemid + '" style="height: 20px; display: inline-block; position: relative; margin: 0px 5px;padding:5px 15px 5px 5px; border: solid 1px #ccc;">';
		html += '<div>' + text + '</div>';
		html += '<a class="imageClose" href="javascript:deleteKeywordPanel(' + itemid + ')"></a>';
		html += '<input type="hidden" path="keywords[' + itemid + '].name" name="keywords[' + itemid + '].name" id="keywords[' + itemid + '].name" value="' + text + '" />';
		html += '</div>';

		$("#keywordsDiv").append(html);
		$('#keywordText').val('');
	}
	
	function deleteKeywordPanel(id){
		$("#key" + id).remove();
	}
</script>


<jsp:include page="../includes/footer.jsp" />