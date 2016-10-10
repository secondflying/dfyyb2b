<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:set var="pageTitle" value="用户管理" scope="request" />
<jsp:include page="../includes/header.jsp" />

<section class="well shadow">
	<fieldset>
		<legend>
			用户列表
			<div class="input-append pull-right">
				<input id="searchtxt" cssClass="input-xlarge" style="line-height: 24px;" placeholder="输入用户名称或电话" />
				<button id="locationBtn" class="btn btn-info" type="button" onclick="search()">查找</button>
			</div>
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="alert alert-success" id="successMessage" style="display:none;">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<strong>发送成功</strong>
		</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead class="info">
				<tr>
					<th align="center">电话</th>
					<th align="center">昵称</th>
					<th align="center">类型</th>
					<th align="center">注册时间</th>
					<th align="center">积分</th>
					<th align="center">推荐数</th>
					<th align="center">推荐币</th>
					<th align="center">发送消息</th>
					<th align="center">我回答的问题</th>
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
						<c:url var="eUrl" value="userRecommendDetail?uid=${user.id}" />
						<td style="width: 100px;"><a href="${eUrl}">
								<c:out value="${user.phone}" />
							</a></td>
						<td style="width: 120px;"><c:out value="${user.alias}" /></td>
						<td style="width: 80px;"><c:out value="${user.level.name}" /></td>
						<td style="width: 120px;"><c:out value="${user.time}" /></td>
						<td style="width: 140px;">
							<button class="btn  btn-mini btn-info" onclick="minusPoint('${user.id}')">
								<i class="icon-minus icon-white"></i>
							</button> <c:out value="${user.point}" />
							<button class="btn  btn-mini btn-info" onclick="plusPoint('${user.id}')">
								<i class="icon-plus icon-white"></i>
							</button>
						</td>
						<td style="width: 50px;"><c:out value="${user.recCount}" /></td>
						<td style="width: 120px;">
							<button class="btn  btn-mini btn-info" onclick="minusCoin('${user.id}')">
								<i class="icon-minus icon-white"></i>
							</button> <c:out value="${user.tjcoin}" />
							<button class="btn  btn-mini btn-info" onclick="plusCoin('${user.id}')">
								<i class="icon-plus icon-white"></i>
							</button>
						</td>
						<td style="width: 60px;">
							<button id="addone" class="btn btn-mini btn-info" onclick="sendMessage('${user.phone}')">发送</button>
						</td>
						
						<c:url var="eUrl2" value="myAnsweredQuestion?uid=${user.id}" />
						<td style="width: 80px;"><a href="${eUrl2}"> 查看</a></td>
							
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</section>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">增加积分</h4>
	</div>
	<div class="modal-body">
		<input type="text" id="txtPoints" style="width: 90%;" />
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" id="btnConfirm">确定</button>
	</div>
</div>

<div id="messageModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">发送消息</h4>
	</div>
	<div class="modal-body">
		<textarea id="contendTxt" style="width: 90%; height: 80px;"></textarea>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" id="btnSendMessage">发送</button>
	</div>
</div>
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

function minusPoint(uid){
	$("#myModalLabel").html('扣积分');
	$('#btnConfirm').unbind('click');
	$("#btnConfirm").click(function(){
		$.post('<c:url value="alterPoints" />', {
			uid:uid,
			isadd:false,
			point : $("#txtPoints").val()
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		}); 	
	});
	
	$('#myModal').modal({});
} 

function plusPoint(uid){
	$("#myModalLabel").html('加积分');
	$('#btnConfirm').unbind('click');
	$("#btnConfirm").click(function(){
		$.post('<c:url value="alterPoints" />', {
			uid:uid,
			isadd: true,
			point : $("#txtPoints").val()
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		}); 	
	});
	$('#myModal').modal({});
} 


function minusCoin(uid){
	$("#myModalLabel").html('扣推荐币');
	$('#btnConfirm').unbind('click');
	$("#btnConfirm").click(function(){
		$.post('<c:url value="alterCoins" />', {
			uid:uid,
			isadd:false,
			coin : $("#txtPoints").val()
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		}); 	
	});
	
	$('#myModal').modal({});
} 

function plusCoin(uid){
	$("#myModalLabel").html('加推荐币');
	$('#btnConfirm').unbind('click');
	$("#btnConfirm").click(function(){
		$.post('<c:url value="alterCoins" />', {
			uid:uid,
			isadd: true,
			coin : $("#txtPoints").val()
		}).done(function(data) {
			window.location.href = window.location.href;
		}).fail(function() {
		}); 	
	});
	$('#myModal').modal({});
} 

function sendMessage(phone){
	$('#btnSendMessage').unbind('click');
	$("#btnSendMessage").click(function(){
		$.post('<c:url value="sendmessage" />', {
			phone:phone,
			message : $("#contendTxt").val()
		}).done(function(data) {
			$('#messageModal').modal('hide');
			$("#successMessage").show().delay(2000).slideUp("slow");
		}).fail(function() {
		}); 	
	});
	$('#messageModal').modal({});
}

</script>


<jsp:include page="../includes/footer.jsp" />