<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="用户信息" scope="request" />
<jsp:include page="../includes/mheader.jsp" />
<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="formal" />
			<li class="active"><a href="${infoUrl}">正式用户</a></li>
			<c:url var="infoUrl2" value="informal" />
			<li class=""><a href="${infoUrl2}">待审核用户</a></li>
		</ul>
	</div>
</div>
<section class="content-wrap">
	<div class="container">
		
		<div class="row">
			<div class="column span8">
				<div class="well">
					<legend>
						位置
					</legend>
					<div id="baiduContainer" style="padding-top: 5px;">
						<div id="mapContainer" style="height: 300px; border: solid 1px #cccccc"></div>
					</div>
				</div>
			</div>
			<div class="column span4">
				<div class="well" style="height:340px;">
					<legend>
						${user.alias }
						<c:if test="${user.status==2 }">
							<c:url var="eUrl" value="edit" />
							<a id="editone" class="btn btn-small btn-success pull-right" href="${eUrl}">
								编辑
							</a>
						</c:if>
					</legend>
					<p class="muted"></p>
					<p class="muted">类型：${user.type.name }</p>
					<p class="muted">联系人：${user.contacts }</p>
					<p class="muted">手机：${user.phone }</p>
					<p class="muted">地址：${user.address }</p>
					<p class="muted">邮编：${user.zipcode }</p>
					<p class="muted">区域：${user.zone.name }</p>
					<p class="text-success">审核通过</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="column span12">
				<div class="well" style="height:400px;">
					<legend>
						资料
					</legend>
					<div id="myCarousel" class="carousel slide">
					  <c:if test="${size>0}">
						  <ol class="carousel-indicators">
						    <c:set value="0" var="i" />
							<c:forEach items="${user.docs}" var="doc">
								<c:set var="cssClass" value="" />
								<c:if test="${sum==0}">
									<c:set var="cssClass" value="active" />
								</c:if>
								<li data-target="#myCarousel" data-slide-to="${i }" class="${cssClass }"></li>
								<c:set value="${i + 1}" var="i" />
							</c:forEach>
						  </ol>
							<div class="carousel-inner">
								<c:set value="0" var="sum" />
								<c:forEach items="${user.docs}" var="doc">
									<c:set var="cssClass" value="item" />
									<c:if test="${sum==0}">
										<c:set var="cssClass" value="active item" />
									</c:if>
									<div class="${cssClass}">
										<img src="${imageUrl}/${doc.url}" alt="" style="width: auto; height: 360px;" />
									</div>
									<c:set value="${sum + 1}" var="sum" />
								</c:forEach>
							</div>
							<a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
					  		<a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</section>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script>
$(document).ready(function () {

	var map = new BMap.Map("mapContainer");
	var point = new BMap.Point(${user.x}, ${user.y}); // 创建点坐标
	map.centerAndZoom(point, 10);
	map.enableScrollWheelZoom();
	map.addControl(new BMap.NavigationControl());
	
	drawMarker(${user.x}, ${user.y});
	
	function drawMarker(x, y) {
		var point = new BMap.Point(x, y);
		var marker = new BMap.Marker(point);
		map.addOverlay(marker);

		map.centerAndZoom(point, 12);
	}

});	
</script>
<jsp:include page="../includes/footer.jsp" />