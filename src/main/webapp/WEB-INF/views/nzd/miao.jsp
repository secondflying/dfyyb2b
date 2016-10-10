<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="秒杀" scope="request" />
<jsp:include page="header.jsp" />


<section class="well shadow">
	<fieldset>
		<legend>
			秒杀列表
			<c:url var="editUrl" value="/nzd/miaoadd" />
			<a id="addone" class="btn btn-info pull-right" href="${editUrl}">
				<i class="icon-plus icon-white"></i> 新增
			</a>
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">缩略图</th>
					<th align="center">标题</th>
					<th align="center">起止时间</th>
					<th align="center">原价</th>
					<th align="center">现价</th>
					<th align="center">审核状态</th>
					<th align="center">状态</th>
					<th align="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty seconds}">
					<tr>
						<td colspan="8">空</td>
					</tr>

				</c:if>
				<c:forEach items="${seconds}" var="second">
					<tr class="${cssClass}">
						<td style="width:120px;"><img style="width:120px; height:90px;" src="${imageUrl}/${second.image}" id="secondImage" /></td>
						<td style="width:90px;"><c:out value="${second.title}" /></td>
						<td style="height:50px; text-align:left;">
						<c:out value="开始：${second.starttime}" /> 
						<br>
						<c:out value="结束：${second.endtime}" /> 
						</td>
						<td style="width:75px;"><c:out value="￥${second.oprice}" /></td>
						<td style="width:75px;"><c:out value="￥${second.nprice}" /></td>
						<td style="width:75px;">
						<c:choose>  
						    <c:when test="${second.verify == null || second.verify==0}">等待审核</c:when>  
						    <c:when test="${second.verify==1}">审核已通过</c:when>  
						    <c:when test="${second.verify==2}">审核未通过</c:when>  
						</c:choose>
						</td>
						<td style="width:75px;">
						<c:choose>  
						    <c:when test="${second.verify==1 && second.status==0}">未开始</c:when>  
						    <c:when test="${second.verify==1 && second.status==1}">进行中</c:when>  
						    <c:when test="${second.verify==1 && second.status==2}">已结束</c:when>  
						</c:choose>
						</td>
						<td style="width:100px;">
							<c:if test="${second.verify == null || second.verify==0 || second.verify==2}">
								<c:url var="eUrl" value="/nzd/miaoedit?id=${second.id}" />
								<a id="editone" class="btn btn-small btn-warning" href="${eUrl}">
									编辑
								</a>
								<button class="btn btn-small btn-danger" type="button" onclick="deleteOne(${second.id})">删除</button>
			
							</c:if>
							
						</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>


<script>
	$(document).ready(
			function() {
				
				page($("#objList"));
				$('#objList').dataTable({
					"bPaginate" : false,
					"bLengthChange" : false,
					"bFilter" : false,
					"bSort" : true,
					"bInfo" : false,
					"bAutoWidth" : false,
					"aoColumnDefs" : [ {
						'bSortable' : false,
						'aTargets' : [ 3 ]
					} ]
				});
				
	});
	
	function page(ptable){
		var $table = ptable;
	    //分页效果
	    var currentPage = 0;  //当前页
	    var pageSize = 10;  //每页行数（不包括表头）
	    //绑定分页事件
	    $table.bind('repaginate', function()
	    {
	        $table.find('tbody tr').hide()
	            .slice(currentPage * pageSize, (currentPage + 1) * pageSize).show();
	    });

	    var numRows = $table.find('tbody tr').length;  //记录宗条数
	    if(numRows<=10){
	    	return;
	    }
	    var numPages = Math.ceil(numRows/pageSize);    //总页数
	    
	    var $pager = $('<div class="page"></div>');  //分页div
	    
	    $pager.insertAfter($table);
	    
	    var options = {
	            currentPage: 1,
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
	            onPageChanged: function(e,oldPage,newPage){
	            	currentPage = newPage-1;                  
	                $table.trigger("repaginate");
	            }
	    };

	    $pager.bootstrapPaginator(options);
	    
	    $table.trigger("repaginate");  //初始化 
	}
	
	function deleteOne(id) {
		bootbox.confirm("确定要删除吗？", "取消", "确定", function(isOk) {
			if (!isOk) {
				return;
			}
	
			$.post('<c:url value="/nzd/miao/delete" />', {
				id : id
			}).done(function(data) {
				window.location.href = window.location.href;
			}).fail(function() {
			});
		});
	}
</script>


<jsp:include page="../includes/footer.jsp" />