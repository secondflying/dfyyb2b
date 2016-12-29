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

<jsp:include page="js.jsp" />
</head>
<body>
	<div id="nav-bar" class="navbar">
		<div class="navbar-inner">
			<div class="container">
				<div class="nav-collapse">
					<ul class="nav">
						<c:set var="cssClass" value=" " />
						<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/provider/proinfo/')}">
							<c:set var="cssClass" value="active" />
						</c:if>
						<c:url var="infoUrl" value="/provider/proinfo/info" />
						<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">用户信息</a></li>

						<c:choose>
							<c:when test="${loginuser.status == 1}">
								<c:set var="cssClass" value=" " />
								<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/commodities')}">
									<c:set var="cssClass" value="active" />
								</c:if>
								<c:url var="infoUrl" value="/provider/commodities/index" />
								<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">商品管理</a></li>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${loginuser.status == 1}">
								<c:set var="cssClass" value=" " />
								<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/orders')}">
									<c:set var="cssClass" value="active" />
								</c:if>
								<c:url var="infoUrl" value="/provider/orders/index" />
								<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">订单管理</a></li>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${loginuser.status == 1}">
								<c:set var="cssClass" value=" " />
								<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/buyedNzd')}">
									<c:set var="cssClass" value="active" />
								</c:if>
								<c:url var="infoUrl" value="/provider/buyedNzd/index" />
								<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">已订购农资店</a></li>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${loginuser.status == 1}">
								<c:set var="cssClass" value=" " />
								<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/rebates')}">
									<c:set var="cssClass" value="active" />
								</c:if>
								<c:url var="infoUrl" value="/provider/rebates/index" />
								<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">订单返利</a></li>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${loginuser.type.id == 2}">
								<c:set var="cssClass" value=" " />
								<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/dealers')}">
									<c:set var="cssClass" value="active" />
								</c:if>
								<c:url var="infoUrl" value="/provider/dealers/informal" />
								<li class="${cssClass}"><a id="infoLink" href="${infoUrl}">经销商</a></li>
							</c:when>
						</c:choose>
					</ul>
				</div>
				<div id="nav-account" class="nav-collapse pull-right">
					<ul class="nav">
						<sec:authorize access="authenticated" var="authenticated" />
						<c:choose>
							<c:when test="${authenticated}">
								<li><div>
										你好:
										<sec:authentication property="principal.name" />
									</div></li>
								<c:url var="logoutUrl" value="/provider/j_spring_security_logout" />
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