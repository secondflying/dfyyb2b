<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="订单返利" scope="request" />
<jsp:include page="../includes/proheader.jsp" />

<section class="well">
	<fieldset>
		<legend> 订单返利 </legend>
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
					<th style="width: 120px;" align="center">商品名称</th>
					<th style="width: 120px;" align="center">订购农资店</th>
					<th style="width: 120px;" align="center">订购总数</th>
					<th style="width: 120px;" align="center">返利比例</th>
					<th style="width: 120px;" align="center">返利金额</th>
					<th style="width: 120px;" align="center">起始时间</th>
					<th style="width: 120px;" align="center">截止时间</th>
					<th style="width: 120px;" align="center">结算状态</th>
					<th style="width: 120px;" align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty rebates}">
					<tr>
						<td colspan="9">空</td>
					</tr>

				</c:if>
				<c:forEach items="${rebates}" var="rebate">
					<tr>
						<td><c:out value="${rebate.commodity.name}" /></td>
						<td><c:out value="${rebate.nzd.alias}" /></td>
						<td><c:out value="${rebate.count}" /></td>
						<td><c:out value="${rebate.rate}" /></td>
						<td><c:out value="${rebate.amount}" /></td>
						<td><fmt:formatDate value='${rebate.starttime}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td><fmt:formatDate value='${rebate.endtime}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td><c:choose>
								<c:when test="${rebate.rstatus == 0}">
								未结	
								</c:when>
								<c:when test="${rebate.rstatus==1}">
								已结
								</c:when>
							</c:choose></td>
						<td>							
							<c:if test="${rebate.rstatus==0  }">
								<button class="btn btn-small btn-danger" type="button" onclick="finalrebate(${rebate.id})">结算</button>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
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
	
	function finalrebate(id) {
		bootbox.confirm("确定结算吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}

			$.post('<c:url value="finalrebate" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
	
	function checkBack(id) {
		bootbox.confirm("请您在查看过订单详情及与客户沟通后给出意见。", "拒绝退货", "同意退货", function(isOk) {
			if (!isOk) {
				$.post('<c:url value="backstop" />', {
					id : id
				}).done(function(data) {
					window.location.href = window.location.href;
				}).fail(function() {
				});
			}
			else{
				
				$.post('<c:url value="backpass" />', {
					id : id
				}).done(function(data) {
					window.location.href = window.location.href;
				}).fail(function() {
				});
				
			}
		});
	}
</script>


<jsp:include page="../includes/footer.jsp" />