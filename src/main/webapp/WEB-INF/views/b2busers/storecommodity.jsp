<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="已购商品" scope="request" />
<jsp:include page="../includes/popheader.jsp" />

<section class="content-wrap">
	<div class="container">
		<div class="row">
			<div class="column span8">
				<div class="well" style="height:470px;">
					<legend>
						已购商品
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
										<img src="${imageUrl}/${doc.url}" alt="" style="width: auto; height: 430px;" />
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
				<div class="well" style="height:470px;">
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
					<p class="muted">返利期限：${commodity.rebatedays }天</p>
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
		<div class="row">
			<div class="column span12">
				<div class="well" style="height:220px;">
					<legend>
						保护条件
						<c:if test="${loginuser.type.id == 2 || loginuser.type.id == 3}">
							<a id="addone" class="btn btn-info pull-right" href="javascript:addpop(${commodity.id })">
								<i class="icon-plus icon-white"></i> 新增
							</a>
						</c:if>
					</legend>
					<div class="divnull">&nbsp;&nbsp;</div>
					<table id="protectivetable" class="table table-bordered">
					 	<thead>
							<tr>
								<td align="center">最小进货数量</td>
<!-- 								<td align="center">最大进货数量</td> -->
								<td align="center">保护天数</td>
								<td align="center">保护半径</td>
								<td align="center">操作</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${protectives}" var="protective">
								<tr>
									<td>${protective.minnumber }</td>
<%-- 									<td>${protective.maxnumber }</td> --%>
									<td>${protective.days }</td>
									<td>${protective.radius }</td>
									<td>
										<c:if test="${loginuser.type.id == 2 || loginuser.type.id == 3}">
											<a id="editdept" class="btn btn-mini btn-warning"  
											href="javascript:editpop(${protective.id },${protective.cid },${protective.minnumber },${protective.maxnumber },${protective.days },${protective.radius })">
												编辑
											</a>
											<button class="btn btn-mini btn-danger" type="button" onclick="deleteOne(${protective.id})">删除</button></td>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<c:if test="${tags!=null}">
		
			<div class="row">
				<div class="column span12">
					<div class="well">
						<legend>
							商品标签
						</legend>
						<p class="muted"></p>
						<c:forEach items="${tags}" var="tag">
							<span class="label label-important">${tag.name }</span>
						</c:forEach>
					</div>
				</div>
			</div>
		
		</c:if>
		
	</div>
</section>
<div class="modal hide fade" id="editOne-modal" data-backdrop="static" data-keyboard="false">
	<c:url var="adddeptUrl" value="editprotective" />
	<form id="protective" class="form-horizontal" action="${adddeptUrl }" method="post">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">编辑保护条件</h3>
			<input type="hidden" id="id" name="id"  />
			<input type="hidden" id="cid" name="cid"  />
		</div>
		<br>
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="minnumber">最小数量</label>
				<div class="controls">
					<input type="text" id="minnumber" name="minnumber" class="span4" placeholder="最小数量" required onkeyup="clearNoNum(this)" />
					<span class="help-inline"></span>
				</div>
			</div>
<!-- 			<div class="control-group"> -->
<!-- 				<label class="control-label" for="code">最大数量</label> -->
<!-- 				<div class="controls"> -->
<!-- 					<input type="text" id="maxnumber" name="maxnumber" class="span4" placeholder="最大数量" required onkeyup="clearNoNum(this)" /> -->
<!-- 					<span class="help-inline"></span> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="control-group">
				<label class="control-label" for="days">保护天数</label>
				<div class="controls">
					<input type="text" id="days" name="days" class="span4" placeholder="天数" required onkeyup="clearNoNum(this)" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="radius">保护半径</label>
				<div class="controls">
					<input type="text" id="radius" name="radius" class="span4" placeholder="半径（千米）" required onkeyup="clearNoNum(this)" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label span2" for="login-btn"></label>
				<input type="submit" id="edit-btn" value="确  定" class="btn btn-info span3">
			</div>
		</fieldset>
	</form>
</div>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script>

$(document).ready(function () {
	addFormValidate();
});	

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
function addpop(cid){
	$("#id").val("");
	$("#cid").val(cid);
	$("#minnumber").val("");
// 	$("#maxnumber").val("");
	$("#days").val("");
	$("#radius").val("");
	$("#editOne-modal").modal( {
		keyboard : false
	});
}
function editpop(id,cid,min,max,days,radius){
	$("#id").val(id);
	$("#cid").val(cid);
	$("#minnumber").val(min);
// 	$("#maxnumber").val(max);
	$("#days").val(days);
	$("#radius").val(radius);
	$("#editOne-modal").modal( {
		keyboard : false
	});
}
function addFormValidate() {
	$("#protective").validate({
		debug : true,
		rules : {
			minnumber : {
				required : true
			},
			maxnumber : {
				required : true
			},
			days : {
				required : true
			},
			radius : {
				required : true
			}
		},

		messages : {
			minnumber : {
				required : "必填"
			},
			maxnumber : {
				required : "必填"
			},
			days : {
				required : "必填"
			},
			radius : {
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


function deleteOne(id) {
	bootbox.confirm("确定要删除吗？", "取消", "确定", function(isOk) {
		if (!isOk) {
			return;
		}
		$.post('<c:url value="deleteprotective" />', {
			id : id
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		});
	});
}
</script>
<jsp:include page="../includes/footer.jsp" />