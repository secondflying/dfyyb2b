<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="农资店信息" scope="request" />
<jsp:include page="../includes/mheader.jsp" />
<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="partners" />
			<li class=""><a href="${infoUrl}">合伙人</a></li>
			<c:url var="dealerUrl" value="dealers" />
			<li class=""><a href="${dealerUrl}">经销商</a></li>
			<c:url var="manuUrl" value="manufacturers" />
			<li class=""><a href="${manuUrl}">厂家</a></li>
			<c:url var="saleUrl" value="salesmans" />
			<li class=""><a href="${saleUrl}">业务员</a></li>
			<c:url var="storeUrl" value="stores" />
			<li class="active"><a href="${storeUrl}">农资店</a></li>
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
						<a id="editone" class="btn btn-small btn-success" href="#myModal" data-toggle="modal">
							设置
						</a>
					</p>					
				</div>
			</div>
		</div>
		
	</div>
	
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
					选择业务员
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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script>
$(document).ready(function () {
	
	$('#treeChooseZoneId').load('<c:url value="/utils/select/salesmans" />');

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
function clickSalesmanNote(id,name){
	$('#myModal').modal('hide');
	var uid = $('#userid').val();
	$.post('<c:url value="setsalesman" />', {
		uid : id,
		sid : uid
	}).done(function(data) {
		if(data=="true"){
			window.location.href = window.location.href;
		}
		else{
			
		}
	}).fail(function() {
	});
}
</script>
<jsp:include page="../includes/footer.jsp" />