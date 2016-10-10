<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="拉拉呱浏览" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			拉拉呱
			<div class="input-append pull-right">
				<input id="searchtxt" cssClass="input-xlarge" style="line-height: 24px;" />
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
			<tbody>
				<c:forEach items="${questions}" var="question">
					<tr class="${cssClass}">
						<td>
							<div class="row">
								<div style="display: inline-block; margin-left: 0px; margin-top: 0px;">
									<img style="width: 50px; height: 50px; vertical-align: bottom;" src="${imageUrl}/${question.writer.thumbnail}" />
								</div>

								<div style="display: inline-block;">
									<div class="textdiv2" onclick="questionClick('${question.id}');">
										<c:out value="${question.content}" />
									</div>
									<div style="text-align: left;">
										<label class="writer"><c:out value="${question.writer.alias}" /></label> <label
											style="font-size: 10px; width: 310px; display: inline-block;">时间：<fmt:formatDate
												value='${question.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss' />&nbsp;&nbsp;&nbsp; <c:out
												value="评论：${question.responsecount}" /></label> 
										<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${question.id})">删除</button>
										<c:choose>
											<c:when test="${question.istop}">
												<button class="btn btn-small btn-danger" type="button" onclick="cancelTop(${question.id})">取消置顶</button>
											</c:when>
											<c:otherwise>
												<button class="btn btn-small " type="button" onclick="addTop(${question.id})">置顶</button>
											</c:otherwise>
										</c:choose>

										<c:choose>
											<c:when test="${question.fine}">
												<button class="btn btn-small btn-danger" type="button" onclick="cancelFine(${question.id})">取消加精</button>
											</c:when>
											<c:otherwise>
												<button class="btn btn-small " type="button" onclick="addFine(${question.id})">加精</button>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</td>
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
	        		window.location.href = '<c:url value="index" />?context='+ encodeURIComponent(text) + "&page=" + page + "&size=" + size;
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
	
	function questionClick(id){
		window.location.href = '<c:url value="detail" />?id='+id;
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
	
	
	function addTop(id) {
		$.post('<c:url value="addTop" />', {
			id : id
		}).done(function(data) {
			if(data.result){
				window.location.href = window.location.href;
			}else{
				bootbox.alert(data.message);
			}
		}).fail(function() {
		}); 
}


function cancelTop(id) {
	$.post('<c:url value="cancelTop" />', {
		id : id
	}).done(function(data) {
		if(data.result){
			window.location.href = window.location.href;
		}else{
			bootbox.alert(data.message);
		}
	}).fail(function() {
	}); 
}


function addFine(id) {
	$.post('<c:url value="addFine" />', {
		id : id
	}).done(function(data) {
		if(data.result){
			window.location.href = window.location.href;
		}else{
			bootbox.alert(data.message);
		}
	}).fail(function() {
	}); 
}


function cancelFine(id) {
$.post('<c:url value="cancelFine" />', {
	id : id
}).done(function(data) {
	if(data.result){
		window.location.href = window.location.href;
	}else{
		bootbox.alert(data.message);
	}
}).fail(function() {
}); 
}
</script>


<jsp:include page="../includes/footer.jsp" />