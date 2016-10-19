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

