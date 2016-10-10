<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="我回答的问题" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
		我回答的问题
			<c:url var="backUrl" value="index" />
			<label class="pull-right" style="width: 10px;"> </label>
			<a class="btn btn-info pull-right" href="${backUrl}"> 返回 </a>
		</legend>
	</fieldset>
</section>

<section id="recommendsta" class="well shadow">
	<fieldset>
		<table id="remList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">内容</th>
					<th align="center">提问时间</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty questions}">
					<tr>
						<td colspan="2">空</td>
					</tr>
				</c:if>
				<c:forEach items="${questions}" var="q">
					<tr class="${cssClass}">
					
						<c:url var="eUrl" value="/manager/question/detail?id=${q.id}" />
						<td><a href="${eUrl}"><c:out value="${q.content}" /></a></td>
						<td><fmt:formatDate value='${q.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>
<script>

	$(document).ready(function() {
		var $pager = $('<div class="page"></div>');  //分页div
	    $pager.insertAfter($('table'));
	    
		var size = 20;
		var sumcount = parseInt(${sumcount}); 
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
	        		window.location.href = '<c:url value="myAnsweredQuestion" />?page=' + page + "&size=" + size + "&uid=" + getUrlParam("uid");
	            }
	    };
	    $pager.bootstrapPaginator(options);
	});

	
</script>


<jsp:include page="../includes/footer.jsp" />