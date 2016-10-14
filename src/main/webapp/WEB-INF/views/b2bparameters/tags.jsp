<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="商品标签管理" scope="request" />
<jsp:include page="../includes/mheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="commoditytypeUrl" value="commoditytype" />
			<li class=""><a href="${commoditytypeUrl}">商品分类</a></li>
			<c:url var="tagUrl2" value="tags" />
			<li class="active"><a href="${tagUrl2}">商品标签</a></li>
			<c:url var="unitUrl2" value="units" />
			<li class=""><a href="${unitUrl2}">商品单位</a></li>
		</ul>
	</div>
</div>

<section class="well">
	<fieldset>
		<legend>
			商品标签
			<c:url var="newUrl" value="newtag" />
			<a class="btn btn-success pull-right" href="${newUrl }"> 新增 </a>
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
			<thead class="info">
				<tr>
					<th align="center">缩略图</th>
					<th align="center">名称</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty tags}">
					<tr>
						<td colspan="3">空</td>
					</tr>
				</c:if>
				<c:forEach items="${tags}" var="tag">
					<tr>
						<td style="width: 200px;"><img style="width: 120px; height: 90px;" src="${imageUrl}/${tag.image}"
							id="diseaseImage" /></td>
						<td style="width: 200px;"><b><c:out value="${tag.name}" /></b></td>
						<td style=""><c:url var="eUrl" value="edittag?id=${tag.id}" /> <a
								id="editone" class="btn btn-small btn-warning" href="${eUrl}">编辑 </a> 
							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${tag.id})">删除</button>
						</td>
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
	if(sumcount ==0){return false}
	
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
        		window.location.href = '<c:url value="tags" />?page=' + page + "&size=" + size;
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

		$.post('<c:url value="deletetag" />', {
			id : id
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		});
	});
}
</script>


<jsp:include page="../includes/footer.jsp" />