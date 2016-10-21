<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.docquyuUl {
	font-size: 14px;
	padding-left:10px;
}

.chooseType {
	cursor: pointer;
}

.list-inline {
  padding-left: 0;
  list-style: none;
}

.list-inline > li {
  display: inline-block;
  padding-right: 5px;
  padding-left: 5px;
}

.list-inline > li:first-child {
  padding-left: 0;
}
</style>
<ul class="docquyuUl">
<c:forEach var="crop" items="${crops}">
	<li>
		<h5 class="" id="${crop.id}" sname="${crop.name}" level="1">
			<span style="color: #0E6390;font-weight: bold;">${crop.name}</span>
		</h5>
		<ul class="list-inline">
			<c:forEach var="crop1" items="${crop.childCrops}">
				<li style="line-height: 15px;">
					<h6 class="chooseType" style="line-height: 15px;"
						id="${crop1.id}" sname="${crop1.name}" level="2">
						<span style="color: #5CB85C;">
							${crop1.name}</span>
					</h6>
				</li>
			</c:forEach>
		</ul>
	</li>
</c:forEach>
</ul>
<script type="text/javascript">
	$(function() {
		$('.chooseType')
				.bind(
						'click',
						function() {
							try {
								clickCommodityType($(this).attr('id'), $.trim($(this).attr('sname')),$(this).attr('level'));
							} catch (e) {
								alert('请覆盖方法 clickCommodityType(id, text) -('
										+ $(this).attr('id') + ':'
										+ $.trim($(this).text()) + ')');
							}

						});
	});
</script>