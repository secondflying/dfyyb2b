<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="应用下载" scope="request" />
<jsp:include page="../includes/header.jsp" />
<!-- <style type="text/css">
.bg{display:none;position:fixed;width:100%;height:100%;background:#000;z-index:2;top:0;left:0;opacity:0.7;}
.content{display:none;width:500px;height:300px;position:fixed;top:50%;margin-top:-150px;background:#fff;z-index:3;left:50%;margin-left:-250px;}
</style> -->
<section class="well shadow">
	<fieldset>
	<legend>种好地客户端（安卓版）</legend>
		<div class="divnull">&nbsp;&nbsp;</div>
		<div class="row-fluid">
		  <div class="span5">
		  	<div id="myCarousel" class="carousel">
			  <!-- Carousel items -->
			  <div class="carousel-inner">
			    <div class="active item"><img id="android_client" src="../../assets/img/client/welcome.png" alt=""/></div>
			  </div>
			  <!-- 
			  <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
			  <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a> -->
			</div>
		  </div>
		  <div class="span7">
		  	<img class="bitmatriximg" src="${androidCode}" alt=""/>
		  	<br>
		  	<a id="downloadLink" class="btn-down-android" href="${androidUrl}"></a>
		  </div>
		</div>
	</fieldset>
</section>
<!-- <div class="bg"></div> -->

<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-carousel.js"></script>
<!-- <script type="text/javascript">
$(document).ready(function() {
	
	$('.bg').fadeIn(800);					

});


function isWeiXin(){ 
	var ua = window.navigator.userAgent.toLowerCase(); 
	if(ua.match(/MicroMessenger/i) == 'micromessenger'){ 
	return true; 
	}else{ 
	return false; 
	} 
}
</script> -->

<jsp:include page="../includes/footer.jsp" />