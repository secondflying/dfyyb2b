<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
<!--
.doctypeUl {
	font-size: 14px;
	padding-left:10px;
}

.choosePartners {
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
-->
</style>
<ul class="doctypeUl">
	<li>
		<h4>
			<span style="color: #0E6390;font-weight: bold;">所有合伙人</span>
		</h4>
		<ul class="list-inline">
		<c:forEach var="user" items="${users}">
			<li>
				<h6 class="choosePartners" id="${user.id}" sname="${user.alias}" style="line-height: 15px;">
					<span style="color: #5CB85C;">
						${user.alias}</span>
				</h6>
			</li>
		</c:forEach>
		</ul>
	</li>
</ul>
<script type="text/javascript">
	$(function() {
		$('.choosePartners')
				.bind(
						'click',
						function() {
							try {
								clickPartnerNote($(this).attr('id'), $.trim($(this).attr('sname')));
							} catch (e) {
								alert('请覆盖方法 clickPartnerNote(id, text) -('
										+ $(this).attr('id') + ':'
										+ $.trim($(this).text()) + ')');
							}

						});
	});
</script>