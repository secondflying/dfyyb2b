<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="编辑秒杀" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<c:url var="addUrl" value="edit" />
	<form id="second" action="${addUrl}" method="post">
		<fieldset>
			<legend>
				秒杀信息
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="title">标题</label>
				<input type="hidden" path="id" name='id' id="id" class="input-xxlarge" value="${second.id}" />
				<div class="controls">
					<input path="title" name='title' id="title" class="input-xxlarge" placeholder="输入配方标题" value="${second.title}" />
					<span class="help-inline"></span>
				</div>
			</div>
			<br /> <br />
			<div class="control-group">
				<label class="control-label" for="content">描述</label>
				<div class="controls">
					<textarea rows="5" path="content" name='content' id="content" class="span8" placeholder="输入描述信息">${second.content}</textarea>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="oprice">原价</label>
				<div class="controls">
					<input path="oprice" name='oprice' id="oprice" class="input-xxlarge" placeholder="输入原价" value="${second.oprice}"
						onkeyup="clearNoNum(this)" maxlength="10" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="nprice">现价</label>
				<div class="controls">
					<input path="nprice" name='nprice' id="nprice" class="input-xxlarge" placeholder="输入现价" value="${second.nprice}"
						onkeyup="clearNoNum(this)" maxlength="10" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="starttime">开始时间</label>
				<div class="controls">
					<input path="starttime" name='starttime' id="starttime" class="input-xxlarge" data-date-format="yyyy-mm-dd hh:ii"
						class="form_datetime" value="<fmt:formatDate value='${second.starttime}' type='date' pattern='yyyy-MM-dd HH:mm'/>" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="endtime">结束时间</label>
				<div class="controls">
					<input path="endtime" name='endtime' id="endtime" class="input-xxlarge" data-date-format="yyyy-mm-dd hh:ii"
						class="form_datetime" placeholder=""
						value="<fmt:formatDate value='${second.endtime}' type='date' pattern='yyyy-MM-dd HH:mm'/>" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="count">数量</label>
				<div class="controls">
					<input path="count" name='count' id="count" class="input-xxlarge" placeholder="" value="${second.count}"
						style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')"
						onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="count">最多秒杀数</label>
				<div class="controls">
					<input path="maxbuy" name='maxbuy' id="maxbuy" class="input-xxlarge" placeholder="" value="${second.maxbuy}"
						style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')"
						onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5" />
					<span class="help-inline"></span>
				</div>
			</div>
			
			
			<div class="control-group">
				<label class="control-label" for="count">是否可使用优惠币</label>
				<div class="controls">
					<c:choose>
					<c:when test="${second.useCoupon}">
						<input type="checkbox" checked path="useCoupon" name="useCoupon" id="useCoupon" />
					</c:when>
					<c:otherwise>
						<input type="checkbox" path="useCoupon" name="useCoupon" id="useCoupon" />
					</c:otherwise>
				</c:choose>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="count">可使用最少优惠币</label>
				<div class="controls">
					<input path="coupon" name='coupon' id="coupon" class="input-xxlarge" placeholder="" value="${second.coupon}"
						style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')"
						onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="count">可使用最多优惠币</label>
				<div class="controls">
					<input path="couponMax" name='couponMax' id="couponMax" class="input-xxlarge" placeholder="" value="${second.couponMax}"
						style="IME-MODE: disabled;" onkeyup="this.value=this.value.replace(/\D/g,'')"
						onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5" />
					<span class="help-inline"></span>
				</div>
			</div>
			
			<div class="row">
				<div class="span5">
					<label class="control-label" style="margin-bottom:8px" for="count">设置有货的农资店</label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="count">秒杀位置</label>
				<div class="controls">
					经度：
					<input id="x" path="x" name='x' value="${second.x}" placeholder="输入经度" />
					纬度：
					<input id="y" path="y" name='y' value="${second.y}" placeholder="输入纬度" />
					辐射范围（米）：
					<input id="size" path="size" name='size' value="${second.size}" placeholder="输入辐射范围（米）" style="IME-MODE: disabled;"
						onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
					<span class="help-inline"></span>
					<div id="baiduContainer" style="padding-top: 5px;">
						<div id="mapContainer" style="height: 300px; border: solid 1px #cccccc"></div>
					</div>
				</div>
			</div>
			<br /> <br />
			<input type="file" name="uploadify" id="multiple_file_upload" />

			<div id="attachmentsdiv">
				<c:set value="0" var="sum" />
				<c:forEach items="${second.attachments}" var="attachment">
					<div id="panel${sum}"
						style="width: 150px; height: 150px; display: inline-block; position: relative; margin: 0px 5px; border: solid 1px #ccc;">
						<img class="image" src="${imageUrl}/${attachment.url}" />
						<a class="imageClose" href="javascript:deleteImagePanel(${sum})"></a>
						<input type="hidden" path="attachments[${sum}].id" name="attachments[${sum}].id" id="attachments[${sum}].id"
							value="${attachment.id}" />
						<input type="hidden" path="attachments[${sum}].url" name="attachments[${sum}].url" id="attachments[${sum}].url"
							value="${attachment.url}" />
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
<script type="text/javascript" src="../../assets/bootstrap/js/moment.js"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>

<script>
$(document).ready(function () {
	setplaceholderSupport();
	addFormValidate();
	
	$("#multiple_file_upload") .uploadify({
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

	$('#starttime').datetimepicker({
		language : 'zh-CN'
	});
	$('#endtime').datetimepicker({
		language : 'zh-CN'
	});

	var map = new BMap.Map("mapContainer");
	var point = new BMap.Point(118.798632, 36.858719); // 创建点坐标
	map.centerAndZoom(point, 10);
	map.enableScrollWheelZoom();
	map.addControl(new BMap.NavigationControl());

	drawMarker(parseFloat($("#x").val()), parseFloat($("#y").val()));

	function drawMarker(x, y) {
		var point = new BMap.Point(x, y);
		var marker = new BMap.Marker(point);
		marker.enableDragging();
		map.addOverlay(marker);

		$("#x").val(x);
		$("#y").val(y);

		//拖拽地图时触发事件
		marker.addEventListener("dragend", function (e) {
			$("#x").val(e.point.lng);
			$("#y").val(e.point.lat);
		});
		map.centerAndZoom(point, 12);
	}

});


function addFormValidate() {
	$("#second").validate({
		debug : true,
		rules : {
			title : {
				required : true
			},
			content : {
				required : true
			},
			oprice : {
				required : true
			},
			nprice : {
				required : true
			},
			starttime : {
				required : true
			},
			endtime : {
				required : true
			},
			count : {
				required : true
			},
			x : {
				required : true
			},
			y : {
				required : true
			},
			size : {
				required : true
			}
		},

		messages : {
			title : {
				required : "必填"
			},
			content : {
				required : "必填"
			},
			oprice : {
				required : "必填"
			},
			nprice : {
				required : "必填"
			},
			starttime : {
				required : "必填"
			},
			endtime : {
				required : "必填"
			},
			count : {
				required : "必填"
			},
			x : {
				required : "必填"
			},
			y : {
				required : "必填"
			},
			size : {
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