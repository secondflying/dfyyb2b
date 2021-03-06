<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="商品" scope="request" />
<jsp:include page="../includes/proheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="informal" />
			<li class=""><a href="${infoUrl}">待审核商品</a></li>
			<c:url var="infoUrl2" value="subordinates" />
			<li class="active"><a href="${infoUrl2}">经销商</a></li>
		</ul>
	</div>
</div>

<section class="well">
	<fieldset>
		<legend>
			经销商商品
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
					<th style="width: 120px;" align="center">名称</th>
					<th style="width: 120px;" align="center">厂家</th>
					<th style="width: 120px;" align="center">状态</th>
					<th style="width: 120px;" align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty commodities}">
					<tr>
						<td colspan="4">空</td>
					</tr>

				</c:if>
				<c:forEach items="${commodities}" var="commodity">
					<tr>
						<td><c:out value="${commodity.name}" /></td>
						<td><c:out value="${commodity.factory}" /></td>
						<td>
							<c:choose>
								<c:when test="${commodity.status == 0}">
								等待合伙人审核	
								</c:when>
								<c:when test="${commodity.status==1}">
								等待管理员审核
								</c:when>
								<c:when test="${commodity.status==2}">
								合伙人审核不通过
								</c:when>
								<c:when test="${commodity.status==3}">
								已上架
								</c:when>
								<c:when test="${commodity.status==4}">
								管理员审核不通过
								</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${commodity.status == 0 || commodity.status == 2 || commodity.status == 4}">
									<c:url var="eUrl" value="edit?id=${commodity.id}" /> 
									<a id="editone"	class="btn btn-small btn-warning" href="${eUrl}"> 编辑 </a>
									<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${commodity.id})">下架</button>
								</c:when>
							</c:choose>
							<c:if test="${commodity.status==3 }">
								<c:url var="infoUrl" value="/provider/commodities/info?id=${commodity.id}" /> 
								<a id="infoa"	class="btn btn-small btn-info" href="${infoUrl}" target="_Blank"> 查看 </a>
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
	        		window.location.href = '<c:url value="dealercommodities" />?page=' + page + "&size=" + size;
	            }
	    };
	    var $pager = $('<div class="page"></div>');  
	    $pager.insertAfter($('table'));
	    $pager.bootstrapPaginator(options);
});

</script>


<jsp:include page="../includes/footer.jsp" />