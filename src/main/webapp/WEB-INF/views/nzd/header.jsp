<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title><c:out value="${pageTitle}" /></title>
<link rel="icon" href="/assets/img/favicon.ico" mce_href="/assets/img/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="/assets/img/favicon.ico" mce_href="/assets/img/favicon.ico" type="image/x-icon">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta name="renderer" content="webkit">
<c:url var="cssUrl" value="/assets/bootstrap/css/bootstrap.css" />
<link href="${cssUrl}" rel="stylesheet" />
<c:url var="cssUrl2" value="/assets/jquery/plugin/DataTables/css/jquery.dataTables.css" />
<link href="${cssUrl2}" rel="stylesheet" />
<c:url var="cssUrl3" value="/assets/css/css.css" />
<link href="${cssUrl3}" rel="stylesheet" />
<c:url var="cssUrl4" value="/assets/bootstrap/css/daterangepicker.css" />
<link href="${cssUrl4}" rel="stylesheet" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
          <script src="../../assets/javascript/html5.js"></script>
        <![endif]-->

<jsp:include page="../includes/js.jsp" />
</head>
<body>
	<div id="nav-bar" class="navbar">
		<div class="navbar-inner">
			<div class="container">
				<div class="nav-collapse">
					<ul class="nav">
						<c:set var="cssClass" value=" " />
						<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/nzd/index')}">
							<c:set var="cssClass" value="active" />
						</c:if>
						<c:url var="infoUrl" value="/nzd/index" />
						<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">配方管理</a></li>
						
						<c:set var="cssClass" value=" " />
						<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/nzd/miao')}">
							<c:set var="cssClass" value="active" />
						</c:if>
						<c:url var="infoUrl" value="/nzd/miao" />
						<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">秒杀管理</a></li>
						
						<c:set var="cssClass" value=" " />
						<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/nzd/orders')}">
							<c:set var="cssClass" value="active" />
						</c:if>
						<c:url var="infoUrl" value="/nzd/orders" />
						<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">配方订单</a></li>
						
						<c:set var="cssClass" value=" " />
						<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/nzd/secondorders')}">
							<c:set var="cssClass" value="active" />
						</c:if>
						<c:url var="infoUrl" value="/nzd/secondorders" />
						<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">秒杀订单</a></li>
					</ul>
				</div>
				<div id="nav-account" class="nav-collapse pull-right">
					<ul class="nav">
						<sec:authorize access="authenticated" var="authenticated" />
						<c:choose>
							<c:when test="${authenticated}">
								<li><div>
										你好:
										<sec:authentication property="principal.phone" />
									</div></li>
								<c:url var="logoutUrl" value="/nzd/j_spring_security_logout" />
								<li><a id="navLogoutLink" href="${logoutUrl}">退出系统</a></li>
							</c:when>
							<c:otherwise>
								
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>

	</div>

	<div class="container">
		<c:if test="${message != null}">
			<div class="alert alert-success" id="message">
				<c:out value="${message}" />
			</div>
		</c:if>