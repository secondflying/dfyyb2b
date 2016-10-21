<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="审核商品" scope="request" />
<jsp:include page="../includes/mheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infUrl" value="informal" />
			<li class="active"><a href="${infUrl}">待审核商品</a></li>
		</ul>
	</div>
</div>

<section class="content-wrap">
	<div class="container">
		<div class="row">
			<div class="column span8">
				<div class="well" style="height:340px;">
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
										<img src="${imageUrl}/${doc.url}" alt="" style="width: auto; height: 300px;" />
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
				<div class="well" style="height:340px;">
					<legend>
						${commodity.name }
					</legend>
					<p class="muted"></p>
					<p class="muted">类型：${commodity.type.name }</p>
					<p class="muted">单位：${commodity.unit.name }</p>
					<p class="muted">价格：${commodity.price }</p>
					<p class="muted">厂家：${commodity.factory }</p>
					<p class="muted">登记证号：${commodity.code }</p>
					<p class="muted">规格：${commodity.standard }</p>
					<p class="muted">成分及含量：${commodity.composition }</p>
					<p class="muted">起订量：${commodity.number }</p>
					<p class="muted">增减阶梯步长：${commodity.step }</p>
					<p class="muted">业务员佣金比例：${commodity.brokerage }</p>
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
								<td align="center">最大数量</td>
								<td align="center">价格</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${gprices}" var="gprice">
								<tr>
									<td>${gprice.minnumber }</td>
									<td>${gprice.maxnumber }</td>
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
								<td align="center">最大数量</td>
								<td align="center">返利</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${grebates}" var="grebate">
								<tr>
									<td>${grebate.minnumber }</td>
									<td>${grebate.maxnumber }</td>
									<td>${grebate.rebate }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="column span12">
				<div class="well" style="height:220px;">
					<legend>
						审查
					</legend>
					<div class="control-group">
						<label class="control-label" for="opinion"></label>
						<div class="controls">
							<textarea rows="5" path="opinion" name='opinion' id="opinion" class="span8" placeholder="输入审查意见" maxlength="100"></textarea>
							<span class="help-inline"></span>
						</div>
					</div>
					<a class="btn btn-success pull-right" href="javascript:verify('${commodity.id}');"> 通过 </a>
					<label class="pull-right" style="width: 10px;"> </label>
					<a class="btn btn-danger pull-right" href="javascript:notverify('${commodity.id}');"> 拒绝 </a>
					
				</div>
			</div>
		</div>
	</div>
	
</section>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script>
function verify(id) {
	bootbox.confirm("确定审查合格了吗？", "取消", "确定", function(isOk) {
		if (!isOk) {
			return;
		}
		var opinion = $("#opinion").val();
		$.post('<c:url value="verify" />', {
			id : id,
			opinion:opinion
		}).done(function(data) {
			window.location.href = '<c:url value="informal" />';
		}).fail(function() {
		});
	}); 
}

function notverify(id) {
	bootbox.confirm("确定要拒绝吗？", "取消", "确定", function(isOk) {
		if (!isOk) {
			return;
		}
		var opinion = $("#opinion").val();
		if(opinion==null || opinion==""){
			bootbox.alert("请填写拒绝的理由");
			return;
		}
		$.post('<c:url value="notverify" />', {
			id : id,
			opinion:opinion
		}).done(function(data) {
			window.location.href = '<c:url value="informal" />';
		}).fail(function() {
		});
	});
}
$(document).ready(function () {

});	
</script>
<jsp:include page="../includes/footer.jsp" />