<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="新增猜农资" scope="request" />
<jsp:include page="../includes/header.jsp" />


<section class="well shadow">
	<c:url var="addUrl" value="add" />
	<form id="second" action="${addUrl}" method="post">
		<fieldset>
			<legend>
				猜农资
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="name">内容</label>
				<div class="controls">
					<textarea rows="5" path="content" name='content' id="content" class="span8" placeholder="输入竞猜内容"></textarea>
					<span class="help-inline"></span>
				</div>
			</div>


			<div class="control-group">
				<label class="control-label" for="content">问题图片</label>
				<div class="controls">
					<input type="file" name="uploadify" id="multiple_file_upload1" />
					<div id="attachmentsdiv1"></div>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="answer">答案</label>
				<div class="controls">
					<input path="answer" name='answer' id="answer" class="input-xxlarge" placeholder="输入竞猜答案" />
					<span class="help-inline"></span>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="content">答案图片</label>
				<div class="controls">
					<input type="file" name="uploadify" id="multiple_file_upload2" />
					<div id="attachmentsdiv2"></div>
				</div>
			</div>

			<!-- 			<div class="control-group"> -->
			<!-- 				<label class="control-label" for="endtime">结束时间</label> -->
			<!-- 				<div class="controls"> -->
			<!-- 					<input path="endtime" name='endtime' id="endtime" class="input-xxlarge" data-date-format="yyyy-mm-dd hh:ii" -->
			<!-- 						class="form_datetime" placeholder="" /> -->
			<!-- 					<span class="help-inline"></span> -->
			<!-- 				</div> -->
			<!-- 			</div> -->

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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>

<script>
$(document).ready(function () {

	setplaceholderSupport();
	addFormValidate();

	$("#multiple_file_upload1") .uploadify({
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
				var itemid = $("#attachmentsdiv1").children('div').length;
				var html = '<div id="panel' + itemid + '" style="width:150px;height:150px;display:inline-block;position: relative;margin: 0px 5px;border: solid 1px #ccc;">';
				html += '<img class="image" src="${imageUrl}/' + data + '" />';
				html += '<a class="imageClose" href="javascript:deleteImagePanel(' + itemid + ')"></a>';
				html += '<input type="hidden" path="attachments1[' + itemid + '].url" name="attachments1[' + itemid + '].url" id="attachments1[' + itemid + '].url" value="' + data + '" />';
				html += '</div>';
				$("#attachmentsdiv1").append(html);
			}
		},
		'onQueueComplete' : function (stats) {
			$("#saveform").attr("disabled", false);
		}

	});
	
	
	$("#multiple_file_upload2") .uploadify({
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
				var itemid = $("#attachmentsdiv2").children('div').length;
				var html = '<div id="panel2' + itemid + '" style="width:150px;height:150px;display:inline-block;position: relative;margin: 0px 5px;border: solid 1px #ccc;">';
				html += '<img class="image" src="${imageUrl}/' + data + '" />';
				html += '<a class="imageClose" href="javascript:deleteImagePanel2(' + itemid + ')"></a>';
				html += '<input type="hidden" path="attachments2[' + itemid + '].url" name="attachments2[' + itemid + '].url" id="attachments2[' + itemid + '].url" value="' + data + '" />';
				html += '</div>';
				$("#attachmentsdiv2").append(html);
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
		$("#second").validate({
			debug : true,
			rules : {
				content : {
					required : true
				},
				answer : {
					required : true
				}
			},

			messages : {
				content : {
					required : "必填"
				},
				answer : {
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
				var item1 = $("#attachmentsdiv1").children('div').length;
				var item2 = $("#attachmentsdiv2").children('div').length;
				if(item1 > 3){
					bootbox.alert("最多上传3张图片");
					return false;
				}
				if(item2 > 3){
					bootbox.alert("最多上传3张图片");
					return false;
				}
				if(item1 != item2){
					bootbox.alert("问题和答案图片个数不一致");
					return false;
				}
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
	
	function deleteImagePanel2(id) {
		$("#panel2" + id).remove();
	}	
	
</script>
<jsp:include page="../includes/footer.jsp" />