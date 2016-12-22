<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="商品管理" scope="request" />
<jsp:include page="../includes/mheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infUrl" value="informal" />
			<li><a href="${infUrl}">待审核商品</a></li>
			<c:url var="cheUrl" value="checked" />
			<li class="active"><a href="${cheUrl}">已上架商品</a></li>
		</ul>
	</div>
</div>

<section class="content-wrap">
	<div class="container">
		<div class="row">
			<div class="column span12">
				<div class="well">
					<legend>
						商品标签
						<c:url var="tagUrl" value="tagsmanager?cid=${commodity.id }" />
						<a class="btn btn-success pull-right" href="${tagUrl }"> 编辑 </a>
					</legend>
					<p class="muted"></p>
					<c:forEach items="${tags}" var="tag">
						<span class="label label-important">${tag.name }</span>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="column span8">
				<div class="well" style="height:440px;">
					<legend>
						商品资料
					</legend>
					<div id="myCarousel" class="carousel slide">
					  <c:if test="${size>0}">
						  <ol class="carousel-indicators">
						    <c:set value="0" var="i" />
							<c:forEach items="${docs}" var="doc">
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
								<c:forEach items="${docs}" var="doc">
									<c:set var="cssClass" value="item" />
									<c:if test="${sum==0}">
										<c:set var="cssClass" value="active item" />
									</c:if>
									<div class="${cssClass}">
										<img src="${imageUrl}/${doc.url}" alt="" style="width: auto; height: 400px;" />
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
			<div class="column span4">
				<div class="well" style="height:440px;">
					<legend>
						${commodity.name }
					</legend>
					<p class="muted"></p>
					<p class="muted">类型：${commodity.type.name }</p>
					<p class="muted">单位：${commodity.unit.name }</p>
					<p class="muted">原价：${commodity.oprice }</p>
					<p class="muted">现价：${commodity.price }</p>
					<p class="muted">零售价：${commodity.retail }</p>
					<p class="muted">起订量：${commodity.number }</p>
					<p class="muted">限量：${commodity.maxcount }</p>
					<p class="muted">增减阶梯步长：${commodity.step }</p>
					<p class="muted">业务员佣金比例：${commodity.brokerage }</p>
					<p class="muted">区域：${commodity.zone.name }</p>
					<p class="muted">厂家：${commodity.factory }</p>
					<p class="muted">登记证号：${commodity.code }</p>
					<p class="muted">规格：${commodity.standard }</p>
					<p class="muted">成分及含量：${commodity.composition }</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="column span6">
				<div class="well">
					<legend>
						阶梯价格
					</legend>
					<div class="divnull">&nbsp;&nbsp;</div>
					<table id="pricetable" class="table table-bordered">
					 	<thead>
							<tr>
								<td align="center">最小数量</td>
<!-- 								<td align="center">最大数量</td> -->
								<td align="center">价格</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${gprices}" var="gprice">
								<tr>
									<td>${gprice.minnumber }</td>
<%-- 									<td>${gprice.maxnumber }</td> --%>
									<td>${gprice.price }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="column span6">
				<div class="well">
					<legend>
						阶梯返利
					</legend>
					<div class="divnull">&nbsp;&nbsp;</div>
					<table id="pricetable" class="table table-bordered">
					 	<thead>
							<tr>
								<td align="center">最小数量</td>
<!-- 								<td align="center">最大数量</td> -->
								<td align="center">返利</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${grebates}" var="grebate">
								<tr>
									<td>${grebate.minnumber }</td>
<%-- 									<td>${grebate.maxnumber }</td> --%>
									<td>${grebate.rebate }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<c:if test="${protectives!=null}">
			<div class="row">
				<div class="column span12">
					<div class="well" style="height:220px;">
						<legend>
							保护条件
						</legend>
						<div class="divnull">&nbsp;&nbsp;</div>
						<table id="protectivetable" class="table table-bordered">
						 	<thead>
								<tr>
									<td align="center">最小进货数量</td>
	<!-- 								<td align="center">最大进货数量</td> -->
									<td align="center">保护天数</td>
									<td align="center">保护半径</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${protectives}" var="protective">
									<tr>
										<td>${protective.minnumber }</td>
	<%-- 									<td>${protective.maxnumber }</td> --%>
										<td>${protective.days }</td>
										<td>${protective.radius }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</c:if>
	</div>
</section>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script>

$(document).ready(function () {

});	
</script>
<jsp:include page="../includes/footer.jsp" />