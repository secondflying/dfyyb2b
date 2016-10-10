<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="vu" uri="http://com.dfyy.util/ViewUtils"%>


<c:set var="pageTitle" value="升级申请审核" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			用户基本信息
			<c:url var="verifyUrl" value="verify?id=${applicant.id}" />
			<a class="btn btn-success pull-right" href="${verifyUrl}" data-toggle="modal"> 通过 </a>
			<label class="pull-right" style="width: 10px;"> </label>
			<a class="btn btn-danger pull-right" href="javascript:notverify(${applicant.id})"> 拒绝 </a>
			<c:url var="backUrl" value="index" />
			<label class="pull-right" style="width: 10px;"> </label>
			<a class="btn btn-info pull-right" href="${backUrl}" data-toggle="modal"> 返回 </a>
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="row-fluid">
			<div class="span4">
				<fieldset>
					<label class="control-label"><c:out value="用户名：${applicant.user.phone}" /></label> <label class="control-label"><c:out
							value="别  名：${applicant.user.alias}" /></label> <label class="control-label"><c:out value="级  别：${vu:getLevelName(applicant.user.levelID)}" /></label>
					<label class="control-label"><c:out value="积  分：${applicant.user.point}" /></label> <label class="control-label"><c:out
							value="地  址：${applicant.user.address}" /></label>
					<c:if test="${tuser!=null}">
						<label class="control-label"><c:out value="推荐人：${tuser.alias}" />&nbsp;&nbsp;<c:out
								value="${tuser.phone}" /></label>
					</c:if>
				</fieldset>
			</div>
			<div>
				<c:url var="thumbnailUrl" value="${imageUrl}/${applicant.user.thumbnail}" />
				<img src="${thumbnailUrl}" style="width: 100px;" id="thumbnail" />
			</div>
		</div>
	</fieldset>
</section>

<section class="well shadow">
	<fieldset>
		<legend> 申请信息 </legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="row-fluid">
			<div class="span4">
				<fieldset>
					<label class="control-label"><c:out value="申请级别：${applicant.level.name}" /></label>
					<c:if test="${applicant.level.id==3}">
						<label class="control-label"><c:out value="农资店名称：${applicant.name}" /></label>
					</c:if>
					<label class="control-label"><c:out value="擅长领域：${crops}" /></label>
					<c:if test="${applicant.level.id==2}">
						<label class="control-label"><c:out value="擅长区域：${empty applicant.area ? '' : applicant.area.text}" /></label>
						<label class="control-label"><c:out
								value="达人分类：${empty applicant.category ? '': applicant.category.name}" /></label>
					</c:if>
					<label class="control-label"><c:out value="自我描述：" /></label>
					<div style="width: 100%;">
						<c:out value="${applicant.description}" />
					</div>
					<label class="control-label"><c:out value="证件资料：" /></label>
					<div id="myCarousel" class="carousel slide" style="width: 800px;">
						<!-- Carousel items -->
						<div class="carousel-inner">
							<c:if test="${size>0}">
								<c:set value="0" var="sum" />
								<c:forEach items="${applicant.attachments}" var="attachment">
									<c:set var="cssClass" value="item" />
									<c:if test="${sum==0}">
										<c:set var="cssClass" value="active item" />
									</c:if>
									<div class="${cssClass}">
										<img src="${imageUrl}/${attachment.url}" alt="" style="width: auto; height: auto;" />
									</div>
									<c:set value="${sum + 1}" var="sum" />
								</c:forEach>
							</c:if>
						</div>
						<a class="carousel-control left" href="#myCarousel" data-slide="prev">‹</a>
						<a class="carousel-control right" href="#myCarousel" data-slide="next">›</a>
					</div>
				</fieldset>
			</div>
		</div>

	</fieldset>
</section>
<c:if test="${applicant.x!=null}">
	<section id="addressInfo" class="well shadow">
		<fieldset>
			<legend>
				农资店位置
				<input type="hidden" id="x" value="${applicant.x}" />
				<input type="hidden" id="y" value="${applicant.y}" />
			</legend>
			<label class="control-label"><c:out value="区  域：${applicant.area.text}" /></label>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div id="baiduContainer">
				<div id="mapContainer" style="height: 300px; border: solid 1px #cccccc"></div>
			</div>
		</fieldset>
	</section>
</c:if>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/CityList/1.2/src/CityList_min.js"></script>
<script>
	var gc = new BMap.Geocoder();
	var map = new BMap.Map("mapContainer");
	var point = new BMap.Point(116.404, 39.915); // 创建点坐标
	map.centerAndZoom(point, 12);
	map.enableScrollWheelZoom();
	map.addControl(new BMap.NavigationControl());

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
			MygetLocation(e.point);

			$("#x").val(e.point.lng);
			$("#y").val(e.point.lat);

		});

		map.centerAndZoom(point, 15);
	}

	function notverify(id) {
		bootbox.confirm("确定要拒绝吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}

			$.post('<c:url value="notverify" />', {
				id : id
			}).done(function(data) {
				window.location.href = '<c:url value="index" />';
			}).fail(function() {
			});
		});
	}

	$(document).ready(function() {

		if ($("#x").val() && $("#y").val()) {
			drawMarker(parseFloat($("#x").val()), parseFloat($("#y").val()));
		}

	});
</script>
<jsp:include page="../includes/footer.jsp" />