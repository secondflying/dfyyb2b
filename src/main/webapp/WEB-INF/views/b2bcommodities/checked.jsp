<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="已上架商品" scope="request" />
<jsp:include page="../includes/mheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infUrl" value="informal" />
			<li><a href="${infUrl}">待审核商品</a></li>
			<c:url var="cheUrl" value="checked" />
			<li class="active"><a href="${cheUrl}">已上架商品</a></li>
		</ul>
	</div>
</div>

<section class="well">
	<fieldset>
		<legend>
			商品列表
			<div class="input-append pull-right">
				<input id="searchtxt" cssClass="input-xlarge" style="line-height: 24px;" placeholder="产品名称" />
				<button id="locationBtn" class="btn btn-info" type="button" onclick="search()">查找</button>
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
			<thead class="info">
				<tr>
					<th align="center">名称</th>
					<th align="center">类别</th>
					<th align="center">厂家</th>
					<th align="center">供应商</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty commodities}">
					<tr>
						<td colspan="5">空</td>
					</tr>

				</c:if>
				<c:forEach items="${commodities}" var="commodity">
					<tr class="${cssClass}">
						<td style="width:120px;"><c:out value="${commodity.name}" /></td>
						<td style="width:80px;"><c:out value="${commodity.type.name}" /></td>
						<td style="width:120px;"><c:out value="${commodity.factory}" /></td>
						<td style="width:120px;"><c:out value="${commodity.provider.alias}" /></td>
						<td style="width:80px;">
							<c:url var="cUrl" value="info?id=${commodity.id}" />
							<a id="info" class="btn btn-small btn-info" href="${cUrl}">
								管理
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<script>

$(document).ready(function() {
	$("#searchtxt").val(getUrlParam("keyword"));
    var size = 20;
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
            	var text = $("#searchtxt").val();
        		window.location.href = '<c:url value="checked" />?keyword='+encodeURIComponent(text)+'&page=' + page + "&size=" + size;
            }
    };
    
    var $pager = $('<div class="page"></div>'); 
    $pager.insertAfter($('table'));
    $pager.bootstrapPaginator(options);
});

function search(){
	var text = $("#searchtxt").val();
	window.location.href = '<c:url value="checked" />?keyword='+encodeURIComponent(text);
}

</script>


<jsp:include page="../includes/footer.jsp" />