<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="积分变更记录" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			积分变更记录
			<div class="input-append pull-right">
				<input id="searchtxt" cssClass="input-xlarge" style="line-height: 24px;" placeholder="输入用户名称或电话" />
				<button id="locationBtn" class="btn btn-info" type="button" onclick="search()">查找</button>
			</div>
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead class="info">
				<tr>
					<th align="center">电话</th>
					<th align="center">昵称</th>
					<th align="center">积分</th>
					<th align="center">时间</th>
					<th align="center">变更记录</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty logs}">
					<tr>
						<td colspan="5">空</td>
					</tr>

				</c:if>
				<c:forEach items="${logs}" var="log">
					<tr class="${cssClass}">
						<td style="width: 120px;"><c:out value="${log.user.phone}" /></td>
						<td style="width: 120px;"><c:out value="${log.user.alias}" /></td>
						<td style="width: 80px;"><c:out value="${log.points}" /></td>
						<td style="width: 160px;"><fmt:formatDate value='${log.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td><c:out value="${log.description}" /></td>
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