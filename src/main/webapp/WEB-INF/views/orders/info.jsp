<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="订单管理" scope="request" />
<jsp:include page="../includes/proheader.jsp" />
<section class="content-wrap">
	<div class="container">
		<div class="row">
			<div class="column span12">
				<div class="well">
					<legend>
						订购农资店
					</legend>
					<p class="muted"></p>
					<p class="muted">名称：${order.nzd.alias }&nbsp;&nbsp;电话：${order.nzd.phone }&nbsp;&nbsp;地址：${order.nzd.address }</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="column span8">
				<div class="well" style="height:340px;">
					<legend>
						订单商品						
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
						${order.commodity.name }
					</legend>
					<p class="muted"></p>
					<p class="muted">类型：${order.commodity.type.name }</p>
					<p class="muted">单位：${order.commodity.unit.name }</p>
					<p class="muted">价格：${order.commodity.price }</p>
					<p class="muted">厂家：${order.commodity.factory }</p>
					<p class="muted">登记证号：${order.commodity.code }</p>
					<p class="muted">规格：${order.commodity.standard }</p>
					<p class="muted">成分及含量：${order.commodity.composition }</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="column span12">
				<div class="well">
					<legend>
						供应商信息
					</legend>
					<p class="muted"></p>
					<p class="muted">名称：${order.commodity.provider.alias }&nbsp;&nbsp;联系人：${order.commodity.provider.contacts }&nbsp;&nbsp;
					电话：${order.commodity.provider.phone }</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="column span12">
				<div class="well">
					<legend>
						订单基本信息
					</legend>
					<p class="muted"></p>
					<p class="muted">订购时间：${order.time }</p>
					<p class="muted">订单价：${order.price }&nbsp;&nbsp;数量：${order.count }&nbsp;&nbsp;金额：${totalprice }</p>
<%-- 					<c:if test="${brokerage!=null }"> --%>
<%-- 						<p class="muted">平台佣金：${brokerage.bplatform } --%>
<%-- 						<c:if test="${brokerage.bpartner!=null }"> --%>
<%-- 							&nbsp;&nbsp;合伙人佣金：${brokerage.bpartner } --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${brokerage.bsalesman!=null }"> --%>
<%-- 							&nbsp;&nbsp;业务员佣金：${brokerage.bsalesman } --%>
<%-- 						</c:if> --%>
<!-- 						</p> -->
<%-- 					</c:if> --%>
				</div>
			</div>
		</div>
	</div>
</section>

<script>

	$(document).ready(function() {
		 var size = 20;
			var sumcount = parseInt(${sumcount}); 
			if(sumcount == 0){
				return false;
			}
			
		    var numPages = Math.ceil(sumcount/size);
		    var currentPage = getUrlParam("page");
		    currentPage = currentPage ? parseInt(currentPage) + 1 : 1;
		    var options = {
		            currentPage: currentPage,
		            totalPages: numPages,
		            size:'small',
		            alignment:'center',
		            itemTexts: function (type, page, current) {
		                switch (type) {
		                case "first":
		                    return "首页";
		                case "prev":
		                    return "前一页";
		                case "next":
		                    return "后一页";
		                case "last":
		                    return "末页";
		                case "page":
		                    return ""+page;
		                }
		            },
		            
		            onPageClicked: function (event, originalEvent, type, page) { 
		            	var page = page-1; 
		        		window.location.href = '<c:url value="index" />?page=' + page + "&size=" + size;
		            }
		    };
		    var $pager = $('<div class="page"></div>');  
		    $pager.insertAfter($('table'));
		    $pager.bootstrapPaginator(options);
	});

	function confirmSend(id) {
		bootbox.confirm("确定货物发出了吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}

			$.post('<c:url value="confirmsend" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
	
	function confirmArrival(id) {
		bootbox.confirm("确定货物送达了吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}

			$.post('<c:url value="confirmarrival" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}

</script>


<jsp:include page="../includes/footer.jsp" />