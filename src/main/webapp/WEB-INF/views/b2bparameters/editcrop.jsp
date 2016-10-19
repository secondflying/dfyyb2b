<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="编辑商品分类" scope="request" />
<jsp:include page="../includes/mheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="commoditytypeUrl" value="commoditytype" />
			<li class="active"><a href="${commoditytypeUrl}">商品分类</a></li>
			<c:url var="tagUrl2" value="tags" />
			<li class=""><a href="${tagUrl2}">商品标签</a></li>
			<c:url var="unitUrl2" value="units" />
			<li class=""><a href="${unitUrl2}">商品单位</a></li>
			<c:url var="brokerageUrl2" value="brokerages" />
			<li class=""><a href="${brokerageUrl2}">佣金系数</a></li>
		</ul>
	</div>
</div>
<section class="well">
	<c:url var="perfectUrl" value="/manager/parameters/editcrop" />
	<form id="crop" action="${perfectUrl}" method="post" enctype="multipart/form-data">
		<fieldset>
			<legend>
				商品类别
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="cname">父类</label>
				<div class="controls">
					<input path="cname" name='cname' id="cname" class="input-xxlarge" placeholder="父类名称" value="${cname }"/>
					<span class="help-inline"></span>
					<input id="category" name="category"type="hidden" value="${crop.category }"/>
					<input id="id" name="id"type="hidden" value="${crop.id }"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="name">名称</label>
				<div class="controls">
					<input path="name" name='name' id="name" class="input-xxlarge" placeholder="输入名称" value = "${crop.name }" required />
					<span class="help-inline"></span>
				</div>
			</div>			
			<br />
			<input type="file" name="uploadify" id="multiple_file_upload" />
			<p id="attachmenttip" class="text-error">请上传类别图片</p>
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
					选择父类别
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

	$('#treeChooseZoneId').load('<c:url value="/utils/select/crops" />');
	$('#cname').bind('click', function() {
		$('#myModal').modal( {
			keyboard : false
		})
	});

});

	function addFormValidate() {
		$("#crop").validate({
			debug : true,
			rules : {
				name : {
					required : true
				}
			},

			messages : {
				name : {
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

	function clickCropNote(id,sname) {
		$('#cname').val(sname);
		$('#category').val(id);
		$('#myModal').modal('hide');

	} 
</script>
<jsp:include page="../includes/footer.jsp" />