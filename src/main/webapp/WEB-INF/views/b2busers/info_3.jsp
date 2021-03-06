<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="厂家信息" scope="request" />
<jsp:include page="../includes/mheader.jsp" />
<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="partners" />
			<li class=""><a href="${infoUrl}">合伙人</a></li>
			<c:url var="dealerUrl" value="dealers" />
			<li class=""><a href="${dealerUrl}">经销商</a></li>
			<c:url var="manuUrl" value="manufacturers" />
			<li class="active"><a href="${manuUrl}">厂家</a></li>
			<c:url var="saleUrl" value="salesmans" />
			<li class=""><a href="${saleUrl}">业务员</a></li>
			<c:url var="storeUrl" value="stores" />
			<li class=""><a href="${storeUrl}">农资店</a></li>
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
						<input type="hidden" id="userid" value="${user.id }"/>
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
					<p class="muted">合伙人：
						<c:if test="${partner!=null}">
							${partner.alias }
						</c:if>
						<a id="editone" class="btn btn-small btn-success" href="#myModal1" data-toggle="modal">
							设置
						</a>
					</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="column span8">
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
		<div class="row">
			<div class="column span8">
				<div class="well">
					<legend>
						销售区域
						<c:url var="eUrl" value="edit" />
						<a id="editone" class="btn btn-small btn-success pull-right" href="#myModal" data-toggle="modal">
							添加
						</a>
					</legend>
					<table id="areatable" class="table  table-bordered table-hover table-striped" style="margin: 0;">
						<thead class="info">
							<tr>
								<th align="center">区域名称</th>
								<th align="center">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty zones}">
								<tr>
									<td colspan="2">空</td>
								</tr>
			
							</c:if>
							<c:forEach items="${zones}" var="zone">
								<tr class="${cssClass}">
									<td><c:out value="${zone.area.name}" /></td>
									<td style="width:80px;">
										<a id="deleteone" class="btn btn-small btn-danger" href="javascript:deletezone('${zone.id}');">
											删除
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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
					选择销售区域
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
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel1" aria-hidden="true" style="display:none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel1">
					选择合伙人
				</h4>
			</div>
			<div class="modal-body" id="treeChooseZoneId1">
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
	$('#treeChooseZoneId').load('<c:url value="/utils/select/zones" />');
	$('#treeChooseZoneId1').load('<c:url value="/utils/select/partners" />');
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
function clickQuyuType(id,sname,level) {
	if(level==1 || level==4){
		return;
	}
	
	$('#myModal').modal('hide');
	var uid = $('#userid').val();
	$.post('<c:url value="addproviderzone" />', {
		uid : uid,
		aid : id
	}).done(function(data) {
		if(data=="true"){
			window.location.href = window.location.href;
		}
		else{
			bootbox.alert("重复记录");
		}
	}).fail(function() {
	});
} 

function deletezone(id){
	bootbox.confirm("确定删除该区域吗？", "取消", "确定", function(isOk) {
		if (!isOk) {
			return;
		}
		$.post('<c:url value="deleteprovicerzone" />', {
			id : id
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		});
	}); 
}

function clickPartnerNote(id,name){
	$('#myModal1').modal('hide');
	var did = $('#userid').val();
	$.post('<c:url value="setpartner" />', {
		pid : id,
		did : did
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