<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="经销商管理" scope="request" />
<jsp:include page="../includes/mheader.jsp" />

<div class="navbar">
	<div class="navbar-inner">
		<ul class="nav">
			<c:url var="infoUrl" value="partners" />
			<li class=""><a href="${infoUrl}">合伙人</a></li>
			<c:url var="dealerUrl" value="dealers" />
			<li class="active"><a href="${dealerUrl}">经销商</a></li>
			<c:url var="manuUrl" value="manufacturers" />
			<li class=""><a href="${manuUrl}">厂家</a></li>
			<c:url var="saleUrl" value="salesmans" />
			<li class=""><a href="${saleUrl}">业务员</a></li>
			<c:url var="storeUrl" value="stores" />
			<li class=""><a href="${storeUrl}">农资店</a></li>
			<c:url var="infoUrl2" value="informal" />
			<li class=""><a href="${infoUrl2}">待审核用户</a></li>
		</ul>
	</div>
</div>

<section class="well">
	<fieldset>
		<legend>
			用户列表
			<div class="input-append pull-right">
				<input id="searchtxt" cssClass="input-xlarge" style="line-height: 24px;" placeholder="输入用户名称或手机号" />
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
					<th align="center">联系人</th>
					<th align="center">地址</th>
					<th align="center">区域</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty users}">
					<tr>
						<td colspan="5">空</td>
					</tr>
	
				</c:if>
				<c:forEach items="${users}" var="user">
					<tr class="${cssClass}">
						<c:url var="infoUrl" value="dealerinfo?id=${user.id}" />
						<td style="width:120px;"><a href="${infoUrl }"><c:out value="${user.alias}" /></a></td>
						<td style="width:80px;"><c:out value="${user.type.name}" /></td>
						<td style="width:120px;"><c:out value="${user.contacts}" /></td>
						<td style="width:160px;"><c:out value="${user.address}" /></td>
						<td style="width:120px;"><c:out value='${user.zone==null ? "" : user.zone.name}' /></td>
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
        		window.location.href = '<c:url value="dealers" />?keyword='+ encodeURIComponent(text) + "&page=" + page + "&size=" + size;
            }
    };
    
    var $pager = $('<div class="page"></div>'); 
    $pager.insertAfter($('table'));
    $pager.bootstrapPaginator(options);
});

function search(){
	var text = $("#searchtxt").val();
	window.location.href = '<c:url value="dealers" />?keyword='+encodeURIComponent(text);
}
</script>


<jsp:include page="../includes/footer.jsp" />