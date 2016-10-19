<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.docquyuUl {
	font-size: 14px;
	padding-left:10px;
}

.chooseQuyuLableType {
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
<c:forEach var="node" items="${zones}">
	<li>
		<h5 class="chooseQuyuLableType" id="${node.id}" sname="${node.name}" level="1">
			<span style="color: #0E6390;font-weight: bold;">${node.name}</span>
		</h5>
		<ul style="padding-left:20px;">
			<c:forEach var="node1" items="${node.nodes}">
				<li>
					<h6 class="chooseQuyuLableType" id="${node1.id}" sname="${node1.name}" level="2">
						<span style="color: #428BCA; font-weight: bold;">
							${node1.name}</span>
					</h6>
					<ul style="padding-left:30px;">
						<c:forEach var="node2" items="${node1.nodes}">
							<li style="line-height: 15px;">
								<h6 class="chooseQuyuLableType" style="line-height: 15px;"
									id="${node2.id}" sname="${node2.name}" level="3">
									<span style="color: #D9534F;">
										${node2.name}</span>
								</h6>
								<ul class="list-inline">
									<c:forEach var="node3" items="${node2.nodes}">
										<li style="line-height: 15px;">
											<h6 class="chooseQuyuLableType" style="line-height: 15px;"
												id="${node3.id}" sname="${node3.name}" level="4">
												<span style="color: #5CB85C;">
													${node3.name}</span>
											</h6>
										</li>
									</c:forEach>
								</ul>
							</li>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
		</ul>
	</li>
</c:forEach>
</ul>
<script type="text/javascript">
	$(function() {
		$('.chooseQuyuLableType')
				.bind(
						'click',
						function() {
							try {
								clickQuyuType($(this).attr('id'), $.trim($(this).attr('sname')),$(this).attr('level'));
							} catch (e) {
								alert('请覆盖方法 clickQuyuType(id, text) -('
										+ $(this).attr('id') + ':'
										+ $.trim($(this).text()) + ')');
							}

						});
	});
</script>