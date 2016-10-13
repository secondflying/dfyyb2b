<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="vu" uri="http://com.dfyy.util/ViewUtils"%>
<!DOCTYPE html>
<html>
<head>
<title><c:out value="${pageTitle}" /></title>
<link rel="icon" href="/assets/img/favicon.ico" mce_href="/assets/img/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="/assets/img/favicon.ico" mce_href="/assets/img/favicon.ico" type="image/x-icon">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta name="renderer" content="webkit">
<meta property="qc:admins" content="2641272317301356316110063757" />
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
				<c:url var="welcomeUrl" value="/" />
				<a class="brand" href="${welcomeUrl}">管理平台</a>
				<div class="nav-collapse">
					<ul class="nav" style="width: 940px;">
						<c:set var="cssClass" value=" " />
						<c:if test="${fn:contains(requestScope['javax.servlet.forward.servlet_path'], '/manager/users/')}">
							<c:set var="cssClass" value="active" />
						</c:if>
						<c:url var="userUrl" value="/manager/users/formal" />
						<li class="${cssClass}"><a id="userLink" href="${userUrl}">用户管理</a></li>
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
								<c:url var="logoutUrl" value="/manager/j_spring_security_logout" />
								<li><a id="navLogoutLink" href="${logoutUrl}">退出系统</a></li>
							</c:when>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>

	</div>

	<div class="container">