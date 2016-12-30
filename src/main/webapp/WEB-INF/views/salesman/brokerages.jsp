<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="佣金" scope="request" />
<jsp:include page="../includes/saleheader.jsp" />

<section class="well">
	<fieldset>
		<legend> 订单佣金 </legend>
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
					<th style="width: 120px;" align="center">订单时间</th>
					<th style="width: 120px;" align="center">佣金</th>
					<th style="width: 120px;" align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty brokerages}">
					<tr>
						<td colspan="3">空</td>
					</tr>

				</c:if>
				<c:forEach items="${brokerages}" var="bke">
					<tr>
						<td><fmt:formatDate value='${bke.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td><c:out value="${bke.bsalesman}" /></td>
						
						<td>
							<c:url var="infoUrl" value="order?id=${bke.oid}" /> 
							<a class="btn btn-small btn-success" href="${infoUrl}">查看订单</a>
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
		        		window.location.href = '<c:url value="brokerages" />?page=' + page + "&size=" + size;
		            }
		    };
		    var $pager = $('<div class="page"></div>');  
		    $pager.insertAfter($('table'));
		    $pager.bootstrapPaginator(options);
	});

</script>


<jsp:include page="../includes/footer.jsp" />