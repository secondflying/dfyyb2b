<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="农资店信息" scope="request" />
<jsp:include page="../includes/saleheader.jsp" />

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
						<input type="hidden" id="userid" value="${user.id }"/>
					</legend>
					<p class="muted"></p>
					<p class="muted">类型：农资店</p>
					<p class="muted">手机：${user.phone }</p>
					<p class="muted">地址：${user.address }</p>
					<p class="muted">业务员：
						<c:if test="${salesman!=null}">
							${salesman.alias }
						</c:if>
					</p>
					<p class="muted">订单情况：
						<c:url var="orderUrl" value="storeorders?uid=${user.id}" />
						<a  class="btn btn-small btn-success" href="${orderUrl }" target="_Blank">
							查看
						</a>
					</p>
					<p class="muted">已购商品：
						<c:url var="orderUrl" value="storebuyed?uid=${user.id}" />
						<a  class="btn btn-small btn-success" href="${orderUrl }" target="_Blank">
							查看
						</a>
					</p>					
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