<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="优惠币交易记录" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			优惠币交易记录
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">支付方</th>
					<th align="center">收币方</th>
					<th align="center">金额</th>
					<th align="center">交易时间</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty accounts}">
					<tr>
						<td colspan="4">空</td>
					</tr>
				</c:if>
				<c:forEach items="${accounts}" var="bl">
					<tr class="${cssClass}">
						<td style="width: 150px;"><c:out value="${bl.pay.alias}" /></td>
						<td style="width: 150px;"><c:out value="${bl.income.alias}" /></td>
						<td style="width: 150px;"><c:out value="${bl.currency}" /></td>
						<td style="width: 150px;"><fmt:formatDate value='${bl.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
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