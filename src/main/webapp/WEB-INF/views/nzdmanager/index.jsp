<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="农资店管理" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			农资店列表
			<div class="input-append pull-right">
				<input id="searchtxt" cssClass="input-xlarge" style="line-height: 24px;" placeholder="输入农资店名称或电话" />
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
					<th align="center">缩略图</th>
					<th align="center">名称</th>
					<th align="center">电话</th>
					<th align="center">地址</th>
					<th align="center">是否合作农资店</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty users}">
					<tr>
						<td colspan="6">空</td>
					</tr>

				</c:if>
				<c:forEach items="${users}" var="user">
					<tr class="${cssClass}">
						<td style="width:120px;"><img style="width:120px; height:90px;" src="${imageUrl}/${user.thumbnail}" id="diseaseImage" /></td>
						<td style="width:120px;"><c:out value="${user.alias}" /></td>
						<td style="width:120px;"><c:out value="${user.phone}" /></td>
						<td style="width:120px;"><c:out value="${user.address}" /></td>
						<td style="width:120px;"><c:out value='${user.teamwork ? "是" : "否"}' /></td>
						<td  style="width:80px;">
							<c:url var="eUrl" value="edit?id=${user.id}" />
							<a id="editone" class="btn btn-small btn-warning" href="${eUrl}">
								编辑
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
            	var text = $("#searchtxt").val();
        		window.location.href = '<c:url value="index" />?keyword='+ encodeURIComponent(text) + "&page=" + page + "&size=" + size;
            }
    };
    
    var $pager = $('<div class="page"></div>'); 
    $pager.insertAfter($('table'));
    $pager.bootstrapPaginator(options);
});

function search(){
	var text = $("#searchtxt").val();
	window.location.href = '<c:url value="index" />?keyword='+encodeURIComponent(text);
}
</script>


<jsp:include page="../includes/footer.jsp" />