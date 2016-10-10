<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="编辑农资店信息" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<c:url var="addUrl" value="editone" />
	<form id="disease2" action="${addUrl}" method="post">
		<fieldset>
			<legend>
				编辑农资店信息
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="control-group">
				<label class="control-label" for="alias">名称</label>
				<input type="hidden" path="id" name='id' id="id" class="input-xxlarge" value="${user.id}" />
				<div class="controls">
					<input path="alias" name='alias' id="alias" class="input-xxlarge" value="${user.alias}" placeholder="输入农资店名称" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<c:choose>
					<c:when test="${user.teamwork}">
						<input type="checkbox" checked path="teamwork" name="teamwork" id="teamwork" />是否合作农资店
					</c:when>
					<c:otherwise>
						<input type="checkbox" path="teamwork" name="teamwork" id="teamwork" />是否合作农资店
					</c:otherwise>
				</c:choose>
				&nbsp;&nbsp;
				<c:choose>
					<c:when test="${user.acceptCoupon}">
						<input type="checkbox" checked path="acceptCoupon" name="acceptCoupon" id="acceptCoupon" />是否接受优惠币
					</c:when>
					<c:otherwise>
						<input type="checkbox" path="acceptCoupon" name="acceptCoupon" id="acceptCoupon" />是否接受优惠币
					</c:otherwise>
				</c:choose>
			</div>
			<div class="control-group">
				<label class="control-label" for="phone">电话</label>
				<div class="controls">
					<input path="phone" name='phone' id="phone" class="input-xxlarge" value="${user.phone}" placeholder="输入农资店电话" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="address">地址</label>
				<div class="controls">
					<input path="address" name='address' id="address" class="input-xxlarge" value="${user.address}"
						placeholder="输入农资店地址" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="description">描述</label>
				<div class="controls">
					<textarea rows="5" path="description" name='description' id="description" class="span8" placeholder="输入描述信息">${user.description}
					</textarea>
					<span class="help-inline"></span>
				</div>
			</div>
		
		</fieldset>

		<section id="addressInfo" class="well shadow">
			<fieldset>
				<legend>
					农资店位置
					<input type="hidden" id="x" path="x" name='x' value="${user.x}" />
					<input type="hidden" id="y" path="y" name='y' value="${user.y}" />
				</legend>
				<%-- 			<label class="control-label"><c:out value="区  域：${applicant.area.text}" /></label> --%>
				<div class="divnull">&nbsp;&nbsp;</div>
				<div id="baiduContainer">
					<div id="mapContainer" style="height: 300px; border: solid 1px #cccccc"></div>
				</div>
			</fieldset>
		</section>
	</form>
</section>
<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/CityList/1.2/src/CityList_min.js"></script>
<script>
	$(document).ready(function() {
		setplaceholderSupport();
		addFormValidate();

		var gc = new BMap.Geocoder();
		var map = new BMap.Map("mapContainer");
		var point = new BMap.Point(118.93, 36.90); // 创建点坐标
		map.centerAndZoom(point, 10);
		map.enableScrollWheelZoom();
		map.addControl(new BMap.NavigationControl());

		if ($("#x").val() && $("#y").val()) {
			drawMarker(parseFloat($("#x").val()), parseFloat($("#y").val()));
		}

		function drawMarker(x, y) {
			var point = new BMap.Point(x, y);
			var marker = new BMap.Marker(point);
			marker.enableDragging();
			map.addOverlay(marker);

			gc.getLocation(point, function(rs) {
				var addComp = rs.addressComponents;
				$("#curCity").html(addComp.city);
				$("#city").val(addComp.city);
			});

			$("#x").val(x);
			$("#y").val(y);

			//拖拽地图时触发事件
			marker.addEventListener("dragend", function(e) {
				$("#x").val(e.point.lng);
				$("#y").val(e.point.lat);
			});
			map.centerAndZoom(point, 15);
		}
	});

	function addFormValidate() {
		$("#disease2").validate({
			debug : true,
			rules : {
				alias : {
					required : true
				},
				phone : {
					required : true
				}
			},

			messages : {
				alias : {
					required : "必填"
				},
				phone : {
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
</script>


<jsp:include page="../includes/footer.jsp" />