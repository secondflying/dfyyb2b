<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="新增田间地头" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<c:url var="addUrl" value="addone" />	
	<form id="agrotechnical" action="${addUrl}" method="post">
		<fieldset>
			<legend>田间地头
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="control-group">
				<label class="control-label" for="title">标题</label>
				<div class="controls">
					<input path="title" name='title' id="title" class="input-xxlarge" placeholder="输入标题" style="width:100%;" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="description">种类</label>
				<div class="controls">
					<select class="selectpicker" name="category.id" id="category.id" path="category.id" style="width:100%;">
						<c:forEach items="${cates}" var="cate">
							<option value="${cate.id}"><c:out value="${cate.name}" /></option>
						</c:forEach>
					</select> <span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="content">内容</label>
				<input type="hidden" path="thumbnail" name='thumbnail' id="thumbnail" />
				<div class="controls">
					<textarea rows="20" path="content" name='content' id="content" style="width:100%;" ></textarea>
					<span class="help-inline"></span>
				</div>
			</div>

<!-- 			<input type="file" name="uploadify" id="multiple_file_upload" /> -->
<!-- 			<div id="attachmentsdiv"> </div> -->
			
		</fieldset>
	</form>
</section>

<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>

<c:url var="cssUrl" value="/assets/wangEditor-2.1.12/css/wangEditor.min.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="jsUrl" value="/assets/wangEditor-2.1.12/js/wangEditor.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>

<script>
	var recipeUpload;
	$(document).ready(function() {
		
		setplaceholderSupport();
		addFormValidate();
		
		var editor = new wangEditor('content');
		
		editor.config.menus = [
		                  'source',
		                  '|',
		                  'bold',
		                  'underline',
		                  'italic',
		                  'strikethrough',
		                  'eraser',
		                  'forecolor',
		                  'bgcolor',
		                  '|',
// 		                  'quote',
// 		                  'fontfamily',
// 		                  'fontsize',
		                  'head',
		                  'unorderlist',
		                  'orderlist',
// 		                  'alignleft',
// 		                  'aligncenter',
// 		                  'alignright',
		                  '|',
// 		                  'link',
// 		                  'unlink',
// 		                  'table',
// 		                  'emotion',
		                  '|',
		                  'img',
		                  'video',
// 		                  'location',
// 		                  'insertcode',
// 		                  '|',
// 		                  'undo',
// 		                  'redo',
// 		                  'fullscreen'
		              ];
		
		editor.config.pasteText = true;
		
		
		editor.config.uploadImgUrl = '<c:url value="bash"/>';
		// 自定义load事件
	    editor.config.uploadImgFns.onload = function (resultText, xhr) {
	        // 如果 resultText 是图片的url地址，可以这样插入图片：
	        editor.command(null, 'insertHtml', '<img src="' + resultText + '" style style="max-width:100%;" />');
	        $("#thumbnail").val(resultText);
	    };

	    // 自定义timeout事件
	    editor.config.uploadImgFns.ontimeout = function (xhr) {
	        alert('上传超时');
	    };

	    // 自定义error事件
	    editor.config.uploadImgFns.onerror = function (xhr) {
	        alert('上传错误');
	    };
		
	    editor.create();
	});
	
	function addFormValidate() {
		$("#agrotechnical").validate(
				{
					debug : true,
					rules : {
						title : {
							required : true
						},
						content : {
							required : true
						}
					},

					messages : {
						title : {
							required : "必填"
						},
						content : {
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