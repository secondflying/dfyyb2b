<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:url var="jsurl1" value="/assets/jquery/js/jquery-1.8.3.js" />
<c:url var="jsurl2" value="/assets/jquery/js/jquery.validate.js" />
<c:url var="jsurl3" value="/assets/bootstrap/js/bootstrap.min.js" />
<c:url var="jsurl4" value="/assets/jquery/js/bootbox.js" />
<c:url var="jsurl5" value="/assets/jquery/js/jquery.dataTables.js" />
<c:url var="jsurl6" value="/assets/jquery/js/jquery.form.js" />
<c:url var="jsurl7" value="/assets/bootstrap/js/bootstrap-tooltip.js" />
<c:url var="jsurl8" value="/assets/bootstrap/js/bootstrap-popover.js" />
<c:url var="jsurl9" value="/assets/bootstrap/js/bootstrap-transition.js" />
<c:url var="jsurl10" value="/assets/sly/sly.js" />
<c:url var="jsurl11" value="/assets/sly/plugins.js" />
<c:url var="jsurl12" value="/assets/bootstrap/js/bootstrap-paginator.js" />
<c:url var="jsurl13" value="/assets/bootstrap/js/bootstrap-carousel.js" />
<c:url var="jsurl14" value="/assets/jquery/js/jquery.cookie.js" />



<script src="${jsurl1}"></script>
<script src="${jsurl2}"></script>
<script src="${jsurl3}"></script>
<script src="${jsurl4}"></script>
<script src="${jsurl5}"></script>
<script src="${jsurl6}"></script>
<script src="${jsurl7}"></script>
<script src="${jsurl8}"></script>
<script src="${jsurl9}"></script>
<script src="${jsurl10}"></script>
<script src="${jsurl11}"></script>
<script src="${jsurl12}"></script>
<script src="${jsurl13}"></script>
<script src="${jsurl14}"></script>


<script>
	function page() {
		var currentPage;
		var $table = $('table');
		var hidden = $('#read').val();
		//分页效果
		if (hidden != null) {
			if ($.cookie("current") != null) {
				var p = $.cookie("current");

				currentPage = parseInt(p);
			} else {
				currentPage = 0;
				$.cookie("current", currentPage);
			}
		} else {
			currentPage = 0;
			$.cookie("current", currentPage);
		}

		var pageSize = 10; //每页行数（不包括表头）
		//绑定分页事件
		$table.bind('repaginate', function() {
			$table.find('tbody tr').hide().slice(currentPage * pageSize, (currentPage + 1) * pageSize).show();
		});

		var numRows = $table.find('tbody tr').length; //记录宗条数
		if (numRows <= 10) {
			return;
		}
		var numPages = Math.ceil(numRows / pageSize); //总页数

		var $pager = $('<div class="page"></div>'); //分页div

		$pager.insertAfter($table);

		var options = {
			currentPage : currentPage + 1,
			totalPages : numPages,
			size : 'small',
			alignment : 'center',
			itemTexts : function(type, page, current) {
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
					return "" + page;
				}
			},
			onPageChanged : function(e, oldPage, newPage) {
				currentPage = newPage - 1;
				$.cookie("current", currentPage);
				$table.trigger("repaginate");
			}
		};

		$pager.bootstrapPaginator(options);

		$table.trigger("repaginate"); //初始化 
	}

	function setplaceholderSupport() {
		if (!placeholderSupport()) { // 判断浏览器是否支持 placeholder
			$('[placeholder]').focus(function() {
				var input = $(this);
				if (input.val() == input.attr('placeholder')) {
					input.val('');
					input.removeClass('placeholder');
				}
			}).blur(function() {
				var input = $(this);
				if (input.val() == '' || input.val() == input.attr('placeholder')) {
					input.addClass('placeholder');
					input.val(input.attr('placeholder'));
				}
			}).blur();
		}
	}
	function placeholderSupport() {
		return 'placeholder' in document.createElement('input');
	}

	//获取url中的参数
	function getUrlParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg); //匹配目标参数
		if (r != null)
			return decodeURIComponent(r[2]);
		return null; //返回参数值
	}
	
	function clearNoNum(obj) {
		//先把非数字的都替换掉，除了数字和.
		obj.value = obj.value.replace(/[^\d.]/g, "");
		//必须保证第一个为数字而不是.
		obj.value = obj.value.replace(/^\./g, "");
		//保证只有出现一个.而没有多个.
		obj.value = obj.value.replace(/\.{2,}/g, ".");
		//保证.只出现一次，而不能出现两次以上
		obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
	}
</script>

