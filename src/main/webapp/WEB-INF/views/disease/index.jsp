<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="病虫害管理" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			病虫害列表
			<c:url var="editUrl" value="edit" />
			<a id="addone" style="margin: 0 0 0 10px;" class="btn btn-info pull-right" href="${editUrl}">
				<i class="icon-plus icon-white"></i> 新增
			</a>   
			
			<div class="input-append pull-right">
				<input id="searchtxt" cssClass="input-xlarge" style="line-height: 24px;" />
				<button id="locationBtn" class="btn btn-info" type="button" onclick="search()">查找</button>
			</div>
			
		</legend>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead class="info">
				<tr>
					<th align="center">缩略图</th>
					<th align="center">名称</th>
					<th align="center">描述</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty diseases}">
					<tr>
						<td colspan="5">空</td>
					</tr>

				</c:if>
				<c:forEach items="${diseases}" var="disease">
					<tr class="${cssClass}">
						<td style="width: 120px;"><img style="width: 120px; height: 90px;" src="${imageUrl}/${disease.thumbnail}"
							id="diseaseImage" /></td>
						<td style="width: 120px;"><c:out value="${disease.name}" /></td>
						<td style="height: 50px; text-align: left;">
							<div class="textdiv">
								<c:out value="${disease.description}" />
							</div>
						</td>
						<td style="width: 120px;"><c:url var="eUrl"
								value="edit?id=${disease.id}&page=${page}&size=${size}" /> <a id="editone"
								class="btn btn-small btn-warning" href="${eUrl}"> 编辑 </a>
							<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${disease.id})">删除</button></td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

<script>

	$(document).ready(function() {
		
		$("#searchtxt").val(getUrlParam("context"));

		
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

		        		window.location.href = '<c:url value="index" />?context='+ encodeURIComponent(text) + '&page=' + page + "&size=" + size;
		            }
		    };
		    
		    var $pager = $('<div class="page"></div>'); 
		    $pager.insertAfter($('table'));
		    $pager.bootstrapPaginator(options);				
	});
	
	
	function search(){
		var text = $("#searchtxt").val();
		window.location.href = '<c:url value="index" />?context='+encodeURIComponent(text);
	}

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