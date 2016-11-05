<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="订单管理" scope="request" />
<jsp:include page="../includes/proheader.jsp" />

<section class="well">
	<fieldset>
		<legend> 订单管理 </legend>
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
					<th style="width: 120px;" align="center">供应商</th>
					<th style="width: 120px;" align="center">订购农资店</th>
					<th style="width: 120px;" align="center">下单时间</th>
					<th style="width: 120px;" align="center">订购数量</th>
					<th style="width: 120px;" align="center">状态</th>
					<th style="width: 120px;" align="center">操作</th>
					<th style="width: 120px;" align="center">收益查看</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty orders}">
					<tr>
						<td colspan="7">空</td>
					</tr>

				</c:if>
				<c:forEach items="${orders}" var="ord">
					<tr>
						<td><c:out value="${ord.commodity.name}" /></td>
						<td><c:out value="${ord.commodity.provider.alias}" /></td>
						<td><c:out value="${ord.nzd.alias}" /></td>
						<td><fmt:formatDate value='${ord.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td><c:out value="${ord.count}" /></td>
						<td><c:choose>
								<c:when test="${ord.status == 0}">
								未发货	
								</c:when>
								<c:when test="${ord.status==1}">
								已发货
								</c:when>
								<c:when test="${ord.status==2}">
								已送达
								</c:when>
								<c:when test="${ord.status==3}">
								已确认收货
								</c:when>
								<c:when test="${ord.status==4}">
								农资店申请退货
								</c:when>
								<c:when test="${ord.status==10}">
								已取消
								</c:when>
								<c:when test="${ord.status==11}">
								已成功退货
								</c:when>
							</c:choose></td>
						<td>
							<c:if test="${loginUser.type.id==1 }">
								<c:choose>
									<c:when test="${ord.status == 0}">
									
								</c:when>
									<c:when test="${ord.status==1}">
							
								</c:when>
									<c:when test="${ord.status==2}">
								
								</c:when>
									<c:when test="${ord.status==3}">
								
								</c:when>
									<c:when test="${ord.status==4}">
									<button class="btn btn-small btn-danger" type="button" onclick="alert(${commodity.id})">审核退货申请</button>
								
								</c:when>
									<c:when test="${ord.status==10}">
								
								</c:when>
									<c:when test="${ord.status==11}">
								
								</c:when>
								</c:choose>
							</c:if>
						<c:if test="${loginUser.type.id==2 ||loginUser.type.id==3  }">
								<c:choose>
									<c:when test="${ord.status == 0}">
									<button class="btn btn-small btn-danger" type="button" onclick="alert(${ord.id})">确定发货</button>
								</c:when>
									<c:when test="${ord.status==1}">
									<button class="btn btn-small btn-danger" type="button" onclick="alert(${ord.id})">确定送达</button>
								</c:when>
									<c:when test="${ord.status==2}">
								
								</c:when>
									<c:when test="${ord.status==3}">
								
								</c:when>
									<c:when test="${ord.status==4}">
								<button class="btn btn-small btn-danger" type="button" onclick="alert(${ord.id})">审核退货申请</button>

								</c:when>
									<c:when test="${ord.status==10}">
								已取消
								</c:when>
									<c:when test="${ord.status==11}">
								已成功退货
								</c:when>
								</c:choose>
							</c:if>	
							</td>
							<td>
							<button class="btn btn-small btn-success" type="button" onclick="alert(${ord.id})">查看</button>
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
</script>


<jsp:include page="../includes/footer.jsp" />