<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="竞争对手" scope="request" />
<jsp:include page="../includes/proheader.jsp" />

<section class="well">
	<fieldset>
		<legend>
			竞争对手
			<div class="input-append pull-right">
				周边距离
				<input id="searchtxt" value="100" cssClass="input-xlarge" style="line-height: 24px;" />
				<button id="locationBtn" class="btn btn-info" type="button" onclick="search()">查找</button>
			</div>
		</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<table id="objList" class="table  table-bordered table-hover table-striped" style="margin: 0;">
			<thead>
				<tr>
					<th style="width: 120px;" align="center">订购农资店</th>
					<th style="width: 120px;" align="center">商品名称</th>
					<th style="width: 120px;" align="center">下单时间</th>
					<th style="width: 80px;" align="center">订购数量</th>
					<th style="width: 120px;" align="center">保护期截止</th>
				</tr>
			</thead>
			<tbody id="tdbody">

			</tbody>
		</table>
	</fieldset>
</section>


<script>

	$(document).ready(function() {
		search();
	});

	function search() {
		var oid = getUrlParam("oid") ;
		var size = $("#searchtxt").val();
		var url = '<c:url value="competitors" />' + '?oid=' + oid + '&size=' +size;
		$.getJSON(url, (function(datas) {
			console.log(datas);
			var h=[];
			$.each(datas, function (n, value) {
				h.push('<tr>');
				h.push('<td>' + value.nzd.alias + '</td>');
				h.push('<td>' + value.commodity.name + '</td>');
				h.push('<td>' + value.time + '</td>');
				h.push('<td>' + value.count + '</td>');
				h.push('<td>' + value.endtime + '</td>');
				h.push('</tr>');

			});
				
			$('#tdbody').html(h.join());
		}));
	}
	
</script>


<jsp:include page="../includes/footer.jsp" />