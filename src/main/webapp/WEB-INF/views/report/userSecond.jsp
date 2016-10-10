<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="统计" scope="request" />
<jsp:include page="../includes/header.jsp" />
<c:url var="btcss" value="/assets/css/bt.css" />
<link href="${btcss}" rel="stylesheet">
<section class="well shadow">
	<fieldset>
		<legend> 统计类型 </legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<ul id="cateList" class="nav nav-pills" style="margin: 0;">
			<li id="report1" class=""><a href="index">用户分类统计</a></li>
			<li id="report2" class=""><a href="userRegister">新用户注册统计</a></li>
			<li id="report2" class=""><a href="userActive">活跃用户统计</a></li>
			<li id="report3" class=""><a href="userRecommend">用户推荐统计</a></li>
			<li id="report3" class=""><a href="userRecTime">每日推荐统计</a></li>
			<li id="report4" class="active"><a href="userSecond">秒杀订单统计</a></li>
			<li id="report5" class=""><a href="topQuestion">作物问题top10</a></li>
			<li id="report6" class=""><a href="userSignin">每日签到</a></li>
<!-- 			<li id="report7" class=""><a href="userResponse">每日回答</a></li> -->
		</ul>
	</fieldset>
</section>


<section id="usersecondsta" class="well shadow">
	<fieldset>
		<table id="ussList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th align="center">秒杀产品</th>
					<th align="center">农资店</th>
					<th align="center">购买者</th>
					<th align="center">购买时间</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty userseconds}">
					<tr>
						<td colspan="4">空</td>
					</tr>

				</c:if>
				<c:forEach items="${userseconds}" var="usersecond">
					<tr class="${cssClass}">
						<td>
							<div>
								<label><c:out value="${usersecond.second.title}" /></label><br> <label
									style="font-size: 10px; display: inline-block;"> <c:out value="原价：${usersecond.second.oprice}" />
									&nbsp;&nbsp;&nbsp;<c:out value="现价：${usersecond.second.nprice}" /> &nbsp;&nbsp;&nbsp;<c:out
										value="差额：${usersecond.second.oprice-usersecond.second.nprice}" />
								</label>
							</div>
						</td>
						<td>
							<div>
								<label><c:out value="${usersecond.second.nzd.alias}" /></label><br> <label
									style="font-size: 10px; display: inline-block;"> <c:out value="${usersecond.second.nzd.phone}" />
								</label>
							</div>
						</td>
						<td>
							<div>
								<label><c:out value="${usersecond.user.alias}" /></label><br> <label
									style="font-size: 10px; display: inline-block;"> <c:out value="${usersecond.user.phone}" />
								</label>
						</td>
						<td><c:out value="${usersecond.time}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>

</section>

<script type="text/javascript" src="../../assets/javascript/Chart.js"></script>
<script>
$(document).ready(function () {
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
        		window.location.href = '<c:url value="userSecond" />?page=' + page + "&size=" + size;
            }
    };
    $pager.bootstrapPaginator(options);
});
	
</script>


<jsp:include page="../includes/footer.jsp" />