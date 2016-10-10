<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="农业专业知识管理" scope="request" />
<jsp:include page="../includes/header.jsp" />


<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="index" />
			<li class="active"><a href="${infoUrl}">田间地头</a></li>
			<c:url var="infoUrl2" value="cate" />
			<li class=""><a href="${infoUrl2}">知识分类</a></li>
		</ul>
	</div>
</div>

<section class="well shadow">
	<fieldset>
		<legend>
			农业知识列表
			<c:url var="editUrl" value="edit" />
			<a id="addone" class="btn btn-info pull-right" href="${editUrl}">
				<i class="icon-plus icon-white"></i> 新增
			</a>
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
					<th align="center">缩略图</th>
					<th align="center">标题</th>
					<th align="center">类别</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty agrotechnicals}">
					<tr>
						<td colspan="5">空</td>
					</tr>

				</c:if>
				<c:forEach items="${agrotechnicals}" var="agrotechnical">
					<tr class="${cssClass}">
						<td style="width: 120px;"><img style="width: 120px; height: 90px;"
							src="${imageUrl}/${agrotechnical.thumbnail}" id="diseaseImage" /></td>
						<td ><c:out value="${agrotechnical.title}" /></td>
						<td style="width: 100px;"><c:out value="${empty agrotechnical.category  ? '': agrotechnical.category.name }" /></td>
						<td style="width: 180px;">
						<c:url var="eUrl" value="edit?id=${agrotechnical.id}&page=${page}&size=${size}" /> 
						<a id="editone" class="btn btn-small btn-warning" href="${eUrl}"> 编辑 </a>
						<c:url var="eUrl" value="detail?id=${agrotechnical.id}&page=${page}&size=${size}" /> 
						<a class="btn btn-small" href="${eUrl}"> 评论管理 </a>
						<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${agrotechnical.id})">删除</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

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
        		window.location.href = '<c:url value="index" />?page=' + page + "&size=" + size;
            }
    };
    var $pager = $('<div class="page"></div>');  
    $pager.insertAfter($('table'));
    $pager.bootstrapPaginator(options);
});

	function deleteOne(id) {
		bootbox.confirm("确定要删除吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
	
			$.post('<c:url value="delete" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
</script>


<jsp:include page="../includes/footer.jsp" />