<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="完成信息" scope="request" />
<jsp:include page="../includes/proheader.jsp" />


<section class="well">
	<c:url var="perfectUrl" value="perfect" />
	<form id="userform" action="${perfectUrl}" method="post">
		<fieldset>
			<legend>
				用户信息
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="alias">名称</label>
				<div class="controls">
					<input path="alias" name='alias' id="alias" class="input-xxlarge" placeholder="输入名称" required />
					<span class="help-inline"></span>
					<input path="id" name='id' id="id" type="hidden" value="${user.id }" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="typeid">类型</label>
				<select class="span5" name="type.id" id="typeid">
					<c:forEach items="${types}" var="type">
						<option value="${type.id }">
							${type.name }
						</option>
					</c:forEach>
				</select>
			</div>
			<div class="control-group">
				<label class="control-label" for="address">地址</label>
				<div class="controls">
					<input path="address" name='address' id="address" class="input-xxlarge" placeholder="输入地址" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="zipcode">邮编</label>
				<div class="controls">
					<input path="zipcode" name='zipcode' id="zipcode" class="input-xxlarge" placeholder="输入邮编" onkeyup="clearNoNum(this)" maxlength="6" required/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="contacts">联系人</label>
				<div class="controls">
					<input path="contacts" name='contacts' id="contacts" class="input-xxlarge" placeholder="联系人姓名" required/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="zone.name">区域</label>
				<div class="controls">
					<input path="zone.name" name='zone.name' id="zonename" class="input-xxlarge" placeholder="区域" required/>
					<span class="help-inline"></span>
					<input id="zoneid" name="zone.id"type="hidden" value=""/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="count">位置</label>
				<div class="controls">
					经度：<input id="x" path="x" name='x' placeholder="输入经度" />
					纬度：<input id="y" path="y" name='y' placeholder="输入纬度" />
					<span class="help-inline"></span>
					<div id="baiduContainer" style="padding-top: 5px;">
						<div id="mapContainer" style="height: 300px; border: solid 1px #cccccc"></div>
					</div>
				</div>
			</div>
			<br />
			<input type="file" name="uploadify" id="multiple_file_upload" />
			<p id="attachmenttip" class="text-error"></p>
			<div id="attachmentsdiv"></div>
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

	setplaceholderSupport();
	addFormValidate();
	$('#typeid').change(function(){ 
		setTipText();
	});
	setTipText();
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

	var map = new BMap.Map("mapContainer");
	var point = new BMap.Point(118.798632, 36.858719); // 创建点坐标
	map.centerAndZoom(point, 10);
	map.enableScrollWheelZoom();
	map.addControl(new BMap.NavigationControl());
	
	drawMarker(118.798632, 36.858719);
	
	function drawMarker(x, y) {
		var point = new BMap.Point(x, y);
		var marker = new BMap.Marker(point);
		marker.enableDragging();
		map.addOverlay(marker);

		$("#x").val(x);
		$("#y").val(y);

		//拖拽地图时触发事件
		marker.addEventListener("dragend", function(e) {
			$("#x").val(e.point.lng);
			$("#y").val(e.point.lat);
		});
		map.centerAndZoom(point, 12);
	}
	
	$('#treeChooseZoneId').load('<c:url value="/utils/select/zones" />');
	$('#zonename').bind('click', function() {
		$('#myModal').modal( {
			keyboard : false
		})
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
				},
				contacts : {
					required : true
				},
				zonename : {
					required : true
				},
				x : {
					required : true
				},
				y : {
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
				},
				contacts : {
					required : "必填"
				},
				zonename : {
					required : "必填"
				},
				x : {
					required : "必填"
				},
				y : {
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
	function setTipText(){
		var selvalue = $("#typeid").children('option:selected').val();
		if(selvalue==1){
			$('#attachmenttip').html("请上传营业执照、组织机构代码、法人身份证及与合伙人签订的合同照片等资料，否则审核不能通过");
		}
		if(selvalue==2){
			$('#attachmenttip').html("请上传营业执照、组织机构代码、身份证等资料，否则审核不能通过");
		}
		if(selvalue==3){
			$('#attachmenttip').html("请上传营业执照、组织机构代码、法人身份证等资料，否则审核不能通过");
		}
	}
	function clickZoneNote(id,sname) {
		$('#zonename').val(sname);
		$('#zoneid').val(id);
		$('#myModal').modal('hide');

	} 
</script>
<jsp:include page="../includes/footer.jsp" />