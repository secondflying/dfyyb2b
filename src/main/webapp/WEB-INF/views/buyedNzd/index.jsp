<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="订货农资店" scope="request" />
<jsp:include page="../includes/proheader.jsp" />

<section class="well">
	<fieldset>
		<legend>
		订货农资店 
		<div class="input-append pull-right">
				<select id="allNzd">
				<option value="0">所有农资店</option>
				<option value="1">保护期即将到期农资店</option>
				</select>
			</div>
		</legend>
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
					<th style="width: 120px;" align="center">订购农资店</th>
					<th style="width: 120px;" align="center">商品名称</th>
					<th style="width: 120px;" align="center">供应商</th>
					<th style="width: 120px;" align="center">下单时间</th>
					<th style="width: 80px;" align="center">订购数量</th>
					<th style="width: 120px;" align="center">保护期截止</th>
					<th style="width: 180px;" align="center">保护期半径</th>
					<th style="width: 140px;" align="center">是否申请延长保护期</th>
					<th style="width: 120px;" align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty orders}">
					<tr>
						<td colspan="9">空</td>
					</tr>
				</c:if>
				<c:forEach items="${orders}" var="ord">
					<tr>
						<td><c:out value="${ord.nzd.alias}" /></td>
						<td><c:out value="${ord.commodity.name}" /></td>
						<td><c:out value="${ord.commodity.provider.alias}" /></td>
						<td><fmt:formatDate value='${ord.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td><c:out value="${ord.count}" /></td>
						<td><fmt:formatDate value='${ord.endtime}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td><c:out value="${ord.radius}" /></td>
						<td>
						<c:out value='${ord.extendStatus == null ? "否" : "是"}' />
						<br />
						<c:if test="${ord.extendStatus != null}">
							申请延长<c:out value='${ord.extendDays}' />天
						</c:if>
						</td>
						<td>
						<c:if test="${ord.extendStatus != null}">
								<button class="btn btn-small btn-danger" type="button" onclick="extendProtectionConfirm(${ord.id})">同意延长保护期</button>
								<button class="btn btn-small btn-danger" type="button" onclick="extendProtectionBack(${ord.id})">不同意延长保护期</button>
						</c:if>
								<button class="btn btn-small btn-success" type="button" onclick="confirmSend(${ord.id})">设置保护期</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>


<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">设置保护期</h4>
	</div>
	<div class="modal-body">
	<input type="text" id="txtExtendDays" placeholder="延长保护期天数" />
	<input type="text" id="txtExtendRadius" placeholder="保护期半径" />
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" id="btnSend">确认</button>
	</div>
</div>

<script>

	$(document).ready(function() {
		$("#allNzd").val(getUrlParam("isnear"));
		$("#allNzd").change(function(){
    		window.location.href = '<c:url value="index" />?isnear=' + $(this).val();
		});	
		
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

	function extendProtectionConfirm(id) {
		bootbox.confirm("确定吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
			$.post('<c:url value="extendProtectionConfirm" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
	
	function extendProtectionBack(id) {
		bootbox.confirm("确定吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}

			$.post('<c:url value="extendProtectionBack" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
	
	
	function setProtection(oid){
		$('#btnSend').unbind('click');
		$("#btnSend").click(function(){
			$.post('<c:url value="setProtection" />', {
				phone:phone,
				days : $("#txtExtendDays").val(),
				radius : $("#txtExtendRadius").val()
			}).done(function(data) {
				$('#myModal').modal('hide');
				$("#successMessage").show().delay(2000).slideUp("slow");
			}).fail(function() {
			}); 	
		});
		$('#myModal').modal({});
	}
	
</script>


<jsp:include page="../includes/footer.jsp" />