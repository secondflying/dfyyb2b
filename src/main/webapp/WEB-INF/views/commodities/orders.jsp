<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="积分订单" scope="request" />
<jsp:include page="../includes/header.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="index" />
			<li class=""><a href="${infoUrl}">积分商品</a></li>
			<c:url var="infoUrl2" value="orders" />
			<li class="active"><a href="${infoUrl2}">积分订单</a></li>
		</ul>
	</div>
</div>

<section class="well shadow">
	<fieldset>
		<legend> 积分订单 </legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<c:if test="${success != null}">
			<div class="alert alert-success" id="successMessage">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				<strong><c:out value="${success}" /></strong>
			</div>
			<script>
				$("#successMessage").delay(2000).slideUp("slow");
			</script>
		</c:if>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">商品</th>
					<th align="center">购买人</th>
					<th align="center">下单时间</th>
					<th align="center">收货地址</th>
					<th style="width: 100px;" align="center">发货农资店</th>
					<th style="width: 80px;" align="center">状态</th>
					<th style="width: 80px;" align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty pointOrders}">
					<tr>
						<td colspan="7">空</td>
					</tr>

				</c:if>
				<c:forEach items="${pointOrders}" var="pointOrder">
					<tr class="${cssClass}">
						<td>
							<div>
								<label><c:out value="${pointOrder.commodity.name}" /></label><br>
								<c:choose>
									<c:when test="${pointOrder.commodity.exchange == 0}">
										<label style="font-size: 10px; display: inline-block;"> <c:out
												value="积分：${pointOrder.commodity.point}" />
										</label>
									</c:when>
									<c:otherwise>
										<label style="font-size: 10px; display: inline-block;"> <c:out
												value="推荐币：${pointOrder.commodity.tjcoin}" />
										</label>
									</c:otherwise>
								</c:choose>
							</div>
						</td>
						<td>
							<div>
								<label><c:out value="${pointOrder.user.alias}" /></label><br> <label
									style="font-size: 10px; display: inline-block;"> <c:out value="${pointOrder.user.phone}" />
								</label>
							</div>
						</td>

						<td><fmt:formatDate value='${pointOrder.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td><c:out value="${empty pointOrder.contact ?  '' : pointOrder.contact.address } " /></td>
						<td><c:choose>
								<c:when test="${pointOrder.status==0}">
									<button class="btn btn-small" type="button" onclick="chooseNZD(${pointOrder.id})">选择</button>
								</c:when>
								<c:otherwise>
									<c:out value="${empty pointOrder.nzd ? '': pointOrder.nzd.alias }" />
								</c:otherwise>
							</c:choose></td>
						<td><c:choose>
								<c:when test="${pointOrder.status==0}">
									<span class="label label-default" style="width: 80px; text-align: center; background-color: #d9534f">配货中</span>
								</c:when>
								<c:when test="${pointOrder.status==3}">
									<span class="label label-default" style="width: 80px; text-align: center; background-color: #5cb85c">已到达农资店</span>
								</c:when>
								<c:when test="${pointOrder.status==2}">
									<span class="label label-default" style="width: 80px; text-align: center; background-color: #5cb85c">交易完成</span>
								</c:when>
							</c:choose></td>
						<td><c:choose>
								<c:when test="${pointOrder.status==0 || pointOrder.status==3}">
									<button class="btn btn-small btn-danger" type="button" onclick="confirmOrder(${pointOrder.id})">完成订单</button>
								</c:when>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">选择发货农资店</h4>
	</div>
	<div class="modal-body">
		<input type="text" id="txtNzdSearch" placeholder="输入农资店名或手机号" />
		<input type="button" style="margin-bottom: 8px" id="btnSearchNzd" value="查找" />
		<select id="allNzd" size="20" style="width: 270px; height: 300px;"></select>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" id="btnConfirm">确定</button>
	</div>
</div>

<script>

$(document).ready(function() {
    var size = 10;
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
        		window.location.href = '<c:url value="orders" />?page=' + page + "&size=" + size;
            }
    };
    var $pager = $('<div class="page"></div>');  
    $pager.insertAfter($('table'));
    $pager.bootstrapPaginator(options);
    
    
    $('#btnSearchNzd').unbind('click');
	$("#btnSearchNzd").click(function(){
		searchNzd();
	});
});

function searchNzd(){
	var keyword = $("#txtNzdSearch").val();
	var url = '<c:url value="searchNzd.json" />';
	url = url + "?keyword=" + encodeURIComponent(keyword);
	$.get(url, function(result) {
		$('#allNzd').empty();
		$.each(result, function (n, value) {
			$('#allNzd').append('<option value="' + value.id + '">' + value.alias + '(' + value.phone + ')</option>')
		});
	});	
}


function chooseNZD(id){
	searchNzd();
	
	$('#btnConfirm').unbind('click');
	$("#btnConfirm").click(function(){
		
		
		var nzd =$('#allNzd').val() ;
		if(!nzd){
			bootbox.alert("请选择发货农资店");
			return false;
		}
		$.post('<c:url value="setnzd" />', {
			id:id,
			nzd:nzd
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		}); 	
	});
	
	$('#myModal').modal({});
} 


function confirmOrder(id) {
	bootbox.confirm("确定订单吗？", "取消", "确定", function(isOk) {
		if (!isOk) {
			return;
		}

		$.post('<c:url value="confirm" />', {
			id : id
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		});
	});
}
</script>


<jsp:include page="../includes/footer.jsp" />